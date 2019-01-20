[CCode (array_length = false)]
unowned int[] foo;

void main () {
	foo = (int[]) 0;
	assert (foo == null);
}
