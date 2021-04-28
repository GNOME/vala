[CCode (array_length = false, array_null_terminated = true)]
string[] manam;

class Foo {
	public string[] f = manam;
	public string[] i = { "baz", "foo", "bar" };
	public string[] ia = { "baz", manam[0], "bar" };
	public static string[] sf = manam;
	public static string[] si = { "baz", "foo", "bar" };
	public static string[] sa = { "baz", manam[0], "bar" };
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
		assert (foo.f[0] == "manam");
		assert (Foo.sf.length == 3);
		assert (Foo.sf[0] == "manam");
		assert (foo.i.length == 3);
		assert (foo.ia.length == 3);
		assert (foo.ia[1] == "manam");
		assert (Foo.si.length == 3);
		assert (Foo.sa.length == 3);
		assert (Foo.sa[1] == "manam");
	}
	{
		minim = { "minim", "foo", "bar" };
		assert (minim.length == -1);
		var bar = new Bar ();
		assert (bar.f.length == -1);
		assert (Bar.sf.length == -1);
	}
}
