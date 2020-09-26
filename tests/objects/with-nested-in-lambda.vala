delegate void FooFunc ();

class Foo {
	public int bar () {
		return 23;
	}
}

void run (FooFunc func) {
	func ();
}

void main () {
	var foo = new Foo ();

	run (() => {
		with (foo) {
			assert (bar () == 23);
		}
	});
}
