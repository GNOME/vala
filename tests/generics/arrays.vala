class Foo<G> {
	public G[] ga;

	public Foo (G g) {
		var gs = new G[] { g };
		assert (gs.length == 1);
		assert (gs[0] == "foo");

		ga = gs;
		assert (ga.length == 1);
		assert (ga[0] == "foo");
	}

	public void foo (owned G[] gs) {
		assert (gs.length == 1);
		assert (gs[0] == "foo");
	}
}

void bar<G> (G g) {
	var gs = new G[] { g };
	assert (gs.length == 1);
	assert (gs[0] == "bar");

	var gs_copy = gs;
	assert (gs_copy.length == 1);
	assert (gs_copy[0] == "bar");
}

void main () {
	var foo = new Foo<string> ("foo");
	foo.foo (foo.ga);

	bar<string> ("bar");
}
