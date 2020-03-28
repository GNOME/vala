using GLib;

static delegate int Maman.ActionCallback (int i);
static delegate void Maman.ActionOutCallback (out int i);
static delegate void Maman.ActionRefCallback (ref int i);

class Maman.Bar : Object {
	static int do_action (ActionCallback cb) {
		return cb (1);
	}

	static int do_out_action (ActionOutCallback cb) {
		int i;
		cb (out i);
		return i;
	}

	static int do_ref_action (ActionRefCallback cb) {
		int i = 1;
		cb (ref i);
		return i;
	}

	public static int main () {
		assert (do_action (i => i * 2) == 2);
		assert (do_action (i => { return i * 3; }) == 3);
		assert (do_out_action ((out i) => { i = 4; }) == 4);
		assert (do_ref_action ((ref i) => { i += 4; }) == 5);

		return 0;
	}
}
