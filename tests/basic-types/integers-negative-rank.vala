[CCode (default_value = "0", has_type_id = false)]
[IntegerType (rank = -1)]
struct FooHandle {
}

struct BarHandle : FooHandle {
}

[IntegerType (rank = -2)]
[CCode (default_value = "0", has_type_id = false)]
struct BazHandle {
}

void main () {
	{
		FooHandle foo = 0;
		assert (foo == 0);
	}
	{
		FooHandle foo = -1;
		assert (foo == -1);
	}
	{
		FooHandle foo = 42;
		assert (foo == 42);
		foo = 64;
		assert (foo == 64);
	}
	{
		FooHandle foo = 36;
		BarHandle bar = 64;
		foo = bar;
		assert (foo == 64);
		foo = 88;
		bar = foo;
		assert (bar == 88);
	}
	{
		int foo = 99;
		BarHandle bar = (BarHandle) foo;
		assert (bar == 99);
		uint baz = (uint) bar;
		assert (baz == 99);
	}
	{
		FooHandle foo = 28;
		BazHandle baz = (BazHandle) foo;
		assert (baz == 28);
	}
}
