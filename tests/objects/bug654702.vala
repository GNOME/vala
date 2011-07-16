class Foo<T> : Object {
}

class Bar : Foo<string> {
	public Bar () {
		Object ();
	}
}

void main () {
	new Bar ();
}
