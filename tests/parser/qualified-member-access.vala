namespace Bar {
	void foo () {
		assert_not_reached ();
	}

	void bar () {
		global::foo ();
	}
}

void foo () {
}

void main () {
	Bar.bar ();
}
