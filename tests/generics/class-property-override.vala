public abstract class Foo<G> : Object {
	public abstract G foo { get; set; }
}

public class Bar : Foo<string> {
	public override string foo { get; set; }
}

public class Manam : Foo<int> {
	public override int foo { get; set; }
}

void main () {
	var bar = new Bar ();
	bar.foo = "foo";
	assert (bar.foo == "foo");

	var manam = new Manam ();
	manam.foo = 42;
	assert (manam.foo == 42);
}
