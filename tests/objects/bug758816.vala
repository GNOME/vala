enum Bar {
	FAIL,
	FOO,
	BAR,
	BAZ
}

public struct Manam {
	public int i;
	public int j;
}

class Foo : Object {
	public signal Bar? bar ();
	public signal Bar? bar2 (Bar? bar);

	public signal Manam? manam ();
	public signal Manam? manam2 (Manam? manam);

	public void emit_bar () {
		assert (bar () == Bar.FOO);
	}

	public void emit_bar2 () {
		assert (bar2 (Bar.BAZ) == Bar.BAZ);
	}

	public void emit_manam () {
		Manam? m = {23, 42};
		assert (manam () == m);
	}

	public void emit_manam2 () {
		Manam? m = {23, 42};
		assert (manam2 ({23, 42}) == m);
	}
}

Bar? callback_bar () {
	return Bar.FOO;
}

Bar? callback_bar2 (Bar? bar) {
	assert (bar == Bar.BAZ);
	return bar;
}

Manam? callback_manam () {
	return {23, 42};
}

Manam? callback_manam2 (Manam? manam) {
	Manam? m = {23, 42};
	assert (manam == m);
	return manam;
}

void main () {
	var foo = new Foo ();

	foo.bar.connect (callback_bar);
	foo.emit_bar ();
	foo.bar2.connect (callback_bar2);
	foo.emit_bar2 ();

	foo.manam.connect (callback_manam);
	foo.emit_manam ();
	foo.manam2.connect (callback_manam2);
	foo.emit_manam2 ();
}
