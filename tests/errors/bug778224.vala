errordomain FooError {
	BAR;
}

[SimpleType]
struct Foo {
	int i;
}

bool @true = true;

Foo foo () throws FooError {
	if (@true) {
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

