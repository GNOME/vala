List<G> copy_list<G> (List<G> list) {
	var result = new List<G> ();

	foreach (var item in list)
		result.prepend (item);
	result.reverse ();

	return result;
}

void main () {
	List<string> list = new List<string> ();
	list.prepend ("foo");

	var copy = copy_list (list);
	list = null;

	assert (copy.nth_data (0) == "foo");

	copy = null;
}
