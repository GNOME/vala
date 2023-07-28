class Test : Object {
	[CCode (no_generic_args=true)]
	public int foo<G> () where G : Object {
		return 10;
	}
}


void main () {
	Test t = new Test ();
	assert (t.foo<Object> () == 10);
}
