[CCode (cheader_filename = "glib-object.h", cname = "G_TYPE_STRV")]
extern GLib.Type G_TYPE_STRV;
[CCode (cheader_filename = "glib-object.h", cname = "G_TYPE_ERROR")]
extern GLib.Type G_TYPE_ERROR;

interface IFoo {
}

enum FooEnum {
	FOO
}

[Flags]
enum FooFlag {
	FOO
}

errordomain FooError {
	FAIL
}

struct FooStruct {
	public int i;
}

[CCode (has_type_id = false)]
enum BarEnum {
	BAR
}

[CCode (has_type_id = false)]
[Flags]
enum BarFlag {
	BAR
}

[CCode (has_type_id = false)]
struct BarStruct {
	public int i;
}

[CCode (has_type_id = false)]
[SimpleType]
struct ManamStruct {
	public int i;
}

void main () {
	assert (typeof (bool) == GLib.Type.BOOLEAN);
	assert (typeof (FooStruct).is_a (GLib.Type.BOXED));
	assert (typeof (char) == GLib.Type.CHAR);
	assert (typeof (double) == GLib.Type.DOUBLE);
	assert (typeof (FooEnum).is_a (GLib.Type.ENUM));
	assert (typeof (FooError) == G_TYPE_ERROR);
	assert (typeof (FooFlag).is_a (GLib.Type.FLAGS));
	assert (typeof (float) == GLib.Type.FLOAT);
	assert (typeof (int) == GLib.Type.INT);
	assert (typeof (int64) == GLib.Type.INT64);
	assert (typeof (IFoo).is_a (GLib.Type.INTERFACE));
	assert (typeof (IFoo[]) == GLib.Type.INVALID);
	assert (typeof (long) == GLib.Type.LONG);
	assert (typeof (void) == GLib.Type.NONE);
	assert (typeof (Object) == GLib.Type.OBJECT);
	assert (typeof (ParamSpec) == GLib.Type.PARAM);
	assert (typeof (void*) == GLib.Type.POINTER);
	assert (typeof (string) == GLib.Type.STRING);
	assert (typeof (string[]) == G_TYPE_STRV);
	assert (typeof (uchar) == GLib.Type.UCHAR);
	assert (typeof (uint) == GLib.Type.UINT);
	assert (typeof (uint64) == GLib.Type.UINT64);
	assert (typeof (ulong) == GLib.Type.ULONG);
	assert (typeof (Variant) == GLib.Type.VARIANT);

	assert (typeof (BarEnum) == GLib.Type.INT);
	assert (typeof (BarFlag) == GLib.Type.UINT);
	assert (typeof (BarStruct) == GLib.Type.POINTER);
	assert (typeof (ManamStruct) == GLib.Type.INVALID);
}
