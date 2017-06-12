class Foo : Object {
	public async void bar () {
		Idle.add (bar.callback);
		yield;
	}
}

void main () {
	var loop = new MainLoop ();
	var foo = new Foo ();
	foo.bar.begin (() => {
		loop.quit ();
	});
	loop.run ();
}
