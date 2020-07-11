class Foo<G> {
	public Foo (G g) {
		assert (g == "foo");
	}
}

void main () {
	var s = "foo";
	var foo = new Foo<string> (s);
}
