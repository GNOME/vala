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
	public abstract bool parse ( Settings settings, Tree tree, DocumentedElement me, string content, out string[] errmsg );
	public abstract string to_string ( );
}

public abstract class MainTaglet : Taglet {
	protected string? get_data_type ( DocumentedElement me ) {
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
	public abstract bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.Collection<DocElement> content, out string[] errmsg );
	public abstract bool write_block_start ( void* res );
	public abstract bool write_block_end ( void* res );
}

public abstract class StringTaglet : Taglet {
	public string content {
		set; get;
	}

	public abstract bool parse ( Settings settings, Tree tree, DocumentedElement me, string content );
}

public enum ImageDocElementPosition {
	NEUTRAL,
	MIDDLE,
	RIGHT,
	LEFT
}

public enum Language {
	GENIE,
	VALA,
	C
}

public enum ListType {
	UNSORTED,
	SORTED
}

public abstract class ImageDocElement : DocElement {
	public abstract bool parse ( Settings settings, Tree tree, DocumentedElement me, string# path, ImageDocElementPosition pos );
}

public abstract class LinkDocElement : DocElement {
	public abstract bool parse ( Settings settings, Tree tree, DocumentedElement me, string# link, Gee.ArrayList<DocElement>? desc );
}

public abstract class SourceCodeDocElement : DocElement {
	public abstract bool parse ( Settings settings, Tree tree, DocumentedElement me, string# src, Language lang );
}

public abstract class ListEntryDocElement : DocElement {
	public abstract bool parse ( Settings settings, Tree tree, DocumentedElement me, ListType type, Gee.ArrayList<DocElement> content );
}

public abstract class ListDocElement : DocElement {
	public abstract bool parse ( Settings settings, Tree tree, DocumentedElement me, ListType type, Gee.ArrayList<ListEntryDocElement> entries );
}

public abstract class NotificationDocElement : DocElement {
	public abstract bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content );
}


public abstract class HighlightedDocElement : DocElement {
	public abstract bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content );
}

public abstract class ItalicDocElement : HighlightedDocElement {
}

public abstract class BoldDocElement : HighlightedDocElement {
}

public abstract class UnderlinedDocElement : HighlightedDocElement {
}

public abstract class ContentPositionDocElement : DocElement {
	public abstract bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content );
}

public abstract class CenterDocElement : ContentPositionDocElement {
}

public abstract class RightAlignedDocElement : ContentPositionDocElement {
}


public enum TextPosition {
	LEFT,
	RIGHT,
	CENTER
}

public enum TextVerticalPosition {
	TOP,
	MIDDLE,
	BOTTOM
}



public abstract class TableCellDocElement : DocElement {
	public abstract void parse ( Settings settings, Tree tree, DocumentedElement me, TextPosition pos, TextVerticalPosition hpos, int size, int dsize, Gee.ArrayList<DocElement> content );
}

public abstract class TableDocElement : DocElement {
	public abstract void parse ( Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> cells );
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
			max = tags.size;
			i = 0;

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








public class ModuleLoader : Object {
	public Gee.HashMap< string, GLib.Type > taglets;
	public GLib.Type underlinedtag;
	public GLib.Type notifictag;
	public GLib.Type centertag;
	public GLib.Type italictag;
	public GLib.Type ulistetag;
	public GLib.Type righttag;
	public GLib.Type ulisttag;
	public GLib.Type linktag;
	public GLib.Type strtag;
	public GLib.Type srctag;
	public GLib.Type imgtag;
	public GLib.Type boldtag;

	public GLib.Type tabletag;
	public GLib.Type celltag;

	public Doclet doclet;

	private Module docletmodule;
	private Type doclettype;

	public bool load ( string path ) {
		bool tmp = this.load_doclet ( path );
		if ( tmp == false )
			return false;

		return this.load_taglets ( path );
	}

	private bool load_doclet ( string path ) {
		void* function;

		docletmodule = Module.open ( path + "/libdoclet.so", ModuleFlags.BIND_LAZY);
		if (docletmodule == null) {
			return false;
		}

		docletmodule.symbol( "register_plugin", out function );
		if ( function == null ) {
			return false;
		}

		Valadoc.DocletRegisterFunction doclet_register_function = (Valadoc.DocletRegisterFunction) function;
		doclettype = doclet_register_function ( );
		this.doclet = (Doclet)GLib.Object.new (doclettype);
		return true;
	}

	private bool load_taglets ( string fulldirpath ) {
		try {
			taglets = new Gee.HashMap<string, Type> ( GLib.str_hash, GLib.str_equal );
			Gee.ArrayList<Module*> modules = new Gee.ArrayList<weak Module*> ( );
			string pluginpath = fulldirpath + "taglets/";
			GLib.Dir dir = GLib.Dir.open ( pluginpath );
			void* function;

			for ( weak string entry = dir.read_name(); entry != null ; entry = dir.read_name() ) {
				if ( !( entry.has_suffix(".so") || entry.has_suffix(".dll") ) )
					continue ;

				string tagletpath = pluginpath + "/" + entry;

				Module* module = Module.open ( tagletpath, ModuleFlags.BIND_LAZY);
				if (module == null) {
					taglets = null;
					return false;
				}

				module->symbol( "register_plugin", out function );
				Valadoc.TagletRegisterFunction tagletregisterfkt = (Valadoc.TagletRegisterFunction) function;


				GLib.Type type = tagletregisterfkt ( taglets );

				switch ( entry ) {
				case "libtagletstring.so":
					this.strtag = type;
					break;
				case "libtagletimage.so":
					this.imgtag = type;
					break;
				case "libtagletcenter.so":
					this.centertag = type;
					break;
				case "libtagletright.so":
					this.righttag = type;
					break;
				case "libtagletbold.so":
					this.boldtag = type;
					break;
				case "libtagletunderline.so":
					this.underlinedtag = type;
					break;
				case "libtagletitalic.so":
					this.italictag = type;
					break;
				case "libtagletsrcsample.so":
					this.srctag = type;
					break;
				case "libtagletnotification.so":
					this.notifictag = type;
					break;
				case "libtaglettable.so":
					this.tabletag = type;
					break;
				case "libtaglettablecell.so":
					this.celltag = type;
					break;
				case "libtagletwikilink.so":
					this.linktag = type;
					break;
				case "libtagletlist.so":
					this.ulisttag = type;
					break;
				case "libtagletlistelement.so":
					this.ulistetag = type;
					break;
				}

				modules.add ( module );
			}
			return true;
		}
		catch ( FileError err ) {
			taglets = null;
			return false;
		}
	}
}


public class Parser {
	private ModuleLoader modules;
	private Settings settings;
	private ErrorReporter err;

	private bool errflag = false;

	private int linestartpos;
	private int startline;
	private int startpos;
	private int line;
	private int pos;

	private string filename;
	private weak string str;
	private bool run;


	public Parser ( Settings settings, ErrorReporter reporter, ModuleLoader modules ) {
		this.settings = settings;
		this.modules = modules;
		this.err = reporter;
	}

	private string extract_line ( int starttag_linestartpos = -1 ) {
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
			this.error ( "invalid body.", 1 );
			this.run = false;
		}
	}

	private void next_nonspace_char () {
		unichar chr = this.str[this.pos+1];

		if ( chr == ' ' || chr == '\t' )
			this.next_char ();
	}

	private void parse_escape ( GLib.StringBuilder buf ) {
		unichar chr = this.str[this.pos+1];
		switch ( chr ) {
		case '}':
		case ']':
		case '|':
		case '\\':
			buf.append_unichar ( chr );
			break;
		case '\0':
			this.error ( "invalid escape sequence.", 1 );
			this.run = false;
			break;
		default:
			this.error ( "invalid escape sequence.", 2 );
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
		if ( this.modules.taglets.contains ( name ) == false ) {
			this.error ( "taglet '%s' is not registered.\n".printf( name ), -(int)name.len()-1  );
			return null;
		}

		GLib.Type type = this.modules.taglets.get ( name );
		Taglet taglet = (Taglet)GLib.Object.new ( type );
		if ( taglet is InlineTaglet == false ) {
			this.error ( "'%s' is not an inline taglet.\n".printf( name ), -(int)name.len()-1 );
			return null;
		}		
		return (InlineTaglet)taglet;
	}

	private MainTaglet? create_main_taglet ( string name ) {
		if ( this.modules.taglets.contains ( name ) == false ) {
			this.error ( "taglet '%s' is not registered.\n".printf( name ), -(int)name.len()-1  );
			return null;
		}

		GLib.Type type = this.modules.taglets.get ( name );
		Taglet taglet = (Taglet)GLib.Object.new ( type );
		if ( taglet is MainTaglet == false ) {
			this.error ( "'%s' is an inline taglet.\n".printf( name ), -(int)name.len()-1 );
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

	private void parse_inline_taglet ( Tree tree, DocumentedElement me, string content, InlineTaglet taglet, int namelen, int starttag_linestartpos, int starttag_startpos, int starttag_line, int starttag_pos ) {
		string[] errmsgs;

		bool tmp = taglet.parse ( settings, tree, me, content, out errmsgs );
		if ( tmp == false ) {
			this.print_error_messages ( errmsgs, namelen, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
		}
	}

	private void parse_main_taglet ( Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content, MainTaglet taglet, int namelen, int starttag_linestartpos, int starttag_startpos, int starttag_line, int starttag_pos ) {
		string[] errmsgs;

		bool tmp = taglet.parse ( settings, tree, me, content, out errmsgs );
		if ( tmp == false ) {
			this.print_error_messages ( errmsgs, namelen, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
		}
	}

	private void append_main_taglet ( Tree tree, DocumentationTree dtree, DocumentedElement me, MainTaglet? curtag, int paragraph, string? curtagname, Gee.ArrayList<DocElement> content, int starttag_linestartpos, int starttag_startpos, int starttag_line, int starttag_pos ) {
		if ( curtag == null ) {
			dtree.add_description ( content );
		}
		else {
			this.parse_main_taglet ( tree, me, content, curtag, (int)curtagname.length, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
			dtree.add_taglet ( curtagname, curtag );
		}
	}

	private StringTaglet create_string_taglet ( Tree tree, DocumentedElement? me, GLib.StringBuilder buf ) {
		StringTaglet strtag = (StringTaglet)GLib.Object.new ( this.modules.strtag );
		strtag.parse ( settings, tree, me, buf.str );
		buf.erase ( 0, -1 );
		return strtag;
	}

	private void append_and_create_string_taglet ( Gee.ArrayList<DocElement> content, Tree tree, DocumentedElement? me, GLib.StringBuilder buf ) {
		if ( buf.len == 0 )
			return ;

		StringTaglet strtag = this.create_string_taglet ( tree, me, buf );
		content.add ( strtag );
	}

	private int next_word_offset () {
		weak string curstr = this.str.offset ( this.pos );
		long offset = curstr.length;

		weak string posstr = curstr.chr ( -1, ' ' );
		if ( posstr != null ) {
			offset =  curstr.pointer_to_offset ( posstr ); 
		}

		posstr = curstr.chr ( -1, '\n' );
		if ( posstr != null ) {
			offset = long.min ( offset, curstr.pointer_to_offset ( posstr ) );
		}

		posstr = curstr.chr ( -1, '\t' );
		if ( posstr != null ) {
			offset = long.min ( offset, curstr.pointer_to_offset ( posstr ) );
		}
		return (int)offset;
	}

	private int next_line_offset () {
		weak string curstr = this.str.offset ( this.pos );
		long offset = curstr.length;

		weak string posstr = curstr.chr ( -1, '\n' );
		if ( posstr != null ) {
			offset =  curstr.pointer_to_offset ( posstr ); 
		}
		return (int)offset;
	}

	private void parse_inline_taglets ( Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> elements ) {
		this.pos++;

		for ( unichar chr = this.str[this.pos]; ; chr = this.str[++this.pos] ) {
			switch ( chr ) {
			case '\t':
			case ' ':
				continue;
			case '\n':
				this.skip_newline ();
				this.next_nonspace_char ();
				continue;
			case '\0':
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
			this.error ( "taglet name was expected.", this.next_word_offset () );
			this.run = false;
			return ;
		}

		GLib.StringBuilder buf = new GLib.StringBuilder ( );
		string name = this.parse_name ( );

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
				this.next_nonspace_char ();
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


		this.error ( "brackets are not closed.", 2, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
		this.run = false;
		return ;
	}

	private bool skip_documentation_header () {
		for ( this.pos = 0; str[this.pos] != '\0' && str[this.pos] == '*'; this.pos++ );
		for ( ; str[this.pos] != '\0' && (str[this.pos] == ' ' || str[this.pos] == '\t'); this.pos++ );
		return ( str[this.pos] == '\n' );
	}

	private int parse_list_entry ( Tree tree, DocumentedElement me, ListType type, Gee.ArrayList<ListEntryDocElement> entries, GLib.Queue<int> queue, int deep, int prevdeep ) {
		Gee.ArrayList<DocElement> content = new Gee.ArrayList<DocElement> ();
		GLib.StringBuilder buf = new GLib.StringBuilder ( );

		unichar chr = this.str[this.pos];
		if ( chr != '*' && chr != '#' ) {
			this.next_char ( );
			chr = this.str[this.pos];
		}

		if ( !(type == ListType.SORTED && chr == '#' || type == ListType.UNSORTED && chr == '*') ) {
			this.error ( "invalid list entry.", this.next_line_offset () );
		}

		this.next_char ( );

		for ( chr = this.str[this.pos]; chr != '\0'; chr = this.str[++this.pos] ) {
			switch ( chr ) {
			case '\t':
			case ' ':
				if ( buf.str[buf.len-1] != '\n' && buf.str[buf.len-1] != ' ') {
					buf.append_unichar ( ' ' );
				}
				break;
			case '\n':
				this.skip_newline ();
				int  startpos = this.pos;
				this.next_nonspace_char ();

				if ( this.str[this.pos] == '\0' ) {
					ListEntryDocElement lstel = (ListEntryDocElement)GLib.Object.new ( this.modules.ulistetag );
					this.append_and_create_string_taglet ( content, tree, me, buf );
					lstel.parse ( this.settings, tree, me, type, content );
					entries.add ( lstel );
					this.run = false;
					return -2;
				}

				unichar nchr = this.str[this.pos+1];

				switch ( nchr ) {
				case '\0':
					ListEntryDocElement lstel = (ListEntryDocElement)GLib.Object.new ( this.modules.ulistetag );
					this.append_and_create_string_taglet ( content, tree, me, buf );
					lstel.parse ( this.settings, tree, me, type, content );
					entries.add ( lstel );
					this.run = false;
					return -2;
				case '\n':
					ListEntryDocElement lstel = (ListEntryDocElement)GLib.Object.new ( this.modules.ulistetag );
					this.append_and_create_string_taglet ( content, tree, me, buf );
					lstel.parse ( this.settings, tree, me, type, content );
					entries.add ( lstel );
					return -2;
				case '*':
				case '#':
					int ndeep = this.pos-startpos + 1;

					ListEntryDocElement lstel = (ListEntryDocElement)GLib.Object.new ( this.modules.ulistetag );
					this.append_and_create_string_taglet ( content, tree, me, buf );
					lstel.parse ( this.settings, tree, me, type, content );
					entries.add ( lstel );

					if ( ndeep > deep ) {
						ndeep = this.parse_list ( tree, me, (nchr == '*')? ListType.UNSORTED : ListType.SORTED, content, queue, ndeep, deep );
					}
					return ndeep;				
				default:
					if ( buf.len > 0 && buf.str[buf.len-1] != ' ') {
						buf.append_unichar ( ' ' );
					}
					break;
				}
				break;
			case '{':
				if ( str[pos+1] == '{' ) {
					if ( str[pos+2] == '{' ) {
						this.error ( "source samples are not allowed inside lists.", this.next_line_offset () );
						this.run = false;
						break;
					}
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_image ( tree, me, content );
					break;
				}
				this.append_and_create_string_taglet ( content, tree, me, buf );
				this.parse_inline_taglets ( tree, me, content );
				break;
			case '[':
				if ( str[pos+1] == '[' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_link ( tree, me, content );
					break;
				}
				buf.append_unichar ( '[' );						
				break;
			case '+':
				if ( str[pos+1] == '+' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_bold_content ( tree, me, content );
					break;
				}
				buf.append_unichar ( '+' );
				break;
			case '_':
				if ( str[pos+1] == '_' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_underlined_content ( tree, me, content );
					break;
				}
				buf.append_unichar ( '_' );
				break;
			case '/':
				if ( str[pos+1] == '/' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_italic_content ( tree, me, content );
					break;
				}
				buf.append_unichar ( '/' );
				break;
			default:
				buf.append_unichar ( chr );
				break;
			}
		}
		ListEntryDocElement lstel = (ListEntryDocElement)GLib.Object.new ( this.modules.ulistetag );
		this.append_and_create_string_taglet ( content, tree, me, buf );
		lstel.parse ( this.settings, tree, me, type, content );
		entries.add ( lstel );
		this.run = false;
		return -2;
	}

	private int parse_list ( Tree tree, DocumentedElement me, ListType listtype, Gee.ArrayList<DocElement> content, GLib.Queue<int> stack, int deep, int prevdeep ) {
		Gee.ArrayList<ListEntryDocElement> entries = new Gee.ArrayList<ListEntryDocElement> ();
		unichar chr = this.str[this.pos];
		int ndeep = -1;

		if ( deep >= 0 )
			stack.push_head ( deep );

		do {
			ndeep = this.parse_list_entry ( tree, me, listtype, entries, stack, deep, prevdeep );
			chr = this.str[++this.pos];
		}
		while ( chr != '\0' && chr != '\n' && ndeep == deep && this.run == true );


		if ( stack.is_empty () == false && deep > ndeep && ndeep >= 0 ) {
			weak GLib.List<int> pos = stack.find ( ndeep );
			if ( pos == null ) {
				this.error ( "invalid list entry.", this.next_line_offset () );
				this.run = false;
			}
		}

		ListDocElement ltag = (ListDocElement)GLib.Object.new ( this.modules.ulisttag );
		ltag.parse ( this.settings, tree, me, listtype, entries );
		content.add ( ltag );

		if ( deep >= 0 )
			stack.pop_head ( );

		this.pos--;
		return ndeep;
	}

	private void skip_whitespaces () {
		for ( ; ; this.pos++  ) {
			unichar chr =  this.str[this.pos];
			switch ( chr ) {
			case '\0':
				this.run = false;
				return;
			case '\t':
			case ' ':
				break;
			default:
				return ;
			}
		}
	}

	private int extract_number () {
		weak string startstr = this.str.offset( this.pos );
		weak string pos = startstr;
		for ( unichar chr = pos.get_char (); chr >= '0' && chr <= '9' ; pos = pos.next_char (), chr = pos.get_char (), this.pos++ );

		long len =  startstr.pointer_to_offset ( pos );
		string numstr = startstr.ndup ( len );
		return numstr.to_int();
	}

	private bool parse_cell_attribute ( ref TextPosition pos, ref TextVerticalPosition hpos, ref int size, ref int dsize ) {
		weak string str = this.str.offset ( this.pos );

		if ( str.has_prefix ( ")(" ) ) {
			pos = TextPosition.CENTER;
			this.pos = this.pos + 2;
		}
		else if ( str.has_prefix ( "))" ) ) {
			pos = TextPosition.RIGHT;
			this.pos = this.pos + 2;
		}
		else if ( str.has_prefix ( "^" ) ) {
			hpos = TextVerticalPosition.TOP;
			this.pos++;
		}
		else if ( str.has_prefix ( "-" ) ) {
			this.pos++;
			this.skip_whitespaces ();
			size = this.extract_number ();
		}
		else if ( str.has_prefix ( "v" ) ) {
			this.pos++;
			this.skip_whitespaces ();
			dsize = this.extract_number ();
		}
		else {
			int offset = this.next_line_offset ();

			weak string posstr = str.chr ( -1, '>' );
			if ( posstr != null ) {
				offset = int.min ( offset, (int)str.pointer_to_offset ( posstr ) );
			}

			posstr = str.chr ( -1, '|' );
			if ( posstr != null ) {
				offset = int.min ( offset, (int)str.pointer_to_offset ( posstr ) );
			}

			this.error ( "invalid cell attribute.", offset );
			this.run = false;
			return false;
		}

		this.skip_whitespaces ();
		unichar chr = this.str[this.pos];
		if ( chr == '|' ) {
			return true;
		}

		if ( chr == '>' ) {
			return false;
		}
		this.error ( "invalid cell attributes.", 5 );
		this.run = false;
		return false;
	}

	private void parse_cell_attributes ( out TextPosition pos, out TextVerticalPosition hpos, out int size, out int dsize ) {
		bool tmp = true;

		hpos = TextVerticalPosition.MIDDLE;
		pos = TextPosition.LEFT;
		size = 1;

		do {
			this.pos++;
			tmp = this.parse_cell_attribute ( ref pos, ref hpos, ref size, ref dsize );
		} while ( tmp == true && this.run == true );
	}

	

	private bool parse_row ( Tree tree, DocumentedElement me, Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> rows ) {
		Gee.ArrayList<TableCellDocElement> row = new Gee.ArrayList<TableCellDocElement> ();
		Gee.ArrayList<DocElement> content = new Gee.ArrayList<DocElement> ();
		GLib.StringBuilder buf = new GLib.StringBuilder ( );

		this.skip_whitespaces ();
		this.pos = this.pos+2;

		TextVerticalPosition hpos = TextVerticalPosition.MIDDLE;
		TextPosition pos = TextPosition.LEFT;
		int dsize = 1;
		int size = 1;

		if ( this.str[this.pos] == '<' ) {
			this.parse_cell_attributes ( out pos, out hpos, out size, out dsize );
		}

		this.next_char ( );
		for ( unichar chr = this.str[this.pos]; chr != '\0'; chr = this.str[++this.pos] ) {
			switch ( chr ) {
			case '\t':
			case ' ':
				if ( buf.str[buf.len-1] != '\n' && buf.str[buf.len-1] != ' ') {
					buf.append_unichar ( ' ' );
				}
				break;
			case '|':
				unichar nchr = this.str[this.pos+1];
				switch ( nchr ) {
				case ']':
				case '|':
					this.append_and_create_string_taglet ( content, tree, me, buf );
					TableCellDocElement cell = (TableCellDocElement)GLib.Object.new ( this.modules.celltag );
					cell.parse ( this.settings, tree, me, pos, hpos, size, dsize, content );
					content = new Gee.ArrayList<DocElement> ();
					row.add ( cell );

					hpos = TextVerticalPosition.MIDDLE;
					pos = TextPosition.LEFT;
					dsize = 1;
					size = 1;

					if ( this.str[this.pos] == '<' ) {
						this.parse_cell_attributes ( out pos, out hpos, out size, out dsize );
					}

					this.pos++;

					if ( nchr == ']' ) {
						this.pos++;
						this.skip_whitespaces ();
						rows.add ( row );
						if ( this.str[this.pos] == '\0' ) {
							this.run = false;
							return false;
						}

						if ( this.str[this.pos] == '\n' ) {
							int newlinepos = this.pos;
							this.skip_newline ();
							this.pos++;
							this.skip_whitespaces ();

							if ( this.str[this.pos] == '[' && this.str[this.pos+1] == '|' ) {
								return true;
							}
							this.pos = newlinepos-1;
						}

						return false;
					}
					break;
				default:
					buf.append_unichar ( chr );
					break;
				}
				break;
			default:
				buf.append_unichar ( chr );
				break;
			}
		}
		this.run = false;
		return false;
	}

	private void parse_table ( Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content ) {
		Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> rows = new Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> ();
		bool next = true;
		this.pos++;

		do {
			next = this.parse_row ( tree, me, rows );
		}
		while ( this.run == true && next == true );
		TableDocElement table = (TableDocElement)GLib.Object.new ( this.modules.tabletag );
		table.parse ( rows  );
		content.add ( table );
	}

	private void parse_italic_content ( Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content, bool newline = true  ) {
		this.parse_highlighted_content ( tree, me, this.modules.italictag, '/', content, newline );
	}

	private void parse_bold_content ( Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content, bool newline = true  ) {
		this.parse_highlighted_content ( tree, me, this.modules.boldtag, '+', content, newline );
	}

	private void parse_underlined_content ( Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content, bool newline = true  ) {
		this.parse_highlighted_content ( tree, me, this.modules.underlinedtag, '_', content, newline );
	}

	private void parse_highlighted_content ( Tree tree, DocumentedElement me, GLib.Type tagtype, unichar separator, Gee.ArrayList<DocElement> content2, bool newline = true  ) {
		Gee.ArrayList<DocElement> content = new Gee.ArrayList<DocElement> ();
		GLib.StringBuilder buf = new GLib.StringBuilder ( );
		int starttag_linestartpos = this.linestartpos;
		int starttag_startpos = this.startpos;
		int starttag_line = this.line;
		int starttag_pos = this.pos;
		this.pos = this.pos+2;

		for ( unichar chr = this.str[this.pos]; chr != '\0' ; chr = this.str[++this.pos] ) {
			if ( this.run == false ) {
				return ;
			}

			switch ( chr ) {
			case '\t':
			case ' ':
				if ( buf.str[buf.len-1] != '\n' && buf.str[buf.len-1] != ' ') {
					buf.append_unichar ( ' ' );
				}
				break;
			case '\n':
				if ( newline == false ) {
					this.error ( "newlines are not allowed.", this.next_line_offset () );
					this.run = false;
					return ;
				}
				this.skip_newline ();
				this.next_nonspace_char ();
				switch ( str[pos+1] ) {
				case '\n':
					buf.append_unichar ( '\n' );
					break ;
				case '#':
				case '*':
					this.error ( "lists are not allowed inside highlighted content.", this.next_line_offset () );
					break;
				case '@':
					this.error ( "taglets are not allowed inside highlighted content.", this.next_line_offset () );
					break;
				case ')':
					unichar nnchr = str[pos+2];
					if ( nnchr == ')' || nnchr == '(' ) {
						this.error ( "error - text alignments are not allowed inside highlighted content.", this.next_line_offset () );
					}
					break;
				}
				break;
			case '{':
				if ( str[pos+1] == '{' ) {
					if ( str[pos+2] == '{' ) {
						this.error ( "code samples are not allowed inside highlighted content.", 3 );
						this.run = false;
						break;
					}
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_image ( tree, me, content );
					break;
				}
				this.append_and_create_string_taglet ( content, tree, me, buf );
				this.parse_inline_taglets ( tree, me, content );
				break;
			case '[':
				weak string cpos = this.str.offset ( this.pos );
				if ( cpos.has_prefix( "[warning:" ) ) {
					this.error ( "notifications are not allowed inside highlighted content.", this.next_line_offset () );
					this.run = false;
					break;
				}
				if ( str[pos+1] == '[' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_link ( tree, me, content );
					break;
				}
				buf.append_unichar ( '[' );						
				break;
			default:
				unichar nchr = str[pos+1];
				if ( chr == separator ) {
					if ( nchr == separator ) {
						this.append_and_create_string_taglet ( content, tree, me, buf );
						HighlightedDocElement element = (HighlightedDocElement)GLib.Object.new ( tagtype );
						element.parse ( this.settings, tree, me, content );
						content2.add ( element );
						this.pos++;
						return ;
					}
					buf.append_unichar ( separator );
					break;
				}

				if ( nchr == chr ) {
					switch ( nchr ) {
					case '+':
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_bold_content ( tree, me, content );
						continue;
					case '_':
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_underlined_content ( tree, me, content );
						continue;
					case '/':
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_italic_content ( tree, me, content );
						continue;
					}
				}
				buf.append_unichar ( chr );
				break;
			}
		}
		this.error ( "tag is not closed.", 2, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
		this.run = false;
	}

	private void parse_notification ( Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content2 ) {
		Gee.ArrayList<DocElement> content = new Gee.ArrayList<DocElement> ();
		GLib.StringBuilder buf = new GLib.StringBuilder ( );
		int starttag_linestartpos = this.linestartpos;
		int starttag_startpos = this.startpos;
		int starttag_line = this.line;
		int starttag_pos = this.pos;
		this.pos = this.pos + 9;

		for ( unichar chr = this.str[this.pos]; chr != '\0' ; chr = this.str[++this.pos] ) {
			switch ( chr ) {
			case ' ':
			case '\t':
				if ( buf.str[buf.len-1] != '\n' && buf.str[buf.len-1] != ' ') {
					buf.append_unichar ( ' ' );
				}
				break;
			case '\n':
				this.skip_newline ();
				int reallinestartpos = this.pos;
				this.next_nonspace_char ();

				switch ( str[pos+1] ) {
				case '\n':
					buf.append_unichar ( '\n' );
					break ;
				case '#':
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_list ( tree, me, ListType.SORTED, content, new GLib.Queue<int> (), ++this.pos-reallinestartpos, -1 );
					break;
				case '*':
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_list ( tree, me, ListType.UNSORTED, content, new GLib.Queue<int> (), ++this.pos-reallinestartpos, -1 );
					break;
				case ')':
					switch ( str[pos+2] ) {
					case ')':
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_content_position ( tree, me, this.modules.righttag, content );
						break;
					case '(':
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_content_position ( tree, me, this.modules.centertag, content );
						break;
					}
					break;
				default:
					if ( buf.str[buf.len-1] != '\n' && buf.str[buf.len-1] != ' ') {
						buf.append_unichar ( ' ' );
					}
					break;
				}
				break;
			case ']':
				this.append_and_create_string_taglet ( content, tree, me, buf );				
				NotificationDocElement notification = (NotificationDocElement)GLib.Object.new ( this.modules.notifictag );
				notification.parse ( this.settings, tree, me, content );
				content2.add ( notification );
				return;
			case '[':
				if ( str[pos+1] == '[' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_link ( tree, me, content );
					break;
				}
				buf.append_unichar ( '[' );						
				break;
			case '{':
				if ( str[pos+1] == '{' ) {
					if ( str[pos+2] == '{' ) {
						this.error ( "code blocks are not allowed inside notification areas.", 3 );
						this.run = false;
						return;
					}
					this.error ( "images are not allowed inside notification areas.", 2 );
					this.run = false;
					return;
				}
				this.append_and_create_string_taglet ( content, tree, me, buf );
				this.parse_inline_taglets ( tree, me, content );
				break;
			case '+':
				if ( str[pos+1] == '+' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_bold_content ( tree, me, content );
					break;
				}
				buf.append_unichar ( '+' );
				break;
			case '_':
				if ( str[pos+1] == '_' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_underlined_content ( tree, me, content );
					break;
				}
				buf.append_unichar ( '_' );
				break;
			case '/':
				if ( str[pos+1] == '/' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_italic_content ( tree, me, content );
					break;
				}
				buf.append_unichar ( '/' );
				break;
			default:
				buf.append_unichar ( str[pos] );
				break;
			}
		}

		this.error ( "warning-tag is not closed.", 2, starttag_linestartpos, starttag_startpos, starttag_line, starttag_pos );
		this.run = false;
	}

	private void parse_content_position ( Tree tree, DocumentedElement me, GLib.Type postagtype, Gee.ArrayList<DocElement> content2 ) {
		Gee.ArrayList<DocElement> content = new Gee.ArrayList<DocElement> ();
		GLib.StringBuilder buf = new GLib.StringBuilder ( );
		this.pos = this.pos + 3;

		for ( unichar chr = this.str[this.pos]; chr != '\0' ; chr = this.str[++this.pos] ) {
			switch ( chr ) {
			case ' ':
			case '\t':
				if ( buf.str[buf.len-1] != '\n' && buf.str[buf.len-1] != ' ') {
					buf.append_unichar ( ' ' );
				}
				break;
			case '\n':
				int newlinepos = this.pos;
				this.skip_newline ();
				int reallinestartpos = this.pos;
				this.next_nonspace_char ();

				switch (this.str[this.pos+1]) {
				case '\n':
					this.append_and_create_string_taglet ( content, tree, me, buf );
					ContentPositionDocElement postag = (ContentPositionDocElement)GLib.Object.new ( postagtype );
					postag.parse ( this.settings, tree, me, content );
					content2.add ( postag );
					return ;
				case '[':
					if ( str[pos+2] == '|' ) {
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_table ( tree, me, content );
						break;
					}
					break;
				case '@':
					this.append_and_create_string_taglet ( content, tree, me, buf );
					ContentPositionDocElement postag = (ContentPositionDocElement)GLib.Object.new ( postagtype );
					postag.parse ( this.settings, tree, me, content );
					content2.add ( postag );
					this.pos = newlinepos;
					return ;
				case '#':
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_list ( tree, me, ListType.SORTED, content, new GLib.Queue<int> (), ++this.pos-reallinestartpos, -1 );
					break;
				case '*':
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_list ( tree, me, ListType.UNSORTED, content, new GLib.Queue<int> (), ++this.pos-reallinestartpos, -1 );
					break;
				}
				break;
			case '[':
				weak string cpos = this.str.offset ( this.pos );
				if ( cpos.has_prefix( "[warning:" ) ) {
					this.error ( "notifications have a predefined position.", this.next_line_offset () );
					this.run = false;
					break;
				}
				if ( str[pos+1] == '[' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_link ( tree, me, content );
					break;
				}
				buf.append_unichar ( '[' );						
				break;
			case '{':
				if ( str[pos+1] == '{' ) {
					if ( str[pos+2] == '{' ) {
						this.error ( "source samples have a predefined position.", this.next_line_offset () );
						this.run = false;
						break;
					}
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_image ( tree, me, content );
					break;
				}
				// inline taglet:
				this.append_and_create_string_taglet ( content, tree, me, buf );
				this.parse_inline_taglets ( tree, me, content );
				break;
			case '+':
				if ( str[pos+1] == '+' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_bold_content ( tree, me, content );
					break;
				}
				buf.append_unichar ( '+' );
				break;
			case '_':
				if ( str[pos+1] == '_' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_underlined_content ( tree, me, content );
					break;
				}
				buf.append_unichar ( '_' );
				break;
			case '/':
				if ( str[pos+1] == '/' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_italic_content ( tree, me, content );
					break;
				}
				buf.append_unichar ( '/' );
				break;
			default:
				buf.append_unichar ( str[pos] );
				break;
			}
		}
		ContentPositionDocElement postag = (ContentPositionDocElement)GLib.Object.new ( postagtype );
		postag.parse ( this.settings, tree, me, content );
		content2.add ( postag );
		this.run = false;
	}

	private void parse_brief_description ( Tree tree, DocumentedElement me, DocumentationTree dtree ) {
		Gee.ArrayList<DocElement> content = new Gee.ArrayList<DocElement> ();
		GLib.StringBuilder buf = new GLib.StringBuilder ( );

		for ( ; str[pos] != '\0'; this.next_char ( ) ) {
			switch ( str[pos] ) {
			case '\t':
			case ' ':
				if ( buf.str[buf.len-1] != '\n' && buf.str[buf.len-1] != ' ') {
					buf.append_unichar ( ' ' );
				}
				break;
			case '\n':
				this.skip_newline ();
				this.next_nonspace_char ();

				if ( str[pos+1] == '\n' ||  str[pos] == '\0' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					dtree.add_brief ( content );
					this.next_char ( );
					return ;
				}
				break;
			default:
				buf.append_unichar ( str[pos] );
				break;
			}
		}
		this.append_and_create_string_taglet ( content, tree, me, buf );
		dtree.add_brief ( content );
		this.run = false;
	}

	public DocumentationTree? parse ( Tree tree, DocumentedElement me, string str ) {
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
			this.error ( "invalid documentation header.", 1 );
			return null;
		}

		this.parse_brief_description ( tree, me, dtree );
		if ( this.run == false ) {
			return dtree;
		}

		for ( ; str[pos] != '\0'; this.next_char ( ) ) {
			if ( this.run == false )
				break;

			switch ( str[pos] ) {
				case '\0':
					continue ;
				case '\t':
					if ( buf.str[buf.len-1] != '\n' && buf.str[buf.len-1] != ' ') {
						buf.append_unichar ( ' ' );
					}
					break;
				case '\n':
					this.skip_newline ();
					int reallinestartpos = this.pos;
					this.next_nonspace_char ();

					switch ( str[pos+1] ) {
					case '\n':
						buf.append_unichar ( '\n' );
						paragraph++;
						break ;
					case '@':
						pos++;

						int f_starttag_linestartpos = this.linestartpos;
						int f_starttag_startpos = this.startpos;
						int f_starttag_line = this.line;
						int f_starttag_pos = this.pos;

						string name = this.parse_name ( );
						if ( name == "" ) {
							buf.append_unichar ( '@' );
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
						break;
					case '#':
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_list ( tree, me, ListType.SORTED, content, new GLib.Queue<int> (), ++this.pos-reallinestartpos, -1 );
						break;
					case '*':
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_list ( tree, me, ListType.UNSORTED, content, new GLib.Queue<int> (), ++this.pos-reallinestartpos, -1 );
						break;
					case '[':
						if ( str[pos+2] == '|' ) {
							this.append_and_create_string_taglet ( content, tree, me, buf );
							this.parse_table ( tree, me, content );
							break;
						}
						break;
					case ')':
						switch ( str[pos+2] ) {
						case ')':
							this.append_and_create_string_taglet ( content, tree, me, buf );
							this.parse_content_position ( tree, me, this.modules.righttag, content );
							break;
						case '(':
							this.append_and_create_string_taglet ( content, tree, me, buf );
							this.parse_content_position ( tree, me, this.modules.centertag, content );
							break;
						}
						break;
					default:
						if ( buf.str[buf.len-1] != '\n' && buf.str[buf.len-1] != ' ') {
							buf.append_unichar ( ' ' );
						}
						break;
					}
					break;
				case '{':
					if ( str[pos+1] == '{' ) {
						if ( str[pos+2] == '{' ) {
							this.append_and_create_string_taglet ( content, tree, me, buf );
							this.parse_source_code ( tree, me, content );
							break;
						}
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_image ( tree, me, content );
						break;
					}
					// inline taglet:
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_inline_taglets ( tree, me, content );
					break;
				case '+':
					if ( str[pos+1] == '+' ) {
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_bold_content ( tree, me, content );
						break;
					}
					buf.append_unichar ( '+' );
					break;
				case '_':
					if ( str[pos+1] == '_' ) {
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_underlined_content ( tree, me, content );
						break;
					}
					buf.append_unichar ( '_' );
					break;
				case '/':
					if ( str[pos+1] == '/' ) {
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_italic_content ( tree, me, content );
						break;
					}
					buf.append_unichar ( '/' );
					break;
				case '[':
					weak string cpos = this.str.offset ( this.pos );
					if ( cpos.has_prefix( "[warning:" ) ) {
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_notification ( tree, me, content );
						break;
					}
					if ( str[pos+1] == '[' ) {
						this.append_and_create_string_taglet ( content, tree, me, buf );
						this.parse_link ( tree, me, content );
						break;
					}
					buf.append_unichar ( '[' );						
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

	private void parse_source_code ( Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> elements ) {
		GLib.StringBuilder buf = new GLib.StringBuilder ();	
		Language lang = Language.VALA;
		int startpos = this.pos;
		this.pos = this.pos+3;

		if ( this.str[this.pos] == '#' ) {
			string line = this.extract_line ( this.pos );
			this.pos = this.pos + (int)line.length + 1;
			switch ( line.strip () ) {
			case "genie":
				lang = Language.GENIE;
				break;
			case "vala":
				lang = Language.VALA;
				break;
			case "C":
				lang = Language.C;
				break;
			default:
				this.error ( "unknown language.", startpos-this.pos+3 );
				break;
			}
			this.skip_newline ();
			this.pos++;
		}

		for ( unichar chr = this.str[this.pos]; chr != '\0'; chr = this.str[++this.pos] ) {
			switch ( chr ) {
			case '}':
				if ( this.str[this.pos+1] == '}' && this.str[this.pos+2] == '}' ) {
					SourceCodeDocElement src = (SourceCodeDocElement)GLib.Object.new ( this.modules.srctag );
					src.parse ( this.settings, tree, me, buf.str, lang );
					this.pos = this.pos+2;
					elements.add ( src );
					return;
				}
				buf.append_unichar ( '}' );
				break;
			case '\n':
				this.skip_newline ();
				buf.append_unichar ( '\n' );
				break;
			default:
				buf.append_unichar ( chr );
				break;
			}
		}
	}

	private ImageDocElementPosition parse_image_position () {
		int separatorpos = this.pos;

		for ( unichar chr = this.str[this.pos]; chr != '\0' && chr != '\n' ; chr = this.str[++this.pos] ) {
			if ( chr == '}' ) {
				string postxt = this.str.offset(separatorpos+1).ndup ( pos-separatorpos-1 );
				switch ( postxt ) {
				case "middle":
					return ImageDocElementPosition.MIDDLE;
				case "right":
					return ImageDocElementPosition.RIGHT;
				case "left":
					return ImageDocElementPosition.LEFT;
				default:
					int len = separatorpos - pos + 1;
					this.error ( "unknown position.", int.min (len, 1) );
					return ImageDocElementPosition.NEUTRAL;
				}
			}
		}
		return ImageDocElementPosition.NEUTRAL;
	}

	private void parse_image ( Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> elements ) {
		GLib.StringBuilder buf = new GLib.StringBuilder ();
		ImageDocElementPosition imgpos = ImageDocElementPosition.NEUTRAL;
		int startpos = this.pos;
		pos = pos+2;

		for ( unichar chr = this.str[this.pos]; ; chr = this.str[++this.pos] ) {
			switch ( chr ) {
			case '|':
			case '}':
				if ( chr == '|' )
					imgpos = parse_image_position ();

				if ( str[pos+1] == '}' ) {
					ImageDocElement img = (ImageDocElement)GLib.Object.new ( this.modules.imgtag );
					bool tmp = img.parse ( this.settings, tree, me, buf.str, imgpos );
					if ( tmp == false ) {
						this.error ( "image not found.", startpos-this.pos );
					}
					elements.add ( img );
					pos++;
					return ;
				}
				continue;
			case '\\':
				this.parse_escape ( buf );
				continue;
			case '\0':
			case '\n':
				this.error ( "brackets are not closed.", startpos-this.pos );
				return;
			default:
				buf.append_unichar ( chr );
				continue ;
			}
		}
		this.error ( "brackets are not closed.", startpos-this.pos );
		this.run = false;
	}

	private bool check_link_path ( int startpos, GLib.StringBuilder buf ) {
		if ( buf.str.has_prefix ( "http://" ) || buf.str.has_prefix ( "/" ))
			return true;

		this.error ( "invalid link", startpos-this.pos );
		return false;
	}

	private Gee.ArrayList<DocElement>? parse_link_text ( Tree tree, DocumentedElement me, int startpos ) {
		Gee.ArrayList<DocElement> content = new Gee.ArrayList<DocElement> ();
		GLib.StringBuilder buf = new GLib.StringBuilder ();
		int separatorpos = ++this.pos;

		for ( unichar chr = this.str[this.pos]; chr != '\0' && chr != '\n' ; chr = this.str[++this.pos] ) {
			switch ( chr ) {
			case ']':
				if ( this.str[pos+1] == ']' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					if ( content.size == 0 ) {
						int pos = separatorpos-this.pos;
						this.error ( "invalid name", (pos == 0)? -1 : pos );
						return null;
					}
					return content;
				}
				buf.append_unichar ( chr );
				break;
			case '\0':
			case '\n':
				this.run = false;
				return null;
			case '\t':
			case ' ':
				if ( buf.len > 0 && buf.str[buf.len-1] != ' ') {
					buf.append_unichar ( ' ' );
				}
				break;
			case '+':
				if ( str[pos+1] == '+' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_bold_content ( tree, me, content, false );
					break;
				}
				buf.append_unichar ( '+' );
				break;
			case '_':
				if ( str[pos+1] == '_' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_underlined_content ( tree, me, content, false );
					break;
				}
				buf.append_unichar ( '_' );
				break;
			case '/':
				if ( str[pos+1] == '/' ) {
					this.append_and_create_string_taglet ( content, tree, me, buf );
					this.parse_italic_content ( tree, me, content, false );
					break;
				}
				buf.append_unichar ( '/' );
				break;
			default:
				buf.append_unichar ( chr );
				break;
			}
		}
		this.run = false;
		return null;
	}

	private void parse_link ( Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> elements ) {
		GLib.StringBuilder buf = new GLib.StringBuilder ();
		int startpos = this.pos;
		this.pos = this.pos+2;
 
		for ( unichar chr = this.str[this.pos]; ; chr = this.str[++this.pos] ) {
			switch ( chr ) {
			case '|':
			case ']':
				bool linkstat = this.check_link_path ( startpos+2, buf );
				Gee.ArrayList<DocElement>? txt = null;

				if ( chr == '|' ) {
					txt = parse_link_text ( tree, me, startpos );
				}

				if ( this.str[this.pos+1] == ']' ) {
					bool tmp = check_link_path ( startpos, buf );
					if ( tmp == true && linkstat == true ) {
						LinkDocElement linktag = (LinkDocElement)GLib.Object.new ( this.modules.linktag );
						linktag.parse ( this.settings, tree, me, buf.str, txt );
						elements.add ( linktag );
					}
					pos++;
					return ;
				}
				buf.append_unichar ( ']' );
				continue;
			case '\\':
				this.parse_escape ( buf );
				continue;
			case '\0':
			case '\n':
				this.error ( "brackets are not closed.", startpos-this.pos );
				this.run = false;
				return;
			default:
				buf.append_unichar ( chr );
				continue ;
			}
		}
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
