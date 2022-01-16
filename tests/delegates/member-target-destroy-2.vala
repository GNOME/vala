delegate void FooFunc ();

void bar (string s) {
	assert (s == "foo");
}

void foo (owned FooFunc func) {
	assert (func.target == "foo");
	assert (func.destroy == g_free);
	func ();
}

void main () {
	FooFunc func = (FooFunc) bar;

	func.target = "foo".dup ();
	func.destroy = g_free;

	foo ((owned) func);
}
