struct Foo {
    public int i;
}

abstract class AbstractBar {
	public Foo foo;

	protected AbstractBar (Foo foo) {
		this.foo = foo;
	}
}

class Bar : AbstractBar {
	public Bar (Foo foo) {
		base (foo);
	}
}

void main () {
	var bar = new Bar ({ 42 });
	assert (bar.foo.i == 42);
}

