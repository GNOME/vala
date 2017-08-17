string* keep;

string may_fail () throws GLib.Error {
	string result = "test";
	keep = result;
	return (owned) result;
}

void main () {
	try {
		print (_("%s\n"), may_fail ());
	} catch {
	}

	assert (keep != "test");
}
