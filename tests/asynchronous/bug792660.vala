abstract class Foo {
	public abstract async void foo ([CCode (array_length = false)] string[] a, int i);
}

class Bar : Foo {
	public override async void foo (string[] a, int i) {
		assert (i == 42);
	}
}

void main () {
	string[] a = { "foo", "bar" };
	var bar = new Bar ();
	bar.foo.begin (a, 42);
}
