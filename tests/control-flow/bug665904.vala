void main () {
	double?[] array = new double?[] { 3, 3, 3 };
	foreach (var i in array) {
		assert (i == 3);
	}
}
