delegate void FooFunc ();

void foo ([CCode (scope = "async")] owned FooFunc f) {
	f ();
}

[CCode (scope = "async")]
delegate void BarFunc ();

void bar (owned BarFunc f) {
	f ();
}

void main () {
	{
		int i = 0;
		foo (() => {
			i++;
		});
		assert (i == 1);
	}
	{
		int j = 0;
		bar (() => {
			j++;
		});
		assert (j == 1);
	}
}
