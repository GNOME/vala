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


using Valadoc;
using GLib;


public interface Valadoc.HtmlHelper {
	protected string? get_html_link ( Settings settings, Basic element, Basic pos ) {
		string tmp = "";
		string prefix = "";

		if ( element is Package ) {
			return "../" + element.name + "/index.html";
		}
	
		if ( element != pos ) {
			prefix =  "../" + element.file.name;
		}

		if ( element is Valadoc.EnumValue || element is Valadoc.ErrorCode ) {
			tmp = "#" + element.name;
			element = element.parent;
		}

		return prefix + "/" + element.full_name () + ".html" + tmp;
	}
}


