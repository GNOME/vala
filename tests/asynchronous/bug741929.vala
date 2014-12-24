MainLoop? loop = null;

class Foo : Object {
	bool running = false;

	public Foo () {
	}

	public async void query_async () throws Error {
		running = true;

		try {
			if (!yield internal_query_async ()) {
				return;
			}
		} finally {
			try {
				yield close_query_async ();
			} catch (Error e) {
				// ignored
			}

			running = false;
		}
	}

	async bool internal_query_async () throws Error {
		return true;
	}

	async void close_query_async () throws Error {
	}
}

async void go_async () {
	Foo foo = new Foo ();
	try {
		yield foo.query_async ();
	} catch (Error e) {
	}

	loop.quit ();
}

void main () {
	loop = new MainLoop ();
	go_async.begin ();
	loop.run ();
}

