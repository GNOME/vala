namespace GLib {
	[CCode (cheader_filename = "glib-object.h", get_value_function = "g_value_get_object", marshaller_type_name = "OBJECT", param_spec_function = "g_param_spec_object", ref_function = "g_object_ref", set_value_function = "g_value_set_object", take_value_function = "g_value_take_object", unref_function = "g_object_unref")]
	public class Object : TypeInstance {
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

	[CCode (cheader_filename = "glib-object.h", has_type_id = false)]
	public abstract class TypeClass {
	}

	[CCode (cheader_filename = "glib-object.h", has_type_id = false)]
	public abstract class TypeInstance {
	}

	[CCode (cheader_filename = "glib-object.h", cname = "guint")]
	public struct Signal : uint {
	}

	[CCode (cheader_filename = "glib-object.h", get_value_function = "g_value_get_gtype", marshaller_type_name = "GTYPE", set_value_function = "g_value_set_gtype", type_id = "G_TYPE_GTYPE")]
	[GIR (fullname = "GType")]
	public struct Type : ulong {
		public const GLib.Type BOOLEAN;
		public const GLib.Type BOXED;
		public const GLib.Type CHAR;
		public const GLib.Type DOUBLE;
		public const GLib.Type ENUM;
		public const GLib.Type FLAGS;
		public const GLib.Type FLOAT;
		public const GLib.Type INT;
		public const GLib.Type INT64;
		public const GLib.Type INTERFACE;
		public const GLib.Type INVALID;
		public const GLib.Type LONG;
		public const GLib.Type NONE;
		public const GLib.Type OBJECT;
		public const GLib.Type PARAM;
		public const GLib.Type POINTER;
		public const GLib.Type STRING;
		public const GLib.Type UCHAR;
		public const GLib.Type UINT;
		public const GLib.Type UINT64;
		public const GLib.Type ULONG;
		public const GLib.Type VARIANT;

		[CCode (cname = "G_TYPE_IS_ABSTRACT")]
		public bool is_abstract ();
		[CCode (cname = "G_TYPE_IS_CLASSED")]
		public bool is_classed ();
		[CCode (cname = "G_TYPE_IS_DEEP_DERIVABLE")]
		public bool is_deep_derivable ();
		[CCode (cname = "G_TYPE_IS_DERIVABLE")]
		public bool is_derivable ();
		[CCode (cname = "G_TYPE_IS_DERIVED")]
		public bool is_derived ();
		[CCode (cname = "G_TYPE_IS_ENUM")]
		public bool is_enum ();
		[CCode (cname = "G_TYPE_IS_FINAL")]
		[Version (since = "2.70")]
		public bool is_final ();
		[CCode (cname = "G_TYPE_IS_FLAGS")]
		public bool is_flags ();
		[CCode (cname = "G_TYPE_IS_FUNDAMENTAL")]
		public bool is_fundamental ();
		[CCode (cname = "G_TYPE_IS_INSTANTIATABLE")]
		public bool is_instantiatable ();
		[CCode (cname = "G_TYPE_IS_INTERFACE")]
		public bool is_interface ();
		[CCode (cname = "G_TYPE_IS_OBJECT")]
		public bool is_object ();
		[CCode (cname = "G_TYPE_IS_VALUE_TYPE")]
		public bool is_value_type ();

		[CCode (cname = "G_TYPE_FROM_INSTANCE")]
		public static GLib.Type from_instance (void* instance);
	}

	[CCode (copy_function = "g_value_copy", destroy_function = "g_value_unset", get_value_function = "g_value_get_boxed", marshaller_type_name = "BOXED", set_value_function = "g_value_set_boxed", take_value_function = "g_value_take_boxed", type_id = "G_TYPE_VALUE", type_signature = "v")]
	public struct Value {
	}
}
