bool success = false;

class Foo : Object {
	~Foo() {
		success = true;
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

	assert (success);
}
