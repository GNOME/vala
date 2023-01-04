class Foo {
	public string f[2] = { "foo", "bar" };
	public int i[3] = { 23, 42, 4711 };

	public class string cf[2] = { "foo", "bar" };
	public class int ci[3] = { 23, 42, 4711 };

	public static string sf[2] = { "foo", "bar" };
	public static int si[3] = { 23, 42, 4711 };
}

void main () {
	var foo = new Foo ();
	{
		assert (foo.f.length == 2);
		assert (foo.f[0] == "foo");
		assert (foo.i.length == 3);
		assert (foo.i[2] == 4711);
	}
	{
		assert (foo.cf.length == 2);
		assert (foo.cf[0] == "foo");
		assert (foo.ci.length == 3);
		assert (foo.ci[2] == 4711);
	}
	{
		assert (Foo.sf.length == 2);
		assert (Foo.sf[0] == "foo");
		assert (Foo.si.length == 3);
		assert (Foo.si[2] == 4711);
	}
}
