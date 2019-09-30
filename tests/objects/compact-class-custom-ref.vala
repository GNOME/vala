[Compact]
[CCode (ref_function = "foo_ref", unref_function = "foo_unref")]
public class Foo {
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
	private extern void free ();
}

void main () {
	var foo = new Foo ();
}
