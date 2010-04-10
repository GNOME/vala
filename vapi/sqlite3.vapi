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
		public int get_table (string sql, [CCode (array_length = false)] out unowned string[] resultp, out int nrow, out int ncolumn, out string errmsg);
		public static void free_table ([CCode (array_length = false)] string[] result);
		public static int open (string filename, out Database db);
		public static int open_v2 (string filename, out Database db, int flags = OPEN_READWRITE | OPEN_CREATE, string? zVfs = null);
		public int errcode ();
		public unowned string errmsg ();
		public int prepare (string sql, int n_bytes, out Statement stmt, out string tail = null);
		public int prepare_v2 (string sql, int n_bytes, out Statement stmt, out string tail = null);
		public void trace (TraceCallback? xtrace);
		public void profile (ProfileCallback? xprofile);
		public void progress_handler (int n_opcodes, Sqlite.ProgressCallback? progress_handler);
		public void commit_hook (CommitCallback? commit_hook);
		public void rollback_hook (RollbackCallback? rollback_hook);
		[CCode (simple_generics = true)]
		public int create_function (string zFunctionName, int nArg, int eTextRep, void * user_data, UserFuncCallback? xFunc, UserFuncCallback? xStep, UserFuncFinishCallback? xFinal);
	}

	[CCode (instance_pos = 0)]
	public delegate void TraceCallback (string message);
	[CCode (instance_pos = 0)]
	public delegate void ProfileCallback (string sql, uint64 time);
	public delegate int ProgressCallback ();
	public delegate int CommitCallback ();
	public delegate void RollbackCallback ();
	[CCode (has_target = false)]
	public delegate void UserFuncCallback (Sqlite.Context context, [CCode (array_length_pos = 1.1)] Sqlite.Value[] values);
	[CCode (has_target = false)]
	public delegate void UserFuncFinishCallback (Sqlite.Context context);

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
		public unowned string to_text ();
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
	[CCode (cname = "SQLITE_UTF8")]
	public const int UTF8;
	[CCode (cname = "SQLITE_UTF16LE")]
	public const int UTF16LE;
	[CCode (cname = "SQLITE_UTF16BE")]
	public const int UTF16BE;
	[CCode (cname = "SQLITE_UTF16")]
	public const int UTF16;
	[CCode (cname = "SQLITE_ANY")]
	public const int ANY;
	[CCode (cname = "SQLITE_UTF16_ALIGNED")]
	public const int UTF16_ALIGNED;

	[CCode (cname = "int", cprefix = "SQLITE_STATUS_")]
	public enum Status {
		MEMORY_USED,
		PAGECACHE_USED,
		PAGECACHE_OVERFLOW,
		SCRATCH_USED,
		SCRATCH_OVERFLOW,
		MALLOC_SIZE,
		PARSER_STACK,
		PAGECACHE_SIZE,
		SCRATCH_SIZE,

		[CCode (cname = "SQLITE_STMTSTATUS_FULLSCAN_STEP")]
		STMT_FULLSCAN_STEP,
		[CCode (cname = "SQLITE_STMTSTATUS_SORT")]
		STMT_SORT
	}

	/* SQL Statement Object */
	[Compact]
	[CCode (free_function = "sqlite3_finalize", cname = "sqlite3_stmt", cprefix = "sqlite3_")]
	public class Statement {
		public int bind_parameter_count ();
		public int bind_parameter_index (string name);
		public unowned string bind_parameter_name (int index);
		public int clear_bindings ();
		public int column_count ();
		public int data_count ();
		public unowned Database db_handle ();
		public int reset ();
		[CCode (cname = "sqlite3_stmt_status")]
		public int status (Sqlite.Status op, int resetFlg);
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
		public unowned string column_text (int col);
		public int column_type (int col);
		public unowned Value column_value (int col);
		public unowned string column_name (int index);
		public unowned string sql ();
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

	[Compact, CCode (cname = "sqlite3_context", cprefix = "sqlite3_")]
	public class Context {
		public void result_blob (uint8[] data, GLib.DestroyNotify? destroy_notify = GLib.g_free);
		public void result_double (double value);
		public void result_error (string value, int error_code);
		public void result_error_toobig ();
		public void result_error_nomem ();
		public void result_error_code (int error_code);
		public void result_int (int value);
		public void result_int64 (int64 value);
		public void result_null ();
		public void result_text (string value, int length = -1, GLib.DestroyNotify? destroy_notify = GLib.g_free);
		public void result_value (Sqlite.Value value);
		public void result_zeroblob (int n);

		[CCode (simple_generics = true)]
		public unowned T user_data<T> ();
		[CCode (simple_generics = true)]
		public void set_auxdata<T> (int N, owned T data);
		[CCode (simple_generics = true)]
		public unowned T get_auxdata<T> (int N);
		[CCode (cname = "sqlite3_context_db_handle")]
		public unowned Database db_handle ();
		[CCode (cname = "sqlite3_aggregate_context")]
		public void * aggregate (int n_bytes);
	}
}

