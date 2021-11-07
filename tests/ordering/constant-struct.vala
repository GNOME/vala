struct FooStruct {
	public int array[FOO];
}

const int FOO = 42;

void main () {
	FooStruct foo = {};
	assert (foo.array.length == 42);
}
