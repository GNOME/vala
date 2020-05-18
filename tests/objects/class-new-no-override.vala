interface IFoo : Object {
	public virtual void foo (int i) {
		assert (i == 42);
	}
}

class Bar : Object, IFoo {
	public new string foo () {
		return "bar";
	}
}

void main () {
	var bar = new Bar ();
	assert (bar.foo () == "bar");
	((IFoo) bar).foo (42);
}
