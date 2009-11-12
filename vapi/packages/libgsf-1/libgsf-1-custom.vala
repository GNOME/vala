namespace Gsf {
	[SimpleType]
	[CCode (cname = "gint64", cheader_filename = "glib.h", type_id = "G_TYPE_INT64", marshaller_type_name = "INT64", get_value_function = "g_value_get_int64", set_value_function = "g_value_set_int64", default_value = "0LL", type_signature = "x")]
	[IntegerType (rank = 10)]
	public struct off_t : int64 {
	}

	[CCode (cheader_filename = "gsf/gsf-outfile-impl.h")]
	public class Outfile {
		public Gsf.Output new_child (string name, bool is_dir);
		public Gsf.Output new_child_full (string name, bool is_dir, ...);
	}
}