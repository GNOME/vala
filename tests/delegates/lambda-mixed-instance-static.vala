[CCode (has_target = false)]
delegate int FooFunc (int i);

delegate int BarFunc (int i);

void func (FooFunc f, BarFunc b) {
	assert (f (42) == 42);
	assert (b (23) == 4711);
}

void main () {
	int global = 4711;

	func (
		(i) => { assert (i == 42); return i; },
		(i) => { assert (i == 23); return global; }
	);
}
