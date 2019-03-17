static int counter = 0;

static async void foo () {
	counter++;
	assert (counter <= 1);

	// This is the simplest way to trigger the issue,
	// it may happen due to GTask/ThreadPool/threads
	// getting to call the callback before yield, too.
	foo.callback ();
	yield;
}

void main () {
	foo.begin ();
}
