void main() {
	unowned string a = "first line\nnext line";
	unowned string b = "first line\rnext line";
	unowned string c = "first \tline\r\nnext \tline";

	assert (/\Rnext/.match (a));
	assert (/\Rnext/.match (b));
	assert (/\Rnext/.match (c));

	try {
		var r = new Regex ("\\Rnext");
		assert (r.match (a));

		var r2 = new Regex ("""\Rnext""");
		assert (r2.match (a));
	} catch {
	}

	assert (/\Nline/.match (c));

	try {
		var r = new Regex ("\\Nline");
		assert (r.match (c));

		var r2 = new Regex ("""\Nline""");
		assert (r2.match (c));
	} catch {
	}
}
