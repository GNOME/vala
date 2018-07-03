[SingleInstance]
public class Foo : Object {
	public int bar = 42;
	construct {
	}
}

[SingleInstance]
public class Bar : Object {
	public int foo = 42;
}

void lifetime_1 () {
	Foo a = new Foo ();
	Foo b = (Foo) Object.new (typeof (Foo));

	assert (a == b);
	assert (a.bar == 23);
}

void lifetime_2 () {
	Foo a = new Foo ();
	Foo b = (Foo) Object.new (typeof (Foo));

	assert (a == b);
	assert (a.bar == 42);
}

void lifetime_3 () {
	Bar a = new Bar ();
	Bar b = (Bar) Object.new (typeof (Bar));

	assert (a == b);
	assert (a.foo == 23);
}

void main () {
	{
		// create singleton instance here
		// which lives as long until it runs out of scope
		Foo singleton = new Foo ();
		singleton.bar = 23;
		lifetime_1 ();
	}

	{
		// create new singleton instance here
		Foo singleton = new Foo ();
		assert (singleton.bar == 42);
		lifetime_2 ();
	}

	{
		// create singleton instance here
		Bar singleton = new Bar ();
		singleton.foo = 23;
		lifetime_3 ();
	}
}
