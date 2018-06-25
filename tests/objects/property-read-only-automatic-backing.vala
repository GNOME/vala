void main () {
	var a = new Test ();
	assert (a.read_only_property == 0);
}

class Test {
	public int read_only_property { get; }
}
