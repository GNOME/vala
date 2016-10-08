delegate void Func ();

void do_bar (Func f) {
}

Object do_foo () {
	var result = new Object ();

	do_bar (() => {
		var v = result;
	});

	return result;
}

void main () {
	do_foo ();
}
