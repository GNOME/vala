[CCode (async_result_pos = 2.1)]
async void foo (int in_i, out int out_i) {
	out_i = in_i;
}

[CCode (async_result_pos = 2.1)]
async void bar (int in_i, out int out_i) throws Error {
	out_i = in_i;
}

async void run () {
	int i;
	yield foo (323, out i);
	assert (i == 323);
	try {
		yield bar (742, out i);
		assert (i == 742);
	} catch {
		assert_not_reached ();
	}
	loop.quit ();
}

MainLoop loop;

void main () {
	loop = new MainLoop ();

	foo.begin (23, (o,r) => {
		int i;
		foo.end (r, out i);
		assert (i == 23);
	});

	bar.begin (42, (o,r) => {
		try {
			int i;
			bar.end (r, out i);
			assert (i == 42);
		} catch {
			assert_not_reached ();
		}
	});

	run.begin ();

	loop.run ();
}
