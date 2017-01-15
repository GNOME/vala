int i = 0;

async void run () {
	while (true) {
		string foo;
		if (i == 0) {
			foo = "foo";
			i++;
		} else {
			break;
		}
	}
}

void main() {
	var loop = new MainLoop ();
	Idle.add (() => {
		run.begin ();
		loop.quit ();
		return false;
	});
	loop.run ();
}
