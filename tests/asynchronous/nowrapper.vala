interface IFoo : Object {
	[NoWrapper]
	public abstract async int manam ();
}

class Foo : Object, IFoo {
	[NoWrapper]
	public virtual async int bar () {
		return 23;
	}

	public async int manam () {
		return 42;
	}
}

MainLoop loop;

void main () {
	loop = new MainLoop ();

	var foo = new Foo ();
	foo.bar.begin ((o,r) => {
		assert (foo.bar.end (r) == 23);
	});
	foo.manam.begin ((o,r) => {
		assert (foo.manam.end (r) == 42);
		loop.quit ();
	});

	loop.run ();
}
