void bar (ref string[] foo) {
	foo.resize (42);
}

void manam (out string[] foo) {
	foo = new string[23];
	foo.resize (42);
}

string[] boo;

void main () {
	{
		var foo = new string[23];
		foo.resize (42);
	}
	{
		var foo = new string[23];
		bar (ref foo);
	}
	{
		string[] foo;
		manam (out foo);
	}
	{
		boo = new string[23];
		boo.resize (42);
	}
}
