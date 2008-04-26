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
using Vala;
using Gee;


[ErrorDomain]
public enum CommentParserError {
	UNKNOWN_SYMBOL,
	SUBPARSER,
	BRACKET_ERROR,
	UNKNOWN_OPTION,
	NO_COMMENT_STRING,
	NESTED_BRACKETS,
	SYNTAX_ERROR,
	CONTEXT_ERROR
}


public class Valadoc.Error : Object {
	public string cmnd {
		construct set;
		get;
	}

	public bool is_warning {
		construct set;
		get;
	}

	public Basic element {
		construct set;
		get;
	}

	public string description {
		construct set;
		get;
	}


	public CommentParserError err {
		construct set;
		get;
	}

	public Error ( Basic element,
								 bool is_warning,
								 string cmnd,
								 CommentParserError err ) {
		this.element = element;
		this.is_warning = is_warning;
		this.cmnd = cmnd;
		this.err = err;
	}

	public Error.Message ( Basic element,
												 bool is_warning,
												 string cmnd,
												 string description ) {
		this.element = element;
		this.is_warning = is_warning;
		this.cmnd = cmnd;
		this.description = description;
	}

	public void print ( ) {
		string file = this.element.file.name;
		string type = ( this.is_warning )? "warning" : "error";
		string element = this.element.name;

		string desc = null;
		if ( this.description == null ) {
			switch ( this.err ) {
			case CommentParserError.UNKNOWN_SYMBOL:
				desc = "unnown symbol"; break;
			case CommentParserError.SUBPARSER:
				desc = "subparser"; break;
			case CommentParserError.UNKNOWN_OPTION:
				desc = "unnown option \"" + this.cmnd + "\"" ; break;
			case CommentParserError.NO_COMMENT_STRING:
				desc = "no comment string"; break;
			case CommentParserError.NESTED_BRACKETS:
				desc = "nested brackets"; break;
			case CommentParserError.SYNTAX_ERROR:
				desc = "syntax error"; break;
			case CommentParserError.CONTEXT_ERROR:
				desc = "context error"; break;
			case CommentParserError.BRACKET_ERROR:
				desc = "open brackets"; break;
			default: desc = "unknown error"; break;
			}
		}
		else {
			desc = this.description;
		}
///home/mog/Desktop/vendy/vendy/Vendy.Magtek.vala, read: error: linked type is not available.

		if ( this.element.line == 0 )
			stdout.printf ( "%s: %s: in %s: %s\n", file, type, element, desc );
		else
			stdout.printf ( "%s:%d: %s: in %s: %s\n", file, this.element.line, type, element, desc );
	}
}

public class Valadoc.ErrorReporter : Object {
	Gee.ArrayList<Error> lst = new Gee.ArrayList<Error> ();

	public int numbers {
		get {
			return ((Gee.Collection)this.lst).size;
		}
	}

	public void print_errors ( ) {
		foreach ( Error err in this.lst ) {
			err.print();
		}
	}

	public void add_with_message ( Basic element, bool is_warning, string cmnd, string desc ) {
		var tmp = new Error.Message ( element, is_warning, cmnd, desc );
		this.lst.add ( tmp );
	}

	public void add ( Basic element, bool is_warning, string cmnd, CommentParserError err ) {
		var tmp = new Error ( element, is_warning, cmnd,CommentParserError.UNKNOWN_OPTION );
		this.lst.add ( tmp );
	}
}



