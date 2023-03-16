struct Foo {
	void* bar;
}

int BAR = 4711;

const Foo FOO = { ref BAR };

const Foo[] FOOS = {
	{ ref BAR }
};

void main () {
	assert (FOO.bar == &BAR);
	assert (FOOS[0].bar == &BAR);
}
