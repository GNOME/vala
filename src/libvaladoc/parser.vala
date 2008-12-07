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


namespace Valadoc {


public static delegate GLib.Type TagletRegisterFunction ( Gee.HashMap<string, Type> taglets );

public abstract class DocElement : Object {
	public abstract bool write ( void* res, int max, int index );
}

public abstract class Taglet : DocElement {
}

public abstract class InlineTaglet : Taglet {
	public abstract bool parse ( Settings settings, Tree tree, Basic me, string content, out string[] errmsg );
	public abstract string to_string ( );
}

public abstract class MainTaglet : Taglet {
	protected string? get_data_type ( Basic me ) {
		if ( me is Valadoc.Class )
			return "class";
		if ( me is Valadoc.Delegate )
			return "delegate";
		if ( me is Valadoc.Interface )
			return "interface";
		if ( me is Valadoc.Method )
			return "method";
		if ( me is Valadoc.Property )
			return "property";
		if ( me is Valadoc.Signal )
			return "signal";
		if ( me is Valadoc.Enum )
			return "enum";
		if ( me is Valadoc.EnumValue )
			return "enum-value";
		if ( me is Valadoc.ErrorDomain )
			return "errordomain";
		if ( me is Valadoc.ErrorCode )
			return "error-code";
		if ( me is Valadoc.Field )
			return "field";
		if ( me is Valadoc.Constant )
			return "constant";
		if ( me is Valadoc.Namespace )
			return "namespace";

		return null;
	}

	public virtual int order { get { return 0; } }
	public abstract bool parse ( Settings settings, Tree tree, Basic me, Gee.Collection<DocElement> content, out string[] errmsg );
	public abstract bool write_block_start ( void* res );
	public abstract bool write_block_end ( void* res );
}

public abstract class StringTaglet : Taglet {
	public string content {
		set; get;
	}

	public abstract bool parse ( Settings settings, Tree tree, Basic me, string content );
}





public class DocumentationTree : Object {
	private Gee.ArrayList<DocElement> description = new Gee.ArrayList<DocElement> ();
	private Gee.ArrayList<DocElement> brief = new Gee.ArrayList<DocElement> ();
	private Gee.HashMap<string, Gee.ArrayList<MainTaglet> > taglets
		= new Gee.HashMap<string, Gee.ArrayList<MainTaglet> > ( GLib.str_hash, GLib.str_equal );

	public void add_taglet ( string tag, MainTaglet taglet ) {
		if ( this.taglets.contains ( tag ) ) {
			Gee.ArrayList<MainTaglet> lst = this.taglets.get ( tag );
			lst.add ( taglet );
		}
		else{
			Gee.ArrayList<MainTaglet> nlst = new Gee.ArrayList<MainTaglet> ();
			nlst.add ( taglet );
			this.taglets.set ( tag, nlst );
		}
	}

	public Gee.ReadOnlyCollection<DocElement> get_brief ( ) {
		return new Gee.ReadOnlyCollection<DocElement> ( (this.brief == null)? new Gee.ArrayList<DocElement>() : this.brief );
	}

	public void add_brief ( Gee.ArrayList<DocElement> content ) {
		this.brief = content;
	}

	public Gee.ReadOnlyCollection<DocElement> get_description ( ) {
		return new Gee.ReadOnlyCollection<DocElement> ( (this.description == null)? new Gee.ArrayList<DocElement>() : this.description );
	}

	public void add_description ( Gee.ArrayList<DocElement> content ) {
		this.description = content;
	}

	private static Gee.ArrayList< Gee.ArrayList<MainTaglet> > sort_tag_collection ( Gee.Collection< Gee.ArrayList<MainTaglet> > lst ) {
		Gee.ArrayList< Gee.ArrayList<MainTaglet> > slst
			= new Gee.ArrayList< Gee.ArrayList<MainTaglet> > ();

		foreach ( Gee.ArrayList<MainTaglet> entry in lst ) {
			slst.add ( entry );
		}

		//<bublesort>
		int count = slst.size;
		if ( count <= 0 )
			return slst;

		for ( int i = 0; i < count; i++ ) {
			for ( int j = count-1; j>i; j-- ) {
				if ( slst.get(j).get(0).order < slst.get(j-1).get(0).order ) {
					Gee.ArrayList<MainTaglet> tmp1 = slst.get(j-1);
					Gee.ArrayList<MainTaglet> tmp2 = slst.get(j);

					slst.remove_at ( j );
					slst.insert (j, tmp1 );
					slst.remove_at ( j-1 );
					slst.insert (j-1, tmp2 );
				}
			}
		}
		//</bublesort>
		return slst;
	}

	public bool write_brief ( void* res ) {
		if ( this.brief == null )
			return true;

		int _max = this.brief.size;
		int _index = 0;

		foreach ( DocElement element in this.brief ) {
			element.write ( res, _max, _index );
			_index++;
		}
		return true;
	}

	public bool write_content ( void* res ) {
		if ( this.description == null )
			return true;

		bool tmp;

		int max = this.description.size;
		int i = 0;

		foreach ( DocElement tag in this.description ) {
			tmp = tag.write ( res, max, i );
			if ( tmp == false )
				return false;

			i++;
		}

		Gee.Collection< Gee.ArrayList<MainTaglet> > lst = this.taglets.get_values ( );
		Gee.ArrayList< Gee.ArrayList<MainTaglet> > alst = sort_tag_collection ( lst );

		foreach ( Gee.ArrayList<MainTaglet> tags in alst ) {
			MainTaglet ftag = tags.get ( 0 );
			int max = tags.size;
			int i = 0;

			tmp = ftag.write_block_start ( res );
			if ( tmp == false )
				return false;

			foreach ( MainTaglet tag in tags ) {
				tmp = tag.write ( res, max, i );
				if ( tmp == false )
					return false;

				i++;
			}

			tmp = ftag.write_block_end ( res );
			if ( tmp == false )
				return false;
		}

		return true;
	}
}













public class Parser {
	private ErrorReporter err;
	private Settings settings;

	private int linestartpos;

	private int line;
	private int pos;

	private weak string filename;
	private int startline = 0;
	private int startpos = 0;

	private bool run;

	private weak string str;

	private bool errflag = false;

	private Gee.HashMap< string, GLib.Type > taglets;
	private GLib.Type strtag;

	public Parser ( Settings settings, ErrorReporter reporter, GLib.Type strtag, Gee.HashMap< string, GLib.Type > taglets ) {
		this.settings = settings;
		this.taglets = taglets;
		this.strtag = strtag;
		this.err = reporter;
	}

	private inline string extract_line ( int starttag_linestartpos = -1 ) {
		if ( starttag_linestartpos == -1 )
			starttag_linestartpos = this.linestartpos;

		weak string startpos = this.str.offset(starttag_linestartpos+1);
		weak string endpos = startpos.chr ( -1, '\n' );
		if ( endpos == null ) {
			for ( endpos = startpos; endpos.get_char() != '\0' ; endpos = endpos.next_char() );
		}

		return startpos.ndup (startpos.pointer_to_offset ( endpos ));
	}

	private void error ( string desc, int len, int starttag_linestartpos = -1, int starttag_startpos = -1, int starttag_line = -1, int starttag_pos = -1 ) {
		if ( starttag_linestartpos == -1 )
			starttag_linestartpos = this.linestartpos;
		if ( starttag_startpos == -1 )
			starttag_startpos = this.startpos;
		if ( starttag_line == -1 )
			starttag_line = this.line;
		if ( starttag_pos == -1 )
			starttag_pos = this.pos;

		int startpos = starttag_pos - starttag_linestartpos - 1;
		if ( starttag_line == 0 )
			startpos += starttag_startpos;

		int endpos = startpos+len;

		this.err.error ( this.filename, starttag_line+this.startline, int.min(startpos, endpos), int.max(startpos, endpos), this.extract_line(starttag_linestartpos), desc );
		this.errflag == true;
	}

	private void next_char ( ) {
		for ( pos++; (str[pos] == ' ' || str[pos] == '\t') && (str[pos+1] == ' ' || str[pos+1] == '\t' ); pos++ );

		if ( str[pos] == '\0' )
			this.run = false;
	}

	private void skip_newline () {
		this.linestartpos = pos;
		this.line++;

		this.next_char ();

		unichar chr = str[pos];

		if ( chr == ' ' || chr == '\t' )
			chr = str[++pos];

		if ( chr == '\0' ) {
			this.run = false;
			return ;
		}

		if ( chr != '*' ) {
			this.error ( "syntax error - invalid body.", 1 );
			this.run = false;
		}

		chr = str[pos+1];

		if ( chr == ' ' || chr == '\t' )
			this.next_char ();
	}

	private void parse_escape ( GLib.StringBuilder buf ) {
		unichar chr = this.str[this.pos+1];
		switch ( chr ) {
		case '@':
		case '}':
		case '{':
		case '\\':
			buf.append_unichar ( chr );
			break;
		case '\0':
			this.error ( "syntax error - invalid escape sequence.", 1 );
			this.run = false;
			break;
		default:
			this.error ( "syntax error - invalid escape sequence.", 2 );
			break;
		}
		this.pos++;
	}

	private string parse_name ( ) {
		int startpos = ++this.pos;

		for ( unichar chr = this.str[this.pos]; !(chr == ' ' || chr == '\t' || chr == '\0'); chr = this.str[++this.pos] );
		if ( this.str[this.pos] == '\0' )
			this.run = false;

		return this.str.offset(startpos).ndup ( (uint)(this.pos-startpos) );
	}

	private InlineTaglet? create_inline_taglet ( string name ) {
		if ( this.taglets.contains ( name ) == false ) {
			this.error ( "error - taglet '%s' is not registered.\n".printf( name ), -(int)name.len()-1  );
			return null;
		}

		GLib.Type type = this.taglets.get ( name );
		Taglet taglet = (Taglet)GLib.Object.new ( type );
		if ( taglet is InlineTaglet == false ) {
			this.error ( "context error - '%s' is not an inline taglet.\n".printf( name ), -(int)name.len()-1 );
			return null;
		}		
		return (InlineTaglet)taglet;
	}

	private MainTaglet? create_main_taglet ( string name ) {
		if ( this.taglets.contains ( name ) == false ) {
			this.error ( "error - taglet '%s' is not registered.\n".printf( name ), -(int)name.len()-1  );
			return null;
		}

		GLib.Type type = this.taglets.get ( name );
		Taglet taglet = (Taglet)GLib.Object.new ( type );
		if ( taglet is MainTaglet == false ) {
			this.error ( "context error - '%s' is an inline taglet.\n".printf( name ), -(int)name.len()-1 );
			return null;
		}		
		return (MainTaglet)taglet;
	}

	private void print_error_messages ( string[] errmsgs, int namelen, int starttag_linestartpos, int starttag_startpos, int starttag_line, int starttag_pos ) {
		if ( errmsgs != null ) {
			foreach ( string msg in errmsgs ) {
				this.error ( msg, namelen+1, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
			}
		}
		else {
			this.error ( "unknown error", namelen+1, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
		}
	}

	private void parse_inline_taglet ( Tree tree, Basic me, string content, InlineTaglet taglet, int namelen, int starttag_linestartpos, int starttag_startpos, int starttag_line, int starttag_pos ) {
		string[] errmsgs;

		bool tmp = taglet.parse ( settings, tree, me, content, out errmsgs );
		if ( tmp == false ) {
			this.print_error_messages ( errmsgs, namelen, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
		}
	}

	private void parse_main_taglet ( Tree tree, Basic me, Gee.ArrayList<DocElement> content, MainTaglet taglet, int namelen, int starttag_linestartpos, int starttag_startpos, int starttag_line, int starttag_pos ) {
		string[] errmsgs;

		bool tmp = taglet.parse ( settings, tree, me, content, out errmsgs );
		if ( tmp == false ) {
			this.print_error_messages ( errmsgs, namelen, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
		}
	}

	private void append_main_taglet ( Tree tree, DocumentationTree dtree, Basic me, MainTaglet? curtag, int paragraph, string? curtagname, Gee.ArrayList<DocElement> content, int starttag_linestartpos, int starttag_startpos, int starttag_line, int starttag_pos ) {
		if ( curtag == null ) {
			if ( paragraph == 0 )
				dtree.add_brief ( content );
			else
				dtree.add_description ( content );
		}
		else {
			this.parse_main_taglet ( tree, me, content, curtag, (int)curtagname.length, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
			dtree.add_taglet ( curtagname, curtag );
		}
	}

	private StringTaglet create_string_taglet ( Tree tree, Basic? me, GLib.StringBuilder buf ) {
		StringTaglet strtag = (StringTaglet)GLib.Object.new ( strtag );
		strtag.parse ( settings, tree, me, buf.str );
		buf.erase ( 0, -1 );
		return strtag;
	}

	private void append_and_create_string_taglet ( Gee.ArrayList<DocElement> content, Tree tree, Basic? me, GLib.StringBuilder buf ) {
		if ( buf.len == 0 )
			return ;

		StringTaglet strtag = this.create_string_taglet ( tree, me, buf );
		content.add ( strtag );
	}

	private void parse_inline_taglets ( Tree tree, Basic me, Gee.ArrayList<DocElement> elements ) {
		this.pos++;

		for ( unichar chr = this.str[this.pos]; ; chr = this.str[++this.pos] ) {
			switch ( chr ) {
			case '\t':
			case ' ':
				continue;
			case '\n':
				this.skip_newline ();
				continue;
			case '\0':
				// error message
				this.run = false;
				return ;
			default:
				break;
			}
			break ;
		}

		int starttag_linestartpos = this.linestartpos;
		int starttag_startpos = this.startpos;
		int starttag_line = this.line;
		int starttag_pos = this.pos;

		if ( this.str[this.pos] != '@' ) {
			// fehlermeldung
			this.run = false;
			return ;
		}

		GLib.StringBuilder buf = new GLib.StringBuilder ( );
		string name = this.parse_name ( );
		// if ( name == "" ) => fehlermeldung

		InlineTaglet? taglet = this.create_inline_taglet ( name );
		if ( taglet == null ) {
			return ;
		}

		for ( unichar chr = this.str[this.pos]; chr != '\0' ; chr = this.str[++this.pos] ) {
			switch ( chr ) {
			case '\t':
			case ' ':
				if ( buf.len > 0 && buf.str[buf.len-1] != ' ' ) {
					buf.append_unichar ( ' ' );
				}
				continue;
			case '\n':
				this.skip_newline ();
				if ( buf.len > 0 && buf.str[buf.len-1] != ' ' ) {
					buf.append_unichar ( ' ' );
				}
				continue;
			case '}':
				if ( buf.len > 0 && buf.str[buf.len-1] == ' ' ) {
					buf.erase ( buf.len-1, -1 );
				}

				this.parse_inline_taglet ( tree, me, buf.str, taglet, (int)name.length, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
				if ( this.run == true ) {
					elements.add ( taglet );
				}
				return ;
			default:
				buf.append_unichar ( chr );
				continue ;
			}
		}
		//error - Missing closing '}' character for inline tag.
		this.run = false;
		return ;
	}

	private bool skip_documentation_header () {
		for ( this.pos = 0; str[this.pos] != '\0' && str[this.pos] == '*'; this.pos++ );
		for ( ; str[this.pos] != '\0' && (str[this.pos] == ' ' || str[this.pos] == '\t'); this.pos++ );
		return ( str[this.pos] == '\n' );
	}

	public DocumentationTree? parse ( Tree tree, Basic me, string str ) {
		Gee.ArrayList<DocElement> content = new Gee.ArrayList<DocElement> ();
		GLib.StringBuilder buf = new GLib.StringBuilder ( );
		DocumentationTree dtree = new DocumentationTree ();
		string curtagname = null;
		MainTaglet curtag = null;

		int starttag_linestartpos = 0;
		int starttag_startpos = 0;
		int starttag_line = 0;
		int starttag_pos = 0;
		int paragraph = 0;

		this.filename = me.filename;

		this.linestartpos = 0;
		this.startpos = 0;
		this.line = 0;
		this.pos = 0;

		this.run = true;
		this.str = str;
		this.line = 0;


		bool tmp = this.skip_documentation_header ();
		if ( tmp == false ) {
			this.error ( "syntax error - invalid documentation header.", 1 );
			return null;
		}

		for ( ; str[pos] != '\0'; this.next_char ( ) ) {
			if ( this.run == false )
				break;

			switch ( str[pos] ) {
				case ' ':
				case '\t':
					if ( buf.str[buf.len-1] != '\n' && buf.len > 0 && buf.str[buf.len-1] != ' ') {
						buf.append_unichar ( ' ' );
					}
					break;
				case '\n':
					this.skip_newline ();

					if ( str[pos+1] == '\n' ) {
						if ( paragraph == 0 ) {
							this.append_and_create_string_taglet ( content, tree, me, buf );
							this.append_main_taglet ( tree, dtree, me, curtag, paragraph, curtagname, content, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
							content = new Gee.ArrayList<DocElement> ();
							paragraph++;
							break;
						}
						buf.append_unichar ( '\n' );
						paragraph++;
						break ;
					}
					else if ( str[pos+1] == '@' ) {
						pos++;

						int f_starttag_linestartpos = this.linestartpos;
						int f_starttag_startpos = this.startpos;
						int f_starttag_line = this.line;
						int f_starttag_pos = this.pos;

						string name = this.parse_name ( );
						if ( name == "" ) {
							buf.append_unichar ( '@' ); // Warning?
							break;
						}

						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.append_main_taglet ( tree, dtree, me, curtag, paragraph, curtagname, content, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
						paragraph++;

						starttag_linestartpos = f_starttag_linestartpos;
						starttag_startpos = f_starttag_startpos;
						starttag_line = f_starttag_line;
						starttag_pos = f_starttag_pos;

						content = new Gee.ArrayList<DocElement> ();
						curtag = create_main_taglet ( name );
						curtagname = #name;
					}
					else if ( buf.str[buf.len-1] != '\n' && buf.len > 0 && buf.str[buf.len-1] != ' ') {
						buf.append_unichar ( ' ' );
					}

					break;
				case '{':
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_inline_taglets ( tree, me, content );
					break;
				case '@':
					// warning!
					buf.append_unichar ( '@' );
					break;
				case '\\':
					this.parse_escape ( buf );
					break;
				default:
					buf.append_unichar ( str[pos] );
					break;
			}
		}

		if ( this.errflag == true )
			return null;

		this.append_and_create_string_taglet ( content, tree, me, buf );
		this.append_main_taglet ( tree, dtree, me, curtag, paragraph, curtagname, content, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
		return dtree;
	}

	public static bool is_documentation ( string cmnt ) {
		return cmnt[0] == '*';
	}

	public static bool is_inherit_doc ( string? cmnt ) {
		if ( cmnt == null )
			return false;

		try {
			var regexp = new Regex (  "^[\\s\\*\n]*{[\\s\n]*@inheritDoc[\\s\n]*}[\\s\n\\*]*$" );
			return regexp.match ( cmnt );
		}
		catch ( RegexError err ) {
			return false;
		}
	}
}

}
