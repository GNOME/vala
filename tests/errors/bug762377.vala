class FooOutputStream : GLib.OutputStream {
	public override ssize_t write (uint8[] buffer, Cancellable? cancellable = null) throws IOError {
		throw new IOError.FAILED ("");
	}

	public override bool close (Cancellable? cancellable = null) throws IOError {
		return true;
	}
}

void main () {
	try {
		var output = new FooOutputStream ();
		size_t bytes_written;
		output.write_all ("Hello world!".data, out bytes_written);
	} catch (IOError e) {
	}
}
