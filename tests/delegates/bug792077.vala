delegate void FooFunc (int i);
delegate FooFunc BarFunc ();

int result = 0;

void main () {
	BarFunc func_gen = () => {
		return (data) => {
			result = data;
		};
	};

	FooFunc func = func_gen ();
	func (42);
	assert (result == 42);
}
