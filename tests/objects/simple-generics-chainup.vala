class IntSequence : Sequence<int> {
}

class StringSequence : Sequence<string> {
}

class StringIntMap : HashTable<string, int> {
	public StringIntMap () {
		base (str_hash, str_equal);
	}
}

void main () {
	var iseq = new IntSequence ();
	iseq.append (1);

	var sseq = new StringSequence ();
	sseq.append ("foo");

	var map = new StringIntMap ();
	map["foo"] = 42;
	assert (map["foo"] == 42);
}
