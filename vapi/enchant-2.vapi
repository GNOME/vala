[CCode (cheader_filename = "enchant.h")]
namespace Enchant {
	public unowned string get_version ();
	public void set_prefix_dir (string dir);

	public delegate void BrokerDescribeFn (string provider_name, string provider_desc, string provider_dll_file);
	public delegate void DictDescribeFn (string lang_tag, string provider_name, string provider_desc, string provider_file);

	[Compact]
	[CCode (free_function = "enchant_broker_free")]
	public class Broker {
		[CCode (cname = "enchant_broker_init")]
		public Broker ();

		public unowned Dict request_dict (string tag);
		public unowned Dict request_pwl_dict (string pwl);
		public void free_dict (Dict dict);
		public int dict_exists (string tag);
		public void set_ordering (string tag, string ordering);
		public unowned string get_error ();
		public void describe (BrokerDescribeFn fn);
		public void list_dicts (DictDescribeFn fn);
	}

	[Compact]
	public class Dict {
		public int check (string word, long len = -1);
		[CCode (array_length_type = "size_t")]
		public unowned string[] suggest (string word, long len = -1);
		public void add (string word, long len = -1);
		public void add_to_session (string word, long len = -1);
		public void remove (string word, long len = -1);
		public void remove_from_session (string word, long len = -1);
		public int is_added (string word, long len = -1);
		public int is_removed (string word, long len = -1);
		public void store_replacement (string mis, string cor, [CCode (pos = 1.1)] long mis_len = -1, long cor_len = -1);
		public void free_string_list ([CCode (array_length = false)] string[] string_list);
		public unowned string get_error ();
		public unowned string get_extra_word_characters ();
		public bool is_word_character (uint32 uc, WordPosition n);
		public void describe (DictDescribeFn fn);
	}

	[CCode (cname = "size_t", has_type_id = false)]
	public enum WordPosition {
		[CCode (cname = "0")]
		START,
		[CCode (cname = "1")]
		MIDDLE,
		[CCode (cname = "2")]
		END
	}
}
