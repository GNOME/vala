[GenericAccessors]
interface Foo<G> : Object {
	public virtual G get_foo (G g) {
		assert (typeof (G) == typeof (string));
		G g_copy = g;
		assert (GLib.strcmp ((string) g_copy, "foo") == 0);
		assert (g_copy != g);
		return g;
	}
}

class Bar<G> : Object, Foo<G> {
}

void main () {
	var bar = new Bar<string> ();
	assert ("foo" == bar.get_foo ("foo"));
}
