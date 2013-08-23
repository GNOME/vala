delegate G DoSomething<G>(G g);

void do_something<G> (DoSomething<G> f) {}

enum TE {
	T
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
	Test t2 = new Test ();
	t2.f ();
	return 0;
}
