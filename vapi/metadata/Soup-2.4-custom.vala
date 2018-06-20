namespace Soup {
	[Compact]
	[CCode (copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "soup_buffer_get_type ()", cheader_filename = "libsoup/soup.h")]
	public class Buffer {
		[CCode (has_construct_function = false)]
		public Buffer.subbuffer (Soup.Buffer parent, size_t offset, size_t length);
	}
}
