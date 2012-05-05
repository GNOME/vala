/* styleattributes.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using Gee;


public enum Valadoc.Content.HorizontalAlign {
	LEFT,
	RIGHT,
	CENTER;

	public static HorizontalAlign? from_string (string str) {
		switch (str) {
		case "left":
			return HorizontalAlign.LEFT;

		case "right":
			return HorizontalAlign.RIGHT;

		case "center":
			return HorizontalAlign.CENTER;
		}

		return null;
	}

	public unowned string to_string () {
		switch (this) {
		case HorizontalAlign.LEFT:
			return "left";

		case HorizontalAlign.RIGHT:
			return "right";

		case HorizontalAlign.CENTER:
			return "center";
		}

		assert (true);
		return "";
	}
}

public enum Valadoc.Content.VerticalAlign {
	TOP,
	MIDDLE,
	BOTTOM;

	public static VerticalAlign? from_string (string str) {
		switch (str) {
		case "top":
			return VerticalAlign.TOP;

		case "middle":
			return VerticalAlign.MIDDLE;

		case "bottom":
			return VerticalAlign.BOTTOM;
		}

		return null;
	}

	public unowned string to_string () {
		switch (this) {
		case VerticalAlign.TOP:
			return "top";

		case VerticalAlign.MIDDLE:
			return "middle";

		case VerticalAlign.BOTTOM:
			return "bottom";
		}

		assert (true);
		return "";
	}
}

public interface Valadoc.Content.StyleAttributes : ContentElement {
	public abstract HorizontalAlign? horizontal_align { get; set; }
	public abstract VerticalAlign? vertical_align { get; set; }
	public abstract string? style { get; set; }
}

