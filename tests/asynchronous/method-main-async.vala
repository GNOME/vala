async int main (string[] args) {
	assert (args.length >= 1);
	assert (args[0] != null);
	var foo = args[0];

	Idle.add (main.callback);
	yield;

	assert (foo == "./asynchronous_method_main_async");
	return 0;
}
