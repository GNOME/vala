using GLib;

public enum ParameterEnum { FOO, BAR }

public static delegate void Maman.VoidCallback ();

public static delegate int Maman.ActionCallback ();

public delegate void Maman.InstanceCallback (int i);

public delegate ParameterEnum Maman.EnumDelegate (ParameterEnum pe);

struct Maman.DelegateStruct {
	public VoidCallback callback;
}

interface Maman.Foo : Object {
	public abstract void foo_method (int i);
}

class Maman.Bar : Object, Foo {
	const DelegateStruct const_delegate_struct = { do_void_action };

	InstanceCallback callback_field;

	public Bar () {
	}

	static void do_void_action () {
		stdout.printf (" 2");
	}

	static int do_action () {
		return 4;
	}

	void do_instance_action (int i) {
		assert (i == 42);

		stdout.printf (" 6");
	}

	static void call_instance_delegate (InstanceCallback instance_cb) {
		instance_cb (42);
	}

	void assign_instance_delegate (out InstanceCallback instance_cb) {
		instance_cb = foo_method;
	}

	static void test_function_pointers () {
		stdout.printf ("testing function pointers:");
		var table = new HashTable<string, Bar>.full (str_hash, str_equal, g_free, Object.unref);
		stdout.printf (" 1");

		table.insert ("foo", new Bar ());
		stdout.printf (" 2");

		var bar = table.lookup ("foo");
		stdout.printf (" 3\n");
	}

	public void foo_method (int i) {
	}

	static void test_delegates_interface_method () {
		// http://bugzilla.gnome.org/show_bug.cgi?id=518109
		var bar = new Bar ();
		call_instance_delegate (bar.foo_method);
	}

	void test_field_reference_transfer () {
		var foo = (owned) callback_field;
	}

	static unowned Maman.VoidCallback test_unowned_delegate_return () {
		return () => {};
	}

	public static int main () {
		stdout.printf ("Delegate Test: 1");

		VoidCallback void_cb = do_void_action;

		void_cb ();

		stdout.printf (" 3");

		ActionCallback cb = do_action;

		stdout.printf (" %d", cb ());

		stdout.printf (" 5");

		var bar = new Bar ();

		InstanceCallback instance_cb = bar.do_instance_action;
		call_instance_delegate (instance_cb);

		bar.assign_instance_delegate (out instance_cb);
		call_instance_delegate (instance_cb);

		stdout.printf (" 7\n");

		test_function_pointers ();

		test_delegates_interface_method ();

		var baz = test_unowned_delegate_return ();

		return 0;
	}
}
