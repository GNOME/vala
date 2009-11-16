public class Foo {
	public virtual async void do_foo () {
	}
}

public class Bar : Foo {
	public override async void do_foo () {
		yield base.do_foo ();
	}
}

void main () {
}
