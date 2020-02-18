int pos;

class Foo {
	public Foo () {
		assert (++pos == 1);
		print ("%i. new\n", pos);
	}

	~Foo () {
		assert (++pos == 2);
		print ("%i. finalize\n", pos);
	}
}

void main () {
	pos = 0;
	{
		var foo = new Foo ();
	}
	assert (pos == 2);
}
