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


namespace Valadoc.Html {
	public class ExceptionTaglet : Valadoc.MainTaglet {
		public override int order { get { return 200; } }
		private Gee.ArrayList<DocElement> content;
		private string paramname;

		public override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.Collection<DocElement> content, ref ErrorLevel errlvl, out string errmsg ) {
			if ( me is Valadoc.ExceptionHandler == false ) {
				errmsg = "Tag @throws cannot be used in this context";
				errlvl = ErrorLevel.ERROR;
				return false;
			}

			if ( content.size == 0 ) {
				errmsg = "Exception name was expected";
				errlvl = ErrorLevel.ERROR;
				return false;
			}


			Gee.ArrayList<DocElement> contentlst = new Gee.ArrayList<DocElement> ();
			foreach ( DocElement element in content ) {
				contentlst.add ( element );
			}

			DocElement tag = contentlst.get( 0 );
			if ( tag is StringTaglet == false ) {
				errmsg = "Exception name was expected";
				errlvl = ErrorLevel.ERROR;
				return false;
			}

			string str = ((StringTaglet)tag).content;
			weak string lposa =  str.chr (-1, '\n');
			weak string lposb =  str.chr (-1, ' ');
			weak string lpos;

			long lposaoffset = (lposa == null)? long.MAX : str.pointer_to_offset ( lposa );
			long lposboffset = (lposb == null)? long.MAX : str.pointer_to_offset ( lposb );

			if ( lposaoffset < lposboffset ) {
				lpos = lposa;
			}
			else {
				lpos = lposb;
			}

			if ( lpos == null ) {
				this.paramname = str.strip ();
				((StringTaglet)tag).content = "";
			}
			else {
				int namepos = (int)str.pointer_to_offset ( lpos );
				this.paramname = str.ndup ( namepos ).strip ();
				((StringTaglet)tag).content = lpos.ndup ( lpos.size () ).chomp ();
			}

			bool tmp = this.check_exception_parameter_name ( (Valadoc.ExceptionHandler)me, this.paramname );
			if ( tmp == false ) {
				errmsg = "Exception name was expected";
				errlvl = ErrorLevel.ERROR;
				return false;
			}

			this.content = contentlst;
			return true;
		}

		private bool check_exception_parameter_name ( Valadoc.ExceptionHandler me, string paramname ) {
			foreach ( DocumentedElement param in me.get_error_domains() ) {
				if ( param.name == paramname )
					return true;
			}
			return false;
		}

		public override bool write ( void* ptr, int max, int index ) {
			weak GLib.FileStream file = (GLib.FileStream)ptr;

			file.printf ( "\t<tr>\n" );
			file.printf ( "\t\t<td class=\"%s\">%s:</td>\n", css_parameter_table_name, this.paramname );
			file.printf ( "\t\t<td class=\"%s\">\n", css_parameter_table_text );
			file.puts ( "\t\t\t" );

			int _max = this.content.size;
			int _index = 0;

			foreach ( DocElement element in this.content ) {
				element.write ( ptr, _max, _index );
				_index++;
			}

			file.puts ( "\n" );
			file.printf ( "\t\t</td>\n" );
			file.printf ( "\t</tr>\n" );
			return true;
		}

		public override bool write_block_start ( void* ptr ) {
			weak GLib.FileStream file = (GLib.FileStream)ptr;
			file.printf ( "<h2 class=\"%s\">Exceptions:</h2>\n", css_title );
			file.printf ( "<table class=\"%s\">\n", css_exception_table );
			return true;
		}

		public override bool write_block_end ( void* ptr ) {
			weak GLib.FileStream file = (GLib.FileStream)ptr;
			file.printf ( "</table>\n" );
			return true;
		}
	}
}


[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
	GLib.Type type = typeof ( Valadoc.Html.ExceptionTaglet );
	taglets.set ( "throws", type );
	return type;
}


