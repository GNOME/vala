delegate int FooFunc ();

unowned FooFunc foo () {
	return (FooFunc) manam;
}

unowned FooFunc bar () {
	return () => 4711;
}

int manam () {
	return 42;
}

void main () {
	{
		FooFunc func = foo ();
		assert (func == (FooFunc) manam);
		assert (func () == 42);
	}
	{
		FooFunc func = bar ();
		assert (func () == 4711);
	}
}
