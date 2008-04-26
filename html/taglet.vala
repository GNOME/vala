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


public class Valadoc.GlobalTaglet : MainTaglet {
	private Gee.Collection<Valadoc.BasicTaglet> lst;

	construct {
		this.indenture_number = 0;
	}

	public GlobalTaglet ( Valadoc.Basic element ) {
		this.element = element;
	}

	public override void parse ( Gee.Collection<Valadoc.BasicTaglet> lst ) {
		this.lst = lst;
	}

	public override void write ( void* ptr ) {
		foreach ( Valadoc.BasicTaglet tag in this.lst ) {
			tag.write ( ptr );
		}
	}

	public static Valadoc.BasicTaglet create  ( Valadoc.Tree tree, Valadoc.Basic element,
																							Valadoc.ErrorReporter err, Valadoc.Settings settings ) {
		return new Valadoc.GlobalTaglet( element );
	}
}


public class Valadoc.ReturnTaglet : MainTaglet {
	Gee.Collection<Valadoc.BasicTaglet> lst;

	construct {
		this.indenture_number = 5000;
	}

	public ReturnTaglet ( Valadoc.Basic element ) {
		this.element = element;
	}

	public override void parse ( Gee.Collection<Valadoc.BasicTaglet> lst ) {
		this.lst = lst;
	}

	public static Valadoc.BasicTaglet create  ( Valadoc.Tree tree, Valadoc.Basic element,
																							Valadoc.ErrorReporter err, Valadoc.Settings settings ) {
		return new Valadoc.ReturnTaglet ( element );
	}

	public override void write ( void* ptr ) {
		((GLib.FileStream)ptr).puts ( "\t\t<table align=\"center\" width=\"80%\">\n\t\t\t<tr>\t\t\t\t<td colspan=\"2\"><h5>Return:</h5></td>\n\t\t\t</tr>\n\t\t\t\t<td width=\"5\">&nbsp;</td>\n\t\t\t\t<td>" );

		foreach ( Valadoc.BasicTaglet tag in this.lst ) {
			tag.write ( ptr );
		}
		((FileStream)ptr).puts ( "</td>\n\t\t\t</tr>\n\t\t</table>\n" );
	}
}




public class Valadoc.SeeTaglet : MainTaglet, LinkHelper {
	private string link;
	private string name;

	construct {
		this.indenture_number = 10000;
	}

	public Settings settings {
		construct set;
		get;
	}

	public SeeTaglet ( Valadoc.Basic element,
										 Valadoc.Tree doctree,
										 Valadoc.ErrorReporter err,
										 Valadoc.Settings settings ) {
		this.element = element;
		this.doctree = doctree;
		this.err = err;
		this.settings = settings;
	}

	public override void parse ( Gee.Collection<Valadoc.BasicTaglet> lst ) {
		if ( lst.size != 1 ) {
			this.err.add_with_message ( this.element, false, "see", "no inline-tags are allowed." );
			return ;
		}

		foreach ( Valadoc.BasicTaglet tag in lst ) {
			if ( tag is Valadoc.StringTaglet == false ) {
				this.err.add_with_message ( this.element, false, "see", "no inline-tags are allowed." );
				return ;
			}

			this.name = ((Valadoc.StringTaglet)tag).str;

			var element = this.doctree.search_symbol_str ( this.element, name.strip() );
			if ( element == null ) {
				this.err.add_with_message ( this.element, false, "see",
						"linked type \"%s\" is not available.".printf( this.name ) );
				return ;
			}

			this.link = this.get_link ( element );
		}
	}

	public override void start_block ( void* ptr ) {
		string str = "\t\t<br><br>\n\t\t<h5>See:</h5>\n\t\t<table>\n\t\t<tr>\n\t\t<td>&nbsp;</td>\n\t\t<td>\n";
		((GLib.FileStream)ptr).puts ( str );
	}

	public override void end_block ( void* ptr ) {
		((GLib.FileStream)ptr).puts ( "\t\t</td>\n\t\t</tr>\t\t</table>" );
	}

	public static Valadoc.BasicTaglet create ( Valadoc.Tree tree, Valadoc.Basic element,
																						 Valadoc.ErrorReporter err, Valadoc.Settings settings ) {
		return new Valadoc.SeeTaglet ( element, tree, err, settings );
	}

	public override void write ( void* ptr ) {
		if ( this.link == null )
			((FileStream)ptr).puts ( this.name );
		else
			((FileStream)ptr).puts ( "<a href=\"%s\">%s</a> ".printf( this.link, this.name ) );
	}
}


public class Valadoc.LinkTaglet : InlineTaglet, LinkHelper {
	private string name;
	private string link;

	public LinkTaglet ( Valadoc.Basic element,
											Valadoc.Tree doctree,
											Valadoc.ErrorReporter err,
											Valadoc.Settings settings ) {
		this.element = element;
		this.doctree = doctree;
		this.err = err;
		this.settings = settings;
	}

	public Settings settings {
		construct set;
		get;
	}

	public override void parse ( string str ) {
		this.name = str;

		var element = this.doctree.search_symbol_str ( this.element, this.name.strip() );
		if ( element == null ) {
			this.err.add_with_message ( this.element, false, "link",
				"linked type \"%s\" is not available.".printf( this.name ) );
			return ;
		}

		this.link = this.get_link ( element );
	}

	public override void write ( void* ptr ) {
		if ( this.link == null )
			((FileStream)ptr).puts ( this.name );
		else
			((FileStream)ptr).puts ( "<a href=\"%s\">%s</a> ".printf( this.link, this.name ) );
	}

	public static Valadoc.BasicTaglet create ( Valadoc.Tree tree, Valadoc.Basic element,
																						 Valadoc.ErrorReporter err, Valadoc.Settings settings ) {
		return new Valadoc.LinkTaglet ( element, tree, err, settings );
	}
}



public abstract class Valadoc.SingleTextHelper : MainTaglet {
	protected string element_name;
	protected string text = "";

	public override void parse ( Gee.Collection<Valadoc.BasicTaglet> lst ) {
		if ( lst.size != 1 ) {
			this.err.add_with_message ( this.element, false, this.element_name, "Inline taglets are not allowed." );
			return ;
		}

		Valadoc.BasicTaglet element = ((Gee.List<BasicTaglet>)lst).get ( 0 );
		if ( element is StringTaglet == false ) {
			this.err.add_with_message ( this.element, false, this.element_name, "Syntax error" );
			return ;
		}

		this.text = ((StringTaglet)element).str;
	}
}



public class Valadoc.VersionTaglet : SingleTextHelper {
	construct {
		this.indenture_number = 10;
	}

	public VersionTaglet ( Basic element, Valadoc.ErrorReporter err ) {
		this.element = element;
		this.err = err;
	}

	public static Valadoc.VersionTaglet create ( Valadoc.Tree tree, Valadoc.Basic element,
																								 Valadoc.ErrorReporter err, Valadoc.Settings settings ) {
		return new Valadoc.VersionTaglet( element, err );
	}

	public override void write ( void* ptr ) {
		((FileStream)ptr).puts ( "<br /><b>Version: </b>" + this.text + "<br />" );
	}
}


public abstract class Valadoc.ParameterTagletHelper : MainTaglet {
	private Gee.ArrayList<Valadoc.BasicTaglet> lst = new Gee.ArrayList<Valadoc.BasicTaglet> ();
	private string param = null;

	protected string parameter_error_msg = "parameter-name was expected.";
	protected string element_name = "param";
	protected string headline = "Parameter:";

	/*
	public ParameterTaglet ( construct Valadoc.Basic element, construct Valadoc.ErrorReporter err ) {
	}
	*/

	public override void parse ( Gee.Collection<Valadoc.BasicTaglet> lst ) {
		int i = 0;
		foreach ( Valadoc.BasicTaglet tag in lst ) {
			if ( i == 0 ) {
				if ( tag is Valadoc.StringTaglet == false ) {
					this.err.add_with_message ( this.element, false, this.element_name, this.parameter_error_msg );
					return ;
				}

				var str = ((Valadoc.StringTaglet)tag).str;

				var vstr = str.split ( " ", 2 );
				int vstr_len = 0; foreach ( string s in vstr ) { vstr_len++; }
				if ( vstr_len >= 1 )
					this.param = vstr[0];
				if ( vstr_len >= 2 ) {
					var tmp = Valadoc.StringTaglet.create ( this.element );
					tmp.parse ( vstr[1] );
					this.lst.add ( tmp );
				}
			}
			else {
				this.lst.add ( tag );
			}

			i++;
		}
	}

	/*
	public static Valadoc.ParameterTaglet create ( Valadoc.Tree tree, Valadoc.Basic element, Valadoc.ErrorReporter err ) {
		return new Valadoc.ParameterTaglet( element, err );
	}
	*/

	public override void start_block (void* ptr ) {
		((GLib.FileStream)ptr).puts ( "\t\t<table align=\"center\" width=\"80%\">\n\t\t\t<tr>\t\t\t\t<td colspan=\"3\"><h5>" );
		((GLib.FileStream)ptr).puts ( this.headline );
		((GLib.FileStream)ptr).puts ( "</h5></td>\n\t\t\t</tr>\n" );
	}

	public override void end_block ( void* ptr ) {
		((GLib.FileStream)ptr).puts ( "\t\t</table>\n" );
	}

	public override void write ( void* ptr ) {
		((FileStream)ptr).printf ( "\t\t\t<tr>\n\t\t\t\t<td width=\"5\">&nbsp;</td>\n\t\t\t<td width=\"70\"><i>%s:</i></td>\n", this.param );
		foreach ( Valadoc.BasicTaglet tag in this.lst ) {
			((FileStream)ptr).puts ( "\n\t\t\t\t<td>" );
			tag.write ( ptr );
			((FileStream)ptr).puts ( "</td>\n\t\t\t</tr>\n" );
		}
	}
}



public class Valadoc.ParameterTaglet : ParameterTagletHelper {
	construct {
		this.parameter_error_msg = "parameter-name was expected.";
		this.element_name = "param";
		this.headline = "Parameter:";
		this.indenture_number = 3000;
	}

	public ParameterTaglet ( Valadoc.Basic element, Valadoc.ErrorReporter err ) {
		this.element = element;
		this.err = err;
	}

	public static Valadoc.ParameterTaglet create ( Valadoc.Tree tree, Valadoc.Basic element,
																								 Valadoc.ErrorReporter err, Valadoc.Settings settings ) {
		return new Valadoc.ParameterTaglet( element, err );
	}
}


public class Valadoc.ExceptionTaglet : ParameterTagletHelper {
	construct {
		this.parameter_error_msg = "exception-name was expected.";
		this.element_name = "throws";
		this.headline = "Exceptions:";
		this.indenture_number = 5500;
	}

	public ExceptionTaglet ( Valadoc.Basic element, Valadoc.ErrorReporter err ) {
		this.element = element;
		this.err = err;
	}

	public static Valadoc.ExceptionTaglet create ( Valadoc.Tree tree, Valadoc.Basic element,
																								 Valadoc.ErrorReporter err, Valadoc.Settings settings ) {
		return new Valadoc.ExceptionTaglet( element, err );
	}
}



