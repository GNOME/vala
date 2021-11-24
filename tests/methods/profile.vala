[Profile]
void foo () {
	Thread.usleep (4000);
}

[Profile]
int bar (bool b) {
	Thread.usleep (4000);
	if (b) {
		return 42;
	}
	return 23;
}

void main () {
	foo ();
	assert (bar (false) == 23);
	assert (bar (true) == 42);
}
