interface Iface1 : Object {
	public abstract int foo ();
}

interface Iface2 : Object {
	public abstract int foo ();
}

class Obj1 : Object, Iface1, Iface2 {
	public int Iface1.foo () {
		return 1;
	}

	public int Iface2.foo () {
		return 2;
	}
}

class Obj2 : Object, Iface1, Iface2 {
	public int Iface1.foo () {
		return 1;
	}

	public int foo () {
		return 2;
	}
}

class Base : Object {
	public void foo () {
	}
}

interface Iface : Object {
	public abstract void foo ();
}

class Concrete : Base, Iface {
}

void main () {
	var obj1 = new Obj1 ();
	var iface1 = (Iface1) obj1;
	var iface2 = (Iface2) obj1;
	
	assert (iface1.foo () == 1);
	assert (iface2.foo () == 2);

	var obj2 = new Obj2 ();
	iface1 = (Iface1) obj2;
	iface2 = (Iface2) obj2;
	
	assert (iface1.foo () == 1);
	assert (iface2.foo () == 2);
}