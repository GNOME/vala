errordomain FooError {
	FAIL;
}

class Foo {
	bool manam = true;

	public bool bar () throws Error {
		bool result;

		lock (manam) {
			if (manam) {
				throw new FooError.FAIL ("foo");
			} else {
				result = true;
			}
		}

		return result;
	}
}

void main () {
}
