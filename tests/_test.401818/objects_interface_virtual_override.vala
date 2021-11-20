interface IFoo : Object {
	public virtual int foo () {
		assert_not_reached ();
	}
	public virtual async int bar () {
		assert_not_reached ();
	}
}

class Bar : Object, IFoo {
	public override int foo () {
		return 42;
	}
	public override async int bar () {
		return 23;
	}
}

MainLoop loop;

void main () {
	var bar = new Bar ();
	assert (bar.foo () == 42);

	loop = new MainLoop ();
	bar.bar.begin ((o,a) => {
		assert (((Bar) o).bar.end (a) == 23);
		loop.quit ();
	});
	loop.run ();
}
