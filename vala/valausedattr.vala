/* valaunusedattr.vala
 *
 * Copyright (C) 2014-2015  Jürg Billeter
 * Copyright (C) 2014-2015  Luca Bruno
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Luca Bruno <lucabru@src.gnome.org>
 */

using GLib;

/**
 * Code visitor to warn about unused attributes
 */
public class Vala.UsedAttr : CodeVisitor {
	public Vala.Map<string,Vala.Set<string>> marked = new HashMap<string,Vala.Set<string>> (str_hash, str_equal);

	const string[] valac_default_attrs = {
		"CCode", "type_signature", "default_value", "set_value_function", "type_id", "cprefix", "cheader_filename",
		"marshaller_type_name", "get_value_function", "cname", "cheader_filename", "destroy_function", "lvalue_access",
		"has_type_id", "instance_pos", "const_cname", "take_value_function", "copy_function", "free_function",
		"param_spec_function", "has_target", "type_cname", "ref_function", "ref_function_void", "unref_function", "type",
		"has_construct_function", "returns_floating_reference", "gir_namespace", "gir_version", "construct_function",
		"lower_case_cprefix", "simple_generics", "sentinel", "scope", "has_destroy_function", "ordering", "type_check_function",
		"has_copy_function", "lower_case_csuffix", "ref_sink_function", "dup_function", "finish_function", "generic_type_pos",
		"array_length_type", "array_length", "array_length_cname", "array_length_cexpr", "array_null_terminated",
		"vfunc_name", "finish_name", "free_function_address_of", "pos", "delegate_target", "delegate_target_cname",
		"array_length_pos", "delegate_target_pos", "destroy_notify_pos", "ctype", "has_new_function", "notify", "",

		"Immutable", "",
		"Compact", "",
		"NoWrapper", "",
		"DestroysInstance", "",
		"Flags", "",
		"Experimental", "",
		"NoReturn", "",
		"Assert", "",
		"ErrorBase", "",
		"GenericAccessors", "",
		"Diagnostics", "",
		"NoAccessorMethod", "",
		"ConcreteAccessor", "",
		"HasEmitter", "",
		"ReturnsModifiedPointer", "",
		"Deprecated", "since", "replacement", "",
		"Version", "since", "replacement", "deprecated", "deprecated_since", "experimental", "",
		"Signal", "detailed", "run", "no_recurse", "action", "no_hooks", "",
		"Description", "nick", "blurb", "",
		
		"IntegerType", "rank", "min", "max", "",
		"FloatingType", "rank", "",
		"BooleanType", "",
		"SimpleType", "",
		"PrintfFormat", "",
		"ScanfFormat", "",

		"GtkChild", "name", "internal", "",
		"GtkTemplate", "ui", "",
		"GtkCallback", "name", "",

		"DBus", "name", "no_reply", "result", "use_string_marshalling", "value", "signature", "visible", "",

		"GIR", "name", ""

	};
	
	public UsedAttr () {
		// mark default valac attrs
		var curattr = "";
		foreach (unowned string val in valac_default_attrs) {
			if (val == "") {
				curattr = "";
			} else {
				if (curattr == "") {
					curattr = val;
					mark (curattr, null);
				} else {
					mark (curattr, val);
				}
			}
		}
	}
	
	/**
	 * Mark the attribute or attribute argument as used by the compiler
	 */
	public void mark (string attribute, string? argument) {
		var set = marked.get (attribute);
		if (set == null) {
			set = new HashSet<string> (str_hash, str_equal);
			marked.set (attribute, set);
		}

		if (argument != null) {
			set.add (argument);
		}
	}
	
	/**
	 * Traverse the code tree and warn about unused attributes.
	 *
	 * @param context a code context
	 */
	public void check_unused (CodeContext context) {
		context.root.accept (this);
	}

	void check_unused_attr (Symbol sym) {
		// optimize by not looking at all the symbols
		if (sym.used) {
			foreach (unowned Attribute attr in sym.attributes) {
				var set = marked.get (attr.name);
				if (set == null) {
					Report.warning (attr.source_reference, "attribute `%s' never used".printf (attr.name));
				} else {
					foreach (var arg in attr.args.get_keys()) {
						if (!set.contains (arg)) {
							Report.warning (attr.source_reference, "argument `%s' never used".printf (arg));
						}
					}
				}
			}
		}
	}
	
	public override void visit_namespace (Namespace ns) {
		check_unused_attr (ns);
		ns.accept_children (this);
	}
	
	public override void visit_class (Class cl) {
		check_unused_attr (cl);
		cl.accept_children (this);
	}

	public override void visit_struct (Struct st) {
		check_unused_attr (st);
		st.accept_children (this);
	}

	public override void visit_interface (Interface iface) {
		check_unused_attr (iface);
		iface.accept_children (this);
	}

	public override void visit_enum (Enum en) {
		check_unused_attr (en);
		en.accept_children (this);
	}

	public override void visit_error_domain (ErrorDomain ed) {
		check_unused_attr (ed);
		ed.accept_children (this);
	}

	public override void visit_delegate (Delegate cb) {
		check_unused_attr (cb);
		cb.accept_children (this);
	}

	public override void visit_constant (Constant c) {
		check_unused_attr (c);
	}

	public override void visit_field (Field f) {
		check_unused_attr (f);
	}

	public override void visit_method (Method m) {
		check_unused_attr (m);
		m.accept_children (this);
	}

	public override void visit_creation_method (CreationMethod m) {
		check_unused_attr (m);
		m.accept_children (this);
	}

	public override void visit_formal_parameter (Parameter p) {
		check_unused_attr (p);
	}

	public override void visit_property (Property prop) {
		check_unused_attr (prop);
	}

	public override void visit_signal (Signal sig) {
		check_unused_attr (sig);
		sig.accept_children (this);
	}
}
