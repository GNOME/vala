class Foo : Object {
	public signal void sig (string s, int i);
}

void sig_cb (Object o, string s, int i) {
	success = true;
	assert (s == "foo");
	assert (i == 42);
}

bool success = false;

void main () {
	dynamic Object dfoo = new Foo ();
	dfoo.sig.connect (sig_cb);

	success = false;
	dfoo.sig.emit ("foo", 42);
	assert (success);
}
