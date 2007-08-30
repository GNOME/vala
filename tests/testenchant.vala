using Enchant;
using GLib;

class TestEnchant : Object {
	static void info (string message) {
		stdout.printf ("INFO: %s\n", message);
	}

	static void test (string message, bool result) {
		stdout.printf ("TEST: %s: %s\n", message, result ? "SUCCESS" : "FAILURE");
	}

	static void main (string[] args) {
		Broker broker = new Broker ();
		weak Dict dict;

		info ("providers for broker %p".printf (broker));
		broker.describe (broker_describe_cb);

		info ("dictionaries for broker %p".printf (broker));
		broker.list_dicts (dict_describe_cb);

		dict = broker.request_dict ("invalid-tag");

		test ("requesting invalid dictionary", null == dict);
		info ("broker error message".printf (broker.get_error ()));

		dict = broker.request_dict ("en");

		test ("requesting english dictionary", null != dict);
		test ("broker error is null", null == broker.get_error ());

		info ("description of dictionary %p".printf (dict));
		dict.describe (dict_describe_cb);

		var text = "The quick prown fox jummps over the lasy dok".split (" ");

		foreach (string word in text) {
			weak string[] suggestions;
			string result;

do { // FIXME: Bug 467896
			switch (dict.check (word)) {
				case 0:
					result = "good";
					break;

				case 1:
					suggestions = dict.suggest (word);
					result = "bad (%d suggestions: %s)".printf (suggestions.length, string.joinv (", ", suggestions));
					break;

				case -1:
					result = "error: %s".printf (dict.get_error ());
					break;

				default:
					assert_not_reached ();
					break;
			}
} while (false);

			info ("%s: %s".printf (word, result));
		}

		var bad_word = "the:colons:make:this:a:bad:word";
		int result;

		result = dict.is_in_session (bad_word);
		test ("bad word is not in session", 0 == result);

		result = dict.check (bad_word);
		test ("bad word is rejected", 1 == result);

		info ("adding bad word to session");
		dict.add_to_session (bad_word);

		result = dict.is_in_session (bad_word);
		test ("bad word is in session now", 1 == result);

		result = dict.check (bad_word);
		test ("bad word is accepted now", 0 == result);

		broker.free_dict (dict);
		dict = null;
	}

	static void broker_describe_cb (string name, string desc, string libname) {
		info ("- %s (%s) - %s".printf (name, desc, libname));
	}

	static void dict_describe_cb (string language, string provider_name, string provider_desc, string provider_libname) {
		info ("- %s (%s) - %s".printf (language, provider_desc, provider_libname));
	}
}
