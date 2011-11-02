class Foo {
	void foo<T> () {
		T retval = null;
		GLib.SourceFunc f = () => {
			retval = null;
			return false;
		};
	}
}

void main () {
}
