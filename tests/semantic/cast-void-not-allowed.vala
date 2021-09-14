bool success = false;

bool foo () {
	success = true;
	return true;
}

void main () {
	(void) foo ();
	assert (success);
}
