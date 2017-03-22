delegate void FooFunc ();

class Foo : Object {
	bool check = false;

	FooFunc func = default_func;

	public Foo () {
	}

	void default_func () {
		check = true;
	}

	public void run () {
		func ();
		assert (check);
	}
}

void main(){
	var foo = new Foo ();
	foo.run ();
}
