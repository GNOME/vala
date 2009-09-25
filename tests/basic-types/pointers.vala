using GLib;

struct SimpleStruct {
	public int field;

	public int test () {
		return field;
	}

	public static void main () {
		SimpleStruct* st = new SimpleStruct[1];
		st->field = 1;
		assert (st->field == st->test ());
		delete st;

		test_pointers_element_access ();
		test_pointers_return_value ();
	}

	static void test_pointers_element_access () {
		int* array = new int[42];
		array[0] = 23;
		assert (array[0] == 23);
		delete array;
	}

	const int[] array = { 42 };

	static int* return_pointer () {
		return array;
	}

	static void test_pointers_return_value () {
		int i = return_pointer ()[0];
		assert (i == 42);
	}
}

void main () {
	SimpleStruct.main ();
}

