struct foo_int : int {}
struct foo_uint : uint {}
struct foo_int64 : int64 {}
struct foo_uint64 : uint64 {}
struct foo_long : long {}
struct foo_ulong : ulong {}
struct foo_bool : bool {}
struct foo_char : char {}
struct foo_uchar : uchar {}
struct foo_float : float {}
struct foo_double : double {}
struct foo_gtype : GLib.Type {}

class Foo : Object {
	public foo_int prop_int { get; set; }
	public foo_uint prop_uint { get; set; }
	public foo_int64 prop_int64 { get; set; }
	public foo_uint64 prop_uint64 { get; set; }
	public foo_long prop_long { get; set; }
	public foo_ulong prop_ulong { get; set; }
	public foo_bool prop_bool { get; set; }
	public foo_char prop_char { get; set; }
	public foo_uchar prop_uchar { get; set; }
	public foo_float prop_float { get; set; }
	public foo_double prop_double { get; set; }
	public foo_gtype prop_gtype { get; set; }
}

void main () {
	{
		assert (typeof (foo_int) == GLib.Type.INT);
		assert (typeof (foo_uint) == GLib.Type.UINT);
		assert (typeof (foo_int64) == GLib.Type.INT64);
		assert (typeof (foo_uint64) == GLib.Type.UINT64);
		assert (typeof (foo_long) == GLib.Type.LONG);
		assert (typeof (foo_ulong) == GLib.Type.ULONG);
		assert (typeof (foo_bool) == GLib.Type.BOOLEAN);
		assert (typeof (foo_char) == GLib.Type.CHAR);
		assert (typeof (foo_uchar) == GLib.Type.UCHAR);
		assert (typeof (foo_float) == GLib.Type.FLOAT);
		assert (typeof (foo_double) == GLib.Type.DOUBLE);
		assert (typeof (foo_gtype) == typeof (GLib.Type));
	}
	{
		var foo = new Foo ();
	}
}
