delegate G DoSomething<G>(G g);

void do_something<G> (DoSomething<G> f) {}

enum TestEnum {
	T;
	public void f() {
		do_something<TestEnum> ((x) => {
			switch (this) {
			case T:
				return T;
			default:
				assert_not_reached ();
			}
        });
	}
	public void g(int i) {
		do_something<TestEnum> ((x) => {
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
		do_something<TestEnum> (g);
		do_something<int> (h);
	}
	[CCode (instance_pos = -1)]
	private TestEnum g(TestEnum i) {
		return i;
	}
	[CCode (instance_pos = -1)]
	private int h(int i) {
		return i;
	}
}

int main() {
	TestEnum t = TestEnum.T;
	t.f ();
	t.g (0);
	Test t2 = new Test ();
	t2.f ();
	return 0;
}
