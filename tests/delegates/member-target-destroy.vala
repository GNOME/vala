delegate string Foo ();

string bar (string s) {
	return s;
}

void foo_free (void* data) {
	GLib.free (data);
}

void main () {
	Foo foo = (Foo) bar;
	assert (foo.target == null);
	assert (foo.destroy == null);

	string* foo_data = "foo".dup ();
	foo.target = foo_data;
	foo.destroy = (GLib.DestroyNotify) foo_free;

	assert (foo () == "foo");
	assert (foo.target == foo_data);
	assert (foo.destroy == (GLib.DestroyNotify) foo_free);
}
