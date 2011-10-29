public async T foo<T> (T bar) {
	return bar;
}

void main () {
	MainLoop loop = new MainLoop ();
	foo.begin ("test", (s,r) => {
		assert (foo.end<string> (r) == "test");
		loop.quit ();
	});
	loop.run ();
}
