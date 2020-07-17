[CCode (cname = "g_strdup", cheader_filename = "glib.h")]
extern string strdup (string s);

[CCode (cname = "vala_some_thing")]
extern void some_thing ();

namespace Foo {
	[CCode (cname = "g_strdup", cheader_filename = "glib.h")]
	extern string strdup (string s);

	[CCode (cname = "vala_some_thing")]
	extern void some_thing ();
}

public class Bar {
	[CCode (cname = "g_strdup", cheader_filename = "glib.h")]
	public static extern string strdup (string s);

	[CCode (cname = "vala_some_thing")]
	public static extern void some_thing ();
}

void main () {
	assert ("foo" == strdup ("foo"));
	assert ("foo" == Foo.strdup ("foo"));
	assert ("foo" == Bar.strdup ("foo"));

	assert ((void*) some_thing != null);
	assert ((void*) Foo.some_thing != null);
	assert ((void*) Bar.some_thing != null);
}
