namespace GTop {
	[CCode (cheader_filename = "glibtop/command.h", cname = "glibtop_response_union", has_type_id = false, lower_case_cprefix = "glibtop_")]
	[GIR (name = "glibtop_response_union")]
	public struct ResponseUnion {
		public GTop.Union data;
		public GTop.SysDeps sysdeps;
	}
	[CCode (cheader_filename = "glibtop/union.h", cname = "glibtop_union", has_type_id = false, lower_case_cprefix = "glibtop_")]
	[GIR (name = "glibtop_union")]
	public struct Union {
		public GTop.Cpu cpu;
		public GTop.Mem mem;
		public GTop.Swap swap;
		public GTop.Uptime uptime;
		public GTop.LoadAvg loadavg;
		public GTop.ShmLimits shm_limits;
		public GTop.MsgLimits msg_limits;
		public GTop.SemLimits sem_limits;
		public GTop.ProcList proclist;
		public GTop.ProcState proc_state;
		public GTop.ProcUid proc_uid;
		public GTop.ProcMem proc_mem;
		public GTop.ProcTime proc_time;
		public GTop.Signal proc_signal;
		public GTop.ProcKernel proc_kernel;
		public GTop.Segment proc_segment;
		public GTop.ProcArgs proc_args;
		public GTop.ProcMap proc_map;
		public GTop.MountList mountlist;
		public GTop.FsUsage fsusage;
		public GTop.NetList netlist;
		public GTop.NetLoad netload;
		public GTop.Ppp ppp;
		public GTop.ProcOpenFiles proc_open_files;
		public GTop.ProcWd proc_wd;
		public GTop.ProcAffinity proc_affinity;
		public GTop.ProcIO proc_io;
	}
}
