errordomain Foo {
	MANAM
}

void main () {
	assert (typeof (Foo) == typeof (GLib.Error));
}
