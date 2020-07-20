[CCode (has_target = false)]
delegate int FooFunc (Foo foo);

delegate int BarFunc ();

class Foo {
	[HasEmitter]
	public virtual signal int bar () {
		return 23;
	}

	public void manam (FooFunc func) {
		assert (func (this) == 23);
	}

	public void minim (BarFunc func) {
		assert (func () == 23);
	}
}

void main () {
	var foo = new Foo ();
	{
		foo.manam (Foo.bar);
		foo.manam ((FooFunc) Foo.bar);
	}
	{
		FooFunc func = Foo.bar;
		assert (func (foo) == 23);
	}
	{
		FooFunc func = (FooFunc) Foo.bar;
		assert (func (foo) == 23);
	}
	{
		foo.minim (foo.bar);
		foo.minim ((BarFunc) foo.bar);
	}
	{
		BarFunc func = foo.bar;
		assert (func () == 23);
	}
	{
		BarFunc func = (BarFunc) foo.bar;
		assert (func () == 23);
	}
}
