class Foo : Object {
	public signal void sig ();
	public string prop { get; set; }
}

bool success = false;

void sig_cb () {
	success = true;
}

void sig_after_cb () {
	assert (success);
}

void main () {
	var real = new Foo ();
	dynamic Object foo = real;

	foo.prop = "foo";
	string s = foo.prop;
	assert (s == "foo");

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
