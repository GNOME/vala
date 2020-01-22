/**
 * Based on the work by
 *   Copyright 2011 Jiří Janoušek <janousek.jiri@gmail.com>
 *   Copyright 2017 Michael Gratton <mike@vee.net>
 */
[CCode (cprefix = "JS", gir_namespace = "JavaScript", gir_version = "4.0", lower_case_cprefix = "JS_")]
[Version (deprecated = true, deprecated_since = "2.22")]
namespace JS {
	[CCode (cheader_filename = "JavaScriptCore/JavaScript.h", cname = "void", free_function = "JSClassRelease", has_type_id = false)]
	[Compact]
	public class Class {
		[CCode (cname = "JSClassRetain")]
		public JS.Class retain ();
		[CCode (cname = "JSClassRelease")]
		[DestroysInstance]
		public void release ();
	}
	[CCode (cheader_filename = "JavaScriptCore/JavaScript.h", cname = "const struct OpaqueJSContext", free_function = "", has_type_id = false)]
	[Compact]
	public class Context {
		[CCode (cname = "JSCheckScriptSyntax")]
		public bool check_script_syntax (JS.String script, JS.String? source_url = null, int starting_line_number = 1, out JS.Value? exception = null);
		[CCode (cname = "JSGarbageCollect")]
		public void collect_garbage ();
		[CCode (cname = "JSEvaluateScript")]
		public unowned JS.Value? evaluate_script (JS.String script, JS.Object? this_object = null, JS.String? source_url = null, int starting_line_number = 1, out JS.Value? exception = null);
	}
	[CCode (cheader_filename = "JavaScriptCore/JavaScript.h", cname = "struct OpaqueJSContext", free_function = "JSGlobalContextRelease", has_type_id = false)]
	[Compact]
	public class GlobalContext : JS.Context {
		[CCode (cname = "JSGlobalContextCreate")]
		public GlobalContext (JS.Class? global_object_class = null);
		[CCode (cname = "JSGlobalContextRelease")]
		[DestroysInstance]
		public void release ();
		[CCode (cname = "JSGlobalContextRetain")]
		public JS.GlobalContext retain ();
	}
	[CCode (cheader_filename = "JavaScriptCore/JavaScript.h", cname = "struct OpaqueJSValue", free_function = "", has_type_id = false)]
	[Compact]
	public class Object {
		[CCode (cname = "JSObjectCallAsFunction", instance_pos = 1.1)]
		public JS.Value call_as_function (JS.Context ctx, JS.Object? this_object, [CCode (array_length_pos = 2.5)] JS.Value[]? arguments, out JS.Value? exception);
		[CCode (cname = "JSObjectGetProperty", instance_pos = 1.1)]
		public JS.Value get_property (JS.Context ctx, JS.String property_name, out JS.Value? exception);
		[CCode (cname = "JSObjectHasProperty", instance_pos = 1.1)]
		public bool has_property (JS.Context ctx, JS.String property_name);
		[CCode (cname = "JSObjectMakeFunction")]
		public Object.make_function (JS.String? name, [CCode (array_length_pos = 1.5)] JS.String[]? parameter_names, JS.String body, JS.String? source_url, int starting_line_number, out JS.Value? exception);
	}
	[CCode (cheader_filename = "JavaScriptCore/JavaScript.h", cname = "struct OpaqueJSString", free_function = "JSStringRelease", has_type_id = false)]
	[Compact]
	public class String {
		[CCode (cname = "JSStringCreateWithUTF8CString")]
		public String.create_with_utf8_cstring (string str);
		[CCode (cname = "JSStringGetLength")]
		public size_t get_length ();
		[CCode (cname = "JSStringGetMaximumUTF8CStringSize")]
		public size_t get_maximum_utf8_cstring_size ();
		[CCode (cname = "JSStringGetUTF8CString")]
		public size_t get_utf8_cstring ([CCode (array_length_type = "gsize")] uint8[] buffer);
		[CCode (cname = "JSStringIsEqual")]
		public bool is_equal (JS.String b);
		[CCode (cname = "JSStringIsEqualToUTF8CString")]
		public bool is_equal_to_utf8_cstring (string b);
		[CCode (cname = "JSStringRelease")]
		[DestroysInstance]
		public void release ();
		[CCode (cname = "JSStringRetain")]
		public JS.String retain ();
	}
	[CCode (cheader_filename = "JavaScriptCore/JavaScript.h", cname = "const struct OpaqueJSValue", free_function = "", has_type_id = false)]
	[Compact]
	public class Value {
		[CCode (cname = "JSValueGetType", instance_pos = 1.1)]
		public JS.Type get_type (JS.Context ctx);

		[CCode (cname = "JSValueGetTypedArrayType", instance_pos = 1.1)]
		public JS.TypedArrayType get_typed_array_type (JS.Context ctx);

		[CCode (cname = "JSValueIsArray", instance_pos = 1.1)]
		public bool is_array (JS.Context ctx);
		[CCode (cname = "JSValueIsBoolean", instance_pos = 1.1)]
		public bool is_boolean (JS.Context ctx);
		[CCode (cname = "JSValueIsDate", instance_pos = 1.1)]
		public bool is_date (JS.Context ctx);
		[CCode (cname = "JSValueIsNumber", instance_pos = 1.1)]
		public bool is_number (JS.Context ctx);
		[CCode (cname = "JSValueIsObject", instance_pos = 1.1)]
		public bool is_object (JS.Context ctx);
		[CCode (cname = "JSValueIsObjectOfClass", instance_pos = 1.1)]
		public bool is_object_of_class (JS.Context ctx, JS.Class js_class);
		[CCode (cname = "JSValueIsString", instance_pos = 1.1)]
		public bool is_string (JS.Context ctx);
		[CCode (cname = "JSValueIsUndefined", instance_pos = 1.1)]
		public bool is_undefined (JS.Context ctx);
		[CCode (cname = "JSValueIsNull", instance_pos = 1.1)]
		public bool is_null (JS.Context ctx);

		[CCode (cname = "JSValueIsEqual", instance_pos = 1.1)]
		public bool is_equal (JS.Context ctx, JS.Value b, out JS.Value? exception = null);
		[CCode (cname = "JSValueIsStrictEqual", instance_pos = 1.1)]
		public bool is_strict_equal (JS.Context ctx, JS.Value b);

		[CCode (cname = "JSValueToBoolean", instance_pos = 1.1)]
		public bool to_boolean (JS.Context ctx);
		[CCode (cname = "JSValueToNumber", instance_pos = 1.1)]
		public double to_number (JS.Context ctx, out JS.Value? exception = null);
		[CCode (cname = "JSValueToObject", instance_pos = 1.1)]
		public JS.Object to_object (JS.Context ctx, out JS.Value? exception = null);
		[CCode (cname = "JSValueToStringCopy", instance_pos = 1.1)]
		public JS.String to_string_copy (JS.Context ctx, out JS.Value? exception = null);

		[CCode (cname = "JSValueProtect", instance_pos = 1.1)]
		public void protect (JS.Context ctx);
		[CCode (cname = "JSValueUnprotect", instance_pos = 1.1)]
		public void unprotect (JS.Context ctx);
	}
	[CCode (cheader_filename = "JavaScriptCore/JavaScript.h", cname = "JSType", has_type_id = false)]
	public enum Type {
		[CCode (cname = "kJSTypeUndefined")]
		UNDEFINED,
		[CCode (cname = "kJSTypeNull")]
		NULL,
		[CCode (cname = "kJSTypeBoolean")]
		BOOLEAN,
		[CCode (cname = "kJSTypeNumber")]
		NUMBER,
		[CCode (cname = "kJSTypeString")]
		STRING,
		[CCode (cname = "kJSTypeObject")]
		OBJECT
	}
	[CCode (cheader_filename = "JavaScriptCore/JavaScript.h", cname = "JSTypedArrayType", has_type_id = false)]
	public enum TypedArrayType {
		[CCode (cname = "kJSTypedArrayTypeInt8Array")]
		INT8,
		[CCode (cname = "kJSTypedArrayTypeInt16Array")]
		INT16,
		[CCode (cname = "kJSTypedArrayTypeInt32Array")]
		INT32,
		[CCode (cname = "kJSTypedArrayTypeUint8Array")]
		UINT8,
		[CCode (cname = "kJSTypedArrayTypeUint8ClampedArray")]
		UINT8_CLAMPED,
		[CCode (cname = "kJSTypedArrayTypeUint16Array")]
		UINT16,
		[CCode (cname = "kJSTypedArrayTypeUint32Array")]
		UINT32,
		[CCode (cname = "kJSTypedArrayTypeFloat32Array")]
		FLOAT32,
		[CCode (cname = "kJSTypedArrayTypeFloat64Array")]
		FLOAT64,
		[CCode (cname = "kJSTypedArrayTypeArrayBuffer")]
		BUFFER,
		[CCode (cname = "kJSTypedArrayTypeNone")]
		NONE
	}
}

namespace JSC {
	[CCode (type_cname = "GCallback", instance_pos = 1.9)]
	public delegate T ClassConstructorCb<T> (GLib.GenericArray<JSC.Value> values);
	[CCode (type_cname = "GCallback", instance_pos = 2.9)]
	public delegate T ClassMethodCb<T> (JSC.Class instance, GLib.GenericArray<JSC.Value> values);
}
