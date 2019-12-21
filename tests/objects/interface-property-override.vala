interface IFoo {
	public virtual int bar {
		get {
			assert_not_reached ();
		}
		set {
			assert_not_reached ();
		}
	}
}

class Foo : IFoo {
	public override int bar {
		get {
			return 42;
		}
		set {
		}
	}
}

interface IBar : Object {
	public virtual int foo {
		get {
			assert_not_reached ();
		}
		set {
			assert_not_reached ();
		}
	}
}

class Bar : Object, IBar {
	public override int foo {
		get {
			return 23;
		}
		set {
		}
	}
}

void main () {
	{
		var foo = new Foo ();
		foo.bar = 0;
		assert (foo.bar == 42);
	}
	{
		var bar = new Bar ();
		bar.foo = 0;
		assert (bar.foo == 23);
	}
}
