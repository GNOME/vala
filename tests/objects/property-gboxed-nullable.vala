public struct Bar {
	public string s;
}

public class Foo : Object {
	public Bar? bar { get; construct set; }

	public Foo (Bar? bar) {
		Object (bar: bar);
	}
}

public class Faz : Object {
	[NoAccessorMethod]
	public Bar? baz { owned get; set; }
}

void main () {
	{
		var foo = new Foo (null);
		assert (foo.bar == null);
	}
	{
		Bar bar = { "foo" };
		var foo = (Foo) Object.@new (typeof (Foo), "bar", bar);
		assert (foo.bar == bar);
		assert (foo.bar.s == "foo");
		foo.bar = null;
		assert (foo.bar == null);
	}
	{
		Bar bar = { "foo" };
		var foo = (Foo) Object.@new (typeof (Foo), "bar", null);
		assert (foo.bar == null);
		foo.bar = bar;
		assert (foo.bar == bar);
	}
	{
		Bar bar = { "foo" };
		var faz = new Faz ();
		assert (faz.baz == null);
		faz.baz = bar;
		assert (faz.baz == bar);
		assert (faz.baz.s == "foo");
		faz.baz = null;
		assert (faz.baz == null);
	}
}
