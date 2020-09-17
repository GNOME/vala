void main () {
	if (true)
		with ("foo")
			assert (to_string () == "foo");

	with (10)
		assert (to_string () == "10");
}
