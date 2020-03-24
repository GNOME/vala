class IntSequence : Sequence<int> {
}

class StringSequence : Sequence<string> {
}

class StringIntMap : HashTable<string,int> {
	public StringIntMap () {
		base (str_hash, str_equal);
	}
}

void main () {
	{
		var seq = new IntSequence ();
		seq.append (23);
		assert (seq.get_begin_iter ().get () == 23);
	}
	{
		var seq = new StringSequence ();
		seq.append ("foo");
		assert (seq.get_begin_iter ().get () == "foo");
	}
	{
		var map = new StringIntMap ();
		map["foo"] = 42;
		assert (map["foo"] == 42);
	}
}
