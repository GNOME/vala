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
	public class SourceCodeDocElement : Valadoc.SourceCodeDocElement {
		public Language lang {
			private set;
			get;
		}

		public string src {
			private set;
			get;
		}

		public override bool parse ( Settings settings, Tree tree, DocumentedElement me, owned string src, Language lang ) {
			this.lang = lang;
			this.src = (owned)src;
			return true;
		}

		public override bool write ( void* res, int max, int index ) {
			weak GLib.FileStream file = (GLib.FileStream)res;
			file.printf ( "\n<div class=\"%s\">\n\t<pre>", css_source_sample );
			file.puts ( src );
			file.puts ( "<pre>\n</div>" );
			return true;
		}
	}
}


[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
	return typeof ( Valadoc.Html.SourceCodeDocElement );
}



