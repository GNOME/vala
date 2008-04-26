
using GLib;

public class Foo : Object {
	public int foo1;
	public int foo2;
	public int foo3;

	public int bar4 { get; set; }
	public int bar5 { get { return 0; } }
	public int bar6 { private get; set; }

	public signal int foobar1 ( int foo );
	public signal int foobar2 ( int foo );
	private signal int foobar3 ( int foo );

	public Foo ( ) {}
	public Foo.foo ( ) {}
	public Foo.foo1 ( int bar4 ) {}

	public int foobaz1 ( int foo = 9 ) { return 0; }
	public int foobaz2 () { return 0; }
	public int foobaz3 () { return 0; }
}


