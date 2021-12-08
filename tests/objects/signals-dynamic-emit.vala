class Foo : Object {
	public signal void sig (string s, int i);

	public signal bool sig2 (string s, int i);
}

void sig_cb (Object o, string s, int i) {
	success = true;
	assert (s == "foo");
	assert (i == 42);
}

bool sig2_cb (Object o, string s, int i) {
	success = true;
	assert (s == "foo");
	assert (i == 42);
	return true;
}

bool success = false;

void main () {
	dynamic Object dfoo = new Foo ();
	dfoo.sig.connect (sig_cb);

	success = false;
	dfoo.sig.emit ("foo", 42);
	assert (success);

	dfoo.sig2.connect (sig2_cb);

	success = false;
	assert (dfoo.sig2.emit ("foo", 42));
	assert (success);
}
