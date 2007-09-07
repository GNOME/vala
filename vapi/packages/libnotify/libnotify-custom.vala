/* libnotify-custom.vala
 *
 * Copyright (C) 2007  Nicolas Christener, Roland Hostettler
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
 * 	Nicolas Christener <nicu@0x17.ch>
 * 	Roland Hostettler <r.hostettler@gmx.ch>
 */

[CCode (cheader_filename = "libnotify/notify.h")]
namespace Notify {
	[Import]
	public bool init (string! app_name);
}
