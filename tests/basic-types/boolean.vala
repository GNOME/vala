[SimpleType]
[BooleanType]
public struct Foo {
	public void check () {
		if (this) {
			return;
		}
		assert (true);
	}
}

void main () {
	Foo foo = true;

	foo.check ();

	if (!foo) {
		assert (true);
	}
}
