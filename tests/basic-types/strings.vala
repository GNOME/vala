void test_string () {
	// declaration and initialization
	string s = "hello";
	assert (s == "hello");

	// assignment
	s = "world";
	assert (s == "world");

	// access
	string t = s;
	assert (t == "world");

	// +
	s = "hello" + "world";
	assert (s == "helloworld");

	// equality and relational
	s = "hello";
	assert (s == "hello");
	assert (s != "world");
	assert (s < "i");
	assert (!(s < "g"));
	assert (s <= "hello");
	assert (!(s <= "g"));
	assert (s >= "hello");
	assert (!(s >= "i"));
	assert (s > "g");
	assert (!(s > "i"));

	// slices
	t = s[2:4];
	assert (t.length == 2);
	assert (t[0] == 'l');
	assert (t[1] == 'l');

	t = s[-2:];
	assert (t.length == 2);
	assert (t[0] == 'l');
	assert (t[1] == 'o');

	t = s[:2];
	assert (t.length == 2);
	assert (t[0] == 'h');
	assert (t[1] == 'e');

	t = s[:];
	assert (t == s);
}

void test_string_concat () {
	var s = "hello" + "world";
	assert (s == "helloworld");
}

void test_string_joinv () {
	string[] sa = { "hello", "my", "world" };

	string s = string.joinv (" ", sa);
	assert (s == "hello my world");

	sa.length = -1;
	s = string.joinv (":", sa);
	assert (s == "hello:my:world");

	s = string.joinv ("-", null);
	assert (s == "");

	s = string.joinv ("-", { null });
	assert (s == "");

	// LeakSanitizer -fsanitize=address
	sa.length = 3;
}

void test_string_printf () {
	string s = "%i %s %u %.4f".printf (42, "foo", 4711U, 3.1415);
	assert (s == "42 foo 4711 3.1415");
}

void test_string_replace () {
	string s = "hellomyworld";

	s = s.replace ("my", "whole");
	assert (s == "hellowholeworld");

	s = "Γειά σου Κόσμε".replace ("Γειά σου ", "");
	assert (s == "Κόσμε");

	s = "こんにちは世界".replace ("世界", "");
	assert (s == "こんにちは");
}

void test_string_slice () {
	string s = "hellomyworld";

	string r = s.slice (5, 7);
	assert (r == "my");

	r = s.slice (-7, 7);
	assert (r == "my");

	r = s.slice (5, -5);
	assert (r == "my");

	r = s.slice (-7, -5);
	assert (r == "my");

	r = s.slice (0, 0);
	assert (r == "");
}

void test_string_splice () {
	string s = "hellomyworld";

	s = s.splice (5, 7);
	assert (s == "helloworld");

	s = s.splice (5, 5, "whole");
	assert (s == "hellowholeworld");

	s = s.splice (10, -5, "wide");
	assert (s == "hellowholewideworld");

	s = s.splice (-14, 5);
	assert (s == "hellowholewideworld");

	s = s.splice (-14, -5);
	assert (s == "helloworld");

	s = "hello".splice (0, 0);
	assert (s == "hello");

	s = "world".splice (0, 0, "hello");
	assert (s == "helloworld");
}

void test_string_substring () {
	string s = "hellomyworld";

	string r = s.substring (5, 2);
	assert (r == "my");

	r = s.substring (-7, 2);
	assert (r == "my");

	r = s.substring (5);
	assert (r == "myworld");

	r = s.substring (-7);
	assert (r == "myworld");
}

void main () {
	test_string ();
	test_string_concat ();
	test_string_joinv ();
	test_string_printf ();
	test_string_replace ();
	test_string_slice ();
	test_string_splice ();
	test_string_substring ();
}
