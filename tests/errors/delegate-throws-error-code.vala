errordomain FooError {
	FOO,
	BAR;
}

delegate void FooFunc () throws FooError.BAR;

void main () {
	FooFunc foo = () => {};
	foo ();
}
