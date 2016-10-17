const string[] FOO = { "foo", "bar" };

void foo (char** s) {
	assert (((string[]) s)[0] == "foo");
}

void main () {
	uint i = 42;

	int *p0 = (int*) &i;
	uint u0 = (uint) *p0;
	assert (u0 == i);

	int *p1 = (int*) (&i);
	uint u1 = (uint) (*p1);
	assert (u1 == i);

	char **p2 = (char**) FOO;
	foo ((char**) FOO);
	foo (p2);

	string s0 = (string) p2[0];
	assert (s0 == "foo");
	string s1 = (string) *(p2 + 1);
	assert (s1 == "bar");
}
