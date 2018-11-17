public class Foo {
	protected int thing_to_lock_on;
	public int other_variable;

	public Foo () {
		other_variable = 0;
	}

	public void run () {
		lock (thing_to_lock_on) {
			other_variable = 1;
		}
	}
}

public class Bar {
	protected class int thing_to_lock_on;
	public int other_variable;

	public Bar () {
		other_variable = 0;
	}

	public void run () {
		lock (thing_to_lock_on) {
			other_variable = 1;
		}
	}
}

void main () {
}
