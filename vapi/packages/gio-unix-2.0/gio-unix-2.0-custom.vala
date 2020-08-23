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
		public UnixMountEntry (string mount_path, out uint64 time_read = null);
		[CCode (cname = "g_unix_mount_for")]
		[Version (since = "2.52")]
		public UnixMountEntry.@for (string file_path, out uint64 time_read = null);
		public int compare (GLib.UnixMountEntry mount);
		public unowned string get_device_path ();
		public unowned string get_fs_type ();
		public unowned string get_mount_path ();
		[Version (since = "2.58")]
		public unowned string get_options ();
		[Version (since = "2.60")]
		public unowned string get_root_path ();
		public bool guess_can_eject ();
		public GLib.Icon guess_icon ();
		public string guess_name ();
		public bool guess_should_display ();
		[Version (since = "2.34")]
		public GLib.Icon guess_symbolic_icon ();
		public bool is_readonly ();
		public bool is_system_internal ();

		[Version (since = "2.54")]
		public GLib.UnixMountEntry copy ();
		[CCode (cname = "g_unix_mounts_get")]
		public static GLib.List<UnixMountEntry> @get (out uint64 time_read = null);
	}

	[Compact]
	[CCode (cname = "GUnixMountPoint", cheader_filename = "gio/gunixmounts.h", lower_case_cprefix = "g_unix_mount_point_", free_function = "g_unix_mount_point_free")]
	public class UnixMountPoint {
		[CCode (cname = "g_unix_mount_point_at")]
		[Version (since = "2.66")]
		public UnixMountPoint (string mount_path, out uint64 time_read = null);

		[Version (since = "2.54")]
		public GLib.UnixMountPoint copy ();
		[CCode (cname = "g_unix_mount_points_get")]
		public static GLib.List<UnixMountPoint> @get (out uint64 time_read = null);
	}
}
