delegate void Func ();

void main () {
	var array = new int[10];
	Func foo = () => {
		assert (array.length == 10);
	};
	foo ();
}
