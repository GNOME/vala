void set_foo (string s) {
	assert (s == "bar");
}

string get_bar () {
	return "bar";
}

void main () {
	string? s = null;
	set_foo (s ?? get_bar ());
}
