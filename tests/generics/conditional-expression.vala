class Foo<G> {
	public G get (int i) {
		return null;
	}
	public void set (int i, G g) {
	}
}

void bar<G> (G g) {
}

void main () {
	bool b = false;

	var foo = new Foo<int> ();
	foo.set (42, b ? foo.get (42) + 1 : 1);

	bar (b ? 13 : 27 + 42);
}
