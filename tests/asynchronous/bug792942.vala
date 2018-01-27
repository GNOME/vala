class Foo {
	public async Foo () throws Error {
	}
}

async void run () {
	try {
		var foo = yield new Foo ();
	} catch {
	}
}

void main () {
	run.begin ();
}
