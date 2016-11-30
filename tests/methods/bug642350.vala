const string[] FOO = { N_ ("foo"), NC_ ("valac", "bar") };
const string BAZ = N_ ("bar");

struct Foo {
	public string foo;
	public unowned string bar;
}

class Bar : Object {
	public static string foo = N_ ("foo");
	public string bar { get { return N_ ("bar"); } }
	public string get_baz () { return N_ ("baz"); }
}

const Foo STRUCT = { "foo", N_ ("bar") };

void main () {
	assert (FOO[1] == "bar");
	assert (BAZ == "bar");
	assert (STRUCT.bar == "bar");

	const string[] LOCAL_FOO = { N_ ("foo"), N_ ("bar") };
	assert (LOCAL_FOO[1] == "bar");
	const string LOCAL_BAZ = N_ ("bar");
	assert (LOCAL_BAZ == "bar");
	const Foo LOCAL_STRUCT = { "foo", N_ ("bar") };
	assert (LOCAL_STRUCT.bar == "bar");

	Foo f = { N_ ("foo"), NC_ ("valac", "bar") };
	assert (f.foo == "foo");
	assert (f.bar == "bar");

	Bar b = new Bar ();
	assert (b.foo == "foo");
	assert (b.bar == "bar");
	assert (b.get_baz () == "baz");

	string s1 = N_ ("bar");
	assert (s1 == "bar");
	s1 = N_ (s1);
	assert (s1 == "bar");

	unowned string s2 = N_ ("bar");
	assert (s2 == "bar");
	s2 = N_ (s2);
	assert (s2 == "bar");

	string[] a1 = FOO;
	assert (a1[1] == "bar");
	unowned string[] a2 = FOO;
	assert (a2[0] == "foo");
}
