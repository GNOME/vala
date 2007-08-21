using GLib;

class SwitchTest {
    static void main () {
        var foo = "Hello World";
        var bar = 0;

        stdout.printf ("before switch: %s\n", foo);

	switch (bar) {
	    case 0:
		stdout.printf ("within switch: %s\n", foo);
		break;
	}

        stdout.printf ("behind switch: %s\n", foo);
    }
}
