

void main () {
	string? s = (string?)"something";

	if (s != null) {
		// fine, s can't be null.
		int k = s.length;
	}
}
