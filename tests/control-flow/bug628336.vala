void main () {
	var foo = new string[]{"bar", "bar"};
	foreach (string bar in foo) {
		assert (bar == "bar");
		SourceFunc f = () => bar == "bar";
		assert (f ());
	}
}
