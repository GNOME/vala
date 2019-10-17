interface IFoo {
	public abstract async void foo ();
}

class Bar : IFoo {
	public async void foo () {
		reached = true;
	}
}

class Foo : Bar {
	public async void bar () {
		yield base.foo ();
	}
}

bool reached = false;

void main () {
	var foo = new Foo ();
	assert (foo is IFoo);

	foo.bar.begin ();
	assert (reached);
}
