public class Foo {
	[CCode (array_length_cname = "length")]
	public int[] bar;
}

void main () {
	var foo = new Foo ();
	foo.bar = new int[10];
}
