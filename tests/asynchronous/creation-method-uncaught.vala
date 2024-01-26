errordomain FooError {
	FOO;
}

void bar () throws GLib.Error {
}

class Foo {
	public async Foo () throws FooError {
		try {
			bar ();
		} catch {
		}
	}
}

void main () {
}
