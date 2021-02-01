/* libunwind-generic.vapi
 *
 * Copyright (C) 2021  Rico Tzschichholz
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

[CCode (cprefix = "UNW", cheader_filename = "libunwind.h", lower_case_cprefix = "unw_")]
namespace Unwind {
	public const int VERSION_MAJOR;
	public const int VERSION_MINOR;
	public const int VERSION_EXTRA;
	[CCode (cname = "UNW_VERSION_CODE")]
	public int version_code (int maj, int min);
	public const int VERSION;

	[CCode (cname = "unw_error_t", cprefix = "UNW_", has_type_id = false)]
	public enum Error {
		ESUCCESS,
		EUNSPEC,
		ENOMEM,
		EBADREG,
		EREADONLYREG,
		ESTOPUNWIND,
		EINVALIDIP,
		EBADFRAME,
		EINVAL,
		EBADVERSION,
		ENOINFO;
		[CCode (cname = "unw_strerror")]
		public unowned string to_string ();
	}

	[CCode (cname = "unw_frame_regnum_t", cprefix = "UNW_REG_", has_type_id = false)]
	public enum FrameRegnum {
		IP,
		SP,
		EH,
		LAST
	}

	[CCode (cname = "unw_caching_policy_t", cprefix = "UNW_CACHE_", has_type_id = false)]
	public enum CachingPolicy {
		NONE,
		GLOBAL,
		PER_THREAD
	}

	[CCode (cname = "unw_init_local2_flags_t", cprefix = "UNW_INIT_", has_type_id = false)]
	public enum InitLocal2Flags {
		SIGNAL_FRAME
	}

	[IntegerType (rank = 8)]
	[CCode (cname = "unw_regnum_t", lower_case_cprefix = "unw_")]
	public struct Regnum : int {
		[CCode (cname = "unw_regname")]
		public unowned string get_name ();
		public int is_fpreg ();
	}

	[FloatingType (rank = 9)]
	[CCode (cname = "unw_fpreg_t")]
	public struct Fpreg {
	}

	[IntegerType (rank = 9)]
	[CCode (cname = "unw_word_t")]
	public struct Word {
	}

	[CCode (cname = "struct unw_addr_space", lower_case_cprefix = "unw_", free_function = "unw_destroy_addr_space")]
	public struct AddrSpace {
		[CCode (array_length = false)]
		public Accessors[] get_accessors ();
		[CCode (array_length = false)]
		public Accessors[] get_accessors_int ();
		public void flush_cache (Word w1, Word w2);
		public int get_proc_info_by_ip (Word w, out ProcInfo pi, void* d);
		public int set_caching_policy (CachingPolicy cp);
		public int set_cache_size (size_t size, int i);
	}

	[CCode (cname = "UNW_TDEP_CURSOR_LEN")]
	public const int TDEP_CURSOR_LEN;

	[CCode (cname = "unw_cursor_t", lower_case_cprefix = "unw_")]
	public struct Cursor {
		public Word opaque[TDEP_CURSOR_LEN];
		public static int init_local (out Cursor cur, Context? ctx);
		public static int init_local2 (out Cursor cur, Context? ctx, int i);
		public static int init_remote (out Cursor cur, AddrSpace? addr, void* d);
		public int step ();
		public int resume ();
		public int get_proc_info (out ProcInfo pi);
		public int reg_states_iterate (RegStatesCallback cb, void* d);
		public int apply_reg_state (void* d);
		public int get_reg (Regnum rn, out Word w);
		public int set_reg (Regnum rn, Word w);
		public int get_fpreg (Regnum rn, out Fpreg off);
		public int set_fpreg (Regnum rn, Fpreg off);
		public int get_save_loc (int i, out SaveLoc loc);
		public int is_signal_frame ();
		public int handle_signal_frame ();
		public int get_proc_name ([CCode (array_length_type = "size_t")] char[] name, out Word off);
	}

	[CCode (cname = "unw_context_t")]
	public struct Context {
		[CCode (cname = "unw_getcontext")]
		public Context ();
	}

	[CCode (cname = "unw_proc_info_t")]
	public struct ProcInfo {
		public Word start_ip;
		public Word end_ip;
		//public Word last_ip;
		public Word lsda;
		public Word handler;
		public Word gp;
		public Word flags;

		public int format;
		public int unwind_info_size;
		public void* unwind_info;
		//unw_tdep_proc_info_t extra;
	}

	[CCode (cname = "unw_reg_states_callback", has_target = false)]
	public delegate int RegStatesCallback (void* token, [CCode (array_length_type = "size_t")] void[] reg_states_data, Word start_ip, Word end_ip);
	[CCode (has_typedef = false)]
	public delegate int AccessorsFindProcInfoCallback (AddrSpace addr, Word w, ProcInfo pi, int i);
	[CCode (has_typedef = false)]
	public delegate void AccessorsPutUnwindInfoCallback (AddrSpace addr, ProcInfo pi);
	[CCode (has_typedef = false)]
	public delegate int AccessorsGetDynInfoListAddrCallback (AddrSpace addr, out Word ow);
	[CCode (has_typedef = false)]
	public delegate int AccessorsAccessMemCallback (AddrSpace addr, Word w, out Word ow, int i);
	[CCode (has_typedef = false)]
	public delegate int AccessorsAccessRegCallback (AddrSpace addr, Regnum rn, out Word ow, int i);
	[CCode (has_typedef = false)]
	public delegate int AccessorsAccessFpregCallback (AddrSpace addr, Regnum rn, out Fpreg fr, int i);
	[CCode (has_typedef = false)]
	public delegate int AccessorsResumeCallback (AddrSpace addr, Cursor cur);
	[CCode (has_typedef = false)]
	public delegate int AccessorsGetProcNameCallback (AddrSpace addr, Word w, [CCode (array_length_type = "size_t")] char[] name, out Word ow);

	[CCode (cname = "unw_accessors_t", lower_case_cprefix = "unw_")]
	public struct Accessors {
		[CCode (delegate_target = false)]
		public AccessorsFindProcInfoCallback find_proc_info;
		[CCode (delegate_target = false)]
		public AccessorsPutUnwindInfoCallback put_unwind_info;
		[CCode (delegate_target = false)]
		public AccessorsGetDynInfoListAddrCallback get_dyn_info_list_addr;
		[CCode (delegate_target = false)]
		public AccessorsAccessMemCallback access_mem;
		[CCode (delegate_target = false)]
		public AccessorsAccessRegCallback access_reg;
		[CCode (delegate_target = false)]
		public AccessorsAccessFpregCallback access_fpreg;
		[CCode (delegate_target = false)]
		public AccessorsResumeCallback resume;
		[CCode (delegate_target = false)]
		public AccessorsGetProcNameCallback? get_proc_name;

		public AddrSpace? create_addr_space (int i);
	}

	[CCode (cname = "unw_save_loc_type_t", cprefix = "UNW_SLT_", has_type_id = false)]
	public enum SaveLocType {
		NONE,
		MEMORY,
		REG
	}


	[CCode (cname = "unw_save_loc_t")]
	public struct SaveLoc {
		public SaveLocType type;
		[CCode (cname = "u.addr")]
		public Word addr;
		[CCode (cname = "u.regnum")]
		public Regnum regnum;
		//public unw_tdep_save_loc_t extra;
	}
}
