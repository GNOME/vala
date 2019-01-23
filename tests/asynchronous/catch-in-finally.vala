errordomain FooError {
	FAIL
}

async void fail () throws FooError {
	throw new FooError.FAIL ("fail");
}

async void may_fail () throws FooError {
}

async void foo () throws FooError {
	try {
		yield fail ();
	} finally {
		try {
			yield may_fail ();
		} catch (FooError e) {
			assert_not_reached ();
		}
	}
	assert_not_reached ();
}

async void bar () throws FooError {
	try {
		yield may_fail ();
	} finally {
		try {
			yield fail ();
		} catch (FooError e) {
		}
	}

	try {
		yield fail ();
	} finally {
		try {
			yield may_fail ();
		} catch (FooError e) {
			assert_not_reached ();
		}
	}
	assert_not_reached ();
}

async void run () {
	foo.begin ((o,r) => {
		try {
			foo.end (r);
		} catch (FooError e) {
			assert (e.message == "fail");
		}
	});

	bar.begin ((o,r) => {
		try {
			bar.end (r);
		} catch (FooError e) {
			assert (e.message == "fail");
			loop.quit ();
		}
	});
}

MainLoop loop;

void main () {
	loop = new MainLoop ();
	run.begin ();
	loop.run ();
}
