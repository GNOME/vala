using GLib;


static Regex get_from_array (int index)
{
	Regex[] arr = {
		/(\d+\.\d+\.\d+)/,
		/(\d+)\.\d+\.\d+/,
		/\d+\.(\d+)\.\d+/,
		/(\d+)\.\d+\.(\d+)/
	};

	assert (0 <= index <= 3);
	return arr[index];
}

static Regex get_fixed ()
{
	return /(is.*ip)/;
}

class Test : Object {
	public signal void regexTest (string str);
	public void run (string s)
	{
		regexTest (s);
	}
}

void main ()
{
	MatchInfo info;

	// Simple greedy regular expression matching, regex received as a function return value.
	var str1 = "mississippi";
	if (get_fixed ().match (str1, 0, out info)) {
		stdout.printf ("Part of %s is '%s'...\n", str1, info.fetch (1));
	} else {
		stdout.printf ("Did not match at all.\n");
	}

	// Match caseless.
	var str2 = "demonStration";
	if (/mon(str.*o)n/i.match (str2, 0, out info)) {
		stdout.printf ("Part of %s is '%s'...\n", str2, info.fetch (1));
	} else {
		stdout.printf ("%s did not match at all.\n", str2);
	}

	// Match and pick substrings.
	var ts   = "Time: 10:42:12";
	if (/Time: (..):(..):(..)/.match (ts, 0, out info)) {
		stdout.printf ("%s\n\thours = %s\n\tminutes = %s\n\tseconds = %s\n\n", ts, info.fetch (1), info.fetch (2), info.fetch (3));
	}

	// Replace demo: word swapping
	try {
		var str = "apple grape";
		stdout.printf ("'%s' becomes '%s'\n", str, /^([^ ]*) *([^ ]*)/.replace (str, -1, 0, """\2 \1"""));
	} catch (RegexError err) {
		// Replacing still needs exception catching
		message (err.message);
	}

	// Regex literals in an array
	for (int i=0; i<4; i++) {
		if (get_from_array (i).match ("23.3.2010", 0, out info)) {
			stdout.printf ("Round %d: %s\n", i, info.fetch (1));
		}
	}

	// ??-operator
	Regex? r = null;
	Regex? r1 = null;
	Regex? r2 = null;

	r = r1 ?? r2 ?? /match (this)/i;
	if (r.match ("match THIS", 0, out info)) {
		stdout.printf ("Match: %s\n", info.fetch (1));
	}

	// Escape sequences
	if (/\.\+\(\)\-\?\/\"\$\[\]\*\^/.match (".+()-?/\"$[]*^")) {
		stdout.printf ("Matches\n");
	} else {
		stdout.printf ("Does not match.\n");
	}

	// Lambda and closure test
	Regex? rc = /foo(bar)/i;
	var test = new Test ();
	test.regexTest.connect ((s) => {
		if (rc.match (s, 0, out info)) {
			stdout.printf ("Lambda (closure var.): %s -> %s\n", s, info.fetch (1));
		} else {
			stdout.printf ("Does not match.\n");
		}
		if (/foo(bar)/i.match (s, 0, out info)) {
			stdout.printf ("Lambda (lit.): %s -> %s\n", s, info.fetch (1));
		} else {
			stdout.printf ("Does not match.\n");
		}
	});
	test.run ("fooBar");
	test.run ("foobAr");
}

