delegate void FooFunc ();
[CCode (has_target = false)]
delegate void BarFunc ();

class Foo : Object {
	public signal void delegate_param_no_target (BarFunc f);
	public signal void delegate_param_with_target (FooFunc f);
	public signal void delegate_param_with_destroy (owned FooFunc f);
}

void no_target_cb (BarFunc f) {
	f ();
}

void with_target_cb (FooFunc f) {
	f ();
}

void with_destroy_cb (owned FooFunc f) {
	f ();
}

bool success1 = false;

class Bar : Object {
	Foo foo;

	bool success2 = false;
	bool success3 = false;

	public Bar () {
		foo = new Foo ();
	}

	public void test_no_target () {
		foo.delegate_param_no_target.connect (no_target_cb);
		foo.delegate_param_no_target (() => {
			success1 = true;
		});
		assert (success1);
	}

	public void test_with_target () {
		foo.delegate_param_with_target.connect (with_target_cb);
		foo.delegate_param_with_target (() => {
			assert (this.ref_count == 1);
			success2 = true;
		});
		assert (this.ref_count == 1);
		assert (success2);
	}

	public void test_with_destroy () {
		foo.delegate_param_with_destroy.connect (with_destroy_cb);
		foo.delegate_param_with_destroy (() => {
			assert (this.ref_count == 2);
			success3 = true;
		});
		assert (this.ref_count == 1);
		assert (success3);
	}
}

void main () {
	var bar = new Bar ();
	bar.test_no_target ();
	bar.test_with_target ();
	bar.test_with_destroy ();
}
