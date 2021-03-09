string foo (int i) requires (i.to_string () == "23" || i.to_string () == "42") {
	return i.to_string ();
}

void main () {
	assert (foo (23) == "23");
	assert (foo (42) == "42");
}
