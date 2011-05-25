void *test () {
	return null;
}

void main () {
	unowned int[] o = (int[]) test();
}
