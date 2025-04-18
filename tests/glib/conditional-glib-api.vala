// glib 2.54 g_enum_to_string / g_flags_to_string
// glib 2.58 G_GNUC_NO_INLINE
enum FooEnum {
	BAR;
}
void use_g_enum_to_string () {
	FooEnum.BAR.to_string ();
}
[Flags]
enum FooFlag {
	BAR;
}
void use_g_flags_to_string () {
	FooFlag.BAR.to_string ();
}

// glib 2.68 g_memdup2
struct FooMemDup2 {
	public int i;
}
void use_g_memdup2 () {
	(unowned string)[] foo = { "foo", "bar", "manam"};
	var bar = foo;

	uint8[] minim = "minim".data;
	Variant minim_v = minim;
	minim = (uint8[]) minim_v;

	FooMemDup2? manam = { 42 };
	Variant manam_v = manam;
	manam = (FooMemDup2?) manam_v;
}

// glib 2.68 drop volatile
// glib 2.74 G_TYPE_FLAG_NONE
// glib 2.80 g_once_init_{enter,leave}_pointer
[SingleInstance]
class FooVolatile : Object {
}
class BarVolatile {
}
void no_use_volatile () {
	var re = /mon(str.*o)n/i;
}

void main () {
	use_g_enum_to_string ();
	use_g_flags_to_string ();
	use_g_memdup2 ();
	no_use_volatile ();
}
