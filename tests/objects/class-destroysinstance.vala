class Foo : Object {
	[DestroysInstance]
	public void free () {
		assert (this.ref_count == 2);
		this.unref ();
	}
}

void main () {
	var foo = new Foo ();
	{
		foo.free ();
	}
	assert (foo.ref_count == 1);
}
