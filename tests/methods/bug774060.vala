unowned string format_wrapper ([FormatArg] string format) {
	return format;
}

void main () {
	print (format_wrapper ("%d"), 42);
}
