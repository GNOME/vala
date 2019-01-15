public delegate void FooFunc ();

public class Foo : Object {
	int global = 42;

	void call (FooFunc a, FooFunc b) {
		a ();
		b ();
	}

	void call_owned (owned FooFunc a, owned FooFunc b) {
		a ();
		b ();
	}

	void call_shared ([CCode (delegate_target_cname = "user_data", delegate_target_pos = 2.9)] FooFunc a, [CCode (delegate_target_cname = "user_data", delegate_target_pos = 2.9)] FooFunc b) {
		a ();
		b ();
	}

	void call_shared_owned ([CCode (delegate_target_cname = "user_data", delegate_target_pos = 2.9)] owned FooFunc a, [CCode (delegate_target_cname = "user_data", delegate_target_pos = 2.9)] owned FooFunc b) {
		a ();
		b ();
	}

	public void run_1 () {
		int local = 23;

		assert (this.ref_count == 2);

		call (
			() => {
				assert (global == 42);
				assert (this.ref_count == 2);
			},
			() => {
				assert (local == 23);
				assert (this.ref_count == 2);
			}
		);

		assert (this.ref_count == 2);
	}

	public void run_2 () {
		int local = 23;

		assert (this.ref_count == 2);

		call_owned (
			() => {
				assert (global == 42);
			},
			() => {
				assert (local == 23);
			}
		);

		assert (this.ref_count == 2);
	}

	public void run_3 () {
		int local = 23;

		assert (this.ref_count == 2);

		call_shared (
			() => {
				assert (global == 42);
			},
			() => {
				assert (local == 23);
			}
		);

		assert (this.ref_count == 2);
	}

	public void run_4 () {
		int local = 23;

		assert (this.ref_count == 2);

		call_shared_owned (
			() => {
				assert (global == 42);
			},
			() => {
				assert (local == 23);
			}
		);

		assert (this.ref_count == 2);
	}
}

void main () {
	var foo = new Foo ();
	assert (foo.ref_count == 1);
	foo.run_1 ();
	assert (foo.ref_count == 1);
	foo.run_2 ();
	assert (foo.ref_count == 1);
	foo.run_3 ();
	assert (foo.ref_count == 1);
	foo.run_4 ();
	assert (foo.ref_count == 1);
}
