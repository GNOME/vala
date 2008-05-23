void void_method () {
}

// http://bugzilla.gnome.org/show_bug.cgi?id=514801
void test_for_void_methods () {
	for (void_method (); ; void_method ()) {
		break;
	}
}

void main () {
	test_for_void_methods ();
}

