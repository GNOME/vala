struct Foo {
	int i;
}

struct Bar : Foo {
}

void main () {
	Bar b1 = {};
	Bar b2 = {};

	assert (b1 == b2);
	assert (b2 == b1);
}
