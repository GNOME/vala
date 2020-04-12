interface IBar : Object {
}

class Foo : Object, IBar {
	public signal Foo on_foo ();
	public signal IBar on_bar ();
}

void main () {
	var foo = new Foo ();
	foo.on_foo.connect (() => {
		return new Foo ();
	});
	foo.on_bar.connect (() => {
		return new Foo ();
	});

	var bar = foo.on_foo ();
	assert (bar is Foo);
	var bar2 = foo.on_bar ();
	assert (bar2 is IBar);
}
