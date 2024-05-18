errordomain FooError {
	BAR;
}

[SimpleType]
struct Foo {
	int i;
}

bool truesy = true;

Foo foo () throws FooError {
	if (truesy) {
		throw new FooError.BAR ("");
	}

	return { 1 };
}

void main () {
	try {
		foo ();
	} catch {
	}
}

