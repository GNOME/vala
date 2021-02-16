class Foo {
    public int x;
    public int y { get; set; }
    public int z;
}

class Bar : Foo {
    public Bar () {
		x = 4711;
		y = 4711;
		z = 4711;
		{
			var foo = new Foo () {
				x = y = z = 23
			};
			assert (foo.x == 23);
			assert (foo.y == 23);
			assert (foo.y == 23);
		}
		{
			var foo2 = new Foo () {
				z = 42,
				y = z,
				x = y
			};
			assert (foo2.x == 4711);
			assert (foo2.y == 4711);
			assert (foo2.z == 42);
		}
		assert (x == 4711);
		assert (y == 4711);
		assert (z == 4711);
    }
}

int i = 67;

int get_int () {
	return i++;
}

void main () {
	{
		var bar = new Bar () {
			x = y = z = get_int ()
		};
		assert (bar.x == 67);
		assert (bar.y == 67);
		assert (bar.z == 67);
	}
	{
		var bar = new Bar () {
			x = 23,
			y = 42,
			z = 67
		};
		assert (bar.x == 23);
		assert (bar.y == 42);
		assert (bar.z == 67);
	}
}
