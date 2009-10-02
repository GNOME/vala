public class Foo : Object {
	public Foo () {
		return;
	}
}

void main () {
	assert (new Foo () is Foo);
}
