/* gio-unix-2.0-custom.vala
 *
 * Copyright (C) 2009  Evan Nemerson
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
 * 	Evan Nemerson <evan@polussystems.com>
 */

namespace GLib {
	[Compact]
	[CCode (cname = "GUnixMountEntry", cheader_filename = "gio/gunixmounts.h", lower_case_cprefix = "g_unix_mount_", free_function = "g_unix_mount_free")]
	public class UnixMountEntry {
		[CCode (cname = "g_unix_mount_at")]
		public UnixMountEntry (string mount_path, uint64 time_read);
		public int compare (GLib.UnixMountEntry mount);
		public unowned string get_device_path ();
		public unowned string get_fs_type ();
		public unowned string get_mount_path ();
		public bool guess_can_eject ();
		public GLib.Icon guess_icon ();
		public string guess_name ();
		public bool guess_should_display ();
		public GLib.Icon guess_symbolic_icon ();
		public bool is_readonly ();
		public bool is_system_internal ();

		[CCode (cname = "g_unix_mounts_get", cheader_filename = "gio/gunixmounts.h")]
		public static GLib.List<UnixMountEntry> @get (out uint64 time_read = null);
	}
}
