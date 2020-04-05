[DBus (name = "org.example.Test")]
public interface Foo : GLib.Object {
	private signal void test1 ();
	public signal void test2 ();
	public signal void test3 (int[] test);
}

void main () {
	
}
