void foo () throws Error {
	var bar = new Object ();
	try
	{
		throw new FileError.EXIST ("");
	} catch (Error e) {
		throw e;
	} finally {
		bar.set_data ("foo", "bar");
	}
}

void main() {
	try {
		foo ();
	} catch (Error e) {
	}
}
