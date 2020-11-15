/* valaccode.vala
 *
 * Copyright (C) 2020  Rico Tzschichholz
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
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */

namespace Vala {
	public unowned string GNUC_CONST;
	public unowned string GNUC_DEPRECATED;
	public unowned string GNUC_FORMAT;
	public unowned string GNUC_INTERNAL;
	public unowned string GNUC_NO_INLINE;
	public unowned string GNUC_PRINTF;
	public unowned string GNUC_SCANF;
	public unowned string GNUC_UNUSED;

	public static void ccode_init (Vala.Profile profile) {
		switch (profile) {
		case Vala.Profile.GOBJECT:
			GNUC_CONST = " G_GNUC_CONST ";
			GNUC_DEPRECATED = " G_GNUC_DEPRECATED ";
			GNUC_FORMAT = " G_GNUC_FORMAT(%d) ";
			GNUC_INTERNAL = " G_GNUC_INTERNAL ";
			GNUC_NO_INLINE = " G_GNUC_NO_INLINE ";
			GNUC_PRINTF = "  G_GNUC_PRINTF(%d,%d) ";
			GNUC_SCANF = " G_GNUC_SCANF(%d,%d) ";
			GNUC_UNUSED = " G_GNUC_UNUSED ";
			break;
		case Vala.Profile.POSIX:
			GNUC_CONST = " __attribute__((__const__)) ";
			GNUC_DEPRECATED = " __attribute__((__deprecated__)) ";
			GNUC_FORMAT = " __attribute__((__format_arg__ (arg_idx))) ";
			GNUC_INTERNAL = " __attribute__((visibility(\"hidden\"))) ";
			GNUC_NO_INLINE = " __attribute__((noinline)) ";
			GNUC_PRINTF = " __attribute__((__format__ (__printf__, %d, %d))) ";
			GNUC_SCANF = " __attribute__((__format__ (__scanf__, %d, %d))) ";
			GNUC_UNUSED = " __attribute__((__unused__)) ";
			break;
		default:
			assert_not_reached ();
		}
	}
}
