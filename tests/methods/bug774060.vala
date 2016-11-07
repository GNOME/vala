class Foo : Object {
	public unowned string format (string bar, int baz, [FormatArg] string format) {
		return format;
	}

	[CCode (instance_pos = -1)]
	public unowned string format_pos (string bar, int baz, [FormatArg] string format) {
		return format;
	}

	[NoWrapper]
	public virtual unowned string format_virtual (string bar, int baz, [FormatArg] string format) {
		return format;
	}

	public static unowned string format_static (string foo, int baz, [FormatArg] string format) {
		return format;
	}
}

unowned string format_wrapper ([FormatArg] string format) {
	return format;
}

void main () {
	print (format_wrapper ("%d"), 42);

	var foo = new Foo ();
	print (foo.format ("", 0, "%d"), 42);
	print (foo.format_pos ("", 0, "%d"), 42);
	print (foo.format_virtual ("", 0, "%d"), 42);
	print (Foo.format_static ("", 0, "%d"), 42);
}
