void main () {
	Object a[1] = {new Object()};
	Object b[1] = a;
	assert (a[0] == b[0]);
}
