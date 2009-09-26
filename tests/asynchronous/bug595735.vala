public abstract class Foo {
	public abstract async void do_foo ();
}

public class Bar : Foo {
	public override async void do_foo () {
	}
}

void main () {
}
