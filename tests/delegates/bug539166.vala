delegate void Deleg ();

class Foo : Object {
	public Object baz = new Object ();

	public void bar () {
		assert (baz != null);
	}
}

void main () {
	var foo = new Foo ();
	var deleg = (Deleg) foo.bar;
	foo = null;
	deleg ();
}
