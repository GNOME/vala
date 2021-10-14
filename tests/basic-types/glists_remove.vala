class Foo : Object {
}

void test_glist () {
	{
		var list = new GLib.List<Foo> ();
		var foo = new Foo ();
		list.append (foo);
		assert (list.length () == 1);
		assert (foo.ref_count == 2);
		list.remove (foo);
		assert (list.length () == 0);
		assert (foo.ref_count == 1);
	}
	{
		var list = new GLib.List<Foo> ();
		var foo = new Foo ();
		list.append (foo);
		list.append (foo);
		assert (list.length () == 2);
		assert (foo.ref_count == 3);
		list.remove_all (foo);
		assert (list.length () == 0);
		assert (foo.ref_count == 1);
	}
	{
		var list = new GLib.List<unowned string> ();
		unowned var s = "foo";
		list.append (s);
		assert (list.length () == 1);
		list.remove (s);
		assert (list.length () == 0);
		list.append (s);
		list.remove_all (s);
		assert (list.length () == 0);
	}
}

void test_gslist () {
	{
		var list = new GLib.SList<Foo> ();
		var foo = new Foo ();
		list.append (foo);
		assert (list.length () == 1);
		assert (foo.ref_count == 2);
		list.remove (foo);
		assert (list.length () == 0);
		assert (foo.ref_count == 1);
	}
	{
		var list = new GLib.SList<Foo> ();
		var foo = new Foo ();
		list.append (foo);
		list.append (foo);
		assert (list.length () == 2);
		assert (foo.ref_count == 3);
		list.remove_all (foo);
		assert (list.length () == 0);
		assert (foo.ref_count == 1);
	}
	{
		var list = new GLib.SList<unowned string> ();
		unowned var s = "foo";
		list.append (s);
		assert (list.length () == 1);
		list.remove (s);
		assert (list.length () == 0);
		list.append (s);
		list.remove_all (s);
		assert (list.length () == 0);
	}
}

void test_gqueue () {
	{
		var queue = new GLib.Queue<Foo> ();
		var foo = new Foo ();
		queue.push_head (foo);
		assert (queue.length == 1);
		assert (foo.ref_count == 2);
		queue.remove (foo);
		assert (queue.length == 0);
		assert (foo.ref_count == 1);
	}
	{
		var queue = new GLib.Queue<Foo> ();
		var foo = new Foo ();
		queue.push_head (foo);
		queue.push_head (foo);
		assert (queue.length == 2);
		assert (foo.ref_count == 3);
		queue.remove_all (foo);
		assert (queue.length == 0);
		assert (foo.ref_count == 1);
	}
	{
		var queue = new GLib.Queue<unowned string> ();
		unowned var s = "foo";
		queue.push_head (s);
		assert (queue.length == 1);
		queue.remove (s);
		assert (queue.length == 0);
		queue.push_head (s);
		queue.remove_all (s);
		assert (queue.length == 0);
	}
}

void main () {
	test_glist ();
	test_gslist ();
	test_gqueue ();
}
