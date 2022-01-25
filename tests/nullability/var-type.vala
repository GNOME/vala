void main () {
	{
		unowned var? foo = "foo";
		assert (foo != null);
	}
	{
		foreach (unowned var? foo in new string[] { "foo", "bar" }) {
			assert (foo != null);
		}
	}
	{
		with (unowned var? foo = "foo") {
			assert (foo != null);
		}
	}
}
