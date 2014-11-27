public class Foo {
	public bool success;

	Foo.first () {
		success = true;
	}

	Foo.second () {
		assert_not_reached ();
	}

	public Foo (bool cond) {
		if (cond) {
			this.first ();
		} else {
			this.second ();
		}
	}
}

public class Bar {
	public bool success;

	public Bar.first () {
		success = true;
	}

	public Bar.second () {
		assert_not_reached ();
	}
}

public class Baz : Bar {
	public Baz (bool cond) {
		if (cond) {
			base.first ();
		} else {
			base.second ();
		}
	}
}

void main () {
	var foo = new Foo (true);
	assert (foo.success);

	var baz = new Baz (true);
	assert (baz.success);
}
