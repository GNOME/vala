/* sqlite3.vala
 *
 * Copyright (C) 2007 Jürg Billeter
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
 * 	Jürg Billeter <j@bitron.ch>
 */

[CCode (lower_case_cprefix = "sqlite3_", cheader_filename = "sqlite3.h")]
namespace Sqlite {
	[CCode (free_function = "sqlite3_close", cname = "sqlite3", cprefix = "sqlite3_")]
	public class Database {
		public int exec (string! sql, Callback sqlite3_callback = null, pointer data = null, out string errmsg = null);
		public int64 last_insert_rowid ();
		public int changes ();
		public int total_changes ();
		public void interrupt ();
		public int complete (string! sql);
		public int get_table (string! sql, out string[] resultp, ref int nrow, ref int ncolumn, out string errmsg);
		public static int open (string! filename, out Database db);
		public int errcode ();
		public weak string errmsg ();
		public int prepare (string! sql, int n_bytes, out Statement stmt, out string tail = null);
	}

	[CCode (cname = "sqlite3_callback")]
	public static delegate int Callback (pointer data, int n_columns, string[] values, string[] column_names);

	[CCode (free_function = "sqlite3_finalize", cname = "sqlite3_stmt", cprefix = "sqlite3_")]
	public class Statement {
		[NoArrayLength]
		public int bind_blob (int index, uchar[] value, int n, GLib.DestroyNotify destroy_notify);
		public int bind_double (int index, double value);
		public int bind_int (int index, int value);
		public int bind_int64 (int index, int64 value);
		public int bind_null (int index);
		public int bind_text (int index, string! value, int n, GLib.DestroyNotify destroy_notify);
		public int bind_parameter_count ();
		public string bind_parameter_name (int index);
		public int bind_parameter_index (string! name);
		public int clear_bindings ();
		public int column_count ();
		public string! column_name (int index);
		public int step ();
		public int column_int (int i_col);
	}
}

