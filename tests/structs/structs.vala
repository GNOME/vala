using GLib;

struct SimpleStruct {
	public int field;
	public int array[10];
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


delegate void Func ();

struct StructWithFunc {
	public Func foo;

	public StructWithFunc (owned Func f) {
		foo = (owned) f;
	}
}

void test_in_parameter (SimpleStruct st) {
	stdout.printf ("test_in_parameter: st.field = %d\n", st.field);
}

void test_in_nullable_parameter (SimpleStruct? st) {
	assert (st.field == 1);
}

void test_ref_parameter (ref SimpleStruct st) {
	stdout.printf ("test_ref_parameter: st.field = %d\n", st.field);
	st.field++;
	st.array[0] = 10;
}

void test_out_parameter (out SimpleStruct st) {
	st = SimpleStruct ();
	st.field = 3;
}

void test_struct_with_func () {
	var foes = new StructWithFunc[] {
		StructWithFunc (() => {})
	};
}

void main () {
	stdout.printf ("Structs Test:\n");

	stdout.printf ("new SimpleStruct ()\n");
	var simple_struct = SimpleStruct ();
	stdout.printf ("new PublicStruct ()\n");
	var public_struct = PublicStruct ();
	stdout.printf ("new StructWithCreationMethod ()\n");
	var struct_with_creation_method = StructWithCreationMethod ();
	stdout.printf ("new StructWithNamedCreationMethod ()\n");
	var struct_with_named_creation_method = StructWithNamedCreationMethod.named ();

	stdout.printf ("new SimpleStruct () { field = 1 }\n");
	simple_struct = SimpleStruct () { field = 1 };
	stdout.printf ("simple_struct.field = %d\n", simple_struct.field);

	test_in_parameter (simple_struct);
	test_in_parameter ({1});
	test_in_nullable_parameter (simple_struct);
	test_ref_parameter (ref simple_struct);
	stdout.printf ("after test_ref_parameter: st.field = %d\n", simple_struct.field);
	assert (simple_struct.array[0] == 10);
	test_out_parameter (out simple_struct);
	stdout.printf ("after test_out_parameter: st.field = %d\n", simple_struct.field);

	stdout.printf (".\n");
}

