void main () {
	assert ("a" == "a");
	assert ("a" != "b");
	assert ("a" < "b");
	assert ("b" > "a");
	assert ("a" >= "a");
	assert ("b" >= "a");
	assert ("b" <= "b");
	assert ("a" <= "b");

	assert (null < "a");
	assert ("a" > null);
}
