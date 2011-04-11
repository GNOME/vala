async int foo () throws Error {
	try {
		yield foo ();
	} catch (Error e) {
		try {
			yield foo ();
		} catch (Error e) {
			return 0;
		}
	}
	foreach (var e in new int[]{1,2,3}) {
	}
	foreach (var e in new int[]{1,2,3}) {
	}
	return 0;
}

void main() {
}
