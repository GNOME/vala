<?xml version="1.0"?>
<api version="1.0">
	<namespace name="GConf">
		<function name="concat_dir_and_key" symbol="gconf_concat_dir_and_key">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="dir" type="gchar*"/>
				<parameter name="key" type="gchar*"/>
			</parameters>
		</function>
		<function name="debug_shutdown" symbol="gconf_debug_shutdown">
			<return-type type="int"/>
		</function>
		<function name="enum_to_string" symbol="gconf_enum_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="lookup_table" type="GConfEnumStringPair[]"/>
				<parameter name="enum_value" type="gint"/>
			</parameters>
		</function>
		<function name="error_quark" symbol="gconf_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="escape_key" symbol="gconf_escape_key">
			<return-type type="char*"/>
			<parameters>
				<parameter name="arbitrary_text" type="char*"/>
				<parameter name="len" type="int"/>
			</parameters>
		</function>
		<function name="init" symbol="gconf_init">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="argc" type="int"/>
				<parameter name="argv" type="char**"/>
				<parameter name="err" type="GError**"/>
			</parameters>
		</function>
		<function name="is_initialized" symbol="gconf_is_initialized">
			<return-type type="gboolean"/>
		</function>
		<function name="key_is_below" symbol="gconf_key_is_below">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="above" type="gchar*"/>
				<parameter name="below" type="gchar*"/>
			</parameters>
		</function>
		<function name="string_to_enum" symbol="gconf_string_to_enum">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="lookup_table" type="GConfEnumStringPair[]"/>
				<parameter name="str" type="gchar*"/>
				<parameter name="enum_value_retloc" type="gint*"/>
			</parameters>
		</function>
		<function name="unescape_key" symbol="gconf_unescape_key">
			<return-type type="char*"/>
			<parameters>
				<parameter name="escaped_key" type="char*"/>
				<parameter name="len" type="int"/>
			</parameters>
		</function>
		<function name="unique_key" symbol="gconf_unique_key">
			<return-type type="gchar*"/>
		</function>
		<function name="valid_key" symbol="gconf_valid_key">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="key" type="gchar*"/>
				<parameter name="why_invalid" type="gchar**"/>
			</parameters>
		</function>
		<callback name="GConfChangeSetForeachFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="cs" type="GConfChangeSet*"/>
				<parameter name="key" type="gchar*"/>
				<parameter name="value" type="GConfValue*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GConfClientErrorHandlerFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="client" type="GConfClient*"/>
				<parameter name="error" type="GError*"/>
			</parameters>
		</callback>
		<callback name="GConfClientNotifyFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="client" type="GConfClient*"/>
				<parameter name="cnxn_id" type="guint"/>
				<parameter name="entry" type="GConfEntry*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GConfListenersCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="listeners" type="GConfListeners*"/>
				<parameter name="all_above_key" type="gchar*"/>
				<parameter name="cnxn_id" type="guint"/>
				<parameter name="listener_data" type="gpointer"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GConfListenersForeach">
			<return-type type="void"/>
			<parameters>
				<parameter name="location" type="gchar*"/>
				<parameter name="cnxn_id" type="guint"/>
				<parameter name="listener_data" type="gpointer"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GConfListenersPredicate">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="location" type="gchar*"/>
				<parameter name="cnxn_id" type="guint"/>
				<parameter name="listener_data" type="gpointer"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GConfNotifyFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="conf" type="GConfEngine*"/>
				<parameter name="cnxn_id" type="guint"/>
				<parameter name="entry" type="GConfEntry*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GConfEngine">
			<method name="all_dirs" symbol="gconf_engine_all_dirs">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="dir" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="all_entries" symbol="gconf_engine_all_entries">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="dir" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="associate_schema" symbol="gconf_engine_associate_schema">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="schema_key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="change_set_from_current" symbol="gconf_engine_change_set_from_current">
				<return-type type="GConfChangeSet*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="err" type="GError**"/>
					<parameter name="first_key" type="gchar*"/>
				</parameters>
			</method>
			<method name="change_set_from_currentv" symbol="gconf_engine_change_set_from_currentv">
				<return-type type="GConfChangeSet*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="keys" type="gchar**"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="commit_change_set" symbol="gconf_engine_commit_change_set">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="remove_committed" type="gboolean"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="dir_exists" symbol="gconf_engine_dir_exists">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="dir" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get" symbol="gconf_engine_get">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_bool" symbol="gconf_engine_get_bool">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_default" symbol="gconf_engine_get_default">
				<return-type type="GConfEngine*"/>
			</method>
			<method name="get_default_from_schema" symbol="gconf_engine_get_default_from_schema">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_entry" symbol="gconf_engine_get_entry">
				<return-type type="GConfEntry*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="locale" type="gchar*"/>
					<parameter name="use_schema_default" type="gboolean"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_float" symbol="gconf_engine_get_float">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_for_address" symbol="gconf_engine_get_for_address">
				<return-type type="GConfEngine*"/>
				<parameters>
					<parameter name="address" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_for_addresses" symbol="gconf_engine_get_for_addresses">
				<return-type type="GConfEngine*"/>
				<parameters>
					<parameter name="addresses" type="GSList*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_int" symbol="gconf_engine_get_int">
				<return-type type="gint"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_list" symbol="gconf_engine_get_list">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="list_type" type="GConfValueType"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_pair" symbol="gconf_engine_get_pair">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="car_type" type="GConfValueType"/>
					<parameter name="cdr_type" type="GConfValueType"/>
					<parameter name="car_retloc" type="gpointer"/>
					<parameter name="cdr_retloc" type="gpointer"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_schema" symbol="gconf_engine_get_schema">
				<return-type type="GConfSchema*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_string" symbol="gconf_engine_get_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_user_data" symbol="gconf_engine_get_user_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="engine" type="GConfEngine*"/>
				</parameters>
			</method>
			<method name="get_with_locale" symbol="gconf_engine_get_with_locale">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="locale" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_without_default" symbol="gconf_engine_get_without_default">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="key_is_writable" symbol="gconf_engine_key_is_writable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="notify_add" symbol="gconf_engine_notify_add">
				<return-type type="guint"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="namespace_section" type="gchar*"/>
					<parameter name="func" type="GConfNotifyFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="notify_remove" symbol="gconf_engine_notify_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="cnxn" type="guint"/>
				</parameters>
			</method>
			<method name="ref" symbol="gconf_engine_ref">
				<return-type type="void"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
				</parameters>
			</method>
			<method name="remove_dir" symbol="gconf_engine_remove_dir">
				<return-type type="void"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="dir" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="reverse_change_set" symbol="gconf_engine_reverse_change_set">
				<return-type type="GConfChangeSet*"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set" symbol="gconf_engine_set">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_bool" symbol="gconf_engine_set_bool">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="gboolean"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_float" symbol="gconf_engine_set_float">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="gdouble"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_int" symbol="gconf_engine_set_int">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="gint"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_list" symbol="gconf_engine_set_list">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="list_type" type="GConfValueType"/>
					<parameter name="list" type="GSList*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_pair" symbol="gconf_engine_set_pair">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="car_type" type="GConfValueType"/>
					<parameter name="cdr_type" type="GConfValueType"/>
					<parameter name="address_of_car" type="gconstpointer"/>
					<parameter name="address_of_cdr" type="gconstpointer"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_schema" symbol="gconf_engine_set_schema">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="GConfSchema*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_string" symbol="gconf_engine_set_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_user_data" symbol="gconf_engine_set_user_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="engine" type="GConfEngine*"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="dnotify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="suggest_sync" symbol="gconf_engine_suggest_sync">
				<return-type type="void"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="unref" symbol="gconf_engine_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
				</parameters>
			</method>
			<method name="unset" symbol="gconf_engine_unset">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conf" type="GConfEngine*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
		</struct>
		<struct name="GConfEntry">
			<method name="copy" symbol="gconf_entry_copy">
				<return-type type="GConfEntry*"/>
				<parameters>
					<parameter name="src" type="GConfEntry*"/>
				</parameters>
			</method>
			<method name="equal" symbol="gconf_entry_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="a" type="GConfEntry*"/>
					<parameter name="b" type="GConfEntry*"/>
				</parameters>
			</method>
			<method name="free" symbol="gconf_entry_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
				</parameters>
			</method>
			<method name="get_is_default" symbol="gconf_entry_get_is_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
				</parameters>
			</method>
			<method name="get_is_writable" symbol="gconf_entry_get_is_writable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
				</parameters>
			</method>
			<method name="get_key" symbol="gconf_entry_get_key">
				<return-type type="char*"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
				</parameters>
			</method>
			<method name="get_schema_name" symbol="gconf_entry_get_schema_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="gconf_entry_get_value">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
				</parameters>
			</method>
			<method name="new" symbol="gconf_entry_new">
				<return-type type="GConfEntry*"/>
				<parameters>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="new_nocopy" symbol="gconf_entry_new_nocopy">
				<return-type type="GConfEntry*"/>
				<parameters>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="ref" symbol="gconf_entry_ref">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
				</parameters>
			</method>
			<method name="set_is_default" symbol="gconf_entry_set_is_default">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
					<parameter name="is_default" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_is_writable" symbol="gconf_entry_set_is_writable">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
					<parameter name="is_writable" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_schema_name" symbol="gconf_entry_set_schema_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_value" symbol="gconf_entry_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
					<parameter name="val" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="set_value_nocopy" symbol="gconf_entry_set_value_nocopy">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
					<parameter name="val" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="steal_value" symbol="gconf_entry_steal_value">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gconf_entry_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GConfEntry*"/>
				</parameters>
			</method>
			<field name="key" type="char*"/>
			<field name="value" type="GConfValue*"/>
		</struct>
		<struct name="GConfEnumStringPair">
			<field name="enum_value" type="gint"/>
			<field name="str" type="gchar*"/>
		</struct>
		<struct name="GConfListeners">
			<method name="add" symbol="gconf_listeners_add">
				<return-type type="guint"/>
				<parameters>
					<parameter name="listeners" type="GConfListeners*"/>
					<parameter name="listen_point" type="gchar*"/>
					<parameter name="listener_data" type="gpointer"/>
					<parameter name="destroy_notify" type="GFreeFunc"/>
				</parameters>
			</method>
			<method name="count" symbol="gconf_listeners_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="listeners" type="GConfListeners*"/>
				</parameters>
			</method>
			<method name="foreach" symbol="gconf_listeners_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="listeners" type="GConfListeners*"/>
					<parameter name="callback" type="GConfListenersForeach"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gconf_listeners_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="listeners" type="GConfListeners*"/>
				</parameters>
			</method>
			<method name="get_data" symbol="gconf_listeners_get_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="listeners" type="GConfListeners*"/>
					<parameter name="cnxn_id" type="guint"/>
					<parameter name="listener_data_p" type="gpointer*"/>
					<parameter name="location_p" type="gchar**"/>
				</parameters>
			</method>
			<method name="new" symbol="gconf_listeners_new">
				<return-type type="GConfListeners*"/>
			</method>
			<method name="notify" symbol="gconf_listeners_notify">
				<return-type type="void"/>
				<parameters>
					<parameter name="listeners" type="GConfListeners*"/>
					<parameter name="all_above" type="gchar*"/>
					<parameter name="callback" type="GConfListenersCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="remove" symbol="gconf_listeners_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="listeners" type="GConfListeners*"/>
					<parameter name="cnxn_id" type="guint"/>
				</parameters>
			</method>
			<method name="remove_if" symbol="gconf_listeners_remove_if">
				<return-type type="void"/>
				<parameters>
					<parameter name="listeners" type="GConfListeners*"/>
					<parameter name="predicate" type="GConfListenersPredicate"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
		</struct>
		<struct name="GConfMetaInfo">
			<method name="free" symbol="gconf_meta_info_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="gcmi" type="GConfMetaInfo*"/>
				</parameters>
			</method>
			<method name="get_mod_user" symbol="gconf_meta_info_get_mod_user">
				<return-type type="char*"/>
				<parameters>
					<parameter name="gcmi" type="GConfMetaInfo*"/>
				</parameters>
			</method>
			<method name="get_schema" symbol="gconf_meta_info_get_schema">
				<return-type type="char*"/>
				<parameters>
					<parameter name="gcmi" type="GConfMetaInfo*"/>
				</parameters>
			</method>
			<method name="mod_time" symbol="gconf_meta_info_mod_time">
				<return-type type="GTime"/>
				<parameters>
					<parameter name="gcmi" type="GConfMetaInfo*"/>
				</parameters>
			</method>
			<method name="new" symbol="gconf_meta_info_new">
				<return-type type="GConfMetaInfo*"/>
			</method>
			<method name="set_mod_time" symbol="gconf_meta_info_set_mod_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="gcmi" type="GConfMetaInfo*"/>
					<parameter name="mod_time" type="GTime"/>
				</parameters>
			</method>
			<method name="set_mod_user" symbol="gconf_meta_info_set_mod_user">
				<return-type type="void"/>
				<parameters>
					<parameter name="gcmi" type="GConfMetaInfo*"/>
					<parameter name="mod_user" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_schema" symbol="gconf_meta_info_set_schema">
				<return-type type="void"/>
				<parameters>
					<parameter name="gcmi" type="GConfMetaInfo*"/>
					<parameter name="schema_name" type="gchar*"/>
				</parameters>
			</method>
			<field name="schema" type="gchar*"/>
			<field name="mod_user" type="gchar*"/>
			<field name="mod_time" type="GTime"/>
		</struct>
		<struct name="GConfSchema">
			<method name="copy" symbol="gconf_schema_copy">
				<return-type type="GConfSchema*"/>
				<parameters>
					<parameter name="sc" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="free" symbol="gconf_schema_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="sc" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="get_car_type" symbol="gconf_schema_get_car_type">
				<return-type type="GConfValueType"/>
				<parameters>
					<parameter name="schema" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="get_cdr_type" symbol="gconf_schema_get_cdr_type">
				<return-type type="GConfValueType"/>
				<parameters>
					<parameter name="schema" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="get_default_value" symbol="gconf_schema_get_default_value">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="schema" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="get_list_type" symbol="gconf_schema_get_list_type">
				<return-type type="GConfValueType"/>
				<parameters>
					<parameter name="schema" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="get_locale" symbol="gconf_schema_get_locale">
				<return-type type="char*"/>
				<parameters>
					<parameter name="schema" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="get_long_desc" symbol="gconf_schema_get_long_desc">
				<return-type type="char*"/>
				<parameters>
					<parameter name="schema" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="get_owner" symbol="gconf_schema_get_owner">
				<return-type type="char*"/>
				<parameters>
					<parameter name="schema" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="get_short_desc" symbol="gconf_schema_get_short_desc">
				<return-type type="char*"/>
				<parameters>
					<parameter name="schema" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="new" symbol="gconf_schema_new">
				<return-type type="GConfSchema*"/>
			</method>
			<method name="set_car_type" symbol="gconf_schema_set_car_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="sc" type="GConfSchema*"/>
					<parameter name="type" type="GConfValueType"/>
				</parameters>
			</method>
			<method name="set_cdr_type" symbol="gconf_schema_set_cdr_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="sc" type="GConfSchema*"/>
					<parameter name="type" type="GConfValueType"/>
				</parameters>
			</method>
			<method name="set_default_value" symbol="gconf_schema_set_default_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="sc" type="GConfSchema*"/>
					<parameter name="val" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="set_default_value_nocopy" symbol="gconf_schema_set_default_value_nocopy">
				<return-type type="void"/>
				<parameters>
					<parameter name="sc" type="GConfSchema*"/>
					<parameter name="val" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="set_list_type" symbol="gconf_schema_set_list_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="sc" type="GConfSchema*"/>
					<parameter name="type" type="GConfValueType"/>
				</parameters>
			</method>
			<method name="set_locale" symbol="gconf_schema_set_locale">
				<return-type type="void"/>
				<parameters>
					<parameter name="sc" type="GConfSchema*"/>
					<parameter name="locale" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_long_desc" symbol="gconf_schema_set_long_desc">
				<return-type type="void"/>
				<parameters>
					<parameter name="sc" type="GConfSchema*"/>
					<parameter name="desc" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_owner" symbol="gconf_schema_set_owner">
				<return-type type="void"/>
				<parameters>
					<parameter name="sc" type="GConfSchema*"/>
					<parameter name="owner" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_short_desc" symbol="gconf_schema_set_short_desc">
				<return-type type="void"/>
				<parameters>
					<parameter name="sc" type="GConfSchema*"/>
					<parameter name="desc" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_type" symbol="gconf_schema_set_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="sc" type="GConfSchema*"/>
					<parameter name="type" type="GConfValueType"/>
				</parameters>
			</method>
		</struct>
		<struct name="GConfValue">
			<method name="compare" symbol="gconf_value_compare">
				<return-type type="int"/>
				<parameters>
					<parameter name="value_a" type="GConfValue*"/>
					<parameter name="value_b" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gconf_value_copy">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="src" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="decode" symbol="gconf_value_decode">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="encoded" type="gchar*"/>
				</parameters>
			</method>
			<method name="encode" symbol="gconf_value_encode">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="val" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="free" symbol="gconf_value_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="get_bool" symbol="gconf_value_get_bool">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="get_car" symbol="gconf_value_get_car">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="get_cdr" symbol="gconf_value_get_cdr">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="get_float" symbol="gconf_value_get_float">
				<return-type type="double"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="get_int" symbol="gconf_value_get_int">
				<return-type type="int"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="get_list" symbol="gconf_value_get_list">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="get_list_type" symbol="gconf_value_get_list_type">
				<return-type type="GConfValueType"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="get_schema" symbol="gconf_value_get_schema">
				<return-type type="GConfSchema*"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="get_string" symbol="gconf_value_get_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="new" symbol="gconf_value_new">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="type" type="GConfValueType"/>
				</parameters>
			</method>
			<method name="new_from_string" symbol="gconf_value_new_from_string">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="type" type="GConfValueType"/>
					<parameter name="str" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_bool" symbol="gconf_value_set_bool">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="the_bool" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_car" symbol="gconf_value_set_car">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="car" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="set_car_nocopy" symbol="gconf_value_set_car_nocopy">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="car" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="set_cdr" symbol="gconf_value_set_cdr">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="cdr" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="set_cdr_nocopy" symbol="gconf_value_set_cdr_nocopy">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="cdr" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="set_float" symbol="gconf_value_set_float">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="the_float" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_int" symbol="gconf_value_set_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="the_int" type="gint"/>
				</parameters>
			</method>
			<method name="set_list" symbol="gconf_value_set_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="list" type="GSList*"/>
				</parameters>
			</method>
			<method name="set_list_nocopy" symbol="gconf_value_set_list_nocopy">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="list" type="GSList*"/>
				</parameters>
			</method>
			<method name="set_list_type" symbol="gconf_value_set_list_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="type" type="GConfValueType"/>
				</parameters>
			</method>
			<method name="set_schema" symbol="gconf_value_set_schema">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="sc" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="set_schema_nocopy" symbol="gconf_value_set_schema_nocopy">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="sc" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="set_string" symbol="gconf_value_set_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
					<parameter name="the_str" type="gchar*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="gconf_value_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<field name="type" type="GConfValueType"/>
		</struct>
		<boxed name="GConfChangeSet" type-name="GConfChangeSet" get-type="gconf_change_set_get_type">
			<method name="check_value" symbol="gconf_change_set_check_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value_retloc" type="GConfValue**"/>
				</parameters>
			</method>
			<method name="clear" symbol="gconf_change_set_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
				</parameters>
			</method>
			<method name="foreach" symbol="gconf_change_set_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="func" type="GConfChangeSetForeachFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_user_data" symbol="gconf_change_set_get_user_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gconf_change_set_new">
				<return-type type="GConfChangeSet*"/>
			</constructor>
			<method name="ref" symbol="gconf_change_set_ref">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
				</parameters>
			</method>
			<method name="remove" symbol="gconf_change_set_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
			<method name="set" symbol="gconf_change_set_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="set_bool" symbol="gconf_change_set_set_bool">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_float" symbol="gconf_change_set_set_float">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_int" symbol="gconf_change_set_set_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="gint"/>
				</parameters>
			</method>
			<method name="set_list" symbol="gconf_change_set_set_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="list_type" type="GConfValueType"/>
					<parameter name="list" type="GSList*"/>
				</parameters>
			</method>
			<method name="set_nocopy" symbol="gconf_change_set_set_nocopy">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<method name="set_pair" symbol="gconf_change_set_set_pair">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="car_type" type="GConfValueType"/>
					<parameter name="cdr_type" type="GConfValueType"/>
					<parameter name="address_of_car" type="gconstpointer"/>
					<parameter name="address_of_cdr" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="set_schema" symbol="gconf_change_set_set_schema">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="GConfSchema*"/>
				</parameters>
			</method>
			<method name="set_string" symbol="gconf_change_set_set_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_user_data" symbol="gconf_change_set_set_user_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="dnotify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="size" symbol="gconf_change_set_size">
				<return-type type="guint"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gconf_change_set_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
				</parameters>
			</method>
			<method name="unset" symbol="gconf_change_set_unset">
				<return-type type="void"/>
				<parameters>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="key" type="gchar*"/>
				</parameters>
			</method>
		</boxed>
		<enum name="GConfClientErrorHandlingMode" type-name="GConfClientErrorHandlingMode" get-type="gconf_client_error_handling_mode_get_type">
			<member name="GCONF_CLIENT_HANDLE_NONE" value="0"/>
			<member name="GCONF_CLIENT_HANDLE_UNRETURNED" value="1"/>
			<member name="GCONF_CLIENT_HANDLE_ALL" value="2"/>
		</enum>
		<enum name="GConfClientPreloadType" type-name="GConfClientPreloadType" get-type="gconf_client_preload_type_get_type">
			<member name="GCONF_CLIENT_PRELOAD_NONE" value="0"/>
			<member name="GCONF_CLIENT_PRELOAD_ONELEVEL" value="1"/>
			<member name="GCONF_CLIENT_PRELOAD_RECURSIVE" value="2"/>
		</enum>
		<enum name="GConfError" type-name="GConfError" get-type="gconf_error_get_type">
			<member name="GCONF_ERROR_SUCCESS" value="0"/>
			<member name="GCONF_ERROR_FAILED" value="1"/>
			<member name="GCONF_ERROR_NO_SERVER" value="2"/>
			<member name="GCONF_ERROR_NO_PERMISSION" value="3"/>
			<member name="GCONF_ERROR_BAD_ADDRESS" value="4"/>
			<member name="GCONF_ERROR_BAD_KEY" value="5"/>
			<member name="GCONF_ERROR_PARSE_ERROR" value="6"/>
			<member name="GCONF_ERROR_CORRUPT" value="7"/>
			<member name="GCONF_ERROR_TYPE_MISMATCH" value="8"/>
			<member name="GCONF_ERROR_IS_DIR" value="9"/>
			<member name="GCONF_ERROR_IS_KEY" value="10"/>
			<member name="GCONF_ERROR_OVERRIDDEN" value="11"/>
			<member name="GCONF_ERROR_OAF_ERROR" value="12"/>
			<member name="GCONF_ERROR_LOCAL_ENGINE" value="13"/>
			<member name="GCONF_ERROR_LOCK_FAILED" value="14"/>
			<member name="GCONF_ERROR_NO_WRITABLE_DATABASE" value="15"/>
			<member name="GCONF_ERROR_IN_SHUTDOWN" value="16"/>
		</enum>
		<enum name="GConfValueType" type-name="GConfValueType" get-type="gconf_value_type_get_type">
			<member name="GCONF_VALUE_INVALID" value="0"/>
			<member name="GCONF_VALUE_STRING" value="1"/>
			<member name="GCONF_VALUE_INT" value="2"/>
			<member name="GCONF_VALUE_FLOAT" value="3"/>
			<member name="GCONF_VALUE_BOOL" value="4"/>
			<member name="GCONF_VALUE_SCHEMA" value="5"/>
			<member name="GCONF_VALUE_LIST" value="6"/>
			<member name="GCONF_VALUE_PAIR" value="7"/>
		</enum>
		<flags name="GConfUnsetFlags" type-name="GConfUnsetFlags" get-type="gconf_unset_flags_get_type">
			<member name="GCONF_UNSET_INCLUDING_SCHEMA_NAMES" value="1"/>
		</flags>
		<object name="GConfClient" parent="GObject" type-name="GConfClient" get-type="gconf_client_get_type">
			<method name="add_dir" symbol="gconf_client_add_dir">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="dir" type="gchar*"/>
					<parameter name="preload" type="GConfClientPreloadType"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="all_dirs" symbol="gconf_client_all_dirs">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="dir" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="all_entries" symbol="gconf_client_all_entries">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="dir" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="change_set_from_current" symbol="gconf_client_change_set_from_current">
				<return-type type="GConfChangeSet*"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="err" type="GError**"/>
					<parameter name="first_key" type="gchar*"/>
				</parameters>
			</method>
			<method name="change_set_from_currentv" symbol="gconf_client_change_set_from_currentv">
				<return-type type="GConfChangeSet*"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="keys" type="gchar**"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="clear_cache" symbol="gconf_client_clear_cache">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
				</parameters>
			</method>
			<method name="commit_change_set" symbol="gconf_client_commit_change_set">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="remove_committed" type="gboolean"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="dir_exists" symbol="gconf_client_dir_exists">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="dir" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="error" symbol="gconf_client_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</method>
			<method name="get" symbol="gconf_client_get">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_bool" symbol="gconf_client_get_bool">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_default" symbol="gconf_client_get_default">
				<return-type type="GConfClient*"/>
			</method>
			<method name="get_default_from_schema" symbol="gconf_client_get_default_from_schema">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_entry" symbol="gconf_client_get_entry">
				<return-type type="GConfEntry*"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="locale" type="gchar*"/>
					<parameter name="use_schema_default" type="gboolean"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_float" symbol="gconf_client_get_float">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_for_engine" symbol="gconf_client_get_for_engine">
				<return-type type="GConfClient*"/>
				<parameters>
					<parameter name="engine" type="GConfEngine*"/>
				</parameters>
			</method>
			<method name="get_int" symbol="gconf_client_get_int">
				<return-type type="gint"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_list" symbol="gconf_client_get_list">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="list_type" type="GConfValueType"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_pair" symbol="gconf_client_get_pair">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="car_type" type="GConfValueType"/>
					<parameter name="cdr_type" type="GConfValueType"/>
					<parameter name="car_retloc" type="gpointer"/>
					<parameter name="cdr_retloc" type="gpointer"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_schema" symbol="gconf_client_get_schema">
				<return-type type="GConfSchema*"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_string" symbol="gconf_client_get_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="get_without_default" symbol="gconf_client_get_without_default">
				<return-type type="GConfValue*"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="key_is_writable" symbol="gconf_client_key_is_writable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="notify" symbol="gconf_client_notify">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="char*"/>
				</parameters>
			</method>
			<method name="notify_add" symbol="gconf_client_notify_add">
				<return-type type="guint"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="namespace_section" type="gchar*"/>
					<parameter name="func" type="GConfClientNotifyFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="destroy_notify" type="GFreeFunc"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="notify_remove" symbol="gconf_client_notify_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="cnxn" type="guint"/>
				</parameters>
			</method>
			<method name="preload" symbol="gconf_client_preload">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="dirname" type="gchar*"/>
					<parameter name="type" type="GConfClientPreloadType"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="recursive_unset" symbol="gconf_client_recursive_unset">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="char*"/>
					<parameter name="flags" type="GConfUnsetFlags"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="remove_dir" symbol="gconf_client_remove_dir">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="dir" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="reverse_change_set" symbol="gconf_client_reverse_change_set">
				<return-type type="GConfChangeSet*"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="cs" type="GConfChangeSet*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set" symbol="gconf_client_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="GConfValue*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_bool" symbol="gconf_client_set_bool">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="gboolean"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_error_handling" symbol="gconf_client_set_error_handling">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="mode" type="GConfClientErrorHandlingMode"/>
				</parameters>
			</method>
			<method name="set_float" symbol="gconf_client_set_float">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="gdouble"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_global_default_error_handler" symbol="gconf_client_set_global_default_error_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="func" type="GConfClientErrorHandlerFunc"/>
				</parameters>
			</method>
			<method name="set_int" symbol="gconf_client_set_int">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="gint"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_list" symbol="gconf_client_set_list">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="list_type" type="GConfValueType"/>
					<parameter name="list" type="GSList*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_pair" symbol="gconf_client_set_pair">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="car_type" type="GConfValueType"/>
					<parameter name="cdr_type" type="GConfValueType"/>
					<parameter name="address_of_car" type="gconstpointer"/>
					<parameter name="address_of_cdr" type="gconstpointer"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_schema" symbol="gconf_client_set_schema">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="GConfSchema*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="set_string" symbol="gconf_client_set_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="val" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="suggest_sync" symbol="gconf_client_suggest_sync">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="unreturned_error" symbol="gconf_client_unreturned_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</method>
			<method name="unset" symbol="gconf_client_unset">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="value_changed" symbol="gconf_client_value_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="value" type="GConfValue*"/>
				</parameters>
			</method>
			<signal name="error" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="error" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="unreturned-error" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="error" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="value-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GConfClient*"/>
					<parameter name="key" type="char*"/>
					<parameter name="value" type="gpointer"/>
				</parameters>
			</signal>
			<field name="engine" type="GConfEngine*"/>
			<field name="error_mode" type="GConfClientErrorHandlingMode"/>
			<field name="dir_hash" type="GHashTable*"/>
			<field name="cache_hash" type="GHashTable*"/>
			<field name="listeners" type="GConfListeners*"/>
			<field name="notify_list" type="GSList*"/>
			<field name="notify_handler" type="guint"/>
			<field name="pending_notify_count" type="int"/>
			<field name="cache_dirs" type="GHashTable*"/>
			<field name="pad2" type="int"/>
		</object>
	</namespace>
</api>
