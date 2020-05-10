void foo<T> (T t) {
	assert (((Bar?) t).s == "foo");
	assert (((Bar?) t).i == 23);
}

struct Bar {
	public string s;
	public int i;
}

void main () {
	Bar f = { "bar", 42 };
	var cast = (Bar?) f;
	assert (cast.s == "bar");
	assert (cast.i == 42);

	Bar arg = { "foo", 23 };
	foo ((Bar?) arg);
	foo<Bar?> (arg);
	foo<Bar?> ((Bar?) arg);
}
