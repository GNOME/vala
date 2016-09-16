void bar ((unowned string)[] str) {
}

void foo () {
	unowned string s1 = "ABC", s2 = "CDE";
	bar ({s1, s2});
	var s3 = "%s%s".printf (s1, s2);
}

void main () {
	foo ();
}
