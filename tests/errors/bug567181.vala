GLib.List<Foo> list;

errordomain Error {
	FOOBAR,
}

class Foo : Object {
	public Foo () throws Error {
		list.append (this);
		throw new Error.FOOBAR ("foo");
	}
}

void main () {
	Foo foo = null;
	list = new List<Foo> ();
	try {
		foo = new Foo ();
	} catch (Error err) {
	}
	assert (foo == null);
	/* There should be only 1 ref in the list */
	assert (list.nth_data (0).ref_count == 1);
}
