public class Foo : Object {
	public int i;
	public Foo () {
		Object ();
		i = 1;
	}
}

void main () {
	var foo = new Foo ();
	assert (foo.i == 1);
}
