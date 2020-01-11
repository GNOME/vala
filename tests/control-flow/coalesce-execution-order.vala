string? get_foo () {
	assert (count == 0);
	return null;
}

string get_bar () {
	count++;
	assert (count == 1);
	return "bar";
}

int count;

void main () {
	count = 0;
	string? s = null;
	string foo = s ?? get_foo () ?? get_bar ();
	assert (foo == "bar");
}
