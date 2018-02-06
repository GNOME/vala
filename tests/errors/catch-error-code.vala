errordomain FooError {
	BAR,
	FOO
}

void main () {
	bool cond = false;
	try {
		if (cond)
			throw new FooError.BAR ("bad");
		throw new FooError.FOO ("worse");
	} catch (FooError.FOO e) {
	} catch (FooError e) {
		assert_not_reached ();
	}
}
