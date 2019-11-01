delegate void FooFunc ();

class Foo<G> : Object {
	public Foo () {
		assert (typeof (G) == typeof (string));
		assert (G.dup == (BoxedCopyFunc) string.dup);
		assert (G.destroy == (DestroyNotify) free);

		G g = null;
		assert (g.dup == (BoxedCopyFunc) string.dup);
		assert (g.destroy == (DestroyNotify) free);
	}

	public void foo () {
		assert (typeof (G) == typeof (string));
		assert (G.dup == (BoxedCopyFunc) string.dup);
		assert (G.destroy == (DestroyNotify) free);

		G g = null;
		assert (g.dup == (BoxedCopyFunc) string.dup);
		assert (g.destroy == (DestroyNotify) free);
	}

	public async void foo_async () {
		assert (typeof (G) == typeof (string));
		assert (G.dup == (BoxedCopyFunc) string.dup);
		assert (G.destroy == (DestroyNotify) free);

		G g = null;
		assert (g.dup == (BoxedCopyFunc) string.dup);
		assert (g.destroy == (DestroyNotify) free);
	}

	public void foo_captured () {
		FooFunc f = () => {
			assert (typeof (G) == typeof (string));
			assert (G.dup == (BoxedCopyFunc) string.dup);
			assert (G.destroy == (DestroyNotify) free);

			G g = null;
			assert (g.dup == (BoxedCopyFunc) string.dup);
			assert (g.destroy == (DestroyNotify) free);
		};
		f ();
	}
}

void bar<T> (T t) {
	assert (typeof (T) == typeof (Foo));
	assert (T.dup == (BoxedCopyFunc) Object.@ref);
	assert (T.destroy == (DestroyNotify) Object.unref);

	assert (t.dup == (BoxedCopyFunc) Object.@ref);
	assert (t.destroy == (DestroyNotify) Object.unref);
}

async void bar_async<T> (T t) {
	assert (typeof (T) == typeof (Foo));
	assert (T.dup == (BoxedCopyFunc) Object.@ref);
	assert (T.destroy == (DestroyNotify) Object.unref);

	assert (t.dup == (BoxedCopyFunc) Object.@ref);
	assert (t.destroy == (DestroyNotify) Object.unref);
}

void bar_captured<T> (T t) {
	FooFunc f = () => {
		assert (typeof (T) == typeof (Foo));
		assert (T.dup == (BoxedCopyFunc) Object.@ref);
		assert (T.destroy == (DestroyNotify) Object.unref);

		assert (t.dup == (BoxedCopyFunc) Object.@ref);
		assert (t.destroy == (DestroyNotify) Object.unref);
	};
	f ();
}

void main () {
	var foo = new Foo<string> ();

	foo.foo ();
	foo.foo_async.begin ();
	foo.foo_captured ();

	bar<Foo> (foo);
	bar_async<Foo>.begin (foo);
	bar_captured<Foo> (foo);
}
