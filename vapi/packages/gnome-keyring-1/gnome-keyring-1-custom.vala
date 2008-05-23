namespace GnomeKeyring
{
	public const string DEFAULT;
	public const GnomeKeyring.PasswordSchema NETWORK_PASSWORD;

	[CCode (free_function = "gnome_keyring_attribute_list_free")]
	public class AttributeList {
		public extern Attribute index (int i);
		
		[NoArrayLength]
		public Attribute[] data;
		public uint len;
	}
}
