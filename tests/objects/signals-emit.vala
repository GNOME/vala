class Foo : Object {
	public signal void sig (string s, int i);

	public signal bool sig2 (string s, int i);

	public void fire () {
		sig.emit ("foo", 42);
	}
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
	var foo = new Foo ();
	foo.sig.connect (sig_cb);

	success = false;
	foo.sig.emit ("foo", 42);
	assert (success);

	success = false;
	foo.fire ();
	assert (success);

	success = false;
	foo.sig2.connect (sig2_cb);
	assert (foo.sig2.emit ("foo", 42));
	assert (success);

}
