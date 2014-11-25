int[] foo () ensures (result.length == 0 || result.length == 1) {
	return new int[1];
}

[CCode (array_length = false, array_null_terminated = true)]
string[] bar () ensures (result[0] == "bar") {
	return new string[] {"bar"};
}

void main () {
	foo ();
	bar ();
}
