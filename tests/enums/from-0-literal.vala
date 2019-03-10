enum Foo {
	BAR
}

[Flags]
enum Bar {
	FOO
}

void main () {
	{
		Foo foo;
		foo = 0;
		foo = 0U;
	}
	{
		Bar bar;
		bar = 0;
		bar = 0U;
	}
}
