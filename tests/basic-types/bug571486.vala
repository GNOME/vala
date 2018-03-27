public unowned (unowned string)[] var1 = null;
public (unowned string)[] var2 = null;

class Foo {
	public (unowned string)[] var3 = null;

	public (unowned string)[] meth ((unowned string)[] var4) {
		var3 = ((unowned string)[]) var4;
		return ((unowned string)[]) var3;
	}
}

void main () {
	Object o1 = new Object ();
	Object o2 = new Object ();

	(unowned Object)[] test = new (unowned Object)[] { o1 };
	assert (o1.ref_count == 1);
	test[0] = o2;
	assert (o1.ref_count == 1);
	assert (o2.ref_count == 1);

	test = null;
	assert (o1.ref_count == 1);
	assert (o2.ref_count == 1);

	int[] i = new int[42];
    int j = (((int*) i)[4] + 5);
}