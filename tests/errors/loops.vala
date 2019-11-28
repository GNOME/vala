errordomain FooError {
	FAIL
}

string[] get_array () throws Error {
	throw new FooError.FAIL ("foo");
}

bool get_bool () throws Error {
	throw new FooError.FAIL ("foo");
}

int get_int () throws Error {
	throw new FooError.FAIL ("foo");
}

void error_in_for () {
	try {
		for (var i = get_int (); i < 2; i++) {
			assert_not_reached ();
		}
		assert_not_reached ();
	} catch {
	}

	try {
		for (var i = 0; get_bool (); i++) {
			assert_not_reached ();
		}
		assert_not_reached ();
	} catch {
	}

	try {
		bool reached = false;
		for (var i = 0; i < 2; i += get_int ()) {
			if (reached) {
				assert_not_reached ();
			} else {
				reached = true;
			}
		}
		assert_not_reached ();
	} catch {
	}

	try {
		for (var i = 0; i < 2; i++) {
			throw new FooError.FAIL ("foo");
			assert_not_reached ();
		}
		assert_not_reached ();
	} catch {
	}
}

void error_in_foreach () {
	try {
		foreach (var s in get_array ()) {
			assert_not_reached ();
		}
		assert_not_reached ();
	} catch {
	}

	try {
		string[] array = { "bar" };
		foreach (var s in array) {
			throw new FooError.FAIL ("foo");
			assert_not_reached ();
		}
		assert_not_reached ();
	} catch {
	}
}

void error_in_do () {
	try {
		do {
		} while (get_bool ());
		assert_not_reached ();
	} catch {
	}

	try {
		do {
			throw new FooError.FAIL ("foo");
			assert_not_reached ();
		} while (true);
		assert_not_reached ();
	} catch {
	}
}

void error_in_while () {
	try {
		while (get_bool ()) {
			assert_not_reached ();
		}
		assert_not_reached ();
	} catch {
	}

	try {
		while (true) {
			throw new FooError.FAIL ("foo");
			assert_not_reached ();
		}
		assert_not_reached ();
	} catch {
	}
}

void main () {
	error_in_for ();
	error_in_foreach ();
	error_in_do ();
	error_in_while ();
}
