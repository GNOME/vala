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
	static void test_in_parameter (SimpleStruct st) {
		stdout.printf ("test_in_parameter: st.field = %d\n", st.field);
	}

	static void test_ref_parameter (ref SimpleStruct st) {
		stdout.printf ("test_ref_parameter: st.field = %d\n", st.field);
		st.field++;
	}

	static void test_out_parameter (out SimpleStruct st) {
		st = new SimpleStruct ();
		st.field = 3;
	}

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

		test_in_parameter (simple_struct);
		test_ref_parameter (ref simple_struct);
		stdout.printf ("after test_ref_parameter: st.field = %d\n", simple_struct.field);
		test_out_parameter (out simple_struct);
		stdout.printf ("after test_out_parameter: st.field = %d\n", simple_struct.field);

		stdout.printf (".\n");

		return 0;
	}
}

