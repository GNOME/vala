namespace GLib {
	[CCode (cheader_filename = "glib-object.h", get_value_function = "g_value_get_object", marshaller_type_name = "OBJECT", param_spec_function = "g_param_spec_object", ref_function = "g_object_ref", set_value_function = "g_value_set_object", take_value_function = "g_value_take_object", unref_function = "g_object_unref")]
	public class Object {
	}

	[CCode (get_value_function = "g_value_get_param", param_spec_function = "g_param_spec_param", ref_function = "g_param_spec_ref", set_value_function = "g_value_set_param", take_value_function = "g_value_take_param", type_id = "G_TYPE_PARAM", unref_function = "g_param_spec_unref")]
	public class ParamSpec {
	}

	// FIXME silently skipped, girparser bug?
	[CCode (cheader_filename = "glib-object.h", type_id = "G_TYPE_PARAM_ENUM")]
	public class ParamSpecEnum : GLib.ParamSpec {
		public int default_value;
		public weak GLib.EnumClass enum_class;
	}

	[CCode (cheader_filename = "glib-object.h", cname = "guint")]
	public struct Signal : uint {
	}

	[CCode (copy_function = "g_value_copy", destroy_function = "g_value_unset", get_value_function = "g_value_get_boxed", marshaller_type_name = "BOXED", set_value_function = "g_value_set_boxed", take_value_function = "g_value_take_boxed", type_id = "G_TYPE_VALUE", type_signature = "v")]
	public struct Value {
	}
}
