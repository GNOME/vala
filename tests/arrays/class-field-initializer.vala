[CCode (array_length = false, array_null_terminated = true)]
string[] manam;

class Foo {
	public string[] f = manam;
	public string[] i = { "baz", "foo", "bar" };
	public static string[] sf = manam;
	public static string[] si = { "baz", "foo", "bar" };
}

[CCode (array_length = false)]
string[] minim;

class Bar {
	public string[] f = minim;
	public static string[] sf = minim;
}

void main () {
	{
		manam = { "manam", "foo", "bar" };
		assert (manam.length == 3);
		var foo = new Foo ();
		assert (foo.f.length == 3);
		assert (Foo.sf.length == 3);
		assert (foo.i.length == 3);
		assert (Foo.si.length == 3);
	}
	{
		minim = { "minim", "foo", "bar" };
		assert (minim.length == -1);
		var bar = new Bar ();
		assert (bar.f.length == -1);
		assert (Bar.sf.length == -1);
	}
}
