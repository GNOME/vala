public class Foo {
}

void main () {
	var foo = new Foo ();
	assert(foo !is Object);
	var bar = new Object ();
	assert(!(bar !is Object));
}
