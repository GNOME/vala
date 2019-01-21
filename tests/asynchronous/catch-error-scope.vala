errordomain FooError {
	FAIL
}

async void foo () {
	try {
		throw new FooError.FAIL ("Foo");
	} catch (GLib.Error e) {
		assert (e is FooError);
		assert (e.message == "Foo");
	}
	try {
		throw new FooError.FAIL ("Bar");
	} catch (GLib.Error e) {
		assert (e is FooError);
		assert (e.message == "Bar");
	}
}

void main () {
	var loop = new MainLoop ();
	foo.begin ((o, res) => {
		foo.end (res);
		loop.quit ();
	});
	loop.run ();
}
