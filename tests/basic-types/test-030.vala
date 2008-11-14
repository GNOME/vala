using GLib;

class Maman.Foo : Object {
	static void main (string[] args) {
		stdout.printf (
			"int8: %s...%s\n",
			int8.MIN.to_string (), 
			int8.MAX.to_string ());
		stdout.printf (
			"int16: %s...%s\n",
			int16.MIN.to_string (),
			int16.MAX.to_string ());
		stdout.printf (
			"int32: %s...%s\n",
			int32.MIN.to_string (),
			int32.MAX.to_string ());
		stdout.printf (
			"int64: %s...%s\n",
			int64.MIN.to_string (),
			int64.MAX.to_string ());

		stdout.printf (
			"uint8: %s...%s\n",
			uint8.MIN.to_string (),
			uint8.MAX.to_string ());
		stdout.printf (
			"uint16: %s...%s\n",
			uint16.MIN.to_string (),
			uint16.MAX.to_string ());
		stdout.printf (
			"uint32: %s...%s\n",
			uint32.MIN.to_string (),
			uint32.MAX.to_string ());
		stdout.printf (
			"uint64: %s...%s\n",
			uint64.MIN.to_string (),
			uint64.MAX.to_string ());
	}
}
