public errordomain FooError {
	FAIL
}

public class Foo : Object {
	public string bar {
		get {
			throw new FooError.FAIL ("property getter");
		}
		set {
			throw new FooError.FAIL ("property setter");
		}
	}

	public Foo () {
		throw new FooError.FAIL ("creation method");
	}

	construct {
		throw new FooError.FAIL ("constructor");
	}

	class construct {
		throw new FooError.FAIL ("class constructor");
	}

	static construct {
		throw new FooError.FAIL ("static constructor");
	}

	~Foo () {
		throw new FooError.FAIL ("destructor");
	}

	class ~Foo () {
		throw new FooError.FAIL ("class destructor");
	}

	public void foo () {
		throw new FooError.FAIL ("method");
	}
}

void main () {
}
