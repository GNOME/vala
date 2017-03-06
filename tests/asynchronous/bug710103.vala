void iostream () {
	IOStream? is0 = null;
	IOStream? is1 = null;
	is0.splice_async.begin (is1, IOStreamSpliceFlags.NONE, Priority.DEFAULT, null, (obj, res) => {
		try {
			is0.splice_async.end (res);
		} catch (Error e) {
		}
	});
}

class Foo : Object {
	public int manam;

	[CCode (finish_instance = false)]
	public async void bar () {
		manam = 23;
	}

	[CCode (finish_instance = false)]
	public async Foo.@async () {
		manam = 42;
	}

	public static async Foo create_foo_async () {
		var foo = yield new Foo.@async ();
		return foo;
	}
}

void main () {
	var loop = new MainLoop ();
	Foo.create_foo_async.begin ((obj,res) => {
		var foo = Foo.create_foo_async.end (res);
		assert (foo.manam == 42);
		foo.bar.begin ((obj, res) => {
			foo.bar.end (res);
			assert (foo.manam == 23);
			loop.quit ();
		});
	});
	loop.run ();
}
