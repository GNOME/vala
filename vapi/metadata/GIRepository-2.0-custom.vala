namespace GI {
	[CCode (cheader_filename = "girepository.h", ref_function = "g_base_info_ref", unref_function = "g_base_info_unref", lower_case_cprefix = "g_base_info_", type_id = "g_base_info_gtype_get_type ()")]
	[Compact]
	public class BaseInfo {
		[CCode (cname = "g_info_new", has_construct_function = false)]
		public BaseInfo (GI.InfoType type, GI.BaseInfo container, GI.Typelib typelib, uint32 offset);
	}
}
