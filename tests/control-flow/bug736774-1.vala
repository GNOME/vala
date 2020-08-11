int success = 0;

class Foo : Object {
	~Foo() {
		success++;
	}
}

Foo may_fail () throws Error {
	return new Foo ();
}

void func (Foo foo) {
}

void main() {
	try {
		func (may_fail ());
	} catch {
	}

	assert (success == 1);
}
