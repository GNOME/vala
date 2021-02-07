void foo<G,T> (G g, T t) {
	assert ((int64?) g == int64.MIN);
	assert ((uint64?) t == uint64.MAX);
}

void bar<G,T> (G g, T t) {
	assert ((int?) g == int.MIN);
	assert ((uint?) t == uint.MAX);
	assert ((int) ((int?) g) == int.MIN);
	assert ((uint) ((uint?) t) == uint.MAX);
}

void main () {
	foo ((int64?) int64.MIN, (uint64?) uint64.MAX);
	foo<int64?,uint64?> ((int64?) int64.MIN, (uint64?) uint64.MAX);
	bar ((int?) int.MIN, (uint?) uint.MAX);
	bar<int?,uint?> ((int?) int.MIN, (uint?) uint.MAX);
}
