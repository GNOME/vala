class Foo<G> {
	G g;
	public void set_g (G data) {
		g = data;
	}
	public G get_g () {
		return g;
	}
}

struct Bar {
	public int i;
}

void main () {
	Bar bar = { 42 };
	var foo = new Foo<Bar*> ();
	foo.set_g (&bar);

	assert (foo.get_g ()->i == 42);
	assert (((Bar*) foo.get_g ())->i == 42);
}
