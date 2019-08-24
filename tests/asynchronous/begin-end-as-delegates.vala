[CCode (has_target = false)]
delegate void FooBegin (int i, AsyncReadyCallback cb);
[CCode (has_target = false)]
delegate int FooEnd (AsyncResult res, out string s);

async int foo (int i, out string s) {
	s = "foo";
	return i;
}

delegate void BarBegin (int i, AsyncReadyCallback cb);
delegate int BarEnd (AsyncResult res, out string s);

class Bar {
	public async int bar (int i, out string s) {
		s = "bar";
		return i;
	}
}

MainLoop loop;

int count = 2;

void main () {
	loop = new MainLoop ();

	{
		FooBegin begin = foo.begin;
		FooEnd end = foo.end;

		begin (23, (o,a) => {
			string s;
			assert (end (a, out s) == 23);
			assert (s == "foo");

			count--;
			if (count <= 0)
				loop.quit ();
			}
		});
	}

	{
		var bar = new Bar ();
		BarBegin begin = bar.bar.begin;
		BarEnd end = bar.bar.end;

		begin (42, (o,a) => {
			string s;
			assert (end (a, out s) == 42);
			assert (s == "bar");

			count--;
			if (count <= 0)
				loop.quit ();
			}
		});
	}

	loop.run ();
}
