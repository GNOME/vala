using GLib;

struct SimpleStruct {
	public int field;

	public int test () {
		return field;
	}

	static void main () {
		SimpleStruct* st = new SimpleStruct[1];
		st->field = 1;
		assert (st->field == st->test ());
		delete st;

		test_pointers_element_access ();
	}

	static void test_pointers_element_access () {
		int* array = new int[42];
		array[0] = 23;
		assert (array[0] == 23);
		delete array;
	}
}

