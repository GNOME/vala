unowned string m () {
	return "foo";
}

void main () {
	string result;
	result = @"";

	int i = 42;
	result = @"i=$i m=$(m ()) $$";
	assert (result == "i=42 m=foo $");
}
