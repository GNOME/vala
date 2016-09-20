namespace Vala {
	namespace Utils {
		namespace Assume {
			[CCode (cheader_filename = "assume.h", cname = "vala_utils_assume")]
			public void assume (bool cond);
		}
		namespace Async {
			[CCode (cheader_filename = "async.h")]
			public async void yield_and_unlock (GLib.Mutex mutex);
		}
		namespace Free {
			[CCode (cheader_filename = "free.h")]
			public GLib.DestroyNotify? get_destroy_notify<G> ();
		}
		namespace Misc {
			[CCode (cheader_filename = "misc.h", simple_generics = true)]
			public void unused<G> (G unused);
		}
	}
}
