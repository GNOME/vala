void main() {
	int8 test1 = -128;
	int8 test2 = +127;

	/* 64-bit integer literals */
	assert(0x80000000 == 0x80000000ll);
	assert(-0x80000001 == -0x80000001ll);
}
