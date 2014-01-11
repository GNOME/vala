interface Foo : Object {
	public void foo<T> (owned T bar) {
	       bar = null;
	}
}

class Bar {
}

class Baz : Object, Foo {
}

void foo<T> (owned T bar) {
	bar = null;
}

bool is_check<G> () {
	var o = new Bar ();
	return o is G;
}

void main () {
	var bar = new Object ();
	foo<Object> (bar);
	assert (bar.ref_count == 1);

	var baz = new Baz ();
	baz.foo<Object> (bar);
	assert (baz.ref_count == 1);
	
	assert (is_check<Bar> ());
	assert (!is_check<Baz> ());
}
