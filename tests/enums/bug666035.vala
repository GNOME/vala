enum FooEnum {
	FOO,
	BAR,
	MAM;
}

[Flags]
enum FooFlag {
	FOO = 1 << 0,
	BAR = 1 << 1,
	MAM = 1 << 2;
}

struct FooStruct {
	public FooEnum f;
}

FooEnum takes_enum (FooEnum foo) {
	return foo;
}

FooEnum gives_enum () {
	return MAM;
}

FooFlag takes_flag (FooFlag foo) {
	return foo;
}

FooFlag gives_flag () {
	return MAM | BAR;
}

void main () {
	if (takes_enum (BAR) == BAR)
		return;

	assert (takes_enum (BAR) == BAR);
	//TODO assert (MAM == gives_enum ());

	assert (takes_flag (BAR | MAM) == (BAR | MAM));
	//TODO assert (FOO == takes_flag (BAR & MAM | FOO));
	assert (gives_flag () == (BAR | MAM));

	FooEnum[] foo_array = { FOO, BAR, FOO };
	foo_array[1] = MAM;
	assert (foo_array[1] == MAM);

	FooStruct foo_struct = { BAR };
	assert (foo_struct.f == BAR);

	FooEnum foo_enum = BAR;
	switch (foo_enum) {
		default:
		case FOO: assert (false); break;
		case BAR: break;
	}
}
