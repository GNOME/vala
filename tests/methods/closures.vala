delegate int Func ();

int A (int k, Func x1, Func x2, Func x3, Func x4, Func x5) {
	Func B = null;
	B = () => {
		k = k - 1;
		return A (k, B, x1, x2, x3, x4);
	};
	return k <= 0 ? x4 () + x5 () : B ();
}

void main () {
	int result = A (10, () => 1, () => -1, () => -1, () => 1, () => 0);
	assert (result == -67);
}

