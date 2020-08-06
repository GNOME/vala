class Foo : Object {
	class string s;

	class construct {
		assert (s == null);
		s = "foo";
	}

	class ~Foo () {
		assert (s == "foo");
		s = null;
	}
}

class Bar : Object {
	string s;

	construct {
		assert (s == null);
		s = "bar";
	}

	~Bar () {
		assert (s == "bar");
		s = null;
	}
}

class Manam : Object {
	~Manam () {
		bool b = true;
		if (b) {
			return;
		}
		assert_not_reached ();
	}
}

void main () {
	typeof (Foo);

	var bar = new Bar ();
	bar = null;

	var manam = new Manam ();
	manam = null;
}
