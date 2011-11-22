void main() {
	var foo = new Object ();
	var bar = new Queue<Object> ();
	bar.push_head (foo);
	bar = null;
	assert (foo.ref_count == 1);
}
