errordomain FooError {
	FAIL
}

void fail () throws FooError {
	throw new FooError.FAIL ("fail");
}

void may_fail () throws FooError {
}

void foo () throws FooError {
	try {
		fail ();
	} finally {
		try {
			may_fail ();
		} catch (FooError e) {
			assert_not_reached ();
		}
	}
	assert_not_reached ();
}

void bar () throws FooError {
	try {
		may_fail ();
	} finally {
		try {
			fail ();
		} catch (FooError e) {
		}
	}

	try {
		fail ();
	} finally {
		try {
			may_fail ();
		} catch (FooError e) {
			assert_not_reached ();
		}
	}
	assert_not_reached ();
}

void main () {
	try {
		foo ();
	} catch (FooError e) {
		assert (e.message == "fail");
	}

	try {
		bar ();
	} catch (FooError e) {
		assert (e.message == "fail");
	}
}
