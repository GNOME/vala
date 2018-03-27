class FObject : Object {
}

struct FStruct {
	public int i;
}

class Foo : Object {
	public string s { get; set; }
	public unowned string[] a { get; set; }
	public int i { get; set; }
	public FObject o { get; set; }
	public FStruct t { get; set; }
	public void* p { get; set; }

	public int foo { get { return i; } }
	public int bar { set { i = value; } }

	public Foo () {
	}
}

void main () {
	var s = "bar";
	string[] a = { "foo", "baz" };
	var i = 42;
	var o = new FObject ();
	FStruct t = {};
	void* p = &o;

	var foo = new Foo ();
	foo.s = s;
	foo.a = a;
	foo.i = i;
	foo.o = o;
	foo.t = t;
	foo.p = p;

	foo.notify["s"].connect (() => error ("string-type equality failed"));
	foo.notify["a"].connect (() => error ("array-type equality failed"));
	foo.notify["i"].connect (() => error ("simple-type equality failed"));
	foo.notify["o"].connect (() => error ("object-type equality failed"));
	foo.notify["t"].connect (() => error ("struct-type equality failed"));
	foo.notify["p"].connect (() => error ("pointer-type equality failed"));

	foo.s = s;
	foo.a = a;
	foo.i = i;
	foo.o = o;
	foo.t = t;
	foo.p = p;
}

