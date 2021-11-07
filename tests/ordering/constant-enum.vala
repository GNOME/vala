enum FooEnum {
	BAR = FOO;
}

const int FOO = 42;

void main () {
	assert (FooEnum.BAR == 42);
}
