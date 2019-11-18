class Foo<G> : Object {
	public G prop { get; set; }
}

delegate G FooFunc<G> (G g);

void foo () {
}

void main () {
	{
		var f = new Thread<void> (null, foo);
	}
	{
		Thread f = new Thread<void> (null, foo);
	}
	{
		Thread<void> f = new Thread<void> (null, foo);
	}
	{
		FooFunc f = (FooFunc) foo;
		f (null);
	}
	{
		FooFunc<void> f = (FooFunc<void>) foo;
		f (null);
	}
	{
		FooFunc<void> f = foo;
		f (null);
	}
	{
		var f = new Foo<void> ();
	}
}
