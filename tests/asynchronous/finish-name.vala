public class Foo {
	[CCode (finish_name = "foo_new_end")]
	public async Foo.async () {
	}

	[CCode (finish_name = "foo_bar_end")]
	public async string bar () {
		return "bar";
	}
	[CCode (finish_name = "foo_baz_end", finish_vfunc_name = "baz_end")]
	public virtual async string baz () {
		return "baz";
	}
}

public class Bar : Foo {
	[CCode (finish_name = "bar_baz_end")]
	public override async string baz () {
		return "baz_bar";
	}
}

[CCode (finish_name = "manam_end")]
public async string manam () {
	return "manam";
}

MainLoop loop;

void main () {
	loop = new MainLoop ();

	var foo = new Foo ();
	foo.bar.begin ((o,r) => {
		var res = foo.bar.end (r);
		assert (res == "bar");
	});
	foo.baz.begin ((o,r) => {
		var res = foo.baz.end (r);
		assert (res == "baz");
	});

	var bar = new Bar ();
	bar.baz.begin ((o,r) => {
		var res = bar.baz.end (r);
		assert (res == "baz_bar");
	});

	manam.begin ((o,r) => {
		var res = manam.end (r);
		assert (res == "manam");
		loop.quit ();
	});

	loop.run ();
}
