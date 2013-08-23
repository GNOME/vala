delegate G DoSomething<G>(G g);

void do_something<G> (DoSomething<G> f) {}

enum TE {
	T;
	public void f() {
		do_something<TE> ((x) => {
			switch (this) {
			case T:
				return T;
			default:
				assert_not_reached ();
			}
        });
	}
	public void g(int i) {
		do_something<TE> ((x) => {
			switch (this) {
			case T:
				i++;
				return T;
			default:
				assert_not_reached ();
			}
		});
	}
}

class Test {
	public void f() {
		do_something<TE> (g);
		do_something<int> (h);
	}
	[CCode (instance_pos = -1)]
	private TE g(TE i) {
		return i;
	}
	[CCode (instance_pos = -1)]
	private int h(int i) {
		return i;
	}
}

int main() {
	TE t = TE.T;
	t.f ();
	t.g (0);
	Test t2 = new Test ();
	t2.f ();
	return 0;
}
