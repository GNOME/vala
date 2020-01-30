struct Foo {
	public int i;

	public void bar<G,T> (G g, T t) {
	}
}

void main () {
	Foo foo = { 42 };

	(&foo)->bar<int?, string> (23, "foo");
}
