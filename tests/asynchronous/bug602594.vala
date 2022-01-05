class Foo {
	public signal void bar (string s, bool b);
}

async void callback (string s, bool b) {
	assert (s == "foo");
	assert (b);
	success = true;
}

bool success = false;

void main() {
	var foo = new Foo ();
	foo.bar.connect (callback);
	foo.bar ("foo", true);
	assert (success);
}
