class Foo {
	int lockable;

	public void explicit_unlocking () {
		lock (lockable);
		unlock (lockable);
	}

	public void implicit_unlocking () {
		lock (lockable) {
		}
	}
}

void main () {
	var foo = new Foo ();
	foo.explicit_unlocking ();
	foo.implicit_unlocking ();
}
