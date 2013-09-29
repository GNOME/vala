public class Foo : Application {
	public bool activated = false;

    public Foo () {
        Object (application_id: "org.foo.bar");
    }

    protected override void activate () {
		activated = true;
    }

    protected override bool local_command_line (ref unowned string[] arguments, out int exit_status) {
        var option_context = new OptionContext ();

        // FIXME: https://bugzilla.gnome.org/show_bug.cgi?id=642885
        unowned string[] args = arguments;

        try {
            option_context.parse (ref args);
        } catch (OptionError e) {
            exit_status = 1;
            return true;
        }

        return base.local_command_line (ref arguments, out exit_status);
    }
}

void main () {
	string[] args = {""};
	var app = new Foo ();
	app.run (args);
	assert (app.activated);
}


