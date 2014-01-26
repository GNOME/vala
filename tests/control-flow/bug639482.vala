void main () {
	string empty = null;
	assert ((false ? "A" : (empty ?? "B")) == "B");
}
