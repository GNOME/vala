[Compact]
[CCode (ref_function = "foo_ref", unref_function = "foo_unref")]
public class Foo {
	[CCode (type = "volatile int")]
	public int ref_count = 1;

	public unowned Foo ref () {
		AtomicInt.inc (ref ref_count);
		return this;
	}

	public void unref () {
		if (AtomicInt.dec_and_test (ref ref_count)) {
			free ();
		}
	}

	[DestroysInstance]
	extern void free ();
}

void main () {
	var foo = new Foo ();
	assert(foo.ref_count == 1);
	foo.ref ();
	assert(foo.ref_count == 2);
	foo.unref ();
	assert(foo.ref_count == 1);
}
