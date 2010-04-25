/* mysql.vala
 *
 * Copyright (C) 2008 Jukka-Pekka Iivonen
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
 * 	Jukka-Pekka Iivonen <jp0409@jippii.fi>
 */

[CCode (lower_case_cprefix = "mysql_", cheader_filename = "mysql/mysql.h")]
namespace Mysql {
	/* Database Connection Handle */
	[Compact]
	[CCode (free_function = "mysql_close", cname = "MYSQL", cprefix = "mysql_")]
	public class Database {
		[CCode (cname = "mysql_init")]
		public Database (Database? mysql = null);

		public ulong affected_rows ();
		public bool autocommit (bool mode);
		public bool change_user (string username, string passwd, string dbname);
		public unowned string character_set_name ();
		public bool commit ();
		public int dump_debug_info ();
		public uint errno ();
		public unowned string error ();
		public unowned string get_host_info ();
		public uint get_proto_info ();
		public unowned string get_server_info ();
		public ulong get_server_version ();
		public unowned string get_ssl_cipher ();
		public unowned string info ();
		public ulong insert_id ();
		public int kill (ulong pid);
		public Result list_dbs (string wild);
		public Result list_fields (string table, string wild);
		public Result list_processes ();
		public Result list_tables (string wild);
		public bool more_results ();
		public int next_result ();
		public int options (int option, string arg);
		public int ping ();
		public int query (string stmt_str);
		public bool real_connect (string? host = null, string? username = null, string? passwd = null, string? dbname = null, uint port = 0, string? unix_socket = null, ulong client_flag = 0);
		public ulong real_escape_string (string to, string from, ulong length);
		public int real_query (string query, ulong len);
		public int reload ();
		public bool rollback ();
		public int select_db (string dbname);
		public int set_character_set (string csname);
		public void set_local_infile_default ();
		public int set_server_option (int option);
		public unowned string sqlstate ();
		public int shutdown (int shutdown_level);
		public bool ssl_set (string key, string cert, string ca, string capath, string cipher);
		public unowned string stat ();
		public Result? store_result ();
		public ulong thread_id ();
		public Result use_result ();
		public uint warning_count ();
	}
	[Compact]
	[CCode (free_function = "mysql_free_result", cname = "MYSQL_RES", cprefix = "mysql_")]
	public class Result {
		public bool eof ();
		public Field fetch_field ();
		public Field fetch_field_direct (uint field_nbr);
		public Field[] fetch_fields ();
		public ulong[] fetch_lengths ();
		[CCode (array_length = false, array_null_terminated = true)]
		public unowned string[]? fetch_row ();		
		public uint fetch_count ();
		public uint num_fields ();
		public uint num_rows ();
		
		public bool data_seek (ulong offset);
	}
	[CCode (cname = "MYSQL_FIELD")]
	public struct Field {
	}
	
	public unowned string get_client_info ();
	public ulong get_client_version ();
	public void debug (string msg);
	public ulong hex_string (string to, string from, ulong length);
	public void library_end ();
	public int library_init ([CCode (array_length_pos = 0.1)] string[] argv, [CCode (array_length = false, array_null_terminated = true)] string[]? groups = null);
	public void server_end ();
	public int server_init ([CCode (array_length_pos = 0.1)] string[] argv, [CCode (array_length = false, array_null_terminated = true)] string[]? groups = null);
	public void thread_end ();
	public bool thread_init ();
	public uint thread_safe ();
}

