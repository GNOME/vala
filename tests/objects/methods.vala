using GLib;

class Maman.Bar : Object {
	public void do_action () {
		stdout.printf (" 2");
	}

	public static void do_static_action () {
		stdout.printf (" 2");
	}

	public virtual void do_virtual_action () {
		stdout.printf (" BAD");
	}
}

class Maman.SubBar : Bar {
	public override void do_virtual_action () {
		stdout.printf (" 2");
	}

	static void accept_ref_string (ref string str) {
	}

	static void test_classes_methods_ref_parameters () {
		string str = "hello";
		accept_ref_string (ref str);
	}

	public static int main () {
		stdout.printf ("Inheritance Test: 1");

		var bar = new SubBar ();
		bar.do_action ();
		
		stdout.printf (" 3\n");

		stdout.printf ("Static Inheritance Test: 1");

		do_static_action ();

		stdout.printf (" 3\n");

		stdout.printf ("Virtual Method Test: 1");

		bar.do_virtual_action ();
	
		stdout.printf (" 3\n");

		// test symbol resolving to check that methods of implemented
		// interfaces take precedence of methods in base classes
		stdout.printf ("Interface Inheritance Test: 1");

		var foobar = new SubFooBar ();
		foobar.do_action ();
	
		stdout.printf (" 3\n");

		test_classes_methods_ref_parameters ();

		BaseAccess.test ();

		string str, str2;
		weak string weak_str;
		string[] array;

		test_out (out str);
		assert (str == "hello");

		test_out_weak (out weak_str);
		assert (weak_str == "hello");

		test_out_weak (out str2);
		assert (str2 == "hello");

		test_ref (ref str);
		assert (str == "world");

		test_ref_weak (ref weak_str);
		assert (weak_str == "world");

		test_out_array_no_length (out array);
		assert (array[0] == "hello");
		assert (array[1] == "world");
		assert (array.length < 0);

		ClassTest.run_test ();

		return 0;
	}
}

interface Maman.Foo {
	public void do_action () {
		stdout.printf (" 2");
	}
}

class Maman.FooBar : Object {
	public void do_action () {
		stdout.printf (" BAD");
	}
}

class Maman.SubFooBar : FooBar, Foo {
}

// http://bugzilla.gnome.org/show_bug.cgi?id=523263

abstract class Maman.AbstractBase : Object {
	public abstract void foo ();
}

abstract class Maman.AbstractDerived : AbstractBase {
	public override void foo () {
	}
}

class Maman.DeepDerived : AbstractDerived {
}

// http://bugzilla.gnome.org/show_bug.cgi?id=528457
namespace Maman.BaseAccess {
	public interface IFoo : Object {
		public abstract int interface_method ();

		public abstract int virtual_interface_method ();
	}

	public class Foo : Object, IFoo {
		public virtual int virtual_method () {
			return 1;
		}

		public int interface_method () {
			return 2;
		}

		public virtual int virtual_interface_method () {
			return 3;
		}
	}

	public class Bar : Foo {
		public override int virtual_method () {
			return base.virtual_method () * 10 + 4;
		}

		public override int virtual_interface_method () {
			return base.virtual_interface_method () * 10 + 5;
		}
	}

	public class FooBar : Foo, IFoo {
		public int interface_method () {
			return base.interface_method () * 10 + 6;
		}

		public int virtual_interface_method () {
			return -1;
		}
	}

	public void test () {
		var bar = new Bar ();
		var foobar = new FooBar ();
		assert (bar.virtual_method () == 14);
		assert (bar.virtual_interface_method () == 35);
		assert (foobar.interface_method () == 26);
	}
}

void test_out (out string bar) {
	bar = "hello";
}

void test_out_weak (out weak string bar) {
	bar = "hello";
}

void test_ref (ref string bar) {
	assert (bar == "hello");
	bar = "world";
}

void test_ref_weak (ref weak string bar) {
	assert (bar == "hello");
	bar = "world";
}

void test_out_array_no_length ([CCode (array_length = false)] out string[] bar) {
	bar = {"hello", "world"};
}

class Maman.ClassTest {
	public class void class_method () {
		stdout.printf(" OK\n");
	}

	public void instance_method () {
		stdout.printf ("Access class method in instance method:");
		class_method ();
	}

	class construct {
		stdout.printf ("Access class method in class constructor:");
		class_method ();
	}

	static construct {
		stdout.printf ("Access class method in static constructor:");
		class_method ();
	}

	public static void run_test () {
		var c = new ClassTest ();

		stdout.printf ("Access class method by member access:");
		c.class_method ();

		c.instance_method ();
	}
}

void main () {
	Maman.SubBar.main ();
}

