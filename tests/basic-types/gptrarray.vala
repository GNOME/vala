class Foo : Object {
	public int i;
	public Foo (int i) {
		this.i = i;
	}
}

int compare_foo (Foo a, Foo b) {
	return b.i - a.i;
}

void main () {
	var foo1 = new Foo (5);
	var foo2 = new Foo (4);
	var foo3 = new Foo (3);
	var foo4 = new Foo (2);
	var foo5 = new Foo (1);

	{
		var array = new GenericArray<Foo> (8);
		array.add (foo1);
		assert (foo1.ref_count == 2);
		array.add (foo2);
		assert (foo2.ref_count == 2);
		array.add (foo3);
		assert (foo3.ref_count == 2);
		assert (array.length == 3);

		int loop_size = 0;
		foreach (weak Foo element in array) {
			loop_size++;
			assert (element.ref_count == 2);
			switch (loop_size) {
				case 1: assert (element == foo1); break;
				case 2: assert (element == foo2); break;
				case 3: assert (element == foo3); break;
			}
		}
		assert (loop_size == 3);

		loop_size = 0;
		foreach (Foo element in array) {
			loop_size++;
			assert (element.ref_count == 3);
			switch (loop_size) {
				case 1: assert (element == foo1); break;
				case 2: assert (element == foo2); break;
				case 3: assert (element == foo3); break;
			}
		}
		assert (loop_size == 3);

		assert (foo2 == array.get (1));
		array.set (1, foo4);
		assert (foo4 == array.get (1));
		assert (foo2.ref_count == 1);
		assert (foo4.ref_count == 2);
		assert (array.length == 3);

		array.insert (2, foo5);
		assert (foo5.ref_count == 2);
		assert (array.length == 4);

		assert (array.remove (foo4));
		assert (foo4.ref_count == 1);
		assert (array.length == 3);

		uint index;
		assert (array.find (foo5, out index));
		assert (foo5.ref_count == 2);
		assert (index == 1);
		assert (array.length == 3);

		array.sort (compare_foo);
		array.sort_with_data (compare_foo);

		assert (array.length == 3);
		array.length = 0;
		assert (array.length == 0);
	}

	assert (foo1.ref_count == 1);
	assert (foo2.ref_count == 1);
	assert (foo3.ref_count == 1);
	assert (foo4.ref_count == 1);
	assert (foo5.ref_count == 1);

	{
		var array = new GenericArray<weak Foo> (8);
		array.add (foo1);
		assert (foo1.ref_count == 1);
		array.add (foo2);
		assert (foo2.ref_count == 1);
		array.add (foo3);
		assert (foo3.ref_count == 1);
		assert (array.length == 3);

		int loop_size = 0;
		foreach (weak Foo element in array) {
			loop_size++;
			assert (element.ref_count == 1);
			switch (loop_size) {
				case 1: assert (element == foo1); break;
				case 2: assert (element == foo2); break;
				case 3: assert (element == foo3); break;
			}
		}
		assert (loop_size == 3);

		loop_size = 0;
		foreach (Foo element in array) {
			loop_size++;
			assert (element.ref_count == 2);
			switch (loop_size) {
				case 1: assert (element == foo1); break;
				case 2: assert (element == foo2); break;
				case 3: assert (element == foo3); break;
			}
		}
		assert (loop_size == 3);

		assert (foo2 == array.get (1));
		array.set (1, foo4);
		assert (foo4 == array.get (1));
		assert (foo2.ref_count == 1);
		assert (foo4.ref_count == 1);
		assert (array.length == 3);

		array.insert (2, foo5);
		assert (foo5.ref_count == 1);
		assert (array.length == 4);

		assert (array.remove (foo4));
		assert (foo4.ref_count == 1);
		assert (array.length == 3);

		uint index;
		assert (array.find (foo5, out index));
		assert (foo5.ref_count == 1);
		assert (index == 1);
		assert (array.length == 3);

		array.sort (compare_foo);
		array.sort_with_data (compare_foo);

		assert (array.length == 3);
		array.length = 0;
		assert (array.length == 0);
	}

	assert (foo1.ref_count == 1);
	assert (foo2.ref_count == 1);
	assert (foo3.ref_count == 1);
	assert (foo4.ref_count == 1);
	assert (foo5.ref_count == 1);
}
