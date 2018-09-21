[GenericAccessors]
interface Foo<G> : Object {
	public virtual G get_foo (G g) {
		return g;
	}
}

class Bar<G> : Object, Foo<G> {
}

void main () {
	var bar = new Bar<string> ();
	assert ("foo" == bar.get_foo ("foo"));
}
