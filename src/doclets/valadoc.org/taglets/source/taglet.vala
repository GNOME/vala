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


public class Valadoc.ValdocOrg.SourceCodeDocElement : Valadoc.SourceCodeDocElement {
	private Language lang;
	private int srclines;
	private string src;

	public override bool parse (string src, Language lang) {
		this.src = src;
		this.lang = lang;
		this.srclines=0;

		for (weak string str=this.src; str.get_char()!='\0'; str=str.next_char()) {
			if (str.get_char () == '\n') {
				this.srclines++;
			}
		}
		return true;
	}

	public override bool write (void* res, int max, int index) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		file.printf ("\n{{{\n%s\n}}}\n", src);
		return true;
	}
}


[ModuleInit]
public GLib.Type register_plugin (Gee.HashMap<string, Type> taglets) {
	return typeof (Valadoc.ValdocOrg.SourceCodeDocElement);
}



