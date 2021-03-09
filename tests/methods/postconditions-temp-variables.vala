string foo () ensures (result.to_string () != "23") {
	return 4711.to_string ();
}

string bar (bool b) ensures (result.to_string () != "4711") {
	if (b) {
		return 23.to_string ();
	} else {
		return 42.to_string ();
	}
}

void main () {
	assert (foo () == "4711");
	assert (bar (true) == "23");
	assert (bar (false) == "42");
}
