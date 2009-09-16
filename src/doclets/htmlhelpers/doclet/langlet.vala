/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
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


using GLib;
using Gee;


public class Valadoc.Html.BasicLanglet : Valadoc.Langlet {
	public Valadoc.Settings settings {
		construct set;
		protected get;
	}

	public BasicLanglet ( Settings settings ) {
		this.settings = settings;
	}

	private DocumentedElement position = null;

	private string get_link ( DocumentedElement element, DocumentedElement? position ) {
		return get_html_link ( this.settings, element, position );
	}

	private inline bool is_basic_type ( string name ) {
		string[] basic_types = new string[] { "bool", "char", "uchar", "int", "uint", "short", "ushort",
				"long", "ulong", "size_t", "ssize_t", "int8", "uint8", "int16", "uint16", "int32",
				"uint32", "int64", "uint64", "float", "double", "time_t", "unichar", "string"
			};

		foreach ( string str in basic_types ) {
			if ( str == name )
				return true;
		}

		return false;
	}

	private void write_type_name ( DocumentedElement? datatype, GLib.FileStream file ) {
		if ( datatype == null ) {
			file.printf ( "<font class=\"%s\">void</font>", css_keyword );
			return ;
		}

		string typename = datatype.full_name ();
		if ( ((DocumentedElement)datatype.parent).name == null && (datatype is Class || datatype is Struct) ) {
			if ( this.is_basic_type ( typename ) ) {
				string link = this.get_link(datatype, this.position );
				if ( link == null )
					file.printf ( "<span class=\"%s\">%s</span>", css_basic_type, typename );
				else
					file.printf ( "<a class=\"%s\" href=\"%s\">%s</a>", css_basic_type, link, typename );
				return ;
			}
		}

		string link = this.get_link(datatype, this.position);
		if ( link == null )
			file.printf ( "<span class=\"%s\">%s</span>", css_other_type, typename );
		else
			file.printf ( "<a class=\"%s\" href=\"%s\">%s</a>", css_other_type, link, typename );
	}

	private void write_type_reference_template_arguments ( Valadoc.TypeReference type_reference, GLib.FileStream file ) {
		Gee.Collection<TypeReference> arglst = type_reference.get_type_arguments ( );
		int size = arglst.size;
		if ( size == 0 )
			return ;

		file.puts ( "<" );
		int i = 0;

		foreach ( TypeReference arg in arglst ) {
			i++;

			this.write_nested_type_referene ( arg, file );
			if ( i != size )
				file.puts ( ", " );
		}

		file.puts ( ">" );
	}

	private void write_type ( Basic? type, DocumentedElement? pos, GLib.FileStream file ) {
		if ( type == null ) {
			file.printf ( "<font class=\"%s\">void</font>", css_keyword );
		}
		else if ( type is DocumentedElement ) {
			DocumentedElement dtype = (DocumentedElement)type;
			weak string css = (dtype.package.name == "glib-2.0" && ((DocumentedElement)dtype.parent).name == null)? css_basic_type : css_other_type;
			string? link = this.get_link ( dtype, pos );
			if ( link == null)
				file.printf ( "<font class=\"%s\">%s</font>", css, dtype.name );
			else
				file.printf ( "<a href=\"%s\"><font class=\"%s\">%s</font></a>", link, css, dtype.name );
		}
		else if ( type is Pointer ) {
			this.write_pointer ( (Pointer)type, file, pos );
		}
		else if ( type is Array ) {
			this.write_array ( (Array)type, file, pos );
		}
		else if ( type is TypeParameter ) {
			this.write_type_parameter ( (TypeParameter)type, file );
		}
		else {
			this.write_type_reference ( (TypeReference)type, file );
		}
	}

	public override void write_pointer ( Pointer ptr, void* fptr, DocumentedElement pos ) {
		weak GLib.FileStream file = (GLib.FileStream)fptr;
		Basic type = ptr.data_type;
		this.write_type ( type, pos, file );
		file.putc ( '*' );
	}

	public override void write_array ( Array arr, void* fptr, DocumentedElement pos ) {
		weak GLib.FileStream file = (GLib.FileStream)fptr;
		Basic type =arr.data_type;
		this.write_type ( type, pos, file );
		file.puts ( "[]" );
	}

	//TODO: pos-parameter (-> this.write_type (?, pos, ?))
	private void write_nested_type_referene ( Valadoc.TypeReference type_reference, GLib.FileStream file ) {
		if ( type_reference.type_name == null )
			return ;

		// type-modifiers:
		GLib.StringBuilder modifiers = new GLib.StringBuilder ();
		if ( type_reference.is_dynamic )
			modifiers.append ( "dynamic " );

		if ( type_reference.is_weak )
			modifiers.append ( "weak " );
		else if ( type_reference.is_unowned )
			modifiers.append ( "unowned " );
		else if ( type_reference.is_owned )
			modifiers.append ( "owned " );

		if ( modifiers.len > 0 )
			file.printf ( "<font class=\"%s\">%s</font> ", css_keyword, modifiers.str );

		modifiers = null;

		Basic? type = type_reference.data_type;
		this.write_type ( type, this.position, file ); //TODO: this.position -> pos-parameter
		this.write_type_reference_template_arguments ( type_reference, file );
	}

	public override void write_type_reference ( Valadoc.TypeReference type_reference, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		this.write_nested_type_referene ( type_reference, file );
	}

	public override void write_formal_parameter ( FormalParameter param, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		if ( param.ellipsis ) {
			file.puts ( " ..." );
		}
		else {
			if ( param.is_out )
				file.printf ( "<span class=\"%s\">out</span> ", css_keyword );
			else if ( param.is_ref )
				file.printf ( "<span class=\"%s\">ref</span> ", css_keyword );

			this.write_type_reference ( param.type_reference, file );
			file.printf ( " %s", param.name );
		}
	}

	public override void write_parameter_list ( ParameterListHandler thandler, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		bool open_bracket = false;

		Gee.ArrayList<FormalParameter> params = thandler.param_list;
		int size = params.size;
		int i = 0;

		file.putc ( '(' );

		foreach ( FormalParameter param in params ) {
			i++;

			if ( param.has_default_value == true && open_bracket == false ) {
				file.printf ( "<span class=\"%s\">[", css_optional_parameter );
				open_bracket = true;
			}

			this.write_formal_parameter ( param, file );
			if ( i != size ) {
				file.puts ( ", " );
			}
			else if ( open_bracket == true ) {
				file.puts ( "]</span>" );
			}
		}

		file.putc ( ')' );
	}

	private void write_exception_list ( ExceptionHandler exception_handler, GLib.FileStream file ) {
		Gee.ReadOnlyCollection<DocumentedElement> error_domains = exception_handler.get_error_domains ();
		int size = error_domains.size;
		int i = 1;

		if ( size == 0 )
			return ;

		file.printf ( " <span class=\"%s\">throws</span> ", css_keyword );

		foreach ( DocumentedElement type in error_domains ) {
			this.write_type_name ( type, file );
			if ( error_domains.size > i ) {
				file.puts ( ", " );
			}
			i++;
		}
	}

	public override void write_method ( void* ptr, Valadoc.Method m, Valadoc.MethodHandler parent ) {
		this.position = m;

		GLib.StringBuilder modifiers = new GLib.StringBuilder ( "" );
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		this.write_accessor ( m, file );

		if ( m.is_abstract )
			modifiers.append ( " abstract" );
		else if ( m.is_virtual )
			modifiers.append ( " virtual" );
		else if ( m.is_override )
			modifiers.append ( " override" );
		if ( m.is_static )
			modifiers.append ( " static" );
		if ( m.is_inline )
			modifiers.append ( " inline" );

		file.printf ( " <span class=\"%s\">%s</span> ", css_keyword, modifiers.str );
		if ( m.is_constructor == false ) {
			this.write_type_reference ( m.type_reference, file );
		}
		file.printf ( " %s ", m.name );
		this.write_parameter_list ( m, file );

		if ( m.is_yields )
			file.printf ( " <span class=\"%s\">yields</span> ", css_keyword );

		this.write_exception_list ( m, file );
	}

	public override void write_type_parameter ( TypeParameter param, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		file.puts ( param.name );
	}

	public override void write_template_parameters ( TemplateParameterListHandler thandler, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		int i = 1;

		var lst = thandler.get_template_param_list( );
		if ( lst.size == 0 )
			return ;

		file.puts ( "&lt;" ); // <

		foreach ( TypeParameter param in lst ) {
			param.write ( this, file );
			if ( lst.size > i )
				file.puts ( ", " );

			i++;
		}
		file.puts ( "&gt;" ); // >
	}

	public override void write_field ( Valadoc.Field field, Valadoc.FieldHandler parent, void* ptr ) {
		this.position = field;
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		this.write_accessor ( field, file );

		if ( field.is_volatile ) {
			file.printf ( " <span class=\"%s\">volatile</span> ", css_keyword );
		}

		if ( field.is_static ) {
			file.printf ( " <span class=\"%s\">static</span> ", css_keyword );
		}

		this.write_type_reference ( field.type_reference, file );
		file.printf ( " %s ", field.name );
	}

	public override void write_constant ( Constant constant, ConstantHandler parent, void* ptr ) {
		this.position = constant;
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		this.write_accessor ( constant, file );
		file.printf ( " <span class=\"%s\"> const </span>", css_keyword );
		this.write_type_reference ( constant.type_reference, file );
		file.printf ( " %s ", constant.name );
	}

	public override void write_property_accessor ( Valadoc.PropertyAccessor propac, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		Property prop = (Property)propac.parent;

		file.printf ( "<span class=\"%s\">", css_keyword );

		if ( !(prop.is_public == propac.is_public && prop.is_private == propac.is_private && prop.is_protected == propac.is_protected) ) {
			// FIXME: PropertyAccessor isn't a SymbolAccessibility. (Valac-Bug.)
			if ( propac.is_public )
				file.puts ( "public " );
			else if ( propac.is_protected )
				file.puts ( "protected " );
			else if ( propac.is_private )
				file.puts ( "private " );
			else if ( propac.is_internal )
				file.puts ( "internal " );
		}

		if ( propac.is_owned )
			file.puts ( "owned " );

		if ( propac.is_get )
			file.puts ( "get" );
		else if ( propac.is_set )
			file.puts ( "set" );

		file.puts ( "</span>;" );
	}

	public override void write_property ( Valadoc.Property prop, void* ptr ) {
		this.position = prop;
		GLib.StringBuilder modifiers = new GLib.StringBuilder ( "" );
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		this.write_accessor ( prop, file );

		if ( prop.is_virtual )
			modifiers.append ( " virtual " );
		else if ( prop.is_abstract )
			modifiers.append ( " abstract " );
		else if ( prop.is_override )
			modifiers.append ( " override " );

		if ( modifiers.len > 0 )
			file.printf ( " <span class=\"%s\">%s</span> ", css_keyword, modifiers.str );

		this.write_type_reference ( prop.type_reference, file );
		file.printf ( " %s { ", prop.name );

		if ( prop.setter != null )
			this.write_property_accessor ( prop.setter, file );


		file.printf ( " " );

		if ( prop.getter != null )
			this.write_property_accessor ( prop.getter, file );

		file.printf ( " }" );
	}

	public override void write_signal ( Valadoc.Signal sig, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		this.position = sig;

		this.write_accessor ( sig, file );

		file.printf ( " <span class=\"%s\">", css_keyword );

		if ( sig.is_virtual == true )
			file.printf ( "virtual " );

		file.printf ( "signal</span> " );

		this.write_type_reference ( sig.type_reference, file );
		file.printf ( " %s ", sig.name );
		this.write_parameter_list ( sig, file );
	}

	public override void write_enum_value ( Valadoc.EnumValue enval, void* ptr ) {
	}

	public override void write_error_code ( Valadoc.ErrorCode errcode, void* ptr ) {
	}

	public override void write_delegate ( Valadoc.Delegate del, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		this.position = del;

		this.write_accessor ( del, file );

		file.printf ( " <span class=\"%s\">delegate</span> ", css_keyword );
		this.write_type_reference ( del.type_reference, file );
		file.printf ( " %s ", del.name );
		this.write_parameter_list ( del, file );
		this.write_exception_list ( del, file );
	}

	public override void write_enum ( Valadoc.Enum en, void* ptr ) {
	}

	public override void write_error_domain ( Valadoc.ErrorDomain errdom, void* ptr ) {
	}

	private void write_accessor ( Valadoc.SymbolAccessibility element, GLib.FileStream file ) {
		if ( element.is_public )
			file.printf ( "<span class=\"%s\">public</span> ", css_keyword );
		else if ( element.is_protected )
			file.printf ( "<span class=\"%s\">protected</span> ", css_keyword );
		else if ( element.is_private )
			file.printf ( "<span class=\"%s\">private</span> ", css_keyword );
		else if ( element.is_internal )
			file.printf ( "<span class=\"%s\">internal</span> ", css_keyword );
	}


	public override void write_struct ( Valadoc.Struct stru, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		this.position = stru;

		this.write_accessor ( stru, file );
		file.printf ( "<span class=\"%s\">struct</span> %s", css_keyword, stru.name );
		this.write_template_parameters ( stru, ptr );
		this.write_inheritance_list ( stru, file );
	}

	public override void write_inheritance_list ( DocumentedElement dtype, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		Gee.Collection<Interface> lst = null;
		DocumentedElement? base_type = null;
		int size = 0;
		int i = 1;

		if (dtype is Class) {
			lst = ((Class)dtype).get_implemented_interface_list ();
			base_type = ((Class)dtype).base_type;
			size = lst.size;
		}
		else if (dtype is Interface) {
			lst = ((Interface)dtype).get_implemented_interface_list ();
			base_type = ((Interface)dtype).base_type;
			size = lst.size;
		}
		else if (dtype is Struct) {
			base_type = ((Struct)dtype).base_type;
		}


		if ( size == 0 && base_type == null )
			return ;

		file.puts ( " : " );

		if ( base_type != null ) {
			this.write_type_name ( (DocumentedElement)base_type, file );
			if ( size > 0 ) {
				file.puts ( ", " );
			}
		}

		if (lst != null) {
			foreach ( Interface cntype in lst ) {
				this.write_type_name ( cntype, file );
				if ( size > i )
					file.puts ( ", " );

				i++;
			}
		}
		file.putc ( ' ' );
	}

	public override void write_class ( Valadoc.Class cl, void* ptr ) {
		GLib.StringBuilder modifiers = new GLib.StringBuilder ( "" );
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		this.position = cl;

		this.write_accessor ( cl, file );

		if ( cl.is_abstract )
			modifiers.append ( "abstract " );

		file.printf ( "<span class=\"%s\">%s class</span> %s", css_keyword, modifiers.str, cl.name );

		this.write_template_parameters ( cl, file );
		this.write_inheritance_list ( cl, file );
	}

	public override void write_interface ( Valadoc.Interface iface, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		this.position = iface;

		this.write_accessor ( iface, file );

		file.printf ( "<span class=\"%s\">interface</span> %s", css_keyword, iface.name );

		this.write_template_parameters ( iface, ptr );
		this.write_inheritance_list ( iface, file );
	}

	public override void write_namespace ( Valadoc.Namespace ns, void* ptr ) {
	}

	public override void write_file ( Valadoc.Package file, void* ptr ) {
	}
}


