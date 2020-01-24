[IntegerType (rank = 6, signed = true, width = 32)]
[SimpleType]
[CCode (has_type_id = false)]
struct foo_t {
	public int sum (foo_t b) {
		return this + b;
	}
}

[CCode (has_type_id = false)]
struct bar_t : foo_t {
	public int mul (bar_t b) {
		return this * b;
	}
	public int mul2 (bar_t b) {
		return base * b;
	}
}

void main () {
	bar_t bar = 23;
	assert (bar.sum (42) == 65);
	assert (bar.mul (42) == 966);
	assert (bar.mul2 (42) == 966);
}
