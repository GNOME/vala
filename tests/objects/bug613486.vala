class Foo<T> {
	public void do_foo (T t) {
	}
}

class Bar : Foo<int> {
}

void main () {
	var b = new Bar ();
	b.do_foo (42);
}
