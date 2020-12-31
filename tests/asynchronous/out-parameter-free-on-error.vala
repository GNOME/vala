errordomain FooError {
	FAIL
}

class Manam : Object {
}

async void foo_async (Manam i, out Manam o) throws FooError {
	o = i;
	throw new FooError.FAIL ("foo");
}

async void run () {
	var manam = new Manam ();
	assert (manam.ref_count == 1);
	try {
		Manam minim;
		yield foo_async (manam, out minim);
	} catch {
	}
	assert (manam.ref_count == 2);
	loop.quit ();
}

MainLoop loop;

void main () {
	loop = new MainLoop ();
	run.begin ();
	loop.run ();
}
