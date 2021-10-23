errordomain FooError {
	FOO,
	BAR;
}

void foo () throws FooError.BAR {
}

void main () {
	foo ();
}
