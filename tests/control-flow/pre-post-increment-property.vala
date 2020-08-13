class Foo {
	public int property { get; set; }

	public Foo () {
		// incrementing
		{
			property = 1;
			int res = property + property++;
			assert (res == 2);
			assert (property == 2);
		}
		{
			property = 1;
			int res = property++ + property;
			assert (res == 3);
			assert (property == 2);
		}
		{
			property = 1;
			int res = property + ++property;
			assert (res == 3);
			assert (property == 2);
		}
		{
			property = 1;
			int res = ++property + property;
			assert (res == 4);
			assert (property == 2);
		}
		{
			property = 1;
			assert (property++ == 1);
			assert (property == 2);
		}
		{
			property = 1;
			assert (++property == 2);
			assert (property == 2);
		}

		// decrementing
		{
			property = 1;
			int res = property + property--;
			assert (res == 2);
			assert (property == 0);
		}
		{
			property = 1;
			int res = property-- + property;
			assert (res == 1);
			assert (property == 0);
		}
		{
			property = 1;
			int res = property + --property;
			assert (res == 1);
			assert (property == 0);
		}
		{
			property = 1;
			int res = --property + property;
			assert (res == 0);
			assert (property == 0);
		}
		{
			property = 1;
			assert (property-- == 1);
			assert (property == 0);
		}
		{
			property = 1;
			assert (--property == 0);
			assert (property == 0);
		}
	}
}

void main () {
	var foo = new Foo ();
	// incrementing
	{
		foo.property = 1;
		int res = foo.property + foo.property++;
		assert (res == 2);
		assert (foo.property == 2);
	}
	{
		foo.property = 1;
		int res = foo.property++ + foo.property;
		assert (res == 3);
		assert (foo.property == 2);
	}
	{
		foo.property = 1;
		int res = foo.property + ++foo.property;
		assert (res == 3);
		assert (foo.property == 2);
	}
	{
		foo.property = 1;
		int res = ++foo.property + foo.property;
		assert (res == 4);
		assert (foo.property == 2);
	}
	{
		foo.property = 1;
		assert (foo.property++ == 1);
		assert (foo.property == 2);
	}
	{
		foo.property = 1;
		assert (++foo.property == 2);
		assert (foo.property == 2);
	}

	// decrementing
	{
		foo.property = 1;
		int res = foo.property + foo.property--;
		assert (res == 2);
		assert (foo.property == 0);
	}
	{
		foo.property = 1;
		int res = foo.property-- + foo.property;
		assert (res == 1);
		assert (foo.property == 0);
	}
	{
		foo.property = 1;
		int res = foo.property + --foo.property;
		assert (res == 1);
		assert (foo.property == 0);
	}
	{
		foo.property = 1;
		int res = --foo.property + foo.property;
		assert (res == 0);
		assert (foo.property == 0);
	}
	{
		foo.property = 1;
		assert (foo.property-- == 1);
		assert (foo.property == 0);
	}
	{
		foo.property = 1;
		assert (--foo.property == 0);
		assert (foo.property == 0);
	}
}
