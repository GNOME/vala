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





public enum CommentContext {
	STRUCT 					=	1 << 1,
	METHOD 					=	1 << 2,
	CREATION_METHOD = 1 << 3,
	ENUM_VALUE 			= 1 << 4,
	DELEGATE 				= 1 << 5,
	SIGNAL 					= 1 << 6,
	VARIABLE 				= 1 << 7,
	PROPERTY				=	1 << 8,
	CLASS 					= 1 << 9,
	ENUM 						= 1 << 10,
	INTERFACE 			= 1 << 11,
	NAMESPACE				= 1 << 12,
	SOURCEFILE			= 1 << 13,
	ALL							= long.MAX
}





public class CommentParser : Object {
	private Gee.HashMap<string, Valadoc.TagletCreator> entries
		= new Gee.HashMap<string, Valadoc.TagletCreator>(GLib.str_hash, GLib.str_equal);
	private Gee.ArrayList<Valadoc.BasicTaglet> tree = new Gee.ArrayList<Valadoc.BasicTaglet>();
	private CommentContext context;
	private Valadoc.Basic element;
	private StringBuilder comment;

	private Valadoc.ErrorReporter err;	
	private Valadoc.Tree doctree;


	construct {
		this.entries.set ( "", (Valadoc.TagletCreator)Valadoc.GlobalTaglet.create );
		this.entries.set ( "see", (Valadoc.TagletCreator)Valadoc.SeeTaglet.create );
		this.entries.set ( "link", (Valadoc.TagletCreator)Valadoc.LinkTaglet.create );
		this.entries.set ( "param", (Valadoc.TagletCreator)Valadoc.ParameterTaglet.create );
		this.entries.set ( "return", (Valadoc.TagletCreator)Valadoc.ReturnTaglet.create );
		this.entries.set ( "throws", (Valadoc.TagletCreator)Valadoc.ExceptionTaglet.create );
		//this.entries.set ( "version", (Valadoc.TagletCreator)Valadoc.VersionTaglet.create );
	}

	public Valadoc.Settings settings {
		construct set;
		get;
	}

	public Gee.Collection<Valadoc.BasicTaglet> comment_tree {
		get {
			return this.tree;
		}
	}

	private Gee.Collection< Gee.Collection<Valadoc.MainTaglet> > sort_collection (
		Gee.Collection< Gee.ArrayList<Valadoc.BasicTaglet> > lst2 )
	{
		bool switched;

		var lst = new Gee.ArrayList< Gee.ArrayList<Valadoc.MainTaglet> > ();
		foreach ( Gee.ArrayList<Valadoc.BasicTaglet> taglst in lst2 )
			lst.add ( (Gee.ArrayList<Valadoc.MainTaglet>)taglst );

		do {
			switched = false;
			int i = 0;

			for ( i = 0; i < ((Gee.Collection)lst).size-1 ; i++ ) {
				Gee.ArrayList<Valadoc.MainTaglet> sublst = lst.get (i);
				Gee.ArrayList<Valadoc.MainTaglet> nsublst = lst.get(i+1);

				Valadoc.MainTaglet tag = sublst.get(0);
				Valadoc.MainTaglet ntag = nsublst.get(0);

				if ( tag.indenture_number > ntag.indenture_number ) {
					lst.remove ( sublst );
					lst.insert ( i+1, sublst );
					switched = true;
				}
			}
			i --;
		} while ( switched );
		return lst;
	}

	public void write ( void* file ) {
		var entries = new Gee.HashMap<Type, Gee.ArrayList<Valadoc.MainTaglet> >( GLib.direct_hash, GLib.direct_equal );

		foreach ( Valadoc.BasicTaglet tag in this.tree ) {
			Type id = ((Valadoc.MainTaglet)tag).get_type();
			if ( entries.contains( id ) ) {
				var lst = entries.get ( id );
				lst.add ( ((Valadoc.MainTaglet)tag) );
			}
			else {
				var arlst = new Gee.ArrayList<Valadoc.MainTaglet> ();
				arlst.add ( tag );
				entries.set ( id, arlst );
			}
		}

		Gee.Collection< Gee.ArrayList<Valadoc.MainTaglet> > slst = this.sort_collection ( entries.get_values() );
//		var slst = entries.get_values();

		foreach ( Gee.ArrayList<Valadoc.MainTaglet> lst in slst ) {
			int i = 0;
			foreach ( Valadoc.MainTaglet tag in lst ) {
				i++;

				if ( i == 1 )
					tag.start_block ( file );

				tag.write ( file );

				if ( ((Gee.Collection)lst).size <= i )
					tag.end_block ( file );
			}
		}
	}

	private Valadoc.BasicTaglet get_taglet ( string name ) {
		Valadoc.TagletCreator creator = this.entries.get ( name );
		if ( creator == null )
			return null;
		else
			return creator( this.doctree, this.element, this.err, this.settings );
	}

	public static bool is_comment_string ( string str ) {
		if ( str == null )
			return false;

		return ( str[0] == '*' )? true : false;
	}

	protected static bool is_inherit_doc ( string cmnt ) {
		bool ret;
		try {
			var regexp = new Regex (  "^[\\s\\*\n]*{[\\s\n]*@inheritDoc[\\s\n]*}[\\s\n\\*]*$" );
			ret = regexp.match ( cmnt );
		}
		catch ( RegexError err ) {
			return false;
		}
		return ret;
	}

	public Valadoc.BasicTaglet create_taglet ( string name,
																						Gee.Collection<Valadoc.BasicTaglet> vtaglets,
																bool in_line ) {
		var tag = this.get_taglet ( name );
		if ( tag == null ) {
			this.err.add ( this.element, false, name, CommentParserError.UNKNOWN_OPTION );
			return null;
		}

		if ( !( in_line == true && tag is Valadoc.InlineTaglet ) ) {
			this.err.add ( this.element, true, name, CommentParserError.CONTEXT_ERROR );
			return null;
		}

		// add context check!

		return tag;
	}

	// TODO: move parameters to constructor
	public void initialisation ( string str, Valadoc.Basic element,
															 Valadoc.Tree tree, 
															 Valadoc.ErrorReporter err,
															 CommentContext context,
															 Valadoc.Settings settings ) {
		this.settings = settings;
		this.element = element;
		this.doctree = tree;
		this.err = err;

		if ( str[0] != '*' ) {
			this.err.add ( this.element, false, null, CommentParserError.NO_COMMENT_STRING );
			return ;
		}
		this.strip ( str );
	}

	private string strip_line ( string line ) {
		line = line.strip ( );
		if ( line == "" || line == "*" || line == null )
			return "";

		if ( line.get_char() != '*' )
			this.err.add ( this.element, false, null, CommentParserError.SYNTAX_ERROR );

		line = line.offset ( 1 ).strip ();

		var ret = new StringBuilder ( "" );
		for ( unichar ch = line.get_char(); ch != '\0' ; line = line.next_char(), ch = line.get_char() ) {
			if ( ch.isspace() ) {
				string tmp = line.prev_char();
				if ( tmp.get_char().isspace() )
					continue;

				ret.append_unichar ( ' ' );
				continue;
			}
			ret.append_unichar ( ch );
		}
		return ret.str;
	}

	private void strip ( string cmnt ) {
		string[] lines = cmnt.split( "\n" );
		this.comment = new StringBuilder ( "" );
		bool fline = false;

		foreach ( string line in lines ) {
			line = this.strip_line ( line );
			if ( line != "" )
				fline = true;

			if ( line == "" && !fline )
				continue ;

			this.comment.append_unichar ( '\n' );
			this.comment.append ( line );
		}
	}

	private Valadoc.InlineTaglet create_inline_taglet ( StringBuilder str )  {
 		var cmnd = new StringBuilder ( "" );
		bool command = false;

		int i = 0;
		string pos = str.str;
		for ( unichar ch = pos.get_char(); ch != '\0' ; pos = pos.next_char(), ch = pos.get_char(), i++ ) {
			if ( ch == '@' && !command ) {
				command = true;
				continue ;
			}
			else if ( !command && !ch.isspace() ) {
				this.err.add ( this.element, false, null, CommentParserError.SYNTAX_ERROR );
				return null;
			}
			if ( command && ch.isspace() ) {
				Valadoc.InlineTaglet tmp = (Valadoc.InlineTaglet)this.get_taglet ( cmnd.str );
				if ( tmp == null ) {
					this.err.add ( this.element, false, cmnd.str, CommentParserError.UNKNOWN_OPTION );
					return null;
				}


				str.erase ( 0, i );
				tmp.parse( str.str );
				str.erase ( 0, -1 );
				return tmp;
			}
			cmnd.append_unichar ( ch );
		}

		return null;
	}

	private void append_tree ( string cmnd, Gee.Collection<Valadoc.BasicTaglet> vtag ) {
		Valadoc.MainTaglet tag;

		// add context check
		tag = (Valadoc.MainTaglet)this.get_taglet ( cmnd );
		if ( tag == null) {
			this.err.add ( this.element, false, cmnd, CommentParserError.UNKNOWN_SYMBOL );
			return ;
		}

		var cvtag = new Gee.ArrayList<Valadoc.BasicTaglet>();

		// copy
		foreach ( Valadoc.BasicTaglet tagt in vtag ) {
			cvtag.add ( tagt );
		}

		tag.parse ( cvtag );
		this.tree.add ( tag );
		vtag.clear();
	}

	// constructor-issue
	private bool parse_comment ( ) {
		if ( this.element is Valadoc.Method == false )
			return true;

		void* ptr = ((Valadoc.Method)element).parent_data_type;
		if ( !((Valadoc.Method)element).is_constructor )
			return true;

		return ( ((Valadoc.Method)element).comment_str == ((Valadoc.ContainerDataType)ptr).comment_str )
			? false : true;
	}

	public void parse ( ) {
		if ( !this.parse_comment ( ) )
			return ;

		var brackets = new StringBuilder ( "" );
		var cmnd = new StringBuilder ( "" );
		var str = new StringBuilder ( "" );
		bool in_brackets = false;
		bool command = false;

		var tags = new Gee.ArrayList<Valadoc.BasicTaglet>();

		int i;
		weak string pos = this.comment.str;

		for ( unichar ch = pos.get_char(); ch != '\0' ; pos = pos.next_char(), ch = pos.get_char() ) {
			var pch = pos.prev_char().get_char();

			if ( ch == '}' ) {
				Valadoc.InlineTaglet tmp;

				if ( in_brackets == false ) {
					this.err.add ( this.element, false, null, CommentParserError.SYNTAX_ERROR );
					return ;
				}

				tmp = this.create_inline_taglet ( brackets );
				if ( tmp == null )
					return ;

				tags.add ( tmp );

				in_brackets = false;
				continue ;
			}
			else if ( in_brackets == true ) {
				if ( brackets.len == 0 ) {
					if ( ( ch.isspace() ) )
						continue ;
				}

				brackets.append_unichar ( ch );
				continue ;
			}
			else if ( ch == '{' ) {
				if ( in_brackets == true ) {
					this.err.add ( this.element, false, null, CommentParserError.SYNTAX_ERROR );
					return ;
				}

				var strtag = new Valadoc.StringTaglet ( );
				strtag.parse ( str.str );
				tags.add ( strtag );

				str.erase( 0, -1 );
				in_brackets = true;
				continue ;
			}
			else if ( command == true ) {
				if ( ch.isspace() )
					command = false;
				else
					cmnd.append_unichar( ch );

				continue ;
			}
			else if ( ch == '@' ) {
				if ( pch.isspace() ) {
					var strtag = new Valadoc.StringTaglet ( );
					strtag.parse ( str.str );
					tags.add ( strtag );
					str.erase( 0, -1 );

					this.append_tree( cmnd.str, tags );

					cmnd.erase ( 0, -1 );
					command = true;
					continue ;
				}
			}

			str.append_unichar( ch );
		}

		if ( in_brackets ) {
			// unreached
			this.err.add ( this.element, false, null, CommentParserError.BRACKET_ERROR );
			return ;
		}

		var strtag = new Valadoc.StringTaglet ( );
		strtag.parse ( str.str );
		tags.add ( strtag );
		str.erase( 0, -1 );

		this.append_tree( cmnd.str, tags );
	}

	private bool check_comment_context ( CommentContext context ) {
		long tmp = this.context & context;
		return ( tmp == 0 )? true : false;
	}
}


