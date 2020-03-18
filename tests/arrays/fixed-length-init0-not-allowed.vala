const int BAR = 1024;

void main () {
	{
		const int FOO = 4;

		char bar[FOO] = { 'f', 'o', 'o', '\0' };
		assert ((string) bar == "foo");

		char baz[FOO];
		baz[0] = 'f';
		baz[1] = 'o';
		baz[2] = 'o';
		baz[3] = '\0';
		assert ((string) baz == "foo");
	}
	{
		const int FOO = 1024;

		string foo[FOO];

		assert (foo[0] == null);
		assert (foo[FOO / 2] == null);
		assert (foo[FOO - 1] == null);
	}
	{
		const int FOO = 1024;

		string array[16 * FOO];

		assert (array[0] == null);
		assert (array[16 * FOO / 2] == null);
		assert (array[16 * FOO - 1] == null);
	}
	{
		string array[BAR];

		assert (array[0] == null);
		assert (array[BAR / 2] == null);
		assert (array[BAR - 1] == null);
	}
	{
		string array[16 * BAR];

		assert (array[0] == null);
		assert (array[16 * BAR / 2] == null);
		assert (array[16 * BAR - 1] == null);
	}
}
