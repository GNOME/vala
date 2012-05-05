/* gobject-2.0.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
 * Copyright (C) 2007  Mathias Hasselmann
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
 * 	Jürg Billeter <j@bitron.ch>
 *	Raffaele Sandrini <rasa@gmx.ch>
 *	Mathias Hasselmann <mathias.hasselmann@gmx.de>
 */

[CCode (cprefix = "G", lower_case_cprefix = "g_", cheader_filename = "glib.h", gir_namespace = "GObject", gir_version = "2.0")]
namespace GLib {
	[CCode (type_id = "G_TYPE_GTYPE", marshaller_type_name = "GTYPE", get_value_function = "g_value_get_gtype", set_value_function = "g_value_set_gtype")]
	public struct Type : ulong {
		[CCode (cname = "G_TYPE_IS_OBJECT")]
		public bool is_object ();
		[CCode (cname = "G_TYPE_IS_ABSTRACT")]
		public bool is_abstract ();
		[CCode (cname = "G_TYPE_IS_CLASSED")]
		public bool is_classed ();
		[CCode (cname = "G_TYPE_IS_DERIVABLE")]
		public bool is_derivable ();
		[CCode (cname = "G_TYPE_IS_DEEP_DERIVABLE")]
		public bool is_deep_derivable ();
		[CCode (cname = "G_TYPE_IS_DERIVED")]
		public bool is_derived ();
		[CCode (cname = "G_TYPE_IS_FUNDAMENTAL")]
		public bool is_fundamental ();
		[CCode (cname = "G_TYPE_IS_INSTANTIATABLE")]
		public bool is_instantiatable ();
		[CCode (cname = "G_TYPE_IS_INTERFACE")]
		public bool is_interface ();
		[CCode (cname = "G_TYPE_IS_VALUE_TYPE")]
		public bool is_value_type ();
		[CCode (cname = "G_TYPE_IS_ENUM")]
		public bool is_enum ();
		[CCode (cname = "G_TYPE_IS_FLAGS")]
		public bool is_flags ();

		[CCode (cname = "G_TYPE_FROM_INSTANCE")]
		public static Type from_instance (void* instance);

		public Type[] children ();
		public uint depth ();
		public static Type from_name (string name);
		[CCode (array_length_type = "guint")]
		public Type[] interfaces ();
		public bool is_a (Type is_a_type);
		public unowned string name ();
		public Quark qname ();
		public Type parent ();

		public void* get_qdata (Quark quark);
		public void set_qdata (Quark quark, void* data);

		public void query (out TypeQuery query);

		public TypeClass class_ref ();
		public unowned TypeClass class_peek ();

		public const Type INVALID;
		public const Type INTERFACE;
		public const Type ENUM;
		public const Type FLAGS;
		public const Type BOXED;
	}

	public struct TypeQuery {
		public Type type;
		public unowned string type_name;
		public uint class_size;
		public uint instance_size;
	}

	[Compact]
	[CCode (ref_function = "g_type_class_ref", unref_function = "g_type_class_unref")]
	public class TypeClass {
		[CCode (cname = "G_TYPE_FROM_CLASS")]
		public Type get_type ();
	}

	[CCode (cprefix = "G_TYPE_DEBUG_", has_type_id = false)]
	public enum TypeDebugFlags {
		NONE,
		OBJECTS,
		SIGNALS,
		MASK
	}

	public interface TypePlugin {
	}

	[CCode (lower_case_csuffix = "type_module")]
	public class TypeModule : Object, TypePlugin {
		[CCode (has_construct_function = false)]
		protected TypeModule ();
		public bool use ();
		public void unuse ();
		public void set_name (string name);
		[NoWrapper]
		public virtual bool load ();
		[NoWrapper]
		public virtual void unload ();
	}

	[CCode (type_id = "G_TYPE_PARAM", ref_function = "g_param_spec_ref", unref_function = "g_param_spec_unref", param_spec_function = "g_param_spec_param", get_value_function = "g_value_get_param", set_value_function = "g_value_set_param", take_value_function = "g_value_take_param")]
	public class ParamSpec {
		public string name;
		public ParamFlags flags;
		public Type value_type;
		public Type owner_type;
		[CCode (cname = "g_param_spec_internal")]
		public ParamSpec.internal (GLib.Type param_type, string name, string nick, string blurb, GLib.ParamFlags flags);
		public ParamSpec ref ();
		public void unref ();
		public void sink ();
		public ParamSpec ref_sink ();
		[CCode (cname = "g_param_value_set_default")]
		public void set_value_default (Value value);
		[CCode (cname = "g_param_value_defaults")]
		public bool value_defaults (Value value);
		[CCode (cname = "g_param_value_validate")]
		public bool value_validate (Value value);
		[CCode (cname = "g_param_value_convert")]
		public bool value_convert (Value src_value, Value dest_value, bool strict_validation);
		[CCode (cname = "g_param_values_cmp")]
		public int values_cmp (Value value1, Value value2);
		public unowned string get_blurb ();
		public unowned string get_name ();
		public unowned string get_nick ();
		public void* get_qdata (Quark quark);
		public void set_qdata (Quark quark, void* data);
		public void set_qdata_full (Quark quark, void* data, DestroyNotify destroy);
		public void* steal_qdata (Quark quark);
		public ParamSpec get_redirect_target ();
	}

	public class ParamSpecBoolean : ParamSpec {
		[CCode (cname = "g_param_spec_boolean")]
		public ParamSpecBoolean (string name, string nick, string blurb, bool defaultvalue, ParamFlags flags);
		public bool default_value;
	}

	public class ParamSpecChar : ParamSpec {
		[CCode (cname = "g_param_spec_char")]
		public ParamSpecChar (string name, string nick, string blurb, int8 minimum, int8 maximum, int8 default_value, ParamFlags flags);
		public int8 minimum;
		public int8 maximum;
		public int8 default_value;
	}

	public class ParamSpecUChar : ParamSpec {
		[CCode (cname = "g_param_spec_uchar")]
		public ParamSpecUChar (string name, string nick, string blurb, uint8 minimum, uint8 maximum, uint8 default_value, ParamFlags flags);
		public uint8 minimum;
		public uint8 maximum;
		public uint8 default_value;
	}

	public class ParamSpecInt : ParamSpec {
		[CCode (cname = "g_param_spec_int")]
		public ParamSpecInt (string name, string nick, string blurb, int minimum, int maximum, int default_value, ParamFlags flags);
		public int minimum;
		public int maximum;
		public int default_value;
	}

	public class ParamSpecUInt : ParamSpec {
		[CCode (cname = "g_param_spec_uint")]
		public ParamSpecUInt (string name, string nick, string blurb, uint minimum, uint maximum, uint default_value, ParamFlags flags);
		public uint minimum;
		public uint maximum;
		public uint default_value;
	}

	public class ParamSpecLong : ParamSpec {
		[CCode (cname = "g_param_spec_long")]
		public ParamSpecLong (string name, string nick, string blurb, long minimum, long maximum, long default_value, ParamFlags flags);
		public long minimum;
		public long maximum;
		public long default_value;
	}

	public class ParamSpecULong : ParamSpec {
		[CCode (cname = "g_param_spec_ulong")]
		public ParamSpecULong (string name, string nick, string blurb, ulong minimum, ulong maximum, ulong default_value, ParamFlags flags);
		public ulong minimum;
		public ulong maximum;
		public ulong default_value;
	}

	public class ParamSpecInt64 : ParamSpec {
		[CCode (cname = "g_param_spec_int64")]
		public ParamSpecInt64 (string name, string nick, string blurb, int64 minimum, int64 maximum, int64 default_value, ParamFlags flags);
		public int64 minimum;
		public int64 maximum;
		public int64 default_value;
	}

	public class ParamSpecUInt64 : ParamSpec {
		[CCode (cname = "g_param_spec_uint64")]
		public ParamSpecUInt64 (string name, string nick, string blurb, uint64 minimum, uint64 maximum, uint64 default_value, ParamFlags flags);
		public uint64 minimum;
		public uint64 maximum;
		public uint64 default_value;
	}

	public class ParamSpecFloat : ParamSpec {
		[CCode (cname = "g_param_spec_float")]
		public ParamSpecFloat (string name, string nick, string blurb, float minimum, float maximum, float default_value, ParamFlags flags);
		public float minimum;
		public float maximum;
		public float default_value;
	}

	public class ParamSpecDouble : ParamSpec {
		[CCode (cname = "g_param_spec_double")]
		public ParamSpecDouble (string name, string nick, string blurb, double minimum, double maximum, double default_value, ParamFlags flags);
		public double minimum;
		public double maximum;
		public double default_value;
	}

	public class ParamSpecEnum : ParamSpec {
		[CCode (cname = "g_param_spec_enum")]
		public ParamSpecEnum (string name, string nick, string blurb, Type enum_type, int default_value, ParamFlags flags);
		public unowned EnumClass enum_class;
		public int default_value;
	}

	public class ParamSpecFlags : ParamSpec {
		[CCode (cname = "g_param_spec_flags")]
		public ParamSpecFlags (string name, string nick, string blurb, Type flags_type, uint default_value, ParamFlags flags);
		public unowned FlagsClass flags_class;
		public uint default_value;
	}

	public class ParamSpecString : ParamSpec {
		[CCode (cname = "g_param_spec_string")]
		public ParamSpecString (string name, string nick, string blurb, string default_value, ParamFlags flags);
		public string default_value;
		public string cset_first;
		public string cset_nth;
		public char substitutor;
		public uint null_fold_if_empty;
		public uint ensure_non_null;
	}

	public class ParamSpecParam : ParamSpec {
		[CCode (cname = "g_param_spec_param")]
		public ParamSpecParam (string name, string nick, string blurb, Type param_type, ParamFlags flags);
	}

	[CCode (cprefix = "G_PARAM_", has_type_id = false)]
	public enum ParamFlags {
		READABLE,
		WRITABLE,
		CONSTRUCT,
		CONSTRUCT_ONLY,
		LAX_VALIDATION,
		STATIC_NAME,
		STATIC_NICK,
		STATIC_BLURB,
		READWRITE,
		STATIC_STRINGS
	}

	[CCode (lower_case_csuffix = "object_class")]
	public class ObjectClass : TypeClass {
		public unowned ParamSpec? find_property (string property_name);
		[CCode (array_length_type = "guint")]
		public unowned ParamSpec[] list_properties ();
		public void install_property (uint property_id, ParamSpec pspec);
	}
	
	public struct ObjectConstructParam {
	}

	[Flags]
	[CCode (cprefix = "G_BINDING_")]
	public enum BindingFlags {
		DEFAULT,
		BIDIRECTIONAL,
		SYNC_CREATE,
		INVERT_BOOLEAN
	}

	public delegate bool BindingTransformFunc (GLib.Binding binding, GLib.Value source_value, ref GLib.Value target_value);

	public class Binding : GLib.Object {
		public weak GLib.Object source { get; }
		public string source_property { get; }
		public weak GLib.Object target { get; }
		public string target_property { get; }
		public GLib.BindingFlags flags { get; }
	}

	[CCode (has_target = false)]
	public delegate void ObjectGetPropertyFunc (Object object, uint property_id, Value value, ParamSpec pspec);
	[CCode (has_target = false)]
	public delegate void ObjectSetPropertyFunc (Object object, uint property_id, Value value, ParamSpec pspec);
	[CCode (instance_pos = 0)]
	public delegate void WeakNotify (Object object);

	[CCode (ref_function = "g_object_ref", unref_function = "g_object_unref", marshaller_type_name = "OBJECT", get_value_function = "g_value_get_object", set_value_function = "g_value_set_object", take_value_function = "g_value_take_object", param_spec_function = "g_param_spec_object", cheader_filename = "glib-object.h")]
	public class Object {
		public uint ref_count;

		[CCode (has_new_function = false, construct_function = "g_object_new")]
		public Object (...);

		public static Object @new (Type type, ...);
		public static Object newv (Type type, [CCode (array_length_pos = 1.9)] Parameter[] parameters);
		public static Object new_valist (Type type, string? firstprop, va_list var_args);

		[CCode (cname = "G_TYPE_FROM_INSTANCE")]
		public Type get_type ();
		[CCode (cname = "G_OBJECT_GET_CLASS")]
		public unowned ObjectClass get_class ();
		public unowned Object @ref ();
		public void unref ();
		public Object ref_sink ();
		public void weak_ref (WeakNotify notify);
		public void weak_unref (WeakNotify notify);
		public void add_weak_pointer (void **data);
		public void remove_weak_pointer (void **data);
		public void get (string first_property_name, ...);
		public void set (string first_property_name, ...);
		public void get_property (string property_name, ref Value value);
		public void set_property (string property_name, Value value);
		[CCode (simple_generics = true)]
		public unowned T get_data<T> (string key);
		[CCode (cname = "g_object_set_data_full", simple_generics = true)]
		public void set_data<T> (string key, owned T data);
		public void set_data_full (string key, void* data, DestroyNotify? destroy);
		[CCode (simple_generics = true)]
		public T steal_data<T> (string key);
		[CCode (simple_generics = true)]
		public unowned T get_qdata<T> (Quark quark);
		[CCode (cname = "g_object_set_qdata_full", simple_generics = true)]
		public void set_qdata<T> (Quark quark, owned T data);
		public void set_qdata_full (Quark quark, void* data, DestroyNotify? destroy);
		[CCode (simple_generics = true)]
		public T steal_qdata<T> (Quark quark);
		public void freeze_notify ();
		public void thaw_notify ();
		[CCode (cname = "g_object_run_dispose")]
		public virtual void dispose ();
		public virtual void constructed ();

		public signal void notify (ParamSpec pspec);
		[CCode (cname = "g_object_notify")]
		public void notify_property (string property_name);

		public unowned Object connect (string signal_spec, ...);
		[CCode (cname = "g_signal_handler_disconnect")]
		public void disconnect (ulong handler_id);

		public void add_toggle_ref (ToggleNotify notify);
		public void remove_toggle_ref (ToggleNotify notify);

		[CCode (cname = "g_object_bind_property_with_closures")]
		public unowned GLib.Binding bind_property (string source_property, GLib.Object target, string target_property, GLib.BindingFlags flags, [CCode (type = "GClosure*")] owned GLib.BindingTransformFunc? transform_to = null, [CCode (type = "GClosure*")] owned GLib.BindingTransformFunc? transform_from = null);
	}

	[CCode (destroy_function = "g_weak_ref_clear")]
	public struct WeakRef {
		public WeakRef (GLib.Object object);
		public GLib.Object? get ();
		public void set (GLib.Object object);
	}

	[CCode (instance_pos = 0)]
	public delegate void ToggleNotify (GLib.Object object, bool is_last_ref);

	[CCode (has_copy_function = false, has_destroy_function = false)]
	public struct Parameter {
		public unowned string name;
		public Value value;
	}

	[CCode (ref_sink_function = "g_object_ref_sink")]
	public class InitiallyUnowned : Object {
		[CCode (has_construct_function = false)]
		protected InitiallyUnowned ();
	}

	[CCode (lower_case_csuffix = "enum")]
	public class EnumClass : TypeClass {
		public unowned EnumValue? get_value (int value);
		public unowned EnumValue? get_value_by_name (string name);
		public unowned EnumValue? get_value_by_nick (string name);
		public int minimum;
		public int maximum;
		public uint n_values;
		[CCode (array_length_cname = "n_values")]
		public unowned EnumValue[] values;
	}

	[CCode (has_type_id = false)]
	public struct EnumValue {
		public int value;
		public unowned string value_name;
		public unowned string value_nick;
	}

	[CCode (lower_case_csuffix = "flags")]
	public class FlagsClass : TypeClass {
		public unowned FlagsValue? get_first_value (uint value);
		public unowned FlagsValue? get_value_by_name (string name);
		public unowned FlagsValue? get_value_by_nick (string name);
		public uint mask;
		public uint n_values;
		[CCode (array_length_cname = "n_values")]
		public FlagsValue[] values;
	}

	[Compact]
	public class FlagsValue {
		public int value;
		public unowned string value_name;
		public unowned string value_nick;
	}

	[CCode (has_target = false)]
	public delegate void ValueTransform (Value src_value, ref Value dest_value);

	[CCode (copy_function = "g_value_copy", destroy_function = "g_value_unset", type_id = "G_TYPE_VALUE", marshaller_type_name = "BOXED", get_value_function = "g_value_get_boxed", set_value_function = "g_value_set_boxed", take_value_function = "g_value_take_boxed", type_signature = "v")]
	public struct Value {
		[CCode (cname = "G_VALUE_HOLDS")]
		public bool holds (Type type);
		[CCode (cname = "G_VALUE_TYPE")]
		public Type type ();
		[CCode (cname = "G_VALUE_TYPE_NAME")]
		public unowned string type_name ();

		public Value (Type g_type);
		public void copy (ref Value dest_value);
		public unowned Value? reset ();
		public void init (Type g_type);
		public void unset ();
		public void set_instance (void* instance);
		public bool fits_pointer ();
		public void* peek_pointer ();
		public static bool type_compatible (Type src_type, Type dest_type);
		public static bool type_transformable (Type src_type, Type dest_type);
		public bool transform (ref Value dest_value);
		[CCode (cname = "g_strdup_value_contents")]
		public string strdup_contents ();
		public static void register_transform_func (Type src_type, Type dest_type, ValueTransform transform);
		public void set_boolean (bool v_boolean);
		public bool get_boolean ();
		public void set_char (char v_char);
		public char get_char ();
		public void set_schar (int8 v_char);
		public int8 get_schar ();
		public void set_uchar (uchar v_uchar);
		public uchar get_uchar ();
		public void set_int (int v_int);
		public int get_int ();
		public void set_uint (uint v_uint);
		public uint get_uint ();
		public void set_long (long v_long);
		public long get_long ();
		public void set_ulong (ulong v_ulong);
		public ulong get_ulong ();
		public void set_int64 (int64 v_int64);
		public int64 get_int64 ();
		public void set_uint64 (uint64 v_uint64);
		public uint64 get_uint64 ();
		public void set_float (float v_float);
		public float get_float ();
		public void set_double (double v_double);
		public double get_double ();
		public void set_enum (int v_enum);
		public int get_enum ();
		public void set_flags (uint v_flags);
		public uint get_flags ();
		public void set_string (string v_string);
		public void set_static_string (string v_string);
		public void take_string (owned string v_string);
		public unowned string get_string ();
		public string dup_string ();
		public void set_pointer (void* v_pointer);
		public void* get_pointer ();
		public void set_boxed (void* v_boxed);
		public void* get_boxed ();
		public void* dup_boxed ();
		public void set_object (Object v_object);
		public void take_object (owned Object v_object);
		public unowned Object get_object ();
		public Object dup_object ();
		public void set_gtype (Type v_gtype);
		public Type get_gtype ();
		public void set_param(ParamSpec param);
		public ParamSpec get_param();
		public void take_param(out ParamSpec param);
		public void param_take_ownership(out ParamSpec param);
	}

	public struct SignalInvocationHint {
		public uint signal_id;
		public Quark detail;
		public SignalFlags run_type;
	}

	public delegate bool SignalEmissionHook (SignalInvocationHint ihint, [CCode (array_length_pos = 1.9)] Value[] param_values);

	[CCode (cprefix = "G_SIGNAL_", has_type_id = false)]
	public enum SignalFlags {
		RUN_FIRST,
		RUN_LAST,
		RUN_CLEANUP,
		DETAILED,
		ACTION,
		NO_HOOKS
	}

	[CCode (cprefix = "G_CONNECT_", has_type_id = false)]
	public enum ConnectFlags {
		AFTER,
		SWAPPED
	}

	[CCode (has_target = false)]
	public delegate void Callback ();

	[Compact]
	[CCode (ref_function = "g_closure_ref", unref_function = "g_closure_unref", type_id = "G_TYPE_CLOSURE")]
	public class Closure {
		public void sink ();
		public void invoke (out Value? return_value, [CCode (array_length_pos = 1.9)] Value[] param_values, void *invocation_hint);
		public void invalidate ();
		public void add_finalize_notifier (void *notify_data, ClosureNotify notify_func);
		public void add_invalidate_notifier (void *notify_data, ClosureNotify notify_func);
		public void remove_finalize_notifier (void *notify_data, ClosureNotify notify_func);
		public void remove_invalidate_notifier (void *notify_data, ClosureNotify notify_func);
		[CCode (cname = "g_closure_new_object")]
		public Closure (ulong sizeof_closure, Object object);
		public void set_marshal (ClosureMarshal marshal);
		public void add_marshal_guards (void *pre_marshal_data, ClosureNotify pre_marshal_notify, void *post_marshal_data, ClosureNotify post_marshal_notify);
		public void set_meta_marshal (void *marshal_data, ClosureMarshal meta_marshal);
	}

	[CCode (has_target = false)]
	public delegate void ClosureNotify (void* data, Closure closure);

	[CCode (instance_pos = 0, has_target = false)]
	public delegate void ClosureMarshal (Closure closure, out Value return_value, [CCode (array_length_pos = 2.9)] Value[] param_values, void *invocation_hint, void *marshal_data);

	[Compact]
	[CCode (type_id = "G_TYPE_VALUE_ARRAY", copy_function = "g_value_array_copy", free_function = "g_value_array_free")]
	public class ValueArray {
		public uint n_values;
		[CCode (array_length_cname = "n_values", array_length_type = "guint")]
		public Value[] values;
		public ValueArray (uint n_prealloced);
		public ValueArray copy ();
		public unowned Value? get_nth (uint index_);
		public void append (Value value);
		public void prepend (Value value);
		public void insert (uint index_, Value value);
		public void remove (uint index_);
		public void sort (CompareFunc compare_func);
		public void sort_with_data (CompareDataFunc compare_func);
	}

	namespace Signal {
		public static void query (uint signal_id, out SignalQuery query);
		public static uint lookup (string name, Type itype);
		public static unowned string name (uint signal_id);
		public static uint[] list_ids (Type itype);
		public static void emit (void* instance, uint signal_id, Quark detail, ...);
		public static void emit_by_name (void* instance, string detailed_signal, ...);
		public static ulong connect (void* instance, string detailed_signal, Callback handler, void* data);
		public static ulong connect_after (void* instance, string detailed_signal, Callback handler, void* data);
		public static ulong connect_swapped (void* instance, string detailed_signal, Callback handler, void* data);
		public static ulong connect_object (void* instance, string detailed_signal, Callback handler, Object gobject, ConnectFlags flags);
		public static ulong connect_data (void* instance, string detailed_signal, Callback handler, void* data, ClosureNotify destroy_data, ConnectFlags flags);
		public static ulong connect_closure (void* instance, string detailed_signal, Closure closure, bool after);
		public static ulong connect_closure_by_id (void* instance, uint signal_id, Quark detail, Closure closure, bool after);
		public static bool has_handler_pending (void* instance, uint signal_id, Quark detail, bool may_be_blocked);
		public static void stop_emission (void* instance, uint signal_id, Quark detail);
		public static void stop_emission_by_name (void* instance, string detailed_signal);
		public static void override_class_closure (uint signal_id, Type instance_type, Closure class_closure);
		public static void chain_from_overridden ([CCode (array_length = false)] Value[] instance_and_params, out Value return_value);
		public static ulong add_emission_hook (uint signal_id, Quark detail, SignalEmissionHook hook_func, DestroyNotify? data_destroy);
		public static void remove_emission_hook (uint signal_id, ulong hook_id);
		public static bool parse_name (string detailed_signal, Type itype, out uint signal_id, out Quark detail, bool force_detail_quark);
		public static unowned SignalInvocationHint? get_invocation_hint (void* instance);
	}

	namespace SignalHandler {
		public static void block (void* instance, ulong handler_id);
		public static void unblock (void* instance, ulong handler_id);
		public static void disconnect (void* instance, ulong handler_id);
		public static ulong find (void* instance, SignalMatchType mask, uint signal_id, Quark detail, Closure? closure, void* func, void* data);
		public static bool is_connected (void* instance, ulong handler_id);

		[CCode (cname = "g_signal_handlers_block_matched")]
		public static uint block_matched (void* instance, SignalMatchType mask, uint signal_id, Quark detail, Closure? closure, void* func, void* data);
		[CCode (cname = "g_signal_handlers_unblock_matched")]
		public static uint unblock_matched (void* instance, SignalMatchType mask, uint signal_id, Quark detail, Closure? closure, void* func, void* data);
		[CCode (cname = "g_signal_handlers_disconnect_matched")]
		public static uint disconnect_matched (void* instance, SignalMatchType mask, uint signal_id, Quark detail, Closure? closure, void* func, void* data);
		[CCode (cname = "g_signal_handlers_block_by_func")]
		public static uint block_by_func (void* instance, void* func, void* data);
		[CCode (cname = "g_signal_handlers_unblock_by_func")]
		public static uint unblock_by_func (void* instance, void* func, void* data);
		[CCode (cname = "g_signal_handlers_disconnect_by_func")]
		public static uint disconnect_by_func (void* instance, void* func, void* data);
	}

	public struct SignalQuery {
		public uint signal_id;
		public unowned string signal_name;
		public Type itype;
		public SignalFlags signal_flags;
		public Type return_type;
		public uint n_params;
		[CCode (array_length = false)]
		public unowned Type[] param_types;
	}

	[CCode (cprefix = "G_SIGNAL_MATCH_", has_type_id = false)]
	public enum SignalMatchType {
		ID,
		DETAIL,
		CLOSURE,
		FUNC,
		DATA,
		UNBLOCKED
	}
}
