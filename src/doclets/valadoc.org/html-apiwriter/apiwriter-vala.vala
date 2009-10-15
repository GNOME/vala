/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2009 Florian Brosch
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */


using Valadoc;
using Gee;

public class Valadoc.Html.ValaApiWriter : ApiWriter {
	private Entry keyword (string str) {
		Span span = new Span ();
		span.add_attribute (this.csskeyword);
		span.add_child (new String(str));
		return span;
	}

	private Entry parents (Api.Node type) {
		Span span = new Span ();
		span.add_attribute (this.cssparentlist);

		Gee.Collection<Interface>? interfaces = null;
		Api.Item? basetype = null;

		bool Api.Node;

		if (type is Interface) {
			interfaces = ((Interface)type).get_implemented_interface_list ();
			basetype = ((Interface)type).base_type;
		}
		else if (type is Class) {
			interfaces = ((Class)type).get_implemented_interface_list ();
			basetype = ((Class)type).base_type;
		}
		else if (type is Struct) {
			basetype = ((Struct)type).base_type;
		}

		if (basetype != null || (interfaces != null && interfaces.size > 0)) {
			span.add_child (new String (" : "));
		}

		if (basetype != null) {
			span.add_child (this.type (basetype, out Api.Node));
		}

		if (interfaces != null) {
			if (basetype != null && interfaces.size > 0) {
				span.add_child (new String (", "));
			}

			int i = 0;
			foreach (Interface iface in interfaces) {
				span.add_child (this.type (iface, out Api.Node));
				if (interfaces.size < ++i) {
					span.add_child (new String (", "));
				}
			}
		}

		return span;
	}

	private Entry type (Api.Item? type, out bool Api.Node) {
		ArrayList<Entry> elements = new ArrayList<Entry> ();
		weak Attribute css = this.csstype;
		Api.Node = false;

		while (true) {
			if (type == null) {
				elements.insert (0, this.keyword("void"));
				break;
			}
			else if (type is Pointer) {
				elements.add (new String("*"));
				type = ((Pointer)type).data_type;
			}
			else if (type is Array) {
				//TODO: multidim. arrays
				elements.add (new String("[]"));
				type = ((Array)type).data_type;
			}
			else if (type is TypeParameter) {
				elements.insert (0, new String (((TypeParameter)type).name));
				break;
			}
			else if (type is Api.Node) {
				weak Api.Node dtype = (Api.Node)type;
				if (dtype.package.name == "glib-2.0" && dtype.nspace.name == null && (dtype is Struct || dtype is Class)) {
					css = this.cssbasictype;
				}

				HyperLink link = new HyperLink ("/%s/%s.html".printf (dtype.package.name, dtype.full_name ()), new String (dtype.name));
				link.add_attribute (csslink);
				elements.insert (0, link);
				Api.Node = true;
				break;
			}
			else { // typereference
				// prepend:
				ArrayList<Entry> lst = this.type_reference (((TypeReference)type));
				foreach (Entry e in elements) {
					lst.add (e);
				}
				elements = lst;
				break;
			}
		}

		Span span = new Span.from_list (elements);
		span.add_attribute (css);
		return span;
	}

	private ArrayList<Entry>? type_parameter_list (TemplateParameterListHandler tplh) {
		Collection<TypeParameter> tpllist = tplh.get_template_param_list ();
		if (tpllist.size == 0) {
			return null;
		}

		ArrayList<Entry> cnt = new ArrayList<Entry> ();
		int i = 0;

		cnt.add (new String ("<"));

		foreach (TypeParameter tpl in tpllist ) {
			Span span = new Span ();
			span.add_child (new String (tpl.name));
			span.add_attribute (this.csstype);
			cnt.add (span);

			if (++i != tpllist.size) {
				cnt.add (new String (", "));
			}
		}

		cnt.add (new String (">"));
		return cnt;
	}

	private ArrayList<Entry> type_reference (TypeReference typeref) {
		ArrayList<Entry> list = new ArrayList<Entry> ();
		bool Api.Node;

		StringBuilder str = new StringBuilder ();
		//if(typeref.pass_ownership) {
		//}

		if(typeref.is_dynamic) {
			str.append ("dynamic ");
		}

		if(typeref.is_owned) {
			str.append ("owned ");
		}

		if(typeref.is_unowned) {
			str.append ("unowned ");
		}

		if(typeref.is_weak) {
			str.append ("weak ");
		}

		if (str.len > 0) {
			list.add (this.keyword (str.str));
		}

		list.add (this.type (typeref.data_type, out Api.Node));

		Collection<TypeReference> typeargs = typeref.get_type_arguments ();
		if (typeargs.size != 0) {
			list.add (new String ("<"));
			int i = 0;

			foreach (TypeReference tref in typeargs) {
				foreach (Entry e in this.type_reference (tref)) {
					list.add (e);
				}

				if (++i != typeargs.size) {
					list.add (new String (", "));
				}
			}

			list.add (new String (">"));
		}

		if(typeref.is_nullable && Api.Node) {
			list.add(new String("?"));
		}

		return list;
	}

	private Entry formal_parameter (FormalParameter param) {
		Span span = new Span ();
		span.add_attribute (this.cssformalparam);

		if (param.ellipsis) {
			span.add_child (new String ("..."));
			return span;
		}
		else {
			if (param.is_out) {
				span.add_child (this.keyword("out "));
			}
			else if (param.is_ref) {
				span.add_child (this.keyword("ref "));
			}
			
			span.add_childs (this.type_reference(param.type_reference));
			span.add_child (new String(" "+param.name));
			return span;
		}
	}

	private Entry parameter_list (ParameterListHandler paramh) {
		Span rspan = new Span ();
		Span span = rspan;

		span.add_attribute (cssparamlist);

		span.add_child (new String("("));
		bool default_value = false;
		int i = 0;

		foreach (FormalParameter param in paramh.param_list) {
			if (param.has_default_value && !default_value) {
				default_value = true;

				span = new Span ();
				span.add_attribute (this.cssoptparamlist);
				span.add_child (new String("["));
				rspan.add_child (span);
			}

			span.add_child (this.formal_parameter(param));
			if (++i != paramh.param_list.size) {
				span.add_child (new String (", "));
			}
		}

		if (default_value) {
			span.add_child (new String("]"));		
			span = rspan;
		}

		span.add_child (new String(")"));
		return rspan;
	}

	private string symbol_accessibility (SymbolAccessibility symbol) {
		if (symbol.is_public) {
			return "public";
		}
		else if (symbol.is_protected) {
			return "protected ";
		}
		else if (symbol.is_internal) {
			return "internal ";
		}
		else {
			return "private ";
		}
	}

	private Entry exception (Api.Node element) {
		Span span = new Span();
		span.add_child (new String (element.full_name()));
		return span;
	}

	private Entry? exceptions (ExceptionHandler exh) {
		Collection<Api.Node> errs = exh.get_error_domains ();
		if (errs.size == 0) {
			return null;
		}

		Span span = new Span ();
		span.add_attribute (cssexclist);

		span.add_child (this.keyword(" throws "));

		foreach (Api.Node type in errs) {
			span.add_child (this.exception(type));
		}

		return span;
	}

	public override Div from_method (Method m) {
		Div api = new Div ();
		api.add_attribute (cssapi);

		StringBuilder str = new StringBuilder (this.symbol_accessibility (m));
		str.append_c (' ');

		if ( m.is_abstract ) {
			str.append ("abstract ");
		}
		else if ( m.is_virtual ) {
			str.append ("virtual ");
		}
		else if ( m.is_override ) {
			str.append ("override ");
		}

		if ( m.is_static ) {
			str.append ("static ");
		}

		if ( m.is_inline ) {
			str.append ("inline ");
		}

		api.add_child (this.keyword(str.str));
		str = null;


		// return type:
		if (m.is_constructor == false) {
			Collection<Entry> lst = this.type_reference (m.type_reference);
			api.add_childs (lst);
		}

		api.add_child (new String (" "+m.name));


		Collection<Entry> lst = this.type_parameter_list ((m.is_constructor)? (TemplateParameterListHandler)m.parent: m);
		if (lst != null) {
			api.add_childs (lst);
		}

		api.add_child (new String (" "));

		// type parameters
		api.add_child (this.parameter_list (m));
		Entry? exceptions = this.exceptions (m);
		if (exceptions != null) {
			api.add_child (exceptions);
		}

		if (m.is_yields) {
			api.add_child (this.keyword(" yields"));
		}

		api.add_child (new String(";"));
		return api;
	}

	public override Div from_delegate (Delegate del) {
		Div api = new Div ();
		api.add_attribute (cssapi);


		api.add_child (this.keyword(this.symbol_accessibility (del) + " delegate "));


		// return type:
		Collection<Entry> lst = this.type_reference (del.type_reference);
		foreach (Entry e in lst) {
			api.add_child (e);
		}

		api.add_child (new String (" "+del.name));

		lst = this.type_parameter_list (del);
		if (lst != null) {
			api.add_childs (lst);
		}

		api.add_child (new String (" "));


		// type parameters
		api.add_child (this.parameter_list (del));
		Entry? exceptions = this.exceptions (del);
		if (exceptions != null) {
			api.add_child (exceptions);
		}

		api.add_child (new String(";"));
		return api;
	}

	public override Div from_signal (Signal sig) {
		Div api = new Div ();
		api.add_attribute (cssapi);


		api.add_child (this.keyword(this.symbol_accessibility (sig) + " signal "));

		// return type:
		Collection<Entry> lst = this.type_reference (sig.type_reference);
		foreach (Entry e in lst) {
			api.add_child (e);
		}

		api.add_child (new String (" "+sig.name+" "));
		// type parameters
		api.add_child (this.parameter_list (sig));
		api.add_child (new String(";"));
		return api;
	}

	public override Div from_field (Field field) {
		Div api = new Div ();
		api.add_attribute (cssapi);

		StringBuilder str = new StringBuilder (this.symbol_accessibility (field));
		str.append_c (' ');

		if (field.is_volatile) {
			str.append ("volatile ");
		}

		if (field.is_static) {
			str.append ("static ");		
		}

		api.add_child (this.keyword (str.str));

		foreach (Entry e in this.type_reference (field.type_reference)) {
			api.add_child (e);
		}

		api.add_child (new String(" "+field.name+";"));
		return api;
	}

	public override Div from_constant (Constant c) {
		Div api = new Div ();
		api.add_attribute (cssapi);

		api.add_child (this.keyword (this.symbol_accessibility (c)+" const "));

		foreach (Entry e in this.type_reference (c.type_reference)) {
			api.add_child (e);
		}

		api.add_child (new String(" "+c.name+";"));
		return api;
	}

	public override Div from_namespace (Namespace ns) {
		Div api = new Div ();
		api.add_attribute (cssapi);

		api.add_child (this.keyword ("namespace "));
		api.add_child (new String (ns.name+";"));
		return api;
	}

	public override Div from_enum (Enum en) {
		Div api = new Div ();
		api.add_attribute (cssapi);

		api.add_child (this.keyword (this.symbol_accessibility (en) + " enum "));
		api.add_child (new String (en.name+";"));
		return api;
	}

	public override Div from_errordomain (ErrorDomain err) {
		Div api = new Div ();
		api.add_attribute (cssapi);

		api.add_child (this.keyword (this.symbol_accessibility (err) + " errordomain "));
		api.add_child (new String (err.name+";"));
		return api;
	}

	public override Div from_enumvalue (EnumValue env) {
		Div api = new Div ();
		api.add_attribute (cssapi);
		api.add_child (new String (env.name));
		return api;
	}

	public override Div from_errorcode (ErrorCode errc) {
		Div api = new Div ();
		api.add_attribute (cssapi);
		api.add_child (new String (errc.name));
		return api;
	}

	public override Div from_struct (Struct stru) {
		Div api = new Div ();
		api.add_attribute (cssapi);

		api.add_child (this.keyword (this.symbol_accessibility (stru) + " struct "));
		api.add_child (new String (stru.name));

		Collection<Entry> lst = this.type_parameter_list (stru);
		if (lst != null) {
			api.add_childs (lst);
		}

		api.add_child (this.parents (stru));
		api.add_child (new String (";"));
		return api;
	}

	public override Div from_class (Class cl) {
		Div api = new Div ();
		api.add_attribute (cssapi);

		StringBuilder str = new StringBuilder (this.symbol_accessibility (cl));
		if (cl.is_abstract) {
			str.append (" abstract");
		}

		str.append (" class ");

		api.add_child (this.keyword(str.str));
		str = null;

		api.add_child (new String (cl.name));

		Collection<Entry> lst = this.type_parameter_list (cl);
		if (lst != null) {
			api.add_childs (lst);
		}

		api.add_child (this.parents (cl));
		api.add_child (new String (";"));
		return api;
	}

	public override Div from_interface (Interface iface) {
		Div api = new Div ();
		api.add_attribute (cssapi);


		api.add_child (this.keyword (this.symbol_accessibility (iface)+" interface "));
		api.add_child (new String (iface.name));

		Collection<Entry> lst = this.type_parameter_list (iface);
		if (lst != null) {
			api.add_childs (lst);
		}

		api.add_child (this.parents (iface));
		api.add_child (new String (";"));
		return api;
	}

	private Entry from_property_accessor (PropertyAccessor propac) {
		StringBuilder str = new StringBuilder ();

		if (propac.is_private) {
			str.append ("private ");
		}
		else if (propac.is_public) {
			str.append ("public ");
		}
		else if (propac.is_protected) {
			str.append ("protected ");
		}
		else {
			str.append ("internal ");
		}

		if (propac.is_owned) {
			str.append ("owned ");
		}

		if (propac.is_get ) {
			str.append ("get ");
		}
		else {
			str.append ("set ");
		}
		
		Span span = new Span ();	
		span.add_child (this.keyword (str.str));
		span.add_child (new String ("; "));
		return span;
	}

	public override Div from_property (Property prop) {
		Div api = new Div ();
		api.add_attribute (cssapi);


		StringBuilder str = new StringBuilder (this.symbol_accessibility (prop));
		if (prop.is_virtual) {
			str.append ( " virtual " );
		}
		else if (prop.is_abstract) {
			str.append ( " abstract " );
		}
		else {
			str.append ( " override " );
		}

		api.add_child (this.keyword (str.str));

		foreach (Entry e in this.type_reference (prop.type_reference)) {
			api.add_child (e);
		}

		api.add_child (new String(" "+prop.name+" { "));
		if (prop.setter != null) {
			api.add_child(from_property_accessor (prop.setter));
		}

		if (prop.getter != null) {
			api.add_child(from_property_accessor (prop.getter));
		}

		api.add_child (new String("}"));
		return api;
	}
}


