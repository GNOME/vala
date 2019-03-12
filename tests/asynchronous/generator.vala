// This is based on Luca Bruno's Generator. It illustrates using async methods
// to emulate a generator style of iterator coding. Note that this runs fine
// without a main loop.

abstract class Generator<G> {
	bool consumed;
	unowned G value;
	SourceFunc callback;

	protected Generator () {
		helper.begin ();
	}

	async void helper () {
		yield generate ();
		consumed = true;
	}

	protected abstract async void generate ();

	protected async void feed (G value) {
		this.value = value;
		this.callback = feed.callback;
		yield;
	}

	public bool next () {
		return !consumed;
	}

	public G get () {
		var result = value;
		callback ();
		return result;
	}

	public Generator<G> iterator () {
		return this;
	}
}

class IntGenerator : Generator<int> {
	protected override async void generate () {
		for (int i = 0; i < 10; i++) {
			 if (i % 2 == 0)
			 	yield feed (i);
		}
	}
}

void main () {
	var gen = new IntGenerator ();
	string result = "";

	foreach (var item in gen)
		result += "%i ".printf (item);

	assert (result == "0 2 4 6 8 ");
}

