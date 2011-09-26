void foo (void* bar) {
	string baz = (string) (owned) bar;
}

void main () {
	var bar = "bar";
	foo ((owned) bar);
}
