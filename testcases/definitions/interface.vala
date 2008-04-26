
using GLib;

public interface Foo {
	public abstract int foo1 { private get; construct set; }
	public abstract int foo2 { get; set; }
	public abstract int foo3 { get; set; }

	public signal int bar1 ( );
	public signal int bar2 ( );
	public signal int bar3 ( );

	public int foobar1 ( ref StringBuilder foo, float dd = 0.3f ) { return 0; }
	public int foobar2 ( ) { return 0; }
	public int foobar3 ( ) { return 0; }
}
