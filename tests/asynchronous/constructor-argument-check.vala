class Foo {
	public async Foo (string bar) {
		assert (bar == "foo");
	}
}

async void run () {
	yield new Foo ("foo");
}

void main () {
	run.begin ();
}
