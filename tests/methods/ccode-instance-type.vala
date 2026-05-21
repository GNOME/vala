public class Foo : Object {
	[CCode (instance_type = "GObject*")]
	public bool is_same (Object o) {
		return this == o;
	}

	[CCode (instance_type = "GObject*")]
	public int answer () {
		return 42;
	}
}

public struct Bar {
	public int i;

	[CCode (instance_type = "gpointer")]
	public int get_answer () {
		return 42;
	}
}

void main () {
	var foo = new Foo ();
	assert (foo.is_same (foo));
	assert (!foo.is_same (new Object ()));
	assert (foo.answer () == 42);

	var bar = Bar ();
	assert (bar.get_answer () == 42);
}
