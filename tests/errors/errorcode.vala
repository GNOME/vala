errordomain FooError {
	REALLY_BAD,
	NOT_SO_GOOD,
	EVEN_WORSE = 23
}

void bar (int code) {
	assert (code == 23);
}

void main () {
	{
		var error = new IOError.NO_SPACE ("foo");
		assert (error.code == 12);
	}
	{
		var code = IOError.NO_SPACE;
		assert (code == 12);
	}
	{
		var error = new FooError.NOT_SO_GOOD ("foo");
		assert (error.code == 1);
	}
	{
		var code = FooError.NOT_SO_GOOD;
		assert (code == 1);
	}
	{
		var error = new FooError.EVEN_WORSE ("foo");
		assert (error.code == 23);
	}
	{
		var code = FooError.EVEN_WORSE;
		assert (code == 23);
	}
	{
		bar (FooError.EVEN_WORSE);
	}
}
