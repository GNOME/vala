bool success = false;
bool success2 = false;

class Foo {
	public signal void foo () {
		success = true;
	}

	[HasEmitter]
	public signal void foo_with_emitter () {
		success2 = true;
	}
}

void main () {
	var foo = new Foo ();

	foo.foo ();
	assert (success);

	foo.foo_with_emitter ();
	assert (success2);
}
