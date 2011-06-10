interface Foo : Object {
	public async virtual void foo () {
	}
}

class Bar : Object, Foo {
}

void main () {
	var loop = new MainLoop();

	var bar = new Bar ();
	bar.foo.begin ((s,r) => { bar.foo.end (r); loop.quit (); });

	loop.run();
}
