public string[] test() throws Error {
	return { null, "1" };
}

void main() {
	string t = (true ? "1" : "2") ?? "3";
	assert (t == "1");
	
	t = (false ? "1" : "2") ?? "3";
	assert (t == "2");
	
	t = (true ? null : "2") ?? "3";
	assert (t == "3");
	
	t = (false ? "1" : null) ?? "3";
	assert (t == "3");
	
	t = test()[0] ?? "2";
	assert (t == "2");
	
	t = test()[1] ?? "2";
	assert (t == "1");
}
