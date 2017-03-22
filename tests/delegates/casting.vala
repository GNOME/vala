delegate void FooFunc ();

[CCode (has_target = false)]
delegate void FooFuncTargetless ();

class Foo : Object {
	public Foo () {
		baz (func);
		assert (ref_count == 1);

		bar (func);
		assert (ref_count == 1);

		baz ((FooFunc) func);
		assert (ref_count == 1);

		bar ((FooFunc) func);
		assert (ref_count == 1);

		man ((FooFuncTargetless) func);
		assert (ref_count == 1);

		maz ((FooFuncTargetless) func);
		assert (ref_count == 1);
	}

	public void func () {
	}

	void baz (FooFunc f) {
		assert (ref_count == 1);
	}

	void bar (owned FooFunc f) {
		assert (ref_count == 2);
	}

	void man (FooFuncTargetless f) {
		assert (ref_count == 1);
	}

	void maz (owned FooFuncTargetless f) {
		assert (ref_count == 1);
	}
}

void func () {
}

void main () {
	var foo = new Foo ();
	assert (foo.ref_count == 1);

	FooFunc f0 = foo.func;
	assert (foo.ref_count == 2);
	f0 = null;
	assert (foo.ref_count == 1);

	var f1 = (FooFunc) foo.func;
	assert (foo.ref_count == 2);
	f1 = null;
	assert (foo.ref_count == 1);

	unowned FooFunc f2 = foo.func;
	assert (foo.ref_count == 1);
	f2 = null;
	assert (foo.ref_count == 1);

	unowned FooFunc f3 = (FooFunc) foo.func;
	assert (foo.ref_count == 1);
	f3 = null;
	assert (foo.ref_count == 1);

	var f4 = (FooFuncTargetless) foo.func;
	assert (foo.ref_count == 1);
	f4 = null;
	assert (foo.ref_count == 1);

	FooFuncTargetless f5 = func;
	f5 = null;

	var f6 = (FooFuncTargetless) func;
	f6 = null;

	unowned FooFuncTargetless f7 = func;
	f7 = null;

	unowned FooFuncTargetless f8 = (FooFuncTargetless) func;
	f8 = null;
}
