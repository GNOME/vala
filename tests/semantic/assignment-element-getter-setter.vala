[Compact]
public class Foo<G> {
	public G[] elements;

	public Foo () {
		elements = new G[] { null };
	}

	public G get (int idx) {
		return elements[idx];
	}

	public void set (int idx, G val) {
		elements[idx] = val;
	}
}

void main () {
	var foo = new Foo<int> ();

	foo[0] = 23;
	assert (foo[0] == 23);

	foo[0] += 42;
	assert (foo[0] == 65);

	foo[0] *= 2;
	assert (foo[0] == 130);

	foo[0] /= 5;
	assert (foo[0] == 26);

	foo[0] -= 4711;
	assert (foo[0] == -4685);
}
