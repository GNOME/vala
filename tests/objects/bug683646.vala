delegate void Func ();

void foo (Object a, Object? b = null) {
	b = a;

	Func sub = () => {
		var c = a;
		var d = b;
	};
}

void main () {
	foo (new Object ());
}
