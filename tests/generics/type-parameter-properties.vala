class Foo<G> : Object {
}

class Bar<T> : Foo<T> {
}

void main () {
	var bar = new Bar<string> ();
	{
		Type type;
		BoxedCopyFunc dup_func;
		DestroyNotify destroy_func;

		bar.get ("t-type", out type, "t-dup-func", out dup_func, "t-destroy-func", out destroy_func);
		assert (type == typeof(string));
		assert (dup_func == (BoxedCopyFunc) string.dup);
		assert (destroy_func == (DestroyNotify) free);
	}
	{
		Type type;
		BoxedCopyFunc dup_func;
		DestroyNotify destroy_func;

		bar.get ("g-type", out type, "g-dup-func", out dup_func, "g-destroy-func", out destroy_func);
		assert (type == typeof(string));
		assert (dup_func == (BoxedCopyFunc) string.dup);
		assert (destroy_func == (DestroyNotify) free);
	}
}
