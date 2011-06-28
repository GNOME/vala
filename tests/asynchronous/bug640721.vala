async void foo (out int i) {
}

void main () {
	var loop = new MainLoop ();
	foo ((s,r) => { foo.end (r, null); loop.quit (); });
	loop.run ();
}
