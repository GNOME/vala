int field = FOO;
int array[FOO];

const int FOO = 42;

void main () {
	assert (field == 42);
	assert (array.length == 42);
}
