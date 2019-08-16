class Foo : Object {
}

G get_object<G> (Object[] o) {
	return null;
}

Foo get_foo () {
	return get_object ({ new Foo () });
}

void main() {
	get_foo ();
}
