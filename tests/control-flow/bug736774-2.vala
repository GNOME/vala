int success = 0;

[Compact]
[Immutable]
[CCode (free_function = "vstring_destroy")]
public class vstring : string {
	public vstring (string s);

	[DestroysInstance]
	public void destroy () {
		free (this);
		success++;
	}
}

vstring may_fail () throws GLib.Error {
	vstring result = (vstring) "test".dup ();
	return (owned) result;
}

void main () {
	try {
		print (_("%s\n"), may_fail ());
	} catch {
	}

	assert (success == 1);
}
