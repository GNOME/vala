class Foo<T> {
	GenericArray<T> bar;

	public Foo () {
		bar = new GenericArray<T> ();
	}
}

GenericArray<G> create_bar<G> () {
	return new GenericArray<G> ();
}

void main () {
	var foo = new Foo<string> ();
	var bar = create_bar<int?> ();
}
