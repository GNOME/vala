G? foo<G> () {
	return null;
}

void main () {
	var s = foo<string> ();
	assert (s == null);
}
