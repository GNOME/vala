using GLib;

interface Maman.Ibaz : Object {
	public abstract void do_action ();

	public abstract void do_virtual_action ();

	protected void protected_mixin_1() {
		stdout.puts("protected_mixin_1\n");
		protected_mixin_2();
	}

	protected void protected_mixin_2() {
		stdout.puts("protected_mixin_2\n");
	}

	public void public_mixin() {
		protected_mixin_1();
		protected_mixin_2();

	}
}

class Maman.Baz : Object, Ibaz {
	public void do_action () {
		stdout.printf (" 2");
	}

	public virtual void do_virtual_action () {
		stdout.printf (" 4");
	}

	public void do_mixin() {
		public_mixin();
	}
}

class Maman.SubBaz : Baz {
	public override void do_virtual_action () {
		stdout.printf (" 6");
	}

	public static int main_func () {
		stdout.printf ("Interface Test: 1");

		Ibaz ibaz = new Baz ();
		ibaz.do_action ();
		ibaz.public_mixin();
		(ibaz as Baz).do_mixin();

		stdout.printf (" 3");

		ibaz.do_virtual_action ();

		stdout.printf (" 5");

		Ibaz subbaz = new SubBaz ();
		subbaz.do_virtual_action ();

		stdout.printf (" 7\n");

		subbaz.public_mixin();
		(subbaz as Baz).public_mixin();

		return 0;
	}
}

void main () {
	Maman.SubBaz.main_func ();
}

