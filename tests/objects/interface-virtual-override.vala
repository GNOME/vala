interface IFoo : Object {
	public virtual int foo () {
		assert_not_reached ();
	}
}

class Bar : Object, IFoo {
	public override int foo () {
		return 42;
	}
}

void main () {
	var bar = new Bar ();
	assert (bar.foo () == 42);
}
