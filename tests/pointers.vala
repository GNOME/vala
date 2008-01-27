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
	}
}

