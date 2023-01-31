bool get_bool () {
	return true;
}

T minim_b<T> () {
	return get_bool ();
}

uint32 get_uint32 () {
	return 42U;
}

T minim_u<T> () {
	return get_uint32 ();
}

string get_string () {
	return "bar";
}

T minim_s<T> () {
	return get_string ();
}

void main () {
	{
		assert (minim_b<bool> () == true);
	}
	{
		assert (minim_u<uint32> () == 42U);
	}
	{
		assert (minim_s<string> () == "bar");
	}
}
