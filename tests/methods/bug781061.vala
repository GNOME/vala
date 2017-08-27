errordomain FooError {
	FAILED;
}

[PrintfFormat]
void print_something_throws (bool ok, string format, ...) throws FooError {
	var vargs = va_list ();
	print_something_vargs_throws (ok, format, vargs);
}

[PrintfFormat]
void print_something_vargs_throws (bool ok, string format, va_list vargs) throws FooError {
}

[ScanfFormat]
void scan_something_throws (bool ok, string format, ...) throws FooError {
}

[ScanfFormat]
void scan_something_vargs_throws (bool ok, string format, va_list vargs) throws FooError {
}

void main () {
	try {
		print_something_throws (true, "%s", "foo");
		int i;
		scan_something_throws (false, "%d", out i);
	} catch (FooError e) {
	}
}
