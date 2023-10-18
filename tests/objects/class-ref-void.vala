[Compact]
[CCode (ref_function = "foo_ref", unref_function = "foo_unref", ref_function_void = true)]
public class Foo {
	public void ref () {
	}
	public void unref () {
	}
}

void bar<G> (G g) {
	var foo = G.dup (g);
	G.destroy (foo);
}

void main () {
	bar<Foo> (new Foo ());
}
