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

using Valadoc;
using Mysql;
using GLib;
using Gee;






public class Valadoc.ValadocOrgLanglet : Valadoc.Langlet {
	private const string css_optional_parameter = "";
	private const string css_basic_type = "";
	private const string css_other_type = "";
	private const string css_keyword = "";

	public Valadoc.Settings settings {
		construct set;
		protected get;
	}

	public ValadocOrgLanglet ( Settings settings ) {
		this.settings = settings;
	}

	private Basic position = null;

	protected string get_link ( Basic type, Basic position ) {
		return "";
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

	private void write_type_name ( DataType? datatype, GLib.StringBuilder stream ) {
		if ( datatype == null ) {
			stream.append ( "<font class=\"" );
			stream.append ( css_keyword );
			stream.append ( "\">void</font>" );
			return ;
		}

		string typename = datatype.full_name ();
		if ( ((DocumentedElement)datatype.parent).name == null && (datatype is Class || datatype is Struct) ) {
			if ( this.is_basic_type ( typename ) ) {
				string link = this.get_link(datatype, this.position );
				if ( link == null ) {
					stream.append ( "<span class=\"" );
					stream.append ( css_basic_type );
					stream.append ( "\">" );
					stream.append ( typename );
					stream.append ( "</span>" );
				}
				else {
					stream.append ( "<a class=\"" );
					stream.append ( css_basic_type );
					stream.append ( "\" href=\"" );
					stream.append ( link );
					stream.append ( "\">" );
					stream.append ( typename );
					stream.append ( "</a>" );
				}
				return ;
			}
		}

		string link = this.get_link(datatype, this.position);
		if ( link == null ) {
			stream.append ( "<span class=\"" );
			stream.append ( css_other_type );
			stream.append ( "\">" );
			stream.append ( typename );
			stream.append ( "</span>" );
		}
		else {
			stream.append ( "<a class=\"" );
			stream.append ( css_other_type );
			stream.append ( "\" href=\"" );
			stream.append ( link );
			stream.append ( "\">" );
			stream.append ( typename );
			stream.append ( "</a>" );
		}
	}

	private void write_type_reference_name ( TypeReference type_reference, GLib.StringBuilder stream ) {
		if ( type_reference.type_name == "void" ) {
			stream.append ( "<font class=\"" );
			stream.append ( css_keyword );
			stream.append ( "\">void</font>" );
		}
		else {
			if ( type_reference.data_type == null  ) {
				stream.append ( "<font class=\"" );
				stream.append ( css_other_type );
				stream.append ( "\">" );
				stream.append ( type_reference.type_name );
				stream.append ( "</font>" );
			}
			else {
				this.write_type_name ( type_reference.data_type, stream );
			}
		}
	}

	private void write_type_reference_template_arguments ( Valadoc.TypeReference type_reference, GLib.StringBuilder stream ) {
		Gee.Collection<TypeReference> arglst = type_reference.get_type_arguments ( );
		int size = arglst.size;
		if ( size == 0 )
			return ;

		stream.append ( "<" );
		int i = 0;

		foreach ( TypeReference arg in arglst ) {
			i++;

			this.write_nested_type_referene ( arg, stream );
			if ( i != size )
				stream.append ( ", " );
		}

		stream.append ( ">" );
	}

	private void write_nested_type_referene ( Valadoc.TypeReference type_reference, GLib.StringBuilder stream ) {
		if ( type_reference.type_name == null )
			return ;


		GLib.StringBuilder modifiers = new GLib.StringBuilder ();

		if ( type_reference.is_dynamic )
			modifiers.append ( "dynamic " );

		if ( type_reference.is_weak )
			modifiers.append ( "weak " );
		else if ( type_reference.is_unowned )
			modifiers.append ( "unowned " );
		else if ( type_reference.is_owned )
			modifiers.append ( "owned " );

		if ( modifiers.len > 0 ) {
			stream.append ( "<font class=\"" );
			stream.append ( css_keyword );
			stream.append ( "\">" );
			stream.append ( modifiers.str );
			stream.append ( "</font> ");
		}


		this.write_type_reference_name ( type_reference, stream );
		this.write_type_reference_template_arguments ( type_reference, stream );

		if ( type_reference.is_array ) {
			stream.append_unichar ( '[' );
			stream.append ( string.nfill ( type_reference.array_rank-1, ',') );
			stream.append_unichar ( ']' );
		}

		if ( type_reference.is_nullable ) {
			stream.append_unichar ( '?' );
		}

		stream.append ( string.nfill ( type_reference.pointer_rank, '*') );
	}

	public override void write_type_reference ( Valadoc.TypeReference type_reference, void* ptr ) {
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;

		if ( type_reference == null )
			return ;

		this.write_nested_type_referene ( type_reference, stream );
		stream.append_unichar ( ' ' );

		/*
		if ( type_reference.is_weak ) {
			file.printf ( "<font class=\"%s\">weak</font> ", css_keyword );
		}

		this.write_type_name ( type_reference.data_type, file );

		if ( type_reference.is_array ) {
			string str = string.nfill ( type_reference.array_rank-1, ',');
			file.printf ( "[%s]", str );
		}

		if ( type_reference.pass_ownership ) {
			file.putc ( '#' );
		}

		if ( type_reference.is_nullable ) {
			file.putc ( '?' );
		}

		string str = string.nfill ( type_reference.pointer_rank, '*' );
		file.puts ( str );
		*/
	}

	private void write_formal_parameter ( FormalParameter param, GLib.StringBuilder stream ) {
		if ( param.ellipsis ) {
			stream.append ( " ..." );
		}
		else {
			if ( param.is_out ) {
				stream.append ( "<span class=\"" );
				stream.append ( css_keyword );
				stream.append ( "\">out</span> " );
			}
			else if ( param.is_ref ) {
				stream.append ( "<span class=\"" );
				stream.append ( css_keyword );
				stream.append ( "\">ref</span> " );
			}

			this.write_type_reference ( param.type_reference, stream );
			stream.append_unichar ( ' ' );
			stream.append ( param.name );
		}
	}

	public override void write_parameter_list ( ParameterListHandler thandler, void* ptr ) {
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		bool open_bracket = false;

		Gee.ArrayList<FormalParameter> params = thandler.param_list;
		int size = params.size;
		int i = 0;

		stream.append_unichar ( '(' );

		foreach ( FormalParameter param in params ) {
			i++;

			if ( param.has_default_value == true && open_bracket == false ) {
				stream.append ( "<span class=\"" );
				stream.append ( css_optional_parameter );
				stream.append ( "\">[" );
				open_bracket = true;
			}

			this.write_formal_parameter ( param, stream );
			if ( i != size ) {
				stream.append ( ", " );
			}
			else if ( open_bracket == true ) {
				stream.append ( "]</span>" );
			}
		}

		stream.append_unichar ( ')' );
	}

	private void write_exception_list ( ExceptionHandler exception_handler, GLib.StringBuilder stream ) {
		Gee.ReadOnlyCollection<DataType> error_domains = exception_handler.get_error_domains ();
		int size = error_domains.size;
		int i = 1;

		if ( size == 0 )
			return ;

		stream.append ( " <span class=\"" );
		stream.append ( css_keyword );
		stream.append ( "\">throws</span> " );


		foreach ( DataType type in error_domains ) {
			this.write_type_name ( type, stream );
			if ( error_domains.size > i ) {
				stream.append ( ", " );
			}
			i++;
		}
	}

	public override void write_method ( void* ptr, Valadoc.Method m, Valadoc.MethodHandler parent ) {
		GLib.StringBuilder modifiers = new GLib.StringBuilder ( "" );
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		this.position = m;

		this.write_accessor ( m, stream );

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

		if ( modifiers.len > 0 ) {
			stream.append ( " <span class=\"" );
			stream.append ( css_keyword );
			stream.append ( "\">" );
			stream.append ( modifiers.str );
			stream.append ( "</span>" );
		}

		this.write_type_reference ( m.type_reference, stream );
		stream.append ( m.name );
		stream.append_unichar ( ' ' );
		this.write_parameter_list ( m, stream );

		if ( m.is_yields ) {
			stream.append ( " <span class=\"" );
			stream.append ( css_keyword );
			stream.append ( "\">yields</span> " );
		}

		this.write_exception_list ( m, stream );
	}

	public override void write_type_parameter ( TypeParameter param, void* ptr ) {
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		stream.append ( param.name );
	}

	public override void write_template_parameters ( TemplateParameterListHandler thandler, void* ptr ) {
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		int i = 1;

		var lst = thandler.get_template_param_list( );
		if ( lst.size == 0 )
			return ;

		stream.append ( "&lt;" ); // <

		foreach ( TypeParameter param in lst ) {
			param.write ( this, stream );
			if ( lst.size > i )
				stream.append ( ", " );

			i++;
		}
		stream.append ( "&gt;" ); // >
	}

	public override void write_field ( Valadoc.Field field, Valadoc.FieldHandler parent, void* ptr ) {
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		this.position = field;

		this.write_accessor ( field, stream );

		if ( field.is_volatile ) {
			stream.append ( " <span class=\"" );
			stream.append ( css_keyword );
			stream.append ( "\">volatile</span>" );
		}

		this.write_type_reference ( field.type_reference, stream );

		stream.append_unichar ( ' ' );
		stream.append ( field.name );
	}

	public override void write_constant ( Constant constant, ConstantHandler parent, void* ptr ) {
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		this.position = constant;

		this.write_accessor ( constant, stream );
		stream.append ( " <span class=\"" );
		stream.append ( css_keyword );
		stream.append ( "\"> const </span>" );

		this.write_type_reference ( constant.type_reference, stream );

		stream.append_unichar ( ' ' );
		stream.append ( constant.name );
	}

	public override void write_property_accessor ( Valadoc.PropertyAccessor propac, void* ptr ) {
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		Property prop = (Property)propac.parent;

		stream.append ( "<span class=\"" );
		stream.append ( css_keyword );
		stream.append ( "\">" );

		if ( !(prop.is_public == propac.is_public && prop.is_private == propac.is_private && prop.is_protected == propac.is_protected) ) {
			// FIXME: PropertyAccessor isn't a SymbolAccessibility.
			if ( propac.is_public )
				stream.append ( "public " );
			else if ( propac.is_protected )
				stream.append ( "protected " );
			else if ( propac.is_private )
				stream.append ( "private " );
		}

		if (  propac.is_owned )
			stream.append ( "owned " );

		if ( propac.is_get )
			stream.append ( "get" );
		else if ( propac.is_set )
			stream.append ( "set" );

		stream.append ( "</span>; " );
	}

	public override void write_property ( Valadoc.Property prop, void* ptr ) {
		GLib.StringBuilder modifiers = new GLib.StringBuilder ( "" );
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		this.position = prop;


		this.write_accessor ( prop, stream );

		if ( prop.is_virtual ) {
			modifiers.append ( " virtual " );
		}
		else if ( prop.is_abstract ) {
			modifiers.append ( " abstract " );
		}
		else if ( prop.is_override ) {
			modifiers.append ( " override " );
		}

		if ( modifiers.len > 0 ) {
			stream.append ( " <span class=\"" );
			stream.append ( css_keyword );
			stream.append ( "\">" );
			stream.append ( modifiers.str );
			stream.append ( "</span> " );
		}

		this.write_type_reference ( prop.type_reference, stream );
		stream.append_unichar ( ' ' );
		stream.append ( prop.name );
		stream.append ( " { " );

		if ( prop.setter != null )
			this.write_property_accessor ( prop.setter, stream );


		stream.append_unichar ( ' ' );

		if ( prop.getter != null )
			this.write_property_accessor ( prop.getter, stream );

		stream.append ( " }" );
	}

	public override void write_signal ( Valadoc.Signal sig, void* ptr ) {
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		this.position = sig;

		this.write_accessor ( sig, stream );

		stream.append ( " <span class=\"" );
		stream.append ( css_keyword );
		stream.append ( "\">" );

		if ( sig.is_virtual == true )
			stream.append ( "virtual " );

		stream.append ( "signal</span> " );

		this.write_type_reference ( sig.type_reference, stream );
		stream.append_unichar ( ' ' );
		stream.append ( sig.name );
		stream.append_unichar ( ' ' );
		this.write_parameter_list ( sig, stream );
	}

	public override void write_enum_value ( Valadoc.EnumValue enval, void* ptr ) {
	}

	public override void write_error_code ( Valadoc.ErrorCode errcode, void* ptr ) {
	}

	public override void write_delegate ( Valadoc.Delegate del, void* ptr ) {
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		this.position = del;

		this.write_accessor ( del, stream );

		stream.append ( " <span class=\"" );
		stream.append ( css_keyword );
		stream.append ( "\">delegate</span> " );

		this.write_type_reference ( del.type_reference, stream );

		stream.append_unichar ( ' ' );
		stream.append ( del.name );
		stream.append_unichar ( ' ' );
		this.write_parameter_list ( del, stream );
		this.write_exception_list ( del, stream );
	}

	public override void write_enum ( Valadoc.Enum en, void* ptr ) {
	}

	public override void write_error_domain ( Valadoc.ErrorDomain errdom, void* ptr ) {
	}

	private void write_accessor ( Valadoc.SymbolAccessibility element, GLib.StringBuilder stream ) {
		stream.append ( "<span class=\"%s\">public</span> " );
		stream.append ( css_keyword );
		stream.append ( "\">" );

		if ( element.is_public )
			stream.append ( "public" );
		else if ( element.is_protected )
			stream.append ( "protected" );
		else if ( element.is_private )
			stream.append ( "private" );

		stream.append ( "</span> " );
	}

	public override void write_struct ( Valadoc.Struct stru, void* ptr ) {
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		this.position = stru;

		this.write_accessor ( stru, stream );
		stream.append ( "<span class=\"" );
		stream.append ( css_keyword );
		stream.append ( "\">struct</span> " );
		stream.append ( stru.name );

		this.write_template_parameters ( stru, stream );
		this.write_inheritance_list ( stru, stream );
	}

	private void write_inheritance_list ( Valadoc.ContainerDataType dtype, GLib.StringBuilder stream ) {
		Gee.Collection<DataType> lst = dtype.get_parent_types ( );
		int size = lst.size;
		int i = 1;

		if ( size == 0 )
			return ;

		stream.append ( " : " );

		foreach ( DataType cntype in lst ) {
			this.write_type_name ( cntype, stream );
			if ( size > i )
				stream.append ( ", " );

			i++;
		}

		stream.append_unichar ( ' ' );
	}

	public override void write_class ( Valadoc.Class cl, void* ptr ) {
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		this.position = cl;

		this.write_accessor ( cl, stream );

		stream.append ( "<span class=\"" );
		stream.append ( css_keyword );
		stream.append ( "\">" );

		if ( cl.is_abstract )
			stream.append ( "abstract " );

		stream.append ( " class</span> " );
		stream.append ( cl.name );

		this.write_template_parameters ( cl, stream );
		this.write_inheritance_list ( cl, stream );
	}

	public override void write_interface ( Valadoc.Interface iface, void* ptr ) {
		weak GLib.StringBuilder stream = (GLib.StringBuilder)ptr;
		this.position = iface;

		this.write_accessor ( iface, stream );

		stream.append ( "<span class=\"" );
		stream.append ( css_keyword );
		stream.append ( "\">interface</span> " );
		stream.append ( iface.name );

		this.write_template_parameters ( iface, stream );
		this.write_inheritance_list ( iface, stream );
	}

	public override void write_namespace ( Valadoc.Namespace ns, void* ptr ) {
	}

	public override void write_file ( Valadoc.Package file, void* ptr ) {
	}
}









public class Valadoc.HtmlDoclet : Valadoc.Doclet {
	private Gee.HashMap<Object, ulong> ids = new Gee.HashMap<Object, ulong> ();
	private GLib.List<Package> exist = new GLib.List<Package> ();
	private Valadoc.ValadocOrgLanglet langlet;
	private Settings settings;
	private bool run = true;
	private Database mysql;
	private int level;

	private Namespace? get_global_namespace ( Package pkg ) {
		foreach ( Namespace ns in pkg.get_namespace_list() ) {
			if ( ns.name == null ) {
				return ns;
			}
		}
		return null;
	}

	private ulong get_package_id ( Package element ) {
		if ( this.ids.contains ( element ) == true ) {
			return this.ids.get ( element );
		}

		string query = "SELECT `id` FROM `Element` NATURAL JOIN `PackageElement` WHERE `name`='" + element.name + "' LIMIT 1";
		if ( mysql.query ( query ) != 0 ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		Result? res = mysql.store_result ();
		if ( res == null ) {
			return 0;
		}

		weak string[]? row = res.fetch_row ();
		if ( row == null ) {
			return 0;
		}

		ulong id = row[0].to_ulong ();
		Namespace? ns = this.get_global_namespace ( element );
		if ( ns != null ) {
			this.ids.set ( ns, id );
		}

		this.ids.set ( element, id );
		return id;
	}

	private ulong get_type_id ( DocumentedElement element ) {
		if ( this.ids.contains ( element ) == true ) {
			return this.ids.get ( element );
		}


		GLib.Queue<DocumentedElement> stack = new Queue<DocumentedElement> ();

		for ( DocumentedElement pos = element; pos != null ; pos = (DocumentedElement)pos.parent ) {
			stack.push_head ( pos );
		}

		Package pkg = (Package)stack.pop_head ( );
		ulong lastid = this.get_package_id ( pkg );

		foreach ( DocumentedElement pos in stack.head ) {
			if ( this.ids.contains ( pos ) ) {
				lastid = this.ids.get ( pos );
				continue ;
			}

			string query = "SELECT `id` FROM `ChildElement` NATURAL JOIN `Element` WHERE `name`='%s' AND `parentelement`='%lu' LIMIT 1".printf ( pos.name, lastid );
			bool tmp = mysql.query ( query ) == 0;
			if ( tmp == false ) {
				stderr.printf ("ERROR: '%s'\n", mysql.error ());
				return 0;
			}

			Result? res = mysql.store_result ();
			if ( res == null ) {
				stderr.printf ("ERROR: '%s'\n", mysql.error ());
				return 0;
			}

			weak string[]? row = res.fetch_row ();
			if ( row == null ) {
				return 0;
			}

			lastid = row[0].to_ulong ();

			if ( lastid == 0 ) {
				return 0;
			}

			this.ids.set ( pos, lastid );
		}

		return lastid;
	}

	private ulong db_create_element ( DocumentedElement element ) {
		string name = element.name;
		if ( name == null ) {
			// err msg
			return 0;
		}

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `Element` (`name`,`fullname`,`txtid`) VALUES ( '");
		query.append ( name );
		query.append ( "', '" );
		query.append ( element.full_name () );
		query.append ( "', '" );

		if ( element is Package == false ) {
			query.append ( element.package.name );
			query.append_unichar ( '/' );
		}

		query.append ( element.full_name () );
		query.append ( "');" );
		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			// err msg
			return 0;
		}

		ulong id = this.mysql.insert_id ();
		this.ids.set ( element, id );
		return id;
	}

	private ulong db_create_property ( Property element ) {
		ulong id = db_create_element ( element );
		if ( id == 0 ) {
			return 0;
		}

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `PropertyElement` (`id`,`abstract`,`virtual`,`override`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "', '" );
		query.append ( this.db_boolean ( element.is_abstract ) );
		query.append ( "', '" );
		query.append ( this.db_boolean ( element.is_virtual ) );
		query.append ( "', '" );
		query.append ( this.db_boolean ( element.is_override ) );
		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		ulong tmp2 = this.db_create_accessibility ( element );
		if ( tmp2 == 0 )
			return 0;

		tmp = this.db_create_with_api_element ( element );
		if ( tmp == false )
			return 0;

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private ulong db_create_field ( Field element ) {
		ulong id = db_create_element ( element );
		if ( id == 0 )
			return 0;

		bool tmp = mysql.query ( "INSERT INTO `FieldElement` (`id`,`volatile`) VALUES ('%lu','%s');".printf ( id, this.db_boolean ( element.is_volatile ) ) ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		ulong tmp2 = this.db_create_accessibility ( element );
		if ( tmp2 == 0 )
			return 0;

		tmp = this.db_create_with_api_element ( element );
		if ( tmp == false )
			return 0;

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private ulong db_create_constant ( Constant element ) {
		ulong id = db_create_element ( element );
		if ( id == 0 )
			return 0;

		bool tmp = mysql.query ( "INSERT INTO `ConstantElement` (`id`) VALUES ('%lu');".printf ( id ) ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		ulong tmp2 = this.db_create_accessibility ( element );
		if ( tmp2 == 0 )
			return 0;

		tmp = this.db_create_with_api_element ( element );
		if ( tmp == false )
			return 0;

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private bool db_add_child_element ( Basic element ) {
		bool tmp = mysql.query ( "INSERT INTO `ChildElement` (`id`, `parentelement`) VALUES ('%lu', '%lu');".printf ( this.ids.get ( element ), this.ids.get ( element.parent ) ) ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return false;
		}
		return true;
	}

	private ulong db_create_package ( Package element ) {
		ulong id = db_create_element ( element );
		if ( id == 0 )
			return 0;

		bool tmp = mysql.query ( "INSERT INTO `PackageElement` (`id`) VALUES ('%lu');".printf ( id ) ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		return id;
	}

	private ulong db_create_namespace ( Namespace element ) {
		if ( element.name == null ) {
			ulong id = this.get_type_id ( element.package );
			this.ids.set ( element, id );
			return id;
		}

		ulong id = db_create_element ( element );
		if ( id == 0 )
			return 0;


		bool tmp = mysql.query ( "INSERT INTO `NamespaceElement` (`id`) VALUES ('%lu');".printf ( id ) ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private ulong db_create_type ( DocumentedElement element ) {
		ulong id = db_create_element ( element );
		if ( id == 0 )
			return 0;

		bool tmp = mysql.query ( "INSERT INTO `TypeElement` (`id`) VALUES ('%lu');".printf ( id ) ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		tmp = this.db_create_with_api_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private string db_boolean ( bool boolean ) {
		return ( boolean == true )? "1" : "0";
	}

	private bool db_create_class_parent ( Class element ) {
		ContainerDataType parent = element.parent_class;
		if ( parent == null )
			return true;

		ulong id = this.get_type_id ( element );
		ulong pid = this.get_type_id ( parent );

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `ParentClassElement` (`id`, `parent`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "', '" );
		query.append ( pid.to_string() );
		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return false;
		}
		return true;
	}

	private bool db_create_interface_list ( ContainerDataType element ) {
		Gee.Collection<DataType> interfacelist = element.get_parent_types ();
		if ( interfacelist.size == 0 )
			return true;

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `ImplementedInterfaceList` (`id`, `interface`) VALUES ('" );
		query.append ( this.get_type_id ( element ).to_string() );
		query.append ( "', '%lu');" );

		foreach ( DataType type in interfacelist ) {
			if ( type is Valadoc.Interface ) {
				bool tmp = mysql.query ( query.str.printf ( this.get_type_id ( type ) ) ) == 0;
				if ( tmp == false ) {
					stderr.printf ("ERROR: '%s'\n", mysql.error ());
					return false;
				}
			}
		}
		return true;
	}

	private bool db_create_with_image_element ( DocumentedElement element ) {
		string realimgpath = this.settings.path + element.package.name + "/" + element.full_name () + ".png";
		if ( element is Class ) {
			Diagrams.write_class_diagram ( (Class)element, realimgpath );
		}
		else if ( element is Interface ) {
			Diagrams.write_interface_diagram ( (Interface)element, realimgpath );
		}
		else if ( element is Struct ) {
			Diagrams.write_struct_diagram ( (Struct)element, realimgpath );
		}
		return true;
	}

	private bool db_create_with_api_element ( DocumentedElement element ) {
		GLib.StringBuilder stream = new GLib.StringBuilder ();

		if ( element is Class ) {
			((Class)element).write ( this.langlet, stream );
		}
		else if ( element is Interface ) {
			((Interface)element).write ( this.langlet, stream );
		}
		else if ( element is Struct ) {
			((Struct)element).write ( this.langlet, stream );
		}
		else if ( element is Method ) {
			((Method)element).write ( this.langlet, stream, (MethodHandler)element.parent );
		}
		else if ( element is Delegate ) {
			((Delegate)element).write ( this.langlet, stream );
		}
		else if ( element is Signal ) {
			((Signal)element).write ( this.langlet, stream );
		}
		else if ( element is Property ) {
			((Property)element).write ( this.langlet, stream );
		}
		else if ( element is Constant ) {
			((Constant)element).write ( this.langlet, stream, (ConstantHandler)element.parent );
		}
		else if ( element is Field ) {
			((Field)element).write ( this.langlet, stream, (FieldHandler)element.parent );
		}
		else {
			return true;
		}

		unichar[] code = new unichar[stream.len*2+1];
		this.mysql.real_escape_string ( (string)code, stream.str, stream.len );

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `WithApiElement` (`id`, `code`) VALUES ('" );
		query.append ( this.ids.get ( element ).to_string() );
		query.append ( "', '" );
		query.append ( (string)code );
		query.append ( "');" );
		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return false;
		}
		return true;
	}

	private bool db_create_exception_list ( ExceptionHandler element ) {
		Gee.ReadOnlyCollection<DataType> list = element.get_error_domains ();
		if ( list.size == 0 )
			return true;

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `ExceptionList` (`id`, `errordomain`) VALUES ('" );
		query.append ( this.ids.get ( element ).to_string() );
		query.append ( "', '%d');" );

		foreach ( DataType type in list ) {
			bool tmp = mysql.query ( query.str.printf ( this.get_type_id ( type ) ) ) == 0;
			if ( tmp == false ) {
				stderr.printf ("ERROR: '%s'\n", mysql.error ());
				return false;
			}
		}
		return true;
	}
	
	private ulong db_create_accessibility ( SymbolAccessibility element ) {
		ulong id = this.ids.get ( element );

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `AccessibilityElement` (`id`,`accessibility`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "', '" );

		if ( element.is_protected )
			query.append ( "PROTECTED" );
		else if ( element.is_private )
			query.append ( "PRIVATE" );
		else if ( element.is_public )
			query.append ( "PUBLIC" );

		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		return id;
	}

	private ulong db_create_class ( Class element ) {
		ulong id = this.db_create_type ( element );
		if ( id == 0 )
			return 0;

		id = this.db_create_accessibility ( element );
		if ( id == 0 )
			return 0;

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `ClassElement` (`id`,`abstract`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "', '" );
		query.append ( this.db_boolean ( element.is_abstract ) );
		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		tmp = this.db_create_with_image_element ( element );
		if ( tmp == false )
			return 0;

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private ulong db_create_enum ( Enum element ) {
		ulong id = db_create_type ( element );
		if ( id == 0 )
			return 0;

		id = db_create_accessibility ( element );
		if ( id == 0 )
			return 0;

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `EnumElement` (`id`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private ulong db_create_errordomain ( ErrorDomain element ) {
		ulong id = db_create_type ( element );
		if ( id == 0 )
			return 0;

		id = db_create_accessibility ( element );
		if ( id == 0 )
			return 0;

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `ErrordomainElement` (`id`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private ulong db_create_enumvalue ( EnumValue element ) {
		ulong id = db_create_element ( element );
		if ( id == 0 )
			return 0;

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `EnumValueElement` (`id`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private ulong db_create_errorcode ( ErrorCode element ) {
		ulong id = db_create_element ( element );
		if ( id == 0 )
			return 0;

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `ErrorCodeElement` (`id`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private ulong db_create_interface ( Interface element ) {
		ulong id = db_create_type ( element );
		if ( id == 0 )
			return 0;

		id = db_create_accessibility ( element );
		if ( id == 0 )
			return 0;

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `InterfaceElement` (`id`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		tmp = this.db_create_with_image_element ( element );
		if ( tmp == false )
			return 0;

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private ulong db_create_delegate ( Delegate element ) {
		ulong id = db_create_type ( element );
		if ( id == 0 )
			return 0;

		id = db_create_accessibility ( element );
		if ( id == 0 )
			return 0;

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `DelegateElement` (`id`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private ulong db_create_method ( Method element ) {
		ulong id = db_create_type ( element );
		if ( id == 0 )
			return 0;

		id = db_create_accessibility ( element );
		if ( id == 0 )
			return 0;

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `MethodElement` (`id`, `yields`, `abstract`, `virtual`, `override`, `static`, `inline`, `constructor`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "', '" );
		query.append ( this.db_boolean ( element.is_yields ) );
		query.append ( "', '" );
		query.append ( this.db_boolean ( element.is_abstract ) );
		query.append ( "', '" );
		query.append ( this.db_boolean ( element.is_virtual ) );
		query.append ( "', '" );
		query.append ( this.db_boolean ( element.is_override ) );
		query.append ( "', '" );
		query.append ( this.db_boolean ( element.is_static ) );
		query.append ( "', '" );
		query.append ( this.db_boolean ( element.is_inline ) );
		query.append ( "', '" );
		query.append ( this.db_boolean ( element.is_constructor ) );
		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		tmp = this.db_create_with_api_element ( element );
		if ( tmp == false )
			return 0;

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private ulong db_create_signal ( Signal element ) {
		ulong id = db_create_type ( element );
		if ( id == 0 )
			return 0;

		id = db_create_accessibility ( element );
		if ( id == 0 )
			return 0;

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `SignalElement` (`id`, `virtual`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "', '" );
		query.append ( this.db_boolean ( element.is_virtual ) );
		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		tmp = this.db_create_with_api_element ( element );
		if ( tmp == false )
			return 0;

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private ulong db_create_struct ( Struct element ) {
		ulong id = db_create_type ( element );
		if ( id == 0 )
			return 0;

		id = db_create_accessibility ( element );
		if ( id == 0 )
			return 0;

		GLib.StringBuilder query = new GLib.StringBuilder ( "INSERT INTO `StructElement` (`id`) VALUES ('" );
		query.append ( id.to_string() );
		query.append ( "');" );

		bool tmp = mysql.query ( query.str ) == 0;
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return 0;
		}

		tmp = this.db_create_with_image_element ( element );
		if ( tmp == false )
			return 0;

		tmp = this.db_add_child_element ( element );
		if ( tmp == false )
			return 0;

		return id;
	}

	private string getline ( ) {
		GLib.StringBuilder str = new GLib.StringBuilder ( );

		for ( int c = stdin.getc (); c != '\n' ; c = stdin.getc () ) {
			str.append_c ( (char)c );
		}
		return str.str;
	}	

	public override void initialisation ( Settings settings, Tree tree ) {
		this.langlet = new Valadoc.ValadocOrgLanglet ( settings );
		this.settings = settings;

		this.mysql = new Database ();
		mysql.init ();

		DirUtils.create ( this.settings.path, 0777 );


		stdout.puts ( "host: " );
		string host = this.getline ( );

		stdout.puts ( "user: " );
		string usr = this.getline ( );

		stdout.puts ( "password: " );
		string pw = this.getline ( );

		stdout.puts ( "database: " );
		string db = this.getline ( );

		bool tmp = mysql.real_connect (host, usr, pw, db, 0, null, 0);
		if ( tmp == false ) {
			stderr.printf ("ERROR: '%s'\n", mysql.error ());
			return;
		}

		Gee.ReadOnlyCollection<Package> packages = tree.get_package_list ();
		this.level = 0;

		foreach ( Package pkg in packages ) {
			pkg.visit ( this );
		}

		this.level = 1;

		foreach ( Package pkg in packages ) {
			if ( this.run == false ) {
				break;
			}

			pkg.visit ( this );
		}
	}

	public override void visit_package ( Package pkg ) {
		if ( this.level == 0 ) {
			ulong id = this.get_package_id ( pkg );
			if ( id > 0 ) {
				this.exist.append ( pkg );
				return ;
			}

			DirUtils.create ( this.settings.path + pkg.name, 0777 );

			id = this.db_create_package ( pkg );
			if ( id == 0 ) {
				this.run = false;
				return ;
			}

			pkg.visit_namespaces ( this );
		}
		else if ( this.exist.find ( pkg ) == null ) {
			pkg.visit_namespaces ( this );
		}
	}

	public override void visit_namespace ( Namespace ns ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 0 ) {
			ulong id = this.db_create_namespace ( ns );
			if ( id == 0 ) {
				this.run = false;
				return ;
			}

			ns.visit_namespaces ( this );
			ns.visit_classes ( this );
			ns.visit_interfaces ( this );
			ns.visit_structs ( this );
			ns.visit_enums ( this );
			ns.visit_error_domains ( this );
			ns.visit_delegates ( this );
		}
		else {
			ns.visit_namespaces ( this );
			ns.visit_classes ( this );
			ns.visit_interfaces ( this );
			ns.visit_structs ( this );
			ns.visit_enums ( this );
			ns.visit_error_domains ( this );
			ns.visit_delegates ( this );
			ns.visit_methods ( this );
			ns.visit_fields ( this );
			ns.visit_constants ( this );
		}
	}

	//TODO: parent list
	public override void visit_interface ( Interface iface ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 0 ) {
			ulong id = this.db_create_interface ( iface );
			if ( id == 0 ) {
				this.run = false;
				return ;
			}

			iface.visit_classes ( this );
			iface.visit_structs ( this );
			iface.visit_delegates ( this );
		}
		else {
			bool tmp = this.db_create_interface_list ( iface );
			if ( tmp == false ) {
				this.run = false;
				return ;
			}

			iface.visit_methods ( this );
			iface.visit_signals ( this );
			iface.visit_properties ( this );
			iface.visit_fields ( this );
			iface.visit_classes ( this );
			iface.visit_structs ( this );
			iface.visit_delegates ( this );
		}
	}

	public override void visit_class ( Class cl ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 0 ) {
			ulong id = this.db_create_class ( cl );
			if ( id == 0 ) {
				this.run = false;
				return ;
			}

			cl.visit_classes ( this );
			cl.visit_structs ( this );
			cl.visit_enums ( this );
			cl.visit_delegates ( this );
		}
		else {
			bool tmp = this.db_create_interface_list ( cl );
			if ( tmp == false ) {
				this.run = false;
				return ;
			}

			tmp = this.db_create_class_parent ( cl );
			if ( tmp == false ) {
				this.run = false;
				return ;
			}

			cl.visit_construction_methods ( this );
			cl.visit_methods ( this );
			cl.visit_signals ( this );
			cl.visit_properties ( this );
			cl.visit_fields ( this );
			cl.visit_constants ( this );
			cl.visit_classes ( this );
			cl.visit_structs ( this );
			cl.visit_enums ( this );
			cl.visit_delegates ( this );
		}
	}

	//TODO: parent list
	public override void visit_struct ( Struct stru ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 0 ) {
			ulong id = this.db_create_struct ( stru );
			if ( id == 0 ) {
				this.run = false;
			}
		}
		else {
			stru.visit_construction_methods ( this );
			stru.visit_methods ( this );
			stru.visit_fields ( this );
			stru.visit_constants ( this );
		}
	}

	public override void visit_error_domain ( ErrorDomain errdom ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 0 ) {
			ulong id = this.db_create_errordomain ( errdom );
			if ( id == 0 ) {
				this.run = false;
				return ;
			}

			errdom.visit_error_codes ( this );
		}
		else {
			errdom.visit_methods ( this );
		}
	}

	public override void visit_enum ( Enum en ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 0 ) {
			ulong id = this.db_create_enum ( en );
			if ( id == 0 ) {
				this.run = false;
				return ;
			}

			en.visit_enum_values ( this );
		}
		else {
			en.visit_methods ( this );
		}
	}

	public override void visit_property ( Property prop ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 1 ) {
			ulong id = this.db_create_property ( prop );
			if ( id == 0 )
				this.run = false;
		}
	}

	public override void visit_constant ( Constant constant, ConstantHandler parent ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 1 ) {
			ulong id = this.db_create_constant ( constant );
			if ( id == 0 )
				this.run = false;
		}
	}

	public override void visit_field ( Field field, FieldHandler parent ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 1 ) {
			ulong id = this.db_create_field ( field );
			if ( id == 0 )
				this.run = false;
		}
	}

	public override void visit_error_code ( ErrorCode errcode ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 0 ) {
			ulong id = this.db_create_errorcode ( errcode );
			if ( id == 0 )
				this.run = false;
		}
	}

	public override void visit_enum_value ( EnumValue enval ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 0 ) {
			ulong id = this.db_create_enumvalue ( enval );
			if ( id == 0 )
				this.run = false;
		}
	}

	public override void visit_delegate ( Delegate del ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 0 ) {
			ulong id = this.db_create_delegate ( del );
			if ( id == 0 )
				this.run = false;
		}
		else {
			bool tmp = this.db_create_exception_list ( del );
			if ( tmp == false )
				this.run = false;
		}
	}

	//TODO: exception list
	public override void visit_signal ( Signal sig ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 1 ) {
			ulong id = this.db_create_signal ( sig );
			if ( id == 0 )
				this.run = false;
		}
	}

	public override void visit_method ( Method m, Valadoc.MethodHandler parent ) {
		if ( this.run == false ) {
			return ;
		}

		if ( this.level == 1 ) {
			ulong id = this.db_create_method ( m );
			if ( id == 0 )
				this.run = false;
		}
		else {
			bool tmp = this.db_create_exception_list ( m );
			if ( tmp == false )
				this.run = false;
		}
	}

	public override void cleanups ( ) {
	}
}





[ModuleInit]
public Type register_plugin ( ) {
	return typeof ( Valadoc.HtmlDoclet );
}

