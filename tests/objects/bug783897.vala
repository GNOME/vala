enum Baz {
	VALUE = 42;
}

struct Bar {
	public int i;
}

class Foo {
	public signal void signal_enum (Baz? e);
	public signal void signal_simple_type (int? t);
	public signal void signal_struct (Bar? s);
	public signal void signal_custom (Foo f, Baz? e, int? t, Bar? s);
	public signal void signal_custom2 (Foo f, Baz e, int t, Bar s);

	public void run () {
		signal_enum (Baz.VALUE);
		signal_simple_type (23);
		signal_struct ({ 4711 });
		signal_custom (this, Baz.VALUE, 23, { 4711 });
		signal_custom2 (this, Baz.VALUE, 23, { 4711 });
	}
}

void callback_enum (Baz? e) {
	assert (e == Baz.VALUE);
}

void callback_simple_type (int? t) {
	assert (t == 23);
}

void callback_struct (Bar? s) {
	assert (s.i == 4711);
}

void callback_custom (Foo f, Baz? e, int? t, Bar? s) {
	assert (e == Baz.VALUE);
	assert (t == 23);
	assert (s.i == 4711);
}

void callback_custom2 (Foo f, Baz e, int t, Bar s) {
	assert (e == Baz.VALUE);
	assert (t == 23);
	assert (s.i == 4711);
}

void main() {
	var foo = new Foo ();
	foo.signal_enum.connect (callback_enum);
	foo.signal_simple_type.connect (callback_simple_type);
	foo.signal_struct.connect (callback_struct);
	foo.signal_custom.connect (callback_custom);
	foo.signal_custom2.connect (callback_custom2);
	foo.run ();
}
