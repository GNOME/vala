delegate void Func ();

MainLoop main_loop;

async void foo () {
	string bar = "hello";
	Func foobar = () => {
		bar = "world";
	};
	foobar ();
	assert (bar == "world");

	Idle.add (foo.callback);
	yield;

	main_loop.quit ();
}

void main () {
	foo.begin ();

        main_loop = new MainLoop (null, false);
        main_loop.run ();
}

