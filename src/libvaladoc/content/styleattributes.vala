/* styleattributes.vala
 *
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
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
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using GLib;
using Gee;

public enum Valadoc.Content.HorizontalAlign {
	LEFT,
	RIGHT,
	CENTER
}

public enum Valadoc.Content.VerticalAlign {
	TOP,
	MIDDLE,
	BOTTOM
}

public interface Valadoc.Content.StyleAttributes : ContentElement {
	public abstract HorizontalAlign? horizontal_align { get; set; }
	public abstract VerticalAlign? vertical_align { get; set; }
	public abstract string? style { get; set; }
}
