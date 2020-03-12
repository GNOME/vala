void foo (owned string[] a) ensures (a[1] == "bar") {
}

void foz (ref string[] a) ensures (a[1] == "bar") {
	a = { "foo", "bar" };
}

void fom (out string[] a) ensures (a[1] == "bar") {
	a = { "foo", "bar" };
}

string[] bar (owned string[] a) ensures (result[0] == "manam" && a[1] == "foo") {
	return { "manam" };
}

string[] baz (ref string[] a) ensures (result[0] == "manam" && a[1] == "foo") {
	a = { "bar", "foo" };
	return { "manam" };
}

string[] bam (out string[] a) ensures (result[0] == "manam" && a[1] == "foo") {
	a = { "bar", "foo" };
	return { "manam" };
}

void main () {
	{
		foo ({ "foo", "bar" });
	}
	{
		string[] a = {};
		foz (ref a);
		assert (a[0] == "foo");
	}
	{
		string[] a;
		fom (out a);
		assert (a[0] == "foo");
	}
	{
		assert (bar ({ "bar", "foo" })[0] == "manam");
	}
	{
		string[] a = {};
		assert (baz (ref a)[0] == "manam");
	}
	{
		string[] a;
		assert (bam (out a)[0] == "manam");
	}
}
