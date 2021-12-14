class Foo<G> : Object {
	public Type foo_g_type { get { return typeof (G); } }
}

class Bar<G> : Foo<G> {
	public Type bar_g_type { get { return typeof (G); } }
}

void main () {
	var bar = new Bar<string> ();
	assert (bar.bar_g_type == typeof (string));
	assert (bar.foo_g_type == typeof (string));
}
