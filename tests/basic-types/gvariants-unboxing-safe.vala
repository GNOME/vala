struct Foo {
	public string s;
	public uint64 u64;
	public bool b;
}

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

	Foo vsrc = { "foo", uint64.MAX, true };
	v = vsrc;
	assert ("(stb)" == v.get_type_string ());
	{
		Foo real_st = (Foo) v;
		assert (real_st.s == "foo");
		assert (real_st.u64 == uint64.MAX);
		assert (real_st.b == true);

		Foo? st = v as Foo;
		assert (st != null);
		assert (st.s == "foo");
		assert (st.u64 == uint64.MAX);
		assert (st.b == true);
	}

	HashTable<string,string> vsrc2 = new HashTable<string,string> (str_hash, str_equal);
	vsrc2.insert ("foo", "bar");
	vsrc2.insert ("bar", "manam");
	v = vsrc2;
	{
		HashTable<string,string> dict = v as HashTable<string,string>;
		assert (dict.lookup ("foo") == "bar");
		assert (dict.lookup ("bar") == "manam");
	}
	{
		HashTable<int,string>? dict = v as HashTable<int,string>;
		assert (dict == null);
	}
}
