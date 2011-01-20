delegate void Func ();

MainLoop main_loop;

async void foo (string baz) {
	string bar = "hello";
	Func foobar = () => {
		bar = baz;
	};
	foobar ();
	assert (bar == "world");

	Idle.add (foo.callback);
	yield;

	main_loop.quit ();
}

void main () {
	foo.begin ("world");

        main_loop = new MainLoop (null, false);
        main_loop.run ();
}

