void case_with_list () {
	int i = 1;
	switch (i) {
	case 0, 1, 2:
		break;
	default:
		assert_not_reached ();
	}
}

void main () {
	case_with_list ();
}
