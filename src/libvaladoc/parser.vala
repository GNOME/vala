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

public abstract class Taglet : Object {
	public abstract bool write ( void* res, int max, int index );

	// => Regexp
	protected weak string get_next_word ( string str, out string param ) {
		GLib.StringBuilder buf = new GLib.StringBuilder ();

		for ( unichar chr = str.get_char(); chr != '\0' ; str = str.next_char(), chr = str.get_char() ) {
			if ( !chr.isspace() )
				break;
		}

		for ( unichar chr = str.get_char(); chr != '\0' ; str = str.next_char(), chr = str.get_char() ) {
			if ( chr.isspace() )
				break;

			buf.append_unichar ( chr );
		}

		param = buf.str.strip();
		return str;
	}

	// remove
	protected static string strip_string ( string str, out int start_line, out int start_pos, out int end_line, out int end_pos ) {
		int lpos = (int)str.length - 1;
		int pos = 0;

		while ( str[pos] != '\0' && str[pos].isspace () ) {
			if ( str[pos] == '\n' ) {
				start_line = start_line+2;
				start_pos = 0;
			}
			else {
				start_pos++;
			}
			pos++;
		}

		while ( lpos >= 0 && str[lpos].isspace () ) {
			if ( str[lpos] == '\n' ) {
				end_line = end_line+2;
			}
			lpos--;
		}

		while ( lpos != 0 && str[lpos] == '\n' ) {
			end_pos++;
			lpos--;
		}

		string striped = str.offset(pos).ndup ( lpos-pos+1 );
		end_line += start_line;

		for ( int i = 0; striped[i] != '\0'; i++ ) {
			if ( striped[i] == '\n' ) {
				end_line = end_line+2;
			}
		}

		if ( end_line == 0 ) {
			end_pos = lpos;
		}

		return striped;
	}

	protected static string? extract_lines ( string content, int line1, int line2 ) {
		if ( line1 > line2 )
			return null;

		string[] lines = content.split ( "\n" );
		int lines_len = 0; for ( ; lines[lines_len] != null; lines_len++ );


		if ( lines_len <= line2 )
			return null;

		GLib.StringBuilder str = new GLib.StringBuilder ();

		while ( line1 < line2+1 ) {
			str.append ( lines[line1] );
			line1++;
	
			if ( line1 < line2+1 )
				str.append_unichar ( '\n' );
		}
		return str.str;
	}

	// remove
	public void init ( ) {
	}
}

public abstract class MainTaglet : Taglet {
	public virtual int order {
		get { return 0; }
	}

	public virtual bool compare_function ( MainTaglet x  ) {
		return false;
	}

	public abstract bool write_block_start ( void* res );
	public abstract bool write_block_end ( void* res );
	public abstract bool parse ( Valadoc.Settings settings, Valadoc.Tree tree, Valadoc.Reporter reporter, string linestart, int line, int pos, Valadoc.Basic me, Gee.ArrayList<Taglet> content );
}

public abstract class InlineTaglet : Taglet {
	public abstract bool parse ( Valadoc.Settings settings, Valadoc.Tree tree, Valadoc.Reporter reporter, string linestart, int line, int pos, Valadoc.Basic me, string content );
}

public abstract class StringTaglet : Taglet {
	public string content {
		protected set;
		get;
	}

	public abstract bool parse ( Valadoc.Settings settings, Valadoc.Tree tree, string content );

	// remove
	public string extract_first_word ( ) { return ""; }

	// remove
	// add counter-stuff!
	public string extract_first_word2 ( out int word_line, out int word_pos, ref int line, ref int pos ) {
		GLib.StringBuilder buf = new GLib.StringBuilder ( "" );
		string str = this.content;

		if ( str == null ) {
			return ""; // FIXME: str should never be null
		}

		for ( unichar chr = str.get_char(); chr != '\0'; str = str.next_char(), chr = str.get_char() ) {
			if ( !chr.isspace() )
				break;

			pos++;

			if ( chr == '\n' ) {
				line = line+2;
				pos = 0;
			}
		}

		word_line = line;
		word_pos = pos;

		for ( unichar chr = str.get_char(); chr != '\0' ; str = str.next_char(), chr = str.get_char() ) {
			if ( chr.isspace() )
				break;

			pos++;

			buf.append_unichar ( chr );
		}

		this.content = str;
		return buf.str;
	}
}






private enum ReporterMessageType {
	WARNING,
	ERROR
}


public class Reporter : Object {
	private int __warnings;
	private int __errors;

	public int warnings {
		get {
			return this.__warnings;
		}
	}

	public int errors {
		get {
			return this.__errors;
		}
	}

	private bool new_message (	ReporterMessageType type, int startline, int startchr, int endline, int endchr, string errtxt, string lines ) {
		string filename = "filename.vala";
		string typestr = (type == ReporterMessageType.WARNING)?"warning":"error";

		stdout.printf ( "%s:%d.%d-%d.%d: %s: %s", filename, startline, startchr, endline, endchr, typestr, errtxt );


		string[] linev = lines.split ( "\n" );
		if ( linev == null ) {
			linev = new string[2];
			linev[0] = lines;
			linev[1] = null;
		}

		for ( int i = 0; linev[i] != null ; i++ ) {
			int rl = i + startline;
			stdout.printf ( "\t %s\n", linev[i] );

			if ( rl == startline ) {
				int len = (int)linev[i].len ( );
				int ulen;


				if ( startline == endline )
					ulen = ( endchr == startchr )? 1 : endchr - startchr;
				else
					ulen = len - startchr;

				string ustr = string.nfill ( ulen, '^' );
				string sstr = string.nfill ( startchr, ' ' );
				stdout.printf ( "\t%s%s\n", sstr, ustr );
			}
/*			else if ( rl == endline ) {
				string ustr = string.nfill ( endchr, '^' );
				stdout.printf ( "\t%s\n", ustr );
			}
			else {
				long len = linev[i].len ( );
				string ustr = string.nfill ( len, '^' );
				stdout.printf ( "\t%s\n", ustr );
			}
*/
		}
		return true;
	}

	public bool add_warning (int startline, int startchr, int endline, int endchr, string errtxt, string lines ) {
		this.__warnings++;

		return this.new_message ( ReporterMessageType.WARNING, startline, startchr, endline,
					endchr, errtxt, lines );
	}

	public bool add_error (int startline, int startchr, int endline, int endchr, string errtxt, string lines ) {
		this.__errors++;

		return this.new_message ( ReporterMessageType.ERROR, startline, startchr, endline,
					endchr, errtxt, lines );
	}
}



public class DocumentationTree : Object {
	private Gee.ArrayList<InlineTaglet> description = new Gee.ArrayList<InlineTaglet> ();
	private Gee.HashMap<string, Gee.ArrayList<MainTaglet> > taglets
		= new Gee.HashMap<string, Gee.ArrayList<MainTaglet> > ( GLib.str_hash, GLib.str_equal );

	public bool add_taglet ( string tag, MainTaglet taglet ) {
		if ( this.taglets.contains ( tag ) ) {
			Gee.ArrayList<MainTaglet> lst = this.taglets.get ( tag );
			lst.add ( taglet );
			return true;
		}
		else{
			Gee.ArrayList<MainTaglet> nlst = new Gee.ArrayList<MainTaglet> ();
			nlst.add ( taglet );
			this.taglets.set ( tag, nlst );
			return true;
		}
	}

	public bool add_description ( Gee.ArrayList<Taglet> content ) {
		this.description = content;
		return true;
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

	public bool write ( void* res ) {
		bool tmp;

		int max = this.description.size;
		int i;

		foreach ( InlineTaglet tag in this.description ) {
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



public class Parser : Object {
	private Gee.HashMap< string, GLib.Type > taglets;
	private GLib.Type stringtag;
	private Reporter reporter;
	private Settings settings;

	public void init ( Settings settings, Reporter reporter, GLib.Type strtag, Gee.HashMap< string, GLib.Type > taglets ) {
		this.reporter = reporter;
		this.stringtag = strtag;
		this.settings = settings;
		this.taglets = taglets;
	}

	private static inline string extract_line ( string str ) {
		str = str.next_char();
		weak string? pos = str.chr ( -1, '\n' );
		if ( pos == null )
			return str;

		string line = str.ndup ( (char*)pos - (char*)str );
		return line;
	}

	private inline bool skip_documentation_header ( ref string str, ref int linenr, ref int pos ) {
		string linestart = str;

		int borderpos = pos;

		if ( str[0] != '*' ) {
			string line = Parser.extract_line ( str );
			this.reporter.add_error ( linenr, 0, linenr, (int)line.len(), "Comment is not a documentation string.\n", string.nfill(borderpos, ' ')+"/*"+line );
			return false;
		}

		str = str.next_char();
		pos++;

		for ( unichar chr = str.get_char(); chr != '\0' ; str = str.next_char(), chr = str.get_char() ) {
			if ( chr == '\n' ) {
				linenr++;
				pos = 0;
				return true;
			}

			pos++;

			if ( !chr.isspace() ) {
				string line = Parser.extract_line ( linestart );
				this.reporter.add_error ( linenr, 0, linenr, (int)line.len() + 3, "Comment is not a documentation string.\n", string.nfill(borderpos, ' ')+"/*"+line );
				return false;
			}
		}
		string line = Parser.extract_line ( linestart );
		this.reporter.add_error ( linenr, 0, linenr, (int)line.len() + 3, "Incomplete Documentation header\n", string.nfill(borderpos, ' ')+"/*"+line );
		return false;
	}

	// rm linenr
	private bool skip_deadh_zone ( ref string str, ref unichar chr, int linenr, ref int pos ) {
		string linestart = str;

		str = str.next_char();
		pos = 0;

		for ( chr = str.get_char(); chr != '\0' ; str = str.next_char(), chr = str.get_char() ) {
			pos++;

			if ( chr == '*' )
				return true;

			if ( !chr.isspace() ) {
				int endpos = 0;

				string line = Parser.extract_line ( linestart );
				weak string? endposstr = str.chr( line.len(), '*' );
				if ( endposstr != null ) {
					endpos = (int)(linestart.len() - endposstr.len());
				}

				this.reporter.add_error ( linenr, pos, linenr, endpos, "Invalid documentation body.\n", line );
				return false;
			}
		}
		// end of comment
		return true;
	}

	private inline void set_prev_chr ( out unichar prev, out unichar prevprev, unichar push )  {
		prevprev = prev;
		prev = push;
	}

	private string? parse_taglet_name ( ref string str, out unichar prevchr, out unichar prevprevchr, ref string linestart, ref int linenr, ref int pos ) {
		GLib.StringBuilder buf = new GLib.StringBuilder ();

		str = str.next_char();
		int startpos = pos;

		for ( unichar chr = str.get_char(); chr != '\0' ; str = str.next_char(), chr = str.get_char() ) {
			this.set_prev_chr ( out prevchr, out prevprevchr, chr );

			pos++;

			if ( chr == '\n' ) {
				linestart = str;
				linenr++;
				pos = 0;

				this.skip_deadh_zone ( ref str, ref chr, linenr, ref pos );
//				this.set_prev_chr ( out prevchr, out prevprevchr, 'p' );
				return buf.str;
			}

			if ( chr.isspace() ) {
				return buf.str;
			}

			if ( !((chr >= 'a' && chr <= 'z') || (chr >= 'A' && chr <= 'Z')) ) {
				string line = this.extract_line ( linestart );
				string reportmsg =  "invalide taglet name.\n";
				int endpos = pos;

				for ( unichar chr = str.get_char(); chr != '\0' ; str = str.next_char(), chr = str.get_char() ) {
					if ( chr.isspace() )
						break;

					endpos ++;
				}

				this.reporter.add_error (linenr, startpos, linenr, endpos, reportmsg, line );
				return null;
			}
			buf.append_unichar ( chr );
		}
		string line = this.extract_line ( linestart );
		string reportmsg = "Incomplete Taglet.\n";
		this.reporter.add_error (linenr, startpos, linenr, (int)line.len(), reportmsg, line );
		return null;
	}

	public StringTaglet create_string_tag ( Valadoc.Tree tree, Valadoc.Basic me, string start_line, int linenr, int pos, string str ) {
		StringTaglet strt = (StringTaglet)GLib.Object.new ( this.stringtag );
		strt.init (  );

//		strt.parse ( Valadoc.Settings settings, Valadoc.Tree tree, string content );
		strt.parse ( this.settings, tree, str );
		return strt;
	}


	public bool append_new_tag ( Valadoc.Tree mtree, Valadoc.Basic me, DocumentationTree tree, string? name, Gee.ArrayList<Taglet> content, string linestart, int linenr, int pos ) {
		if ( name == null ) {
			tree.add_description ( content );
			return true;
		}

		if ( !this.taglets.contains( name ) ) {
			string line = this.extract_line ( linestart );
			string reportmsg = "Taglet '%s' is not registered.\n".printf( name );
			this.reporter.add_error (linenr, pos, linenr, pos+(int)name.len()+1, reportmsg, line );
			return false;
		}

		GLib.Type type = this.taglets.get ( name );
		Taglet taglet = (Taglet)GLib.Object.new ( type );
		if ( taglet is MainTaglet == false ) {
			string line = this.extract_line ( linestart );
			string reportmsg = "'%s' is an inline taglet.\n".printf( name );
			this.reporter.add_error (linenr, pos, linenr, pos+(int)name.len()+1, reportmsg, line );
			return false;
		}

		taglet.init ();
		((MainTaglet)taglet).parse ( this.settings, mtree, this.reporter, linestart.offset(1), linenr, pos, me, content );
		tree.add_taglet ( name, (MainTaglet)taglet );
		return true;
	}

	private inline void skip_spaces ( ref string str, ref int pos ) {
		for ( unichar chr = str.get_char(); chr != '\0' ; str = str.next_char(), chr = str.get_char() ) {
			pos++;
			if ( !chr.isspace() )
				return ;
		}
	}


	// add line counting
	private InlineTaglet? parse_bracket ( Valadoc.Tree tree, Valadoc.Basic me, ref string str, ref string linestart, ref int linestartnr, ref int linenr, ref int pos ) {
		int startpos = pos;

		str = str.next_char();
		pos++;

		string tagline = linestart;

		string? currtagname = "";
		unichar prevprevchr = '\0';
		unichar prevchr = '\0';

		GLib.StringBuilder buf = new GLib.StringBuilder ();
		this.skip_spaces ( ref str, ref pos );

		int taglinenr = linenr;
		int tagpos = pos-1;

		if (  str[0] != '@' ) {
			string line = this.extract_line ( linestart );
			string reportmsg = "Bracket is not allowed in this context.\n";
			this.reporter.add_error ( linenr, startpos, linenr, startpos, reportmsg, line );
			return null;
		}

		string? tagname = this.parse_taglet_name ( ref str, out prevchr, out prevprevchr, ref linestart, ref linenr, ref pos );
		if ( tagname == null )
			return null;

		str = str.next_char();
//		pos++;

		if ( !this.taglets.contains( tagname ) ) {
			string line = this.extract_line ( linestart );
			string reportmsg = "Taglet '%s' is not registered.\n".printf( tagname );
			this.reporter.add_error (linenr, startpos+1, linenr, startpos+(int)tagname.len()+2, reportmsg, line );
			return null;
		}

		GLib.Type tagtype = this.taglets.get ( tagname );
		GLib.Object tag = GLib.Object.new (tagtype );
		if ( tag is InlineTaglet == false ) {
			string line = this.extract_line ( linestart );
			string reportmsg = "'%s' is not an inline taglet.\n".printf( tagname );
			this.reporter.add_error (linenr, tagpos, linenr, tagpos+(int)tagname.len()+1, reportmsg, line );
			return null;
		}


		for ( unichar chr = str.get_char(); chr != '\0' ; str = str.next_char(), chr = str.get_char() ) {
			pos++;

			bool tmp = this.escaped_characters ( ref str, linestart, linenr, ref chr, ref prevchr, ref prevprevchr, ref pos );
			if ( tmp == true ) {
				buf.append_unichar ( chr );
				continue ;
			}

			tmp = this.newline_handler ( buf, ref linestart, ref str, ref linenr, ref pos, ref linestartnr, ref chr, ref prevchr, ref prevprevchr );
			if ( chr == '\0' ) {
				stdout.printf ( ">>WTF<<\n" );
				break;
			}
			else if ( tmp == true ) {
				continue;
			}

			tmp = this.skip_double_spaces ( ref str, buf, chr, ref prevchr, ref prevprevchr );
			if ( tmp == true )
				continue ;


			if ( chr == '}' ) {
				if ( prevchr.isspace() )
					buf.erase ( buf.len-1, -1);

				InlineTaglet rtag = ((InlineTaglet)tag);
				rtag.init ( );

				rtag.parse ( this.settings, tree, this.reporter, tagline.offset(1), taglinenr, tagpos, me, buf.str );
				return rtag;
			}

			if ( chr == '@' || chr == '{' ) {
				string line = this.extract_line ( linestart );
				string reportmsg = "Error: Character is not allowed in this context.\n";
				this.reporter.add_error (linenr, pos-1, linenr, pos-1, reportmsg, line );
				return null;
			}


			buf.append_unichar ( chr );
			this.set_prev_chr ( out prevchr, out prevprevchr, chr );
		}

		string line = this.extract_line ( linestart );
		string reportmsg = "Warning: Bracket is not closed.\n";
		this.reporter.add_error (linenr, startpos, linenr, (int)linestart.len(), reportmsg, line );
		return null;
	}

	private inline bool skip_double_spaces ( ref string str, GLib.StringBuilder buf,unichar chr, ref unichar prevchr, ref unichar prevprevchr ) {
		if ( chr.isspace() ) {
			buf.append_unichar ( ' ' );

			if ( prevchr.isspace() )
				return true;

			string tmpstr = str.next_char();
			unichar nextchr = tmpstr.get_char();

			if ( nextchr.isspace() )
				return true;

			this.set_prev_chr ( out prevchr, out prevprevchr, ' ' );
			return true;
		}
		return false;
	}

	private inline bool escaped_characters ( ref string str, string linestart, int linenr, ref unichar curchr, ref unichar prevchr, ref unichar prevprevchr, ref int pos ) {
		if ( curchr == '\\' ) {
			str = str.next_char();
			curchr = str.get_char();

			prevprevchr = prevchr;
			prevchr = '\\';

			if (!( curchr == '@' || curchr == '{' || curchr == '}' || curchr == '\\' )) {
				GLib.StringBuilder unichrstr = new GLib.StringBuilder ( "" );
				unichrstr.append_unichar( curchr );

				string line = this.extract_line ( linestart );
				string reportmsg = "'\\%s' is not a valid character.\n".printf ( unichrstr.str );
				this.reporter.add_error (linenr, pos, linenr, pos+2, reportmsg, line );
				return false;
			}
			return true;
		}
		return false;
	}

	private bool newline_handler ( GLib.StringBuilder buf, ref string linestart, ref string str, ref int linenr, ref int pos, ref int linestartnr, ref unichar chr, ref unichar prevchr, ref unichar prevprevchr ) {
		if ( chr == '\n' ) {
			linestartnr = linenr;
			linestart = str;
			linenr++;
			pos = 0;

			this.skip_deadh_zone ( ref str, ref chr, linenr, ref pos );
			if ( chr == '\0' )
				return false;

			if ( prevchr == '\n' ) {
				buf.append_unichar ( '\n' );
			}

			this.set_prev_chr ( out prevchr, out prevprevchr, '\n' );
			return true;
		}
		return false;
	}

	public DocumentationTree? parse ( Valadoc.Tree tree, Valadoc.Basic me, string str2 ) {
		if ( me is Valadoc.Property ) {
			stdout.printf ( "PROPERTY\n" );
		}
		else if ( me is Valadoc.Signal ) {
			stdout.printf ( "SIGNAL\n" );
		}
		else if ( me is Valadoc.Class ) {
			stdout.printf ( "CLASS\n" );
		}
		else if ( me is Valadoc.Interface ) {
			stdout.printf ( "INTERFACE\n" );
		}
		else if ( me is Valadoc.Delegate ) {
			stdout.printf ( "DELEGATE\n" );
		}
		else if ( me is Valadoc.Namespace ) {
			stdout.printf ( "NAMESPACE\n" );
		}
		else if ( me is Valadoc.Method ) {
			stdout.printf ( "METHOD\n" );
		}
		else if ( me is Valadoc.Field ) {
			stdout.printf ( "FIELD\n" );
		}
		else if ( me is Valadoc.Constant ) {
			stdout.printf ( "CONSTANT\n" );
		}
		else if ( me is Valadoc.Struct ) {
			stdout.printf ( "STRUCT\n" );
		}
		else if ( me is Valadoc.Enum ) {
			stdout.printf ( "ENUM\n" );
		}
		else if ( me is Valadoc.EnumValue ) {
			stdout.printf ( "ENUMVALUE\n" );
		}
		else if ( me is Valadoc.ErrorCode ) {
			stdout.printf ( "ERRORCODE\n" );
		}
		else if ( me is Valadoc.ErrorDomain ) {
			stdout.printf ( "ERRORDOMAIN\n" );
		}
		else {
			stdout.printf ( "Gut ^_^\n" );
		}

		stdout.printf ( "============= %s =============\n", me.full_name() );

		string str = str2;

		GLib.StringBuilder buf = new GLib.StringBuilder ();
		DocumentationTree doctree = new DocumentationTree ();

		int linenr = 0;
		int pos = 0;


		bool tmp = this.skip_documentation_header ( ref str, ref linenr, ref pos );
		if ( tmp == false ) {
		stdout.printf ( "-----------------------\n" );
			return null;
		}

		Gee.ArrayList<Taglet> content = new Gee.ArrayList<Taglet> ();
		string? currtagname = null;
		string currtagline = str;
		int currtagstartpos = 0;
		int currtagstartlinenr = 0;


		unichar prevprevchr = '\0';
		unichar prevchr = '\0';

		// weak
		string? linestart = str;
		int linestartnr = 0;

		for ( unichar chr = str.get_char(); chr != '\0' ; str = str.next_char(), chr = str.get_char() ) {
			pos++;

			bool tmp = this.escaped_characters ( ref str, linestart, linenr, ref chr, ref prevchr, ref prevprevchr, ref pos );
			if ( tmp == true ) {
				buf.append_unichar ( chr );
				continue ;
			}

			tmp = this.newline_handler ( buf, ref linestart, ref str, ref linenr, ref pos, ref linestartnr, ref chr, ref prevchr, ref prevprevchr );
			if ( chr == '\0' ) {
				break;
			}
			else if ( tmp == true ) {
				continue;
			}

			tmp = this.skip_double_spaces ( ref str, buf, chr, ref prevchr, ref prevprevchr );
			if ( tmp == true )
				continue ;


			if ( chr == '{' ) {
				// <
				if ( buf.len > 0 ) {
					StringTaglet strtag = this.create_string_tag ( tree, me, linestart, linenr, pos, buf.str );
					content.add ( strtag );
					prevchr = '}';
					buf.erase ( 0, -1 );
				}
				// >

				InlineTaglet itag = this.parse_bracket ( tree, me, ref str, ref linestart, ref linestartnr, ref linenr, ref pos );
				if ( itag == null ) {
		stdout.printf ( "-----------------------\n" );
					return null;
				}
				content.add ( itag );
				continue ;
			}
			else if ( chr == '}' ) {
				string line = this.extract_line ( linestart );
				this.reporter.add_error (linenr, pos, linenr, pos, "syntax error.\n", line );
		stdout.printf ( "-----------------------\n" );
				return null;
			}
			else if ( chr == '@' && prevchr.isspace() ) {
				// <
				if ( buf.len > 0 ) {
					StringTaglet strtag = this.create_string_tag ( tree, me, linestart, linenr, pos, buf.str );
					content.add ( strtag );
					buf.erase ( 0, -1 );
				}
				this.append_new_tag ( tree, me, doctree, currtagname, content, currtagline, currtagstartlinenr, currtagstartpos );
				// >
				content = new Gee.ArrayList<InlineTaglet> ();

				currtagstartlinenr = linenr;
				currtagstartpos = pos;
				currtagline = linestart;

				currtagname = this.parse_taglet_name ( ref str, out prevchr, out prevprevchr, ref linestart, ref linenr, ref pos );
				continue ;
			}

			buf.append_unichar ( chr );
			this.set_prev_chr ( out prevchr, out prevprevchr, chr );
		}

		if ( buf.len > 0 ) {
			StringTaglet strtag = this.create_string_tag ( tree, me, linestart, linenr, pos, buf.str );
			content.add ( strtag );
		}

		stdout.printf ( "-----------------------\n" );

		this.append_new_tag ( tree, me, doctree, currtagname, content, currtagline, currtagstartlinenr, currtagstartpos );
		tmp = this.check_foother ( ref linestart, linenr );
		if ( tmp == false )
			return null;
		return doctree;
	}

	private inline bool check_foother ( ref string lastline, int linenr ) {
		for ( unichar chr = lastline.get_char(); chr != '\0' ;
			lastline = lastline.next_char(), chr = lastline.get_char() )
		{
			if ( chr.isspace() )
				continue ;

			string line = this.extract_line ( lastline );
			string reportmsg = "syntax error - invalid body.\n";
			this.reporter.add_error (linenr, 0, linenr, (int)line.len()+1, reportmsg, line+"*/" );
			return false;
		}
		return true;
	}

	protected static bool is_documentation ( string cmnt ) {
		if ( cmnt[0] != '*' )
			return false;

		for ( int i = 1; !(cmnt[i] == '\n' || cmnt[i] == '\0') ; i++ ) {
			if ( cmnt[i].isspace() )
				continue;

			return false;
		}

		return true;
	}

	protected static bool is_inherit_doc ( string? cmnt ) {
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
