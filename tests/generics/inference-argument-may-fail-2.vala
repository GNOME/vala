int bar () throws Error {
	return 42;
}

void foo<T> (T? a) {
	//FIXME
	//assert (a == 42);
}

void main () {
	try {
		foo<int?> (bar ());
	} catch {
	}
}
