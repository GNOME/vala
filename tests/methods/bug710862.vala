class Foo : Object {
	[PrintfFormat]
	public void print (string format, ...) {
		var vargs = va_list ();
		print_vargs (format, vargs);
	}

	[PrintfFormat]
	public void print_shift ([FormatArg] string format, int shift, ...) {
		var vargs = va_list ();
		print_shift_vargs (format, shift, vargs);
	}

	[PrintfFormat]
	public void print_vargs (string format, va_list vargs) {
	}

	[PrintfFormat]
	public void print_shift_vargs ([FormatArg] string format, int shift, va_list vargs) {
	}

	[NoWrapper]
	[PrintfFormat]
	public virtual void print_vfunc_vargs (string format, va_list vargs) {
	}

	[NoWrapper]
	[PrintfFormat]
	public virtual void print_vfunc_shift_vargs ([FormatArg] string format, int shift, va_list vargs) {
	}

	[ScanfFormat]
	public void scan (string input, string format, ...) {
	}

	[NoWrapper]
	[ScanfFormat]
	public virtual void scan_vfunc_vargs (string input, string format, va_list vargs) {
	}
}

[PrintfFormat]
void print_something (string format, ...) {
	var vargs = va_list ();
	print_something_vargs (format, vargs);
}

[PrintfFormat]
void print_something_shift ([FormatArg] string format, int shift, ...) {
	var vargs = va_list ();
	print_something_vargs (format, vargs);
}

[PrintfFormat]
void print_something_vargs (string format, va_list vargs) {
}

[PrintfFormat]
void print_something_shift_vargs ([FormatArg] string format, int shift, va_list vargs) {
}

[ScanfFormat]
void scan_something (string input, string format, ...) {
}

void main () {
	int i;

	print_something ("%d", 42);
	print_something_shift ("%d", 0, 42);
	scan_something ("42", "%d", out i);

	var foo = new Foo ();
	foo.print ("%d", 42);
	foo.scan ("42", "%d", out i);
}
