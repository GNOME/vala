void main () {
	string s = "%i %s %u %.4f".printf (42, "foo", 4711U, 3.1415);
	assert (s == "42 foo 4711 3.1415");
}
