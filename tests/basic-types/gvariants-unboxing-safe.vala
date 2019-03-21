void main () {
	Variant v;

	v = new Variant.int32 (4711);
	{
		bool? b = v as bool;
		assert (b == null);
	}
	{
		int16? i16 = v as int16;
		assert (i16 == null);
	}
	{
		int32? i32 = v as int32;
		assert (i32 == 4711);
	}
	{
		string? s = v as string;
		assert (s == null);
	}

	v = new Variant.boolean (true);
	{
		bool? b = v as bool;
		assert (b == true);
	}
	{
		int32? i32 = v as int32;
		assert (i32 == null);
	}

	v = new Variant.strv ({ "foo", "bar", "manam" });
	{
		string[]? sa = v as string[];
		assert (sa != null);
		assert (sa[2] == "manam");
	}
}
