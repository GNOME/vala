class Foo {
}

class Bar : Foo {
}

void manam (Foo?[] foos) {
	assert (foos[0] is Bar);
}

void main () {
	Bar[] bars = { new Bar () };

	manam (bars);

	unowned Foo?[] foos = bars;
	assert (foos[0] is Bar);
}
