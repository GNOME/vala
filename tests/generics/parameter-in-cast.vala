T manam<T> (T foo) {
	return foo;
}

bool get_bool () {
	return true;
}

T minim_b<T> () {
	return manam<T> (get_bool ());
}

uint32 get_uint32 () {
	return 23U;
}

T minim_u<T> () {
	return manam<T> (get_uint32 ());
}

string get_string () {
	return "bar";
}

T minim_s<T> () {
	return manam<T> (get_string ());
}

void main () {
	{
		assert (manam<bool> (get_bool ()) == true);
		assert (minim_b<bool> () == true);
	}
	{
		assert (manam<uint32> (get_uint32 ()) == 23U);
		assert (minim_u<uint32> () == 23U);
	}
	{
		assert (manam<string> (get_string ()) == "bar");
		assert (minim_s<string> () == "bar");
	}
}
