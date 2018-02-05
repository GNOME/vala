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

void main () {
	typeof (Foo);

	var bar = new Bar ();
	bar = null;
}
