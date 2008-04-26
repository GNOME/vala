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


public enum WriterState {
	KEY,
	STANDARD,
	NULL
}



public class Valadoc.LangletIndex : Valadoc.Langlet, Valadoc.LinkHelper {
	private StringBuilder write_buffer = new StringBuilder ( "" );
	private WriterState wstate = WriterState.NULL;

	private ulong name_len = 0;

	private int space_width = 4;
	private int acess_area = 10;
	private int typeref_area = 20;
	private int name_area = 25;

	public bool with_link {
		get;
		set;
	}

	public LangletIndex ( Settings settings ) {
		this.settings = settings;
	}

	public Settings settings {
		construct set;
		get;
	}

	construct {
		this.with_link = false;

		this.puts_keyword += ( @this, ptr, str ) => {
			((FileStream)ptr).puts ( "<i>" );
			((FileStream)ptr).puts ( str );
			((FileStream)ptr).puts ( "</i>" );
		};

		this.puts += ( @this, ptr, str ) => {
			((FileStream)ptr).puts ( str );
		};
	}

	protected void writer_flush ( void* ptr ) {
		if ( this.wstate == WriterState.STANDARD )
			this.puts ( ptr, this.write_buffer.str );
		else if ( this.wstate == WriterState.KEY )
			this.puts_keyword ( ptr, this.write_buffer.str );

		this.write_buffer.erase ( 0, -1 );
	}

	protected void write_keywrd ( void* ptr, string str ) {
		if ( wstate == WriterState.STANDARD ) {
			if ( write_buffer.str != "" )
				this.puts ( ptr, this.write_buffer.str );
				this.write_buffer.erase ( 0, -1 );
		}

		this.write_buffer.append ( str );
		wstate = WriterState.KEY;
	}

	protected void write ( void* ptr, string str ) {
		if ( wstate == WriterState.KEY ) {
			if ( write_buffer.str != "" )
				this.puts_keyword ( ptr, this.write_buffer.str );
				this.write_buffer.erase ( 0, -1 );
		}

		this.write_buffer.append ( str );
		wstate = WriterState.STANDARD;
	}

	private void write_name ( void* ptr, Valadoc.Basic type ) {
		long len = this.name_area - type.name.len ();
		if ( len < 0 ) {
			this.name_len += this.name_area + len;
			len = 0;
		}
		else {
			this.name_len += this.name_area;
		}

		if ( this.with_link )
			this.write ( ptr, "<a href=\"#%s\">%s</a>".printf( this.get_mark_name ( type ), type.name ) );
		else
			this.write ( ptr, type.name );

		this.name_len += type.name.len();
		this.write ( ptr, string.nfill ( len, ' ' ) );
	}

	private void write_ident ( void* ptr, uint rank_lvl ) {
		uint ident = this.space_width * rank_lvl;
		this.write ( ptr, string.nfill( ident, ' ' ) );
		this.name_len = ident;
	}

	private void write_accessibility ( Valadoc.SymbolAccessibility bs, void* ptr ) {
		var str = new StringBuilder ( "" );
		if ( bs.is_public )
			str.append ( "public   " );
		else if ( bs.is_protected )
			str.append ( "protected" );
		else if ( bs.is_private )
			str.append ( "private  " );

		long ln = this.acess_area - str.str.len();
		ln = ( ln < 0 )? 0 : ln;
		str.append ( string.nfill( ln,' ' ) );

		this.write_keywrd ( ptr, str.str );
		this.name_len += ln + 3;
	}

	public override void write_type_parameter ( TypeParameter param, void* ptr ) {
		this.write ( ptr, param.datatype_name );
	}

	public override void write_template_parameters ( TemplateParameterListHandler thandler, void* ptr ) {
		var lst = thandler.get_template_param_list( );
		if ( ((Gee.Collection)lst).size == 0 )
			return ;

		this.write ( ptr, " < " );

		int i = 1;

		foreach ( TypeParameter param in lst ) {
			param.write ( this, ptr );
			if ( ((Gee.Collection)lst).size > i )
				this.write ( ptr, ", " );
			i++;
		}
		this.write ( ptr, " > " );
	}

	public void write_parent_type_list ( Valadoc.ContainerDataType dtype, void* ptr ) {
		var lst = dtype.get_parent_types ( );
		int size = lst.size;
		int i = 1;

		if ( size == 0 )
			return ;

		this.write ( ptr, " : " );
		foreach ( DataType cntype in lst ) {
			string link = this.get_link ( cntype );
			string str;

			if ( link == null ) {
				str = cntype.name;
			}
			else
				str = "<a href=\"%s\">%s</a>".printf( link, cntype.name );

			this.write ( ptr, str );

			if ( size > i )
				this.write ( ptr, ", " );

			i++;
		}

		this.write ( ptr, " " );
	}

	private void write_error_domain_list ( ExceptionHandler exhandler, void* ptr ) {
		var tmp = this.space_width + this.acess_area + this.typeref_area + this.name_area + 9;
		var str = string.nfill ( tmp, ' ' );

		long space = 0;
		int i = 1;

		var lst = exhandler.get_error_domains ( );
		if ( ((Gee.Collection)lst).size == 0 )
			return ;


		this.write ( ptr, "\n" );
		this.write ( ptr, str.offset ( 7 ) );
		this.write_keywrd ( ptr, "throws " );

		foreach ( TypeReference tref in lst ) {
			if ( i != 1 )
				this.write ( ptr, str );

			this.write_nested_type_reference ( tref, ptr, out space );

			if ( ((Gee.Collection)lst).size > i )
				this.write ( ptr, ",\n" );
			i++;
		}
	}

	public override void write_parameter_list ( ParameterListHandler thandler, void* ptr ) {
		var tmp = this.space_width + this.acess_area + this.typeref_area + this.name_area + 9;

		string margin = string.nfill ( tmp, ' ' );
		string open_bracket = " ( ";
		this.write ( ptr, open_bracket );
		this.name_len += open_bracket.len();

		var lst = thandler.get_parameter_list ( );
		var it  = lst.iterator ( );
		bool last ;

		for ( int i = 1; last = it.next(); i++ ) {
			FormalParameter fp = it.get ();
			fp.write ( this, ptr );

			if ( i < ((Gee.Collection)lst).size ) {
				this.write ( ptr, ",\n" );
				this.write ( ptr, margin );
			}
		}

		this.write ( ptr, " ) " );
		this.writer_flush ( ptr );
	}

	public override void write_field ( Valadoc.Field field, Valadoc.FieldHandler parent, void* ptr ) {
		this.name_len = 0;
		this.write_ident ( ptr, field.bracket_level );

		this.write_accessibility ( field, ptr );
		this.write_type_reference ( field.type_reference, ptr );

		if ( field.parent != parent ) {
			if ( parent is Class ) {
				if ( ((Class)parent).is_double_field ( field ) ) {
					this.write ( ptr, "(" );
					this.write ( ptr, field.parent.name );
					this.write ( ptr, ")" );
				}
			}
		}


		if ( with_link )
			this.write ( ptr, "<a href=\"#%s\">%s</a>".printf( this.get_mark_name ( field ), field.name ) );
		else
			this.write ( ptr, field.name );

		this.write ( ptr, " ;" );
		this.writer_flush ( ptr );
	}

	private void write_type_reference_keywords ( Valadoc.TypeReference tref, void* ptr, out long strlen ) {
		if ( tref.is_weak ) {
			string str = "weak ";
			this.write_keywrd ( ptr, str );
			strlen += str.len ();
		}
	}

	private string write_type_reference_name_helper ( Valadoc.TypeReference tref, out long strlen ) {
		string typensname = tref.data_type.nspace.name;
		string nsname = tref.nspace.name;
		StringBuilder str = new StringBuilder ( "" );

		if ( !( typensname == null || nsname == null ) ) {
			if ( typensname != nsname ) {
				str.append ( typensname );
				str.append_unichar ( '.' );
				strlen += typensname.len();
				strlen++;
			}
		}
		str.append ( tref.type_name );
		strlen += tref.type_name.len();
		return str.str;
	}

	private void write_type_reference_name ( Valadoc.TypeReference tref, void* ptr, out long strlen ) {
		if ( tref.type_name == "void" ) {
			string str = "void ";
			this.write_keywrd ( ptr, str );
			strlen += str.len();
		}
		else {
			StringBuilder str = new StringBuilder ( "" );

			if ( tref.data_type != null ) {
				string link = this.get_link ( tref.data_type );
				if ( link == null ) {
					str.append ( this.write_type_reference_name_helper( tref, out strlen ) );
				}
				else {
					str.append ( "<a href=\"%s\">".printf( link ) );
					str.append ( this.write_type_reference_name_helper( tref, out strlen ) );
					str.append ( "</a>" );
				}
			}
			else {
				str.append ( tref.type_name );
				strlen += str.str.len();
			}

			this.write ( ptr, str.str );
			str = null;

			this.write_type_reference_template_arguments ( tref, ptr, out strlen );
		}
	}

	private void write_type_reference_template_arguments ( Valadoc.TypeReference tref, void* ptr, out long strlen ) {
		var arglst = tref.get_type_arguments ( );
		if ( ((Gee.Collection)arglst).size != 0 ) {
			string open_lst = "< ";
			this.write ( ptr, open_lst );
			foreach ( TypeReference arg in arglst ) {
				this.write_nested_type_reference ( arg, ptr, out strlen );
				this.write ( ptr, " " );
				strlen++;
			}
			string close_lst = ">";
			this.write ( ptr, close_lst );
			strlen += open_lst.len() + close_lst.len();
		}
	}

	// rename to something more common
	private void write_nested_type_reference ( Valadoc.TypeReference tref, void* ptr, out long strlen ) {
		if ( tref.type_name == null )
			return ;

		this.write_type_reference_keywords ( tref, ptr, out strlen );
		this.write_type_reference_name ( tref, ptr, out strlen );

		if ( tref.is_nullable ) {
			this.write ( ptr, "?" );
			strlen++;
		}

		if ( tref.pass_ownership ) {
			this.write ( ptr, "#" );
			strlen++;
		}

		if ( tref.is_array ) {
			var str = new StringBuilder ( "[" );
			for ( uint i = 0 ; i < tref.array_rank - 1 ; i++ ) {
				str.append (",");
			}
			str.append ("]");
			this.write ( ptr, str.str );
			strlen += str.str.len();
		}

		this.write ( ptr, string.nfill ( tref.pointer_rank, '*' ) );
		strlen += tref.pointer_rank;

		this.writer_flush ( ptr );
	}

	public override void write_type_reference ( Valadoc.TypeReference tref, void* ptr ) {
		long strlen = 0;

		if ( tref.type_name == null )
			return ;


		this.write_nested_type_reference ( tref, ptr, out strlen );


		this.write ( ptr, " " );
		strlen++;


		long space = this.space_width + this.acess_area + this.typeref_area - strlen - (long)this.name_len;
		space = ( space > 0 )? space : 1;
		this.write ( ptr, string.nfill ( space, ' ' ) );
		this.name_len += space;

		this.writer_flush ( ptr );
	}

	private inline void write_formal_parameter_keywords ( Valadoc.FormalParameter param, void* ptr, out long strlen ) {
		if ( param.is_construct ) {
			this.write_keywrd ( ptr, "construct " );
		}

		if ( param.is_ref ) {
			string str = "ref ";
			this.write_keywrd ( ptr, str );
			strlen += str.len ();
		}
		else if ( param.is_out ) {
			string str = "out ";
			this.write_keywrd ( ptr, str );
			strlen += str.len ();
		}
	}

	public override void write_formal_parameter ( Valadoc.FormalParameter param, void* ptr ) {
		if ( param.ellipsis ) {
			this.write ( ptr, "..." );
			return ;
		}

		long len = 0;
		this.write_formal_parameter_keywords ( param, ptr, out len );

		if ( param.type_reference != null ) {
			//this.write_type_return_type ( param.return_type, ptr );
			this.write_nested_type_reference ( param.type_reference, ptr, out len );
			len = ( len > this.typeref_area )? 1 : this.typeref_area - len;
			this.write ( ptr, string.nfill( len, ' ' ) );
			this.name_len += len;
		}

		this.write ( ptr, param.name );
		if ( param.default_value != null )
			this.write ( ptr, " = " + param.default_value );

		this.writer_flush ( ptr );
	}

	public override void write_property_accessor ( Valadoc.PropertyAccessor propac, void* ptr ) {
		if ( propac.is_private && !propac.parent.is_private ) {
			this.write_keywrd ( ptr, " private" );
		}
		else if ( propac.is_protected && !propac.parent.is_protected ) {
			this.write_keywrd ( ptr, " protected" );
		}
		else if ( propac.is_public && !propac.parent.is_public ) {
			this.write_keywrd ( ptr, " public" );
		}

		if ( propac.is_construct ) {
			string str = " construct";
			this.write_keywrd ( ptr, str );
		}

		if ( propac.is_set ) {
			string str = " set";
			string str2 = ";";
			this.write_keywrd ( ptr, str );
			this.write ( ptr, str2 );
		}
		else if ( propac.is_get ) {
			string str = " get";
			string str2 = ";";
			this.write_keywrd ( ptr, str );
			this.write ( ptr, str2 );
		}
	}

	public override void write_property ( Valadoc.Property prop, void* ptr ) {
		this.name_len = 0;
		this.write_ident ( ptr, prop.bracket_level );

		this.write_accessibility ( prop, ptr );

		this.write_type_reference ( prop.return_type, ptr );

		this.write_name ( ptr, prop );

		this.write ( ptr, " {" );

		if ( prop.getter != null )
			prop.getter.write ( this, ptr );

		if ( prop.setter != null )
			prop.setter.write ( this, ptr );

		this.write ( ptr, " } ;" );
		this.writer_flush ( ptr );
	}

	public override void write_signal ( Valadoc.Signal sig, void* ptr ) {
		this.name_len = 0;
		this.write_ident ( ptr, sig.bracket_level );
		this.write_accessibility ( sig, ptr );

		string strsig = "signal ";
		this.write_keywrd ( ptr, strsig );
		this.name_len += strsig.len();

		this.write_type_reference ( sig.return_type, ptr );
		this.write_name ( ptr, sig );
		this.write_parameter_list ( sig, ptr );
		this.write ( ptr, " ;" );
		this.writer_flush ( ptr );
	}

	public override void write_method ( void* ptr, weak Valadoc.Method m, Valadoc.MethodHandler parent ) {
		this.name_len = 0;
		this.write_ident ( ptr, m.bracket_level );
		this.write_accessibility ( m, ptr );

		if ( m.is_abstract ) {
			string str = "abstract ";
			this.write_keywrd ( ptr, str );
			this.name_len += str.len();
		}

		if ( m.is_virtual ) {
			string str = "virtual ";
			this.write_keywrd ( ptr, str );
			this.name_len += str.len();
		}
		else if ( m.is_override ) {
			string str = "override ";
			this.write_keywrd ( ptr, str );
			this.name_len += str.len();
		}

		if ( m.is_static && !m.is_constructor ) {
			string str = "static ";
			this.write_keywrd ( ptr, str );
			this.name_len += str.len();
		}

		if ( m.is_constructor ) {
			long space = this.space_width + this.acess_area + this.typeref_area - (long)this.name_len;
			space = ( space > 0 )? space : 1;
			this.write ( ptr, string.nfill ( space, ' ' ) );
		}
		else
			this.write_type_reference ( m.return_type, ptr );

		if ( m.parent != parent ) {
			if ( parent is Class ) {
				if ( ((ContainerDataType)parent).is_double_method ( m ) ) {
					var str = "(%s)".printf( m.parent.name );
					this.name_len += str.len();
					this.write ( ptr, str );
				}
			}
		}

		this.write_name ( ptr, m );

		this.write_template_parameters ( m, ptr );
		this.write_parameter_list ( m, ptr );
		this.write_error_domain_list ( m, ptr );
		this.write ( ptr, ";" );
		this.writer_flush ( ptr );
	}

	public override void write_enum_value ( Valadoc.EnumValue enval, void* ptr ) {
		this.name_len = 0;
		this.write_ident ( ptr, enval.bracket_level );

		this.write ( ptr, enval.name );
		this.write ( ptr, "," );
		this.writer_flush ( ptr );
	}

	public override void write_error_code ( Valadoc.ErrorCode errcode, void* ptr ) {
		this.name_len = 0;
		this.write_ident ( ptr, errcode.bracket_level );

		this.write ( ptr, errcode.name );
		this.write ( ptr, "," );
		this.writer_flush ( ptr );
	}

	public override void write_delegate ( Valadoc.Delegate del, void* ptr ) {
		this.name_len = 0;
		this.write_ident ( ptr, del.bracket_level );

		this.write_accessibility ( del, ptr );

		if ( del.is_static ) {
			string str = "static ";
			this.write_keywrd ( ptr, str );
			this.name_len += str.len();
		}

		string strkey = "delegate ";
		this.write_keywrd ( ptr, strkey );
		this.name_len += strkey.len();

		this.write_type_reference ( del.return_type, ptr );

		this.write_name ( ptr, del );

		this.write_template_parameters ( del, ptr );
		this.write_parameter_list ( del, ptr );
		this.write ( ptr, " ;" );
		this.writer_flush ( ptr );
	}

	public override void write_class ( Valadoc.Class cl, void* ptr ) {
		this.name_len = 0;
		this.write_ident ( ptr, cl.bracket_level );

		this.write_keywrd ( ptr, cl.accessibility_str );

		if ( cl.is_abstract )
			this.write_keywrd ( ptr, " abstract" );

		this.write_keywrd ( ptr, " class " );
		this.write ( ptr, cl.name );
		this.write_template_parameters ( cl, ptr );
		this.write_parent_type_list ( cl, ptr );
		this.writer_flush ( ptr );
	}

	public override void write_enum ( Valadoc.Enum en, void* ptr ) {
		this.name_len = 0;
		this.write_ident ( ptr, en.bracket_level );

		this.write_keywrd ( ptr, en.accessibility_str );
		this.write_keywrd ( ptr, " enum " );
		this.write ( ptr, en.name );
		this.writer_flush ( ptr );
	}

	public override void write_error_domain ( Valadoc.ErrorDomain errdom, void* ptr ) {
		this.name_len = 0;
		this.write_ident ( ptr, errdom.bracket_level );

		this.write_keywrd ( ptr, errdom.accessibility_str );
		this.write_keywrd ( ptr, " errordomain " );
		this.write ( ptr, errdom.name );
		this.writer_flush ( ptr );
	}

	public override void write_struct ( Valadoc.Struct stru, void* ptr ) {
		this.name_len = 0;
		this.write_ident ( ptr, stru.bracket_level );

		this.write_keywrd ( ptr, stru.accessibility_str );
		this.write_keywrd ( ptr, " struct " );
		this.write ( ptr, stru.name );
		this.write_template_parameters ( stru, ptr );
		this.writer_flush ( ptr );
	}

	public override void write_interface ( Valadoc.Interface iface, void* ptr ) {
		this.name_len = 0;
		this.write_ident ( ptr, iface.bracket_level );

		this.write_keywrd ( ptr, iface.accessibility_str );
		this.write_keywrd ( ptr, " interface " );
		this.write ( ptr, iface.name );
		this.write_template_parameters ( iface, ptr );
		this.writer_flush ( ptr );
	}

	public override void write_namespace ( Valadoc.Namespace ns, void* ptr ) {
		this.write_keywrd ( ptr, ns.accessibility_str );
		this.write_keywrd ( ptr, " namespace " );
		this.write ( ptr, ns.name );
		this.write ( ptr, " ;" );
		this.writer_flush ( ptr );
	}

	public override void write_file ( Valadoc.File file, void* ptr ) {
//		this.writer_flush ( ptr );
	}
}


