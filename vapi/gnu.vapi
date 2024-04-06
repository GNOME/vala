/* gnu.vapi
 *
 * Copyright (C) 2020, 2024 Reuben Thomas
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
 *	Reuben Thomas <rrt@sc3d.org>
 */

[CCode (cprefix = "", lower_case_cprefix = "")]
namespace Gnu {
	/**
	 * Provides the values for the 'has_arg' field of 'GetoptOption'.
	 */
	[CCode (cname = "int", cprefix = "", cheader_filename = "getopt.h", has_type_id = false)]
	public enum GetoptArgument {
		[CCode (cname = "no_argument")]
		NONE,
		[CCode (cname = "required_argument")]
		REQUIRED,
		[CCode (cname = "optional_argument")]
		OPTIONAL
	}

	[CCode (cname = "struct option", cheader_filename = "getopt.h", has_type_id = false)]
	public struct GetoptOption {
		public unowned string name;
		public int has_arg;
		public int *flag;
		public int val;
	}

	[CCode (cheader_filename = "getopt.h")]
	public int getopt_long ([CCode (array_length_pos = 0.1)] string[] args, string shortopts, [CCode (array_length = false, array_null_terminated = true)] GetoptOption[] longopts, out int longind);
	[CCode (cheader_filename = "getopt.h")]
	public int getopt_long_only ([CCode (array_length_pos = 0.1)] string[] args, string shortopts, [CCode (array_length = false, array_null_terminated = true)] GetoptOption[] longopts, out int longind);


	[CCode (cheader_filename = "string.h", feature_test_macro = "_GNU_SOURCE")]
	public string memmem (string haystack, size_t haystack_len, string needle, size_t needle_len);

	[CCode (cheader_filename = "error.h")]
	[PrintfFormat]
	public void error (int status, int errnum, string format, ...);

	/**
	 * Provides the values for the 'operation' argument of 'flock'.
	 */
	[CCode (cname = "int", cprefix = "LOCK_", cheader_filename = "sys/file.h", has_type_id = false)]
	public enum FlockOperation {
		SH,
		EX,
		UN
	}
	[CCode (cheader_filename = "sys/file.h")]
	public int flock (int fd, FlockOperation operation);

	[CCode (cheader_filename = "quote.h")]
	public string quote (string arg);
}
