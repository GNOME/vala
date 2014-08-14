public class Test<G,H> {
}

public void foo<T> (Test<T,int> t) {
}

public void bar<A,B> (Test<Test<A,B>,int> t) {
}

public T* baz<T> () {
	return null;
}

void main () {
	var f = new Test<int,int> ();
	foo (f);

	var g = new Test<Test<char,uint>,int> ();
	bar (g);

	int* i = baz ();
}
