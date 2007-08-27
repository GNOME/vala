[CCode (cname_prefix = "enchant_", cheader_filename = "enchant.h")]
namespace Enchant {
	public static delegate void BrokerDescribeFn (string provider_name, string provider_desc, string provider_dll_file, pointer user_data);
	public static delegate void DictDescribeFn (string lang_tag, string provider_name, string provider_desc, string provider_file, pointer user_data);

	[ReferenceType (unref_function = "enchant_broker_free")]
	public struct Broker {
		[CCode (cname = "enchant_broker_init")]
		public Broker ();

		public weak Dict request_dict (weak string! tag);	// FIXME integrate with memory manager
		public weak Dict request_pwl_dict (weak string! pwl);	// FIXME integrate with memory manager
		public void free_dict (Dict! dict); 			// FIXME integrate with memory manager
		public int dict_exists (weak string! tag);
		public void set_ordering (weak string! tag, weak string! ordering);
		public void describe (BrokerDescribeFn fn, pointer user_data = null);
		public void list_dicts (DictDescribeFn fn, pointer user_data = null);
		public weak string! get_error ();
	}

	[ReferenceType ()]
	public struct Dict {
		public int check (weak string! word, long len = -1);
		public weak string[] suggest (weak string! word, long len = -1);	// FIXME integrate with memory manager
		[NoArrayLength ()]
		public void free_string_list (weak string[] string_list); 	// FIXME integrate with memory manager
		public void add_to_session (weak string! word, long len = -1);
		public int is_in_session (weak string! word, long len = -1);
		public void store_replacement (weak string! mis, long mis_len, weak string! cor, long cor_len);
		public void add_to_pwl (weak string! word, long len = -1);
		public void describe (DictDescribeFn fn, pointer user_data = null);
		[NoArrayLength ()]
		public weak string! get_error ();
	}
}
