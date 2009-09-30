void do_foo (out int i) {
	i = 0;
	try {
		return;
	} finally {
		i = 42;
	}
}

void main () {
	int i;
	do_foo (out i);
	assert (i == 42);
}
