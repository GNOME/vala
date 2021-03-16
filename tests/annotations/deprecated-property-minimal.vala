[CCode (has_type_id = false)]
[SimpleType]
struct Foo {
	void* _bar;
	[Version (deprecated = true)]
	public void* bar {
		get { return _bar; }
		set { _bar = value; }
	}
}

void main () {
}
