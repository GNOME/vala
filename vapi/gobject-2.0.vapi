/* gobject-2.0.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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

[CCode (cprefix = "G", lower_case_cprefix = "g_", cheader_filename = "glib.h")]
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
		
		public Type[] children ();
		public uint depth ();
		public static Type from_name (string name);
		public Type[] interfaces ();
		public bool is_a (Type is_a_type);
		public weak string name ();
		public Quark qname ();
		public Type parent ();

		public void query (out TypeQuery query);

		public TypeClass class_ref ();
		public weak TypeClass class_peek ();

		[CCode (cname = "G_TYPE_INVALID")]
		public static Type INVALID;
	}

	public struct TypeQuery {
		public Type type;
		public weak string type_name;
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
		public bool use ();
		public void unuse ();
		public void set_name (string name);
		[NoWrapper]
		public virtual bool load ();
		[NoWrapper]
		public virtual void unload ();
	}

	[CCode (ref_function = "g_param_spec_ref", unref_function = "g_param_spec_unref")]
	public class ParamSpec {
		public string name;
		public ParamFlags flags;
		public Type value_type;
		public Type owner_type;
		public weak string get_blurb ();
		public weak string get_name ();
		public weak string get_nick ();
	}

	public class ParamSpecEnum : ParamSpec {
		[CCode (cname = "g_param_spec_enum")]
		public ParamSpecEnum (string name, string nick, string blurb, Type enum_type, int default_value, ParamFlags flags);
	}

	public class ParamSpecFloat : ParamSpec {
		[CCode (cname = "g_param_spec_float")]
		public ParamSpecFloat (string name, string nick, string blurb, float minimum, float maximum, float default_value, ParamFlags flags);
	}

	public class ParamSpecInt : ParamSpec {
		[CCode (cname = "g_param_spec_int")]
		public ParamSpecInt (string name, string nick, string blurb, int minimum, int maximum, int default_value, ParamFlags flags);
	}

	public class ParamSpecUInt : ParamSpec {
		[CCode (cname = "g_param_spec_uint")]
		public ParamSpecUInt (string name, string nick, string blurb, uint minimum, uint maximum, uint default_value, ParamFlags flags);
	}

	public class ParamSpecBoolean : ParamSpec {
		[CCode (cname = "g_param_spec_boolean")]
		public ParamSpecBoolean (string name, string nick, string blurb, bool defaultvalue, ParamFlags flags);
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
		public weak ParamSpec find_property (string property_name);
		public weak ParamSpec[] list_properties ();
		public void install_property (uint property_id, ParamSpec pspec);
	}
	
	public struct ObjectConstructParam {
	}

	public static delegate void ObjectGetPropertyFunc (Object object, uint property_id, Value value, ParamSpec pspec);
	public static delegate void ObjectSetPropertyFunc (Object object, uint property_id, Value value, ParamSpec pspec);
	public static delegate void WeakNotify (void *data, Object object);

	[CCode (ref_function = "g_object_ref", unref_function = "g_object_unref", marshaller_type_name = "OBJECT", get_value_function = "g_value_get_object", set_value_function = "g_value_set_object", param_spec_function = "g_param_spec_object", cheader_filename = "glib-object.h")]
	public class Object {
		public uint ref_count;

		public static Object @new (Type type, ...);

		[CCode (cname = "G_TYPE_FROM_INSTANCE")]
		public Type get_type ();
		public weak Object @ref ();
		public void unref ();
		public Object ref_sink ();
		public void weak_ref (WeakNotify notify, void *data);
		public void weak_unref (WeakNotify notify, void *data);
		public void add_weak_pointer (void **data);
		public void remove_weak_pointer (void **data);
		public void get (string first_property_name, ...);
		public void set (string first_property_name, ...);
		public void get_property (string property_name, Value value);
		public void set_property (string property_name, Value value);
		public void* get_data (string key);
		public void set_data (string key, void* data);
		public void set_data_full (string key, void* data, DestroyNotify? destroy);
		public void* steal_data (string key);
		public void* get_qdata (Quark quark);
		public void set_qdata (Quark quark, void* data);
		public void set_qdata_full (Quark quark, void* data, DestroyNotify? destroy);
		public void* steal_qdata (Quark quark);
		public void freeze_notify ();
		public void thaw_notify ();
		public virtual void dispose ();
		public virtual void finalize ();
		public virtual void constructed ();

		public signal void notify (ParamSpec pspec);

		public weak Object connect (string signal_spec, ...);

		public void add_toggle_ref (ToggleNotify notify);
		public void remove_toggle_ref (ToggleNotify notify);
	}

	[CCode (instance_pos = 0)]
	public delegate void ToggleNotify (GLib.Object object, bool is_last_ref);

	public struct Parameter {
		public string name;
		public Value value;
	}

	public class InitiallyUnowned : Object {
	}

	[CCode (lower_case_csuffix = "enum")]
	public class EnumClass : TypeClass {
		public weak EnumValue? get_value (int value);
		public weak EnumValue? get_value_by_name (string name);
		public weak EnumValue? get_value_by_nick (string name);
	}

	[Compact]
	public class EnumValue {
		public int value;
		public weak string value_name;
		public weak string value_nick;
	}

	[CCode (lower_case_csuffix = "flags")]
	public class FlagsClass : TypeClass {
		public weak FlagsValue? get_first_value ();
		public weak FlagsValue? get_value_by_name (string name);
		public weak FlagsValue? get_value_by_nick (string name);
	}

	[Compact]
	public class FlagsValue {
		public int value;
		public weak string value_name;
		public weak string value_nick;
	}

	[Compact]
	[CCode (cname = "gpointer", has_type_id = true, type_id = "G_TYPE_BOXED", marshaller_type_name = "BOXED", get_value_function = "g_value_get_boxed", set_value_function = "g_value_set_boxed")]
	public abstract class Boxed {
	}

	public static delegate void ValueTransform (Value src_value, out Value dest_value);

	[CCode (copy_function = "g_value_copy", destroy_function = "g_value_unset", type_id = "G_TYPE_VALUE", marshaller_type_name = "BOXED", get_value_function = "g_value_get_boxed", set_value_function = "g_value_set_boxed", type_signature = "v")]
	public struct Value {
		[CCode (cname = "G_VALUE_HOLDS")]
		public bool holds (Type type);
		[CCode (cname = "G_VALUE_TYPE")]
		public Type type ();
		[CCode (cname = "G_VALUE_TYPE_NAME")]
		public weak string type_name ();

		public Value (Type g_type);
		public void copy (ref Value dest_value);
		public weak Value? reset ();
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
		public void take_string (string# v_string);
		public weak string get_string ();
		public string dup_string ();
		public void set_pointer (void* v_pointer);
		public void* get_pointer ();
		public void set_boxed (Boxed v_boxed);
		public void take_boxed (Boxed# v_boxed);
		public weak Boxed get_boxed ();
		public Boxed dup_boxed ();
		public void set_object (Object v_object);
		public void take_object (Object# v_object);
		public weak Object get_object ();
		public Object dup_object ();
		public void set_gtype (Type v_gtype);
		public Type get_gtype ();
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

	public static delegate void Callback ();

	[Compact]
	public class Closure : Boxed {
	}

	public static delegate void ClosureNotify (void* data, Closure closure);

	[Compact]
	[CCode (type_id = "G_TYPE_VALUE_ARRAY")]
	public class ValueArray : Boxed {
		public uint n_values;
		public Value[] values;
		public ValueArray (uint n_prealloced);
		public weak Value? get_nth (uint index_);
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
		public static weak string name (uint signal_id);
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
		[NoArrayLength]
		public static void chain_from_overridden (Value[] instance_and_params, out Value return_value);
		public static ulong add_emission_hook (uint signal_id, Quark detail, SignalEmissionHook hook_func, DestroyNotify? data_destroy);
		public static void remove_emission_hook (uint signal_id, ulong hook_id);
		public static bool parse_name (string detailed_signal, Type itype, out uint signal_id, out Quark detail, bool force_detail_quark);
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
		public weak string signal_name;
		public Type itype;
		public SignalFlags signal_flags;
		public Type return_type;
		public uint n_params;
		[NoArrayLength]
		public weak Type[] param_types;
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
