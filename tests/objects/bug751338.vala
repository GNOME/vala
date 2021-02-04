public class Foo : Object {
	public string[]? strings {
		get { return this._strings; }
		set { this._strings = value; }
	}

	private string[]? _strings;
}

void main() {
	string[]? strings;
	var f = new Foo();

	f.set("strings", new string[]{ "foo", "bar" });
	f.get("strings", out strings);
	assert (strings[0] == "foo");
	assert (strings[1] == "bar");

	// LeakSanitizer -fsanitize=address
	if (strings.length == -1) {
		strings.length = (int) strv_length (strings);
	}

	f.set("strings", null);
	f.get("strings", out strings);
	assert(strings == null);

	f.set("strings", new string[]{ "foo", "bar" });
	f.get("strings", out strings);
	assert (strings[0] == "foo");
	assert (strings[1] == "bar");

	// LeakSanitizer -fsanitize=address
	if (strings.length == -1) {
		strings.length = (int) strv_length (strings);
	}
}
