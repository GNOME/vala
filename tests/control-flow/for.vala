void void_method () {
}

// http://bugzilla.gnome.org/show_bug.cgi?id=514801
void test_for_void_methods () {
	for (void_method (); ; void_method ()) {
		break;
	}
}

void condition_true () {
	for (;true;) {
		return;
	}
	assert_not_reached ();
}

void condition_false () {
	for (;false;) {
		assert_not_reached ();
	}
}

void main () {
	condition_true ();
	condition_false ();
	test_for_void_methods ();
}

