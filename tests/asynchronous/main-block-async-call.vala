async string foo () {
	Idle.add (foo.callback);
	yield;
	return "foo";
}

var bar = yield foo ();
assert (bar == "foo");
