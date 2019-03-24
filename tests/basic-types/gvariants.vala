void string_conversion () {
	Variant v = "foo";
	string s = (string) v;
	assert (s == "foo");
}

void string_array_conversion () {
	Variant v = new string[] { "foo", "bar" };
	string[] sa = (string[]) v;
	assert (sa.length == 2);
	assert (sa[1] == "bar");
}

void string_array_2d_conversion () {
	Variant v = new string[,] { { "foo" , "faz" } , { "bar", "baz" } };
	string[,] sa = (string[,]) v;
	assert (sa.length[0] == 2);
	assert (sa.length[1] == 2);
	assert (sa[1,1] == "baz");
}

void string_array_3d_conversion () {
	Variant v = new string[,,] { { { "foo", "bar" }, { "baz", "man" } }, { { "foo2", "bar2" }, { "baz2", "man2" } } };
	string[,,] sa = (string[,,]) v;
	assert (sa.length[0] == 2);
	assert (sa.length[1] == 2);
	assert (sa.length[2] == 2);
	assert (sa[0,1,0] == "baz");
	assert (sa[0,1,1] == "man");
	assert (sa[1,1,0] == "baz2");
	assert (sa[1,1,1] == "man2");
}

void double_conversion () {
	Variant v = 42.23;
	double d = (double) v;
	assert (d == 42.23);
}

void double_array_conversion () {
	Variant v = new double[] { 42.23, 47.11 };
	double[] da = (double[]) v;
	assert (da.length == 2);
	assert (da[1] == 47.11);
}

void double_array_2d_conversion () {
	Variant v = new double[,] { { 42.23, 11.47 } , { 47.11, 23.42 } };
	double[,] da = (double[,]) v;
	assert (da.length[0] == 2);
	assert (da.length[1] == 2);
	assert (da[1,1] == 23.42);
}

struct Foo {
	public string s;
	public uint64 u64;
	public bool b;
}

void struct_conversion () {
	Foo s = { "foo", uint64.MAX, true };
	Variant v = s;
	Foo st = (Foo) v;
	assert (st.s == "foo");
	assert (st.u64 == uint64.MAX);
	assert (st.b == true);
}

void main () {
	string_conversion ();
	string_array_conversion ();
	double_conversion ();
	double_array_conversion ();
	struct_conversion ();

	string_array_2d_conversion ();
	double_array_2d_conversion ();

	string_array_3d_conversion ();
}
