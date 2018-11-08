interface IFoo {
	[CCode (instance_pos = -1)]
	public abstract void foo (int i);
}

class Foo : IFoo {
	public virtual void foo (int i) {
		assert (i == 23);
	}
}

class Bar : Foo {
	public override void foo (int i) {
		assert (i == 42);
	}
}

abstract class Baz {
	[CCode (instance_pos = -1)]
	public abstract void foo (int i);
}

class Manam : Baz {
	public override void foo (int i) {
		assert (i == 4711);
	}
}

void main () {
	var foo = new Foo ();
	foo.foo (23);

	var bar = new Bar ();
	bar.foo (42);

	var manam = new Manam ();
	manam.foo (4711);
}
