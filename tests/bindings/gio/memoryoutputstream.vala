void test_stack_data () {
	uint8 buffer[7];
	var mos = MemoryOutputStream.with_data (buffer);
	var dos = new DataOutputStream (mos);
	try {
		dos.put_string ("foobar\0");
		assert (buffer.length == 7);
		assert ((string) buffer == "foobar");
	} catch {
		assert_not_reached ();
	}
}

void test_heap_data () {
	uint8[] buffer = new uint8[7];
	var mos = MemoryOutputStream.with_data (buffer);
	var dos = new DataOutputStream (mos);
	try {
		dos.put_string ("foobar\0");
		assert ((string) buffer == "foobar");
	} catch {
		assert_not_reached ();
	}
}

void test_owned_data () {
	uint8[] buffer = new uint8[7];
	var mos = MemoryOutputStream.with_owned_data ((owned) buffer);
	var dos = new DataOutputStream (mos);
	try {
		dos.put_string ("foobar\0");
		unowned uint8[] data = mos.get_data ();
		assert ((string) data == "foobar");
	} catch {
		assert_not_reached ();
	}
}

void main () {
	test_stack_data ();
	test_heap_data ();
	test_owned_data ();
}
