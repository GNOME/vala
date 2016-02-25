delegate int[] ArrayReturnFunc ();

void main () {
	ArrayReturnFunc f = () => { return {1, 2, 3}; };

	var a = f ();
	assert (a.length == 3);
}
