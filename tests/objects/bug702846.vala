void main () {
	Variant? foo = "baz";
	Variant bar = (!) foo;
	string baz = (string) bar;
	assert (baz == "baz");
}
