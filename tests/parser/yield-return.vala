class Foo {
	public async Foo () {
	}
}

async string foo () {
	return "foo";
}

async Foo bar () {
	return yield new Foo ();
}

async string baz () {
	return yield foo ();
}

void main () {
}
