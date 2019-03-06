class Foo<G> {
	public static G[] bar () {
		return {};
	}
}

void main () {
	Foo<string>.bar ();
}
