[IntegerType (rank = 6, signed = true, width = 32)]
[SimpleType]
[CCode (has_type_id = false)]
struct foo_t {
}

[IntegerType (rank = 11, signed = false, width = 64)]
[SimpleType]
[CCode (has_type_id = false)]
struct faz_t {
}

[FloatingType (rank = 1, width = 32)]
[SimpleType]
[CCode (has_type_id = false)]
struct bar_t {
}

[FloatingType (rank = 2, width = 64)]
[SimpleType]
[CCode (has_type_id = false)]
struct baz_t {
}

[BooleanType]
[SimpleType]
[CCode (has_type_id = false)]
struct manam_t {
}

void main () {
	{
		foo_t foo = int32.MAX;
		assert (foo == int32.MAX);
	}
	{
		faz_t faz = uint64.MAX;
		assert (faz == uint64.MAX);
	}
	{
		bar_t bar = float.MAX;
		assert (bar == float.MAX);
	}
	{
		baz_t baz = double.MAX;
		assert (baz == double.MAX);
	}
	{
		manam_t manam = true;
		assert (manam);
	}
}
