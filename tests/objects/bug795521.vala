class Foo {
	[CCode (cname = "faz")]
	public int foo;
	[CCode (cname = "baz")]
	public class int boo;
	[CCode (cname = "maz")]
	public static int moo;

	public int foor;
	public class int boor;
	public static int moor;

	public int foop { get; set; }

	public void use () {
		lock (foo) {
		}

		lock (boo) {
		}

		lock (moo) {
		}

		lock (foor) {
		}

		lock (boor) {
		}

		lock (moor) {
		}

		lock (foop) {
		}
	}
}

void main () {
}
