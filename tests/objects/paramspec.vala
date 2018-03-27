enum FooEnum {
	FOO = 0,
	BAR = 42
}

[Flags]
enum FooFlag {
	FOO = 0,
	BAR = 23
}

struct FooStruct {
	public int i;
}

class Foo : Object {
	// default ParamSpec implementations
	public bool bool_prop { get; set; }
	public bool bool_prop2 { get; set; default = true; }
	public char char_prop { get; set; }
	public char char_prop2 { get; set; default = 'c'; }
	public double double_prop { get; set; }
	public double double_prop2 { get; set; default = 3.1415; }
	public FooEnum enum_prop { get; set; }
	public FooEnum enum_prop2 { get; set; default = FooEnum.BAR; }
	public FooFlag flag_prop { get; set; }
	public FooFlag flag_prop2 { get; set; default = FooFlag.BAR; }
	public float float_prop { get; set; }
	public float float_prop2 { get; set; default = 47.11f; }
	public int int_prop { get; set; }
	public int int_prop2 { get; set; default = int.MIN; }
	public int64 int64_prop { get; set; }
	public int64 int64_prop2 { get; set; default = int64.MIN; }
	public long long_prop { get; set; }
	public long long_prop2 { get; set; default = long.MAX; }
	public Object object_prop { get; set; }
	public ParamSpec param_prop { get; set; }
	public void* pointer_prop { get; set; }
	public string string_prop { get; set; }
	public string string_prop2 { get; set; default = "foo"; }
	public uchar uchar_prop { get; set; }
	public uchar uchar_prop2 { get; set; default = 'u'; }
	public uint uint_prop { get; set; }
	public uint uint_prop2 { get; set; default = uint.MAX; }
	public uint64 uint64_prop { get; set; }
	public uint64 uint64_prop2 { get; set; default = uint64.MAX; }
	public ulong ulong_prop { get; set; }
	public ulong ulong_prop2 { get; set; default = ulong.MAX; }
	public unichar unichar_prop { get; set; }
	public Type gtype_prop { get; set; }
	public Type gtype_prop2 { get; set; default = typeof (string); }
	//Deprecated public ValueArray value_array_prop { get; set; }
	public Variant variant_prop { get; set; }
	public Variant variant_prop2 { get; set; default = new Variant ("as"); }

	public FooStruct struct_prop { get; set; }
	public FooStruct struct_prop2 { get; set; default = FooStruct () { i = 4711 }; }
	public string[] strv_prop { get; set; }
	public string[] strv_prop2 { get; set; default = { "foo", "bar" }; }
}

void main () {
	var foo = new Foo ();
	unowned ObjectClass foo_class = foo.get_class ();

	assert (foo_class.find_property ("bool-prop") is ParamSpecBoolean);
	assert (foo.bool_prop2 == true);
	assert (foo_class.find_property ("char-prop") is ParamSpecChar);
	assert (foo.char_prop2 == 'c');
	assert (foo_class.find_property ("double-prop") is ParamSpecDouble);
	assert (foo.double_prop2 == 3.1415);
	assert (foo_class.find_property ("enum-prop") is ParamSpecEnum);
	assert (foo.enum_prop2 == FooEnum.BAR);
	assert (foo_class.find_property ("flag-prop") is ParamSpecFlags);
	assert (foo.flag_prop2 == FooFlag.BAR);
	assert (foo_class.find_property ("float-prop") is ParamSpecFloat);
	assert (foo.float_prop2 == 47.11f);
	assert (foo_class.find_property ("int-prop") is ParamSpecInt);
	assert (foo.int_prop2 == int.MIN);
	assert (foo_class.find_property ("int64-prop") is ParamSpecInt64);
	assert (foo.int64_prop2 == int64.MIN);
	assert (foo_class.find_property ("long-prop") is ParamSpecLong);
	assert (foo.long_prop2 == long.MAX);
	assert (foo_class.find_property ("object-prop") is ParamSpecObject);
	assert (foo_class.find_property ("param-prop") is ParamSpecParam);
	assert (foo_class.find_property ("pointer-prop") is ParamSpecPointer);
	assert (foo_class.find_property ("string-prop") is ParamSpecString);
	assert (foo.string_prop2 == "foo");
	assert (foo_class.find_property ("uchar-prop") is ParamSpecUChar);
	assert (foo.uchar_prop2 == 'u');
	assert (foo_class.find_property ("uint-prop") is ParamSpecUInt);
	assert (foo.uint_prop2 == uint.MAX);
	assert (foo_class.find_property ("uint64-prop") is ParamSpecUInt64);
	assert (foo.uint64_prop2 == uint64.MAX);
	assert (foo_class.find_property ("ulong-prop") is ParamSpecULong);
	assert (foo.ulong_prop2 == ulong.MAX);
	//FIXME? assert (foo_class.find_property ("unichar-prop") is ParamSpecUnichar);
	assert (foo_class.find_property ("unichar-prop") is ParamSpecUInt);
	assert (foo_class.find_property ("gtype-prop") is ParamSpecGType);
	assert (foo.gtype_prop2 == typeof (string));
	//Deprecated assert (foo_class.find_property ("value-array-prop") is ParamSpecValueArray);
	assert (foo_class.find_property ("variant-prop") is ParamSpecVariant);
	assert (foo.variant_prop2.is_of_type (VariantType.STRING_ARRAY));

	assert (foo_class.find_property ("struct-prop") is ParamSpecBoxed);
	assert (foo.struct_prop2.i == 4711);
	assert (foo_class.find_property ("strv-prop") is ParamSpecBoxed);
	assert (foo.strv_prop2[1] == "bar");
}
