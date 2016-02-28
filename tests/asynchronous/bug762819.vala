abstract class Bar : GLib.Object {
	[CCode (array_length = false, array_null_terminated = true)]
	public abstract async string[] get_string_async ();
}

class Foo : Bar {
	public override async string[] get_string_async () {
		return { "foo", "bar" };
	}
}

void main () {
	var loop = new MainLoop ();
	var foo = new Foo ();
	foo.get_string_async.begin ((obj, res) => {
		var result = foo.get_string_async.end (res);
		assert (result.length == 2);
		assert (result[1] == "bar");
		loop.quit ();
	});
	loop.run ();
}
