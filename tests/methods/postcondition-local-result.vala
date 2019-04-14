public string foo () ensures (result.length >= 3) {
	string result = "bar";
	return result;
}

void main () {
	assert (foo () == "bar");
}
