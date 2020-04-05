interface IFoo : Object {
	public abstract async int foo ();
}

class Bar : Object, IFoo {
	public override async int foo () {
		return 42;
	}
}

MainLoop loop;

void main () {
	loop = new MainLoop ();

	IFoo bar = new Bar ();
	bar.foo.begin ((o,r) => {
		assert (((IFoo) o).foo.end (r) == 42);
		loop.quit ();
	});
	loop.run ();
}

