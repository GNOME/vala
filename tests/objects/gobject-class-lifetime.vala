int pos;

class Foo : Object {
	public Foo () {
		assert (++pos == 3);
		print ("%i. new\n", pos);
	}

	// GObjectClass.constructor()
	construct {
		assert (++pos == 1);
		print ("%i. constructor\n", pos);
	}

	// GObjectClass.finalize()
	~Foo () {
		assert (++pos == 5);
		print ("%i. finalize\n", pos);
	}

	public override void constructed () {
		assert (++pos == 2);
		print ("%i. constructed\n", pos);
	}

	public override void dispose () {
		assert (++pos == 4);
		print ("%i. dispose\n", pos);
	}
}

void main () {
	pos = 0;
	{
		var foo = new Foo ();
	}
	assert (pos == 5);
}
