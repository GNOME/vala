struct Foo {
	[CCode (cname = "foo")]
	public string f1;
	[CCode (cname = "bar")]
	public int f2;
	[CCode (cname = "baz")]
	public unowned string[] f3;
}

const string[] FOO_ARRAY = { "manam", "minimi" };

void main () {
	Foo a = { "42", 42, FOO_ARRAY};
	Foo b = { "42", 42, FOO_ARRAY};
	assert (a == b);
	assert (a.f3.length == 2);
}
