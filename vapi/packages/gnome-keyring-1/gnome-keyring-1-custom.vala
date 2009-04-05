namespace GnomeKeyring
{
	public const string DEFAULT;
	public const GnomeKeyring.PasswordSchema NETWORK_PASSWORD;

	[Compact]
	[CCode (free_function = "gnome_keyring_network_password_free")]
	public class NetworkPasswordData {
	}

	[CCode (free_function = "gnome_keyring_attribute_list_free")]
	public class AttributeList {
		public extern Attribute index (int i);
		
		[NoArrayLength]
		public Attribute[] data;
		public uint len;
	}
}
