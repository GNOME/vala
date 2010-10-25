/* pango.vala
 *
 * Copyright (C) 2007  Mathias Hasselmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Mathias Hasselmann <mathias.hasselmann@gmx.de>
 */

namespace Pango {
	[CCode (cheader_filename = "pango/pango.h")]
	public struct Glyph : uint32 {
	}

	[CCode (cheader_filename = "pango/pango.h")]
	namespace Scale {
		[CCode (cname = "PANGO_SCALE_XX_SMALL")]
		public const double XX_SMALL;
		[CCode (cname = "PANGO_SCALE_X_SMALL")]
		public const double X_SMALL;
		[CCode (cname = "PANGO_SCALE_SMALL")]
		public const double SMALL;
		[CCode (cname = "PANGO_SCALE_MEDIUM")]
		public const double MEDIUM;
		[CCode (cname = "PANGO_SCALE_LARGE")]
		public const double LARGE;
		[CCode (cname = "PANGO_SCALE_X_LARGE")]
		public const double X_LARGE;
		[CCode (cname = "PANGO_SCALE_XX_LARGE")]
		public const double XX_LARGE;
	}
}
