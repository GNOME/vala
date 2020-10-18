class Foo<G> {
	public G prop { get; private set; }

	public Foo (G g) {
		prop = g;
	}
}

void main() {
	var foo = new Foo<int> (23);
	assert (foo.prop == 23);
}
