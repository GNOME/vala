class Foo : Object {
	public signal void bar ();

	public async void do_foo () {
		bar.connect (() => {
		});
	}
}

void main () {
}
