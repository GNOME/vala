bool reached = false;

class Foo : Object {
	public virtual signal void foo () {
		reached = true;
	}
}

class Bar : Foo {
	public void bar () {
		// Only execute default-handler without a signal emission
		base.foo ();
	}
}

void main () {
	var bar = new Bar ();
	bar.foo.connect (assert_not_reached);
	bar.bar ();
	assert (reached);
}
