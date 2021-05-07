class Bar<G> {
	public G g;
	public Bar (G g) {
		this.g = g;
		assert (g == "bar");
	}
}

void bar<G> (Bar<G> g) {
	var t = (owned) g.g;
	assert (g.g == null);
	assert (t == "bar");
}

void foo<G> (owned G g) {
	var t = (owned) g;
	assert (g == null);
	assert (t == "foo");
}

void main () {
	{
		foo<string> ("foo");
	}
	{
		bar<string> (new Bar<string> ("bar"));
	}
	{
		var bar = new Bar<string> ("bar");
		var t = (owned) bar.g;
		assert (bar.g == null);
		assert (t == "bar");
	}
}
