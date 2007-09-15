using GLib;

struct SimpleStruct {
	public int field;
}

public struct PublicStruct {
	public int field;
}

struct StructWithCreationMethod {
	public StructWithCreationMethod () {
		stdout.printf ("StructWithCreationMethod\n");
	}

	public int field;
}

struct StructWithNamedCreationMethod {
	public StructWithNamedCreationMethod.named () {
		stdout.printf ("StructWithNamedCreationMethod\n");
	}

	public int field;
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

		stdout.printf ("new SimpleStruct () { field = 1 }\n");
		simple_struct = new SimpleStruct () { field = 1 };
		stdout.printf ("simple_struct.field = %d\n", simple_struct.field);

		stdout.printf (".\n");

		return 0;
	}
}

