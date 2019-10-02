public delegate unowned string Manam ();

public class Foo {
	public Manam deleg { get; set; }

	public virtual Manam deleg_v { get; set; }

	[CCode (delegate_target = false)]
	public Manam deleg_no_target { get; set; }

	[CCode (delegate_target = false)]
	public virtual Manam deleg_no_target_v { get; set; }
}

public class Bar : Object {
	[CCode (delegate_target = false)]
	public Manam deleg { get; set; }

	[CCode (delegate_target = false)]
	public virtual Manam deleg_v { get; set; }
}

unowned string manam () {
	return "manam";
}

void main () {
	{
		var foo = new Foo ();

		foo.deleg = (Manam) manam;
		assert (foo.deleg () == "manam");
		foo.deleg_v = (Manam) manam;
		assert (foo.deleg_v () == "manam");

		foo.deleg_no_target = (Manam) manam;
		assert (foo.deleg_no_target () == "manam");
		foo.deleg_no_target_v = (Manam) manam;
		assert (foo.deleg_no_target_v () == "manam");
	}
	{
		var bar = new Bar ();
		bar.deleg = (Manam) manam;
		assert (bar.deleg () == "manam");
		bar.deleg_v = (Manam) manam;
		assert (bar.deleg_v () == "manam");

		Manam func;
		bar.get ("deleg", out func);
		assert (func () == "manam");
		bar.get ("deleg-v", out func);
		assert (func () == "manam");
	}
}
