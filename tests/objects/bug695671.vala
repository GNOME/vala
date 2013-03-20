class Foo : Object {
}

G ref_generic<G> (G o) {
	return o;
}

Object ref (Object o) {
	return o;
}

void main () {
	var o = new Object();
	var f = (ref (o)) as Foo;
	assert (f == null);
	assert (o.ref_count == 1);

	var g = (ref_generic (o)) as Foo;
	assert (g == null);
	assert (o.ref_count == 1);

	var r = ref_generic (o) as Object;
	assert (r == o);
	assert (o.ref_count == 2);

	var r2 = o as Object;
	assert (r2 == o);
	assert (o.ref_count == 3);

	unowned Object r3 = o as Object;
	assert (r3 == o);
	assert (o.ref_count == 3);

	unowned Object r4 = o as Foo;
	assert (r4 == null);
	assert (o.ref_count == 3);
}
