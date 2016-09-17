bool bar () {
	assert_not_reached();
}

void main () {
	var foo = true ? 0 : (bar() ? 1 : 2);
	assert(foo == 0);
}
