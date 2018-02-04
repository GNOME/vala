errordomain FooError {
	BAR;
}

class Foo : Object {
	public async bool bar () throws FooError {
		return true;
	}
}

MainLoop loop;

void main () {
	loop = new MainLoop ();
	var foo = new Foo ();
	foo.bar.begin ((o, r) => {
		loop.quit ();
	});
	loop.run ();
}
