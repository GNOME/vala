const string[] array = { "foo", "bar", "manam" };

void foo (string s) requires (s in array) {
}

string bar () ensures (result in array) {
	return "manam";
}

void main () {
	foo ("bar");
	bar ();
}
