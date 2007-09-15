using GLib;

struct SimpleStruct {
}

public struct PublicStruct {
}

struct StructWithCreationMethod {
	public StructWithCreationMethod () {
		stdout.printf ("StructWithCreationMethod\n");
	}
}

struct StructWithNamedCreationMethod {
	public StructWithNamedCreationMethod.named () {
		stdout.printf ("StructWithNamedCreationMethod\n");
	}
}

static class StructsTest {
	static int main (string[] args) {
		stdout.printf ("Structs Test:\n");

		stdout.printf ("new SimpleStruct ()\n");
		var simple_struct = new SimpleStruct ();
		stdout.printf ("new PublicStruct ()\n");
		var public_struct = new PublicStruct ();
		stdout.printf ("new StructWithCreationMethod ()\n");
		var struct_with_creation_method = new StructWithCreationMethod ();
		stdout.printf ("new StructWithNamedCreationMethod ()\n");
		var struct_with_named_creation_method = new StructWithNamedCreationMethod.named ();

		stdout.printf (".\n");

		return 0;
	}
}

