struct FooStruct {
	public int bar;
}

class FooClass {
	public int bar = 42;
}


class Bar {
	public int f_simple;
	public string f_string;
	public string[] f_array;
	public FooStruct f_struct;
	public FooClass f_class;

	public unowned string fu_string;
	public unowned string[] fu_array;
	public unowned FooStruct? fu_struct;
	public unowned FooClass fu_class;

	public int p_simple { get; set; }
	public string p_string { get; set; }
	public string[] p_array { get; set; }
	public FooStruct p_struct { get; set; }
	public FooClass p_class { get; set; }
}


void main () {
	FooStruct fs = { 42 };
	var fc = new FooClass ();
	string s = "foo";
	string[] a = { "foo", "bar" };

	var bar = new Bar () {
		f_simple = 42,
		f_string = s,
		f_array = a,
		f_struct = fs,
		f_class = fc,

		fu_string = s,
		fu_array = a,
		fu_struct = fs,
		fu_class = fc,

		p_simple = 42,
		p_string = s,
		p_array = a,
		p_struct = fs,
		p_class = fc
	};

	assert (bar.f_simple == 42);
	assert (bar.f_string == "foo");
	assert (bar.f_array[1] == "bar");
	assert (bar.f_struct.bar == 42);
	assert (bar.f_class == fc);

	assert (bar.fu_string == "foo");
	assert (bar.fu_array[1] == "bar");
	assert (bar.fu_struct == fs);
	assert (bar.fu_class == fc);

	assert (bar.p_simple == 42);
	assert (bar.p_string == "foo");
	assert (bar.p_array[1] == "bar");
	assert (bar.p_struct.bar == 42);
	assert (bar.p_class == fc);

	bar = null;

	assert (fs.bar == 42);
	assert (fc.bar == 42);
	assert (s == "foo");
	assert (a[1] == "bar");
}

