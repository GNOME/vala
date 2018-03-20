class Foo : GLib.Object {
}

class Bar<G> : GLib.Object {
	GLib.List<G> list;

	construct {
		list = new GLib.List<G> ();
	}

	public void add (G item) {
		list.append (item);
	}
}

class Baz<G> : GLib.Object {
	GLib.Node<G> node;

	construct {
		node = new GLib.Node<G> ();
	}

	public void add (G item) {
		node.append_data (item);
	}
}

void main () {
	var foo = new Foo ();

	var bar = new Bar<Foo> ();
	bar.add (foo);
	assert (foo.ref_count == 2);
	bar = null;
	assert (foo.ref_count == 1);

	var baz = new Baz<Foo> ();
	baz.add (foo);
	assert (foo.ref_count == 2);
	baz = null;
	assert (foo.ref_count == 1);
}
