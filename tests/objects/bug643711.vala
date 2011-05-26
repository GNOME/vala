public abstract class Foo {
	public Baz get_struct () { return Baz (); }
	public abstract void bar ();
}

public struct Baz {
    Foo foo;

    public void bar () {
        foo.bar ();
    }
}

void main () { }
