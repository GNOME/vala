namespace Bar {
	class Foo {
		public Foo () {
			assert_not_reached ();
		}
	}

	void bar () {
		new global::Foo ();
	}
}

class Foo {
}

void main () {
	Bar.bar ();
}
