void main () {
	string[] array = { "foo", "bar", "manam" };
	foreach (string s in array) {
	}
	foreach (unowned string s in array) {
	}
	foreach (var s in array) {
	}
	foreach (unowned var s in array) {
	}
}
