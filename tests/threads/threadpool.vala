bool success = false;

void main () {
	try {
		var pool = new ThreadPool<string>.with_owned_data ((s) => {
			assert (s == "foo" || s == "bar");
			success = true;
		}, 2, true);
		pool.add ("foo");
		pool.add ("bar");
	} catch {
		assert_not_reached ();
	}
	assert (success);
}
