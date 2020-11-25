void test_glist () {
	var list = new GLib.List<string> ();
	assert (list.is_empty ());
	list.prepend ("foo");
	list.prepend ("bar");
	assert (!list.is_empty ());
	assert (list.nth_data (1) == "foo");
	list = null;

	var list2 = new GLib.List<unowned string> ();
	list2.prepend ("foo");
	list2.prepend ("bar");
	assert (list2.nth_data (1) == "foo");
	list2 = null;
}

void test_gslist () {
	var list = new GLib.SList<string> ();
	assert (list.is_empty ());
	list.prepend ("foo");
	list.prepend ("bar");
	assert (!list.is_empty ());
	assert (list.nth_data (1) == "foo");
	list = null;

	var list2 = new GLib.SList<unowned string> ();
	list2.prepend ("foo");
	list2.prepend ("bar");
	assert (list2.nth_data (1) == "foo");
	list2 = null;
}

void test_gqueue () {
	var queue = new GLib.Queue<string> ();
	assert (queue.is_empty ());
	queue.push_head ("foo");
	queue.push_head ("bar");
	assert (!queue.is_empty ());
	assert (queue.peek_nth (1) == "foo");
	queue = null;

	var queue2 = new GLib.Queue<unowned string> ();
	queue2.push_head ("foo");
	queue2.push_head ("bar");
	assert (queue2.peek_nth (1) == "foo");
	queue2 = null;
}

void test_gnode () {
	var nodes = new GLib.Node<string> ();
	nodes.append_data ("foo");
	nodes.append_data ("bar");
	assert (nodes.nth_child (1).data == "bar");
	nodes = null;

	var nodes2 = new GLib.Node<unowned string> ();
	nodes2.append_data ("foo");
	nodes2.append_data ("bar");
	assert (nodes2.nth_child (1).data == "bar");
	nodes2 = null;
}

void main () {
	test_glist ();
	test_gslist ();
	test_gqueue ();
	test_gnode ();
}
