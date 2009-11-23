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
	/* Database Connection Handle */
	[Compact]
	[CCode (free_function = "sqlite3_close", cname = "sqlite3", cprefix = "sqlite3_")]
	public class Database {
		public int busy_timeout (int ms);
		public int changes ();
		public int exec (string sql, Callback? sqlite3_callback = null, out string errmsg = null);
		public int extended_result_codes (int onoff);
		public int get_autocommit ();
		public void interrupt ();
		public int64 last_insert_rowid ();
		public int total_changes ();

		public int complete (string sql);
		public int get_table (string sql, [CCode (array_length = false)] out weak string[] resultp, out int nrow, out int ncolumn, out string errmsg);
		public static void free_table ([CCode (array_length = false)] string[] result);
		public static int open (string filename, out Database db);
		public static int open_v2 (string filename, out Database db, int flags = OPEN_READWRITE | OPEN_CREATE, string? zVfs = null);
		public int errcode ();
		public weak string errmsg ();
		public int prepare (string sql, int n_bytes, out Statement stmt, out string tail = null);
		public int prepare_v2 (string sql, int n_bytes, out Statement stmt, out string tail = null);
		public void trace (TraceCallback? xtrace);
		public void profile (ProfileCallback? xprofile);
		public void progress_handler (int n_opcodes, Sqlite.ProgressCallback? progress_handler);
		public void commit_hook (CommitCallback? commit_hook);
		public void rollback_hook (RollbackCallback? rollback_hook);
	}

	[CCode (instance_pos = 0)]
	public delegate void TraceCallback (string message);
	[CCode (instance_pos = 0)]
	public delegate void ProfileCallback (string sql, uint64 time);
	public delegate int ProgressCallback ();
	public delegate int CommitCallback ();
	public delegate void RollbackCallback ();

	/* Dynamically Typed Value Object */
	[Compact]
	[CCode (cname = "sqlite3_value")]
	public class Value {
		[CCode (cname = "sqlite3_value_blob")]
		public void* to_blob ();
		[CCode (cname = "sqlite3_value_bytes")]
		public int to_bytes ();
		[CCode (cname = "sqlite3_value_double")]
		public double to_double ();
		[CCode (cname = "sqlite3_value_int")]
		public int to_int ();
		[CCode (cname = "sqlite3_value_int64")]
		public int64 to_int64 ();
		[CCode (cname = "sqlite3_value_text")]
		public weak string to_text ();
		[CCode (cname = "sqlite3_value_type")]
		public int to_type ();
		[CCode (cname = "sqlite3_value_numeric_type")]
		public int to_numeric_type ();
	}

	[CCode (cname = "sqlite3_callback", instance_pos = 0)]
	public delegate int Callback (int n_columns, [CCode (array_length = false)] string[] values, [CCode (array_length = false)] string[] column_names);

	[CCode (cname = "SQLITE_OK")]
	public const int OK;
	[CCode (cname = "SQLITE_ERROR")]
	public const int ERROR;
	[CCode (cname = "SQLITE_INTERNAL")]
	public const int INTERNAL;
	[CCode (cname = "SQLITE_PERM")]
	public const int PERM;
	[CCode (cname = "SQLITE_ABORT")]
	public const int ABORT;
	[CCode (cname = "SQLITE_BUSY")]
	public const int BUSY;
	[CCode (cname = "SQLITE_LOCKED")]
	public const int LOCKED;
	[CCode (cname = "SQLITE_NOMEM")]
	public const int NOMEM;
	[CCode (cname = "SQLITE_READONLY")]
	public const int READONLY;
	[CCode (cname = "SQLITE_INTERRUPT")]
	public const int INTERRUPT;
	[CCode (cname = "SQLITE_IOERR")]
	public const int IOERR;
	[CCode (cname = "SQLITE_CORRUPT")]
	public const int CORRUPT;
	[CCode (cname = "SQLITE_NOTFOUND")]
	public const int NOTFOUND;
	[CCode (cname = "SQLITE_FULL")]
	public const int FULL;
	[CCode (cname = "SQLITE_CANTOPEN")]
	public const int CANTOPEN;
	[CCode (cname = "SQLITE_PROTOCOL")]
	public const int PROTOCOL;
	[CCode (cname = "SQLITE_EMPTY")]
	public const int EMPTY;
	[CCode (cname = "SQLITE_SCHEMA")]
	public const int SCHEMA;
	[CCode (cname = "SQLITE_TOOBIG")]
	public const int TOOBIG;
	[CCode (cname = "SQLITE_CONSTRAINT")]
	public const int CONSTRAINT;
	[CCode (cname = "SQLITE_MISMATCH")]
	public const int MISMATCH;
	[CCode (cname = "SQLITE_MISUSE")]
	public const int MISUSE;
	[CCode (cname = "SQLITE_NOLFS")]
	public const int NOLFS;
	[CCode (cname = "SQLITE_AUTH")]
	public const int AUTH;
	[CCode (cname = "SQLITE_FORMAT")]
	public const int FORMAT;
	[CCode (cname = "SQLITE_RANGE")]
	public const int RANGE;
	[CCode (cname = "SQLITE_NOTADB")]
	public const int NOTADB;
	[CCode (cname = "SQLITE_ROW")]
	public const int ROW;
	[CCode (cname = "SQLITE_DONE")]
	public const int DONE;
	[CCode (cname = "SQLITE_OPEN_READONLY")]
	public const int OPEN_READONLY;
	[CCode (cname = "SQLITE_OPEN_READWRITE")]
	public const int OPEN_READWRITE;
	[CCode (cname = "SQLITE_OPEN_CREATE")]
	public const int OPEN_CREATE;
	[CCode (cname = "SQLITE_INTEGER")]
	public const int INTEGER;
	[CCode (cname = "SQLITE_FLOAT")]
	public const int FLOAT;
	[CCode (cname = "SQLITE_BLOB")]
	public const int BLOB;
	[CCode (cname = "SQLITE_NULL")]
	public const int NULL;
	[CCode (cname = "SQLITE3_TEXT")]
	public const int TEXT;
	[CCode (cname = "SQLITE_MUTEX_FAST")]
	public const int MUTEX_FAST;
	[CCode (cname = "SQLITE_MUTEX_RECURSIVE")]
	public const int MUTEX_RECURSIVE;

	/* SQL Statement Object */
	[Compact]
	[CCode (free_function = "sqlite3_finalize", cname = "sqlite3_stmt", cprefix = "sqlite3_")]
	public class Statement {
		public int bind_parameter_count ();
		public int bind_parameter_index (string name);
		public weak string bind_parameter_name (int index);
		public int clear_bindings ();
		public int column_count ();
		public int data_count ();
		public weak Database db_handle ();
		public int reset ();
		public int step ();
		public int bind_blob (int index, void* value, int n, GLib.DestroyNotify destroy_notify);
		public int bind_double (int index, double value);
		public int bind_int (int index, int value);
		public int bind_int64 (int index, int64 value);
		public int bind_null (int index);
		public int bind_text (int index, owned string value, int n = -1, GLib.DestroyNotify destroy_notify = GLib.g_free);
		public int bind_value (int index, Value value);
		public int bind_zeroblob (int index, int n);
		public void* column_blob (int col);
		public int column_bytes (int col);
		public double column_double (int col);
		public int column_int (int col);
		public int64 column_int64 (int col);
		public weak string column_text (int col);
		public int column_type (int col);
		public weak Value column_value (int col);
		public weak string column_name (int index);
		public weak string sql ();
	}

	[Compact]
	[CCode (cname = "sqlite3_mutex")]
	public class Mutex {
		[CCode (cname = "sqlite3_mutex_alloc")]
		public Mutex (int mutex_type = MUTEX_RECURSIVE);
		public void enter ();
		public int @try ();
		public void leave ();
	}
}

