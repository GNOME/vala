delegate void FooFunc ([CCode (array_length = false, array_null_terminated = true)] string[] a);
delegate void BarFunc (owned FooFunc func);

void foo (string[] a) {
	assert (a.length == 2);
	assert (a[1] == "bar");
}

void bar (owned FooFunc func) {
	string[] ia = { "foo", "bar" };
	func (ia);
}

void main () {
	FooFunc f = foo;
	BarFunc b = bar;
	b ((owned) f);
}
