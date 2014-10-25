const int foo[] = {1,2,3};


void main () {
	int baz[] = {3,4,5};
	assert (foo.length == 3);
	assert (foo[1] == 2);
	assert (baz.length == 3);
	assert (baz[1] == 4);
}