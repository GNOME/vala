namespace GnomeKeyring
{
	public const string DEFAULT;
	[CCode (cname = "GNOME_KEYRING_NETWORK_PASSWORD")]
	public GnomeKeyring.PasswordSchema NETWORK_PASSWORD;

	[Compact]
	[CCode (free_function = "gnome_keyring_network_password_free")]
	public class NetworkPasswordData {
	}

	[Compact]
	[CCode (free_function = "gnome_keyring_attribute_list_free")]
	public class AttributeList {
		public extern AttributeList ();
		public extern Attribute index (int i);
		
		[CCode (array_length = false)]
		public Attribute[] data;
		public uint len;
	}

	[CCode (cprefix = "GNOME_KEYRING_ITEM_", has_type_id = false, cheader_filename = "gnome-keyring.h")]
	public enum ItemType {
		APPLICATION_SECRET,
		ITEM_TYPE_MASK,
		GENERIC_SECRET,
		NETWORK_PASSWORD,
		NOTE,
		CHAINED_KEYRING_PASSWORD,
		ENCRYPTION_KEY_PASSWORD,
		PK_STORAGE,
		LAST_TYPE
	}

	[CCode (cprefix = "GNOME_KEYRING_ITEM_INFO_", has_type_id = false, cheader_filename = "gnome-keyring.h")]
	public enum ItemInfoFlags {
		ALL,
		BASICS,
		SECRET
	}

	[CCode (cname = "GNOME_KEYRING_SESSION")]
	public const string SESSION;
}
