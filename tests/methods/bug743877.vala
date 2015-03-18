void main () {
	Intl.setlocale ();

	string[] charsets;
	var is_utf8 = GLib.get_filename_charsets (out charsets);

	assert (charsets.length != -1);
}

