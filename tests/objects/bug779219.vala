interface IFoo : GLib.Object {
	public abstract int foo { get; }
}

abstract class Foo : GLib.Object, IFoo {
	public abstract int foo { get; }
}

class Bar : Foo {
	public override int foo { get { return 42; } }
	public Bar () {
	}
}

void main () {
	var bar = new Bar ();
	assert (bar.foo == 42);
}
