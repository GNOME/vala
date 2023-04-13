void main () {
	var gs = new GenericSet<string> (GLib.str_hash, GLib.str_equal);
	gs.add ("foo");
	foreach (var s in gs) {
		assert (s == "foo");
	}
}
