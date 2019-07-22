interface IFoo : Object {
}

class Bar : Object, IFoo {
}

class Manam : Bar {
}

interface IFaz : Object, IFoo {
}

class Baz : Object, IFoo, IFaz {
}

void main () {
	{
		Bar bar = new Bar ();
		IFoo foo = bar;

		if (foo != bar) {
			assert_not_reached ();
		} else if (foo == bar) {
			// Well done
		} else {
			assert_not_reached ();
		}
	}
	{
		IFaz faz = new Baz ();
		IFoo foo = faz;

		if (faz != foo) {
			assert_not_reached ();
		} else if (foo == faz) {
			// Well done
		} else {
			assert_not_reached ();
		}
	}
	{
		Manam manam = new Manam ();
		Bar bar = manam;

		if (manam != bar) {
			assert_not_reached ();
		} else if (manam == bar) {
			// Well done
		} else {
			assert_not_reached ();
		}
	}
}

