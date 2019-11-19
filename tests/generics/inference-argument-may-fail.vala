class Foo<G> {
	public Foo () throws Error {
	}
}

Foo<string>? foo () throws Error {
	return null;
}

G bar<G> (Foo<G>? foo) {
	return null;
}

void main () {
	try {
		bar (foo ());
		bar (new Foo<string> ());
	} catch {
	}
}
