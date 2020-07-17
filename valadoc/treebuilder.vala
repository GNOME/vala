/* treebuilder.vala
 *
 * Copyright (C) 2011  Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc.Api;

/**
 * Creates an simpler, minimized, more abstract AST for valacs AST.
 */
public class Valadoc.Drivers.TreeBuilder : Vala.CodeVisitor {
	private Vala.ArrayList<PackageMetaData> packages = new Vala.ArrayList<PackageMetaData> ();
	private PackageMetaData source_package;

	private Vala.HashMap<Vala.SourceFile, SourceFile> files = new Vala.HashMap<Vala.SourceFile, SourceFile> ();
	private Vala.HashMap<Vala.Symbol, Symbol> symbol_map = new Vala.HashMap<Vala.Symbol, Symbol> ();

	private ErrorReporter reporter;
	private Settings settings;

	private Api.Node current_node;
	private Api.Tree tree;

	private Valadoc.Api.Class glib_error = null;


	//
	// Accessors
	//

	public Api.Class get_glib_error () {
		return glib_error;
	}

	public Vala.HashMap<Vala.Symbol, Symbol> get_symbol_map () {
		return symbol_map;
	}


	//
	//
	//

	private class PackageMetaData {
		public Package package;
		public Vala.HashMap<Vala.Namespace, Namespace> namespaces = new Vala.HashMap<Vala.Namespace, Namespace> ();
		public Vala.ArrayList<Vala.SourceFile> files = new Vala.ArrayList<Vala.SourceFile> ();

		public PackageMetaData (Package package) {
			this.package = package;
		}

		public Namespace get_namespace (Vala.Namespace vns, SourceFile file) {
			Namespace? ns = namespaces.get (vns);
			if (ns != null) {
				return ns;
			}

			// find documentation comment if existing:
			SourceComment? comment = null;
			if (vns.source_reference != null) {
				foreach (Vala.Comment c in vns.get_comments()) {
					if (c.source_reference.file == file.data ||
						(c.source_reference.file.file_type == Vala.SourceFileType.SOURCE
						 && ((Vala.SourceFile) file.data).file_type == Vala.SourceFileType.SOURCE)
					) {
						Vala.SourceReference pos = c.source_reference;
						if (c is Vala.GirComment) {
							comment = new GirSourceComment (c.content,
															file,
															pos.begin.line,
															pos.begin.column,
															pos.end.line,
															pos.end.column);
						} else {
							comment = new SourceComment (c.content,
														 file,
														 pos.begin.line,
														 pos.begin.column,
														 pos.end.line,
														 pos.end.column);
						}
						break;
					}
				}
			}

			// find parent if existing
			var parent_vns = vns.parent_symbol;

			if (parent_vns == null) {
				ns = new Namespace (package, file, vns.name, comment, vns);
				package.add_child (ns);
			} else {
				Namespace parent_ns = get_namespace ((Vala.Namespace) parent_vns, file);
				ns = new Namespace (parent_ns, file, vns.name, comment, vns);
				parent_ns.add_child (ns);
			}

			namespaces.set (vns, ns);
			return ns;
		}

		public void register_source_file (Vala.SourceFile file) {
			files.add (file);
		}

		public bool is_package_for_file (Vala.SourceFile source_file) {
			if (source_file.file_type == Vala.SourceFileType.SOURCE && !package.is_package) {
				return true;
			}

			return files.contains (source_file);
		}
	}


	//
	// Type constructor translation helpers:
	//

	private Pointer create_pointer (Vala.PointerType vtyperef, Item parent, Api.Node caller) {
		Pointer ptr = new Pointer (parent, vtyperef);

		Vala.DataType vntype = vtyperef.base_type;
		if (vntype is Vala.PointerType) {
			ptr.data_type = create_pointer ((Vala.PointerType) vntype, ptr, caller);
		} else if (vntype is Vala.ArrayType) {
			ptr.data_type = create_array ((Vala.ArrayType) vntype, ptr, caller);
		} else {
			ptr.data_type = create_type_reference (vntype, ptr, caller);
		}

		return ptr;
	}

	private Api.Array create_array (Vala.ArrayType vtyperef, Item parent, Api.Node caller) {
		Api.Array arr = new Api.Array (parent, vtyperef);

		Vala.DataType vntype = vtyperef.element_type;
		if (vntype is Vala.ArrayType) {
			arr.data_type = create_array ((Vala.ArrayType) vntype, arr, caller);
		} else {
			arr.data_type = create_type_reference (vntype, arr, caller);
		}

		return arr;
	}

	private TypeReference create_type_reference (Vala.DataType? vtyperef, Item parent, Api.Node caller) {
		bool is_nullable = vtyperef != null
			&& vtyperef.nullable
			&& !(vtyperef is Vala.GenericType)
			&& !(vtyperef is Vala.PointerType);
		string? signature = (vtyperef != null
			&& vtyperef.data_type != null)? Vala.GVariantModule.get_dbus_signature (vtyperef.data_type) : null;
		bool pass_ownership = type_reference_pass_ownership (vtyperef);
		Ownership ownership = get_type_reference_ownership (vtyperef);
		bool is_dynamic = vtyperef != null && vtyperef.is_dynamic;

		TypeReference type_ref = new TypeReference (parent,
													ownership,
													pass_ownership,
													is_dynamic,
													is_nullable,
													signature,
													vtyperef);

		if (vtyperef is Vala.PointerType) {
			type_ref.data_type = create_pointer ((Vala.PointerType) vtyperef,  type_ref, caller);
		} else if (vtyperef is Vala.ArrayType) {
			type_ref.data_type = create_array ((Vala.ArrayType) vtyperef,  type_ref, caller);
		//} else if (vtyperef is Vala.GenericType) {
		//	type_ref.data_type = new TypeParameter (caller,
		//											caller.get_source_file (),
		//											((Vala.GenericType) vtyperef).type_parameter.name,
		//											vtyperef);
		}

		// type parameters:
		if (vtyperef != null) {
			foreach (Vala.DataType vdtype in vtyperef.get_type_arguments ()) {
				var type_param = create_type_reference (vdtype, type_ref, caller);
				type_ref.add_type_argument (type_param);
			}
		}

		return type_ref;
	}



	//
	// Translation helpers:
	//

	private void process_attributes (Api.Symbol parent, GLib.List<Vala.Attribute> lst) {
		// attributes without arguments:
		string[] attributes = {
				"ReturnsModifiedPointer",
				"DestroysInstance",
				"GenericAccessors",
				"NoAccessorMethod",
				"NoArrayLength",
				"Experimental",
				"Diagnostics",
				"PrintfFormat",
				"PointerType",
				"ScanfFormat",
				"ThreadLocal",
				"SimpleType",
				"HasEmitter",
				"ModuleInit",
				"NoWrapper",
				"Immutable",
				"ErrorBase",
				"NoReturn",
				"NoThrow",
				"Compact",
				"Assert",
				"Flags"
			};

		string? tmp = "";

		foreach (Vala.Attribute att in lst) {
			if (att.name == "CCode" && (tmp = att.args.get ("has_target")) != null && tmp == "false") {
				Attribute new_attribute = new Attribute (parent, parent.get_source_file (), att.name, att);
				new_attribute.add_boolean ("has_target", false, att);
				parent.add_attribute (new_attribute);
			} else if (att.name == "Version") {
				Attribute new_attribute = new Attribute (parent, parent.get_source_file (), att.name, att);
				if ((tmp = att.args.get ("deprecated")) != null) {
					new_attribute.add_boolean ("deprecated", bool.parse (tmp), att);
				}
				if ((tmp = att.args.get ("since")) != null) {
					new_attribute.add_string ("since", tmp, att);
				}
				if ((tmp = att.args.get ("deprecated_since")) != null) {
					new_attribute.add_string ("deprecated_since", tmp, att);
					if (att.args.get ("deprecated") == null) {
						new_attribute.add_boolean ("deprecated", true, att);
					}
				}
				if ((tmp = att.args.get ("replacement")) != null) {
					new_attribute.add_string ("replacement", tmp, att);
				}
				parent.add_attribute (new_attribute);
			} else if (att.name == "Deprecated") {
				Attribute new_attribute = new Attribute (parent, parent.get_source_file (), att.name, att);
				if ((tmp = att.args.get ("since")) != null) {
					new_attribute.add_string ("since", tmp, att);
				}
				if ((tmp = att.args.get ("replacement")) != null) {
					new_attribute.add_string ("replacement", tmp, att);
				}
				parent.add_attribute (new_attribute);
			} else if (att.name in attributes) {
				Attribute new_attribute = new Attribute (parent, parent.get_source_file (), att.name, att);
				parent.add_attribute (new_attribute);
			}
		}
	}

	private string? get_ccode_type_id (Vala.CodeNode node) {
		return Vala.get_ccode_type_id (node);
	}

	private string? get_ref_function (Vala.Class sym) {
		return Vala.get_ccode_ref_function (sym);
	}

	private string? get_unref_function (Vala.Class sym) {
		return Vala.get_ccode_unref_function (sym);
	}

	private string? get_finalize_function_name (Vala.Class element) {
		if (!element.is_fundamental ()) {
			return null;
		}

		return "%sfinalize".printf (Vala.get_ccode_lower_case_prefix (element));
	}

	private string? get_free_function_name (Vala.Class element) {
		if (!element.is_compact) {
			return null;
		}

		return Vala.get_ccode_free_function (element);
	}

	private string? get_finish_name (Vala.Method m) {
		return Vala.get_ccode_finish_name (m);
	}

	private string? get_take_value_function (Vala.Class sym) {
		return Vala.get_ccode_take_value_function (sym);
	}

	private string? get_get_value_function (Vala.Class sym) {
		return Vala.get_ccode_get_value_function (sym);
	}

	private string? get_set_value_function (Vala.Class sym) {
		return Vala.get_ccode_set_value_function (sym);
	}


	private string? get_param_spec_function (Vala.CodeNode sym) {
		return Vala.get_ccode_param_spec_function (sym);
	}

	private string? get_dup_function (Vala.TypeSymbol sym) {
		return Vala.get_ccode_dup_function (sym);
	}

	private string? get_copy_function (Vala.TypeSymbol sym) {
		return Vala.get_ccode_copy_function (sym);
	}

	private string? get_destroy_function (Vala.TypeSymbol sym) {
		return Vala.get_ccode_destroy_function (sym);
	}

	private string? get_free_function (Vala.TypeSymbol sym) {
		return Vala.get_ccode_free_function (sym);
	}

	private string? get_cname (Vala.Symbol symbol) {
		return Vala.get_ccode_name (symbol);
	}

	private SourceComment? create_comment (Vala.Comment? comment) {
		if (comment != null) {
			Vala.SourceReference pos = comment.source_reference;
			SourceFile file = files.get (pos.file);
			if (comment is Vala.GirComment) {
				var tmp = new GirSourceComment (comment.content,
												file,
												pos.begin.line,
												pos.begin.column,
												pos.end.line,
												pos.end.column);
				if (((Vala.GirComment) comment).return_content != null) {
					Vala.SourceReference return_pos = ((Vala.GirComment) comment).return_content.source_reference;
					tmp.return_comment = new SourceComment (((Vala.GirComment) comment).return_content.content,
															file,
															return_pos.begin.line,
															return_pos.begin.column,
															return_pos.end.line,
															return_pos.end.column);
				}

				Vala.MapIterator<string, Vala.Comment> it = ((Vala.GirComment) comment).parameter_iterator ();
				while (it.next ()) {
					Vala.Comment vala_param = it.get_value ();
					Vala.SourceReference param_pos = vala_param.source_reference;
					var param_comment = new SourceComment (vala_param.content,
														   file,
														   param_pos.begin.line,
														   param_pos.begin.column,
														   param_pos.end.line,
														   param_pos.end.column);
					tmp.add_parameter_content (it.get_key (), param_comment);
				}
				return tmp;
			} else {
				return new SourceComment (comment.content,
										  file,
										  pos.begin.line,
										  pos.begin.column,
										  pos.end.line,
										  pos.end.column);
			}
		}

		return null;
	}

	private string get_method_name (Vala.Method element) {
		if (element is Vala.CreationMethod) {
			if (element.name == ".new") {
				return element.parent_symbol.name;
			} else {
				return element.parent_symbol.name + "." + element.name;
			}
		}

		return element.name;
	}

	private string? get_quark_macro_name (Vala.ErrorDomain element) {
		return Vala.get_ccode_upper_case_name (element, null);
	}

	private string? get_private_cname (Vala.Class element) {
		if (element.is_compact) {
			return null;
		}

		string? cname = get_cname (element);
		return (cname != null)? cname + "Private" : null;
	}

	private string? get_class_macro_name (Vala.Class element) {
		if (element.is_compact) {
			return null;
		}

		return "%s_GET_CLASS".printf (Vala.get_ccode_upper_case_name (element, null));
	}

	private string? get_class_type_macro_name (Vala.Class element) {
		if (element.is_compact) {
			return null;
		}

		return "%s_CLASS".printf (Vala.get_ccode_upper_case_name (element, null));
	}

	private string? get_is_type_macro_name (Vala.TypeSymbol element) {
		string? name = Vala.get_ccode_type_check_function (element);
		return (name != null && name != "")? name : null;
	}

	private string? get_is_class_type_macro_name (Vala.TypeSymbol element) {
		string? name = get_is_type_macro_name (element);
		return (name != null)? name + "_CLASS" : null;
	}

	private string? get_type_function_name (Vala.TypeSymbol element) {
		if ((element is Vala.Class
			&& ((Vala.Class) element).is_compact)
			|| element is Vala.ErrorDomain
			|| element is Vala.Delegate)
		{
			return null;
		}

		return "%s_get_type".printf (Vala.get_ccode_lower_case_name (element, null));
	}

	private string? get_type_macro_name (Vala.TypeSymbol element) {
		if ((element is Vala.Class
			&& ((Vala.Class) element).is_compact)
			|| element is Vala.ErrorDomain
			|| element is Vala.Delegate)
		{
			return null;
		}

		return Vala.get_ccode_type_id (element);
	}

	private string? get_type_cast_macro_name (Vala.TypeSymbol element) {
		if ((element is Vala.Class
			&& !((Vala.Class) element).is_compact)
			|| element is Vala.Interface)
		{
			return Vala.get_ccode_upper_case_name (element, null);
		} else {
			return null;
		}
	}

	private string? get_interface_macro_name (Vala.Interface element) {
		return "%s_GET_INTERFACE".printf (Vala.get_ccode_upper_case_name (element, null));
	}

	private string get_quark_function_name (Vala.ErrorDomain element) {
		return Vala.get_ccode_lower_case_prefix (element) + "quark";
	}

	private PackageMetaData? get_package_meta_data (Package pkg) {
		foreach (PackageMetaData data in packages) {
			if (data.package == pkg) {
				return data;
			}
		}

		return null;
	}

	private PackageMetaData register_package (Package package) {
		PackageMetaData meta_data = new PackageMetaData (package);
		tree.add_package (package);
		packages.add (meta_data);
		return meta_data;
	}

	private SourceFile register_source_file (PackageMetaData meta_data, Vala.SourceFile source_file) {
		SourceFile file = new SourceFile (meta_data.package,
										  source_file.get_relative_filename (),
										  source_file.get_csource_filename (),
										  source_file);
		files.set (source_file, file);

		meta_data.register_source_file (source_file);
		return file;
	}

	private SourceFile? get_source_file (Vala.Symbol symbol) {
		Vala.SourceReference source_ref = symbol.source_reference;
		if (source_ref == null) {
			return null;
		}

		SourceFile? file = files.get (source_ref.file);
		assert (file != null);
		return file;
	}

	private Package? find_package_for_file (Vala.SourceFile source_file) {
		foreach (PackageMetaData pkg in this.packages) {
			if (pkg.is_package_for_file (source_file)) {
				return pkg.package;
			}
		}

		return null;
	}


	private Namespace get_namespace (Package pkg, Vala.Symbol symbol, SourceFile? file) {
		// Find the closest namespace in our vala-tree
		Vala.Symbol namespace_symbol = symbol;
		while (!(namespace_symbol is Vala.Namespace)) {
			namespace_symbol = namespace_symbol.parent_symbol;
		}

		PackageMetaData? meta_data = get_package_meta_data (pkg);
		assert (meta_data != null);

		return meta_data.get_namespace ((Vala.Namespace) namespace_symbol, file);
	}

	private MethodBindingType get_method_binding_type (Vala.Method element) {
		if (element.is_inline) {
			return MethodBindingType.INLINE;
		} else if (element.is_abstract) {
			return MethodBindingType.ABSTRACT;
		} else if (element.is_virtual) {
			return MethodBindingType.VIRTUAL;
		} else if (element.overrides) {
			return MethodBindingType.OVERRIDE;
		} else if (element.is_inline) {
			return MethodBindingType.INLINE;
		} else if (element.binding == Vala.MemberBinding.CLASS) {
			return MethodBindingType.CLASS;
		} else if (element.binding == Vala.MemberBinding.STATIC) {
			return MethodBindingType.STATIC;
		}
		return MethodBindingType.UNMODIFIED;
	}


	private SymbolAccessibility get_access_modifier(Vala.Symbol symbol) {
		switch (symbol.access) {
		case Vala.SymbolAccessibility.PROTECTED:
			return SymbolAccessibility.PROTECTED;

		case Vala.SymbolAccessibility.INTERNAL:
			return SymbolAccessibility.INTERNAL;

		case Vala.SymbolAccessibility.PRIVATE:
			return SymbolAccessibility.PRIVATE;

		case Vala.SymbolAccessibility.PUBLIC:
			return SymbolAccessibility.PUBLIC;

		default:
			error ("Unknown symbol accessibility modifier found");
		}
	}

	private PropertyAccessorType get_property_accessor_type (Vala.PropertyAccessor element) {
		if (element.construction) {
			if (element.writable) {
				return (PropertyAccessorType.CONSTRUCT | PropertyAccessorType.SET);
			}
			return PropertyAccessorType.CONSTRUCT;
		} else if (element.writable) {
			return PropertyAccessorType.SET;
		} else if (element.readable) {
			return PropertyAccessorType.GET;
		}

		error ("Unknown symbol accessibility type");
	}

	private bool type_reference_pass_ownership (Vala.DataType? element) {
		if (element == null) {
			return false;
		}

		weak Vala.CodeNode? node = element.parent_node;
		if (node == null) {
			return false;
		}
		if (node is Vala.Parameter) {
			return (((Vala.Parameter)node).direction == Vala.ParameterDirection.IN &&
				((Vala.Parameter)node).variable_type.value_owned);
		}
		if (node is Vala.Property) {
			return ((Vala.Property)node).property_type.value_owned;
		}

		return false;
	}

	private Ownership get_type_reference_ownership (Vala.DataType? element) {
		unowned Vala.DataType? type = element;
		if (type != null) {
			if (type.parent_node is Vala.Parameter) {
				if (((Vala.Parameter) type.parent_node).direction == Vala.ParameterDirection.IN) {
					if (type.value_owned) {
						return Ownership.OWNED;
					}
				} else {
					if (type.is_weak ()) {
						return Ownership.UNOWNED;
					}
				}
				return Ownership.DEFAULT;
			} else if (type.parent_node is Vala.PropertyAccessor) {
				if (((Vala.PropertyAccessor) type.parent_node).value_type.value_owned) {
					return Ownership.OWNED;
				}
				return Ownership.DEFAULT;
			} else if (type.parent_node is Vala.Constant) {
				return Ownership.DEFAULT;
			}
			if (type.is_weak ()) {
				return Ownership.UNOWNED;
			}
		}

		return Ownership.DEFAULT;
	}

	private Ownership get_property_ownership (Vala.PropertyAccessor element) {
		if (element.value_type.value_owned) {
			return Ownership.OWNED;
		}

		// the exact type (weak, unowned) does not matter
		return Ownership.UNOWNED;
	}

	private PropertyBindingType get_property_binding_type (Vala.Property element) {
		if (element.is_abstract) {
			return PropertyBindingType.ABSTRACT;
		} else if (element.is_virtual) {
			return PropertyBindingType.VIRTUAL;
		} else if (element.overrides) {
			return PropertyBindingType.OVERRIDE;
		}

		return PropertyBindingType.UNMODIFIED;
	}

	private FormalParameterType get_formal_parameter_type (Vala.Parameter element) {
		if (element.direction == Vala.ParameterDirection.OUT) {
			return FormalParameterType.OUT;
		} else if (element.direction == Vala.ParameterDirection.REF) {
			return FormalParameterType.REF;
		} else if (element.direction == Vala.ParameterDirection.IN) {
			return FormalParameterType.IN;
		}

		error ("Unknown formal parameter type");
	}


	//
	// Vala tree creation:
	//

	private string get_package_name (string path) {
		string file_name = Path.get_basename (path);
		return file_name.substring (0, file_name.last_index_of_char ('.'));
	}

	private bool add_package (Vala.CodeContext context, string pkg) {
		// ignore multiple occurences of the same package
		if (context.has_package (pkg)) {
			return true;
		}

		string vapi_name = pkg + ".vapi";
		string gir_name = pkg + ".gir";
		foreach (string source_file in settings.source_files) {
			string basename = Path.get_basename (source_file);
			if (basename == vapi_name || basename == gir_name) {
				return true;
			}
		}


		var package_path = context.get_vapi_path (pkg) ?? context.get_gir_path (pkg);
		if (package_path == null) {
			Vala.Report.error (null, "Package `%s' not found in specified Vala API directories or GObject-Introspection GIR directories".printf (pkg));
			return false;
		}

		context.add_package (pkg);

		var vfile = new Vala.SourceFile (context, Vala.SourceFileType.PACKAGE, package_path);
		context.add_source_file (vfile);
		Package vdpkg = new Package (pkg, true, null);
		register_source_file (register_package (vdpkg), vfile);

		add_deps (context, Path.build_filename (Path.get_dirname (package_path), "%s.deps".printf (pkg)), pkg);
		return true;
	}

	private void add_deps (Vala.CodeContext context, string file_path, string pkg_name) {
		if (FileUtils.test (file_path, FileTest.EXISTS)) {
			try {
				string deps_content;
				ulong deps_len;
				FileUtils.get_contents (file_path, out deps_content, out deps_len);
				foreach (string dep in deps_content.split ("\n")) {
					dep = dep.strip ();
					if (dep != "") {
						if (!add_package (context, dep)) {
							Vala.Report.error (null, "%s, dependency of %s, not found in specified Vala API directories".printf (dep, pkg_name));
						}
					}
				}
			} catch (FileError e) {
				Vala.Report.error (null, "Unable to read dependency file: %s".printf (e.message));
			}
		}
	}

	/**
	 * Adds the specified packages to the list of used packages.
	 *
	 * @param context The code context
	 * @param packages a list of package names
	 */
	private void add_depencies (Vala.CodeContext context, string[] packages) {
		foreach (string package in packages) {
			if (!add_package (context, package)) {
				Vala.Report.error (null, "Package `%s' not found in specified Vala API directories or GObject-Introspection GIR directories".printf (package));
			}
		}
	}

	/**
	 * Add the specified source file to the context. Only .vala, .vapi, .gs,
	 * and .c files are supported.
	 */
	private void add_documented_files (Vala.CodeContext context, string[] sources) {
		if (sources == null) {
			return;
		}

		foreach (string source in sources) {
			if (FileUtils.test (source, FileTest.EXISTS)) {
				var rpath = Vala.CodeContext.realpath (source);
				if (source.has_suffix (".vala") || source.has_suffix (".gs")) {
					var source_file = new Vala.SourceFile (context, Vala.SourceFileType.SOURCE, rpath);

					if (source_package == null) {
						source_package = register_package (new Package (settings.pkg_name, false, null));
					}

					register_source_file (source_package, source_file);

					if (context.profile == Vala.Profile.GOBJECT) {
						// import the GLib namespace by default (namespace of backend-specific standard library)
						var ns_ref = new Vala.UsingDirective (new Vala.UnresolvedSymbol (null, "GLib", null));
						source_file.add_using_directive (ns_ref);
						context.root.add_using_directive (ns_ref);
					}

					context.add_source_file (source_file);
				} else if (source.has_suffix (".vapi") || source.has_suffix (".gir")) {
					string file_name = get_package_name (source);

					var vfile = new Vala.SourceFile (context, Vala.SourceFileType.PACKAGE, rpath);
					context.add_source_file (vfile);

					if (source_package == null) {
						source_package = register_package (new Package (settings.pkg_name, false, null));
					}

					register_source_file (source_package, vfile);

					add_deps (context, Path.build_filename (Path.get_dirname (source), "%s.deps".printf (file_name)), file_name);
				} else if (source.has_suffix (".c")) {
					context.add_c_source_file (rpath);
					tree.add_external_c_files (rpath);
				} else {
					Vala.Report.error (null, "%s is not a supported source file type. Only .vala, .vapi, .gs, and .c files are supported.".printf (source));
				}
			} else {
				Vala.Report.error (null, "%s not found".printf (source));
			}
		}
	}

	private Vala.CodeContext create_valac_tree (Settings settings) {
		// init context:
		var context = Vala.CodeContext.get ();

		// settings:
		context.experimental = settings.experimental;
		context.experimental_non_null = settings.experimental || settings.experimental_non_null;
		context.vapi_directories = settings.vapi_directories;
		context.report.enable_warnings = settings.verbose;
		context.metadata_directories = settings.metadata_directories;
		context.gir_directories = settings.gir_directories;

		if (settings.basedir == null) {
			context.basedir = Vala.CodeContext.realpath (".");
		} else {
			context.basedir = Vala.CodeContext.realpath (settings.basedir);
		}

		if (settings.directory != null) {
			context.directory = Vala.CodeContext.realpath (settings.directory);
		} else {
			context.directory = context.basedir;
		}


		// add default packages:
		if (settings.profile == "gobject-2.0" || settings.profile == "gobject" || settings.profile == null) {
			context.profile = Vala.Profile.GOBJECT;
			context.add_define ("GOBJECT");
		}


		if (settings.defines != null) {
			foreach (string define in settings.defines) {
				context.add_define (define);
			}
		}

		for (int i = 2; i <= 40; i += 2) {
			context.add_define ("VALA_0_%d".printf (i));
		}

		if (context.profile == Vala.Profile.GOBJECT) {
			int glib_major = 2;
			int glib_minor = 40;

			context.target_glib_major = glib_major;
			context.target_glib_minor = glib_minor;
			if (context.target_glib_major != 2) {
				Vala.Report.error (null, "This version of valac only supports GLib 2");
			}

			if (settings.target_glib != null && settings.target_glib.scanf ("%d.%d", out glib_major, out glib_minor) != 2) {
				Vala.Report.error (null, "Invalid format for --target-glib");
			}

			context.target_glib_major = glib_major;
			context.target_glib_minor = glib_minor;
			if (context.target_glib_major != 2) {
				Vala.Report.error (null, "This version of valac only supports GLib 2");
			}

			for (int i = 16; i <= glib_minor; i += 2) {
				context.add_define ("GLIB_2_%d".printf (i));
			}

			// default packages
			if (!this.add_package (context, "glib-2.0")) { //
				Vala.Report.error (null, "glib-2.0 not found in specified Vala API directories");
			}

			if (!this.add_package (context, "gobject-2.0")) { //
				Vala.Report.error (null, "gobject-2.0 not found in specified Vala API directories");
			}
		}

		// add user defined files:
		add_depencies (context, settings.packages);
		if (reporter.errors > 0) {
			return context;
		}

		add_documented_files (context, settings.source_files);
		if (reporter.errors > 0) {
			return context;
		}


		// parse vala-code:
		Vala.Parser parser = new Vala.Parser ();

		parser.parse (context);
		if (context.report.get_errors () > 0) {
			return context;
		}

		// parse gir:
		Vala.GirParser gir_parser = new Vala.GirParser ();

		gir_parser.parse (context);
		if (context.report.get_errors () > 0) {
			return context;
		}



		// check context:
		context.check ();
		if (context.report.get_errors () > 0) {
			return context;
		}

		return context;
	}



	//
	// Valadoc tree creation:
	//

	private void process_children (Api.Node node, Vala.CodeNode element) {
		Api.Node old_node = current_node;
		current_node = node;
		element.accept_children (this);
		current_node = old_node;
	}

	private Api.Node get_parent_node_for (Vala.Symbol element) {
		if (current_node != null) {
			return current_node;
		}

		Vala.SourceFile vala_source_file = element.source_reference.file;
		Package package = find_package_for_file (vala_source_file);
		SourceFile? source_file = get_source_file (element);

		return get_namespace (package, element, source_file);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_namespace (Vala.Namespace element) {
		element.accept_children (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_class (Vala.Class element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		bool is_basic_type = element.base_class == null && element.name == "string";

		Class node = new Class (parent,
								file,
								element.name,
								get_access_modifier (element),
								comment,
								get_cname (element),
								get_private_cname (element),
								get_class_macro_name (element),
								get_type_macro_name (element),
								get_is_type_macro_name (element),
								get_type_cast_macro_name (element),
								get_type_function_name (element),
								get_class_type_macro_name (element),
								get_is_class_type_macro_name (element),
								Vala.GDBusModule.get_dbus_name (element),
								get_ccode_type_id (element),
								get_param_spec_function (element),
								get_ref_function (element),
								get_unref_function (element),
								get_free_function_name (element),
								get_finalize_function_name (element),
								get_take_value_function (element),
								get_get_value_function (element),
								get_set_value_function (element),
								element.is_fundamental (),
								element.is_abstract,
								is_basic_type,
								element);
		symbol_map.set (element, node);
		parent.add_child (node);

		// relations
		foreach (Vala.DataType vala_type_ref in element.get_base_types ()) {
			var type_ref = create_type_reference (vala_type_ref, node, node);

			if (vala_type_ref.data_type is Vala.Interface) {
				node.add_interface (type_ref);
			} else if (vala_type_ref.data_type is Vala.Class) {
				node.base_type = type_ref;
			}
		}

		process_attributes (node, element.attributes);
		process_children (node, element);

		// save GLib.Error
		if (glib_error == null && node.get_full_name () == "GLib.Error") {
			glib_error = node;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_interface (Vala.Interface element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		Interface node = new Interface (parent,
										file,
										element.name,
										get_access_modifier (element),
										comment,
										get_cname (element),
										get_type_macro_name (element),
										get_is_type_macro_name (element),
										get_type_cast_macro_name (element),
										get_type_function_name (element),
										get_interface_macro_name (element),
										Vala.GDBusModule.get_dbus_name (element),
										element);
		symbol_map.set (element, node);
		parent.add_child (node);

		// prerequisites:
		foreach (Vala.DataType vala_type_ref in element.get_prerequisites ()) {
			TypeReference type_ref = create_type_reference (vala_type_ref, node, node);
			if (vala_type_ref.data_type is Vala.Interface) {
				node.add_interface (type_ref);
			} else {
				node.base_type = type_ref;
			}
		}

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_struct (Vala.Struct element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		bool is_basic_type = element.base_type == null
			&& (element.is_boolean_type ()
			|| element.is_floating_type ()
			|| element.is_integer_type ());

		Struct node = new Struct (parent,
								  file,
								  element.name,
								  get_access_modifier (element),
								  comment,
								  get_cname (element),
								  get_type_macro_name (element),
								  get_type_function_name (element),
								  get_ccode_type_id (element),
								  get_dup_function (element),
								  get_copy_function (element),
								  get_destroy_function (element),
								  get_free_function (element),
								  is_basic_type,
								  element);
		symbol_map.set (element, node);
		parent.add_child (node);

		// parent type:
		Vala.ValueType? basetype = element.base_type as Vala.ValueType;
		if (basetype != null) {
			node.base_type = create_type_reference (basetype, node, node);
		}

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_field (Vala.Field element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		Field node = new Field (parent,
								file,
								element.name,
								get_access_modifier (element),
								comment,
								get_cname (element),
								element.binding == Vala.MemberBinding.STATIC,
								element.is_volatile,
								element);
		node.field_type = create_type_reference (element.variable_type, node, node);
		symbol_map.set (element, node);
		parent.add_child (node);

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_property (Vala.Property element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		Property node = new Property (parent,
									  file,
									  element.name,
									  get_access_modifier (element),
									  comment,
									  element.nick,
									  Vala.GDBusModule.get_dbus_name_for_member (element),
									  Vala.GDBusModule.is_dbus_visible (element),
									  get_property_binding_type (element),
									  element);
		node.property_type = create_type_reference (element.property_type, node, node);
		symbol_map.set (element, node);
		parent.add_child (node);

		// Process property type
		if (element.get_accessor != null) {
			var accessor = element.get_accessor;
			node.getter = new PropertyAccessor (node,
												file,
												element.name,
												get_access_modifier (accessor),
												get_cname (accessor),
												get_property_accessor_type (accessor),
												get_property_ownership (accessor),
												accessor);
		}

		if (element.set_accessor != null) {
			var accessor = element.set_accessor;
			node.setter = new PropertyAccessor (node,
												file,
												element.name,
												get_access_modifier (accessor),
												get_cname (accessor),
												get_property_accessor_type (accessor),
												get_property_ownership (accessor),
												accessor);
		}

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_creation_method (Vala.CreationMethod element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		Method node = new Method (parent,
								  file,
								  get_method_name (element),
								  get_access_modifier (element),
								  comment,
								  get_cname (element),
								  Vala.GDBusModule.get_dbus_name_for_member (element),
								  Vala.GDBusModule.dbus_result_name (element),
								  (element.coroutine)? get_finish_name (element) : null,
								  get_method_binding_type (element),
								  element.coroutine,
								  Vala.GDBusModule.is_dbus_visible (element),
								  element is Vala.CreationMethod,
								  element);
		node.return_type = create_type_reference (element.return_type, node, node);
		symbol_map.set (element, node);
		parent.add_child (node);

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_method (Vala.Method element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		Method node = new Method (parent,
								  file,
								  get_method_name (element),
								  get_access_modifier (element),
								  comment,
								  get_cname (element),
								  Vala.GDBusModule.get_dbus_name_for_member (element),
								  Vala.GDBusModule.dbus_result_name (element),
								  (element.coroutine)? get_finish_name (element) : null,
								  get_method_binding_type (element),
								  element.coroutine,
								  Vala.GDBusModule.is_dbus_visible (element),
								  element is Vala.CreationMethod,
								  element);
		node.return_type = create_type_reference (element.return_type, node, node);
		symbol_map.set (element, node);
		parent.add_child (node);

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_signal (Vala.Signal element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		Api.Signal node = new Api.Signal (parent,
										  file,
										  element.name,
										  get_access_modifier (element),
										  comment,
										  get_cname (element),
										  (element.default_handler != null)? get_cname (element.default_handler) : null,
										  Vala.GDBusModule.get_dbus_name_for_member (element),
										  Vala.GDBusModule.is_dbus_visible (element),
										  element.is_virtual,
										  element);
		node.return_type = create_type_reference (element.return_type, node, node);
		symbol_map.set (element, node);
		parent.add_child (node);

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_delegate (Vala.Delegate element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		Delegate node = new Delegate (parent,
									  file,
									  element.name,
									  get_access_modifier (element),
									  comment,
									  get_cname (element),
									  !element.has_target,
									  element);
		node.return_type = create_type_reference (element.return_type, node, node);
		symbol_map.set (element, node);
		parent.add_child (node);

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_enum (Vala.Enum element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		Symbol node = new Enum (parent,
								file,
								element.name,
								get_access_modifier (element),
								comment,
								get_cname (element),
								get_type_macro_name (element),
								get_type_function_name (element),
								element);
		symbol_map.set (element, node);
		parent.add_child (node);

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_enum_value (Vala.EnumValue element) {
		Api.Enum parent = (Enum) get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		Symbol node = new Api.EnumValue (parent,
										 file,
										 element.name,
										 comment,
										 get_cname (element),
										 element);
		symbol_map.set (element, node);
		parent.add_child (node);

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_constant (Vala.Constant element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		Constant node = new Constant (parent,
									  file,
									  element.name,
									  get_access_modifier (element),
									  comment,
									  get_cname (element),
									  element);
		node.constant_type = create_type_reference (element.type_reference, node, node);
		symbol_map.set (element, node);
		parent.add_child (node);

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_error_domain (Vala.ErrorDomain element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		SourceComment? comment = create_comment (element.comment);

		Symbol node = new ErrorDomain (parent,
									   file,
									   element.name,
									   get_access_modifier (element),
									   comment,
									   get_cname (element),
									   get_quark_macro_name (element),
									   get_quark_function_name (element),
									   Vala.GDBusModule.get_dbus_name (element),
									  element);
		symbol_map.set (element, node);
		parent.add_child (node);

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_error_code (Vala.ErrorCode element) {
		Api.ErrorDomain parent = (ErrorDomain) get_parent_node_for (element);
		SourceFile? file = get_source_file (element);
		if (file == null) {
			file = parent.get_source_file ();
		}

		SourceComment? comment = create_comment (element.comment);

		Symbol node = new Api.ErrorCode (parent,
										 file,
										 element.name,
										 comment,
										 get_cname (element),
										 Vala.GDBusModule.get_dbus_name_for_member (element),
										 element);
		symbol_map.set (element, node);
		parent.add_child (node);

		process_attributes (node, element.attributes);
		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_type_parameter (Vala.TypeParameter element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);

		Symbol node = new TypeParameter (parent,
										 file,
										 element.name,
										 element);
		symbol_map.set (element, node);
		parent.add_child (node);

		process_children (node, element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_formal_parameter (Vala.Parameter element) {
		Api.Node parent = get_parent_node_for (element);
		SourceFile? file = get_source_file (element);

		FormalParameter node = new FormalParameter (parent,
													file,
													element.name,
													get_access_modifier(element),
													get_formal_parameter_type (element),
													element.ellipsis,
													element);
		node.parameter_type = create_type_reference (element.variable_type, node, node);
		parent.add_child (node);

		process_children (node, element);
	}	


	//
	// startpoint:
	//

	public Api.Tree? build (Settings settings, ErrorReporter reporter) {
		this.settings = settings;
		this.reporter = reporter;

		this.tree = new Api.Tree (reporter, settings);
		var context = create_valac_tree (settings);
		this.tree.data = context;

		reporter.warnings_offset = context.report.get_warnings ();
		reporter.errors_offset = context.report.get_errors ();

		if (context == null) {
			return null;
		}

		// TODO: Register all packages here
		// register packages included by gir-files
		foreach (Vala.SourceFile vfile in context.get_source_files ()) {
			if (vfile.file_type == Vala.SourceFileType.PACKAGE
				&& vfile.get_nodes ().size > 0
				&& files.contains (vfile) == false)
			{
				Package vdpkg = new Package (get_package_name (vfile.filename), true, null);
				register_source_file (register_package (vdpkg), vfile);
			}
		}

		context.accept(this);

		return (reporter.errors == 0)? tree : null;
	}
}


