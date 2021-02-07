T manam <T> (int i) {
	return (int?) i;
}

T minim <T> (uint i) {
	return (uint?) i;
}

void main () {
	assert (manam<int?> (int.MIN) == int.MIN);
	assert (minim<uint?> (uint.MAX) == uint.MAX);
	assert ((int) ((int?) manam<int?> (int.MIN)) == int.MIN);
	assert ((uint) ((uint?) minim<uint?> (uint.MAX)) == uint.MAX);
}
