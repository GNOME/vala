enum Foo {
	BAR = 23
}

const Foo FOO = Foo.BAR;

[Flags]
enum Bar {
	FOO = 42
}

const Bar BAR = Bar.FOO;

void main () {
	{
		Foo? foo = Foo.BAR;
		assert (foo == 23);
	}
	{
		Foo? foo = FOO;
		assert (foo == 23);
	}
	{
		var foo = (Foo?) FOO;
		assert (foo == 23);
	}
	{
		Bar? bar = Bar.FOO;
		assert (bar == 42);
	}
	{
		Bar? bar = BAR;
		assert (bar == 42);
	}
	{
		var bar = (Bar?) BAR;
		assert (bar == 42);
	}
}
