void main () {
	var i = (int?) int.MIN;
	assert (i == int.MIN);

	var u = (uint?) uint.MAX;
	assert (u == uint.MAX);

	var i64 = (int64?) int64.MIN;
	assert (i64 == int64.MIN);

	var u64 = (uint64?) uint64.MAX;
	assert (u64 == uint64.MAX);
}
