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
public class Valadoc.TreeBuilder : Vala.CodeVisitor {
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
			&& vtyperef.type_symbol != null)? Vala.GVariantModule.get_dbus_signature (vtyperef.type_symbol) : null;
		bool is_dynamic = vtyperef != null && vtyperef.is_dynamic;

		TypeReference type_ref = new TypeReference (parent,
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
		foreach (Vala.Attribute att in lst) {
			Attribute new_attribute = new Attribute (parent, parent.get_source_file (), att.name, att);
			parent.add_attribute (new_attribute);
		}
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


	//
	// Vala tree creation:
	//

	private string get_package_name (string path) {
		string file_name = Path.get_basename (path);
		return file_name.substring (0, file_name.last_index_of_char ('.'));
	}

	private bool add_package (Vala.CodeContext context, string pkg) {
		// ignore multiple occurrences of the same package
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
			Vala.Report.error (null, "Package `%s' not found in specified Vala API directories or GObject-Introspection GIR directories", pkg);
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
							Vala.Report.error (null, "`%s', dependency of `%s', not found in specified Vala API directories", dep, pkg_name);
						}
					}
				}
			} catch (FileError e) {
				Vala.Report.error (null, "Unable to read dependency file: %s", e.message);
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
				Vala.Report.error (null, "Package `%s' not found in specified Vala API directories or GObject-Introspection GIR directories", package);
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

					if (context.profile == Vala.Profile.POSIX) {
						// import the Posix namespace by default (namespace of backend-specific standard library)
						var ns_ref = new Vala.UsingDirective (new Vala.UnresolvedSymbol (null, "Posix", null));
						source_file.add_using_directive (ns_ref);
						context.root.add_using_directive (ns_ref);
					} else if (context.profile == Vala.Profile.GOBJECT) {
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
					Vala.Report.error (null, "%s is not a supported source file type. Only .vala, .vapi, .gs, and .c files are supported.", source);
				}
			} else {
				Vala.Report.error (null, "%s not found", source);
			}
		}
	}

	private void create_valac_tree (Vala.CodeContext context, Settings settings) {
		// settings:
		context.experimental = settings.experimental;
		context.experimental_non_null = settings.experimental || settings.experimental_non_null;
		context.vapi_directories = settings.vapi_directories;
		context.verbose_mode = settings.verbose;
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

		context.set_target_profile (settings.profile, false);

		if (settings.target_glib != null) {
			context.set_target_glib_version (settings.target_glib);
		}

		if (settings.defines != null) {
			foreach (string define in settings.defines) {
				context.add_define (define);
			}
		}

		// FIXME Let CodeContext.set_target_profile() do this and correctly
		// handle default-packages as given source
		switch (context.profile) {
		default:
		case Vala.Profile.GOBJECT:
			add_package (context, "glib-2.0");
			add_package (context, "gobject-2.0");
			break;
		case Vala.Profile.POSIX:
			add_package (context, "posix");
			break;
		}

		// add user defined files:
		add_depencies (context, settings.packages);
		if (reporter.errors > 0) {
			return;
		}

		add_documented_files (context, settings.source_files);
		if (reporter.errors > 0) {
			return;
		}

		// parse vala-code:
		Vala.Parser parser = new Vala.Parser ();

		parser.parse (context);
		if (context.report.get_errors () > 0) {
			return;
		}

		// parse gir:
		Vala.GirParser gir_parser = new Vala.GirParser ();

		gir_parser.parse (context);
		if (context.report.get_errors () > 0) {
			return;
		}

		// check context:
		context.check ();
		if (context.report.get_errors () > 0) {
			return;
		}
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

		Class node = new Class (parent,
								file,
								element.name,
								element.access,
								comment,
								element);
		symbol_map.set (element, node);
		parent.add_child (node);

		// relations
		foreach (Vala.DataType vala_type_ref in element.get_base_types ()) {
			var type_ref = create_type_reference (vala_type_ref, node, node);

			if (vala_type_ref.type_symbol is Vala.Interface) {
				node.add_interface (type_ref);
			} else if (vala_type_ref.type_symbol is Vala.Class) {
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
										element.access,
										comment,
										element);
		symbol_map.set (element, node);
		parent.add_child (node);

		// prerequisites:
		foreach (Vala.DataType vala_type_ref in element.get_prerequisites ()) {
			TypeReference type_ref = create_type_reference (vala_type_ref, node, node);
			if (vala_type_ref.type_symbol is Vala.Interface) {
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

		Struct node = new Struct (parent,
								  file,
								  element.name,
								  element.access,
								  comment,
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
								element.access,
								comment,
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
									  element.access,
									  comment,
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
												accessor.access,
												accessor);
		}

		if (element.set_accessor != null) {
			var accessor = element.set_accessor;
			node.setter = new PropertyAccessor (node,
												file,
												element.name,
												accessor.access,
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
								  element.access,
								  comment,
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
								  element.access,
								  comment,
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
										  element.access,
										  comment,
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
									  element.access,
									  comment,
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
								element.access,
								comment,
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
									  element.access,
									  comment,
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
									   element.access,
									   comment,
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

		Api.Parameter node = new Api.Parameter (parent,
												file,
												element.name,
												element.access,
												element.direction,
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

		var context = Vala.CodeContext.get ();

		this.tree = new Api.Tree (reporter, settings, context);
		create_valac_tree (context, settings);

		reporter.warnings_offset = context.report.get_warnings ();
		reporter.errors_offset = context.report.get_errors ();

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


