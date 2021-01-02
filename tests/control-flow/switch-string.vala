const string FOO = "foo";
const string BAR = "bar";
const string MANAM = "manam";

string foo () {
	string foo = "foo";

	switch (foo) {
	case FOO:
		break;
	case BAR:
	case MANAM:
		assert_not_reached ();
	case "minim":
		assert_not_reached ();
	}

	return foo;
}

string get_bar () {
	return "bar";
}

string bar () {
	switch (get_bar ()) {
	case BAR:
		break;
	case FOO:
	case "minim":
		assert_not_reached ();
	default:
		assert_not_reached ();
	}

	return BAR;
}

void main () {
	assert (foo () == "foo");
	assert (bar () == "bar");
}
