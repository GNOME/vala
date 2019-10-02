public struct Manam {
	public int i;
}

public class Foo {
	public Manam?[] array { get; set; }

	public virtual Manam?[] array_v { get; set; }

	[CCode (array_length = false, array_null_terminated = true)]
	public Manam?[] array_no_length { get; set; }

	[CCode (array_length = false, array_null_terminated = true)]
	public virtual Manam?[] array_no_length_v { get; set; }

	[CCode (array_length = false, array_null_terminated = true)]
	public string[] strv { set; get; }

	[CCode (array_length = false, array_null_terminated = true)]
	public virtual string[] strv_v { set; get; }
}

public class Bar : Object {
	[CCode (array_length = false, array_null_terminated = true)]
	public Manam?[] array { get; set; }

	[CCode (array_length = false, array_null_terminated = true)]
	public virtual Manam?[] array_v { get; set; }

	[CCode (array_length = false, array_null_terminated = true)]
	public string[] strv { set; get; }

	[CCode (array_length = false, array_null_terminated = true)]
	public virtual string[] strv_v { set; get; }
}

void main () {
	Manam?[] manam = { Manam () { i = 23 }, Manam () { i = 42 }, null };
	string[] minim = { "foo", "bar", null };

	{
		var foo = new Foo ();

		foo.array = manam;
		assert (foo.array[0].i == 23);
		foo.array_v = manam;
		assert (foo.array_v[1].i == 42);

		foo.array_no_length = manam;
		assert (foo.array_no_length[0].i == 23);
		foo.array_no_length_v = manam;
		assert (foo.array_no_length_v[1].i == 42);

		foo.strv = minim;
		assert (foo.strv[0] == "foo");
		foo.strv_v = minim;
		assert (foo.strv_v[1] == "bar");
	}
	{
		var bar = new Bar ();

		bar.array = manam;
		assert (bar.array[0].i == 23);
		bar.array_v = manam;
		assert (bar.array_v[1].i == 42);

		bar.strv = minim;
		assert (bar.strv[0] == "foo");
		bar.strv_v = minim;
		assert (bar.strv_v[1] == "bar");

		unowned Manam?[] res;
		bar.get ("array", out res);
		assert (res[0].i == 23);
		bar.get ("array-v", out res);
		assert (res[1].i == 42);

		unowned string[] strv;
		bar.get ("strv", out strv);
		assert (strv[0] == "foo");
		bar.get ("strv-v", out strv);
		assert (strv[1] == "bar");
	}
}
