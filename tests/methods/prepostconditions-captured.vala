delegate void Func ();

int bar (int i) requires (i == 23) ensures (i == 42) {
	Func f = () => {
		assert (i == 23);
		i = 42;
	};
	f ();

	return i;
}

void baz (int i) requires (i == 42) ensures (i == 23) {
	Func f = () => {
		assert (i == 42);
		i = 23;
	};
	f ();
}

async int foo (int i) requires (i == 23) ensures (i == 42) {
	Func f = () => {
		assert (i == 23);
		i = 42;
	};
	f ();

	return i;
}

void main () {
	assert (bar (23) == 42);
	baz (42);
	foo.begin (23);
}
