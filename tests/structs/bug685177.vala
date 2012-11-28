void non_nullable (Value v1, ref Value v2, out Value v3) {
	v3 = v2;
	v2 = v1;
}

void nullable (Value? v1, ref Value? v2, out Value? v3) {
	v3 = v2;
	v2 = null;
}

void main () {
	Value v1 = 1;
	Value v2 = 2;
	Value v3;
	non_nullable (v1, ref v2, out v3);
	assert ((int)v1 == 1);
	assert ((int)v2 == 1);
	assert ((int)v3 == 2);

	Value? v4 = 4;
	Value? v5 = 5;
	Value? v6 = 6;
	non_nullable (v4, ref v5, out v6);
	assert ((int)v4 == 4);
	assert ((int)v5 == 4);
	assert ((int)v6 == 5);

	v4 = 4;
	v5 = 5;
	v6 = 6;
	nullable (v4, ref v5, out v6);
	assert ((int)v4 == 4);
	assert (v5 == null);
	assert ((int)v6 == 5);
}
