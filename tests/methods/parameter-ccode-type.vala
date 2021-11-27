void foo ([CCode (array_length = false, type = "const gchar**")] string[]? sa) {
	assert (sa[1] == "bar");
}

const string[] BARS = { "foo", "bar", null };

void bar ([CCode (array_length = false, type = "const gchar***")] out unowned string[]? sa) {
	sa = BARS;
}

void manam ([CCode (array_length = false, type = "const GObject**")] Object[]? oa) {
	assert (oa[1] == null);
}

void faz ([CCode (type = "const GObject*")] Object? o) {
	assert (o == null);
}

void baz ([CCode (type = "const GObject**")] out unowned Object? o) {
	o = null ;
}

void minim ([CCode (type = "gpointer*")] out unowned void* p) {
	p = null;
}

void main () {
	{
		foo ({ "foo", "bar", null });
	}
	{
		unowned string[] sa;
		bar (out sa);
	}
	{
		manam ({ null });
	}
	{
		faz (null);
	}
	{
		unowned Object? o;
		baz (out o);
		assert (o == null);
	}
	{
		unowned void* p;
		minim (out p);
		assert (p == null);
	}
}
