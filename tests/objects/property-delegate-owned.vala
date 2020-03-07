delegate void FooFunc ();

interface IFoo {
	public abstract FooFunc foo { get; owned set; }
	public abstract FooFunc bar { get; owned set; }
}

class Foo : IFoo {
	FooFunc? _bar;

	public virtual FooFunc foo { get; owned set; }

	public virtual FooFunc bar {
		get {
			return _bar;
		}
		owned set {
			_bar = (owned) value;
		}
	}

	public Foo () {
		foo = () => {};
		bar = () => {};
	}
}

class Bar : Foo {
	FooFunc? _bar;

	public override FooFunc foo { get; owned set; }

	public override FooFunc bar {
		get {
			return _bar;
		}
		owned set {
			_bar = (owned) value;
		}
	}

	public Bar () {
		foo = () => {};
		bar = () => {};
	}
}

void main () {
	var foo = new Foo ();
	foo.foo ();
	var bar = new Bar ();
	bar.bar ();
}
