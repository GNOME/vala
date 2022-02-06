class Foo : Object {
	public signal void sig ();
	public string prop { owned get; set; }
	public int prop2 { get; set; }
}

class Bar : Object {
	public bool success = false;

	public void sig_cb () {
		success = true;
	}

	public void sig_after_cb () {
		assert (success);
	}
}

bool success = false;

void sig_cb () {
	success = true;
}

void sig_after_cb () {
	assert (success);
}

void main () {
	{
		var real = new Foo ();
		dynamic Object foo = real;

		foo.prop = "foo";
		string s = foo.prop;
		assert (s == "foo");

		foo.prop2 = 42;
		int i = foo.prop2;
		assert (i == 42);

		success = false;
		var id1 = foo.sig.connect_after (sig_after_cb);
		var id2 = foo.sig.connect (sig_cb);
		real.sig ();
		assert (success);

		success = false;
		SignalHandler.disconnect (foo, id1);
		SignalHandler.disconnect (foo, id2);
		real.sig ();
		assert (!success);
	}
	{
		var real = new Foo ();
		dynamic Object foo = real;

		var bar = new Bar ();
		bar.success = false;
		var id1 = foo.sig.connect_after (bar.sig_after_cb);
		var id2 = foo.sig.connect (bar.sig_cb);
		real.sig ();
		assert (bar.success);

		bar.success = false;
		SignalHandler.disconnect (foo, id1);
		SignalHandler.disconnect (foo, id2);
		real.sig ();
		assert (!bar.success);
	}
}
