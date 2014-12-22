string foo = null;

(unowned string)[] bar () {
	(unowned string)[] ret = new (unowned string)[1];
	ret[0] = foo;
	return ret;
}

void main() {
	foo = "foo";
	
	string[] keys = bar();
	foo = null;
	
	foreach (unowned string k in keys) {
		assert (k == "foo");
	}
}