bool success = false;

class Foo : Object {
	~Foo () {
		success = true;
	}
}

void bar () {
	assert (!success);
	for (int i = 0; i < 1; i++) {
		Foo? foo = null;
		switch (i) {
		case 0:
			foo = new Foo ();
			continue;
		}
	}
	assert (success);
}

void main() {
	bar ();
}
