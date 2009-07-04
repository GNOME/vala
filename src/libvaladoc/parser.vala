
using GLib;




public class Valadoc.Parser : Object {
	private ModuleLoader modules;
	private Settings settings;
	private ErrorReporter err;
	private Tree tree;

	public Parser ( Settings settings, ErrorReporter reporter, Tree tree, ModuleLoader modules ) {
		this.settings = settings;
		this.modules = modules;
		this.err = reporter;
		this.tree = tree;
	}

	/* == error: == */
	private enum ErrorNumber {
		UNKNOWN_TAGLET,
		MISSING_IMAGE,
		INVALID_LINK,
		OPEN_TAG,
		TABLE_CELL_ATTRIBUTES,
		TABLE_CELL,
		CONTEXT
	}

	private struct ErrMsg {
		public ErrorLevel lvl;
		public string msg;
	}

	private const ErrMsg[] errmsg = {
			{ ErrorLevel.ERROR, "Taglet does not exist" },
			{ ErrorLevel.ASSUMPTION, "Image not found" },
			{ ErrorLevel.ASSUMPTION, "Invalid address specified" },
			{ ErrorLevel.ASSUMPTION, "Tag may be not closed" },
			{ ErrorLevel.ASSUMPTION, "Cell attributes may be broken" },
			{ ErrorLevel.ASSUMPTION, "Cell may be broken" },
			{ ErrorLevel.ERROR, "Taglet is not allowed in this context" }
		};

	private void printr ( ErrorNumber errno, string filename, string str, long strlen,  long line, long linestartpos, long pos, long len ) {
		this.printr_custom ( errmsg[(int)errno].lvl, filename, str, strlen, line, linestartpos, pos, len, errmsg[(int)errno].msg );
	}

	private void printr_custom ( ErrorLevel errlvl, string filename, string str, long strlen,  long line, long linestartpos, long pos, long len, string errmsg ) {
		if ( this.settings.verbose == false && errlvl == ErrorLevel.ASSUMPTION ) {
			return ;
		}

		weak string linestr = str.offset( linestartpos );
		if (linestr[0] == '\r') {
			linestr = linestr.offset(1);
//			linestartpos++;
			len--;
		}

		if ( linestr[0] == '\n' ) {
			linestr = linestr.offset(1);
//			linestartpos++;
			len--;
		}

		weak string end = linestr.chr( -1, '\n' );
		long linelen = (end == null)? (long)linestr.len() : linestr.pointer_to_offset(end);


		long underlinestartpos = pos-linestartpos;
		long underlineendpos = underlinestartpos+((len == -1)?(linelen-(pos-linestartpos)):len);

		if ( errlvl == ErrorLevel.ERROR ) {
			this.err.error ( filename, line, underlinestartpos, /*pos-linestartpos*/ underlineendpos, linestr.ndup(linelen), errmsg );
		}
		else {
			this.err.warning ( filename, line, underlinestartpos, /*pos-linestartpos*/ underlineendpos, linestr.ndup(linelen), errmsg );
		}
	}

	/* == helpers == */
	private StringTaglet create_string_taglet (string str, long strlen, ref long startpos, long pos, long lpos, StringBuilder buf ) {
		buf.append_len (str.offset(startpos), lpos-startpos);
		StringTaglet strtag = (StringTaglet)GLib.Object.new ( this.modules.strtag );
		strtag.parse ( buf.str );
		buf.erase ( 0, -1 );
		startpos = pos+1;
		return strtag;
	}

	private void prepend_string_taglet (string str, long strlen, Gee.ArrayList<DocElement> content, ref long startpos, long pos, long lpos, StringBuilder buf ) {
		StringTaglet strtag = this.create_string_taglet (str, strlen, ref startpos, pos, lpos, buf );
		content.insert (content.size-1, strtag);
	}

	private void append_string_taglet (string str, long strlen, Gee.ArrayList<DocElement> content, ref long startpos, long pos, long lpos, StringBuilder buf ) {
		StringTaglet strtag = this.create_string_taglet ( str, strlen, ref startpos, pos, lpos, buf );
		content.add ( strtag );
	}


	/* == rules: == */
	private bool skip_deadzone_pos ( string str, long strlen, ref long pos, ref long line, ref long linestartpos, bool wikimode ) {
		linestartpos=pos;
		for ( pos++; str[pos]==' '||str[pos]=='\t' ; pos++ );
		line++;

		if ( wikimode == false ) {
			if ( str[pos]=='*' ) {
				linestartpos = pos;
				return true;
			}
		}

		linestartpos = --pos;
		return true;
	}

	private bool parse_newline_pos ( string str, long strlen, ref long npos, ref long nline, ref long nnewlinepos, bool wikimode ) {
		if ( str[npos] == '\n' ) {
			return this.skip_deadzone_pos (str, strlen, ref npos, ref nline, ref nnewlinepos, wikimode);
		}
		return false;
	}

	private bool parse_linebreak_pos ( string str, long strlen, ref long npos, ref long nline, ref long nnewlinepos, bool wikimode) {
		if ( str[npos] == '\\' ) {
			long newlinepos = nnewlinepos;
			long line = nline;
			long pos = npos;

			long mpos =  pos+1;
			for ( ; str[mpos]==' '||str[mpos]=='\t' ; mpos++ );
			if ( str[mpos]=='\r' )
				mpos++;

			if ( str[mpos]=='\n' ) {
				pos = mpos;
				if (this.skip_deadzone_pos (str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
					nnewlinepos = newlinepos;
					nline = line;
					npos = pos;
					return true;
				}
				return false;
			}
		}
		return false;
	}

	private string? parse_taglet_name ( Documented? curelement, string str, long strlen, ref long pos, long line, long newlinepos, long npos ) {
		long startpos = pos;
		for ( ; str[pos]!=' '&&str[pos]!='\t'&&str[pos]!='\n'&&str[pos]!='\0'; pos++ );
		if ( str[pos]=='\0'|| !str[pos].isspace() ) {
			if (curelement != null) {
				this.printr ( ErrorNumber.OPEN_TAG, curelement.get_filename(), str, strlen, line, newlinepos, npos, -1 );
			}
			return null;
		}
		return str.substring ( startpos, pos-startpos );
	}

	private bool parse_inline_taglet_pos ( Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long nline, ref long nnewlinepos, bool wikimode ) {
		if ( str[npos] != '{' ) {
			return false;
		}

		long newlinepos = nnewlinepos;
		long line = nline;
		long pos = npos;


		for (pos++; str[pos]!='@' && pos<strlen; pos++ ) {
			if (str[pos]==' '||str[pos]=='\t') {
				continue;
			}

			if(this.parse_linebreak_pos(str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				continue ;
			}

			return false;
		}

		if ( str[pos]!='@' ) {
			return false;
		}

		long keywordnewlinepos = newlinepos;
		long keywordstartpos = pos;
		long keywordline = line;
		pos++;

		string keyword = this.parse_taglet_name ( curelement, str, strlen, ref pos, line, newlinepos, npos );
		if ( keyword == null ) {
			return false;
		}

		if ( !this.modules.taglets.contains(keyword) ) {
			this.printr ( ErrorNumber.UNKNOWN_TAGLET, curelement.get_filename (), str, strlen, line, newlinepos, keywordstartpos, keyword.len()+1 );
			return false;
		}

		Taglet taglet = (Taglet)GLib.Object.new ( this.modules.taglets.get (keyword) );
		if ( taglet is InlineTaglet == false) {
			this.printr ( ErrorNumber.CONTEXT, curelement.get_filename (), str, strlen, line, newlinepos, keywordstartpos, keyword.len()+1 );
			return false;
		}


		for ( ; str[pos]==' '||str[pos]=='\t'; pos++ );
		if ( str[pos]=='\0' ) {
			this.printr ( ErrorNumber.OPEN_TAG, curelement.get_filename (), str, strlen, line, newlinepos, npos, -1 );
			return false;
		}

		GLib.StringBuilder strcontent = new GLib.StringBuilder ();
		long contentstartpos = pos;

		for ( ;str[pos]!='}'; pos++ ) {
			long looppos = pos;
			if(this.parse_linebreak_pos(str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				strcontent.append ( str.substring ( contentstartpos, looppos-contentstartpos) );
				contentstartpos = pos+1;
			}
			else if ( str[pos]=='\0'||str[pos]=='\n' ) {
				this.printr ( ErrorNumber.OPEN_TAG, curelement.get_filename (), str, strlen, line, newlinepos, npos, -1 );
				return false;
			}
		}

		strcontent.append ( str.substring ( contentstartpos, pos-contentstartpos ) );

		ErrorLevel errlvl = ErrorLevel.ASSUMPTION;
		string? errmsg;

		if( !((InlineTaglet)taglet).parse ( this.settings, this.tree, curelement, strcontent.str, ref errlvl, out errmsg ) ) {
			this.printr_custom ( errlvl, curelement.get_filename (), str, strlen, keywordline, keywordnewlinepos, keywordstartpos, keyword.len()+1, errmsg );
		}

		content.add ( taglet );

		nnewlinepos = newlinepos;
		nline = line;
		npos = pos;
		return true;
	}

	private bool parse_align_pos (Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long pos, ref long line, ref long newlinepos, ref long space, bool wikimode ) {
		if ( this.parse_align_helper (curelement, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, wikimode, this.modules.righttag, "))" ) ) {
			return true;
		}

		if ( this.parse_align_helper (curelement, str, strlen,  content, ref pos, ref line, ref newlinepos, ref space, wikimode, this.modules.centertag, ")(" ) ) {
			return true;
		}
		return false;
	}

	private bool parse_highlighting_pos (Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long pos, ref long line, ref long newlinepos, bool wikimode ) {
		if ( this.parse_bold_pos (curelement, str, strlen, content, ref pos, ref line, ref newlinepos, wikimode) ) {
			return true;
		}
		else if ( this.parse_italic_pos (curelement, str, strlen, content, ref pos, ref line, ref newlinepos, wikimode) ) {
			return true;
		}
		else if ( this.parse_underline_pos (curelement, str, strlen, content, ref pos, ref line, ref newlinepos, wikimode) ) {
			return true;
		}
		return false;
	}

	public bool parse_align_helper ( Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long nline, ref long nnewlinepos, ref long space, bool wikimode, GLib.Type tagtype, string tag ) {
		long newlinepos = nnewlinepos;
		long line = nline;
		long pos = npos;

		if ( !str.offset(pos).has_prefix(tag) )
			return false;

		for ( ; str[pos]==' '||str[pos]=='\t'; pos++ );

		Gee.ArrayList<DocElement> subcontent = new Gee.ArrayList<DocElement> ();
		StringBuilder buf = new StringBuilder ();
		long startpos = pos + 2;
		long lpos = startpos;


		for (; pos<strlen; pos++ ) {
			lpos = pos;
			if (this.parse_linebreak_pos(str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos = pos+1;
			}
			else if (this.parse_newline_pos (str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				if (str.offset(pos+1).has_prefix(tag)) {
					buf.append_len (str.offset(startpos), lpos-startpos);
					buf.erase ( 0, -1 );
					startpos = pos+3;
					continue;
				}
				//pos = lpos-1;
				break;
			}
			else if (this.parse_inline_taglet_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos, wikimode)) {
				this.prepend_string_taglet (str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_url_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos) ) {
				this.prepend_string_taglet (str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_img_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos) ) {
				this.prepend_string_taglet (str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_highlighting_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos, wikimode) ) {
				this.prepend_string_taglet (str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
		}

		this.append_string_taglet ( str, strlen, subcontent, ref startpos, pos, lpos, buf );

		for (space=++pos;str[pos]==' '||str[pos]=='\t';pos++);
		space = pos-space;

		nnewlinepos = newlinepos;
		nline = nline;
		npos = pos-1;

		ContentPositionDocElement aligntag = (ContentPositionDocElement)GLib.Object.new ( tagtype );
		aligntag.parse ( subcontent );
		content.add ( aligntag );
		return true;
	}

	private bool parse_notification_pos (Documented curelement,  string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long nline, ref long nnewlinepos, ref long nspace, bool wikimode ) {
		weak string strpos = str.offset( npos );
		if ( !strpos.has_prefix( "[[warning:" ) ) {
			return false;
		}


		Gee.ArrayList<DocElement> subcontent = new Gee.ArrayList<DocElement> ();
		long newlinepos = nnewlinepos;
		long pos = npos + 10;
		long line = nline;
		long space = 0;

		if(!this.skip_empty_spaces_pos (str, strlen, ref pos, ref line, ref newlinepos, ref space, wikimode)) {
			return false;
		}

		StringBuilder buf = new StringBuilder ();
		long startpos = pos;

		for (; pos<strlen; pos++) {
			long lpos = pos;
			if (this.parse_linebreak_pos(str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos = pos+1;
				continue;
			}

			if (this.parse_newline_pos (str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos = pos+1;

				long nlpos = pos+1;
				for ( ; str[nlpos]=='\t'||str[nlpos]==' '; nlpos++);

				if ( str.offset( nlpos ).has_prefix( "]]" ) ) {
					long tmppos = nlpos+2;
					for ( ;str[tmppos]==' '||str[tmppos]=='\t';tmppos++ );
					if(!this.parse_newline_pos (str, strlen, ref tmppos, ref line, ref newlinepos, wikimode)) {
						buf.append_c ( '\n' );
						continue;
					}

					for (space=++tmppos;str[tmppos]==' '||str[tmppos]=='\t';tmppos++);
					nspace = tmppos-space;

					this.append_string_taglet ( str, strlen, subcontent, ref startpos, pos, nlpos, buf );
					nnewlinepos = newlinepos;

					NotificationDocElement notificationtag = (NotificationDocElement)GLib.Object.new ( this.modules.notifictag );
					notificationtag.parse ( subcontent );
					content.add ( notificationtag );

					npos = tmppos-1;
					nline = line;
					return true;
				}
				buf.append_c ( '\n' );
				continue;
			}

			if (this.parse_inline_taglet_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos, wikimode)) {
				this.prepend_string_taglet (str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_url_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos) ) {
				this.prepend_string_taglet (str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
			//else if ( this.parse_img_pos (subcontent, ref pos, ref line, ref newlinepos) ) {
			//	this.prepend_string_taglet ( subcontent, ref startpos, pos, lpos, buf );
			//}
			else if ( this.parse_highlighting_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos, wikimode) ) {
				this.prepend_string_taglet (str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
		}
		this.printr ( ErrorNumber.OPEN_TAG, curelement.get_filename (), str, strlen, nline, nnewlinepos, npos, -1 );
		return false;
	}

	private bool parse_source_pos (Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long nline, ref long nnewlinepos, ref long space, bool wikimode ) {
		weak string strpos = str.offset( npos );
		if ( !strpos.has_prefix( "{{{" ) )
			return false;

		StringBuilder buf = new StringBuilder ();
		long newlinepos = nnewlinepos;
		long startpos = npos+3;
		long pos = startpos;
		long line = nline;


		for ( long lpos = pos; pos<strlen;  pos++, lpos = pos ) {
			if (this.parse_newline_pos (str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos = pos+1;

				long nlpos = startpos;
				for ( ; str[nlpos]=='\t'||str[nlpos]==' '; nlpos++);

				weak string tmp = str.offset (nlpos);
				if ( tmp.has_prefix("}}}") ) {
					long tmppos = nlpos+3;

					for ( ;str[tmppos]==' '||str[tmppos]=='\t';tmppos++ );
					if(!this.parse_newline_pos (str, strlen, ref tmppos, ref line, ref newlinepos, wikimode)) {
						continue;
					}

					for (space=++tmppos;str[tmppos]==' '||str[tmppos]=='\t';tmppos++);
					space = tmppos-space;

					SourceCodeDocElement srctag = (SourceCodeDocElement)GLib.Object.new ( this.modules.srctag );
					srctag.parse ( buf.str, Language.VALA );					
					content.add ( srctag );

					newlinepos = newlinepos;
					npos = tmppos-1;
					nline = line;
					return true;
				}
				buf.append_c('\n');
			}
		}
		this.printr ( ErrorNumber.OPEN_TAG, curelement.get_filename (), str, strlen, nline, nnewlinepos, npos, -1 );
		return false;
	}

	private bool parse_bold_pos (Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long line, ref long newlinepos, bool wikimode ) {
		return this.parse_highlighting_helper_pos (curelement, str, strlen, content, ref npos, ref line, ref newlinepos, wikimode, this.modules.boldtag, "++" );
	}

	private bool parse_italic_pos (Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long line, ref long newlinepos, bool wikimode ) {
		return this.parse_highlighting_helper_pos (curelement, str, strlen, content, ref npos, ref line, ref newlinepos, wikimode, this.modules.italictag, "//" );
	}

	private bool parse_underline_pos (Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long line, ref long newlinepos, bool wikimode ) {
		return this.parse_highlighting_helper_pos (curelement, str, strlen, content, ref npos, ref line, ref newlinepos, wikimode, this.modules.underlinedtag, "__" );
	}

	private bool parse_highlighting_helper_pos (Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long nline, ref long nnewlinepos, bool wikimode, GLib.Type tagtype, string markup ) {
		weak string strpos = str.offset( npos );
		if ( !strpos.has_prefix( markup ) ) {
			return false;
		}

		Gee.ArrayList<DocElement> subcontent = new Gee.ArrayList<DocElement> ();
		StringBuilder buf = new StringBuilder ();
		long startpos = npos+2;
		long pos = startpos;

		long newlinepos = nnewlinepos;
		long line = nline;


		for ( ; pos<strlen ; pos++ ) {
			long lpos = pos;
			if ( str.offset(pos).has_prefix(markup) ) {
				this.append_string_taglet ( str, strlen, subcontent, ref startpos, pos, lpos, buf );
				HighlightedDocElement htag = (HighlightedDocElement)GLib.Object.new ( tagtype );
				htag.parse ( subcontent );
				content.add ( htag );

				nnewlinepos = newlinepos;
				npos = startpos;
				nline = line;
				return true;
			}

			if ( this.parse_highlighting_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos, wikimode) ) {
				this.prepend_string_taglet ( str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
			else if (this.parse_linebreak_pos(str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos=pos+1;
				continue;
			}
			else if ( this.parse_url_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos) ) {
				this.prepend_string_taglet ( str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
			else if (this.parse_inline_taglet_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos, wikimode)) {
				this.prepend_string_taglet ( str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
			else if ( str[pos]=='\n' ) {
				break;
			}
		}
		this.printr ( ErrorNumber.OPEN_TAG, curelement.get_filename (), str, strlen, nline, nnewlinepos, npos, -1 );
		return false;
	}

	private bool parse_short_desc_pos (DocumentedElement curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long line, ref long newlinepos, ref long space, bool wikimode ) {
		StringBuilder buf = new StringBuilder ();
		long startpos = npos;
		long lpos = npos;

		for (; npos < strlen ; npos++ ) {
			lpos = npos;

			if (this.parse_linebreak_pos (str, strlen, ref npos, ref line, ref newlinepos, wikimode) ) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos=npos+1;
				continue;
			}

			if (this.parse_newline_pos ( str, strlen, ref npos, ref line, ref newlinepos, wikimode)) {
				npos++;
				break;
			}

			if (this.parse_inline_taglet_pos (curelement, str, strlen, content, ref npos, ref line, ref newlinepos, wikimode)) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, npos, lpos, buf );
			}
			else if ( this.parse_url_pos (curelement, str, strlen, content, ref npos, ref line, ref newlinepos ) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, npos, lpos, buf );
			}
			else if ( this.parse_highlighting_pos (curelement, str, strlen, content, ref npos, ref line, ref newlinepos, wikimode) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, npos, lpos, buf );
			}
		}
		this.append_string_taglet ( str, strlen, content, ref startpos, lpos, lpos, buf );
		for ( ; str[npos]==' '||str[npos]=='\t' ; npos++, space++ );
		return true;
	}

	private static bool check_img_url ( string url ) {
		return FileUtils.test (url, FileTest.IS_REGULAR);
	}

	private static bool check_url ( string url ) {
		return url.has_prefix("http://") || url.has_prefix("http://") || (url.has_prefix("/")&&url.has_suffix(".valadoc"));
	}

	private bool parse_url_pos ( Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long rpos, ref long nline, ref long newlinepos ) {
		if ( !str.offset(rpos).has_prefix ("[[") )
			return false;


		//long newlinepos = nnewlinepos;
		long pos = rpos+2;
		long urlend = -1;
		long line = nline;

		for ( ; pos<strlen ; pos++ ) {
			switch ( str[pos] ) {
			case '|':
				urlend= pos;
				break;
			case ']':
				if (str[pos+1]==']') {
					string url = str.substring ( rpos+2, ((urlend==-1)? pos : urlend)-rpos-2 );
					if ( !this.check_url (url) ) {
						this.printr ( ErrorNumber.INVALID_LINK, curelement.get_filename (), str, strlen, nline, newlinepos, rpos+2, pos-rpos-2 );
						return false;
					}

					string urldesc = (urlend==-1)? url : str.substring( urlend+1, pos-urlend-1 );					
					LinkDocElement linktag = (LinkDocElement)GLib.Object.new ( this.modules.linktag );
					linktag.parse ( this.settings, this.tree, curelement, url, urldesc );
					content.add ( linktag );

					nline = line;
					rpos = pos+1;
					return true;
				}
				break;
			case '\n':
				this.printr ( ErrorNumber.OPEN_TAG, curelement.get_filename (), str, strlen, nline, newlinepos, rpos, -1 );
				return false;
			}
		}
		this.printr ( ErrorNumber.OPEN_TAG, curelement.get_filename (), str, strlen, nline, newlinepos, rpos, -1 );
		return false;
	}

	private bool parse_img_pos ( Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long line, ref long newlinepos ) {
		if ( str[npos]!='{'||str[npos+1]!='{' )
			return false;

		long pos = npos+2;
		long urlend = -1;

		for ( ; pos<strlen ; pos++ ) {
			switch ( str[pos] ) {
			case '|':
				urlend= pos;
				break;
			case '}':
				if (str[pos+1]=='}') {
					string url = str.substring ( npos+2, ((urlend==-1)? pos : urlend)-npos-2 );
					if ( !this.check_img_url (url) ) {
						this.printr ( ErrorNumber.MISSING_IMAGE, curelement.get_filename (), str, strlen, line, newlinepos, npos+2, pos-npos-2 );
						return false;
					}
					string alt = (urlend==-1)? url : str.substring( urlend+1, pos-urlend-1 );
					ImageDocElement imgtag = (ImageDocElement)GLib.Object.new ( this.modules.imgtag );
					imgtag.parse ( this.settings, curelement, url, alt );
					content.add ( imgtag );

					npos = pos+1;
					return true;
				}
				break;
			case '\n':
				this.printr ( ErrorNumber.OPEN_TAG, curelement.get_filename (), str, strlen, line, newlinepos, npos, pos-1 );
				return false;
			}
		}
		this.printr ( ErrorNumber.OPEN_TAG, curelement.get_filename (), str, strlen, line, newlinepos, npos, -1 );
		return false;
	}

	private bool parse_taglet ( DocumentedElement curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long nline, ref long nnewlinepos, ref long nspace, ref int depth, bool wikimode ) {
		if ( str[npos] != '@' ) {
			return false;
		}

		ErrorLevel errlvl = ErrorLevel.ASSUMPTION;
		string errmsg;


		long newlinepos = nnewlinepos;
		long line = nline;
		long pos = npos+1;

		long keywordnewlinepos = nnewlinepos;
		long keywordstartpos = npos;
		long keywordline =  nline;


		string keyword = this.parse_taglet_name ( curelement, str, strlen, ref pos, line, newlinepos, npos );
		if ( keyword == null ) {
			return false;
		}

		if ( !this.modules.taglets.contains(keyword) ) {
			this.printr ( ErrorNumber.UNKNOWN_TAGLET, curelement.get_filename (), str, strlen, line, newlinepos, npos, keyword.len()+1 );
			return false;
		}

 		Taglet taglet = (Taglet)GLib.Object.new ( this.modules.taglets.get (keyword) );
 		if ( taglet is MainTaglet == false ) {
			this.printr ( ErrorNumber.CONTEXT, curelement.get_filename (), str, strlen, line, newlinepos, npos, keyword.len()+1 );
 			return false;
 		}

		Gee.ArrayList<DocElement> subcontent = new Gee.ArrayList<DocElement> ();
		StringBuilder buf = new StringBuilder ();
		long startpos = pos+1;
		long space = nspace;
		long lpos = pos+1;

		for ( ; pos < strlen ; pos++ ) {
			lpos = pos;
			if (this.parse_linebreak_pos (str, strlen, ref pos, ref line, ref newlinepos, wikimode) ) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos=pos+1;
			}
			else if (this.parse_newline_pos (str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos=pos+1;

				for ( pos++; str[pos]=='\t'||str[pos]==' '; pos++);

				if (this.parse_taglet (curelement, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, ref depth, wikimode ) ) {
					this.append_string_taglet ( str, strlen, subcontent, ref startpos, pos, startpos, buf );

					if ( !((MainTaglet)taglet).parse ( this.settings, this.tree, curelement, subcontent, ref errlvl, out errmsg  ) ) {
						this.printr_custom ( errlvl, curelement.get_filename (), str, strlen, keywordline, keywordnewlinepos, keywordstartpos, keyword.len()+1, errmsg );
					}

					nnewlinepos = newlinepos;
					nspace=pos-startpos;
					nline = line;
					npos = pos;

					content.insert (content.size-depth, taglet);
					depth++;
					return true;
				}
				buf.append_c ( '\n' );
				pos--;
			}
			else if (this.parse_inline_taglet_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos, wikimode )) {
				this.prepend_string_taglet ( str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_url_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos ) ) {
				this.prepend_string_taglet ( str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_highlighting_pos (curelement, str, strlen, subcontent, ref pos, ref line, ref newlinepos, wikimode) ) {
				this.prepend_string_taglet ( str, strlen, subcontent, ref startpos, pos, lpos, buf );
			}
		}
		this.append_string_taglet ( str, strlen, subcontent, ref startpos, pos, lpos, buf );

		if ( !((MainTaglet)taglet).parse ( this.settings, this.tree, curelement, subcontent, ref errlvl, out errmsg  ) ) {
			this.printr_custom ( errlvl, curelement.get_filename (), str, strlen, keywordline, keywordnewlinepos, keywordstartpos, keyword.len()+1, errmsg );
		}

		nnewlinepos = newlinepos;
		nspace=pos-startpos;
		nline = line;
		npos = pos;

		content.add ( taglet );
		depth++;
		return true;
	}

	private bool extract_color ( string str, long strlen, ref long pos, out int nr ) {
		long startpos = pos;

		for ( pos++; str[pos].isdigit()||(str[pos]>='A'&&str[pos]<='F')||(str[pos]>='a'&&str[pos]<='f'); pos++ );
		pos--;

		string strnr = str.offset(startpos+1).ndup(pos-startpos);
		startpos = pos-startpos;

		if ( startpos != 3 && startpos != 6 ) {
			return false;
		}

		strnr.scanf ("%x", out nr);
		return true;
	}

	private bool extract_decimal ( string str, long strlen, ref long pos, out int nr ) {
		long startpos = pos;

		for ( pos++; str[pos].isdigit(); pos++ );
		pos--;

		string strnr = str.offset(startpos+1).ndup(pos-startpos);
		nr = strnr.to_int();
		return true;
	}

	private long get_table_cell_attributes_error_len ( string str, long strlen, long startpos ) {
		weak string strstartpos = str.offset(startpos);

		weak string? endposstr = strstartpos.chr (-1, '>');
		weak string? cellendstr = strstartpos.str("||");
		weak string? lineendstr = strstartpos.chr (-1, '\n');

		long endpos = (endposstr == null)? long.MAX : (strstartpos.pointer_to_offset(endposstr)+1);	
		long cellend = (cellendstr == null)? long.MAX : strstartpos.pointer_to_offset(cellendstr);
		long lineend = (lineendstr == null)? long.MAX : strstartpos.pointer_to_offset(lineendstr);

		return long.min(long.min( long.min( cellend, lineend), endpos), strlen-startpos);
	}

	private bool parse_table_cell_attributes (Documented curelement, string str, long strlen, ref long npos, long line, long newlinepos, out TextPosition vpos, out TextVerticalPosition hpos, out int hwidth, out int vwidth, out int color) {
		if ( str[npos] != '<' ) {
			return false;
		}

		hpos = TextVerticalPosition.MIDDLE;
		vpos = TextPosition.LEFT;
		hwidth = 1;
		vwidth = 1;
		color = -1;


		for ( long pos = npos+1; pos < strlen; pos++ ) {
			switch ( str[pos] ) {
				case '-':
					if ( !this.extract_decimal ( str, strlen, ref pos, out hwidth ) ) {
						this.printr ( ErrorNumber.TABLE_CELL_ATTRIBUTES, curelement.get_filename (), str, strlen, line, newlinepos, npos, this.get_table_cell_attributes_error_len (str, strlen, npos) );
						return false;
					}
					break;
				case '|':
					if ( !this.extract_decimal ( str, strlen, ref pos, out vwidth ) ) {
						this.printr ( ErrorNumber.TABLE_CELL_ATTRIBUTES, curelement.get_filename (), str, strlen, line, newlinepos, npos, this.get_table_cell_attributes_error_len (str, strlen, npos) );
						return false;
					}
					break;
				case ')':
					switch ( str[pos+1] ) {
					case '(':
						vpos = TextPosition.CENTER;
						pos++;
						break;
					case ')':
						vpos = TextPosition.RIGHT;
						pos++;
						break;
					default:
						this.printr ( ErrorNumber.TABLE_CELL_ATTRIBUTES, curelement.get_filename (), str, strlen, line, newlinepos, npos, this.get_table_cell_attributes_error_len (str, strlen, npos) );
						return false;
					}
					break;
				case '#':
					if ( !this.extract_color(str, strlen, ref pos, out color) ) {
						this.printr ( ErrorNumber.TABLE_CELL_ATTRIBUTES, curelement.get_filename (), str, strlen, line, newlinepos, npos, this.get_table_cell_attributes_error_len (str, strlen, npos) );
						return false;
					}
					break;
				case '>':
					npos = pos+1;
					return true;
				case 'v':
					hpos = TextVerticalPosition.BOTTOM;
					break;
				case '^':
					hpos = TextVerticalPosition.TOP;
					break;
				case '\t':
					break;
				case ' ':
					break;
				default:
					this.printr ( ErrorNumber.TABLE_CELL_ATTRIBUTES, curelement.get_filename (), str, strlen, line, newlinepos, npos, this.get_table_cell_attributes_error_len (str, strlen, npos) );
					return false;
			}
		}
		this.printr ( ErrorNumber.TABLE_CELL_ATTRIBUTES, curelement.get_filename (), str, strlen, line, newlinepos, npos, this.get_table_cell_attributes_error_len (str, strlen, npos) );
		return false;
	}

	private bool parse_table_cell ( Documented curelement, string str, long strlen, Gee.ArrayList<TableCellDocElement> cells, ref long pos, ref long line, ref long newlinepos, bool wikimode ) {
		if ( !str.offset(pos).has_prefix("||") ) {
			return false;
		}

		Gee.ArrayList<DocElement> content = new Gee.ArrayList<DocElement> ();
		StringBuilder buf = new StringBuilder ();
		pos = pos + 2;
		long lpos;

		TextVerticalPosition hpos;
		TextPosition vpos;
		int hwidth;
		int vwidth;
		int color;

		long cellstartnewlinepos = newlinepos;
		long cellstartline = line;
		long cellstartpos = pos;

		this.parse_table_cell_attributes (curelement, str, strlen, ref pos, line, newlinepos, out vpos, out hpos, out hwidth, out vwidth, out color);

		for ( long startpos = pos; pos < strlen ; pos++ ) {
			lpos = pos;
			if ( str.offset(pos).has_prefix("||") ) {
				this.append_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );

				TableCellDocElement celltag = (TableCellDocElement)GLib.Object.new ( this.modules.celltag );
				celltag.parse ( vpos, hpos, hwidth, vwidth, content );
				cells.add ( celltag );
				return true;
			}
			else if (this.parse_linebreak_pos (str, strlen, ref pos, ref line, ref newlinepos, wikimode) ) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos=pos+1;
			}
			else if (this.parse_inline_taglet_pos (curelement, str, strlen, content, ref pos, ref line, ref newlinepos, wikimode )) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
				startpos=pos+1;
			}
			else if ( this.parse_url_pos (curelement, str, strlen, content, ref pos, ref line, ref newlinepos ) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_img_pos (curelement, str, strlen, content, ref pos, ref line, ref newlinepos ) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_highlighting_pos (curelement, str, strlen, content, ref pos, ref line, ref newlinepos, wikimode) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
			else if (this.parse_newline_pos (str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				this.printr ( ErrorNumber.TABLE_CELL, curelement.get_filename (), str, strlen, cellstartline, cellstartnewlinepos, cellstartpos, -1 );
				return false;
			}
		}
		this.printr ( ErrorNumber.TABLE_CELL, curelement.get_filename (), str, strlen, cellstartline, cellstartnewlinepos, cellstartpos, -1 );
		return false;
	}

	private bool parse_is_last_table_cell ( string str, long strlen, ref long npos, ref long nline, ref long newlinepos, out long nspace, bool wikimode) {
		long line = nline;
		long pos = npos;

		for ( pos = pos+2; str[pos]==' '||str[pos]=='\t' ; pos++ );

		if ( this.parse_newline_pos(str, strlen, ref pos, ref line, ref newlinepos, wikimode) ) {
			for ( nspace=++pos; str[pos]==' '||str[pos]=='\t' ; pos++ );
			nspace = pos-nspace;
			nline = line;
			npos = pos-1;
			return true;
		}

		return false;
	}

	private bool parse_table_row ( Documented curelement, string str, long strlen, Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> rows, ref long npos, ref long nline, ref long nnewlinepos, ref long nspace, bool wikimode ) {
		if ( !str.offset(npos).has_prefix("||") ) {
			return false;
		}

		Gee.ArrayList<TableCellDocElement> cells = new Gee.ArrayList<TableCellDocElement> ();
		long newlinepos = nnewlinepos;
		long space = nspace;
		long line = nline;
		long pos = npos;
		do {
			if (!this.parse_table_cell ( curelement, str, strlen, cells, ref pos, ref line, ref newlinepos, wikimode )) {
				return false;
			}

			if ( this.parse_is_last_table_cell (str, strlen, ref pos, ref line, ref newlinepos, out space, wikimode) ) {
				break;
			}
		}
		while (pos < strlen);

		nnewlinepos = newlinepos;
		nspace = space;
		nline = line;
		npos = pos;
//Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> rows
		rows.add ( cells );
		return true;
	}

	private bool parse_table ( Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long nline, ref long nnewlinepos, ref long nspace, bool wikimode ) {
		if ( !str.offset(npos).has_prefix("||") ) {
			return false;
		}

		Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> rows = new Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> ();

		for (;this.parse_table_row (curelement, str, strlen, rows, ref npos, ref nline, ref nnewlinepos, ref nspace, wikimode); npos++);

		if ( rows.size == 0 ) {
			return false;
		}

		npos--;

		TableDocElement tabletag = (TableDocElement)GLib.Object.new ( this.modules.tabletag );
		tabletag.parse ( rows );
		content.add ( tabletag );
		return true;
	}

	private bool parse_inherit_doc_taglet_pos ( string str, long strlen, ref uint counter, ref long npos, ref long nline, ref long nnewlinepos ) {
		if ( str[npos] != '{' )
			return false;

		long newlinepos = nnewlinepos;
		long line = nline;
		long pos = npos;

		for (pos++; str[pos]!='@' && pos<strlen; pos++ ) {
			if (str[pos]==' '||str[pos]=='\t') {
				continue;
			}

			if(this.parse_linebreak_pos(str, strlen, ref pos, ref line, ref newlinepos, false)) {
				continue ;
			}

			return false;
		}

		if ( str[pos]!='@' ) {
			return false;
		}

		pos++;

		string keyword = this.parse_taglet_name ( null, str, strlen, ref pos, line, newlinepos, npos );
		if ( keyword != "inheritDoc" ) {
			return false;
		}

		for ( ; str[pos]!='}'; pos++ ) {
			if(this.parse_linebreak_pos( str, strlen, ref pos, ref line, ref newlinepos, false)) {
				continue;
			}
			else if ( str[pos]=='\0'||str[pos]=='\n' ) {
				return false;
			}
		}

		nnewlinepos = newlinepos;
		nline = line;
		npos = pos;
		counter++;
		return true;
	}

	public bool is_inherit_doc ( DocumentedElement self ) {
		weak string str = self.comment_string;

		if ( self.comment_string == null ) {
			return false;
		}

		if ( self.comment_string[0]!='*' ) {
			return false;
		}

		long strlen = str.len();
		long newlinepos = 0;
		uint counter = 0;
		long line = 0;
		long pos = 0;

		if (!this.skip_header_pos ( str, strlen, ref pos, ref line, ref newlinepos, false )) {
			return false;
		}

		for ( pos++; pos<strlen; pos++ ) {
			if ( str[pos] == ' '||str[pos]=='\t' ) {
				continue;
			}
			else if ( this.parse_linebreak_pos ( str, strlen, ref pos, ref line, ref newlinepos, false) ) {
				continue;
			}
			else if (this.parse_newline_pos (str, strlen, ref pos, ref line, ref newlinepos, false)) {
				continue;
			}			
			else if (this.parse_inherit_doc_taglet_pos ( str, strlen, ref counter, ref pos, ref line, ref newlinepos )) {
				continue;
			}
			return false;
		}

		return counter > 0;
	}

	private bool parse_headline_pos ( string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long nline, ref long nnewlinepos, ref long space, bool wikimode ) {
		weak string startstr = str.offset(npos);
		if ( !startstr.has_prefix("==") ) {
			return false;
		}

		long pos = npos+2;
		int lvl = 0;

		for ( startstr = startstr.offset(2); startstr[lvl]=='=' ; lvl++ );
		lvl++;
		
		if ( lvl > 5 ) {
			return false;
		}

		GLib.StringBuilder buf = new GLib.StringBuilder();
		long newlinepos = nnewlinepos;
		long startpos = pos+lvl;
		long rpos = startpos;
		long line = nline;

		for ( ;  rpos<strlen ; rpos++ ) {
			long lpos = rpos;
			if ( this.parse_linebreak_pos (str, strlen, ref rpos, ref line, ref newlinepos, wikimode) ) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos = rpos+1;
				continue;
			}
			else if (this.parse_newline_pos (str, strlen, ref rpos, ref line, ref newlinepos, wikimode)) {
				buf.append_len (str.offset(startpos), lpos-startpos);

				HeadlineDocElement htag = (HeadlineDocElement)GLib.Object.new ( this.modules.headlinetag );
				htag.parse ( buf.str, lvl );
				content.add ( htag );

				for ( space=++rpos; str[rpos]==' '||str[rpos]=='\t'; rpos++ );
				newlinepos = newlinepos;
				space = rpos-space;
				npos = rpos-1;
				nline = line;
				return true;
			}
		}
		return false;
	}

	public weak WikiPage parse_wikipage ( WikiPage wikipage ) {
		Gee.ArrayList<DocElement> content = new Gee.ArrayList<DocElement> ();
		GLib.StringBuilder buf = new GLib.StringBuilder();
		weak string str = wikipage.documentation_str;
		long strlen = str.len();
		long newlinepos = 0;
		long startpos = 0;
		long line = 1;
		long lpos = 0;
		long pos = 0;

		for ( pos=0; str[pos]==' '||str[pos]=='\t' ; pos++ );
		long linestart = pos;
		long space = pos;

		for ( ; pos<strlen ; pos++ ) {
			lpos = pos;
			if ( this.parse_linebreak_pos (str, strlen, ref pos, ref line, ref newlinepos, true) ) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos = pos+1;
				continue;
			}
			else if (this.parse_newline_pos (str, strlen, ref pos, ref line, ref newlinepos, true)) {
				for (;(str[pos+1]==' '||str[pos+1]=='\t'); pos++);
				space = pos-lpos;

				buf.append_len (str.offset(startpos), lpos-startpos+1);
				linestart = pos+1;
				startpos = pos+1;
				continue;
			}

			if ( linestart == pos ) {
				if ( this.parse_source_pos ( wikipage, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, true ) ) {
					this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
					linestart = startpos = pos+1;
					continue ;
				}
				else if ( this.parse_notification_pos ( wikipage, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, true ) ) {
					this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
					linestart = startpos = pos+1;
					continue ;
				}
				else if ( this.parse_align_pos( wikipage, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, true ) ) {
					this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
					linestart = startpos = pos+1;
					continue ;
				}
				else if ( this.parse_list_pos (wikipage, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, ref linestart, true) ) {
					this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
					linestart = startpos = pos+1;
					continue ;
				}
				else if ( this.parse_table (wikipage,  str, strlen, content, ref pos, ref line, ref newlinepos, ref space, true ) ) {
					this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
					linestart = startpos = pos+1;
					continue ;
				}
				else if (this.parse_headline_pos ( str, strlen, content, ref pos, ref line, ref newlinepos, ref space, true )) {
					this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
					linestart = startpos = pos+1;
					continue ;
				}
			}

			if (this.parse_inline_taglet_pos (wikipage, str, strlen, content, ref pos, ref line, ref newlinepos, true)) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_url_pos (wikipage, str, strlen, content, ref pos, ref line, ref newlinepos) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_img_pos (wikipage, str, strlen, content, ref pos, ref line, ref newlinepos) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_highlighting_pos (wikipage, str, strlen, content, ref pos, ref line, ref newlinepos, true) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
		}

		this.append_string_taglet ( str, strlen, content, ref startpos, strlen-1, lpos, buf );

		wikipage.add_content(content);
		return wikipage;
	}

	public DocumentationTree? parse ( DocumentedElement self ) {
		weak string str = self.comment_string;
		if ( str == null ) {
			return null;
		}

		if ( str[0]!='*' ) {
			return null;
		}

		if ( self.documentation != null ) {
			return self.documentation;
		}

		Gee.ArrayList<DocElement> content = new Gee.ArrayList<DocElement> ();
		DocumentationTree doctree = new DocumentationTree ();
		long strlen = str.len();
		long newlinepos = 0;
		long space = 0;
		int depth = 0;
		long line = 0;
		long pos = 0;

		if (!this.skip_header_pos ( str, strlen, ref pos, ref line, ref newlinepos, false )) {
			return null;
		}

		if(!this.parse_short_desc_pos(self, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, false )) {
			return null;
		}

		doctree.add_brief ( content );

		StringBuilder buf = new StringBuilder ();
		long startpos = pos; //+1
		long linestart = pos;
		long lpos = pos;

		content = new Gee.ArrayList<DocElement> ();


		for ( ; pos<strlen ; pos++ ) {
			lpos = pos;
			if ( this.parse_linebreak_pos (str, strlen, ref pos, ref line, ref newlinepos, false) ) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos = pos+1;
				continue;
			}
			else if (this.parse_newline_pos (str, strlen, ref pos, ref line, ref newlinepos, false)) {
				for (space = pos;(str[pos+1]==' '||str[pos+1]=='\t'); pos++);
				space = pos-space;

				buf.append_len (str.offset(startpos), lpos-startpos+1);
				linestart = pos+1;
				startpos = pos+1;
				continue;
			}

			if ( linestart == pos ) {
				if ( this.parse_source_pos ( self, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, false) ) {
					this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
					linestart = startpos = pos+1;
					continue ;
				}
				else if ( this.parse_notification_pos ( self, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, false ) ) {
					this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
					linestart = startpos = pos+1;
					continue ;
				}
				else if ( this.parse_align_pos( self, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, false ) ) {
					this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
					linestart = startpos = pos+1;
					continue ;
				}
				else if ( this.parse_list_pos (self, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, ref linestart, false) ) {
					this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
					linestart = startpos = pos+1;
					continue ;
				}
				else if ( str[pos] == '@' && !str[pos].isspace() ) {
					Gee.ArrayList<MainTaglet> taglets = new Gee.ArrayList<MainTaglet>();

					this.parse_taglet ( self, str, strlen, taglets, ref pos, ref line, ref newlinepos, ref space, ref depth, false );
					this.append_string_taglet ( str, strlen, content, ref startpos, strlen-1, lpos, buf );
					doctree.add_description ( content );
					doctree.add_taglets (taglets);
					return doctree;
				}
				else if ( this.parse_table ( self, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, false ) ) {
					this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
					linestart = startpos = pos+1;
					continue ;
				}
			}

			if (this.parse_inline_taglet_pos ( self, str, strlen, content, ref pos, ref line, ref newlinepos, false )) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_url_pos ( self, str, strlen, content, ref pos, ref line, ref newlinepos ) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_img_pos ( self, str, strlen, content, ref pos, ref line, ref newlinepos ) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_highlighting_pos ( self, str, strlen, content, ref pos, ref line, ref newlinepos, false ) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
		}

		this.append_string_taglet ( str, strlen, content, ref startpos, strlen-1, lpos, buf );
		doctree.add_description ( content );
		return doctree;
	}

	private bool skip_header_pos ( string str, long strlen, ref long npos, ref long line, ref long linestartpos, bool wikimode ) {
		if ( str[0] != '*' ) {
			return false;
		}

		for (; str[npos]=='*'; npos++ );
		for (; str[npos]==' '||str[npos]=='\t'; npos++ );

		this.parse_newline_pos (str, strlen, ref npos, ref line, ref linestartpos, wikimode);
		if ( str[npos]=='*' ) {
			npos++;
		}
		return true;
	}

	private bool skip_empty_spaces_pos ( string str, long strlen, ref long npos, ref long nline, ref long nnewlinepos, ref long space, bool wikimode ) {
		long newlinepos = nnewlinepos;
		long line = nline;
		long pos = npos;
		long lpos = 0;
		do {
			for (lpos = pos; str[pos]==' '|| str[pos]=='\t';pos++);
			space = pos-lpos;

			if(this.parse_newline_pos (str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				pos++;
			}
		} while (lpos!=pos);
		nnewlinepos = newlinepos;
		nline = line;
		npos = pos;
		return true;
	}

	public static bool is_documentation ( string cmnt ) {
		return cmnt[0] == '*';
	}

	private bool parse_list_template_pos ( Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long pos, ref long line, ref long newlinepos, ref long space, ref long linestart, bool wikimode, ListType listtype, unichar tag ) {
		if ( str[pos]!=tag )
			return false;

		Gee.ArrayList<ListEntryDocElement> listelements = new Gee.ArrayList<ListEntryDocElement> ();
		long lspace = space;

		do {
			if(!this.parse_list_entry_pos ( curelement, str, strlen, listelements, ref pos, ref line, ref newlinepos, out space, wikimode, listtype, tag ))
				break;

			if ( space > lspace ) {
				if (this.parse_unsorted_list_pos ( curelement, str, strlen, listelements, ref pos, ref line, ref newlinepos, ref space, ref linestart, wikimode )){
					continue;
				}
				if (this.parse_sorted_list_pos ( curelement, str, strlen, listelements, ref pos, ref line, ref newlinepos, ref space, ref linestart, wikimode )){
					continue;
				}
			}
		}
		while ( pos < strlen && space == lspace );

		ListDocElement listtag = (ListDocElement)GLib.Object.new ( this.modules.ulisttag );
		listtag.parse ( listtype, listelements );
		content.add ( listtag );
		return true;
	}

	private bool parse_unsorted_list_pos ( Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long pos, ref long line, ref long newlinepos, ref long space, ref long linestart, bool wikimode ) {
		return parse_list_template_pos ( curelement, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, ref linestart, wikimode, ListType.UNSORTED, '-' );
	}

	private bool parse_sorted_list_pos ( Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long pos, ref long line, ref long newlinepos, ref long space, ref long linestart, bool wikimode ) {
		return parse_list_template_pos ( curelement, str, strlen, content, ref pos, ref line, ref newlinepos, ref space, ref linestart, wikimode, ListType.SORTED, '#' );
	}

	private bool parse_list_pos ( Documented curelement, string str, long strlen, Gee.ArrayList<DocElement> content, ref long npos, ref long line, ref long newlinepos, ref long space, ref long linestart, bool wikimode ) {
		if (this.parse_unsorted_list_pos ( curelement, str, strlen, content, ref npos, ref line, ref newlinepos, ref space, ref linestart, wikimode )) {
			npos--;
			return true;
		}
		if (this.parse_sorted_list_pos ( curelement, str, strlen, content, ref npos, ref line, ref newlinepos, ref space, ref linestart, wikimode )) {
			npos--;
			return true;
		}
		return false;
	}

	private bool parse_list_entry_pos ( Documented curelement, string str, long strlen, Gee.ArrayList<ListEntryDocElement> listelements, ref long npos, ref long line, ref long newlinepos, out long space, bool wikimode, ListType listtype, unichar tag ) {
		if ( str[npos]!=tag )
			return false;


		Gee.ArrayList<DocElement> content = new Gee.ArrayList<DocElement> ();
		StringBuilder buf = new StringBuilder ();
		long startpos = npos+1;
		long lpos = startpos;
		long pos = npos+1;

		for ( ; pos<strlen; pos++) {
			lpos = pos;
			if (this.parse_linebreak_pos(str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				buf.append_len (str.offset(startpos), lpos-startpos);
				startpos = pos+1;
			}
			else if (this.parse_newline_pos (str, strlen, ref pos, ref line, ref newlinepos, wikimode)) {
				break;
			}
			else if (this.parse_inline_taglet_pos ( curelement, str, strlen, content, ref pos, ref line, ref newlinepos, wikimode )) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
			else if ( this.parse_url_pos ( curelement, str, strlen, content, ref pos, ref line, ref newlinepos ) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
			//else if ( this.parse_img_pos ( content, ref pos, ref line, ref newlinepos ) ) {
			//	this.prepend_string_taglet ( content, ref startpos, pos, lpos, buf );
			//}
			else if ( this.parse_highlighting_pos (curelement, str, strlen, content, ref pos, ref line, ref newlinepos, wikimode) ) {
				this.prepend_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
			}
		}

		for ( space = pos, pos++; str[pos]==' '||str[pos]=='\t' ; pos++ );
		this.append_string_taglet ( str, strlen, content, ref startpos, pos, lpos, buf );
		space = pos-space;

		ListEntryDocElement listeltag = (ListEntryDocElement)GLib.Object.new ( this.modules.ulistetag );
		listeltag.parse ( listtype, content );
		listelements.add ( listeltag );

		npos = pos;
		return true;
	}
}




