enum Foo {
	BAR
}

void main () {
	{
		Foo foo = 23;
	}
	{
		Foo foo = Foo.BAR;
		foo = 42;
	}
}
