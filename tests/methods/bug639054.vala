[Compact]
public class Baz {
}

public async void foo (uint8[] bar, Baz baz) {
	SourceFunc f = () => {
		bar[0] = 'b';
		baz = null;
		return false;
	};
	f ();
}

void main () {
	var loop = new MainLoop ();
	var bar = "foo".data;
	foo.begin (bar, new Baz (), () => {
		assert (bar[0] == 'b');
		loop.quit ();
	});
	loop.run ();
}
