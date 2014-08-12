[CCode (cname = "g_hash_table_get_keys_as_array", array_length_type = "guint", type = "gpointer*")]
public extern (unowned string)[] g_hash_table_get_keys_as_array (GLib.HashTable<string,string> hash_table);

private static int main (string[] args) {
  var ht = new GLib.HashTable<string,string> (GLib.str_hash, GLib.str_equal);
  ht["one"] = "hello";
  ht["two"] = "world";

  string[] keys = g_hash_table_get_keys_as_array (ht);
  ht = null;
  
  foreach (unowned string k in keys) {
	  assert (k == "one" || k == "two");
  }

  return 0;
}