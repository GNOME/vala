delegate void FooFunc ();

bool success = false;

void main () {
	FooFunc f = () => {
		success = true;
	};
	f ();
	assert (success);
}
