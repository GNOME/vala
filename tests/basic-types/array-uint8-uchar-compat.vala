[CCode (array_length = false)]
uchar[] data;
[CCode (array_length = false)]
uint8[] data2;

[CCode (array_length = false)]
unowned uchar[] get_buffer () {
	return data;
}

void change_buffer ([CCode (array_length = false)] uint8[] data) {
	data[0] = 98;
	data[1] = 97;
	data[2] = 114;
}

[CCode (array_length = false)]
unowned uint8[] get_buffer2 () {
	return data2;
}

void change_buffer2 ([CCode (array_length = false)] uchar[] data) {
	data[0] = 'b';
	data[1] = 'a';
	data[2] = 'z';
}

void main () {
	{
		data = { 'f', 'o', 'o', '\n', '\0' };
		data2 = { 102, 111, 111, 10, 0 };
		assert ("foo\n" == (string) data);
		change_buffer (get_buffer ());
		assert ("bar\n" == (string) data);
		change_buffer (get_buffer2 ());
		assert ("bar\n" == (string) data2);
		assert ((string) data == (string) data2);
	}

	{
		data = { 'f', 'o', 'o', '\n', '\0' };
		data2 = { 102, 111, 111, 10, 0 };
		assert ("foo\n" == (string) data2);
		change_buffer2 (get_buffer2 ());
		assert ("baz\n" == (string) data2);
		change_buffer2 (get_buffer ());
		assert ("baz\n" == (string) data);
		assert ((string) data == (string) data2);
	}
}
