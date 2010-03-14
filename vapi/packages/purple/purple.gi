<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Purple">
		<function name="accounts_add" symbol="purple_accounts_add">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
			</parameters>
		</function>
		<function name="accounts_delete" symbol="purple_accounts_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
			</parameters>
		</function>
		<function name="accounts_find" symbol="purple_accounts_find">
			<return-type type="PurpleAccount*"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="protocol" type="char*"/>
			</parameters>
		</function>
		<function name="accounts_find_any" symbol="purple_accounts_find_any">
			<return-type type="PurpleAccount*"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="protocol" type="char*"/>
			</parameters>
		</function>
		<function name="accounts_find_connected" symbol="purple_accounts_find_connected">
			<return-type type="PurpleAccount*"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="protocol" type="char*"/>
			</parameters>
		</function>
		<function name="accounts_find_ext" symbol="purple_accounts_find_ext">
			<return-type type="PurpleAccount*"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="protocol_id" type="char*"/>
				<parameter name="account_test" type="GCallback"/>
			</parameters>
		</function>
		<function name="accounts_get_all" symbol="purple_accounts_get_all">
			<return-type type="GList*"/>
		</function>
		<function name="accounts_get_all_active" symbol="purple_accounts_get_all_active">
			<return-type type="GList*"/>
		</function>
		<function name="accounts_get_handle" symbol="purple_accounts_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="accounts_get_ui_ops" symbol="purple_accounts_get_ui_ops">
			<return-type type="PurpleAccountUiOps*"/>
		</function>
		<function name="accounts_init" symbol="purple_accounts_init">
			<return-type type="void"/>
		</function>
		<function name="accounts_remove" symbol="purple_accounts_remove">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
			</parameters>
		</function>
		<function name="accounts_reorder" symbol="purple_accounts_reorder">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="new_index" type="gint"/>
			</parameters>
		</function>
		<function name="accounts_restore_current_statuses" symbol="purple_accounts_restore_current_statuses">
			<return-type type="void"/>
		</function>
		<function name="accounts_set_ui_ops" symbol="purple_accounts_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleAccountUiOps*"/>
			</parameters>
		</function>
		<function name="accounts_uninit" symbol="purple_accounts_uninit">
			<return-type type="void"/>
		</function>
		<function name="base16_decode" symbol="purple_base16_decode">
			<return-type type="guchar*"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="ret_len" type="gsize*"/>
			</parameters>
		</function>
		<function name="base16_encode" symbol="purple_base16_encode">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="data" type="guchar*"/>
				<parameter name="len" type="gsize"/>
			</parameters>
		</function>
		<function name="base16_encode_chunked" symbol="purple_base16_encode_chunked">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="data" type="guchar*"/>
				<parameter name="len" type="gsize"/>
			</parameters>
		</function>
		<function name="base64_decode" symbol="purple_base64_decode">
			<return-type type="guchar*"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="ret_len" type="gsize*"/>
			</parameters>
		</function>
		<function name="base64_encode" symbol="purple_base64_encode">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="data" type="guchar*"/>
				<parameter name="len" type="gsize"/>
			</parameters>
		</function>
		<function name="blist_add_account" symbol="purple_blist_add_account">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
			</parameters>
		</function>
		<function name="blist_add_buddy" symbol="purple_blist_add_buddy">
			<return-type type="void"/>
			<parameters>
				<parameter name="buddy" type="PurpleBuddy*"/>
				<parameter name="contact" type="PurpleContact*"/>
				<parameter name="group" type="PurpleGroup*"/>
				<parameter name="node" type="PurpleBlistNode*"/>
			</parameters>
		</function>
		<function name="blist_add_chat" symbol="purple_blist_add_chat">
			<return-type type="void"/>
			<parameters>
				<parameter name="chat" type="PurpleChat*"/>
				<parameter name="group" type="PurpleGroup*"/>
				<parameter name="node" type="PurpleBlistNode*"/>
			</parameters>
		</function>
		<function name="blist_add_contact" symbol="purple_blist_add_contact">
			<return-type type="void"/>
			<parameters>
				<parameter name="contact" type="PurpleContact*"/>
				<parameter name="group" type="PurpleGroup*"/>
				<parameter name="node" type="PurpleBlistNode*"/>
			</parameters>
		</function>
		<function name="blist_add_group" symbol="purple_blist_add_group">
			<return-type type="void"/>
			<parameters>
				<parameter name="group" type="PurpleGroup*"/>
				<parameter name="node" type="PurpleBlistNode*"/>
			</parameters>
		</function>
		<function name="blist_alias_buddy" symbol="purple_blist_alias_buddy">
			<return-type type="void"/>
			<parameters>
				<parameter name="buddy" type="PurpleBuddy*"/>
				<parameter name="alias" type="char*"/>
			</parameters>
		</function>
		<function name="blist_alias_chat" symbol="purple_blist_alias_chat">
			<return-type type="void"/>
			<parameters>
				<parameter name="chat" type="PurpleChat*"/>
				<parameter name="alias" type="char*"/>
			</parameters>
		</function>
		<function name="blist_alias_contact" symbol="purple_blist_alias_contact">
			<return-type type="void"/>
			<parameters>
				<parameter name="contact" type="PurpleContact*"/>
				<parameter name="alias" type="char*"/>
			</parameters>
		</function>
		<function name="blist_destroy" symbol="purple_blist_destroy">
			<return-type type="void"/>
		</function>
		<function name="blist_find_chat" symbol="purple_blist_find_chat">
			<return-type type="PurpleChat*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="blist_get_buddies" symbol="purple_blist_get_buddies">
			<return-type type="GSList*"/>
		</function>
		<function name="blist_get_group_online_count" symbol="purple_blist_get_group_online_count">
			<return-type type="int"/>
			<parameters>
				<parameter name="group" type="PurpleGroup*"/>
			</parameters>
		</function>
		<function name="blist_get_group_size" symbol="purple_blist_get_group_size">
			<return-type type="int"/>
			<parameters>
				<parameter name="group" type="PurpleGroup*"/>
				<parameter name="offline" type="gboolean"/>
			</parameters>
		</function>
		<function name="blist_get_handle" symbol="purple_blist_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="blist_get_root" symbol="purple_blist_get_root">
			<return-type type="PurpleBlistNode*"/>
		</function>
		<function name="blist_get_ui_data" symbol="purple_blist_get_ui_data">
			<return-type type="gpointer"/>
		</function>
		<function name="blist_get_ui_ops" symbol="purple_blist_get_ui_ops">
			<return-type type="PurpleBlistUiOps*"/>
		</function>
		<function name="blist_init" symbol="purple_blist_init">
			<return-type type="void"/>
		</function>
		<function name="blist_load" symbol="purple_blist_load">
			<return-type type="void"/>
		</function>
		<function name="blist_merge_contact" symbol="purple_blist_merge_contact">
			<return-type type="void"/>
			<parameters>
				<parameter name="source" type="PurpleContact*"/>
				<parameter name="node" type="PurpleBlistNode*"/>
			</parameters>
		</function>
		<function name="blist_new" symbol="purple_blist_new">
			<return-type type="PurpleBuddyList*"/>
		</function>
		<function name="blist_remove_account" symbol="purple_blist_remove_account">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
			</parameters>
		</function>
		<function name="blist_remove_buddy" symbol="purple_blist_remove_buddy">
			<return-type type="void"/>
			<parameters>
				<parameter name="buddy" type="PurpleBuddy*"/>
			</parameters>
		</function>
		<function name="blist_remove_chat" symbol="purple_blist_remove_chat">
			<return-type type="void"/>
			<parameters>
				<parameter name="chat" type="PurpleChat*"/>
			</parameters>
		</function>
		<function name="blist_remove_contact" symbol="purple_blist_remove_contact">
			<return-type type="void"/>
			<parameters>
				<parameter name="contact" type="PurpleContact*"/>
			</parameters>
		</function>
		<function name="blist_remove_group" symbol="purple_blist_remove_group">
			<return-type type="void"/>
			<parameters>
				<parameter name="group" type="PurpleGroup*"/>
			</parameters>
		</function>
		<function name="blist_rename_buddy" symbol="purple_blist_rename_buddy">
			<return-type type="void"/>
			<parameters>
				<parameter name="buddy" type="PurpleBuddy*"/>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="blist_rename_group" symbol="purple_blist_rename_group">
			<return-type type="void"/>
			<parameters>
				<parameter name="group" type="PurpleGroup*"/>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="blist_request_add_buddy" symbol="purple_blist_request_add_buddy">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="username" type="char*"/>
				<parameter name="group" type="char*"/>
				<parameter name="alias" type="char*"/>
			</parameters>
		</function>
		<function name="blist_request_add_chat" symbol="purple_blist_request_add_chat">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="group" type="PurpleGroup*"/>
				<parameter name="alias" type="char*"/>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="blist_request_add_group" symbol="purple_blist_request_add_group">
			<return-type type="void"/>
		</function>
		<function name="blist_schedule_save" symbol="purple_blist_schedule_save">
			<return-type type="void"/>
		</function>
		<function name="blist_server_alias_buddy" symbol="purple_blist_server_alias_buddy">
			<return-type type="void"/>
			<parameters>
				<parameter name="buddy" type="PurpleBuddy*"/>
				<parameter name="alias" type="char*"/>
			</parameters>
		</function>
		<function name="blist_set_ui_data" symbol="purple_blist_set_ui_data">
			<return-type type="void"/>
			<parameters>
				<parameter name="ui_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="blist_set_ui_ops" symbol="purple_blist_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleBlistUiOps*"/>
			</parameters>
		</function>
		<function name="blist_set_visible" symbol="purple_blist_set_visible">
			<return-type type="void"/>
			<parameters>
				<parameter name="show" type="gboolean"/>
			</parameters>
		</function>
		<function name="blist_show" symbol="purple_blist_show">
			<return-type type="void"/>
		</function>
		<function name="blist_uninit" symbol="purple_blist_uninit">
			<return-type type="void"/>
		</function>
		<function name="blist_update_buddy_icon" symbol="purple_blist_update_buddy_icon">
			<return-type type="void"/>
			<parameters>
				<parameter name="buddy" type="PurpleBuddy*"/>
			</parameters>
		</function>
		<function name="blist_update_buddy_status" symbol="purple_blist_update_buddy_status">
			<return-type type="void"/>
			<parameters>
				<parameter name="buddy" type="PurpleBuddy*"/>
				<parameter name="old_status" type="PurpleStatus*"/>
			</parameters>
		</function>
		<function name="blist_update_node_icon" symbol="purple_blist_update_node_icon">
			<return-type type="void"/>
			<parameters>
				<parameter name="node" type="PurpleBlistNode*"/>
			</parameters>
		</function>
		<function name="build_dir" symbol="purple_build_dir">
			<return-type type="int"/>
			<parameters>
				<parameter name="path" type="char*"/>
				<parameter name="mode" type="int"/>
			</parameters>
		</function>
		<function name="ciphers_find_cipher" symbol="purple_ciphers_find_cipher">
			<return-type type="PurpleCipher*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="ciphers_get_ciphers" symbol="purple_ciphers_get_ciphers">
			<return-type type="GList*"/>
		</function>
		<function name="ciphers_get_handle" symbol="purple_ciphers_get_handle">
			<return-type type="gpointer"/>
		</function>
		<function name="ciphers_init" symbol="purple_ciphers_init">
			<return-type type="void"/>
		</function>
		<function name="ciphers_register_cipher" symbol="purple_ciphers_register_cipher">
			<return-type type="PurpleCipher*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
				<parameter name="ops" type="PurpleCipherOps*"/>
			</parameters>
		</function>
		<function name="ciphers_uninit" symbol="purple_ciphers_uninit">
			<return-type type="void"/>
		</function>
		<function name="ciphers_unregister_cipher" symbol="purple_ciphers_unregister_cipher">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="cipher" type="PurpleCipher*"/>
			</parameters>
		</function>
		<function name="cmd_do_command" symbol="purple_cmd_do_command">
			<return-type type="PurpleCmdStatus"/>
			<parameters>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="cmdline" type="gchar*"/>
				<parameter name="markup" type="gchar*"/>
				<parameter name="errormsg" type="gchar**"/>
			</parameters>
		</function>
		<function name="cmd_help" symbol="purple_cmd_help">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="cmd" type="gchar*"/>
			</parameters>
		</function>
		<function name="cmd_list" symbol="purple_cmd_list">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="conv" type="PurpleConversation*"/>
			</parameters>
		</function>
		<function name="cmd_register" symbol="purple_cmd_register">
			<return-type type="PurpleCmdId"/>
			<parameters>
				<parameter name="cmd" type="gchar*"/>
				<parameter name="args" type="gchar*"/>
				<parameter name="p" type="PurpleCmdPriority"/>
				<parameter name="f" type="PurpleCmdFlag"/>
				<parameter name="prpl_id" type="gchar*"/>
				<parameter name="func" type="PurpleCmdFunc"/>
				<parameter name="helpstr" type="gchar*"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</function>
		<function name="cmd_unregister" symbol="purple_cmd_unregister">
			<return-type type="void"/>
			<parameters>
				<parameter name="id" type="PurpleCmdId"/>
			</parameters>
		</function>
		<function name="cmds_get_handle" symbol="purple_cmds_get_handle">
			<return-type type="gpointer"/>
		</function>
		<function name="cmds_init" symbol="purple_cmds_init">
			<return-type type="void"/>
		</function>
		<function name="cmds_uninit" symbol="purple_cmds_uninit">
			<return-type type="void"/>
		</function>
		<function name="connections_disconnect_all" symbol="purple_connections_disconnect_all">
			<return-type type="void"/>
		</function>
		<function name="connections_get_all" symbol="purple_connections_get_all">
			<return-type type="GList*"/>
		</function>
		<function name="connections_get_connecting" symbol="purple_connections_get_connecting">
			<return-type type="GList*"/>
		</function>
		<function name="connections_get_handle" symbol="purple_connections_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="connections_get_ui_ops" symbol="purple_connections_get_ui_ops">
			<return-type type="PurpleConnectionUiOps*"/>
		</function>
		<function name="connections_init" symbol="purple_connections_init">
			<return-type type="void"/>
		</function>
		<function name="connections_set_ui_ops" symbol="purple_connections_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleConnectionUiOps*"/>
			</parameters>
		</function>
		<function name="connections_uninit" symbol="purple_connections_uninit">
			<return-type type="void"/>
		</function>
		<function name="conv_custom_smiley_add" symbol="purple_conv_custom_smiley_add">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="smile" type="char*"/>
				<parameter name="cksum_type" type="char*"/>
				<parameter name="chksum" type="char*"/>
				<parameter name="remote" type="gboolean"/>
			</parameters>
		</function>
		<function name="conv_custom_smiley_close" symbol="purple_conv_custom_smiley_close">
			<return-type type="void"/>
			<parameters>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="smile" type="char*"/>
			</parameters>
		</function>
		<function name="conv_custom_smiley_write" symbol="purple_conv_custom_smiley_write">
			<return-type type="void"/>
			<parameters>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="smile" type="char*"/>
				<parameter name="data" type="guchar*"/>
				<parameter name="size" type="gsize"/>
			</parameters>
		</function>
		<function name="conv_present_error" symbol="purple_conv_present_error">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="who" type="char*"/>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="what" type="char*"/>
			</parameters>
		</function>
		<function name="conv_send_confirm" symbol="purple_conv_send_confirm">
			<return-type type="void"/>
			<parameters>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="message" type="char*"/>
			</parameters>
		</function>
		<function name="conversations_get_handle" symbol="purple_conversations_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="conversations_init" symbol="purple_conversations_init">
			<return-type type="void"/>
		</function>
		<function name="conversations_set_ui_ops" symbol="purple_conversations_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleConversationUiOps*"/>
			</parameters>
		</function>
		<function name="conversations_uninit" symbol="purple_conversations_uninit">
			<return-type type="void"/>
		</function>
		<function name="date_format_full" symbol="purple_date_format_full">
			<return-type type="char*"/>
			<parameters>
				<parameter name="tm" type="struct tm*"/>
			</parameters>
		</function>
		<function name="date_format_long" symbol="purple_date_format_long">
			<return-type type="char*"/>
			<parameters>
				<parameter name="tm" type="struct tm*"/>
			</parameters>
		</function>
		<function name="date_format_short" symbol="purple_date_format_short">
			<return-type type="char*"/>
			<parameters>
				<parameter name="tm" type="struct tm*"/>
			</parameters>
		</function>
		<function name="dbus_get_handle" symbol="purple_dbus_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="dbus_get_init_error" symbol="purple_dbus_get_init_error">
			<return-type type="char*"/>
		</function>
		<function name="dbus_init" symbol="purple_dbus_init">
			<return-type type="void"/>
		</function>
		<function name="dbus_init_ids" symbol="purple_dbus_init_ids">
			<return-type type="void"/>
		</function>
		<function name="dbus_is_owner" symbol="purple_dbus_is_owner">
			<return-type type="gboolean"/>
		</function>
		<function name="dbus_register_pointer" symbol="purple_dbus_register_pointer">
			<return-type type="void"/>
			<parameters>
				<parameter name="node" type="gpointer"/>
				<parameter name="type" type="PurpleDBusType*"/>
			</parameters>
		</function>
		<function name="dbus_signal_emit_purple" symbol="purple_dbus_signal_emit_purple">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="num_values" type="int"/>
				<parameter name="values" type="PurpleValue**"/>
				<parameter name="vargs" type="va_list"/>
			</parameters>
		</function>
		<function name="dbus_uninit" symbol="purple_dbus_uninit">
			<return-type type="void"/>
		</function>
		<function name="dbus_unregister_pointer" symbol="purple_dbus_unregister_pointer">
			<return-type type="void"/>
			<parameters>
				<parameter name="node" type="gpointer"/>
			</parameters>
		</function>
		<function name="debug" symbol="purple_debug">
			<return-type type="void"/>
			<parameters>
				<parameter name="level" type="PurpleDebugLevel"/>
				<parameter name="category" type="char*"/>
				<parameter name="format" type="char*"/>
			</parameters>
		</function>
		<function name="debug_error" symbol="purple_debug_error">
			<return-type type="void"/>
			<parameters>
				<parameter name="category" type="char*"/>
				<parameter name="format" type="char*"/>
			</parameters>
		</function>
		<function name="debug_fatal" symbol="purple_debug_fatal">
			<return-type type="void"/>
			<parameters>
				<parameter name="category" type="char*"/>
				<parameter name="format" type="char*"/>
			</parameters>
		</function>
		<function name="debug_get_ui_ops" symbol="purple_debug_get_ui_ops">
			<return-type type="PurpleDebugUiOps*"/>
		</function>
		<function name="debug_info" symbol="purple_debug_info">
			<return-type type="void"/>
			<parameters>
				<parameter name="category" type="char*"/>
				<parameter name="format" type="char*"/>
			</parameters>
		</function>
		<function name="debug_init" symbol="purple_debug_init">
			<return-type type="void"/>
		</function>
		<function name="debug_is_enabled" symbol="purple_debug_is_enabled">
			<return-type type="gboolean"/>
		</function>
		<function name="debug_is_unsafe" symbol="purple_debug_is_unsafe">
			<return-type type="gboolean"/>
		</function>
		<function name="debug_is_verbose" symbol="purple_debug_is_verbose">
			<return-type type="gboolean"/>
		</function>
		<function name="debug_misc" symbol="purple_debug_misc">
			<return-type type="void"/>
			<parameters>
				<parameter name="category" type="char*"/>
				<parameter name="format" type="char*"/>
			</parameters>
		</function>
		<function name="debug_set_enabled" symbol="purple_debug_set_enabled">
			<return-type type="void"/>
			<parameters>
				<parameter name="enabled" type="gboolean"/>
			</parameters>
		</function>
		<function name="debug_set_ui_ops" symbol="purple_debug_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleDebugUiOps*"/>
			</parameters>
		</function>
		<function name="debug_set_unsafe" symbol="purple_debug_set_unsafe">
			<return-type type="void"/>
			<parameters>
				<parameter name="unsafe" type="gboolean"/>
			</parameters>
		</function>
		<function name="debug_set_verbose" symbol="purple_debug_set_verbose">
			<return-type type="void"/>
			<parameters>
				<parameter name="verbose" type="gboolean"/>
			</parameters>
		</function>
		<function name="debug_warning" symbol="purple_debug_warning">
			<return-type type="void"/>
			<parameters>
				<parameter name="category" type="char*"/>
				<parameter name="format" type="char*"/>
			</parameters>
		</function>
		<function name="dnsquery_a" symbol="purple_dnsquery_a">
			<return-type type="PurpleDnsQueryData*"/>
			<parameters>
				<parameter name="hostname" type="char*"/>
				<parameter name="port" type="int"/>
				<parameter name="callback" type="PurpleDnsQueryConnectFunction"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="dnsquery_destroy" symbol="purple_dnsquery_destroy">
			<return-type type="void"/>
			<parameters>
				<parameter name="query_data" type="PurpleDnsQueryData*"/>
			</parameters>
		</function>
		<function name="dnsquery_get_host" symbol="purple_dnsquery_get_host">
			<return-type type="char*"/>
			<parameters>
				<parameter name="query_data" type="PurpleDnsQueryData*"/>
			</parameters>
		</function>
		<function name="dnsquery_get_port" symbol="purple_dnsquery_get_port">
			<return-type type="unsigned"/>
			<parameters>
				<parameter name="query_data" type="PurpleDnsQueryData*"/>
			</parameters>
		</function>
		<function name="dnsquery_get_ui_ops" symbol="purple_dnsquery_get_ui_ops">
			<return-type type="PurpleDnsQueryUiOps*"/>
		</function>
		<function name="dnsquery_init" symbol="purple_dnsquery_init">
			<return-type type="void"/>
		</function>
		<function name="dnsquery_set_ui_ops" symbol="purple_dnsquery_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleDnsQueryUiOps*"/>
			</parameters>
		</function>
		<function name="dnsquery_uninit" symbol="purple_dnsquery_uninit">
			<return-type type="void"/>
		</function>
		<function name="email_is_valid" symbol="purple_email_is_valid">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="address" type="char*"/>
			</parameters>
		</function>
		<function name="escape_filename" symbol="purple_escape_filename">
			<return-type type="char*"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="eventloop_get_ui_ops" symbol="purple_eventloop_get_ui_ops">
			<return-type type="PurpleEventLoopUiOps*"/>
		</function>
		<function name="eventloop_set_ui_ops" symbol="purple_eventloop_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleEventLoopUiOps*"/>
			</parameters>
		</function>
		<function name="fd_get_ip" symbol="purple_fd_get_ip">
			<return-type type="char*"/>
			<parameters>
				<parameter name="fd" type="int"/>
			</parameters>
		</function>
		<function name="find_buddies" symbol="purple_find_buddies">
			<return-type type="GSList*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="find_buddy" symbol="purple_find_buddy">
			<return-type type="PurpleBuddy*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="find_buddy_in_group" symbol="purple_find_buddy_in_group">
			<return-type type="PurpleBuddy*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="name" type="char*"/>
				<parameter name="group" type="PurpleGroup*"/>
			</parameters>
		</function>
		<function name="find_chat" symbol="purple_find_chat">
			<return-type type="PurpleConversation*"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="id" type="int"/>
			</parameters>
		</function>
		<function name="find_conversation_with_account" symbol="purple_find_conversation_with_account">
			<return-type type="PurpleConversation*"/>
			<parameters>
				<parameter name="type" type="PurpleConversationType"/>
				<parameter name="name" type="char*"/>
				<parameter name="account" type="PurpleAccount*"/>
			</parameters>
		</function>
		<function name="find_group" symbol="purple_find_group">
			<return-type type="PurpleGroup*"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="find_pounce" symbol="purple_find_pounce">
			<return-type type="PurplePounce*"/>
			<parameters>
				<parameter name="pouncer" type="PurpleAccount*"/>
				<parameter name="pouncee" type="char*"/>
				<parameter name="events" type="PurplePounceEvent"/>
			</parameters>
		</function>
		<function name="find_prpl" symbol="purple_find_prpl">
			<return-type type="PurplePlugin*"/>
			<parameters>
				<parameter name="id" type="char*"/>
			</parameters>
		</function>
		<function name="gai_strerror" symbol="purple_gai_strerror">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="errnum" type="gint"/>
			</parameters>
		</function>
		<function name="get_attention_type_from_code" symbol="purple_get_attention_type_from_code">
			<return-type type="PurpleAttentionType*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="type_code" type="guint"/>
			</parameters>
		</function>
		<function name="get_blist" symbol="purple_get_blist">
			<return-type type="PurpleBuddyList*"/>
		</function>
		<function name="get_chats" symbol="purple_get_chats">
			<return-type type="GList*"/>
		</function>
		<function name="get_conversations" symbol="purple_get_conversations">
			<return-type type="GList*"/>
		</function>
		<function name="get_core" symbol="purple_get_core">
			<return-type type="PurpleCore*"/>
		</function>
		<function name="get_host_name" symbol="purple_get_host_name">
			<return-type type="gchar*"/>
		</function>
		<function name="get_ims" symbol="purple_get_ims">
			<return-type type="GList*"/>
		</function>
		<function name="get_tzoff_str" symbol="purple_get_tzoff_str">
			<return-type type="char*"/>
			<parameters>
				<parameter name="tm" type="struct tm*"/>
				<parameter name="iso" type="gboolean"/>
			</parameters>
		</function>
		<function name="global_proxy_get_info" symbol="purple_global_proxy_get_info">
			<return-type type="PurpleProxyInfo*"/>
		</function>
		<function name="global_proxy_set_info" symbol="purple_global_proxy_set_info">
			<return-type type="void"/>
			<parameters>
				<parameter name="info" type="PurpleProxyInfo*"/>
			</parameters>
		</function>
		<function name="got_protocol_handler_uri" symbol="purple_got_protocol_handler_uri">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="char*"/>
			</parameters>
		</function>
		<function name="home_dir" symbol="purple_home_dir">
			<return-type type="gchar*"/>
		</function>
		<function name="idle_get_ui_ops" symbol="purple_idle_get_ui_ops">
			<return-type type="PurpleIdleUiOps*"/>
		</function>
		<function name="idle_init" symbol="purple_idle_init">
			<return-type type="void"/>
		</function>
		<function name="idle_set" symbol="purple_idle_set">
			<return-type type="void"/>
			<parameters>
				<parameter name="time" type="time_t"/>
			</parameters>
		</function>
		<function name="idle_set_ui_ops" symbol="purple_idle_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleIdleUiOps*"/>
			</parameters>
		</function>
		<function name="idle_touch" symbol="purple_idle_touch">
			<return-type type="void"/>
		</function>
		<function name="idle_uninit" symbol="purple_idle_uninit">
			<return-type type="void"/>
		</function>
		<function name="imgstore_add" symbol="purple_imgstore_add">
			<return-type type="PurpleStoredImage*"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
				<parameter name="size" type="size_t"/>
				<parameter name="filename" type="char*"/>
			</parameters>
		</function>
		<function name="imgstore_add_with_id" symbol="purple_imgstore_add_with_id">
			<return-type type="int"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
				<parameter name="size" type="size_t"/>
				<parameter name="filename" type="char*"/>
			</parameters>
		</function>
		<function name="imgstore_find_by_id" symbol="purple_imgstore_find_by_id">
			<return-type type="PurpleStoredImage*"/>
			<parameters>
				<parameter name="id" type="int"/>
			</parameters>
		</function>
		<function name="imgstore_get_data" symbol="purple_imgstore_get_data">
			<return-type type="gconstpointer"/>
			<parameters>
				<parameter name="img" type="PurpleStoredImage*"/>
			</parameters>
		</function>
		<function name="imgstore_get_extension" symbol="purple_imgstore_get_extension">
			<return-type type="char*"/>
			<parameters>
				<parameter name="img" type="PurpleStoredImage*"/>
			</parameters>
		</function>
		<function name="imgstore_get_filename" symbol="purple_imgstore_get_filename">
			<return-type type="char*"/>
			<parameters>
				<parameter name="img" type="PurpleStoredImage*"/>
			</parameters>
		</function>
		<function name="imgstore_get_handle" symbol="purple_imgstore_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="imgstore_get_size" symbol="purple_imgstore_get_size">
			<return-type type="size_t"/>
			<parameters>
				<parameter name="img" type="PurpleStoredImage*"/>
			</parameters>
		</function>
		<function name="imgstore_init" symbol="purple_imgstore_init">
			<return-type type="void"/>
		</function>
		<function name="imgstore_new_from_file" symbol="purple_imgstore_new_from_file">
			<return-type type="PurpleStoredImage*"/>
			<parameters>
				<parameter name="path" type="char*"/>
			</parameters>
		</function>
		<function name="imgstore_ref" symbol="purple_imgstore_ref">
			<return-type type="PurpleStoredImage*"/>
			<parameters>
				<parameter name="img" type="PurpleStoredImage*"/>
			</parameters>
		</function>
		<function name="imgstore_ref_by_id" symbol="purple_imgstore_ref_by_id">
			<return-type type="void"/>
			<parameters>
				<parameter name="id" type="int"/>
			</parameters>
		</function>
		<function name="imgstore_uninit" symbol="purple_imgstore_uninit">
			<return-type type="void"/>
		</function>
		<function name="imgstore_unref" symbol="purple_imgstore_unref">
			<return-type type="PurpleStoredImage*"/>
			<parameters>
				<parameter name="img" type="PurpleStoredImage*"/>
			</parameters>
		</function>
		<function name="imgstore_unref_by_id" symbol="purple_imgstore_unref_by_id">
			<return-type type="void"/>
			<parameters>
				<parameter name="id" type="int"/>
			</parameters>
		</function>
		<function name="input_add" symbol="purple_input_add">
			<return-type type="guint"/>
			<parameters>
				<parameter name="fd" type="int"/>
				<parameter name="cond" type="PurpleInputCondition"/>
				<parameter name="func" type="PurpleInputFunction"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="input_get_error" symbol="purple_input_get_error">
			<return-type type="int"/>
			<parameters>
				<parameter name="fd" type="int"/>
				<parameter name="error" type="int*"/>
			</parameters>
		</function>
		<function name="input_remove" symbol="purple_input_remove">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="guint"/>
			</parameters>
		</function>
		<function name="ip_address_is_valid" symbol="purple_ip_address_is_valid">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="ip" type="char*"/>
			</parameters>
		</function>
		<function name="ipv4_address_is_valid" symbol="purple_ipv4_address_is_valid">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="ip" type="char*"/>
			</parameters>
		</function>
		<function name="ipv6_address_is_valid" symbol="purple_ipv6_address_is_valid">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="ip" type="char*"/>
			</parameters>
		</function>
		<function name="markup_escape_text" symbol="purple_markup_escape_text">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="text" type="gchar*"/>
				<parameter name="length" type="gssize"/>
			</parameters>
		</function>
		<function name="markup_extract_info_field" symbol="purple_markup_extract_info_field">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="len" type="int"/>
				<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
				<parameter name="start_token" type="char*"/>
				<parameter name="skip" type="int"/>
				<parameter name="end_token" type="char*"/>
				<parameter name="check_value" type="char"/>
				<parameter name="no_value_token" type="char*"/>
				<parameter name="display_name" type="char*"/>
				<parameter name="is_link" type="gboolean"/>
				<parameter name="link_prefix" type="char*"/>
				<parameter name="format_cb" type="PurpleInfoFieldFormatCallback"/>
			</parameters>
		</function>
		<function name="markup_find_tag" symbol="purple_markup_find_tag">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="needle" type="char*"/>
				<parameter name="haystack" type="char*"/>
				<parameter name="start" type="char**"/>
				<parameter name="end" type="char**"/>
				<parameter name="attributes" type="GData**"/>
			</parameters>
		</function>
		<function name="markup_get_css_property" symbol="purple_markup_get_css_property">
			<return-type type="char*"/>
			<parameters>
				<parameter name="style" type="gchar*"/>
				<parameter name="opt" type="gchar*"/>
			</parameters>
		</function>
		<function name="markup_get_tag_name" symbol="purple_markup_get_tag_name">
			<return-type type="char*"/>
			<parameters>
				<parameter name="tag" type="char*"/>
			</parameters>
		</function>
		<function name="markup_html_to_xhtml" symbol="purple_markup_html_to_xhtml">
			<return-type type="void"/>
			<parameters>
				<parameter name="html" type="char*"/>
				<parameter name="dest_xhtml" type="char**"/>
				<parameter name="dest_plain" type="char**"/>
			</parameters>
		</function>
		<function name="markup_is_rtl" symbol="purple_markup_is_rtl">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="html" type="char*"/>
			</parameters>
		</function>
		<function name="markup_linkify" symbol="purple_markup_linkify">
			<return-type type="char*"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="markup_slice" symbol="purple_markup_slice">
			<return-type type="char*"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="x" type="guint"/>
				<parameter name="y" type="guint"/>
			</parameters>
		</function>
		<function name="markup_strip_html" symbol="purple_markup_strip_html">
			<return-type type="char*"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="markup_unescape_entity" symbol="purple_markup_unescape_entity">
			<return-type type="char*"/>
			<parameters>
				<parameter name="text" type="char*"/>
				<parameter name="length" type="int*"/>
			</parameters>
		</function>
		<function name="marshal_BOOLEAN__INT_POINTER" symbol="purple_marshal_BOOLEAN__INT_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_BOOLEAN__POINTER" symbol="purple_marshal_BOOLEAN__POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_BOOLEAN__POINTER_POINTER" symbol="purple_marshal_BOOLEAN__POINTER_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_BOOLEAN__POINTER_POINTER_POINTER" symbol="purple_marshal_BOOLEAN__POINTER_POINTER_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_BOOLEAN__POINTER_POINTER_POINTER_POINTER" symbol="purple_marshal_BOOLEAN__POINTER_POINTER_POINTER_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_BOOLEAN__POINTER_POINTER_POINTER_POINTER_POINTER" symbol="purple_marshal_BOOLEAN__POINTER_POINTER_POINTER_POINTER_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_BOOLEAN__POINTER_POINTER_POINTER_POINTER_POINTER_POINTER" symbol="purple_marshal_BOOLEAN__POINTER_POINTER_POINTER_POINTER_POINTER_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_BOOLEAN__POINTER_POINTER_POINTER_POINTER_UINT" symbol="purple_marshal_BOOLEAN__POINTER_POINTER_POINTER_POINTER_UINT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_BOOLEAN__POINTER_POINTER_POINTER_UINT" symbol="purple_marshal_BOOLEAN__POINTER_POINTER_POINTER_UINT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_BOOLEAN__POINTER_POINTER_UINT" symbol="purple_marshal_BOOLEAN__POINTER_POINTER_UINT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_INT__INT" symbol="purple_marshal_INT__INT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_INT__INT_INT" symbol="purple_marshal_INT__INT_INT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_INT__POINTER_POINTER" symbol="purple_marshal_INT__POINTER_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_INT__POINTER_POINTER_POINTER_POINTER_POINTER" symbol="purple_marshal_INT__POINTER_POINTER_POINTER_POINTER_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_POINTER__POINTER_INT" symbol="purple_marshal_POINTER__POINTER_INT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_POINTER__POINTER_INT64" symbol="purple_marshal_POINTER__POINTER_INT64">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_POINTER__POINTER_INT64_BOOLEAN" symbol="purple_marshal_POINTER__POINTER_INT64_BOOLEAN">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_POINTER__POINTER_INT_BOOLEAN" symbol="purple_marshal_POINTER__POINTER_INT_BOOLEAN">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_POINTER__POINTER_POINTER" symbol="purple_marshal_POINTER__POINTER_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID" symbol="purple_marshal_VOID">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__INT" symbol="purple_marshal_VOID__INT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__INT_INT" symbol="purple_marshal_VOID__INT_INT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER" symbol="purple_marshal_VOID__POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_INT_INT" symbol="purple_marshal_VOID__POINTER_INT_INT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_INT_POINTER" symbol="purple_marshal_VOID__POINTER_INT_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_POINTER" symbol="purple_marshal_VOID__POINTER_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_POINTER_POINTER" symbol="purple_marshal_VOID__POINTER_POINTER_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_POINTER_POINTER_POINTER" symbol="purple_marshal_VOID__POINTER_POINTER_POINTER_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_POINTER_POINTER_POINTER_POINTER" symbol="purple_marshal_VOID__POINTER_POINTER_POINTER_POINTER_POINTER">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_POINTER_POINTER_POINTER_UINT" symbol="purple_marshal_VOID__POINTER_POINTER_POINTER_POINTER_UINT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_POINTER_POINTER_UINT" symbol="purple_marshal_VOID__POINTER_POINTER_POINTER_UINT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_POINTER_POINTER_UINT_UINT" symbol="purple_marshal_VOID__POINTER_POINTER_POINTER_UINT_UINT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_POINTER_UINT" symbol="purple_marshal_VOID__POINTER_POINTER_UINT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_POINTER_UINT_UINT" symbol="purple_marshal_VOID__POINTER_POINTER_UINT_UINT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="marshal_VOID__POINTER_UINT" symbol="purple_marshal_VOID__POINTER_UINT">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</function>
		<function name="message_meify" symbol="purple_message_meify">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="message" type="char*"/>
				<parameter name="len" type="gssize"/>
			</parameters>
		</function>
		<function name="mime_decode_field" symbol="purple_mime_decode_field">
			<return-type type="char*"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="mkstemp" symbol="purple_mkstemp">
			<return-type type="FILE*"/>
			<parameters>
				<parameter name="path" type="char**"/>
				<parameter name="binary" type="gboolean"/>
			</parameters>
		</function>
		<function name="network_convert_idn_to_ascii" symbol="purple_network_convert_idn_to_ascii">
			<return-type type="int"/>
			<parameters>
				<parameter name="in" type="gchar*"/>
				<parameter name="out" type="gchar**"/>
			</parameters>
		</function>
		<function name="network_force_online" symbol="purple_network_force_online">
			<return-type type="void"/>
		</function>
		<function name="network_get_handle" symbol="purple_network_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="network_get_local_system_ip" symbol="purple_network_get_local_system_ip">
			<return-type type="char*"/>
			<parameters>
				<parameter name="fd" type="int"/>
			</parameters>
		</function>
		<function name="network_get_my_ip" symbol="purple_network_get_my_ip">
			<return-type type="char*"/>
			<parameters>
				<parameter name="fd" type="int"/>
			</parameters>
		</function>
		<function name="network_get_port_from_fd" symbol="purple_network_get_port_from_fd">
			<return-type type="unsigned"/>
			<parameters>
				<parameter name="fd" type="int"/>
			</parameters>
		</function>
		<function name="network_get_public_ip" symbol="purple_network_get_public_ip">
			<return-type type="char*"/>
		</function>
		<function name="network_get_stun_ip" symbol="purple_network_get_stun_ip">
			<return-type type="gchar*"/>
		</function>
		<function name="network_get_turn_ip" symbol="purple_network_get_turn_ip">
			<return-type type="gchar*"/>
		</function>
		<function name="network_init" symbol="purple_network_init">
			<return-type type="void"/>
		</function>
		<function name="network_ip_atoi" symbol="purple_network_ip_atoi">
			<return-type type="unsigned*"/>
			<parameters>
				<parameter name="ip" type="char*"/>
			</parameters>
		</function>
		<function name="network_is_available" symbol="purple_network_is_available">
			<return-type type="gboolean"/>
		</function>
		<function name="network_listen" symbol="purple_network_listen">
			<return-type type="PurpleNetworkListenData*"/>
			<parameters>
				<parameter name="port" type="unsigned"/>
				<parameter name="socket_type" type="int"/>
				<parameter name="cb" type="PurpleNetworkListenCallback"/>
				<parameter name="cb_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="network_listen_cancel" symbol="purple_network_listen_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="listen_data" type="PurpleNetworkListenData*"/>
			</parameters>
		</function>
		<function name="network_listen_map_external" symbol="purple_network_listen_map_external">
			<return-type type="void"/>
			<parameters>
				<parameter name="map_external" type="gboolean"/>
			</parameters>
		</function>
		<function name="network_listen_range" symbol="purple_network_listen_range">
			<return-type type="PurpleNetworkListenData*"/>
			<parameters>
				<parameter name="start" type="unsigned"/>
				<parameter name="end" type="unsigned"/>
				<parameter name="socket_type" type="int"/>
				<parameter name="cb" type="PurpleNetworkListenCallback"/>
				<parameter name="cb_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="network_remove_port_mapping" symbol="purple_network_remove_port_mapping">
			<return-type type="void"/>
			<parameters>
				<parameter name="fd" type="gint"/>
			</parameters>
		</function>
		<function name="network_set_public_ip" symbol="purple_network_set_public_ip">
			<return-type type="void"/>
			<parameters>
				<parameter name="ip" type="char*"/>
			</parameters>
		</function>
		<function name="network_set_stun_server" symbol="purple_network_set_stun_server">
			<return-type type="void"/>
			<parameters>
				<parameter name="stun_server" type="gchar*"/>
			</parameters>
		</function>
		<function name="network_set_turn_server" symbol="purple_network_set_turn_server">
			<return-type type="void"/>
			<parameters>
				<parameter name="turn_server" type="gchar*"/>
			</parameters>
		</function>
		<function name="network_uninit" symbol="purple_network_uninit">
			<return-type type="void"/>
		</function>
		<function name="normalize" symbol="purple_normalize">
			<return-type type="char*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="normalize_nocase" symbol="purple_normalize_nocase">
			<return-type type="char*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="notify_close" symbol="purple_notify_close">
			<return-type type="void"/>
			<parameters>
				<parameter name="type" type="PurpleNotifyType"/>
				<parameter name="ui_handle" type="void*"/>
			</parameters>
		</function>
		<function name="notify_close_with_handle" symbol="purple_notify_close_with_handle">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="void*"/>
			</parameters>
		</function>
		<function name="notify_email" symbol="purple_notify_email">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="subject" type="char*"/>
				<parameter name="from" type="char*"/>
				<parameter name="to" type="char*"/>
				<parameter name="url" type="char*"/>
				<parameter name="cb" type="PurpleNotifyCloseCallback"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="notify_emails" symbol="purple_notify_emails">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="count" type="size_t"/>
				<parameter name="detailed" type="gboolean"/>
				<parameter name="subjects" type="char**"/>
				<parameter name="froms" type="char**"/>
				<parameter name="tos" type="char**"/>
				<parameter name="urls" type="char**"/>
				<parameter name="cb" type="PurpleNotifyCloseCallback"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="notify_formatted" symbol="purple_notify_formatted">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="title" type="char*"/>
				<parameter name="primary" type="char*"/>
				<parameter name="secondary" type="char*"/>
				<parameter name="text" type="char*"/>
				<parameter name="cb" type="PurpleNotifyCloseCallback"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="notify_get_handle" symbol="purple_notify_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="notify_get_ui_ops" symbol="purple_notify_get_ui_ops">
			<return-type type="PurpleNotifyUiOps*"/>
		</function>
		<function name="notify_init" symbol="purple_notify_init">
			<return-type type="void"/>
		</function>
		<function name="notify_message" symbol="purple_notify_message">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="type" type="PurpleNotifyMsgType"/>
				<parameter name="title" type="char*"/>
				<parameter name="primary" type="char*"/>
				<parameter name="secondary" type="char*"/>
				<parameter name="cb" type="PurpleNotifyCloseCallback"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="notify_searchresults" symbol="purple_notify_searchresults">
			<return-type type="void*"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="title" type="char*"/>
				<parameter name="primary" type="char*"/>
				<parameter name="secondary" type="char*"/>
				<parameter name="results" type="PurpleNotifySearchResults*"/>
				<parameter name="cb" type="PurpleNotifyCloseCallback"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="notify_set_ui_ops" symbol="purple_notify_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleNotifyUiOps*"/>
			</parameters>
		</function>
		<function name="notify_uninit" symbol="purple_notify_uninit">
			<return-type type="void"/>
		</function>
		<function name="notify_uri" symbol="purple_notify_uri">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="uri" type="char*"/>
			</parameters>
		</function>
		<function name="notify_userinfo" symbol="purple_notify_userinfo">
			<return-type type="void*"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="who" type="char*"/>
				<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
				<parameter name="cb" type="PurpleNotifyCloseCallback"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="ntlm_gen_type1" symbol="purple_ntlm_gen_type1">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="domain" type="gchar*"/>
			</parameters>
		</function>
		<function name="ntlm_gen_type3" symbol="purple_ntlm_gen_type3">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="username" type="gchar*"/>
				<parameter name="passw" type="gchar*"/>
				<parameter name="hostname" type="gchar*"/>
				<parameter name="domain" type="gchar*"/>
				<parameter name="nonce" type="guint8*"/>
				<parameter name="flags" type="guint32*"/>
			</parameters>
		</function>
		<function name="ntlm_parse_type2" symbol="purple_ntlm_parse_type2">
			<return-type type="guint8*"/>
			<parameters>
				<parameter name="type2" type="gchar*"/>
				<parameter name="flags" type="guint32*"/>
			</parameters>
		</function>
		<function name="plugins_add_search_path" symbol="purple_plugins_add_search_path">
			<return-type type="void"/>
			<parameters>
				<parameter name="path" type="char*"/>
			</parameters>
		</function>
		<function name="plugins_destroy_all" symbol="purple_plugins_destroy_all">
			<return-type type="void"/>
		</function>
		<function name="plugins_enabled" symbol="purple_plugins_enabled">
			<return-type type="gboolean"/>
		</function>
		<function name="plugins_find_with_basename" symbol="purple_plugins_find_with_basename">
			<return-type type="PurplePlugin*"/>
			<parameters>
				<parameter name="basename" type="char*"/>
			</parameters>
		</function>
		<function name="plugins_find_with_filename" symbol="purple_plugins_find_with_filename">
			<return-type type="PurplePlugin*"/>
			<parameters>
				<parameter name="filename" type="char*"/>
			</parameters>
		</function>
		<function name="plugins_find_with_id" symbol="purple_plugins_find_with_id">
			<return-type type="PurplePlugin*"/>
			<parameters>
				<parameter name="id" type="char*"/>
			</parameters>
		</function>
		<function name="plugins_find_with_name" symbol="purple_plugins_find_with_name">
			<return-type type="PurplePlugin*"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="plugins_get_all" symbol="purple_plugins_get_all">
			<return-type type="GList*"/>
		</function>
		<function name="plugins_get_handle" symbol="purple_plugins_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="plugins_get_loaded" symbol="purple_plugins_get_loaded">
			<return-type type="GList*"/>
		</function>
		<function name="plugins_get_protocols" symbol="purple_plugins_get_protocols">
			<return-type type="GList*"/>
		</function>
		<function name="plugins_get_search_paths" symbol="purple_plugins_get_search_paths">
			<return-type type="GList*"/>
		</function>
		<function name="plugins_init" symbol="purple_plugins_init">
			<return-type type="void"/>
		</function>
		<function name="plugins_load_saved" symbol="purple_plugins_load_saved">
			<return-type type="void"/>
			<parameters>
				<parameter name="key" type="char*"/>
			</parameters>
		</function>
		<function name="plugins_probe" symbol="purple_plugins_probe">
			<return-type type="void"/>
			<parameters>
				<parameter name="ext" type="char*"/>
			</parameters>
		</function>
		<function name="plugins_register_load_notify_cb" symbol="purple_plugins_register_load_notify_cb">
			<return-type type="void"/>
			<parameters>
				<parameter name="func" type="GCallback"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</function>
		<function name="plugins_register_probe_notify_cb" symbol="purple_plugins_register_probe_notify_cb">
			<return-type type="void"/>
			<parameters>
				<parameter name="func" type="GCallback"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</function>
		<function name="plugins_register_unload_notify_cb" symbol="purple_plugins_register_unload_notify_cb">
			<return-type type="void"/>
			<parameters>
				<parameter name="func" type="GCallback"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</function>
		<function name="plugins_save_loaded" symbol="purple_plugins_save_loaded">
			<return-type type="void"/>
			<parameters>
				<parameter name="key" type="char*"/>
			</parameters>
		</function>
		<function name="plugins_uninit" symbol="purple_plugins_uninit">
			<return-type type="void"/>
		</function>
		<function name="plugins_unload" symbol="purple_plugins_unload">
			<return-type type="void"/>
			<parameters>
				<parameter name="type" type="PurplePluginType"/>
			</parameters>
		</function>
		<function name="plugins_unload_all" symbol="purple_plugins_unload_all">
			<return-type type="void"/>
		</function>
		<function name="plugins_unregister_load_notify_cb" symbol="purple_plugins_unregister_load_notify_cb">
			<return-type type="void"/>
			<parameters>
				<parameter name="func" type="GCallback"/>
			</parameters>
		</function>
		<function name="plugins_unregister_probe_notify_cb" symbol="purple_plugins_unregister_probe_notify_cb">
			<return-type type="void"/>
			<parameters>
				<parameter name="func" type="GCallback"/>
			</parameters>
		</function>
		<function name="plugins_unregister_unload_notify_cb" symbol="purple_plugins_unregister_unload_notify_cb">
			<return-type type="void"/>
			<parameters>
				<parameter name="func" type="GCallback"/>
			</parameters>
		</function>
		<function name="pmp_create_map" symbol="purple_pmp_create_map">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="type" type="PurplePmpType"/>
				<parameter name="privateport" type="unsigned"/>
				<parameter name="publicport" type="unsigned"/>
				<parameter name="lifetime" type="int"/>
			</parameters>
		</function>
		<function name="pmp_destroy_map" symbol="purple_pmp_destroy_map">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="type" type="PurplePmpType"/>
				<parameter name="privateport" type="unsigned"/>
			</parameters>
		</function>
		<function name="pmp_get_public_ip" symbol="purple_pmp_get_public_ip">
			<return-type type="char*"/>
		</function>
		<function name="pmp_init" symbol="purple_pmp_init">
			<return-type type="void"/>
		</function>
		<function name="pounces_get_all" symbol="purple_pounces_get_all">
			<return-type type="GList*"/>
		</function>
		<function name="pounces_get_all_for_ui" symbol="purple_pounces_get_all_for_ui">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="ui" type="char*"/>
			</parameters>
		</function>
		<function name="pounces_get_handle" symbol="purple_pounces_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="pounces_init" symbol="purple_pounces_init">
			<return-type type="void"/>
		</function>
		<function name="pounces_load" symbol="purple_pounces_load">
			<return-type type="gboolean"/>
		</function>
		<function name="pounces_register_handler" symbol="purple_pounces_register_handler">
			<return-type type="void"/>
			<parameters>
				<parameter name="ui" type="char*"/>
				<parameter name="cb" type="PurplePounceCb"/>
				<parameter name="new_pounce" type="GCallback"/>
				<parameter name="free_pounce" type="GCallback"/>
			</parameters>
		</function>
		<function name="pounces_uninit" symbol="purple_pounces_uninit">
			<return-type type="void"/>
		</function>
		<function name="pounces_unregister_handler" symbol="purple_pounces_unregister_handler">
			<return-type type="void"/>
			<parameters>
				<parameter name="ui" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_add_bool" symbol="purple_prefs_add_bool">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="gboolean"/>
			</parameters>
		</function>
		<function name="prefs_add_int" symbol="purple_prefs_add_int">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="int"/>
			</parameters>
		</function>
		<function name="prefs_add_none" symbol="purple_prefs_add_none">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_add_path" symbol="purple_prefs_add_path">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_add_path_list" symbol="purple_prefs_add_path_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="GList*"/>
			</parameters>
		</function>
		<function name="prefs_add_string" symbol="purple_prefs_add_string">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_add_string_list" symbol="purple_prefs_add_string_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="GList*"/>
			</parameters>
		</function>
		<function name="prefs_connect_callback" symbol="purple_prefs_connect_callback">
			<return-type type="guint"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="name" type="char*"/>
				<parameter name="cb" type="PurplePrefCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="prefs_destroy" symbol="purple_prefs_destroy">
			<return-type type="void"/>
		</function>
		<function name="prefs_disconnect_by_handle" symbol="purple_prefs_disconnect_by_handle">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="void*"/>
			</parameters>
		</function>
		<function name="prefs_disconnect_callback" symbol="purple_prefs_disconnect_callback">
			<return-type type="void"/>
			<parameters>
				<parameter name="callback_id" type="guint"/>
			</parameters>
		</function>
		<function name="prefs_exists" symbol="purple_prefs_exists">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_get_bool" symbol="purple_prefs_get_bool">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_get_children_names" symbol="purple_prefs_get_children_names">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_get_handle" symbol="purple_prefs_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="prefs_get_int" symbol="purple_prefs_get_int">
			<return-type type="int"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_get_path" symbol="purple_prefs_get_path">
			<return-type type="char*"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_get_path_list" symbol="purple_prefs_get_path_list">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_get_string" symbol="purple_prefs_get_string">
			<return-type type="char*"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_get_string_list" symbol="purple_prefs_get_string_list">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_get_type" symbol="purple_prefs_get_type">
			<return-type type="PurplePrefType"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_init" symbol="purple_prefs_init">
			<return-type type="void"/>
		</function>
		<function name="prefs_load" symbol="purple_prefs_load">
			<return-type type="gboolean"/>
		</function>
		<function name="prefs_remove" symbol="purple_prefs_remove">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_rename" symbol="purple_prefs_rename">
			<return-type type="void"/>
			<parameters>
				<parameter name="oldname" type="char*"/>
				<parameter name="newname" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_rename_boolean_toggle" symbol="purple_prefs_rename_boolean_toggle">
			<return-type type="void"/>
			<parameters>
				<parameter name="oldname" type="char*"/>
				<parameter name="newname" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_set_bool" symbol="purple_prefs_set_bool">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="gboolean"/>
			</parameters>
		</function>
		<function name="prefs_set_generic" symbol="purple_prefs_set_generic">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="gpointer"/>
			</parameters>
		</function>
		<function name="prefs_set_int" symbol="purple_prefs_set_int">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="int"/>
			</parameters>
		</function>
		<function name="prefs_set_path" symbol="purple_prefs_set_path">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_set_path_list" symbol="purple_prefs_set_path_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="GList*"/>
			</parameters>
		</function>
		<function name="prefs_set_string" symbol="purple_prefs_set_string">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_set_string_list" symbol="purple_prefs_set_string_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="GList*"/>
			</parameters>
		</function>
		<function name="prefs_trigger_callback" symbol="purple_prefs_trigger_callback">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="prefs_uninit" symbol="purple_prefs_uninit">
			<return-type type="void"/>
		</function>
		<function name="prefs_update_old" symbol="purple_prefs_update_old">
			<return-type type="void"/>
		</function>
		<function name="primitive_get_id_from_type" symbol="purple_primitive_get_id_from_type">
			<return-type type="char*"/>
			<parameters>
				<parameter name="type" type="PurpleStatusPrimitive"/>
			</parameters>
		</function>
		<function name="primitive_get_name_from_type" symbol="purple_primitive_get_name_from_type">
			<return-type type="char*"/>
			<parameters>
				<parameter name="type" type="PurpleStatusPrimitive"/>
			</parameters>
		</function>
		<function name="primitive_get_type_from_id" symbol="purple_primitive_get_type_from_id">
			<return-type type="PurpleStatusPrimitive"/>
			<parameters>
				<parameter name="id" type="char*"/>
			</parameters>
		</function>
		<function name="print_utf8_to_console" symbol="purple_print_utf8_to_console">
			<return-type type="void"/>
			<parameters>
				<parameter name="filestream" type="FILE*"/>
				<parameter name="message" type="char*"/>
			</parameters>
		</function>
		<function name="privacy_allow" symbol="purple_privacy_allow">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
				<parameter name="local" type="gboolean"/>
				<parameter name="restore" type="gboolean"/>
			</parameters>
		</function>
		<function name="privacy_check" symbol="purple_privacy_check">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
			</parameters>
		</function>
		<function name="privacy_deny" symbol="purple_privacy_deny">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
				<parameter name="local" type="gboolean"/>
				<parameter name="restore" type="gboolean"/>
			</parameters>
		</function>
		<function name="privacy_deny_add" symbol="purple_privacy_deny_add">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="name" type="char*"/>
				<parameter name="local_only" type="gboolean"/>
			</parameters>
		</function>
		<function name="privacy_deny_remove" symbol="purple_privacy_deny_remove">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="name" type="char*"/>
				<parameter name="local_only" type="gboolean"/>
			</parameters>
		</function>
		<function name="privacy_get_ui_ops" symbol="purple_privacy_get_ui_ops">
			<return-type type="PurplePrivacyUiOps*"/>
		</function>
		<function name="privacy_init" symbol="purple_privacy_init">
			<return-type type="void"/>
		</function>
		<function name="privacy_permit_add" symbol="purple_privacy_permit_add">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="name" type="char*"/>
				<parameter name="local_only" type="gboolean"/>
			</parameters>
		</function>
		<function name="privacy_permit_remove" symbol="purple_privacy_permit_remove">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="name" type="char*"/>
				<parameter name="local_only" type="gboolean"/>
			</parameters>
		</function>
		<function name="privacy_set_ui_ops" symbol="purple_privacy_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurplePrivacyUiOps*"/>
			</parameters>
		</function>
		<function name="program_is_valid" symbol="purple_program_is_valid">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="program" type="char*"/>
			</parameters>
		</function>
		<function name="proxy_connect" symbol="purple_proxy_connect">
			<return-type type="PurpleProxyConnectData*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="host" type="char*"/>
				<parameter name="port" type="int"/>
				<parameter name="connect_cb" type="PurpleProxyConnectFunction"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="proxy_connect_cancel" symbol="purple_proxy_connect_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="connect_data" type="PurpleProxyConnectData*"/>
			</parameters>
		</function>
		<function name="proxy_connect_cancel_with_handle" symbol="purple_proxy_connect_cancel_with_handle">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="void*"/>
			</parameters>
		</function>
		<function name="proxy_connect_socks5" symbol="purple_proxy_connect_socks5">
			<return-type type="PurpleProxyConnectData*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="gpi" type="PurpleProxyInfo*"/>
				<parameter name="host" type="char*"/>
				<parameter name="port" type="int"/>
				<parameter name="connect_cb" type="PurpleProxyConnectFunction"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="proxy_connect_udp" symbol="purple_proxy_connect_udp">
			<return-type type="PurpleProxyConnectData*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="host" type="char*"/>
				<parameter name="port" type="int"/>
				<parameter name="connect_cb" type="PurpleProxyConnectFunction"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="proxy_get_handle" symbol="purple_proxy_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="proxy_get_setup" symbol="purple_proxy_get_setup">
			<return-type type="PurpleProxyInfo*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
			</parameters>
		</function>
		<function name="proxy_init" symbol="purple_proxy_init">
			<return-type type="void"/>
		</function>
		<function name="proxy_uninit" symbol="purple_proxy_uninit">
			<return-type type="void"/>
		</function>
		<function name="prpl_change_account_status" symbol="purple_prpl_change_account_status">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="old_status" type="PurpleStatus*"/>
				<parameter name="new_status" type="PurpleStatus*"/>
			</parameters>
		</function>
		<function name="prpl_get_media_caps" symbol="purple_prpl_get_media_caps">
			<return-type type="PurpleMediaCaps"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
			</parameters>
		</function>
		<function name="prpl_get_statuses" symbol="purple_prpl_get_statuses">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="presence" type="PurplePresence*"/>
			</parameters>
		</function>
		<function name="prpl_got_account_actions" symbol="purple_prpl_got_account_actions">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
			</parameters>
		</function>
		<function name="prpl_got_account_idle" symbol="purple_prpl_got_account_idle">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="idle" type="gboolean"/>
				<parameter name="idle_time" type="time_t"/>
			</parameters>
		</function>
		<function name="prpl_got_account_login_time" symbol="purple_prpl_got_account_login_time">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="login_time" type="time_t"/>
			</parameters>
		</function>
		<function name="prpl_got_account_status" symbol="purple_prpl_got_account_status">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="status_id" type="char*"/>
			</parameters>
		</function>
		<function name="prpl_got_attention" symbol="purple_prpl_got_attention">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="who" type="char*"/>
				<parameter name="type_code" type="guint"/>
			</parameters>
		</function>
		<function name="prpl_got_attention_in_chat" symbol="purple_prpl_got_attention_in_chat">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="id" type="int"/>
				<parameter name="who" type="char*"/>
				<parameter name="type_code" type="guint"/>
			</parameters>
		</function>
		<function name="prpl_got_user_idle" symbol="purple_prpl_got_user_idle">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="name" type="char*"/>
				<parameter name="idle" type="gboolean"/>
				<parameter name="idle_time" type="time_t"/>
			</parameters>
		</function>
		<function name="prpl_got_user_login_time" symbol="purple_prpl_got_user_login_time">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="name" type="char*"/>
				<parameter name="login_time" type="time_t"/>
			</parameters>
		</function>
		<function name="prpl_got_user_status" symbol="purple_prpl_got_user_status">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="name" type="char*"/>
				<parameter name="status_id" type="char*"/>
			</parameters>
		</function>
		<function name="prpl_got_user_status_deactive" symbol="purple_prpl_got_user_status_deactive">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="name" type="char*"/>
				<parameter name="status_id" type="char*"/>
			</parameters>
		</function>
		<function name="prpl_initiate_media" symbol="purple_prpl_initiate_media">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
				<parameter name="type" type="PurpleMediaSessionType"/>
			</parameters>
		</function>
		<function name="prpl_send_attention" symbol="purple_prpl_send_attention">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="who" type="char*"/>
				<parameter name="type_code" type="guint"/>
			</parameters>
		</function>
		<function name="quotedp_decode" symbol="purple_quotedp_decode">
			<return-type type="guchar*"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="ret_len" type="gsize*"/>
			</parameters>
		</function>
		<function name="request_action" symbol="purple_request_action">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="title" type="char*"/>
				<parameter name="primary" type="char*"/>
				<parameter name="secondary" type="char*"/>
				<parameter name="default_action" type="int"/>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="user_data" type="void*"/>
				<parameter name="action_count" type="size_t"/>
			</parameters>
		</function>
		<function name="request_action_varg" symbol="purple_request_action_varg">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="title" type="char*"/>
				<parameter name="primary" type="char*"/>
				<parameter name="secondary" type="char*"/>
				<parameter name="default_action" type="int"/>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="user_data" type="void*"/>
				<parameter name="action_count" type="size_t"/>
				<parameter name="actions" type="va_list"/>
			</parameters>
		</function>
		<function name="request_choice" symbol="purple_request_choice">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="title" type="char*"/>
				<parameter name="primary" type="char*"/>
				<parameter name="secondary" type="char*"/>
				<parameter name="default_value" type="int"/>
				<parameter name="ok_text" type="char*"/>
				<parameter name="ok_cb" type="GCallback"/>
				<parameter name="cancel_text" type="char*"/>
				<parameter name="cancel_cb" type="GCallback"/>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="user_data" type="void*"/>
			</parameters>
		</function>
		<function name="request_choice_varg" symbol="purple_request_choice_varg">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="title" type="char*"/>
				<parameter name="primary" type="char*"/>
				<parameter name="secondary" type="char*"/>
				<parameter name="default_value" type="int"/>
				<parameter name="ok_text" type="char*"/>
				<parameter name="ok_cb" type="GCallback"/>
				<parameter name="cancel_text" type="char*"/>
				<parameter name="cancel_cb" type="GCallback"/>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="user_data" type="void*"/>
				<parameter name="choices" type="va_list"/>
			</parameters>
		</function>
		<function name="request_close" symbol="purple_request_close">
			<return-type type="void"/>
			<parameters>
				<parameter name="type" type="PurpleRequestType"/>
				<parameter name="uihandle" type="void*"/>
			</parameters>
		</function>
		<function name="request_close_with_handle" symbol="purple_request_close_with_handle">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="void*"/>
			</parameters>
		</function>
		<function name="request_fields" symbol="purple_request_fields">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="title" type="char*"/>
				<parameter name="primary" type="char*"/>
				<parameter name="secondary" type="char*"/>
				<parameter name="fields" type="PurpleRequestFields*"/>
				<parameter name="ok_text" type="char*"/>
				<parameter name="ok_cb" type="GCallback"/>
				<parameter name="cancel_text" type="char*"/>
				<parameter name="cancel_cb" type="GCallback"/>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="user_data" type="void*"/>
			</parameters>
		</function>
		<function name="request_file" symbol="purple_request_file">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="title" type="char*"/>
				<parameter name="filename" type="char*"/>
				<parameter name="savedialog" type="gboolean"/>
				<parameter name="ok_cb" type="GCallback"/>
				<parameter name="cancel_cb" type="GCallback"/>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="user_data" type="void*"/>
			</parameters>
		</function>
		<function name="request_folder" symbol="purple_request_folder">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="title" type="char*"/>
				<parameter name="dirname" type="char*"/>
				<parameter name="ok_cb" type="GCallback"/>
				<parameter name="cancel_cb" type="GCallback"/>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="user_data" type="void*"/>
			</parameters>
		</function>
		<function name="request_get_ui_ops" symbol="purple_request_get_ui_ops">
			<return-type type="PurpleRequestUiOps*"/>
		</function>
		<function name="request_input" symbol="purple_request_input">
			<return-type type="void*"/>
			<parameters>
				<parameter name="handle" type="void*"/>
				<parameter name="title" type="char*"/>
				<parameter name="primary" type="char*"/>
				<parameter name="secondary" type="char*"/>
				<parameter name="default_value" type="char*"/>
				<parameter name="multiline" type="gboolean"/>
				<parameter name="masked" type="gboolean"/>
				<parameter name="hint" type="gchar*"/>
				<parameter name="ok_text" type="char*"/>
				<parameter name="ok_cb" type="GCallback"/>
				<parameter name="cancel_text" type="char*"/>
				<parameter name="cancel_cb" type="GCallback"/>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="who" type="char*"/>
				<parameter name="conv" type="PurpleConversation*"/>
				<parameter name="user_data" type="void*"/>
			</parameters>
		</function>
		<function name="request_set_ui_ops" symbol="purple_request_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleRequestUiOps*"/>
			</parameters>
		</function>
		<function name="restore_default_signal_handlers" symbol="purple_restore_default_signal_handlers">
			<return-type type="void"/>
		</function>
		<function name="running_gnome" symbol="purple_running_gnome">
			<return-type type="gboolean"/>
		</function>
		<function name="running_kde" symbol="purple_running_kde">
			<return-type type="gboolean"/>
		</function>
		<function name="running_osx" symbol="purple_running_osx">
			<return-type type="gboolean"/>
		</function>
		<function name="savedstatuses_get_all" symbol="purple_savedstatuses_get_all">
			<return-type type="GList*"/>
		</function>
		<function name="savedstatuses_get_handle" symbol="purple_savedstatuses_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="savedstatuses_get_popular" symbol="purple_savedstatuses_get_popular">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="how_many" type="unsigned"/>
			</parameters>
		</function>
		<function name="savedstatuses_init" symbol="purple_savedstatuses_init">
			<return-type type="void"/>
		</function>
		<function name="savedstatuses_uninit" symbol="purple_savedstatuses_uninit">
			<return-type type="void"/>
		</function>
		<function name="serv_add_deny" symbol="serv_add_deny">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="p2" type="char*"/>
			</parameters>
		</function>
		<function name="serv_add_permit" symbol="serv_add_permit">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="p2" type="char*"/>
			</parameters>
		</function>
		<function name="serv_alias_buddy" symbol="serv_alias_buddy">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleBuddy*"/>
			</parameters>
		</function>
		<function name="serv_chat_invite" symbol="serv_chat_invite">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="p2" type="int"/>
				<parameter name="p3" type="char*"/>
				<parameter name="p4" type="char*"/>
			</parameters>
		</function>
		<function name="serv_chat_leave" symbol="serv_chat_leave">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="p2" type="int"/>
			</parameters>
		</function>
		<function name="serv_chat_send" symbol="serv_chat_send">
			<return-type type="int"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="p2" type="int"/>
				<parameter name="p3" type="char*"/>
				<parameter name="flags" type="PurpleMessageFlags"/>
			</parameters>
		</function>
		<function name="serv_chat_whisper" symbol="serv_chat_whisper">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="p2" type="int"/>
				<parameter name="p3" type="char*"/>
				<parameter name="p4" type="char*"/>
			</parameters>
		</function>
		<function name="serv_get_info" symbol="serv_get_info">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="p2" type="char*"/>
			</parameters>
		</function>
		<function name="serv_got_alias" symbol="serv_got_alias">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="who" type="char*"/>
				<parameter name="alias" type="char*"/>
			</parameters>
		</function>
		<function name="serv_got_attention" symbol="serv_got_attention">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="who" type="char*"/>
				<parameter name="type_code" type="guint"/>
			</parameters>
		</function>
		<function name="serv_got_chat_in" symbol="serv_got_chat_in">
			<return-type type="void"/>
			<parameters>
				<parameter name="g" type="PurpleConnection*"/>
				<parameter name="id" type="int"/>
				<parameter name="who" type="char*"/>
				<parameter name="flags" type="PurpleMessageFlags"/>
				<parameter name="message" type="char*"/>
				<parameter name="mtime" type="time_t"/>
			</parameters>
		</function>
		<function name="serv_got_chat_invite" symbol="serv_got_chat_invite">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="name" type="char*"/>
				<parameter name="who" type="char*"/>
				<parameter name="message" type="char*"/>
				<parameter name="data" type="GHashTable*"/>
			</parameters>
		</function>
		<function name="serv_got_chat_left" symbol="serv_got_chat_left">
			<return-type type="void"/>
			<parameters>
				<parameter name="g" type="PurpleConnection*"/>
				<parameter name="id" type="int"/>
			</parameters>
		</function>
		<function name="serv_got_im" symbol="serv_got_im">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="who" type="char*"/>
				<parameter name="msg" type="char*"/>
				<parameter name="flags" type="PurpleMessageFlags"/>
				<parameter name="mtime" type="time_t"/>
			</parameters>
		</function>
		<function name="serv_got_join_chat_failed" symbol="purple_serv_got_join_chat_failed">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="data" type="GHashTable*"/>
			</parameters>
		</function>
		<function name="serv_got_joined_chat" symbol="serv_got_joined_chat">
			<return-type type="PurpleConversation*"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="id" type="int"/>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="serv_got_private_alias" symbol="purple_serv_got_private_alias">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="who" type="char*"/>
				<parameter name="alias" type="char*"/>
			</parameters>
		</function>
		<function name="serv_got_typing" symbol="serv_got_typing">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="name" type="char*"/>
				<parameter name="timeout" type="int"/>
				<parameter name="state" type="PurpleTypingState"/>
			</parameters>
		</function>
		<function name="serv_got_typing_stopped" symbol="serv_got_typing_stopped">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="serv_join_chat" symbol="serv_join_chat">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="data" type="GHashTable*"/>
			</parameters>
		</function>
		<function name="serv_move_buddy" symbol="serv_move_buddy">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleBuddy*"/>
				<parameter name="p2" type="PurpleGroup*"/>
				<parameter name="p3" type="PurpleGroup*"/>
			</parameters>
		</function>
		<function name="serv_reject_chat" symbol="serv_reject_chat">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="data" type="GHashTable*"/>
			</parameters>
		</function>
		<function name="serv_rem_deny" symbol="serv_rem_deny">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="p2" type="char*"/>
			</parameters>
		</function>
		<function name="serv_rem_permit" symbol="serv_rem_permit">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="p2" type="char*"/>
			</parameters>
		</function>
		<function name="serv_send_attention" symbol="serv_send_attention">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="who" type="char*"/>
				<parameter name="type_code" type="guint"/>
			</parameters>
		</function>
		<function name="serv_send_file" symbol="serv_send_file">
			<return-type type="void"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="who" type="char*"/>
				<parameter name="file" type="char*"/>
			</parameters>
		</function>
		<function name="serv_send_im" symbol="serv_send_im">
			<return-type type="int"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="p2" type="char*"/>
				<parameter name="p3" type="char*"/>
				<parameter name="flags" type="PurpleMessageFlags"/>
			</parameters>
		</function>
		<function name="serv_send_typing" symbol="serv_send_typing">
			<return-type type="unsigned"/>
			<parameters>
				<parameter name="gc" type="PurpleConnection*"/>
				<parameter name="name" type="char*"/>
				<parameter name="state" type="PurpleTypingState"/>
			</parameters>
		</function>
		<function name="serv_set_info" symbol="serv_set_info">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
				<parameter name="p2" type="char*"/>
			</parameters>
		</function>
		<function name="serv_set_permit_deny" symbol="serv_set_permit_deny">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleConnection*"/>
			</parameters>
		</function>
		<function name="set_blist" symbol="purple_set_blist">
			<return-type type="void"/>
			<parameters>
				<parameter name="blist" type="PurpleBuddyList*"/>
			</parameters>
		</function>
		<function name="signal_connect" symbol="purple_signal_connect">
			<return-type type="gulong"/>
			<parameters>
				<parameter name="instance" type="void*"/>
				<parameter name="signal" type="char*"/>
				<parameter name="handle" type="void*"/>
				<parameter name="func" type="PurpleCallback"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</function>
		<function name="signal_connect_priority" symbol="purple_signal_connect_priority">
			<return-type type="gulong"/>
			<parameters>
				<parameter name="instance" type="void*"/>
				<parameter name="signal" type="char*"/>
				<parameter name="handle" type="void*"/>
				<parameter name="func" type="PurpleCallback"/>
				<parameter name="data" type="void*"/>
				<parameter name="priority" type="int"/>
			</parameters>
		</function>
		<function name="signal_connect_priority_vargs" symbol="purple_signal_connect_priority_vargs">
			<return-type type="gulong"/>
			<parameters>
				<parameter name="instance" type="void*"/>
				<parameter name="signal" type="char*"/>
				<parameter name="handle" type="void*"/>
				<parameter name="func" type="PurpleCallback"/>
				<parameter name="data" type="void*"/>
				<parameter name="priority" type="int"/>
			</parameters>
		</function>
		<function name="signal_connect_vargs" symbol="purple_signal_connect_vargs">
			<return-type type="gulong"/>
			<parameters>
				<parameter name="instance" type="void*"/>
				<parameter name="signal" type="char*"/>
				<parameter name="handle" type="void*"/>
				<parameter name="func" type="PurpleCallback"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</function>
		<function name="signal_disconnect" symbol="purple_signal_disconnect">
			<return-type type="void"/>
			<parameters>
				<parameter name="instance" type="void*"/>
				<parameter name="signal" type="char*"/>
				<parameter name="handle" type="void*"/>
				<parameter name="func" type="PurpleCallback"/>
			</parameters>
		</function>
		<function name="signal_emit" symbol="purple_signal_emit">
			<return-type type="void"/>
			<parameters>
				<parameter name="instance" type="void*"/>
				<parameter name="signal" type="char*"/>
			</parameters>
		</function>
		<function name="signal_emit_return_1" symbol="purple_signal_emit_return_1">
			<return-type type="void*"/>
			<parameters>
				<parameter name="instance" type="void*"/>
				<parameter name="signal" type="char*"/>
			</parameters>
		</function>
		<function name="signal_emit_vargs" symbol="purple_signal_emit_vargs">
			<return-type type="void"/>
			<parameters>
				<parameter name="instance" type="void*"/>
				<parameter name="signal" type="char*"/>
				<parameter name="args" type="va_list"/>
			</parameters>
		</function>
		<function name="signal_emit_vargs_return_1" symbol="purple_signal_emit_vargs_return_1">
			<return-type type="void*"/>
			<parameters>
				<parameter name="instance" type="void*"/>
				<parameter name="signal" type="char*"/>
				<parameter name="args" type="va_list"/>
			</parameters>
		</function>
		<function name="signal_get_values" symbol="purple_signal_get_values">
			<return-type type="void"/>
			<parameters>
				<parameter name="instance" type="void*"/>
				<parameter name="signal" type="char*"/>
				<parameter name="ret_value" type="PurpleValue**"/>
				<parameter name="num_values" type="int*"/>
				<parameter name="values" type="PurpleValue***"/>
			</parameters>
		</function>
		<function name="signal_register" symbol="purple_signal_register">
			<return-type type="gulong"/>
			<parameters>
				<parameter name="instance" type="void*"/>
				<parameter name="signal" type="char*"/>
				<parameter name="marshal" type="PurpleSignalMarshalFunc"/>
				<parameter name="ret_value" type="PurpleValue*"/>
				<parameter name="num_values" type="int"/>
			</parameters>
		</function>
		<function name="signal_unregister" symbol="purple_signal_unregister">
			<return-type type="void"/>
			<parameters>
				<parameter name="instance" type="void*"/>
				<parameter name="signal" type="char*"/>
			</parameters>
		</function>
		<function name="signals_disconnect_by_handle" symbol="purple_signals_disconnect_by_handle">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="void*"/>
			</parameters>
		</function>
		<function name="signals_init" symbol="purple_signals_init">
			<return-type type="void"/>
		</function>
		<function name="signals_uninit" symbol="purple_signals_uninit">
			<return-type type="void"/>
		</function>
		<function name="signals_unregister_by_instance" symbol="purple_signals_unregister_by_instance">
			<return-type type="void"/>
			<parameters>
				<parameter name="instance" type="void*"/>
			</parameters>
		</function>
		<function name="smarshal_BOOLEAN__OBJECT_POINTER_STRING" symbol="purple_smarshal_BOOLEAN__OBJECT_POINTER_STRING">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="smarshal_VOID__ENUM_STRING_STRING" symbol="purple_smarshal_VOID__ENUM_STRING_STRING">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="smarshal_VOID__ENUM_STRING_STRING_BOOLEAN" symbol="purple_smarshal_VOID__ENUM_STRING_STRING_BOOLEAN">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="smarshal_VOID__POINTER_POINTER_OBJECT" symbol="purple_smarshal_VOID__POINTER_POINTER_OBJECT">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="smarshal_VOID__STRING_STRING" symbol="purple_smarshal_VOID__STRING_STRING">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="smarshal_VOID__STRING_STRING_DOUBLE" symbol="purple_smarshal_VOID__STRING_STRING_DOUBLE">
			<return-type type="void"/>
			<parameters>
				<parameter name="closure" type="GClosure*"/>
				<parameter name="return_value" type="GValue*"/>
				<parameter name="n_param_values" type="guint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="invocation_hint" type="gpointer"/>
				<parameter name="marshal_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="smileys_find_by_checksum" symbol="purple_smileys_find_by_checksum">
			<return-type type="PurpleSmiley*"/>
			<parameters>
				<parameter name="checksum" type="char*"/>
			</parameters>
		</function>
		<function name="smileys_find_by_shortcut" symbol="purple_smileys_find_by_shortcut">
			<return-type type="PurpleSmiley*"/>
			<parameters>
				<parameter name="shortcut" type="char*"/>
			</parameters>
		</function>
		<function name="smileys_get_all" symbol="purple_smileys_get_all">
			<return-type type="GList*"/>
		</function>
		<function name="smileys_get_storing_dir" symbol="purple_smileys_get_storing_dir">
			<return-type type="char*"/>
		</function>
		<function name="smileys_init" symbol="purple_smileys_init">
			<return-type type="void"/>
		</function>
		<function name="smileys_uninit" symbol="purple_smileys_uninit">
			<return-type type="void"/>
		</function>
		<function name="sound_get_ui_ops" symbol="purple_sound_get_ui_ops">
			<return-type type="PurpleSoundUiOps*"/>
		</function>
		<function name="sound_init" symbol="purple_sound_init">
			<return-type type="void"/>
		</function>
		<function name="sound_play_event" symbol="purple_sound_play_event">
			<return-type type="void"/>
			<parameters>
				<parameter name="event" type="PurpleSoundEventID"/>
				<parameter name="account" type="PurpleAccount*"/>
			</parameters>
		</function>
		<function name="sound_play_file" symbol="purple_sound_play_file">
			<return-type type="void"/>
			<parameters>
				<parameter name="filename" type="char*"/>
				<parameter name="account" type="PurpleAccount*"/>
			</parameters>
		</function>
		<function name="sound_set_ui_ops" symbol="purple_sound_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleSoundUiOps*"/>
			</parameters>
		</function>
		<function name="sound_uninit" symbol="purple_sound_uninit">
			<return-type type="void"/>
		</function>
		<function name="sounds_get_handle" symbol="purple_sounds_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="srv_cancel" symbol="purple_srv_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="query_data" type="PurpleSrvQueryData*"/>
			</parameters>
		</function>
		<function name="srv_resolve" symbol="purple_srv_resolve">
			<return-type type="PurpleSrvQueryData*"/>
			<parameters>
				<parameter name="protocol" type="char*"/>
				<parameter name="transport" type="char*"/>
				<parameter name="domain" type="char*"/>
				<parameter name="cb" type="PurpleSrvCallback"/>
				<parameter name="extradata" type="gpointer"/>
			</parameters>
		</function>
		<function name="ssl_close" symbol="purple_ssl_close">
			<return-type type="void"/>
			<parameters>
				<parameter name="gsc" type="PurpleSslConnection*"/>
			</parameters>
		</function>
		<function name="ssl_connect" symbol="purple_ssl_connect">
			<return-type type="PurpleSslConnection*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="host" type="char*"/>
				<parameter name="port" type="int"/>
				<parameter name="func" type="PurpleSslInputFunction"/>
				<parameter name="error_func" type="PurpleSslErrorFunction"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</function>
		<function name="ssl_connect_fd" symbol="purple_ssl_connect_fd">
			<return-type type="PurpleSslConnection*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="fd" type="int"/>
				<parameter name="func" type="PurpleSslInputFunction"/>
				<parameter name="error_func" type="PurpleSslErrorFunction"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</function>
		<function name="ssl_connect_with_host_fd" symbol="purple_ssl_connect_with_host_fd">
			<return-type type="PurpleSslConnection*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="fd" type="int"/>
				<parameter name="func" type="PurpleSslInputFunction"/>
				<parameter name="error_func" type="PurpleSslErrorFunction"/>
				<parameter name="host" type="char*"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</function>
		<function name="ssl_connect_with_ssl_cn" symbol="purple_ssl_connect_with_ssl_cn">
			<return-type type="PurpleSslConnection*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="host" type="char*"/>
				<parameter name="port" type="int"/>
				<parameter name="func" type="PurpleSslInputFunction"/>
				<parameter name="error_func" type="PurpleSslErrorFunction"/>
				<parameter name="ssl_host" type="char*"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</function>
		<function name="ssl_get_ops" symbol="purple_ssl_get_ops">
			<return-type type="PurpleSslOps*"/>
		</function>
		<function name="ssl_get_peer_certificates" symbol="purple_ssl_get_peer_certificates">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="gsc" type="PurpleSslConnection*"/>
			</parameters>
		</function>
		<function name="ssl_init" symbol="purple_ssl_init">
			<return-type type="void"/>
		</function>
		<function name="ssl_input_add" symbol="purple_ssl_input_add">
			<return-type type="void"/>
			<parameters>
				<parameter name="gsc" type="PurpleSslConnection*"/>
				<parameter name="func" type="PurpleSslInputFunction"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</function>
		<function name="ssl_is_supported" symbol="purple_ssl_is_supported">
			<return-type type="gboolean"/>
		</function>
		<function name="ssl_read" symbol="purple_ssl_read">
			<return-type type="size_t"/>
			<parameters>
				<parameter name="gsc" type="PurpleSslConnection*"/>
				<parameter name="buffer" type="void*"/>
				<parameter name="len" type="size_t"/>
			</parameters>
		</function>
		<function name="ssl_set_ops" symbol="purple_ssl_set_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleSslOps*"/>
			</parameters>
		</function>
		<function name="ssl_strerror" symbol="purple_ssl_strerror">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="error" type="PurpleSslErrorType"/>
			</parameters>
		</function>
		<function name="ssl_uninit" symbol="purple_ssl_uninit">
			<return-type type="void"/>
		</function>
		<function name="ssl_write" symbol="purple_ssl_write">
			<return-type type="size_t"/>
			<parameters>
				<parameter name="gsc" type="PurpleSslConnection*"/>
				<parameter name="buffer" type="void*"/>
				<parameter name="len" type="size_t"/>
			</parameters>
		</function>
		<function name="str_add_cr" symbol="purple_str_add_cr">
			<return-type type="char*"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="str_binary_to_ascii" symbol="purple_str_binary_to_ascii">
			<return-type type="char*"/>
			<parameters>
				<parameter name="binary" type="unsigned*"/>
				<parameter name="len" type="guint"/>
			</parameters>
		</function>
		<function name="str_has_prefix" symbol="purple_str_has_prefix">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="s" type="char*"/>
				<parameter name="p" type="char*"/>
			</parameters>
		</function>
		<function name="str_has_suffix" symbol="purple_str_has_suffix">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="s" type="char*"/>
				<parameter name="x" type="char*"/>
			</parameters>
		</function>
		<function name="str_seconds_to_string" symbol="purple_str_seconds_to_string">
			<return-type type="char*"/>
			<parameters>
				<parameter name="sec" type="guint"/>
			</parameters>
		</function>
		<function name="str_size_to_units" symbol="purple_str_size_to_units">
			<return-type type="char*"/>
			<parameters>
				<parameter name="size" type="size_t"/>
			</parameters>
		</function>
		<function name="str_strip_char" symbol="purple_str_strip_char">
			<return-type type="void"/>
			<parameters>
				<parameter name="str" type="char*"/>
				<parameter name="thechar" type="char"/>
			</parameters>
		</function>
		<function name="str_to_time" symbol="purple_str_to_time">
			<return-type type="time_t"/>
			<parameters>
				<parameter name="timestamp" type="char*"/>
				<parameter name="utc" type="gboolean"/>
				<parameter name="tm" type="struct tm*"/>
				<parameter name="tz_off" type="long*"/>
				<parameter name="rest" type="char**"/>
			</parameters>
		</function>
		<function name="strcasereplace" symbol="purple_strcasereplace">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="string" type="char*"/>
				<parameter name="delimiter" type="char*"/>
				<parameter name="replacement" type="char*"/>
			</parameters>
		</function>
		<function name="strcasestr" symbol="purple_strcasestr">
			<return-type type="char*"/>
			<parameters>
				<parameter name="haystack" type="char*"/>
				<parameter name="needle" type="char*"/>
			</parameters>
		</function>
		<function name="strdup_withhtml" symbol="purple_strdup_withhtml">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="src" type="gchar*"/>
			</parameters>
		</function>
		<function name="strequal" symbol="purple_strequal">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="left" type="gchar*"/>
				<parameter name="right" type="gchar*"/>
			</parameters>
		</function>
		<function name="strreplace" symbol="purple_strreplace">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="string" type="char*"/>
				<parameter name="delimiter" type="char*"/>
				<parameter name="replacement" type="char*"/>
			</parameters>
		</function>
		<function name="stun_discover" symbol="purple_stun_discover">
			<return-type type="PurpleStunNatDiscovery*"/>
			<parameters>
				<parameter name="cb" type="StunCallback"/>
			</parameters>
		</function>
		<function name="stun_init" symbol="purple_stun_init">
			<return-type type="void"/>
		</function>
		<function name="text_strip_mnemonic" symbol="purple_text_strip_mnemonic">
			<return-type type="char*"/>
			<parameters>
				<parameter name="in" type="char*"/>
			</parameters>
		</function>
		<function name="time_build" symbol="purple_time_build">
			<return-type type="time_t"/>
			<parameters>
				<parameter name="year" type="int"/>
				<parameter name="month" type="int"/>
				<parameter name="day" type="int"/>
				<parameter name="hour" type="int"/>
				<parameter name="min" type="int"/>
				<parameter name="sec" type="int"/>
			</parameters>
		</function>
		<function name="time_format" symbol="purple_time_format">
			<return-type type="char*"/>
			<parameters>
				<parameter name="tm" type="struct tm*"/>
			</parameters>
		</function>
		<function name="timeout_add" symbol="purple_timeout_add">
			<return-type type="guint"/>
			<parameters>
				<parameter name="interval" type="guint"/>
				<parameter name="function" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="timeout_add_seconds" symbol="purple_timeout_add_seconds">
			<return-type type="guint"/>
			<parameters>
				<parameter name="interval" type="guint"/>
				<parameter name="function" type="GSourceFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="timeout_remove" symbol="purple_timeout_remove">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="guint"/>
			</parameters>
		</function>
		<function name="txt_cancel" symbol="purple_txt_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="query_data" type="PurpleSrvQueryData*"/>
			</parameters>
		</function>
		<function name="txt_resolve" symbol="purple_txt_resolve">
			<return-type type="PurpleSrvQueryData*"/>
			<parameters>
				<parameter name="owner" type="char*"/>
				<parameter name="domain" type="char*"/>
				<parameter name="cb" type="PurpleTxtCallback"/>
				<parameter name="extradata" type="gpointer"/>
			</parameters>
		</function>
		<function name="unescape_filename" symbol="purple_unescape_filename">
			<return-type type="char*"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="unescape_html" symbol="purple_unescape_html">
			<return-type type="char*"/>
			<parameters>
				<parameter name="html" type="char*"/>
			</parameters>
		</function>
		<function name="upnp_cancel_port_mapping" symbol="purple_upnp_cancel_port_mapping">
			<return-type type="void"/>
			<parameters>
				<parameter name="mapping_data" type="UPnPMappingAddRemove*"/>
			</parameters>
		</function>
		<function name="upnp_discover" symbol="purple_upnp_discover">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleUPnPCallback"/>
				<parameter name="cb_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="upnp_get_public_ip" symbol="purple_upnp_get_public_ip">
			<return-type type="gchar*"/>
		</function>
		<function name="upnp_init" symbol="purple_upnp_init">
			<return-type type="void"/>
		</function>
		<function name="upnp_remove_port_mapping" symbol="purple_upnp_remove_port_mapping">
			<return-type type="UPnPMappingAddRemove*"/>
			<parameters>
				<parameter name="portmap" type="unsigned"/>
				<parameter name="protocol" type="gchar*"/>
				<parameter name="cb" type="PurpleUPnPCallback"/>
				<parameter name="cb_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="upnp_set_port_mapping" symbol="purple_upnp_set_port_mapping">
			<return-type type="UPnPMappingAddRemove*"/>
			<parameters>
				<parameter name="portmap" type="unsigned"/>
				<parameter name="protocol" type="gchar*"/>
				<parameter name="cb" type="PurpleUPnPCallback"/>
				<parameter name="cb_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="uri_list_extract_filenames" symbol="purple_uri_list_extract_filenames">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="uri_list" type="gchar*"/>
			</parameters>
		</function>
		<function name="uri_list_extract_uris" symbol="purple_uri_list_extract_uris">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="uri_list" type="gchar*"/>
			</parameters>
		</function>
		<function name="url_decode" symbol="purple_url_decode">
			<return-type type="char*"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="url_encode" symbol="purple_url_encode">
			<return-type type="char*"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="url_parse" symbol="purple_url_parse">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="url" type="char*"/>
				<parameter name="ret_host" type="char**"/>
				<parameter name="ret_port" type="int*"/>
				<parameter name="ret_path" type="char**"/>
				<parameter name="ret_user" type="char**"/>
				<parameter name="ret_passwd" type="char**"/>
			</parameters>
		</function>
		<function name="user_dir" symbol="purple_user_dir">
			<return-type type="char*"/>
		</function>
		<function name="utf8_has_word" symbol="purple_utf8_has_word">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="haystack" type="char*"/>
				<parameter name="needle" type="char*"/>
			</parameters>
		</function>
		<function name="utf8_ncr_decode" symbol="purple_utf8_ncr_decode">
			<return-type type="char*"/>
			<parameters>
				<parameter name="in" type="char*"/>
			</parameters>
		</function>
		<function name="utf8_ncr_encode" symbol="purple_utf8_ncr_encode">
			<return-type type="char*"/>
			<parameters>
				<parameter name="in" type="char*"/>
			</parameters>
		</function>
		<function name="utf8_salvage" symbol="purple_utf8_salvage">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="utf8_strcasecmp" symbol="purple_utf8_strcasecmp">
			<return-type type="int"/>
			<parameters>
				<parameter name="a" type="char*"/>
				<parameter name="b" type="char*"/>
			</parameters>
		</function>
		<function name="utf8_strftime" symbol="purple_utf8_strftime">
			<return-type type="char*"/>
			<parameters>
				<parameter name="format" type="char*"/>
				<parameter name="tm" type="struct tm*"/>
			</parameters>
		</function>
		<function name="utf8_strip_unprintables" symbol="purple_utf8_strip_unprintables">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="utf8_try_convert" symbol="purple_utf8_try_convert">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="util_chrreplace" symbol="purple_util_chrreplace">
			<return-type type="void"/>
			<parameters>
				<parameter name="string" type="char*"/>
				<parameter name="delimiter" type="char"/>
				<parameter name="replacement" type="char"/>
			</parameters>
		</function>
		<function name="util_fetch_url_cancel" symbol="purple_util_fetch_url_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="url_data" type="PurpleUtilFetchUrlData*"/>
			</parameters>
		</function>
		<function name="util_fetch_url_request" symbol="purple_util_fetch_url_request">
			<return-type type="PurpleUtilFetchUrlData*"/>
			<parameters>
				<parameter name="url" type="gchar*"/>
				<parameter name="full" type="gboolean"/>
				<parameter name="user_agent" type="gchar*"/>
				<parameter name="http11" type="gboolean"/>
				<parameter name="request" type="gchar*"/>
				<parameter name="include_headers" type="gboolean"/>
				<parameter name="callback" type="PurpleUtilFetchUrlCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="util_fetch_url_request_len" symbol="purple_util_fetch_url_request_len">
			<return-type type="PurpleUtilFetchUrlData*"/>
			<parameters>
				<parameter name="url" type="gchar*"/>
				<parameter name="full" type="gboolean"/>
				<parameter name="user_agent" type="gchar*"/>
				<parameter name="http11" type="gboolean"/>
				<parameter name="request" type="gchar*"/>
				<parameter name="include_headers" type="gboolean"/>
				<parameter name="max_len" type="gssize"/>
				<parameter name="callback" type="PurpleUtilFetchUrlCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="util_fetch_url_request_len_with_account" symbol="purple_util_fetch_url_request_len_with_account">
			<return-type type="PurpleUtilFetchUrlData*"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="url" type="gchar*"/>
				<parameter name="full" type="gboolean"/>
				<parameter name="user_agent" type="gchar*"/>
				<parameter name="http11" type="gboolean"/>
				<parameter name="request" type="gchar*"/>
				<parameter name="include_headers" type="gboolean"/>
				<parameter name="max_len" type="gssize"/>
				<parameter name="callback" type="PurpleUtilFetchUrlCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="util_format_song_info" symbol="purple_util_format_song_info">
			<return-type type="char*"/>
			<parameters>
				<parameter name="title" type="char*"/>
				<parameter name="artist" type="char*"/>
				<parameter name="album" type="char*"/>
				<parameter name="unused" type="gpointer"/>
			</parameters>
		</function>
		<function name="util_get_image_checksum" symbol="purple_util_get_image_checksum">
			<return-type type="char*"/>
			<parameters>
				<parameter name="image_data" type="gconstpointer"/>
				<parameter name="image_len" type="size_t"/>
			</parameters>
		</function>
		<function name="util_get_image_extension" symbol="purple_util_get_image_extension">
			<return-type type="char*"/>
			<parameters>
				<parameter name="data" type="gconstpointer"/>
				<parameter name="len" type="size_t"/>
			</parameters>
		</function>
		<function name="util_get_image_filename" symbol="purple_util_get_image_filename">
			<return-type type="char*"/>
			<parameters>
				<parameter name="image_data" type="gconstpointer"/>
				<parameter name="image_len" type="size_t"/>
			</parameters>
		</function>
		<function name="util_init" symbol="purple_util_init">
			<return-type type="void"/>
		</function>
		<function name="util_read_xml_from_file" symbol="purple_util_read_xml_from_file">
			<return-type type="xmlnode*"/>
			<parameters>
				<parameter name="filename" type="char*"/>
				<parameter name="description" type="char*"/>
			</parameters>
		</function>
		<function name="util_set_current_song" symbol="purple_util_set_current_song">
			<return-type type="void"/>
			<parameters>
				<parameter name="title" type="char*"/>
				<parameter name="artist" type="char*"/>
				<parameter name="album" type="char*"/>
			</parameters>
		</function>
		<function name="util_set_user_dir" symbol="purple_util_set_user_dir">
			<return-type type="void"/>
			<parameters>
				<parameter name="dir" type="char*"/>
			</parameters>
		</function>
		<function name="util_uninit" symbol="purple_util_uninit">
			<return-type type="void"/>
		</function>
		<function name="util_write_data_to_file" symbol="purple_util_write_data_to_file">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="filename" type="char*"/>
				<parameter name="data" type="char*"/>
				<parameter name="size" type="gssize"/>
			</parameters>
		</function>
		<function name="util_write_data_to_file_absolute" symbol="purple_util_write_data_to_file_absolute">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="filename_full" type="char*"/>
				<parameter name="data" type="char*"/>
				<parameter name="size" type="gssize"/>
			</parameters>
		</function>
		<function name="version_check" symbol="purple_version_check">
			<return-type type="char*"/>
			<parameters>
				<parameter name="required_major" type="guint"/>
				<parameter name="required_minor" type="guint"/>
				<parameter name="required_micro" type="guint"/>
			</parameters>
		</function>
		<function name="xfers_get_all" symbol="purple_xfers_get_all">
			<return-type type="GList*"/>
		</function>
		<function name="xfers_get_handle" symbol="purple_xfers_get_handle">
			<return-type type="void*"/>
		</function>
		<function name="xfers_get_ui_ops" symbol="purple_xfers_get_ui_ops">
			<return-type type="PurpleXferUiOps*"/>
		</function>
		<function name="xfers_init" symbol="purple_xfers_init">
			<return-type type="void"/>
		</function>
		<function name="xfers_set_ui_ops" symbol="purple_xfers_set_ui_ops">
			<return-type type="void"/>
			<parameters>
				<parameter name="ops" type="PurpleXferUiOps*"/>
			</parameters>
		</function>
		<function name="xfers_uninit" symbol="purple_xfers_uninit">
			<return-type type="void"/>
		</function>
		<callback name="PTFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleTheme*"/>
			</parameters>
		</callback>
		<callback name="PurpleAccountRegistrationCb">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="succeeded" type="gboolean"/>
				<parameter name="user_data" type="void*"/>
			</parameters>
		</callback>
		<callback name="PurpleAccountRequestAuthorizationCb">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="void*"/>
			</parameters>
		</callback>
		<callback name="PurpleAccountUnregistrationCb">
			<return-type type="void"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
				<parameter name="succeeded" type="gboolean"/>
				<parameter name="user_data" type="void*"/>
			</parameters>
		</callback>
		<callback name="PurpleCallback">
			<return-type type="void"/>
		</callback>
		<callback name="PurpleCertificateVerifiedCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="st" type="PurpleCertificateVerificationStatus"/>
				<parameter name="userdata" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="PurpleCmdFunc">
			<return-type type="PurpleCmdRet"/>
			<parameters>
				<parameter name="p1" type="PurpleConversation*"/>
				<parameter name="cmd" type="gchar*"/>
				<parameter name="args" type="gchar**"/>
				<parameter name="error" type="gchar**"/>
				<parameter name="data" type="void*"/>
			</parameters>
		</callback>
		<callback name="PurpleDnsQueryConnectFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="hosts" type="GSList*"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="error_message" type="char*"/>
			</parameters>
		</callback>
		<callback name="PurpleDnsQueryFailedCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="query_data" type="PurpleDnsQueryData*"/>
				<parameter name="error_message" type="gchar*"/>
			</parameters>
		</callback>
		<callback name="PurpleDnsQueryResolvedCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="query_data" type="PurpleDnsQueryData*"/>
				<parameter name="hosts" type="GSList*"/>
			</parameters>
		</callback>
		<callback name="PurpleFilterAccountFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="account" type="PurpleAccount*"/>
			</parameters>
		</callback>
		<callback name="PurpleInfoFieldFormatCallback">
			<return-type type="char*"/>
			<parameters>
				<parameter name="field" type="char*"/>
				<parameter name="len" type="size_t"/>
			</parameters>
		</callback>
		<callback name="PurpleInputFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="gpointer"/>
				<parameter name="p2" type="gint"/>
				<parameter name="p3" type="PurpleInputCondition"/>
			</parameters>
		</callback>
		<callback name="PurpleLogSetCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="sets" type="GHashTable*"/>
				<parameter name="set" type="PurpleLogSet*"/>
			</parameters>
		</callback>
		<callback name="PurpleMediaElementCreateCallback">
			<return-type type="GstElement*"/>
			<parameters>
				<parameter name="media" type="PurpleMedia*"/>
				<parameter name="session_id" type="gchar*"/>
				<parameter name="participant" type="gchar*"/>
			</parameters>
		</callback>
		<callback name="PurpleNetworkListenCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="listenfd" type="int"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="PurpleNotifyCloseCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="PurpleNotifySearchResultsCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="c" type="PurpleConnection*"/>
				<parameter name="row" type="GList*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="PurplePounceCb">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurplePounce*"/>
				<parameter name="p2" type="PurplePounceEvent"/>
				<parameter name="p3" type="void*"/>
			</parameters>
		</callback>
		<callback name="PurplePrefCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="type" type="PurplePrefType"/>
				<parameter name="val" type="gconstpointer"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="PurpleProxyConnectFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
				<parameter name="source" type="gint"/>
				<parameter name="error_message" type="gchar*"/>
			</parameters>
		</callback>
		<callback name="PurpleRequestActionCb">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="void*"/>
				<parameter name="p2" type="int"/>
			</parameters>
		</callback>
		<callback name="PurpleRequestChoiceCb">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="void*"/>
				<parameter name="p2" type="int"/>
			</parameters>
		</callback>
		<callback name="PurpleRequestFieldsCb">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="void*"/>
				<parameter name="fields" type="PurpleRequestFields*"/>
			</parameters>
		</callback>
		<callback name="PurpleRequestFileCb">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="void*"/>
				<parameter name="filename" type="char*"/>
			</parameters>
		</callback>
		<callback name="PurpleRequestInputCb">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="void*"/>
				<parameter name="p2" type="char*"/>
			</parameters>
		</callback>
		<callback name="PurpleSignalMarshalFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="cb" type="PurpleCallback"/>
				<parameter name="args" type="va_list"/>
				<parameter name="data" type="void*"/>
				<parameter name="return_val" type="void**"/>
			</parameters>
		</callback>
		<callback name="PurpleSrvCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="resp" type="PurpleSrvResponse*"/>
				<parameter name="results" type="int"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="PurpleSslErrorFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleSslConnection*"/>
				<parameter name="p2" type="PurpleSslErrorType"/>
				<parameter name="p3" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="PurpleSslInputFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="gpointer"/>
				<parameter name="p2" type="PurpleSslConnection*"/>
				<parameter name="p3" type="PurpleInputCondition"/>
			</parameters>
		</callback>
		<callback name="PurpleTxtCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="responses" type="GList*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="PurpleUPnPCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="success" type="gboolean"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="PurpleUtilFetchUrlCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="url_data" type="PurpleUtilFetchUrlData*"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="url_text" type="gchar*"/>
				<parameter name="len" type="gsize"/>
				<parameter name="error_message" type="gchar*"/>
			</parameters>
		</callback>
		<callback name="StunCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="PurpleStunNatDiscovery*"/>
			</parameters>
		</callback>
		<struct name="PurpleAccount">
			<method name="add_buddies" symbol="purple_account_add_buddies">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="buddies" type="GList*"/>
				</parameters>
			</method>
			<method name="add_buddy" symbol="purple_account_add_buddy">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="change_password" symbol="purple_account_change_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="orig_pw" type="char*"/>
					<parameter name="new_pw" type="char*"/>
				</parameters>
			</method>
			<method name="clear_current_error" symbol="purple_account_clear_current_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="clear_settings" symbol="purple_account_clear_settings">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="connect" symbol="purple_account_connect">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_account_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="destroy_log" symbol="purple_account_destroy_log">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="disconnect" symbol="purple_account_disconnect">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_active_status" symbol="purple_account_get_active_status">
				<return-type type="PurpleStatus*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_alias" symbol="purple_account_get_alias">
				<return-type type="char*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_bool" symbol="purple_account_get_bool">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="name" type="char*"/>
					<parameter name="default_value" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_buddy_icon_path" symbol="purple_account_get_buddy_icon_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_check_mail" symbol="purple_account_get_check_mail">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_connection" symbol="purple_account_get_connection">
				<return-type type="PurpleConnection*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_current_error" symbol="purple_account_get_current_error">
				<return-type type="PurpleConnectionErrorInfo*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_enabled" symbol="purple_account_get_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="ui" type="char*"/>
				</parameters>
			</method>
			<method name="get_int" symbol="purple_account_get_int">
				<return-type type="int"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="name" type="char*"/>
					<parameter name="default_value" type="int"/>
				</parameters>
			</method>
			<method name="get_log" symbol="purple_account_get_log">
				<return-type type="PurpleLog*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="create" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_password" symbol="purple_account_get_password">
				<return-type type="char*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_presence" symbol="purple_account_get_presence">
				<return-type type="PurplePresence*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_protocol_id" symbol="purple_account_get_protocol_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_protocol_name" symbol="purple_account_get_protocol_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_proxy_info" symbol="purple_account_get_proxy_info">
				<return-type type="PurpleProxyInfo*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_remember_password" symbol="purple_account_get_remember_password">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_status" symbol="purple_account_get_status">
				<return-type type="PurpleStatus*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="status_id" type="char*"/>
				</parameters>
			</method>
			<method name="get_status_type" symbol="purple_account_get_status_type">
				<return-type type="PurpleStatusType*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_status_type_with_primitive" symbol="purple_account_get_status_type_with_primitive">
				<return-type type="PurpleStatusType*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="primitive" type="PurpleStatusPrimitive"/>
				</parameters>
			</method>
			<method name="get_status_types" symbol="purple_account_get_status_types">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_string" symbol="purple_account_get_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="name" type="char*"/>
					<parameter name="default_value" type="char*"/>
				</parameters>
			</method>
			<method name="get_ui_bool" symbol="purple_account_get_ui_bool">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="ui" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="default_value" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_ui_int" symbol="purple_account_get_ui_int">
				<return-type type="int"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="ui" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="default_value" type="int"/>
				</parameters>
			</method>
			<method name="get_ui_string" symbol="purple_account_get_ui_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="ui" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="default_value" type="char*"/>
				</parameters>
			</method>
			<method name="get_user_info" symbol="purple_account_get_user_info">
				<return-type type="char*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_username" symbol="purple_account_get_username">
				<return-type type="char*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="is_connected" symbol="purple_account_is_connected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="is_connecting" symbol="purple_account_is_connecting">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="is_disconnected" symbol="purple_account_is_disconnected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="is_status_active" symbol="purple_account_is_status_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="status_id" type="char*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_account_new">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="username" type="char*"/>
					<parameter name="protocol_id" type="char*"/>
				</parameters>
			</method>
			<method name="notify_added" symbol="purple_account_notify_added">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="remote_user" type="char*"/>
					<parameter name="id" type="char*"/>
					<parameter name="alias" type="char*"/>
					<parameter name="message" type="char*"/>
				</parameters>
			</method>
			<method name="register" symbol="purple_account_register">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="remove_buddies" symbol="purple_account_remove_buddies">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="buddies" type="GList*"/>
					<parameter name="groups" type="GList*"/>
				</parameters>
			</method>
			<method name="remove_buddy" symbol="purple_account_remove_buddy">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="buddy" type="PurpleBuddy*"/>
					<parameter name="group" type="PurpleGroup*"/>
				</parameters>
			</method>
			<method name="remove_group" symbol="purple_account_remove_group">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="group" type="PurpleGroup*"/>
				</parameters>
			</method>
			<method name="remove_setting" symbol="purple_account_remove_setting">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="setting" type="char*"/>
				</parameters>
			</method>
			<method name="request_add" symbol="purple_account_request_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="remote_user" type="char*"/>
					<parameter name="id" type="char*"/>
					<parameter name="alias" type="char*"/>
					<parameter name="message" type="char*"/>
				</parameters>
			</method>
			<method name="request_authorization" symbol="purple_account_request_authorization">
				<return-type type="void*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="remote_user" type="char*"/>
					<parameter name="id" type="char*"/>
					<parameter name="alias" type="char*"/>
					<parameter name="message" type="char*"/>
					<parameter name="on_list" type="gboolean"/>
					<parameter name="auth_cb" type="PurpleAccountRequestAuthorizationCb"/>
					<parameter name="deny_cb" type="PurpleAccountRequestAuthorizationCb"/>
					<parameter name="user_data" type="void*"/>
				</parameters>
			</method>
			<method name="request_change_password" symbol="purple_account_request_change_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="request_change_user_info" symbol="purple_account_request_change_user_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="request_close" symbol="purple_account_request_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="ui_handle" type="void*"/>
				</parameters>
			</method>
			<method name="request_close_with_account" symbol="purple_account_request_close_with_account">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="request_password" symbol="purple_account_request_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="ok_cb" type="GCallback"/>
					<parameter name="cancel_cb" type="GCallback"/>
					<parameter name="user_data" type="void*"/>
				</parameters>
			</method>
			<method name="set_alias" symbol="purple_account_set_alias">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="alias" type="char*"/>
				</parameters>
			</method>
			<method name="set_bool" symbol="purple_account_set_bool">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_buddy_icon_path" symbol="purple_account_set_buddy_icon_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="set_check_mail" symbol="purple_account_set_check_mail">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_connection" symbol="purple_account_set_connection">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="gc" type="PurpleConnection*"/>
				</parameters>
			</method>
			<method name="set_enabled" symbol="purple_account_set_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="ui" type="char*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_int" symbol="purple_account_set_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="int"/>
				</parameters>
			</method>
			<method name="set_password" symbol="purple_account_set_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</method>
			<method name="set_protocol_id" symbol="purple_account_set_protocol_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="protocol_id" type="char*"/>
				</parameters>
			</method>
			<method name="set_proxy_info" symbol="purple_account_set_proxy_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="info" type="PurpleProxyInfo*"/>
				</parameters>
			</method>
			<method name="set_register_callback" symbol="purple_account_set_register_callback">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="cb" type="PurpleAccountRegistrationCb"/>
					<parameter name="user_data" type="void*"/>
				</parameters>
			</method>
			<method name="set_remember_password" symbol="purple_account_set_remember_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_status" symbol="purple_account_set_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="status_id" type="char*"/>
					<parameter name="active" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_status_list" symbol="purple_account_set_status_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="status_id" type="char*"/>
					<parameter name="active" type="gboolean"/>
					<parameter name="attrs" type="GList*"/>
				</parameters>
			</method>
			<method name="set_status_types" symbol="purple_account_set_status_types">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="status_types" type="GList*"/>
				</parameters>
			</method>
			<method name="set_string" symbol="purple_account_set_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_ui_bool" symbol="purple_account_set_ui_bool">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="ui" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_ui_int" symbol="purple_account_set_ui_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="ui" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="int"/>
				</parameters>
			</method>
			<method name="set_ui_string" symbol="purple_account_set_ui_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="ui" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_user_info" symbol="purple_account_set_user_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="user_info" type="char*"/>
				</parameters>
			</method>
			<method name="set_username" symbol="purple_account_set_username">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="username" type="char*"/>
				</parameters>
			</method>
			<method name="supports_offline_message" symbol="purple_account_supports_offline_message">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="unregister" symbol="purple_account_unregister">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="cb" type="PurpleAccountUnregistrationCb"/>
					<parameter name="user_data" type="void*"/>
				</parameters>
			</method>
			<field name="username" type="char*"/>
			<field name="alias" type="char*"/>
			<field name="password" type="char*"/>
			<field name="user_info" type="char*"/>
			<field name="buddy_icon_path" type="char*"/>
			<field name="remember_pass" type="gboolean"/>
			<field name="protocol_id" type="char*"/>
			<field name="gc" type="PurpleConnection*"/>
			<field name="disconnecting" type="gboolean"/>
			<field name="settings" type="GHashTable*"/>
			<field name="ui_settings" type="GHashTable*"/>
			<field name="proxy_info" type="PurpleProxyInfo*"/>
			<field name="permit" type="GSList*"/>
			<field name="deny" type="GSList*"/>
			<field name="perm_deny" type="PurplePrivacyType"/>
			<field name="status_types" type="GList*"/>
			<field name="presence" type="PurplePresence*"/>
			<field name="system_log" type="PurpleLog*"/>
			<field name="ui_data" type="void*"/>
			<field name="registration_cb" type="PurpleAccountRegistrationCb"/>
			<field name="registration_cb_user_data" type="void*"/>
			<field name="priv" type="gpointer"/>
		</struct>
		<struct name="PurpleAccountOption">
			<method name="add_list_item" symbol="purple_account_option_add_list_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
					<parameter name="key" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="bool_new" symbol="purple_account_option_bool_new">
				<return-type type="PurpleAccountOption*"/>
				<parameters>
					<parameter name="text" type="char*"/>
					<parameter name="pref_name" type="char*"/>
					<parameter name="default_value" type="gboolean"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_account_option_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
				</parameters>
			</method>
			<method name="get_default_bool" symbol="purple_account_option_get_default_bool">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
				</parameters>
			</method>
			<method name="get_default_int" symbol="purple_account_option_get_default_int">
				<return-type type="int"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
				</parameters>
			</method>
			<method name="get_default_list_value" symbol="purple_account_option_get_default_list_value">
				<return-type type="char*"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
				</parameters>
			</method>
			<method name="get_default_string" symbol="purple_account_option_get_default_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
				</parameters>
			</method>
			<method name="get_list" symbol="purple_account_option_get_list">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
				</parameters>
			</method>
			<method name="get_masked" symbol="purple_account_option_get_masked">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
				</parameters>
			</method>
			<method name="get_setting" symbol="purple_account_option_get_setting">
				<return-type type="char*"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="purple_account_option_get_text">
				<return-type type="char*"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
				</parameters>
			</method>
			<method name="int_new" symbol="purple_account_option_int_new">
				<return-type type="PurpleAccountOption*"/>
				<parameters>
					<parameter name="text" type="char*"/>
					<parameter name="pref_name" type="char*"/>
					<parameter name="default_value" type="int"/>
				</parameters>
			</method>
			<method name="list_new" symbol="purple_account_option_list_new">
				<return-type type="PurpleAccountOption*"/>
				<parameters>
					<parameter name="text" type="char*"/>
					<parameter name="pref_name" type="char*"/>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_account_option_new">
				<return-type type="PurpleAccountOption*"/>
				<parameters>
					<parameter name="type" type="PurplePrefType"/>
					<parameter name="text" type="char*"/>
					<parameter name="pref_name" type="char*"/>
				</parameters>
			</method>
			<method name="set_default_bool" symbol="purple_account_option_set_default_bool">
				<return-type type="void"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_default_int" symbol="purple_account_option_set_default_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
					<parameter name="value" type="int"/>
				</parameters>
			</method>
			<method name="set_default_string" symbol="purple_account_option_set_default_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_list" symbol="purple_account_option_set_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
					<parameter name="values" type="GList*"/>
				</parameters>
			</method>
			<method name="set_masked" symbol="purple_account_option_set_masked">
				<return-type type="void"/>
				<parameters>
					<parameter name="option" type="PurpleAccountOption*"/>
					<parameter name="masked" type="gboolean"/>
				</parameters>
			</method>
			<method name="string_new" symbol="purple_account_option_string_new">
				<return-type type="PurpleAccountOption*"/>
				<parameters>
					<parameter name="text" type="char*"/>
					<parameter name="pref_name" type="char*"/>
					<parameter name="default_value" type="char*"/>
				</parameters>
			</method>
			<field name="type" type="PurplePrefType"/>
			<field name="text" type="char*"/>
			<field name="pref_name" type="char*"/>
			<field name="default_value" type="gpointer"/>
			<field name="masked" type="gboolean"/>
		</struct>
		<struct name="PurpleAccountUiOps">
			<field name="notify_added" type="GCallback"/>
			<field name="status_changed" type="GCallback"/>
			<field name="request_add" type="GCallback"/>
			<field name="request_authorize" type="GCallback"/>
			<field name="close_account_request" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleAccountUserSplit">
			<method name="destroy" symbol="purple_account_user_split_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="split" type="PurpleAccountUserSplit*"/>
				</parameters>
			</method>
			<method name="get_default_value" symbol="purple_account_user_split_get_default_value">
				<return-type type="char*"/>
				<parameters>
					<parameter name="split" type="PurpleAccountUserSplit*"/>
				</parameters>
			</method>
			<method name="get_reverse" symbol="purple_account_user_split_get_reverse">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="split" type="PurpleAccountUserSplit*"/>
				</parameters>
			</method>
			<method name="get_separator" symbol="purple_account_user_split_get_separator">
				<return-type type="char"/>
				<parameters>
					<parameter name="split" type="PurpleAccountUserSplit*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="purple_account_user_split_get_text">
				<return-type type="char*"/>
				<parameters>
					<parameter name="split" type="PurpleAccountUserSplit*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_account_user_split_new">
				<return-type type="PurpleAccountUserSplit*"/>
				<parameters>
					<parameter name="text" type="char*"/>
					<parameter name="default_value" type="char*"/>
					<parameter name="sep" type="char"/>
				</parameters>
			</method>
			<method name="set_reverse" symbol="purple_account_user_split_set_reverse">
				<return-type type="void"/>
				<parameters>
					<parameter name="split" type="PurpleAccountUserSplit*"/>
					<parameter name="reverse" type="gboolean"/>
				</parameters>
			</method>
			<field name="text" type="char*"/>
			<field name="default_value" type="char*"/>
			<field name="field_sep" type="char"/>
			<field name="reverse" type="gboolean"/>
		</struct>
		<struct name="PurpleAttentionType">
			<method name="get_icon_name" symbol="purple_attention_type_get_icon_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="type" type="PurpleAttentionType*"/>
				</parameters>
			</method>
			<method name="get_incoming_desc" symbol="purple_attention_type_get_incoming_desc">
				<return-type type="char*"/>
				<parameters>
					<parameter name="type" type="PurpleAttentionType*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_attention_type_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="type" type="PurpleAttentionType*"/>
				</parameters>
			</method>
			<method name="get_outgoing_desc" symbol="purple_attention_type_get_outgoing_desc">
				<return-type type="char*"/>
				<parameters>
					<parameter name="type" type="PurpleAttentionType*"/>
				</parameters>
			</method>
			<method name="get_unlocalized_name" symbol="purple_attention_type_get_unlocalized_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="type" type="PurpleAttentionType*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_attention_type_new">
				<return-type type="PurpleAttentionType*"/>
				<parameters>
					<parameter name="ulname" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="inc_desc" type="char*"/>
					<parameter name="out_desc" type="char*"/>
				</parameters>
			</method>
			<method name="set_icon_name" symbol="purple_attention_type_set_icon_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="type" type="PurpleAttentionType*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_incoming_desc" symbol="purple_attention_type_set_incoming_desc">
				<return-type type="void"/>
				<parameters>
					<parameter name="type" type="PurpleAttentionType*"/>
					<parameter name="desc" type="char*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="purple_attention_type_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="type" type="PurpleAttentionType*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_outgoing_desc" symbol="purple_attention_type_set_outgoing_desc">
				<return-type type="void"/>
				<parameters>
					<parameter name="type" type="PurpleAttentionType*"/>
					<parameter name="desc" type="char*"/>
				</parameters>
			</method>
			<method name="set_unlocalized_name" symbol="purple_attention_type_set_unlocalized_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="type" type="PurpleAttentionType*"/>
					<parameter name="ulname" type="char*"/>
				</parameters>
			</method>
			<field name="name" type="char*"/>
			<field name="incoming_description" type="char*"/>
			<field name="outgoing_description" type="char*"/>
			<field name="icon_name" type="char*"/>
			<field name="unlocalized_name" type="char*"/>
			<field name="_reserved2" type="gpointer"/>
			<field name="_reserved3" type="gpointer"/>
			<field name="_reserved4" type="gpointer"/>
		</struct>
		<struct name="PurpleBlistNode">
			<method name="get_bool" symbol="purple_blist_node_get_bool">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
					<parameter name="key" type="char*"/>
				</parameters>
			</method>
			<method name="get_extended_menu" symbol="purple_blist_node_get_extended_menu">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="n" type="PurpleBlistNode*"/>
				</parameters>
			</method>
			<method name="get_first_child" symbol="purple_blist_node_get_first_child">
				<return-type type="PurpleBlistNode*"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="purple_blist_node_get_flags">
				<return-type type="PurpleBlistNodeFlags"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
				</parameters>
			</method>
			<method name="get_int" symbol="purple_blist_node_get_int">
				<return-type type="int"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
					<parameter name="key" type="char*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="purple_blist_node_get_parent">
				<return-type type="PurpleBlistNode*"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
				</parameters>
			</method>
			<method name="get_sibling_next" symbol="purple_blist_node_get_sibling_next">
				<return-type type="PurpleBlistNode*"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
				</parameters>
			</method>
			<method name="get_sibling_prev" symbol="purple_blist_node_get_sibling_prev">
				<return-type type="PurpleBlistNode*"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
				</parameters>
			</method>
			<method name="get_string" symbol="purple_blist_node_get_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
					<parameter name="key" type="char*"/>
				</parameters>
			</method>
			<method name="get_ui_data" symbol="purple_blist_node_get_ui_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
				</parameters>
			</method>
			<method name="next" symbol="purple_blist_node_next">
				<return-type type="PurpleBlistNode*"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
					<parameter name="offline" type="gboolean"/>
				</parameters>
			</method>
			<method name="remove_setting" symbol="purple_blist_node_remove_setting">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
					<parameter name="key" type="char*"/>
				</parameters>
			</method>
			<method name="set_bool" symbol="purple_blist_node_set_bool">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
					<parameter name="key" type="char*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_flags" symbol="purple_blist_node_set_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
					<parameter name="flags" type="PurpleBlistNodeFlags"/>
				</parameters>
			</method>
			<method name="set_int" symbol="purple_blist_node_set_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
					<parameter name="key" type="char*"/>
					<parameter name="value" type="int"/>
				</parameters>
			</method>
			<method name="set_string" symbol="purple_blist_node_set_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
					<parameter name="key" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_ui_data" symbol="purple_blist_node_set_ui_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
					<parameter name="ui_data" type="gpointer"/>
				</parameters>
			</method>
			<field name="type" type="PurpleBlistNodeType"/>
			<field name="prev" type="PurpleBlistNode*"/>
			<field name="next" type="PurpleBlistNode*"/>
			<field name="parent" type="PurpleBlistNode*"/>
			<field name="child" type="PurpleBlistNode*"/>
			<field name="settings" type="GHashTable*"/>
			<field name="ui_data" type="void*"/>
			<field name="flags" type="PurpleBlistNodeFlags"/>
		</struct>
		<struct name="PurpleBlistUiOps">
			<field name="new_list" type="GCallback"/>
			<field name="new_node" type="GCallback"/>
			<field name="show" type="GCallback"/>
			<field name="update" type="GCallback"/>
			<field name="remove" type="GCallback"/>
			<field name="destroy" type="GCallback"/>
			<field name="set_visible" type="GCallback"/>
			<field name="request_add_buddy" type="GCallback"/>
			<field name="request_add_chat" type="GCallback"/>
			<field name="request_add_group" type="GCallback"/>
			<field name="save_node" type="GCallback"/>
			<field name="remove_node" type="GCallback"/>
			<field name="save_account" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
		</struct>
		<struct name="PurpleBuddy">
			<method name="destroy" symbol="purple_buddy_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_account" symbol="purple_buddy_get_account">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_alias" symbol="purple_buddy_get_alias">
				<return-type type="char*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_alias_only" symbol="purple_buddy_get_alias_only">
				<return-type type="char*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_contact" symbol="purple_buddy_get_contact">
				<return-type type="PurpleContact*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_contact_alias" symbol="purple_buddy_get_contact_alias">
				<return-type type="char*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_group" symbol="purple_buddy_get_group">
				<return-type type="PurpleGroup*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="purple_buddy_get_icon">
				<return-type type="PurpleBuddyIcon*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_local_alias" symbol="purple_buddy_get_local_alias">
				<return-type type="char*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_local_buddy_alias" symbol="purple_buddy_get_local_buddy_alias">
				<return-type type="char*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_buddy_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_presence" symbol="purple_buddy_get_presence">
				<return-type type="PurplePresence*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_protocol_data" symbol="purple_buddy_get_protocol_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="get_server_alias" symbol="purple_buddy_get_server_alias">
				<return-type type="char*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="icons_find" symbol="purple_buddy_icons_find">
				<return-type type="PurpleBuddyIcon*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="username" type="char*"/>
				</parameters>
			</method>
			<method name="icons_find_account_icon" symbol="purple_buddy_icons_find_account_icon">
				<return-type type="PurpleStoredImage*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="icons_find_custom_icon" symbol="purple_buddy_icons_find_custom_icon">
				<return-type type="PurpleStoredImage*"/>
				<parameters>
					<parameter name="contact" type="PurpleContact*"/>
				</parameters>
			</method>
			<method name="icons_get_account_icon_timestamp" symbol="purple_buddy_icons_get_account_icon_timestamp">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="icons_get_cache_dir" symbol="purple_buddy_icons_get_cache_dir">
				<return-type type="char*"/>
			</method>
			<method name="icons_get_checksum_for_user" symbol="purple_buddy_icons_get_checksum_for_user">
				<return-type type="char*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="icons_get_handle" symbol="purple_buddy_icons_get_handle">
				<return-type type="void*"/>
			</method>
			<method name="icons_has_custom_icon" symbol="purple_buddy_icons_has_custom_icon">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="contact" type="PurpleContact*"/>
				</parameters>
			</method>
			<method name="icons_init" symbol="purple_buddy_icons_init">
				<return-type type="void"/>
			</method>
			<method name="icons_is_caching" symbol="purple_buddy_icons_is_caching">
				<return-type type="gboolean"/>
			</method>
			<method name="icons_node_find_custom_icon" symbol="purple_buddy_icons_node_find_custom_icon">
				<return-type type="PurpleStoredImage*"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
				</parameters>
			</method>
			<method name="icons_node_has_custom_icon" symbol="purple_buddy_icons_node_has_custom_icon">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
				</parameters>
			</method>
			<method name="icons_node_set_custom_icon" symbol="purple_buddy_icons_node_set_custom_icon">
				<return-type type="PurpleStoredImage*"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
					<parameter name="icon_data" type="guchar*"/>
					<parameter name="icon_len" type="size_t"/>
				</parameters>
			</method>
			<method name="icons_node_set_custom_icon_from_file" symbol="purple_buddy_icons_node_set_custom_icon_from_file">
				<return-type type="PurpleStoredImage*"/>
				<parameters>
					<parameter name="node" type="PurpleBlistNode*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="icons_set_account_icon" symbol="purple_buddy_icons_set_account_icon">
				<return-type type="PurpleStoredImage*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="icon_data" type="guchar*"/>
					<parameter name="icon_len" type="size_t"/>
				</parameters>
			</method>
			<method name="icons_set_cache_dir" symbol="purple_buddy_icons_set_cache_dir">
				<return-type type="void"/>
				<parameters>
					<parameter name="cache_dir" type="char*"/>
				</parameters>
			</method>
			<method name="icons_set_caching" symbol="purple_buddy_icons_set_caching">
				<return-type type="void"/>
				<parameters>
					<parameter name="caching" type="gboolean"/>
				</parameters>
			</method>
			<method name="icons_set_custom_icon" symbol="purple_buddy_icons_set_custom_icon">
				<return-type type="PurpleStoredImage*"/>
				<parameters>
					<parameter name="contact" type="PurpleContact*"/>
					<parameter name="icon_data" type="guchar*"/>
					<parameter name="icon_len" type="size_t"/>
				</parameters>
			</method>
			<method name="icons_set_for_user" symbol="purple_buddy_icons_set_for_user">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="username" type="char*"/>
					<parameter name="icon_data" type="void*"/>
					<parameter name="icon_len" type="size_t"/>
					<parameter name="checksum" type="char*"/>
				</parameters>
			</method>
			<method name="icons_uninit" symbol="purple_buddy_icons_uninit">
				<return-type type="void"/>
			</method>
			<method name="new" symbol="purple_buddy_new">
				<return-type type="PurpleBuddy*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="name" type="char*"/>
					<parameter name="alias" type="char*"/>
				</parameters>
			</method>
			<method name="set_icon" symbol="purple_buddy_set_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
					<parameter name="icon" type="PurpleBuddyIcon*"/>
				</parameters>
			</method>
			<method name="set_protocol_data" symbol="purple_buddy_set_protocol_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<field name="node" type="PurpleBlistNode"/>
			<field name="name" type="char*"/>
			<field name="alias" type="char*"/>
			<field name="server_alias" type="char*"/>
			<field name="proto_data" type="void*"/>
			<field name="icon" type="PurpleBuddyIcon*"/>
			<field name="account" type="PurpleAccount*"/>
			<field name="presence" type="PurplePresence*"/>
		</struct>
		<struct name="PurpleBuddyIcon">
			<method name="get_account" symbol="purple_buddy_icon_get_account">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="icon" type="PurpleBuddyIcon*"/>
				</parameters>
			</method>
			<method name="get_checksum" symbol="purple_buddy_icon_get_checksum">
				<return-type type="char*"/>
				<parameters>
					<parameter name="icon" type="PurpleBuddyIcon*"/>
				</parameters>
			</method>
			<method name="get_data" symbol="purple_buddy_icon_get_data">
				<return-type type="gconstpointer"/>
				<parameters>
					<parameter name="icon" type="PurpleBuddyIcon*"/>
					<parameter name="len" type="size_t*"/>
				</parameters>
			</method>
			<method name="get_extension" symbol="purple_buddy_icon_get_extension">
				<return-type type="char*"/>
				<parameters>
					<parameter name="icon" type="PurpleBuddyIcon*"/>
				</parameters>
			</method>
			<method name="get_full_path" symbol="purple_buddy_icon_get_full_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="icon" type="PurpleBuddyIcon*"/>
				</parameters>
			</method>
			<method name="get_scale_size" symbol="purple_buddy_icon_get_scale_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="spec" type="PurpleBuddyIconSpec*"/>
					<parameter name="width" type="int*"/>
					<parameter name="height" type="int*"/>
				</parameters>
			</method>
			<method name="get_username" symbol="purple_buddy_icon_get_username">
				<return-type type="char*"/>
				<parameters>
					<parameter name="icon" type="PurpleBuddyIcon*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_buddy_icon_new">
				<return-type type="PurpleBuddyIcon*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="username" type="char*"/>
					<parameter name="icon_data" type="void*"/>
					<parameter name="icon_len" type="size_t"/>
					<parameter name="checksum" type="char*"/>
				</parameters>
			</method>
			<method name="ref" symbol="purple_buddy_icon_ref">
				<return-type type="PurpleBuddyIcon*"/>
				<parameters>
					<parameter name="icon" type="PurpleBuddyIcon*"/>
				</parameters>
			</method>
			<method name="set_data" symbol="purple_buddy_icon_set_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon" type="PurpleBuddyIcon*"/>
					<parameter name="data" type="guchar*"/>
					<parameter name="len" type="size_t"/>
					<parameter name="checksum" type="char*"/>
				</parameters>
			</method>
			<method name="unref" symbol="purple_buddy_icon_unref">
				<return-type type="PurpleBuddyIcon*"/>
				<parameters>
					<parameter name="icon" type="PurpleBuddyIcon*"/>
				</parameters>
			</method>
			<method name="update" symbol="purple_buddy_icon_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon" type="PurpleBuddyIcon*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleBuddyIconSpec">
			<field name="format" type="char*"/>
			<field name="min_width" type="int"/>
			<field name="min_height" type="int"/>
			<field name="max_width" type="int"/>
			<field name="max_height" type="int"/>
			<field name="max_filesize" type="size_t"/>
			<field name="scale_rules" type="PurpleIconScaleRules"/>
		</struct>
		<struct name="PurpleBuddyList">
			<field name="root" type="PurpleBlistNode*"/>
			<field name="buddies" type="GHashTable*"/>
			<field name="ui_data" type="void*"/>
		</struct>
		<struct name="PurpleCertificate">
			<method name="add_ca_search_path" symbol="purple_certificate_add_ca_search_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="check_signature_chain" symbol="purple_certificate_check_signature_chain">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="chain" type="GList*"/>
				</parameters>
			</method>
			<method name="check_signature_chain_with_failing" symbol="purple_certificate_check_signature_chain_with_failing">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="chain" type="GList*"/>
					<parameter name="failing" type="PurpleCertificate**"/>
				</parameters>
			</method>
			<method name="check_subject_name" symbol="purple_certificate_check_subject_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="crt" type="PurpleCertificate*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="copy" symbol="purple_certificate_copy">
				<return-type type="PurpleCertificate*"/>
				<parameters>
					<parameter name="crt" type="PurpleCertificate*"/>
				</parameters>
			</method>
			<method name="copy_list" symbol="purple_certificate_copy_list">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="crt_list" type="GList*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_certificate_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="crt" type="PurpleCertificate*"/>
				</parameters>
			</method>
			<method name="destroy_list" symbol="purple_certificate_destroy_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="crt_list" type="GList*"/>
				</parameters>
			</method>
			<method name="display_x509" symbol="purple_certificate_display_x509">
				<return-type type="void"/>
				<parameters>
					<parameter name="crt" type="PurpleCertificate*"/>
				</parameters>
			</method>
			<method name="export" symbol="purple_certificate_export">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="filename" type="gchar*"/>
					<parameter name="crt" type="PurpleCertificate*"/>
				</parameters>
			</method>
			<method name="find_pool" symbol="purple_certificate_find_pool">
				<return-type type="PurpleCertificatePool*"/>
				<parameters>
					<parameter name="scheme_name" type="gchar*"/>
					<parameter name="pool_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="find_scheme" symbol="purple_certificate_find_scheme">
				<return-type type="PurpleCertificateScheme*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="find_verifier" symbol="purple_certificate_find_verifier">
				<return-type type="PurpleCertificateVerifier*"/>
				<parameters>
					<parameter name="scheme_name" type="gchar*"/>
					<parameter name="ver_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_fingerprint_sha1" symbol="purple_certificate_get_fingerprint_sha1">
				<return-type type="GByteArray*"/>
				<parameters>
					<parameter name="crt" type="PurpleCertificate*"/>
				</parameters>
			</method>
			<method name="get_handle" symbol="purple_certificate_get_handle">
				<return-type type="gpointer"/>
			</method>
			<method name="get_issuer_unique_id" symbol="purple_certificate_get_issuer_unique_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="crt" type="PurpleCertificate*"/>
				</parameters>
			</method>
			<method name="get_pools" symbol="purple_certificate_get_pools">
				<return-type type="GList*"/>
			</method>
			<method name="get_schemes" symbol="purple_certificate_get_schemes">
				<return-type type="GList*"/>
			</method>
			<method name="get_subject_name" symbol="purple_certificate_get_subject_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="crt" type="PurpleCertificate*"/>
				</parameters>
			</method>
			<method name="get_times" symbol="purple_certificate_get_times">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="crt" type="PurpleCertificate*"/>
					<parameter name="activation" type="time_t*"/>
					<parameter name="expiration" type="time_t*"/>
				</parameters>
			</method>
			<method name="get_unique_id" symbol="purple_certificate_get_unique_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="crt" type="PurpleCertificate*"/>
				</parameters>
			</method>
			<method name="get_verifiers" symbol="purple_certificate_get_verifiers">
				<return-type type="GList*"/>
			</method>
			<method name="import" symbol="purple_certificate_import">
				<return-type type="PurpleCertificate*"/>
				<parameters>
					<parameter name="scheme" type="PurpleCertificateScheme*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="init" symbol="purple_certificate_init">
				<return-type type="void"/>
			</method>
			<method name="register_pool" symbol="purple_certificate_register_pool">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pool" type="PurpleCertificatePool*"/>
				</parameters>
			</method>
			<method name="register_scheme" symbol="purple_certificate_register_scheme">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="scheme" type="PurpleCertificateScheme*"/>
				</parameters>
			</method>
			<method name="register_verifier" symbol="purple_certificate_register_verifier">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="vr" type="PurpleCertificateVerifier*"/>
				</parameters>
			</method>
			<method name="signed_by" symbol="purple_certificate_signed_by">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="crt" type="PurpleCertificate*"/>
					<parameter name="issuer" type="PurpleCertificate*"/>
				</parameters>
			</method>
			<method name="uninit" symbol="purple_certificate_uninit">
				<return-type type="void"/>
			</method>
			<method name="unregister_pool" symbol="purple_certificate_unregister_pool">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pool" type="PurpleCertificatePool*"/>
				</parameters>
			</method>
			<method name="unregister_scheme" symbol="purple_certificate_unregister_scheme">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="scheme" type="PurpleCertificateScheme*"/>
				</parameters>
			</method>
			<method name="unregister_verifier" symbol="purple_certificate_unregister_verifier">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="vr" type="PurpleCertificateVerifier*"/>
				</parameters>
			</method>
			<method name="verify" symbol="purple_certificate_verify">
				<return-type type="void"/>
				<parameters>
					<parameter name="verifier" type="PurpleCertificateVerifier*"/>
					<parameter name="subject_name" type="gchar*"/>
					<parameter name="cert_chain" type="GList*"/>
					<parameter name="cb" type="PurpleCertificateVerifiedCallback"/>
					<parameter name="cb_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="verify_complete" symbol="purple_certificate_verify_complete">
				<return-type type="void"/>
				<parameters>
					<parameter name="vrq" type="PurpleCertificateVerificationRequest*"/>
					<parameter name="st" type="PurpleCertificateVerificationStatus"/>
				</parameters>
			</method>
			<field name="scheme" type="PurpleCertificateScheme*"/>
			<field name="data" type="gpointer"/>
		</struct>
		<struct name="PurpleCertificatePool">
			<method name="contains" symbol="purple_certificate_pool_contains">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pool" type="PurpleCertificatePool*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="delete" symbol="purple_certificate_pool_delete">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pool" type="PurpleCertificatePool*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="destroy_idlist" symbol="purple_certificate_pool_destroy_idlist">
				<return-type type="void"/>
				<parameters>
					<parameter name="idlist" type="GList*"/>
				</parameters>
			</method>
			<method name="get_idlist" symbol="purple_certificate_pool_get_idlist">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="pool" type="PurpleCertificatePool*"/>
				</parameters>
			</method>
			<method name="get_scheme" symbol="purple_certificate_pool_get_scheme">
				<return-type type="PurpleCertificateScheme*"/>
				<parameters>
					<parameter name="pool" type="PurpleCertificatePool*"/>
				</parameters>
			</method>
			<method name="mkpath" symbol="purple_certificate_pool_mkpath">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="pool" type="PurpleCertificatePool*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="retrieve" symbol="purple_certificate_pool_retrieve">
				<return-type type="PurpleCertificate*"/>
				<parameters>
					<parameter name="pool" type="PurpleCertificatePool*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="store" symbol="purple_certificate_pool_store">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pool" type="PurpleCertificatePool*"/>
					<parameter name="id" type="gchar*"/>
					<parameter name="crt" type="PurpleCertificate*"/>
				</parameters>
			</method>
			<method name="usable" symbol="purple_certificate_pool_usable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pool" type="PurpleCertificatePool*"/>
				</parameters>
			</method>
			<field name="scheme_name" type="gchar*"/>
			<field name="name" type="gchar*"/>
			<field name="fullname" type="gchar*"/>
			<field name="data" type="gpointer"/>
			<field name="init" type="GCallback"/>
			<field name="uninit" type="GCallback"/>
			<field name="cert_in_pool" type="GCallback"/>
			<field name="get_cert" type="GCallback"/>
			<field name="put_cert" type="GCallback"/>
			<field name="delete_cert" type="GCallback"/>
			<field name="get_idlist" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleCertificateScheme">
			<field name="name" type="gchar*"/>
			<field name="fullname" type="gchar*"/>
			<field name="import_certificate" type="GCallback"/>
			<field name="export_certificate" type="GCallback"/>
			<field name="copy_certificate" type="GCallback"/>
			<field name="destroy_certificate" type="GCallback"/>
			<field name="signed_by" type="GCallback"/>
			<field name="get_fingerprint_sha1" type="GCallback"/>
			<field name="get_unique_id" type="GCallback"/>
			<field name="get_issuer_unique_id" type="GCallback"/>
			<field name="get_subject_name" type="GCallback"/>
			<field name="check_subject_name" type="GCallback"/>
			<field name="get_times" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleCertificateVerificationRequest">
			<field name="verifier" type="PurpleCertificateVerifier*"/>
			<field name="scheme" type="PurpleCertificateScheme*"/>
			<field name="subject_name" type="gchar*"/>
			<field name="cert_chain" type="GList*"/>
			<field name="data" type="gpointer"/>
			<field name="cb" type="PurpleCertificateVerifiedCallback"/>
			<field name="cb_data" type="gpointer"/>
		</struct>
		<struct name="PurpleCertificateVerifier">
			<field name="scheme_name" type="gchar*"/>
			<field name="name" type="gchar*"/>
			<field name="start_verification" type="GCallback"/>
			<field name="destroy_request" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleChat">
			<method name="destroy" symbol="purple_chat_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleChat*"/>
				</parameters>
			</method>
			<method name="get_account" symbol="purple_chat_get_account">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="chat" type="PurpleChat*"/>
				</parameters>
			</method>
			<method name="get_components" symbol="purple_chat_get_components">
				<return-type type="GHashTable*"/>
				<parameters>
					<parameter name="chat" type="PurpleChat*"/>
				</parameters>
			</method>
			<method name="get_group" symbol="purple_chat_get_group">
				<return-type type="PurpleGroup*"/>
				<parameters>
					<parameter name="chat" type="PurpleChat*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_chat_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="chat" type="PurpleChat*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_chat_new">
				<return-type type="PurpleChat*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="alias" type="char*"/>
					<parameter name="components" type="GHashTable*"/>
				</parameters>
			</method>
			<field name="node" type="PurpleBlistNode"/>
			<field name="alias" type="char*"/>
			<field name="components" type="GHashTable*"/>
			<field name="account" type="PurpleAccount*"/>
		</struct>
		<struct name="PurpleCipher">
			<method name="digest_region" symbol="purple_cipher_digest_region">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="data" type="guchar*"/>
					<parameter name="data_len" type="size_t"/>
					<parameter name="in_len" type="size_t"/>
					<parameter name="digest" type="guchar[]"/>
					<parameter name="out_len" type="size_t*"/>
				</parameters>
			</method>
			<method name="get_capabilities" symbol="purple_cipher_get_capabilities">
				<return-type type="guint"/>
				<parameters>
					<parameter name="cipher" type="PurpleCipher*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_cipher_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="cipher" type="PurpleCipher*"/>
				</parameters>
			</method>
			<method name="http_digest_calculate_response" symbol="purple_cipher_http_digest_calculate_response">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="algorithm" type="gchar*"/>
					<parameter name="method" type="gchar*"/>
					<parameter name="digest_uri" type="gchar*"/>
					<parameter name="qop" type="gchar*"/>
					<parameter name="entity" type="gchar*"/>
					<parameter name="nonce" type="gchar*"/>
					<parameter name="nonce_count" type="gchar*"/>
					<parameter name="client_nonce" type="gchar*"/>
					<parameter name="session_key" type="gchar*"/>
				</parameters>
			</method>
			<method name="http_digest_calculate_session_key" symbol="purple_cipher_http_digest_calculate_session_key">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="algorithm" type="gchar*"/>
					<parameter name="username" type="gchar*"/>
					<parameter name="realm" type="gchar*"/>
					<parameter name="password" type="gchar*"/>
					<parameter name="nonce" type="gchar*"/>
					<parameter name="client_nonce" type="gchar*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleCipherContext">
			<method name="append" symbol="purple_cipher_context_append">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="data" type="guchar*"/>
					<parameter name="len" type="size_t"/>
				</parameters>
			</method>
			<method name="decrypt" symbol="purple_cipher_context_decrypt">
				<return-type type="gint"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="data" type="guchar[]"/>
					<parameter name="len" type="size_t"/>
					<parameter name="output" type="guchar[]"/>
					<parameter name="outlen" type="size_t*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_cipher_context_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
				</parameters>
			</method>
			<method name="digest" symbol="purple_cipher_context_digest">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="in_len" type="size_t"/>
					<parameter name="digest" type="guchar[]"/>
					<parameter name="out_len" type="size_t*"/>
				</parameters>
			</method>
			<method name="digest_to_str" symbol="purple_cipher_context_digest_to_str">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="in_len" type="size_t"/>
					<parameter name="digest_s" type="gchar[]"/>
					<parameter name="out_len" type="size_t*"/>
				</parameters>
			</method>
			<method name="encrypt" symbol="purple_cipher_context_encrypt">
				<return-type type="gint"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="data" type="guchar[]"/>
					<parameter name="len" type="size_t"/>
					<parameter name="output" type="guchar[]"/>
					<parameter name="outlen" type="size_t*"/>
				</parameters>
			</method>
			<method name="get_batch_mode" symbol="purple_cipher_context_get_batch_mode">
				<return-type type="PurpleCipherBatchMode"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
				</parameters>
			</method>
			<method name="get_block_size" symbol="purple_cipher_context_get_block_size">
				<return-type type="size_t"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
				</parameters>
			</method>
			<method name="get_data" symbol="purple_cipher_context_get_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
				</parameters>
			</method>
			<method name="get_key_size" symbol="purple_cipher_context_get_key_size">
				<return-type type="size_t"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
				</parameters>
			</method>
			<method name="get_option" symbol="purple_cipher_context_get_option">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_salt_size" symbol="purple_cipher_context_get_salt_size">
				<return-type type="size_t"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_cipher_context_new">
				<return-type type="PurpleCipherContext*"/>
				<parameters>
					<parameter name="cipher" type="PurpleCipher*"/>
					<parameter name="extra" type="void*"/>
				</parameters>
			</method>
			<method name="new_by_name" symbol="purple_cipher_context_new_by_name">
				<return-type type="PurpleCipherContext*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="extra" type="void*"/>
				</parameters>
			</method>
			<method name="reset" symbol="purple_cipher_context_reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="extra" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_batch_mode" symbol="purple_cipher_context_set_batch_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="mode" type="PurpleCipherBatchMode"/>
				</parameters>
			</method>
			<method name="set_data" symbol="purple_cipher_context_set_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_iv" symbol="purple_cipher_context_set_iv">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="iv" type="guchar*"/>
					<parameter name="len" type="size_t"/>
				</parameters>
			</method>
			<method name="set_key" symbol="purple_cipher_context_set_key">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="key" type="guchar*"/>
				</parameters>
			</method>
			<method name="set_key_with_len" symbol="purple_cipher_context_set_key_with_len">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="key" type="guchar*"/>
					<parameter name="len" type="size_t"/>
				</parameters>
			</method>
			<method name="set_option" symbol="purple_cipher_context_set_option">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_salt" symbol="purple_cipher_context_set_salt">
				<return-type type="void"/>
				<parameters>
					<parameter name="context" type="PurpleCipherContext*"/>
					<parameter name="salt" type="guchar*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleCipherOps">
			<field name="set_option" type="GCallback"/>
			<field name="get_option" type="GCallback"/>
			<field name="init" type="GCallback"/>
			<field name="reset" type="GCallback"/>
			<field name="uninit" type="GCallback"/>
			<field name="set_iv" type="GCallback"/>
			<field name="append" type="GCallback"/>
			<field name="digest" type="GCallback"/>
			<field name="encrypt" type="GCallback"/>
			<field name="decrypt" type="GCallback"/>
			<field name="set_salt" type="GCallback"/>
			<field name="get_salt_size" type="GCallback"/>
			<field name="set_key" type="GCallback"/>
			<field name="get_key_size" type="GCallback"/>
			<field name="set_batch_mode" type="GCallback"/>
			<field name="get_batch_mode" type="GCallback"/>
			<field name="get_block_size" type="GCallback"/>
			<field name="set_key_with_len" type="GCallback"/>
		</struct>
		<struct name="PurpleCircBuffer">
			<method name="append" symbol="purple_circ_buffer_append">
				<return-type type="void"/>
				<parameters>
					<parameter name="buf" type="PurpleCircBuffer*"/>
					<parameter name="src" type="gconstpointer"/>
					<parameter name="len" type="gsize"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_circ_buffer_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="buf" type="PurpleCircBuffer*"/>
				</parameters>
			</method>
			<method name="get_max_read" symbol="purple_circ_buffer_get_max_read">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="buf" type="PurpleCircBuffer*"/>
				</parameters>
			</method>
			<method name="mark_read" symbol="purple_circ_buffer_mark_read">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buf" type="PurpleCircBuffer*"/>
					<parameter name="len" type="gsize"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_circ_buffer_new">
				<return-type type="PurpleCircBuffer*"/>
				<parameters>
					<parameter name="growsize" type="gsize"/>
				</parameters>
			</method>
			<field name="buffer" type="gchar*"/>
			<field name="growsize" type="gsize"/>
			<field name="buflen" type="gsize"/>
			<field name="bufused" type="gsize"/>
			<field name="inptr" type="gchar*"/>
			<field name="outptr" type="gchar*"/>
		</struct>
		<struct name="PurpleCmdId">
		</struct>
		<struct name="PurpleConnection">
			<method name="destroy" symbol="purple_connection_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
				</parameters>
			</method>
			<method name="error" symbol="purple_connection_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
					<parameter name="reason" type="char*"/>
				</parameters>
			</method>
			<method name="error_is_fatal" symbol="purple_connection_error_is_fatal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="reason" type="PurpleConnectionError"/>
				</parameters>
			</method>
			<method name="error_reason" symbol="purple_connection_error_reason">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
					<parameter name="reason" type="PurpleConnectionError"/>
					<parameter name="description" type="char*"/>
				</parameters>
			</method>
			<method name="get_account" symbol="purple_connection_get_account">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
				</parameters>
			</method>
			<method name="get_display_name" symbol="purple_connection_get_display_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
				</parameters>
			</method>
			<method name="get_password" symbol="purple_connection_get_password">
				<return-type type="char*"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
				</parameters>
			</method>
			<method name="get_protocol_data" symbol="purple_connection_get_protocol_data">
				<return-type type="void*"/>
				<parameters>
					<parameter name="connection" type="PurpleConnection*"/>
				</parameters>
			</method>
			<method name="get_prpl" symbol="purple_connection_get_prpl">
				<return-type type="PurplePlugin*"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="purple_connection_get_state">
				<return-type type="PurpleConnectionState"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_connection_new">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="regist" type="gboolean"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</method>
			<method name="new_unregister" symbol="purple_connection_new_unregister">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="password" type="char*"/>
					<parameter name="cb" type="PurpleAccountUnregistrationCb"/>
					<parameter name="user_data" type="void*"/>
				</parameters>
			</method>
			<method name="notice" symbol="purple_connection_notice">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
					<parameter name="text" type="char*"/>
				</parameters>
			</method>
			<method name="set_account" symbol="purple_connection_set_account">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="set_display_name" symbol="purple_connection_set_display_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_protocol_data" symbol="purple_connection_set_protocol_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="connection" type="PurpleConnection*"/>
					<parameter name="proto_data" type="void*"/>
				</parameters>
			</method>
			<method name="set_state" symbol="purple_connection_set_state">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
					<parameter name="state" type="PurpleConnectionState"/>
				</parameters>
			</method>
			<method name="ssl_error" symbol="purple_connection_ssl_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
					<parameter name="ssl_error" type="PurpleSslErrorType"/>
				</parameters>
			</method>
			<method name="update_progress" symbol="purple_connection_update_progress">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
					<parameter name="text" type="char*"/>
					<parameter name="step" type="size_t"/>
					<parameter name="count" type="size_t"/>
				</parameters>
			</method>
			<field name="prpl" type="PurplePlugin*"/>
			<field name="flags" type="PurpleConnectionFlags"/>
			<field name="state" type="PurpleConnectionState"/>
			<field name="account" type="PurpleAccount*"/>
			<field name="password" type="char*"/>
			<field name="inpa" type="int"/>
			<field name="buddy_chats" type="GSList*"/>
			<field name="proto_data" type="void*"/>
			<field name="display_name" type="char*"/>
			<field name="keepalive" type="guint"/>
			<field name="wants_to_die" type="gboolean"/>
			<field name="disconnect_timeout" type="guint"/>
			<field name="last_received" type="time_t"/>
		</struct>
		<struct name="PurpleConnectionErrorInfo">
			<field name="type" type="PurpleConnectionError"/>
			<field name="description" type="char*"/>
		</struct>
		<struct name="PurpleConnectionUiOps">
			<field name="connect_progress" type="GCallback"/>
			<field name="connected" type="GCallback"/>
			<field name="disconnected" type="GCallback"/>
			<field name="notice" type="GCallback"/>
			<field name="report_disconnect" type="GCallback"/>
			<field name="network_connected" type="GCallback"/>
			<field name="network_disconnected" type="GCallback"/>
			<field name="report_disconnect_reason" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
		</struct>
		<struct name="PurpleContact">
			<method name="destroy" symbol="purple_contact_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="contact" type="PurpleContact*"/>
				</parameters>
			</method>
			<method name="get_alias" symbol="purple_contact_get_alias">
				<return-type type="char*"/>
				<parameters>
					<parameter name="contact" type="PurpleContact*"/>
				</parameters>
			</method>
			<method name="get_priority_buddy" symbol="purple_contact_get_priority_buddy">
				<return-type type="PurpleBuddy*"/>
				<parameters>
					<parameter name="contact" type="PurpleContact*"/>
				</parameters>
			</method>
			<method name="invalidate_priority_buddy" symbol="purple_contact_invalidate_priority_buddy">
				<return-type type="void"/>
				<parameters>
					<parameter name="contact" type="PurpleContact*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_contact_new">
				<return-type type="PurpleContact*"/>
			</method>
			<method name="on_account" symbol="purple_contact_on_account">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="contact" type="PurpleContact*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="set_alias" symbol="purple_contact_set_alias">
				<return-type type="void"/>
				<parameters>
					<parameter name="contact" type="PurpleContact*"/>
					<parameter name="alias" type="char*"/>
				</parameters>
			</method>
			<field name="node" type="PurpleBlistNode"/>
			<field name="alias" type="char*"/>
			<field name="totalsize" type="int"/>
			<field name="currentsize" type="int"/>
			<field name="online" type="int"/>
			<field name="priority" type="PurpleBuddy*"/>
			<field name="priority_valid" type="gboolean"/>
		</struct>
		<struct name="PurpleConvChat">
			<method name="add_user" symbol="purple_conv_chat_add_user">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="user" type="char*"/>
					<parameter name="extra_msg" type="char*"/>
					<parameter name="flags" type="PurpleConvChatBuddyFlags"/>
					<parameter name="new_arrival" type="gboolean"/>
				</parameters>
			</method>
			<method name="add_users" symbol="purple_conv_chat_add_users">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="users" type="GList*"/>
					<parameter name="extra_msgs" type="GList*"/>
					<parameter name="flags" type="GList*"/>
					<parameter name="new_arrivals" type="gboolean"/>
				</parameters>
			</method>
			<method name="cb_destroy" symbol="purple_conv_chat_cb_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="cb" type="PurpleConvChatBuddy*"/>
				</parameters>
			</method>
			<method name="cb_find" symbol="purple_conv_chat_cb_find">
				<return-type type="PurpleConvChatBuddy*"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="cb_get_name" symbol="purple_conv_chat_cb_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="cb" type="PurpleConvChatBuddy*"/>
				</parameters>
			</method>
			<method name="cb_new" symbol="purple_conv_chat_cb_new">
				<return-type type="PurpleConvChatBuddy*"/>
				<parameters>
					<parameter name="name" type="char*"/>
					<parameter name="alias" type="char*"/>
					<parameter name="flags" type="PurpleConvChatBuddyFlags"/>
				</parameters>
			</method>
			<method name="clear_users" symbol="purple_conv_chat_clear_users">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
				</parameters>
			</method>
			<method name="find_user" symbol="purple_conv_chat_find_user">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="user" type="char*"/>
				</parameters>
			</method>
			<method name="get_conversation" symbol="purple_conv_chat_get_conversation">
				<return-type type="PurpleConversation*"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="purple_conv_chat_get_id">
				<return-type type="int"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
				</parameters>
			</method>
			<method name="get_ignored" symbol="purple_conv_chat_get_ignored">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
				</parameters>
			</method>
			<method name="get_ignored_user" symbol="purple_conv_chat_get_ignored_user">
				<return-type type="char*"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="user" type="char*"/>
				</parameters>
			</method>
			<method name="get_nick" symbol="purple_conv_chat_get_nick">
				<return-type type="char*"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
				</parameters>
			</method>
			<method name="get_topic" symbol="purple_conv_chat_get_topic">
				<return-type type="char*"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
				</parameters>
			</method>
			<method name="get_users" symbol="purple_conv_chat_get_users">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
				</parameters>
			</method>
			<method name="has_left" symbol="purple_conv_chat_has_left">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
				</parameters>
			</method>
			<method name="ignore" symbol="purple_conv_chat_ignore">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="invite_user" symbol="purple_conv_chat_invite_user">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="user" type="char*"/>
					<parameter name="message" type="char*"/>
					<parameter name="confirm" type="gboolean"/>
				</parameters>
			</method>
			<method name="is_user_ignored" symbol="purple_conv_chat_is_user_ignored">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="user" type="char*"/>
				</parameters>
			</method>
			<method name="left" symbol="purple_conv_chat_left">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
				</parameters>
			</method>
			<method name="remove_user" symbol="purple_conv_chat_remove_user">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="user" type="char*"/>
					<parameter name="reason" type="char*"/>
				</parameters>
			</method>
			<method name="remove_users" symbol="purple_conv_chat_remove_users">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="users" type="GList*"/>
					<parameter name="reason" type="char*"/>
				</parameters>
			</method>
			<method name="rename_user" symbol="purple_conv_chat_rename_user">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="old_user" type="char*"/>
					<parameter name="new_user" type="char*"/>
				</parameters>
			</method>
			<method name="send" symbol="purple_conv_chat_send">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="message" type="char*"/>
				</parameters>
			</method>
			<method name="send_with_flags" symbol="purple_conv_chat_send_with_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="message" type="char*"/>
					<parameter name="flags" type="PurpleMessageFlags"/>
				</parameters>
			</method>
			<method name="set_id" symbol="purple_conv_chat_set_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="id" type="int"/>
				</parameters>
			</method>
			<method name="set_ignored" symbol="purple_conv_chat_set_ignored">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="ignored" type="GList*"/>
				</parameters>
			</method>
			<method name="set_nick" symbol="purple_conv_chat_set_nick">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="nick" type="char*"/>
				</parameters>
			</method>
			<method name="set_topic" symbol="purple_conv_chat_set_topic">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="who" type="char*"/>
					<parameter name="topic" type="char*"/>
				</parameters>
			</method>
			<method name="set_users" symbol="purple_conv_chat_set_users">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="users" type="GList*"/>
				</parameters>
			</method>
			<method name="unignore" symbol="purple_conv_chat_unignore">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="user_get_flags" symbol="purple_conv_chat_user_get_flags">
				<return-type type="PurpleConvChatBuddyFlags"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="user" type="char*"/>
				</parameters>
			</method>
			<method name="user_set_flags" symbol="purple_conv_chat_user_set_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="user" type="char*"/>
					<parameter name="flags" type="PurpleConvChatBuddyFlags"/>
				</parameters>
			</method>
			<method name="write" symbol="purple_conv_chat_write">
				<return-type type="void"/>
				<parameters>
					<parameter name="chat" type="PurpleConvChat*"/>
					<parameter name="who" type="char*"/>
					<parameter name="message" type="char*"/>
					<parameter name="flags" type="PurpleMessageFlags"/>
					<parameter name="mtime" type="time_t"/>
				</parameters>
			</method>
			<field name="conv" type="PurpleConversation*"/>
			<field name="in_room" type="GList*"/>
			<field name="ignored" type="GList*"/>
			<field name="who" type="char*"/>
			<field name="topic" type="char*"/>
			<field name="id" type="int"/>
			<field name="nick" type="char*"/>
			<field name="left" type="gboolean"/>
		</struct>
		<struct name="PurpleConvChatBuddy">
			<field name="name" type="char*"/>
			<field name="alias" type="char*"/>
			<field name="alias_key" type="char*"/>
			<field name="buddy" type="gboolean"/>
			<field name="flags" type="PurpleConvChatBuddyFlags"/>
		</struct>
		<struct name="PurpleConvIm">
			<method name="get_conversation" symbol="purple_conv_im_get_conversation">
				<return-type type="PurpleConversation*"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="purple_conv_im_get_icon">
				<return-type type="PurpleBuddyIcon*"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
				</parameters>
			</method>
			<method name="get_send_typed_timeout" symbol="purple_conv_im_get_send_typed_timeout">
				<return-type type="guint"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
				</parameters>
			</method>
			<method name="get_type_again" symbol="purple_conv_im_get_type_again">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
				</parameters>
			</method>
			<method name="get_typing_state" symbol="purple_conv_im_get_typing_state">
				<return-type type="PurpleTypingState"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
				</parameters>
			</method>
			<method name="get_typing_timeout" symbol="purple_conv_im_get_typing_timeout">
				<return-type type="guint"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
				</parameters>
			</method>
			<method name="send" symbol="purple_conv_im_send">
				<return-type type="void"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
					<parameter name="message" type="char*"/>
				</parameters>
			</method>
			<method name="send_with_flags" symbol="purple_conv_im_send_with_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
					<parameter name="message" type="char*"/>
					<parameter name="flags" type="PurpleMessageFlags"/>
				</parameters>
			</method>
			<method name="set_icon" symbol="purple_conv_im_set_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
					<parameter name="icon" type="PurpleBuddyIcon*"/>
				</parameters>
			</method>
			<method name="set_type_again" symbol="purple_conv_im_set_type_again">
				<return-type type="void"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
					<parameter name="val" type="unsigned"/>
				</parameters>
			</method>
			<method name="set_typing_state" symbol="purple_conv_im_set_typing_state">
				<return-type type="void"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
					<parameter name="state" type="PurpleTypingState"/>
				</parameters>
			</method>
			<method name="start_send_typed_timeout" symbol="purple_conv_im_start_send_typed_timeout">
				<return-type type="void"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
				</parameters>
			</method>
			<method name="start_typing_timeout" symbol="purple_conv_im_start_typing_timeout">
				<return-type type="void"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
					<parameter name="timeout" type="int"/>
				</parameters>
			</method>
			<method name="stop_send_typed_timeout" symbol="purple_conv_im_stop_send_typed_timeout">
				<return-type type="void"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
				</parameters>
			</method>
			<method name="stop_typing_timeout" symbol="purple_conv_im_stop_typing_timeout">
				<return-type type="void"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
				</parameters>
			</method>
			<method name="update_typing" symbol="purple_conv_im_update_typing">
				<return-type type="void"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
				</parameters>
			</method>
			<method name="write" symbol="purple_conv_im_write">
				<return-type type="void"/>
				<parameters>
					<parameter name="im" type="PurpleConvIm*"/>
					<parameter name="who" type="char*"/>
					<parameter name="message" type="char*"/>
					<parameter name="flags" type="PurpleMessageFlags"/>
					<parameter name="mtime" type="time_t"/>
				</parameters>
			</method>
			<field name="conv" type="PurpleConversation*"/>
			<field name="typing_state" type="PurpleTypingState"/>
			<field name="typing_timeout" type="guint"/>
			<field name="type_again" type="time_t"/>
			<field name="send_typed_timeout" type="guint"/>
			<field name="icon" type="PurpleBuddyIcon*"/>
		</struct>
		<struct name="PurpleConvMessage">
			<field name="who" type="char*"/>
			<field name="what" type="char*"/>
			<field name="flags" type="PurpleMessageFlags"/>
			<field name="when" type="time_t"/>
			<field name="conv" type="PurpleConversation*"/>
			<field name="alias" type="char*"/>
		</struct>
		<struct name="PurpleConversation">
			<method name="autoset_title" symbol="purple_conversation_autoset_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="clear_message_history" symbol="purple_conversation_clear_message_history">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="close_logs" symbol="purple_conversation_close_logs">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_conversation_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="do_command" symbol="purple_conversation_do_command">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
					<parameter name="cmdline" type="gchar*"/>
					<parameter name="markup" type="gchar*"/>
					<parameter name="error" type="gchar**"/>
				</parameters>
			</method>
			<method name="foreach" symbol="purple_conversation_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="func" type="GCallback"/>
				</parameters>
			</method>
			<method name="get_account" symbol="purple_conversation_get_account">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="get_chat_data" symbol="purple_conversation_get_chat_data">
				<return-type type="PurpleConvChat*"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="get_data" symbol="purple_conversation_get_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
					<parameter name="key" type="char*"/>
				</parameters>
			</method>
			<method name="get_extended_menu" symbol="purple_conversation_get_extended_menu">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="get_features" symbol="purple_conversation_get_features">
				<return-type type="PurpleConnectionFlags"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="get_gc" symbol="purple_conversation_get_gc">
				<return-type type="PurpleConnection*"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="get_im_data" symbol="purple_conversation_get_im_data">
				<return-type type="PurpleConvIm*"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="get_message_history" symbol="purple_conversation_get_message_history">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_conversation_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="purple_conversation_get_title">
				<return-type type="char*"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="get_ui_ops" symbol="purple_conversation_get_ui_ops">
				<return-type type="PurpleConversationUiOps*"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="has_focus" symbol="purple_conversation_has_focus">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="is_logging" symbol="purple_conversation_is_logging">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="message_get_flags" symbol="purple_conversation_message_get_flags">
				<return-type type="PurpleMessageFlags"/>
				<parameters>
					<parameter name="msg" type="PurpleConvMessage*"/>
				</parameters>
			</method>
			<method name="message_get_message" symbol="purple_conversation_message_get_message">
				<return-type type="char*"/>
				<parameters>
					<parameter name="msg" type="PurpleConvMessage*"/>
				</parameters>
			</method>
			<method name="message_get_sender" symbol="purple_conversation_message_get_sender">
				<return-type type="char*"/>
				<parameters>
					<parameter name="msg" type="PurpleConvMessage*"/>
				</parameters>
			</method>
			<method name="message_get_timestamp" symbol="purple_conversation_message_get_timestamp">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="msg" type="PurpleConvMessage*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_conversation_new">
				<return-type type="PurpleConversation*"/>
				<parameters>
					<parameter name="type" type="PurpleConversationType"/>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="present" symbol="purple_conversation_present">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="set_account" symbol="purple_conversation_set_account">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="set_data" symbol="purple_conversation_set_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
					<parameter name="key" type="char*"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_features" symbol="purple_conversation_set_features">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
					<parameter name="features" type="PurpleConnectionFlags"/>
				</parameters>
			</method>
			<method name="set_logging" symbol="purple_conversation_set_logging">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
					<parameter name="log" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_name" symbol="purple_conversation_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_title" symbol="purple_conversation_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
					<parameter name="title" type="char*"/>
				</parameters>
			</method>
			<method name="set_ui_ops" symbol="purple_conversation_set_ui_ops">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
					<parameter name="ops" type="PurpleConversationUiOps*"/>
				</parameters>
			</method>
			<method name="update" symbol="purple_conversation_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
					<parameter name="type" type="PurpleConvUpdateType"/>
				</parameters>
			</method>
			<method name="write" symbol="purple_conversation_write">
				<return-type type="void"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
					<parameter name="who" type="char*"/>
					<parameter name="message" type="char*"/>
					<parameter name="flags" type="PurpleMessageFlags"/>
					<parameter name="mtime" type="time_t"/>
				</parameters>
			</method>
			<field name="type" type="PurpleConversationType"/>
			<field name="account" type="PurpleAccount*"/>
			<field name="name" type="char*"/>
			<field name="title" type="char*"/>
			<field name="logging" type="gboolean"/>
			<field name="logs" type="GList*"/>
			<field name="u" type="gpointer"/>
			<field name="ui_ops" type="PurpleConversationUiOps*"/>
			<field name="ui_data" type="void*"/>
			<field name="data" type="GHashTable*"/>
			<field name="features" type="PurpleConnectionFlags"/>
			<field name="message_history" type="GList*"/>
		</struct>
		<struct name="PurpleConversationUiOps">
			<field name="create_conversation" type="GCallback"/>
			<field name="destroy_conversation" type="GCallback"/>
			<field name="write_chat" type="GCallback"/>
			<field name="write_im" type="GCallback"/>
			<field name="write_conv" type="GCallback"/>
			<field name="chat_add_users" type="GCallback"/>
			<field name="chat_rename_user" type="GCallback"/>
			<field name="chat_remove_users" type="GCallback"/>
			<field name="chat_update_user" type="GCallback"/>
			<field name="present" type="GCallback"/>
			<field name="has_focus" type="GCallback"/>
			<field name="custom_smiley_add" type="GCallback"/>
			<field name="custom_smiley_write" type="GCallback"/>
			<field name="custom_smiley_close" type="GCallback"/>
			<field name="send_confirm" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleCore">
			<method name="ensure_single_instance" symbol="purple_core_ensure_single_instance">
				<return-type type="gboolean"/>
			</method>
			<method name="get_ui" symbol="purple_core_get_ui">
				<return-type type="char*"/>
			</method>
			<method name="get_ui_info" symbol="purple_core_get_ui_info">
				<return-type type="GHashTable*"/>
			</method>
			<method name="get_ui_ops" symbol="purple_core_get_ui_ops">
				<return-type type="PurpleCoreUiOps*"/>
			</method>
			<method name="get_version" symbol="purple_core_get_version">
				<return-type type="char*"/>
			</method>
			<method name="init" symbol="purple_core_init">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="ui" type="char*"/>
				</parameters>
			</method>
			<method name="migrate" symbol="purple_core_migrate">
				<return-type type="gboolean"/>
			</method>
			<method name="quit" symbol="purple_core_quit">
				<return-type type="void"/>
			</method>
			<method name="quit_cb" symbol="purple_core_quit_cb">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="unused" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_ui_ops" symbol="purple_core_set_ui_ops">
				<return-type type="void"/>
				<parameters>
					<parameter name="ops" type="PurpleCoreUiOps*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleCoreUiOps">
			<field name="ui_prefs_init" type="GCallback"/>
			<field name="debug_ui_init" type="GCallback"/>
			<field name="ui_init" type="GCallback"/>
			<field name="quit" type="GCallback"/>
			<field name="get_ui_info" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
		</struct>
		<struct name="PurpleDBusType">
			<field name="parent" type="PurpleDBusType*"/>
		</struct>
		<struct name="PurpleDebugUiOps">
			<field name="print" type="GCallback"/>
			<field name="is_enabled" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleDesktopItem">
			<method name="copy" symbol="purple_desktop_item_copy">
				<return-type type="PurpleDesktopItem*"/>
				<parameters>
					<parameter name="item" type="PurpleDesktopItem*"/>
				</parameters>
			</method>
			<method name="get_entry_type" symbol="purple_desktop_item_get_entry_type">
				<return-type type="PurpleDesktopItemType"/>
				<parameters>
					<parameter name="item" type="PurpleDesktopItem*"/>
				</parameters>
			</method>
			<method name="get_string" symbol="purple_desktop_item_get_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="item" type="PurpleDesktopItem*"/>
					<parameter name="attr" type="char*"/>
				</parameters>
			</method>
			<method name="new_from_file" symbol="purple_desktop_item_new_from_file">
				<return-type type="PurpleDesktopItem*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
				</parameters>
			</method>
			<method name="unref" symbol="purple_desktop_item_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="PurpleDesktopItem*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleDnsQueryData">
		</struct>
		<struct name="PurpleDnsQueryUiOps">
			<field name="resolve_host" type="GCallback"/>
			<field name="destroy" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleEventLoopUiOps">
			<field name="timeout_add" type="GCallback"/>
			<field name="timeout_remove" type="GCallback"/>
			<field name="input_add" type="GCallback"/>
			<field name="input_remove" type="GCallback"/>
			<field name="input_get_error" type="GCallback"/>
			<field name="timeout_add_seconds" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleGroup">
			<method name="destroy" symbol="purple_group_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="PurpleGroup*"/>
				</parameters>
			</method>
			<method name="get_accounts" symbol="purple_group_get_accounts">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="g" type="PurpleGroup*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_group_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="group" type="PurpleGroup*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_group_new">
				<return-type type="PurpleGroup*"/>
				<parameters>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="on_account" symbol="purple_group_on_account">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="g" type="PurpleGroup*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<field name="node" type="PurpleBlistNode"/>
			<field name="name" type="char*"/>
			<field name="totalsize" type="int"/>
			<field name="currentsize" type="int"/>
			<field name="online" type="int"/>
		</struct>
		<struct name="PurpleIdleUiOps">
			<field name="get_time_idle" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleKeyValuePair">
			<field name="key" type="gchar*"/>
			<field name="value" type="void*"/>
		</struct>
		<struct name="PurpleLog">
			<method name="common_deleter" symbol="purple_log_common_deleter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="log" type="PurpleLog*"/>
				</parameters>
			</method>
			<method name="common_is_deletable" symbol="purple_log_common_is_deletable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="log" type="PurpleLog*"/>
				</parameters>
			</method>
			<method name="common_lister" symbol="purple_log_common_lister">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="type" type="PurpleLogType"/>
					<parameter name="name" type="char*"/>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="ext" type="char*"/>
					<parameter name="logger" type="PurpleLogLogger*"/>
				</parameters>
			</method>
			<method name="common_sizer" symbol="purple_log_common_sizer">
				<return-type type="int"/>
				<parameters>
					<parameter name="log" type="PurpleLog*"/>
				</parameters>
			</method>
			<method name="common_total_sizer" symbol="purple_log_common_total_sizer">
				<return-type type="int"/>
				<parameters>
					<parameter name="type" type="PurpleLogType"/>
					<parameter name="name" type="char*"/>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="ext" type="char*"/>
				</parameters>
			</method>
			<method name="common_writer" symbol="purple_log_common_writer">
				<return-type type="void"/>
				<parameters>
					<parameter name="log" type="PurpleLog*"/>
					<parameter name="ext" type="char*"/>
				</parameters>
			</method>
			<method name="compare" symbol="purple_log_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="y" type="gconstpointer"/>
					<parameter name="z" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="delete" symbol="purple_log_delete">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="log" type="PurpleLog*"/>
				</parameters>
			</method>
			<method name="free" symbol="purple_log_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="log" type="PurpleLog*"/>
				</parameters>
			</method>
			<method name="get_activity_score" symbol="purple_log_get_activity_score">
				<return-type type="int"/>
				<parameters>
					<parameter name="type" type="PurpleLogType"/>
					<parameter name="name" type="char*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_handle" symbol="purple_log_get_handle">
				<return-type type="void*"/>
			</method>
			<method name="get_log_dir" symbol="purple_log_get_log_dir">
				<return-type type="char*"/>
				<parameters>
					<parameter name="type" type="PurpleLogType"/>
					<parameter name="name" type="char*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_log_sets" symbol="purple_log_get_log_sets">
				<return-type type="GHashTable*"/>
			</method>
			<method name="get_logs" symbol="purple_log_get_logs">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="type" type="PurpleLogType"/>
					<parameter name="name" type="char*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="purple_log_get_size">
				<return-type type="int"/>
				<parameters>
					<parameter name="log" type="PurpleLog*"/>
				</parameters>
			</method>
			<method name="get_system_logs" symbol="purple_log_get_system_logs">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_total_size" symbol="purple_log_get_total_size">
				<return-type type="int"/>
				<parameters>
					<parameter name="type" type="PurpleLogType"/>
					<parameter name="name" type="char*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="init" symbol="purple_log_init">
				<return-type type="void"/>
			</method>
			<method name="is_deletable" symbol="purple_log_is_deletable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="log" type="PurpleLog*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_log_new">
				<return-type type="PurpleLog*"/>
				<parameters>
					<parameter name="type" type="PurpleLogType"/>
					<parameter name="name" type="char*"/>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="conv" type="PurpleConversation*"/>
					<parameter name="time" type="time_t"/>
					<parameter name="tm" type="struct tm*"/>
				</parameters>
			</method>
			<method name="read" symbol="purple_log_read">
				<return-type type="char*"/>
				<parameters>
					<parameter name="log" type="PurpleLog*"/>
					<parameter name="flags" type="PurpleLogReadFlags*"/>
				</parameters>
			</method>
			<method name="uninit" symbol="purple_log_uninit">
				<return-type type="void"/>
			</method>
			<method name="write" symbol="purple_log_write">
				<return-type type="void"/>
				<parameters>
					<parameter name="log" type="PurpleLog*"/>
					<parameter name="type" type="PurpleMessageFlags"/>
					<parameter name="from" type="char*"/>
					<parameter name="time" type="time_t"/>
					<parameter name="message" type="char*"/>
				</parameters>
			</method>
			<field name="type" type="PurpleLogType"/>
			<field name="name" type="char*"/>
			<field name="account" type="PurpleAccount*"/>
			<field name="conv" type="PurpleConversation*"/>
			<field name="time" type="time_t"/>
			<field name="logger" type="PurpleLogLogger*"/>
			<field name="logger_data" type="void*"/>
			<field name="tm" type="struct tm*"/>
		</struct>
		<struct name="PurpleLogCommonLoggerData">
			<field name="path" type="char*"/>
			<field name="file" type="FILE*"/>
			<field name="extra_data" type="void*"/>
		</struct>
		<struct name="PurpleLogLogger">
			<method name="add" symbol="purple_log_logger_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="logger" type="PurpleLogLogger*"/>
				</parameters>
			</method>
			<method name="free" symbol="purple_log_logger_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="logger" type="PurpleLogLogger*"/>
				</parameters>
			</method>
			<method name="get" symbol="purple_log_logger_get">
				<return-type type="PurpleLogLogger*"/>
			</method>
			<method name="get_options" symbol="purple_log_logger_get_options">
				<return-type type="GList*"/>
			</method>
			<method name="new" symbol="purple_log_logger_new">
				<return-type type="PurpleLogLogger*"/>
				<parameters>
					<parameter name="id" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="functions" type="int"/>
				</parameters>
			</method>
			<method name="remove" symbol="purple_log_logger_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="logger" type="PurpleLogLogger*"/>
				</parameters>
			</method>
			<method name="set" symbol="purple_log_logger_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="logger" type="PurpleLogLogger*"/>
				</parameters>
			</method>
			<field name="name" type="char*"/>
			<field name="id" type="char*"/>
			<field name="create" type="GCallback"/>
			<field name="write" type="GCallback"/>
			<field name="finalize" type="GCallback"/>
			<field name="list" type="GCallback"/>
			<field name="read" type="GCallback"/>
			<field name="size" type="GCallback"/>
			<field name="total_size" type="GCallback"/>
			<field name="list_syslog" type="GCallback"/>
			<field name="get_log_sets" type="GCallback"/>
			<field name="remove" type="GCallback"/>
			<field name="is_deletable" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleLogSet">
			<method name="compare" symbol="purple_log_set_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="y" type="gconstpointer"/>
					<parameter name="z" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="purple_log_set_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="PurpleLogSet*"/>
				</parameters>
			</method>
			<field name="type" type="PurpleLogType"/>
			<field name="name" type="char*"/>
			<field name="account" type="PurpleAccount*"/>
			<field name="buddy" type="gboolean"/>
			<field name="normalized_name" type="char*"/>
		</struct>
		<struct name="PurpleMedia">
			<method name="accepted" symbol="purple_media_accepted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="sess_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_remote_candidates" symbol="purple_media_add_remote_candidates">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="sess_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
					<parameter name="remote_candidates" type="GList*"/>
				</parameters>
			</method>
			<method name="add_stream" symbol="purple_media_add_stream">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="sess_id" type="gchar*"/>
					<parameter name="who" type="gchar*"/>
					<parameter name="type" type="PurpleMediaSessionType"/>
					<parameter name="initiator" type="gboolean"/>
					<parameter name="transmitter" type="gchar*"/>
					<parameter name="num_params" type="guint"/>
					<parameter name="params" type="GParameter*"/>
				</parameters>
			</method>
			<method name="candidates_prepared" symbol="purple_media_candidates_prepared">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="session_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
				</parameters>
			</method>
			<method name="codecs_ready" symbol="purple_media_codecs_ready">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="sess_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="element_type_get_type" symbol="purple_media_element_type_get_type">
				<return-type type="GType"/>
			</method>
			<method name="end" symbol="purple_media_end">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="session_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
				</parameters>
			</method>
			<method name="error" symbol="purple_media_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="error" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_account" symbol="purple_media_get_account">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
				</parameters>
			</method>
			<method name="get_codecs" symbol="purple_media_get_codecs">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="sess_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_local_candidates" symbol="purple_media_get_local_candidates">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="sess_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_manager" symbol="purple_media_get_manager">
				<return-type type="struct _PurpleMediaManager*"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
				</parameters>
			</method>
			<method name="get_prpl_data" symbol="purple_media_get_prpl_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
				</parameters>
			</method>
			<method name="get_session_ids" symbol="purple_media_get_session_ids">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
				</parameters>
			</method>
			<method name="get_session_type" symbol="purple_media_get_session_type">
				<return-type type="PurpleMediaSessionType"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="sess_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_src" symbol="purple_media_get_src">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="sess_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_tee" symbol="purple_media_get_tee">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="session_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
				</parameters>
			</method>
			<method name="info_type_get_type" symbol="purple_media_info_type_get_type">
				<return-type type="GType"/>
			</method>
			<method name="is_initiator" symbol="purple_media_is_initiator">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="sess_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
				</parameters>
			</method>
			<method name="network_protocol_get_type" symbol="purple_media_network_protocol_get_type">
				<return-type type="GType"/>
			</method>
			<method name="remove_output_windows" symbol="purple_media_remove_output_windows">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
				</parameters>
			</method>
			<method name="session_type_get_type" symbol="purple_media_session_type_get_type">
				<return-type type="GType"/>
			</method>
			<method name="set_input_volume" symbol="purple_media_set_input_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="session_id" type="gchar*"/>
					<parameter name="level" type="double"/>
				</parameters>
			</method>
			<method name="set_output_volume" symbol="purple_media_set_output_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="session_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
					<parameter name="level" type="double"/>
				</parameters>
			</method>
			<method name="set_output_window" symbol="purple_media_set_output_window">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="session_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
					<parameter name="window_id" type="gulong"/>
				</parameters>
			</method>
			<method name="set_prpl_data" symbol="purple_media_set_prpl_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="prpl_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_remote_codecs" symbol="purple_media_set_remote_codecs">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="sess_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
					<parameter name="codecs" type="GList*"/>
				</parameters>
			</method>
			<method name="set_send_codec" symbol="purple_media_set_send_codec">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="sess_id" type="gchar*"/>
					<parameter name="codec" type="PurpleMediaCodec*"/>
				</parameters>
			</method>
			<method name="state_changed_get_type" symbol="purple_media_state_changed_get_type">
				<return-type type="GType"/>
			</method>
			<method name="stream_info" symbol="purple_media_stream_info">
				<return-type type="void"/>
				<parameters>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="type" type="PurpleMediaInfoType"/>
					<parameter name="session_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
					<parameter name="local" type="gboolean"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleMediaCandidate">
			<method name="get_base_ip" symbol="purple_media_candidate_get_base_ip">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="candidate" type="PurpleMediaCandidate*"/>
				</parameters>
			</method>
			<method name="get_base_port" symbol="purple_media_candidate_get_base_port">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="candidate" type="PurpleMediaCandidate*"/>
				</parameters>
			</method>
			<method name="get_candidate_type" symbol="purple_media_candidate_get_candidate_type">
				<return-type type="PurpleMediaCandidateType"/>
				<parameters>
					<parameter name="candidate" type="PurpleMediaCandidate*"/>
				</parameters>
			</method>
			<method name="get_component_id" symbol="purple_media_candidate_get_component_id">
				<return-type type="guint"/>
				<parameters>
					<parameter name="candidate" type="PurpleMediaCandidate*"/>
				</parameters>
			</method>
			<method name="get_foundation" symbol="purple_media_candidate_get_foundation">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="candidate" type="PurpleMediaCandidate*"/>
				</parameters>
			</method>
			<method name="get_ip" symbol="purple_media_candidate_get_ip">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="candidate" type="PurpleMediaCandidate*"/>
				</parameters>
			</method>
			<method name="get_password" symbol="purple_media_candidate_get_password">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="candidate" type="PurpleMediaCandidate*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="purple_media_candidate_get_port">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="candidate" type="PurpleMediaCandidate*"/>
				</parameters>
			</method>
			<method name="get_priority" symbol="purple_media_candidate_get_priority">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="candidate" type="PurpleMediaCandidate*"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="purple_media_candidate_get_protocol">
				<return-type type="PurpleMediaNetworkProtocol"/>
				<parameters>
					<parameter name="candidate" type="PurpleMediaCandidate*"/>
				</parameters>
			</method>
			<method name="get_ttl" symbol="purple_media_candidate_get_ttl">
				<return-type type="guint"/>
				<parameters>
					<parameter name="candidate" type="PurpleMediaCandidate*"/>
				</parameters>
			</method>
			<method name="get_username" symbol="purple_media_candidate_get_username">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="candidate" type="PurpleMediaCandidate*"/>
				</parameters>
			</method>
			<method name="list_copy" symbol="purple_media_candidate_list_copy">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="candidates" type="GList*"/>
				</parameters>
			</method>
			<method name="list_free" symbol="purple_media_candidate_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="candidates" type="GList*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_media_candidate_new">
				<return-type type="PurpleMediaCandidate*"/>
				<parameters>
					<parameter name="foundation" type="gchar*"/>
					<parameter name="component_id" type="guint"/>
					<parameter name="type" type="PurpleMediaCandidateType"/>
					<parameter name="proto" type="PurpleMediaNetworkProtocol"/>
					<parameter name="ip" type="gchar*"/>
					<parameter name="port" type="guint"/>
				</parameters>
			</method>
			<method name="type_get_type" symbol="purple_media_candidate_type_get_type">
				<return-type type="GType"/>
			</method>
		</struct>
		<struct name="PurpleMediaCodec">
			<method name="add_optional_parameter" symbol="purple_media_codec_add_optional_parameter">
				<return-type type="void"/>
				<parameters>
					<parameter name="codec" type="PurpleMediaCodec*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_channels" symbol="purple_media_codec_get_channels">
				<return-type type="guint"/>
				<parameters>
					<parameter name="codec" type="PurpleMediaCodec*"/>
				</parameters>
			</method>
			<method name="get_clock_rate" symbol="purple_media_codec_get_clock_rate">
				<return-type type="guint"/>
				<parameters>
					<parameter name="codec" type="PurpleMediaCodec*"/>
				</parameters>
			</method>
			<method name="get_encoding_name" symbol="purple_media_codec_get_encoding_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="codec" type="PurpleMediaCodec*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="purple_media_codec_get_id">
				<return-type type="guint"/>
				<parameters>
					<parameter name="codec" type="PurpleMediaCodec*"/>
				</parameters>
			</method>
			<method name="get_optional_parameter" symbol="purple_media_codec_get_optional_parameter">
				<return-type type="PurpleKeyValuePair*"/>
				<parameters>
					<parameter name="codec" type="PurpleMediaCodec*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_optional_parameters" symbol="purple_media_codec_get_optional_parameters">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="codec" type="PurpleMediaCodec*"/>
				</parameters>
			</method>
			<method name="list_copy" symbol="purple_media_codec_list_copy">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="codecs" type="GList*"/>
				</parameters>
			</method>
			<method name="list_free" symbol="purple_media_codec_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="codecs" type="GList*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_media_codec_new">
				<return-type type="PurpleMediaCodec*"/>
				<parameters>
					<parameter name="id" type="int"/>
					<parameter name="encoding_name" type="char*"/>
					<parameter name="media_type" type="PurpleMediaSessionType"/>
					<parameter name="clock_rate" type="guint"/>
				</parameters>
			</method>
			<method name="remove_optional_parameter" symbol="purple_media_codec_remove_optional_parameter">
				<return-type type="void"/>
				<parameters>
					<parameter name="codec" type="PurpleMediaCodec*"/>
					<parameter name="param" type="PurpleKeyValuePair*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="purple_media_codec_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="codec" type="PurpleMediaCodec*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleMediaElementInfo">
			<method name="call_create" symbol="purple_media_element_info_call_create">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="info" type="PurpleMediaElementInfo*"/>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="session_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_element_type" symbol="purple_media_element_info_get_element_type">
				<return-type type="PurpleMediaElementType"/>
				<parameters>
					<parameter name="info" type="PurpleMediaElementInfo*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="purple_media_element_info_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="info" type="PurpleMediaElementInfo*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_media_element_info_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="info" type="PurpleMediaElementInfo*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleMediaElementInfoClass">
		</struct>
		<struct name="PurpleMediaManager">
			<method name="create_media" symbol="purple_media_manager_create_media">
				<return-type type="PurpleMedia*"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="conference_type" type="char*"/>
					<parameter name="remote_user" type="char*"/>
					<parameter name="initiator" type="gboolean"/>
				</parameters>
			</method>
			<method name="create_output_window" symbol="purple_media_manager_create_output_window">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="session_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
				</parameters>
			</method>
			<method name="get" symbol="purple_media_manager_get">
				<return-type type="PurpleMediaManager*"/>
			</method>
			<method name="get_active_element" symbol="purple_media_manager_get_active_element">
				<return-type type="PurpleMediaElementInfo*"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="type" type="PurpleMediaElementType"/>
				</parameters>
			</method>
			<method name="get_element" symbol="purple_media_manager_get_element">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="type" type="PurpleMediaSessionType"/>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="session_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_element_info" symbol="purple_media_manager_get_element_info">
				<return-type type="PurpleMediaElementInfo*"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_media" symbol="purple_media_manager_get_media">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
				</parameters>
			</method>
			<method name="get_media_by_account" symbol="purple_media_manager_get_media_by_account">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_pipeline" symbol="purple_media_manager_get_pipeline">
				<return-type type="GstElement*"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
				</parameters>
			</method>
			<method name="get_ui_caps" symbol="purple_media_manager_get_ui_caps">
				<return-type type="PurpleMediaCaps"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
				</parameters>
			</method>
			<method name="register_element" symbol="purple_media_manager_register_element">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="info" type="PurpleMediaElementInfo*"/>
				</parameters>
			</method>
			<method name="remove_media" symbol="purple_media_manager_remove_media">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="media" type="PurpleMedia*"/>
				</parameters>
			</method>
			<method name="remove_output_window" symbol="purple_media_manager_remove_output_window">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="output_window_id" type="gulong"/>
				</parameters>
			</method>
			<method name="remove_output_windows" symbol="purple_media_manager_remove_output_windows">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="session_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_active_element" symbol="purple_media_manager_set_active_element">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="info" type="PurpleMediaElementInfo*"/>
				</parameters>
			</method>
			<method name="set_output_window" symbol="purple_media_manager_set_output_window">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="media" type="PurpleMedia*"/>
					<parameter name="session_id" type="gchar*"/>
					<parameter name="participant" type="gchar*"/>
					<parameter name="window_id" type="gulong"/>
				</parameters>
			</method>
			<method name="set_ui_caps" symbol="purple_media_manager_set_ui_caps">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="caps" type="PurpleMediaCaps"/>
				</parameters>
			</method>
			<method name="unregister_element" symbol="purple_media_manager_unregister_element">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="manager" type="PurpleMediaManager*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleMediaManagerClass">
		</struct>
		<struct name="PurpleMenuAction">
			<method name="free" symbol="purple_menu_action_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="act" type="PurpleMenuAction*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_menu_action_new">
				<return-type type="PurpleMenuAction*"/>
				<parameters>
					<parameter name="label" type="char*"/>
					<parameter name="callback" type="PurpleCallback"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="children" type="GList*"/>
				</parameters>
			</method>
			<field name="label" type="char*"/>
			<field name="callback" type="PurpleCallback"/>
			<field name="data" type="gpointer"/>
			<field name="children" type="GList*"/>
		</struct>
		<struct name="PurpleMimeDocument">
			<method name="free" symbol="purple_mime_document_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="doc" type="PurpleMimeDocument*"/>
				</parameters>
			</method>
			<method name="get_field" symbol="purple_mime_document_get_field">
				<return-type type="char*"/>
				<parameters>
					<parameter name="doc" type="PurpleMimeDocument*"/>
					<parameter name="field" type="char*"/>
				</parameters>
			</method>
			<method name="get_fields" symbol="purple_mime_document_get_fields">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="doc" type="PurpleMimeDocument*"/>
				</parameters>
			</method>
			<method name="get_parts" symbol="purple_mime_document_get_parts">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="doc" type="PurpleMimeDocument*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_mime_document_new">
				<return-type type="PurpleMimeDocument*"/>
			</method>
			<method name="parse" symbol="purple_mime_document_parse">
				<return-type type="PurpleMimeDocument*"/>
				<parameters>
					<parameter name="buf" type="char*"/>
				</parameters>
			</method>
			<method name="parsen" symbol="purple_mime_document_parsen">
				<return-type type="PurpleMimeDocument*"/>
				<parameters>
					<parameter name="buf" type="char*"/>
					<parameter name="len" type="gsize"/>
				</parameters>
			</method>
			<method name="set_field" symbol="purple_mime_document_set_field">
				<return-type type="void"/>
				<parameters>
					<parameter name="doc" type="PurpleMimeDocument*"/>
					<parameter name="field" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="write" symbol="purple_mime_document_write">
				<return-type type="void"/>
				<parameters>
					<parameter name="doc" type="PurpleMimeDocument*"/>
					<parameter name="str" type="GString*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleMimePart">
			<method name="get_data" symbol="purple_mime_part_get_data">
				<return-type type="char*"/>
				<parameters>
					<parameter name="part" type="PurpleMimePart*"/>
				</parameters>
			</method>
			<method name="get_data_decoded" symbol="purple_mime_part_get_data_decoded">
				<return-type type="void"/>
				<parameters>
					<parameter name="part" type="PurpleMimePart*"/>
					<parameter name="data" type="guchar**"/>
					<parameter name="len" type="gsize*"/>
				</parameters>
			</method>
			<method name="get_field" symbol="purple_mime_part_get_field">
				<return-type type="char*"/>
				<parameters>
					<parameter name="part" type="PurpleMimePart*"/>
					<parameter name="field" type="char*"/>
				</parameters>
			</method>
			<method name="get_field_decoded" symbol="purple_mime_part_get_field_decoded">
				<return-type type="char*"/>
				<parameters>
					<parameter name="part" type="PurpleMimePart*"/>
					<parameter name="field" type="char*"/>
				</parameters>
			</method>
			<method name="get_fields" symbol="purple_mime_part_get_fields">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="part" type="PurpleMimePart*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="purple_mime_part_get_length">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="part" type="PurpleMimePart*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_mime_part_new">
				<return-type type="PurpleMimePart*"/>
				<parameters>
					<parameter name="doc" type="PurpleMimeDocument*"/>
				</parameters>
			</method>
			<method name="set_data" symbol="purple_mime_part_set_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="part" type="PurpleMimePart*"/>
					<parameter name="data" type="char*"/>
				</parameters>
			</method>
			<method name="set_field" symbol="purple_mime_part_set_field">
				<return-type type="void"/>
				<parameters>
					<parameter name="part" type="PurpleMimePart*"/>
					<parameter name="field" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleNetworkListenData">
		</struct>
		<struct name="PurpleNotifySearchButton">
			<field name="type" type="PurpleNotifySearchButtonType"/>
			<field name="callback" type="PurpleNotifySearchResultsCallback"/>
			<field name="label" type="char*"/>
		</struct>
		<struct name="PurpleNotifySearchColumn">
			<field name="title" type="char*"/>
		</struct>
		<struct name="PurpleNotifySearchResults">
			<method name="button_add" symbol="purple_notify_searchresults_button_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="results" type="PurpleNotifySearchResults*"/>
					<parameter name="type" type="PurpleNotifySearchButtonType"/>
					<parameter name="cb" type="PurpleNotifySearchResultsCallback"/>
				</parameters>
			</method>
			<method name="button_add_labeled" symbol="purple_notify_searchresults_button_add_labeled">
				<return-type type="void"/>
				<parameters>
					<parameter name="results" type="PurpleNotifySearchResults*"/>
					<parameter name="label" type="char*"/>
					<parameter name="cb" type="PurpleNotifySearchResultsCallback"/>
				</parameters>
			</method>
			<method name="column_add" symbol="purple_notify_searchresults_column_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="results" type="PurpleNotifySearchResults*"/>
					<parameter name="column" type="PurpleNotifySearchColumn*"/>
				</parameters>
			</method>
			<method name="column_get_title" symbol="purple_notify_searchresults_column_get_title">
				<return-type type="char*"/>
				<parameters>
					<parameter name="results" type="PurpleNotifySearchResults*"/>
					<parameter name="column_id" type="unsigned"/>
				</parameters>
			</method>
			<method name="column_new" symbol="purple_notify_searchresults_column_new">
				<return-type type="PurpleNotifySearchColumn*"/>
				<parameters>
					<parameter name="title" type="char*"/>
				</parameters>
			</method>
			<method name="free" symbol="purple_notify_searchresults_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="results" type="PurpleNotifySearchResults*"/>
				</parameters>
			</method>
			<method name="get_columns_count" symbol="purple_notify_searchresults_get_columns_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="results" type="PurpleNotifySearchResults*"/>
				</parameters>
			</method>
			<method name="get_rows_count" symbol="purple_notify_searchresults_get_rows_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="results" type="PurpleNotifySearchResults*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_notify_searchresults_new">
				<return-type type="PurpleNotifySearchResults*"/>
			</method>
			<method name="new_rows" symbol="purple_notify_searchresults_new_rows">
				<return-type type="void"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
					<parameter name="results" type="PurpleNotifySearchResults*"/>
					<parameter name="data" type="void*"/>
				</parameters>
			</method>
			<method name="row_add" symbol="purple_notify_searchresults_row_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="results" type="PurpleNotifySearchResults*"/>
					<parameter name="row" type="GList*"/>
				</parameters>
			</method>
			<method name="row_get" symbol="purple_notify_searchresults_row_get">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="results" type="PurpleNotifySearchResults*"/>
					<parameter name="row_id" type="unsigned"/>
				</parameters>
			</method>
			<field name="columns" type="GList*"/>
			<field name="rows" type="GList*"/>
			<field name="buttons" type="GList*"/>
		</struct>
		<struct name="PurpleNotifyUiOps">
			<field name="notify_message" type="GCallback"/>
			<field name="notify_email" type="GCallback"/>
			<field name="notify_emails" type="GCallback"/>
			<field name="notify_formatted" type="GCallback"/>
			<field name="notify_searchresults" type="GCallback"/>
			<field name="notify_searchresults_new_rows" type="GCallback"/>
			<field name="notify_userinfo" type="GCallback"/>
			<field name="notify_uri" type="GCallback"/>
			<field name="close_notify" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleNotifyUserInfo">
			<method name="add_pair" symbol="purple_notify_user_info_add_pair">
				<return-type type="void"/>
				<parameters>
					<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
					<parameter name="label" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="add_section_break" symbol="purple_notify_user_info_add_section_break">
				<return-type type="void"/>
				<parameters>
					<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
				</parameters>
			</method>
			<method name="add_section_header" symbol="purple_notify_user_info_add_section_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
					<parameter name="label" type="char*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_notify_user_info_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
				</parameters>
			</method>
			<method name="get_entries" symbol="purple_notify_user_info_get_entries">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
				</parameters>
			</method>
			<method name="get_text_with_newline" symbol="purple_notify_user_info_get_text_with_newline">
				<return-type type="char*"/>
				<parameters>
					<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
					<parameter name="newline" type="char*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_notify_user_info_new">
				<return-type type="PurpleNotifyUserInfo*"/>
			</method>
			<method name="prepend_pair" symbol="purple_notify_user_info_prepend_pair">
				<return-type type="void"/>
				<parameters>
					<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
					<parameter name="label" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="prepend_section_break" symbol="purple_notify_user_info_prepend_section_break">
				<return-type type="void"/>
				<parameters>
					<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
				</parameters>
			</method>
			<method name="prepend_section_header" symbol="purple_notify_user_info_prepend_section_header">
				<return-type type="void"/>
				<parameters>
					<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
					<parameter name="label" type="char*"/>
				</parameters>
			</method>
			<method name="remove_entry" symbol="purple_notify_user_info_remove_entry">
				<return-type type="void"/>
				<parameters>
					<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
					<parameter name="user_info_entry" type="PurpleNotifyUserInfoEntry*"/>
				</parameters>
			</method>
			<method name="remove_last_item" symbol="purple_notify_user_info_remove_last_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="user_info" type="PurpleNotifyUserInfo*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleNotifyUserInfoEntry">
			<method name="get_label" symbol="purple_notify_user_info_entry_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user_info_entry" type="PurpleNotifyUserInfoEntry*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="purple_notify_user_info_entry_get_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user_info_entry" type="PurpleNotifyUserInfoEntry*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_notify_user_info_entry_new">
				<return-type type="PurpleNotifyUserInfoEntry*"/>
				<parameters>
					<parameter name="label" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_label" symbol="purple_notify_user_info_entry_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="user_info_entry" type="PurpleNotifyUserInfoEntry*"/>
					<parameter name="label" type="char*"/>
				</parameters>
			</method>
			<method name="set_type" symbol="purple_notify_user_info_entry_set_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="user_info_entry" type="PurpleNotifyUserInfoEntry*"/>
					<parameter name="type" type="PurpleNotifyUserInfoEntryType"/>
				</parameters>
			</method>
			<method name="set_value" symbol="purple_notify_user_info_entry_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="user_info_entry" type="PurpleNotifyUserInfoEntry*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurplePlugin">
			<method name="destroy" symbol="purple_plugin_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="disable" symbol="purple_plugin_disable">
				<return-type type="void"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="get_author" symbol="purple_plugin_get_author">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="purple_plugin_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="get_homepage" symbol="purple_plugin_get_homepage">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="purple_plugin_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_plugin_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="get_summary" symbol="purple_plugin_get_summary">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="get_version" symbol="purple_plugin_get_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="ipc_call" symbol="purple_plugin_ipc_call">
				<return-type type="void*"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
					<parameter name="command" type="char*"/>
					<parameter name="ok" type="gboolean*"/>
				</parameters>
			</method>
			<method name="ipc_get_params" symbol="purple_plugin_ipc_get_params">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
					<parameter name="command" type="char*"/>
					<parameter name="ret_value" type="PurpleValue**"/>
					<parameter name="num_params" type="int*"/>
					<parameter name="params" type="PurpleValue***"/>
				</parameters>
			</method>
			<method name="ipc_register" symbol="purple_plugin_ipc_register">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
					<parameter name="command" type="char*"/>
					<parameter name="func" type="PurpleCallback"/>
					<parameter name="marshal" type="PurpleSignalMarshalFunc"/>
					<parameter name="ret_value" type="PurpleValue*"/>
					<parameter name="num_params" type="int"/>
				</parameters>
			</method>
			<method name="ipc_unregister" symbol="purple_plugin_ipc_unregister">
				<return-type type="void"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
					<parameter name="command" type="char*"/>
				</parameters>
			</method>
			<method name="ipc_unregister_all" symbol="purple_plugin_ipc_unregister_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="is_loaded" symbol="purple_plugin_is_loaded">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="is_unloadable" symbol="purple_plugin_is_unloadable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="load" symbol="purple_plugin_load">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_plugin_new">
				<return-type type="PurplePlugin*"/>
				<parameters>
					<parameter name="native" type="gboolean"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="probe" symbol="purple_plugin_probe">
				<return-type type="PurplePlugin*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
				</parameters>
			</method>
			<method name="register" symbol="purple_plugin_register">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="reload" symbol="purple_plugin_reload">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<method name="unload" symbol="purple_plugin_unload">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="PurplePlugin*"/>
				</parameters>
			</method>
			<field name="native_plugin" type="gboolean"/>
			<field name="loaded" type="gboolean"/>
			<field name="handle" type="void*"/>
			<field name="path" type="char*"/>
			<field name="info" type="PurplePluginInfo*"/>
			<field name="error" type="char*"/>
			<field name="ipc_data" type="void*"/>
			<field name="extra" type="void*"/>
			<field name="unloadable" type="gboolean"/>
			<field name="dependent_plugins" type="GList*"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurplePluginAction">
			<method name="free" symbol="purple_plugin_action_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="action" type="PurplePluginAction*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_plugin_action_new">
				<return-type type="PurplePluginAction*"/>
				<parameters>
					<parameter name="label" type="char*"/>
					<parameter name="callback" type="GCallback"/>
				</parameters>
			</method>
			<field name="label" type="char*"/>
			<field name="callback" type="GCallback"/>
			<field name="plugin" type="PurplePlugin*"/>
			<field name="context" type="gpointer"/>
			<field name="user_data" type="gpointer"/>
		</struct>
		<struct name="PurplePluginInfo">
			<field name="magic" type="unsigned"/>
			<field name="major_version" type="unsigned"/>
			<field name="minor_version" type="unsigned"/>
			<field name="type" type="PurplePluginType"/>
			<field name="ui_requirement" type="char*"/>
			<field name="flags" type="unsigned"/>
			<field name="dependencies" type="GList*"/>
			<field name="priority" type="PurplePluginPriority"/>
			<field name="id" type="char*"/>
			<field name="name" type="char*"/>
			<field name="version" type="char*"/>
			<field name="summary" type="char*"/>
			<field name="description" type="char*"/>
			<field name="author" type="char*"/>
			<field name="homepage" type="char*"/>
			<field name="load" type="GCallback"/>
			<field name="unload" type="GCallback"/>
			<field name="destroy" type="GCallback"/>
			<field name="ui_info" type="void*"/>
			<field name="extra_info" type="void*"/>
			<field name="prefs_info" type="PurplePluginUiInfo*"/>
			<field name="actions" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurplePluginLoaderInfo">
			<field name="exts" type="GList*"/>
			<field name="probe" type="GCallback"/>
			<field name="load" type="GCallback"/>
			<field name="unload" type="GCallback"/>
			<field name="destroy" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurplePluginPref">
			<method name="add_choice" symbol="purple_plugin_pref_add_choice">
				<return-type type="void"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
					<parameter name="label" type="char*"/>
					<parameter name="choice" type="gpointer"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_plugin_pref_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
				</parameters>
			</method>
			<method name="get_bounds" symbol="purple_plugin_pref_get_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
					<parameter name="min" type="int*"/>
					<parameter name="max" type="int*"/>
				</parameters>
			</method>
			<method name="get_choices" symbol="purple_plugin_pref_get_choices">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
				</parameters>
			</method>
			<method name="get_format_type" symbol="purple_plugin_pref_get_format_type">
				<return-type type="PurpleStringFormatType"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="purple_plugin_pref_get_label">
				<return-type type="char*"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
				</parameters>
			</method>
			<method name="get_masked" symbol="purple_plugin_pref_get_masked">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
				</parameters>
			</method>
			<method name="get_max_length" symbol="purple_plugin_pref_get_max_length">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_plugin_pref_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_plugin_pref_new">
				<return-type type="PurplePluginPref*"/>
			</method>
			<method name="new_with_label" symbol="purple_plugin_pref_new_with_label">
				<return-type type="PurplePluginPref*"/>
				<parameters>
					<parameter name="label" type="char*"/>
				</parameters>
			</method>
			<method name="new_with_name" symbol="purple_plugin_pref_new_with_name">
				<return-type type="PurplePluginPref*"/>
				<parameters>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="new_with_name_and_label" symbol="purple_plugin_pref_new_with_name_and_label">
				<return-type type="PurplePluginPref*"/>
				<parameters>
					<parameter name="name" type="char*"/>
					<parameter name="label" type="char*"/>
				</parameters>
			</method>
			<method name="set_bounds" symbol="purple_plugin_pref_set_bounds">
				<return-type type="void"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
					<parameter name="min" type="int"/>
					<parameter name="max" type="int"/>
				</parameters>
			</method>
			<method name="set_format_type" symbol="purple_plugin_pref_set_format_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
					<parameter name="format" type="PurpleStringFormatType"/>
				</parameters>
			</method>
			<method name="set_label" symbol="purple_plugin_pref_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
					<parameter name="label" type="char*"/>
				</parameters>
			</method>
			<method name="set_masked" symbol="purple_plugin_pref_set_masked">
				<return-type type="void"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
					<parameter name="mask" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_max_length" symbol="purple_plugin_pref_set_max_length">
				<return-type type="void"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
					<parameter name="max_length" type="unsigned"/>
				</parameters>
			</method>
			<method name="set_name" symbol="purple_plugin_pref_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_type" symbol="purple_plugin_pref_set_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="pref" type="PurplePluginPref*"/>
					<parameter name="type" type="PurplePluginPrefType"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurplePluginPrefFrame">
			<method name="add" symbol="purple_plugin_pref_frame_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="PurplePluginPrefFrame*"/>
					<parameter name="pref" type="PurplePluginPref*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_plugin_pref_frame_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="PurplePluginPrefFrame*"/>
				</parameters>
			</method>
			<method name="get_prefs" symbol="purple_plugin_pref_frame_get_prefs">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="frame" type="PurplePluginPrefFrame*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_plugin_pref_frame_new">
				<return-type type="PurplePluginPrefFrame*"/>
			</method>
		</struct>
		<struct name="PurplePluginPriority">
		</struct>
		<struct name="PurplePluginProtocolInfo">
			<field name="options" type="PurpleProtocolOptions"/>
			<field name="user_splits" type="GList*"/>
			<field name="protocol_options" type="GList*"/>
			<field name="icon_spec" type="PurpleBuddyIconSpec"/>
			<field name="list_icon" type="GCallback"/>
			<field name="list_emblem" type="GCallback"/>
			<field name="status_text" type="GCallback"/>
			<field name="tooltip_text" type="GCallback"/>
			<field name="status_types" type="GCallback"/>
			<field name="blist_node_menu" type="GCallback"/>
			<field name="chat_info" type="GCallback"/>
			<field name="chat_info_defaults" type="GCallback"/>
			<field name="login" type="GCallback"/>
			<field name="close" type="GCallback"/>
			<field name="send_im" type="GCallback"/>
			<field name="set_info" type="GCallback"/>
			<field name="send_typing" type="GCallback"/>
			<field name="get_info" type="GCallback"/>
			<field name="set_status" type="GCallback"/>
			<field name="set_idle" type="GCallback"/>
			<field name="change_passwd" type="GCallback"/>
			<field name="add_buddy" type="GCallback"/>
			<field name="add_buddies" type="GCallback"/>
			<field name="remove_buddy" type="GCallback"/>
			<field name="remove_buddies" type="GCallback"/>
			<field name="add_permit" type="GCallback"/>
			<field name="add_deny" type="GCallback"/>
			<field name="rem_permit" type="GCallback"/>
			<field name="rem_deny" type="GCallback"/>
			<field name="set_permit_deny" type="GCallback"/>
			<field name="join_chat" type="GCallback"/>
			<field name="reject_chat" type="GCallback"/>
			<field name="get_chat_name" type="GCallback"/>
			<field name="chat_invite" type="GCallback"/>
			<field name="chat_leave" type="GCallback"/>
			<field name="chat_whisper" type="GCallback"/>
			<field name="chat_send" type="GCallback"/>
			<field name="keepalive" type="GCallback"/>
			<field name="register_user" type="GCallback"/>
			<field name="get_cb_info" type="GCallback"/>
			<field name="get_cb_away" type="GCallback"/>
			<field name="alias_buddy" type="GCallback"/>
			<field name="group_buddy" type="GCallback"/>
			<field name="rename_group" type="GCallback"/>
			<field name="buddy_free" type="GCallback"/>
			<field name="convo_closed" type="GCallback"/>
			<field name="normalize" type="GCallback"/>
			<field name="set_buddy_icon" type="GCallback"/>
			<field name="remove_group" type="GCallback"/>
			<field name="get_cb_real_name" type="GCallback"/>
			<field name="set_chat_topic" type="GCallback"/>
			<field name="find_blist_chat" type="GCallback"/>
			<field name="roomlist_get_list" type="GCallback"/>
			<field name="roomlist_cancel" type="GCallback"/>
			<field name="roomlist_expand_category" type="GCallback"/>
			<field name="can_receive_file" type="GCallback"/>
			<field name="send_file" type="GCallback"/>
			<field name="new_xfer" type="GCallback"/>
			<field name="offline_message" type="GCallback"/>
			<field name="whiteboard_prpl_ops" type="PurpleWhiteboardPrplOps*"/>
			<field name="send_raw" type="GCallback"/>
			<field name="roomlist_room_serialize" type="GCallback"/>
			<field name="unregister_user" type="GCallback"/>
			<field name="send_attention" type="GCallback"/>
			<field name="get_attention_types" type="GCallback"/>
			<field name="struct_size" type="unsigned"/>
			<field name="get_account_text_table" type="GCallback"/>
			<field name="initiate_media" type="GCallback"/>
			<field name="get_media_caps" type="GCallback"/>
		</struct>
		<struct name="PurplePluginUiInfo">
			<field name="get_plugin_pref_frame" type="GCallback"/>
			<field name="page_num" type="int"/>
			<field name="frame" type="PurplePluginPrefFrame*"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurplePounce">
			<method name="action_get_attribute" symbol="purple_pounce_action_get_attribute">
				<return-type type="char*"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
					<parameter name="action" type="char*"/>
					<parameter name="attr" type="char*"/>
				</parameters>
			</method>
			<method name="action_is_enabled" symbol="purple_pounce_action_is_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
					<parameter name="action" type="char*"/>
				</parameters>
			</method>
			<method name="action_register" symbol="purple_pounce_action_register">
				<return-type type="void"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="action_set_attribute" symbol="purple_pounce_action_set_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
					<parameter name="action" type="char*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="action_set_enabled" symbol="purple_pounce_action_set_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
					<parameter name="action" type="char*"/>
					<parameter name="enabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_pounce_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
				</parameters>
			</method>
			<method name="destroy_all_by_account" symbol="purple_pounce_destroy_all_by_account">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="execute" symbol="purple_pounce_execute">
				<return-type type="void"/>
				<parameters>
					<parameter name="pouncer" type="PurpleAccount*"/>
					<parameter name="pouncee" type="char*"/>
					<parameter name="events" type="PurplePounceEvent"/>
				</parameters>
			</method>
			<method name="get_data" symbol="purple_pounce_get_data">
				<return-type type="void*"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
				</parameters>
			</method>
			<method name="get_events" symbol="purple_pounce_get_events">
				<return-type type="PurplePounceEvent"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
				</parameters>
			</method>
			<method name="get_options" symbol="purple_pounce_get_options">
				<return-type type="PurplePounceOption"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
				</parameters>
			</method>
			<method name="get_pouncee" symbol="purple_pounce_get_pouncee">
				<return-type type="char*"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
				</parameters>
			</method>
			<method name="get_pouncer" symbol="purple_pounce_get_pouncer">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
				</parameters>
			</method>
			<method name="get_save" symbol="purple_pounce_get_save">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_pounce_new">
				<return-type type="PurplePounce*"/>
				<parameters>
					<parameter name="ui_type" type="char*"/>
					<parameter name="pouncer" type="PurpleAccount*"/>
					<parameter name="pouncee" type="char*"/>
					<parameter name="event" type="PurplePounceEvent"/>
					<parameter name="option" type="PurplePounceOption"/>
				</parameters>
			</method>
			<method name="set_data" symbol="purple_pounce_set_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
					<parameter name="data" type="void*"/>
				</parameters>
			</method>
			<method name="set_events" symbol="purple_pounce_set_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
					<parameter name="events" type="PurplePounceEvent"/>
				</parameters>
			</method>
			<method name="set_options" symbol="purple_pounce_set_options">
				<return-type type="void"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
					<parameter name="options" type="PurplePounceOption"/>
				</parameters>
			</method>
			<method name="set_pouncee" symbol="purple_pounce_set_pouncee">
				<return-type type="void"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
					<parameter name="pouncee" type="char*"/>
				</parameters>
			</method>
			<method name="set_pouncer" symbol="purple_pounce_set_pouncer">
				<return-type type="void"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
					<parameter name="pouncer" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="set_save" symbol="purple_pounce_set_save">
				<return-type type="void"/>
				<parameters>
					<parameter name="pounce" type="PurplePounce*"/>
					<parameter name="save" type="gboolean"/>
				</parameters>
			</method>
			<field name="ui_type" type="char*"/>
			<field name="events" type="PurplePounceEvent"/>
			<field name="options" type="PurplePounceOption"/>
			<field name="pouncer" type="PurpleAccount*"/>
			<field name="pouncee" type="char*"/>
			<field name="actions" type="GHashTable*"/>
			<field name="save" type="gboolean"/>
			<field name="data" type="void*"/>
		</struct>
		<struct name="PurplePresence">
			<method name="add_list" symbol="purple_presence_add_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
					<parameter name="source_list" type="GList*"/>
				</parameters>
			</method>
			<method name="add_status" symbol="purple_presence_add_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
					<parameter name="status" type="PurpleStatus*"/>
				</parameters>
			</method>
			<method name="compare" symbol="purple_presence_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="presence1" type="PurplePresence*"/>
					<parameter name="presence2" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_presence_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="get_account" symbol="purple_presence_get_account">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="get_active_status" symbol="purple_presence_get_active_status">
				<return-type type="PurpleStatus*"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="get_buddy" symbol="purple_presence_get_buddy">
				<return-type type="PurpleBuddy*"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="get_chat_user" symbol="purple_presence_get_chat_user">
				<return-type type="char*"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="get_context" symbol="purple_presence_get_context">
				<return-type type="PurplePresenceContext"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="get_conversation" symbol="purple_presence_get_conversation">
				<return-type type="PurpleConversation*"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="get_idle_time" symbol="purple_presence_get_idle_time">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="get_login_time" symbol="purple_presence_get_login_time">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="get_status" symbol="purple_presence_get_status">
				<return-type type="PurpleStatus*"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
					<parameter name="status_id" type="char*"/>
				</parameters>
			</method>
			<method name="get_statuses" symbol="purple_presence_get_statuses">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="is_available" symbol="purple_presence_is_available">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="is_idle" symbol="purple_presence_is_idle">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="is_online" symbol="purple_presence_is_online">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="is_status_active" symbol="purple_presence_is_status_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
					<parameter name="status_id" type="char*"/>
				</parameters>
			</method>
			<method name="is_status_primitive_active" symbol="purple_presence_is_status_primitive_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
					<parameter name="primitive" type="PurpleStatusPrimitive"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_presence_new">
				<return-type type="PurplePresence*"/>
				<parameters>
					<parameter name="context" type="PurplePresenceContext"/>
				</parameters>
			</method>
			<method name="new_for_account" symbol="purple_presence_new_for_account">
				<return-type type="PurplePresence*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="new_for_buddy" symbol="purple_presence_new_for_buddy">
				<return-type type="PurplePresence*"/>
				<parameters>
					<parameter name="buddy" type="PurpleBuddy*"/>
				</parameters>
			</method>
			<method name="new_for_conv" symbol="purple_presence_new_for_conv">
				<return-type type="PurplePresence*"/>
				<parameters>
					<parameter name="conv" type="PurpleConversation*"/>
				</parameters>
			</method>
			<method name="set_idle" symbol="purple_presence_set_idle">
				<return-type type="void"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
					<parameter name="idle" type="gboolean"/>
					<parameter name="idle_time" type="time_t"/>
				</parameters>
			</method>
			<method name="set_login_time" symbol="purple_presence_set_login_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
					<parameter name="login_time" type="time_t"/>
				</parameters>
			</method>
			<method name="set_status_active" symbol="purple_presence_set_status_active">
				<return-type type="void"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
					<parameter name="status_id" type="char*"/>
					<parameter name="active" type="gboolean"/>
				</parameters>
			</method>
			<method name="switch_status" symbol="purple_presence_switch_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="presence" type="PurplePresence*"/>
					<parameter name="status_id" type="char*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurplePrivacyUiOps">
			<field name="permit_added" type="GCallback"/>
			<field name="permit_removed" type="GCallback"/>
			<field name="deny_added" type="GCallback"/>
			<field name="deny_removed" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleProxyConnectData">
		</struct>
		<struct name="PurpleProxyInfo">
			<method name="destroy" symbol="purple_proxy_info_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="PurpleProxyInfo*"/>
				</parameters>
			</method>
			<method name="get_host" symbol="purple_proxy_info_get_host">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="PurpleProxyInfo*"/>
				</parameters>
			</method>
			<method name="get_password" symbol="purple_proxy_info_get_password">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="PurpleProxyInfo*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="purple_proxy_info_get_port">
				<return-type type="int"/>
				<parameters>
					<parameter name="info" type="PurpleProxyInfo*"/>
				</parameters>
			</method>
			<method name="get_username" symbol="purple_proxy_info_get_username">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="PurpleProxyInfo*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_proxy_info_new">
				<return-type type="PurpleProxyInfo*"/>
			</method>
			<method name="set_host" symbol="purple_proxy_info_set_host">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="PurpleProxyInfo*"/>
					<parameter name="host" type="char*"/>
				</parameters>
			</method>
			<method name="set_password" symbol="purple_proxy_info_set_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="PurpleProxyInfo*"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</method>
			<method name="set_port" symbol="purple_proxy_info_set_port">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="PurpleProxyInfo*"/>
					<parameter name="port" type="int"/>
				</parameters>
			</method>
			<method name="set_type" symbol="purple_proxy_info_set_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="PurpleProxyInfo*"/>
					<parameter name="type" type="PurpleProxyType"/>
				</parameters>
			</method>
			<method name="set_username" symbol="purple_proxy_info_set_username">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="PurpleProxyInfo*"/>
					<parameter name="username" type="char*"/>
				</parameters>
			</method>
			<field name="type" type="PurpleProxyType"/>
			<field name="host" type="char*"/>
			<field name="port" type="int"/>
			<field name="username" type="char*"/>
			<field name="password" type="char*"/>
		</struct>
		<struct name="PurpleRequestField">
			<method name="account_get_default_value" symbol="purple_request_field_account_get_default_value">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="account_get_filter" symbol="purple_request_field_account_get_filter">
				<return-type type="PurpleFilterAccountFunc"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="account_get_show_all" symbol="purple_request_field_account_get_show_all">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="account_get_value" symbol="purple_request_field_account_get_value">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="account_new" symbol="purple_request_field_account_new">
				<return-type type="PurpleRequestField*"/>
				<parameters>
					<parameter name="id" type="char*"/>
					<parameter name="text" type="char*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="account_set_default_value" symbol="purple_request_field_account_set_default_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="default_value" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="account_set_filter" symbol="purple_request_field_account_set_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="filter_func" type="PurpleFilterAccountFunc"/>
				</parameters>
			</method>
			<method name="account_set_show_all" symbol="purple_request_field_account_set_show_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="show_all" type="gboolean"/>
				</parameters>
			</method>
			<method name="account_set_value" symbol="purple_request_field_account_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="value" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="bool_get_default_value" symbol="purple_request_field_bool_get_default_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="bool_get_value" symbol="purple_request_field_bool_get_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="bool_new" symbol="purple_request_field_bool_new">
				<return-type type="PurpleRequestField*"/>
				<parameters>
					<parameter name="id" type="char*"/>
					<parameter name="text" type="char*"/>
					<parameter name="default_value" type="gboolean"/>
				</parameters>
			</method>
			<method name="bool_set_default_value" symbol="purple_request_field_bool_set_default_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="default_value" type="gboolean"/>
				</parameters>
			</method>
			<method name="bool_set_value" symbol="purple_request_field_bool_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="choice_add" symbol="purple_request_field_choice_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="label" type="char*"/>
				</parameters>
			</method>
			<method name="choice_get_default_value" symbol="purple_request_field_choice_get_default_value">
				<return-type type="int"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="choice_get_labels" symbol="purple_request_field_choice_get_labels">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="choice_get_value" symbol="purple_request_field_choice_get_value">
				<return-type type="int"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="choice_new" symbol="purple_request_field_choice_new">
				<return-type type="PurpleRequestField*"/>
				<parameters>
					<parameter name="id" type="char*"/>
					<parameter name="text" type="char*"/>
					<parameter name="default_value" type="int"/>
				</parameters>
			</method>
			<method name="choice_set_default_value" symbol="purple_request_field_choice_set_default_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="default_value" type="int"/>
				</parameters>
			</method>
			<method name="choice_set_value" symbol="purple_request_field_choice_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="value" type="int"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_request_field_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="get_group" symbol="purple_request_field_get_group">
				<return-type type="PurpleRequestFieldGroup*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="purple_request_field_get_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="purple_request_field_get_label">
				<return-type type="char*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="get_type_hint" symbol="purple_request_field_get_type_hint">
				<return-type type="char*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="get_ui_data" symbol="purple_request_field_get_ui_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="image_get_buffer" symbol="purple_request_field_image_get_buffer">
				<return-type type="char*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="image_get_scale_x" symbol="purple_request_field_image_get_scale_x">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="image_get_scale_y" symbol="purple_request_field_image_get_scale_y">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="image_get_size" symbol="purple_request_field_image_get_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="image_new" symbol="purple_request_field_image_new">
				<return-type type="PurpleRequestField*"/>
				<parameters>
					<parameter name="id" type="char*"/>
					<parameter name="text" type="char*"/>
					<parameter name="buf" type="char*"/>
					<parameter name="size" type="gsize"/>
				</parameters>
			</method>
			<method name="image_set_scale" symbol="purple_request_field_image_set_scale">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="x" type="unsigned"/>
					<parameter name="y" type="unsigned"/>
				</parameters>
			</method>
			<method name="int_get_default_value" symbol="purple_request_field_int_get_default_value">
				<return-type type="int"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="int_get_value" symbol="purple_request_field_int_get_value">
				<return-type type="int"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="int_new" symbol="purple_request_field_int_new">
				<return-type type="PurpleRequestField*"/>
				<parameters>
					<parameter name="id" type="char*"/>
					<parameter name="text" type="char*"/>
					<parameter name="default_value" type="int"/>
				</parameters>
			</method>
			<method name="int_set_default_value" symbol="purple_request_field_int_set_default_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="default_value" type="int"/>
				</parameters>
			</method>
			<method name="int_set_value" symbol="purple_request_field_int_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="value" type="int"/>
				</parameters>
			</method>
			<method name="is_required" symbol="purple_request_field_is_required">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="is_visible" symbol="purple_request_field_is_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="label_new" symbol="purple_request_field_label_new">
				<return-type type="PurpleRequestField*"/>
				<parameters>
					<parameter name="id" type="char*"/>
					<parameter name="text" type="char*"/>
				</parameters>
			</method>
			<method name="list_add" symbol="purple_request_field_list_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="item" type="char*"/>
					<parameter name="data" type="void*"/>
				</parameters>
			</method>
			<method name="list_add_selected" symbol="purple_request_field_list_add_selected">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="item" type="char*"/>
				</parameters>
			</method>
			<method name="list_clear_selected" symbol="purple_request_field_list_clear_selected">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="list_get_data" symbol="purple_request_field_list_get_data">
				<return-type type="void*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="text" type="char*"/>
				</parameters>
			</method>
			<method name="list_get_items" symbol="purple_request_field_list_get_items">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="list_get_multi_select" symbol="purple_request_field_list_get_multi_select">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="list_get_selected" symbol="purple_request_field_list_get_selected">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="list_is_selected" symbol="purple_request_field_list_is_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="item" type="char*"/>
				</parameters>
			</method>
			<method name="list_new" symbol="purple_request_field_list_new">
				<return-type type="PurpleRequestField*"/>
				<parameters>
					<parameter name="id" type="char*"/>
					<parameter name="text" type="char*"/>
				</parameters>
			</method>
			<method name="list_set_multi_select" symbol="purple_request_field_list_set_multi_select">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="multi_select" type="gboolean"/>
				</parameters>
			</method>
			<method name="list_set_selected" symbol="purple_request_field_list_set_selected">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="items" type="GList*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_request_field_new">
				<return-type type="PurpleRequestField*"/>
				<parameters>
					<parameter name="id" type="char*"/>
					<parameter name="text" type="char*"/>
					<parameter name="type" type="PurpleRequestFieldType"/>
				</parameters>
			</method>
			<method name="set_label" symbol="purple_request_field_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="label" type="char*"/>
				</parameters>
			</method>
			<method name="set_required" symbol="purple_request_field_set_required">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="required" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_type_hint" symbol="purple_request_field_set_type_hint">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="type_hint" type="char*"/>
				</parameters>
			</method>
			<method name="set_ui_data" symbol="purple_request_field_set_ui_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="ui_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_visible" symbol="purple_request_field_set_visible">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="visible" type="gboolean"/>
				</parameters>
			</method>
			<method name="string_get_default_value" symbol="purple_request_field_string_get_default_value">
				<return-type type="char*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="string_get_value" symbol="purple_request_field_string_get_value">
				<return-type type="char*"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="string_is_editable" symbol="purple_request_field_string_is_editable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="string_is_masked" symbol="purple_request_field_string_is_masked">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="string_is_multiline" symbol="purple_request_field_string_is_multiline">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="string_new" symbol="purple_request_field_string_new">
				<return-type type="PurpleRequestField*"/>
				<parameters>
					<parameter name="id" type="char*"/>
					<parameter name="text" type="char*"/>
					<parameter name="default_value" type="char*"/>
					<parameter name="multiline" type="gboolean"/>
				</parameters>
			</method>
			<method name="string_set_default_value" symbol="purple_request_field_string_set_default_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="default_value" type="char*"/>
				</parameters>
			</method>
			<method name="string_set_editable" symbol="purple_request_field_string_set_editable">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="editable" type="gboolean"/>
				</parameters>
			</method>
			<method name="string_set_masked" symbol="purple_request_field_string_set_masked">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="masked" type="gboolean"/>
				</parameters>
			</method>
			<method name="string_set_value" symbol="purple_request_field_string_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PurpleRequestField*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<field name="type" type="PurpleRequestFieldType"/>
			<field name="group" type="PurpleRequestFieldGroup*"/>
			<field name="id" type="char*"/>
			<field name="label" type="char*"/>
			<field name="type_hint" type="char*"/>
			<field name="visible" type="gboolean"/>
			<field name="required" type="gboolean"/>
			<field name="u" type="gpointer"/>
			<field name="ui_data" type="void*"/>
		</struct>
		<struct name="PurpleRequestFieldGroup">
			<method name="add_field" symbol="purple_request_field_group_add_field">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="PurpleRequestFieldGroup*"/>
					<parameter name="field" type="PurpleRequestField*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_request_field_group_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="group" type="PurpleRequestFieldGroup*"/>
				</parameters>
			</method>
			<method name="get_fields" symbol="purple_request_field_group_get_fields">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="group" type="PurpleRequestFieldGroup*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="purple_request_field_group_get_title">
				<return-type type="char*"/>
				<parameters>
					<parameter name="group" type="PurpleRequestFieldGroup*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_request_field_group_new">
				<return-type type="PurpleRequestFieldGroup*"/>
				<parameters>
					<parameter name="title" type="char*"/>
				</parameters>
			</method>
			<field name="fields_list" type="PurpleRequestFields*"/>
			<field name="title" type="char*"/>
			<field name="fields" type="GList*"/>
		</struct>
		<struct name="PurpleRequestFields">
			<method name="add_group" symbol="purple_request_fields_add_group">
				<return-type type="void"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
					<parameter name="group" type="PurpleRequestFieldGroup*"/>
				</parameters>
			</method>
			<method name="all_required_filled" symbol="purple_request_fields_all_required_filled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_request_fields_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
				</parameters>
			</method>
			<method name="exists" symbol="purple_request_fields_exists">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_account" symbol="purple_request_fields_get_account">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_bool" symbol="purple_request_fields_get_bool">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_choice" symbol="purple_request_fields_get_choice">
				<return-type type="int"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_field" symbol="purple_request_fields_get_field">
				<return-type type="PurpleRequestField*"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_groups" symbol="purple_request_fields_get_groups">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
				</parameters>
			</method>
			<method name="get_integer" symbol="purple_request_fields_get_integer">
				<return-type type="int"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_required" symbol="purple_request_fields_get_required">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
				</parameters>
			</method>
			<method name="get_string" symbol="purple_request_fields_get_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="is_field_required" symbol="purple_request_fields_is_field_required">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="fields" type="PurpleRequestFields*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_request_fields_new">
				<return-type type="PurpleRequestFields*"/>
			</method>
			<field name="groups" type="GList*"/>
			<field name="fields" type="GHashTable*"/>
			<field name="required_fields" type="GList*"/>
			<field name="ui_data" type="void*"/>
		</struct>
		<struct name="PurpleRequestUiOps">
			<field name="request_input" type="GCallback"/>
			<field name="request_choice" type="GCallback"/>
			<field name="request_action" type="GCallback"/>
			<field name="request_fields" type="GCallback"/>
			<field name="request_file" type="GCallback"/>
			<field name="close_request" type="GCallback"/>
			<field name="request_folder" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleRoomlist">
			<method name="cancel_get_list" symbol="purple_roomlist_cancel_get_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PurpleRoomlist*"/>
				</parameters>
			</method>
			<method name="expand_category" symbol="purple_roomlist_expand_category">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PurpleRoomlist*"/>
					<parameter name="category" type="PurpleRoomlistRoom*"/>
				</parameters>
			</method>
			<method name="get_fields" symbol="purple_roomlist_get_fields">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="roomlist" type="PurpleRoomlist*"/>
				</parameters>
			</method>
			<method name="get_in_progress" symbol="purple_roomlist_get_in_progress">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="list" type="PurpleRoomlist*"/>
				</parameters>
			</method>
			<method name="get_list" symbol="purple_roomlist_get_list">
				<return-type type="PurpleRoomlist*"/>
				<parameters>
					<parameter name="gc" type="PurpleConnection*"/>
				</parameters>
			</method>
			<method name="get_ui_ops" symbol="purple_roomlist_get_ui_ops">
				<return-type type="PurpleRoomlistUiOps*"/>
			</method>
			<method name="new" symbol="purple_roomlist_new">
				<return-type type="PurpleRoomlist*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="ref" symbol="purple_roomlist_ref">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PurpleRoomlist*"/>
				</parameters>
			</method>
			<method name="set_fields" symbol="purple_roomlist_set_fields">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PurpleRoomlist*"/>
					<parameter name="fields" type="GList*"/>
				</parameters>
			</method>
			<method name="set_in_progress" symbol="purple_roomlist_set_in_progress">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PurpleRoomlist*"/>
					<parameter name="in_progress" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_ui_ops" symbol="purple_roomlist_set_ui_ops">
				<return-type type="void"/>
				<parameters>
					<parameter name="ops" type="PurpleRoomlistUiOps*"/>
				</parameters>
			</method>
			<method name="show_with_account" symbol="purple_roomlist_show_with_account">
				<return-type type="void"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="unref" symbol="purple_roomlist_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PurpleRoomlist*"/>
				</parameters>
			</method>
			<field name="account" type="PurpleAccount*"/>
			<field name="fields" type="GList*"/>
			<field name="rooms" type="GList*"/>
			<field name="in_progress" type="gboolean"/>
			<field name="ui_data" type="gpointer"/>
			<field name="proto_data" type="gpointer"/>
			<field name="ref" type="guint"/>
		</struct>
		<struct name="PurpleRoomlistField">
			<method name="get_hidden" symbol="purple_roomlist_field_get_hidden">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PurpleRoomlistField*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="purple_roomlist_field_get_label">
				<return-type type="char*"/>
				<parameters>
					<parameter name="field" type="PurpleRoomlistField*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_roomlist_field_new">
				<return-type type="PurpleRoomlistField*"/>
				<parameters>
					<parameter name="type" type="PurpleRoomlistFieldType"/>
					<parameter name="label" type="gchar*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="hidden" type="gboolean"/>
				</parameters>
			</method>
			<field name="type" type="PurpleRoomlistFieldType"/>
			<field name="label" type="gchar*"/>
			<field name="name" type="gchar*"/>
			<field name="hidden" type="gboolean"/>
		</struct>
		<struct name="PurpleRoomlistRoom">
			<method name="add" symbol="purple_roomlist_room_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PurpleRoomlist*"/>
					<parameter name="room" type="PurpleRoomlistRoom*"/>
				</parameters>
			</method>
			<method name="add_field" symbol="purple_roomlist_room_add_field">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PurpleRoomlist*"/>
					<parameter name="room" type="PurpleRoomlistRoom*"/>
					<parameter name="field" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="get_fields" symbol="purple_roomlist_room_get_fields">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="room" type="PurpleRoomlistRoom*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_roomlist_room_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="room" type="PurpleRoomlistRoom*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="purple_roomlist_room_get_parent">
				<return-type type="PurpleRoomlistRoom*"/>
				<parameters>
					<parameter name="room" type="PurpleRoomlistRoom*"/>
				</parameters>
			</method>
			<method name="join" symbol="purple_roomlist_room_join">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="PurpleRoomlist*"/>
					<parameter name="room" type="PurpleRoomlistRoom*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_roomlist_room_new">
				<return-type type="PurpleRoomlistRoom*"/>
				<parameters>
					<parameter name="type" type="PurpleRoomlistRoomType"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="parent" type="PurpleRoomlistRoom*"/>
				</parameters>
			</method>
			<field name="type" type="PurpleRoomlistRoomType"/>
			<field name="name" type="gchar*"/>
			<field name="fields" type="GList*"/>
			<field name="parent" type="PurpleRoomlistRoom*"/>
			<field name="expanded_once" type="gboolean"/>
		</struct>
		<struct name="PurpleRoomlistUiOps">
			<field name="show_with_account" type="GCallback"/>
			<field name="create" type="GCallback"/>
			<field name="set_fields" type="GCallback"/>
			<field name="add_room" type="GCallback"/>
			<field name="in_progress" type="GCallback"/>
			<field name="destroy" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleSavedStatus">
			<method name="activate" symbol="purple_savedstatus_activate">
				<return-type type="void"/>
				<parameters>
					<parameter name="saved_status" type="PurpleSavedStatus*"/>
				</parameters>
			</method>
			<method name="activate_for_account" symbol="purple_savedstatus_activate_for_account">
				<return-type type="void"/>
				<parameters>
					<parameter name="saved_status" type="PurpleSavedStatus*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="delete" symbol="purple_savedstatus_delete">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="title" type="char*"/>
				</parameters>
			</method>
			<method name="delete_by_status" symbol="purple_savedstatus_delete_by_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="saved_status" type="PurpleSavedStatus*"/>
				</parameters>
			</method>
			<method name="find" symbol="purple_savedstatus_find">
				<return-type type="PurpleSavedStatus*"/>
				<parameters>
					<parameter name="title" type="char*"/>
				</parameters>
			</method>
			<method name="find_by_creation_time" symbol="purple_savedstatus_find_by_creation_time">
				<return-type type="PurpleSavedStatus*"/>
				<parameters>
					<parameter name="creation_time" type="time_t"/>
				</parameters>
			</method>
			<method name="find_transient_by_type_and_message" symbol="purple_savedstatus_find_transient_by_type_and_message">
				<return-type type="PurpleSavedStatus*"/>
				<parameters>
					<parameter name="type" type="PurpleStatusPrimitive"/>
					<parameter name="message" type="char*"/>
				</parameters>
			</method>
			<method name="get_creation_time" symbol="purple_savedstatus_get_creation_time">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="saved_status" type="PurpleSavedStatus*"/>
				</parameters>
			</method>
			<method name="get_current" symbol="purple_savedstatus_get_current">
				<return-type type="PurpleSavedStatus*"/>
			</method>
			<method name="get_default" symbol="purple_savedstatus_get_default">
				<return-type type="PurpleSavedStatus*"/>
			</method>
			<method name="get_idleaway" symbol="purple_savedstatus_get_idleaway">
				<return-type type="PurpleSavedStatus*"/>
			</method>
			<method name="get_message" symbol="purple_savedstatus_get_message">
				<return-type type="char*"/>
				<parameters>
					<parameter name="saved_status" type="PurpleSavedStatus*"/>
				</parameters>
			</method>
			<method name="get_startup" symbol="purple_savedstatus_get_startup">
				<return-type type="PurpleSavedStatus*"/>
			</method>
			<method name="get_substatus" symbol="purple_savedstatus_get_substatus">
				<return-type type="PurpleSavedStatusSub*"/>
				<parameters>
					<parameter name="saved_status" type="PurpleSavedStatus*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="purple_savedstatus_get_title">
				<return-type type="char*"/>
				<parameters>
					<parameter name="saved_status" type="PurpleSavedStatus*"/>
				</parameters>
			</method>
			<method name="has_substatuses" symbol="purple_savedstatus_has_substatuses">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="saved_status" type="PurpleSavedStatus*"/>
				</parameters>
			</method>
			<method name="is_idleaway" symbol="purple_savedstatus_is_idleaway">
				<return-type type="gboolean"/>
			</method>
			<method name="is_transient" symbol="purple_savedstatus_is_transient">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="saved_status" type="PurpleSavedStatus*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_savedstatus_new">
				<return-type type="PurpleSavedStatus*"/>
				<parameters>
					<parameter name="title" type="char*"/>
					<parameter name="type" type="PurpleStatusPrimitive"/>
				</parameters>
			</method>
			<method name="set_idleaway" symbol="purple_savedstatus_set_idleaway">
				<return-type type="void"/>
				<parameters>
					<parameter name="idleaway" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_message" symbol="purple_savedstatus_set_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="status" type="PurpleSavedStatus*"/>
					<parameter name="message" type="char*"/>
				</parameters>
			</method>
			<method name="set_substatus" symbol="purple_savedstatus_set_substatus">
				<return-type type="void"/>
				<parameters>
					<parameter name="status" type="PurpleSavedStatus*"/>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="type" type="PurpleStatusType*"/>
					<parameter name="message" type="char*"/>
				</parameters>
			</method>
			<method name="set_title" symbol="purple_savedstatus_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="status" type="PurpleSavedStatus*"/>
					<parameter name="title" type="char*"/>
				</parameters>
			</method>
			<method name="set_type" symbol="purple_savedstatus_set_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="status" type="PurpleSavedStatus*"/>
					<parameter name="type" type="PurpleStatusPrimitive"/>
				</parameters>
			</method>
			<method name="substatus_get_message" symbol="purple_savedstatus_substatus_get_message">
				<return-type type="char*"/>
				<parameters>
					<parameter name="substatus" type="PurpleSavedStatusSub*"/>
				</parameters>
			</method>
			<method name="substatus_get_type" symbol="purple_savedstatus_substatus_get_type">
				<return-type type="PurpleStatusType*"/>
				<parameters>
					<parameter name="substatus" type="PurpleSavedStatusSub*"/>
				</parameters>
			</method>
			<method name="unset_substatus" symbol="purple_savedstatus_unset_substatus">
				<return-type type="void"/>
				<parameters>
					<parameter name="saved_status" type="PurpleSavedStatus*"/>
					<parameter name="account" type="PurpleAccount*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleSavedStatusSub">
		</struct>
		<struct name="PurpleSmiley">
			<method name="delete" symbol="purple_smiley_delete">
				<return-type type="void"/>
				<parameters>
					<parameter name="smiley" type="PurpleSmiley*"/>
				</parameters>
			</method>
			<method name="get_checksum" symbol="purple_smiley_get_checksum">
				<return-type type="char*"/>
				<parameters>
					<parameter name="smiley" type="PurpleSmiley*"/>
				</parameters>
			</method>
			<method name="get_data" symbol="purple_smiley_get_data">
				<return-type type="gconstpointer"/>
				<parameters>
					<parameter name="smiley" type="PurpleSmiley*"/>
					<parameter name="len" type="size_t*"/>
				</parameters>
			</method>
			<method name="get_extension" symbol="purple_smiley_get_extension">
				<return-type type="char*"/>
				<parameters>
					<parameter name="smiley" type="PurpleSmiley*"/>
				</parameters>
			</method>
			<method name="get_full_path" symbol="purple_smiley_get_full_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="smiley" type="PurpleSmiley*"/>
				</parameters>
			</method>
			<method name="get_shortcut" symbol="purple_smiley_get_shortcut">
				<return-type type="char*"/>
				<parameters>
					<parameter name="smiley" type="PurpleSmiley*"/>
				</parameters>
			</method>
			<method name="get_stored_image" symbol="purple_smiley_get_stored_image">
				<return-type type="PurpleStoredImage*"/>
				<parameters>
					<parameter name="smiley" type="PurpleSmiley*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_smiley_new">
				<return-type type="PurpleSmiley*"/>
				<parameters>
					<parameter name="img" type="PurpleStoredImage*"/>
					<parameter name="shortcut" type="char*"/>
				</parameters>
			</method>
			<method name="new_from_file" symbol="purple_smiley_new_from_file">
				<return-type type="PurpleSmiley*"/>
				<parameters>
					<parameter name="shortcut" type="char*"/>
					<parameter name="filepath" type="char*"/>
				</parameters>
			</method>
			<method name="set_data" symbol="purple_smiley_set_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="smiley" type="PurpleSmiley*"/>
					<parameter name="smiley_data" type="guchar*"/>
					<parameter name="smiley_data_len" type="size_t"/>
				</parameters>
			</method>
			<method name="set_shortcut" symbol="purple_smiley_set_shortcut">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="smiley" type="PurpleSmiley*"/>
					<parameter name="shortcut" type="char*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleSmileyClass">
		</struct>
		<struct name="PurpleSoundTheme">
			<method name="get_file" symbol="purple_sound_theme_get_file">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="theme" type="PurpleSoundTheme*"/>
					<parameter name="event" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_file_full" symbol="purple_sound_theme_get_file_full">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="theme" type="PurpleSoundTheme*"/>
					<parameter name="event" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_file" symbol="purple_sound_theme_set_file">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="PurpleSoundTheme*"/>
					<parameter name="event" type="gchar*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<field name="parent" type="PurpleTheme"/>
			<field name="priv" type="gpointer"/>
		</struct>
		<struct name="PurpleSoundThemeClass">
			<field name="parent_class" type="PurpleThemeClass"/>
		</struct>
		<struct name="PurpleSoundThemeLoader">
			<field name="parent" type="PurpleThemeLoader"/>
		</struct>
		<struct name="PurpleSoundThemeLoaderClass">
			<field name="parent_class" type="PurpleThemeLoaderClass"/>
		</struct>
		<struct name="PurpleSoundUiOps">
			<field name="init" type="GCallback"/>
			<field name="uninit" type="GCallback"/>
			<field name="play_file" type="GCallback"/>
			<field name="play_event" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleSrvQueryData">
		</struct>
		<struct name="PurpleSrvResponse">
			<field name="hostname" type="char[]"/>
			<field name="port" type="int"/>
			<field name="weight" type="int"/>
			<field name="pref" type="int"/>
		</struct>
		<struct name="PurpleSslConnection">
			<field name="host" type="char*"/>
			<field name="port" type="int"/>
			<field name="connect_cb_data" type="void*"/>
			<field name="connect_cb" type="PurpleSslInputFunction"/>
			<field name="error_cb" type="PurpleSslErrorFunction"/>
			<field name="recv_cb_data" type="void*"/>
			<field name="recv_cb" type="PurpleSslInputFunction"/>
			<field name="fd" type="int"/>
			<field name="inpa" type="guint"/>
			<field name="connect_data" type="PurpleProxyConnectData*"/>
			<field name="private_data" type="void*"/>
			<field name="verifier" type="PurpleCertificateVerifier*"/>
		</struct>
		<struct name="PurpleSslOps">
			<field name="init" type="GCallback"/>
			<field name="uninit" type="GCallback"/>
			<field name="connectfunc" type="GCallback"/>
			<field name="close" type="GCallback"/>
			<field name="read" type="GCallback"/>
			<field name="write" type="GCallback"/>
			<field name="get_peer_certificates" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleStatus">
			<method name="compare" symbol="purple_status_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="status1" type="PurpleStatus*"/>
					<parameter name="status2" type="PurpleStatus*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_status_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
				</parameters>
			</method>
			<method name="get_attr_boolean" symbol="purple_status_get_attr_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_attr_int" symbol="purple_status_get_attr_int">
				<return-type type="int"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_attr_string" symbol="purple_status_get_attr_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_attr_value" symbol="purple_status_get_attr_value">
				<return-type type="PurpleValue*"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_handle" symbol="purple_status_get_handle">
				<return-type type="void*"/>
			</method>
			<method name="get_id" symbol="purple_status_get_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_status_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
				</parameters>
			</method>
			<method name="get_presence" symbol="purple_status_get_presence">
				<return-type type="PurplePresence*"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
				</parameters>
			</method>
			<method name="init" symbol="purple_status_init">
				<return-type type="void"/>
			</method>
			<method name="is_active" symbol="purple_status_is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
				</parameters>
			</method>
			<method name="is_available" symbol="purple_status_is_available">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
				</parameters>
			</method>
			<method name="is_exclusive" symbol="purple_status_is_exclusive">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
				</parameters>
			</method>
			<method name="is_independent" symbol="purple_status_is_independent">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
				</parameters>
			</method>
			<method name="is_online" symbol="purple_status_is_online">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_status_new">
				<return-type type="PurpleStatus*"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
					<parameter name="presence" type="PurplePresence*"/>
				</parameters>
			</method>
			<method name="set_active" symbol="purple_status_set_active">
				<return-type type="void"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
					<parameter name="active" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_active_with_attrs" symbol="purple_status_set_active_with_attrs">
				<return-type type="void"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
					<parameter name="active" type="gboolean"/>
					<parameter name="args" type="va_list"/>
				</parameters>
			</method>
			<method name="set_active_with_attrs_list" symbol="purple_status_set_active_with_attrs_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
					<parameter name="active" type="gboolean"/>
					<parameter name="attrs" type="GList*"/>
				</parameters>
			</method>
			<method name="set_attr_boolean" symbol="purple_status_set_attr_boolean">
				<return-type type="void"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
					<parameter name="id" type="char*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_attr_int" symbol="purple_status_set_attr_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
					<parameter name="id" type="char*"/>
					<parameter name="value" type="int"/>
				</parameters>
			</method>
			<method name="set_attr_string" symbol="purple_status_set_attr_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="status" type="PurpleStatus*"/>
					<parameter name="id" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="uninit" symbol="purple_status_uninit">
				<return-type type="void"/>
			</method>
		</struct>
		<struct name="PurpleStatusAttr">
			<method name="destroy" symbol="purple_status_attr_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="PurpleStatusAttr*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="purple_status_attr_get_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="attr" type="PurpleStatusAttr*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_status_attr_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="attr" type="PurpleStatusAttr*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="purple_status_attr_get_value">
				<return-type type="PurpleValue*"/>
				<parameters>
					<parameter name="attr" type="PurpleStatusAttr*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_status_attr_new">
				<return-type type="PurpleStatusAttr*"/>
				<parameters>
					<parameter name="id" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value_type" type="PurpleValue*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleStatusType">
			<method name="add_attr" symbol="purple_status_type_add_attr">
				<return-type type="void"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
					<parameter name="id" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="add_attrs" symbol="purple_status_type_add_attrs">
				<return-type type="void"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
					<parameter name="id" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="add_attrs_vargs" symbol="purple_status_type_add_attrs_vargs">
				<return-type type="void"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
					<parameter name="args" type="va_list"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_status_type_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
				</parameters>
			</method>
			<method name="find_with_id" symbol="purple_status_type_find_with_id">
				<return-type type="PurpleStatusType*"/>
				<parameters>
					<parameter name="status_types" type="GList*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_attr" symbol="purple_status_type_get_attr">
				<return-type type="PurpleStatusAttr*"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="get_attrs" symbol="purple_status_type_get_attrs">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="purple_status_type_get_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_status_type_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
				</parameters>
			</method>
			<method name="get_primary_attr" symbol="purple_status_type_get_primary_attr">
				<return-type type="char*"/>
				<parameters>
					<parameter name="type" type="PurpleStatusType*"/>
				</parameters>
			</method>
			<method name="get_primitive" symbol="purple_status_type_get_primitive">
				<return-type type="PurpleStatusPrimitive"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
				</parameters>
			</method>
			<method name="is_available" symbol="purple_status_type_is_available">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
				</parameters>
			</method>
			<method name="is_exclusive" symbol="purple_status_type_is_exclusive">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
				</parameters>
			</method>
			<method name="is_independent" symbol="purple_status_type_is_independent">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
				</parameters>
			</method>
			<method name="is_saveable" symbol="purple_status_type_is_saveable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
				</parameters>
			</method>
			<method name="is_user_settable" symbol="purple_status_type_is_user_settable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_status_type_new">
				<return-type type="PurpleStatusType*"/>
				<parameters>
					<parameter name="primitive" type="PurpleStatusPrimitive"/>
					<parameter name="id" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="user_settable" type="gboolean"/>
				</parameters>
			</method>
			<method name="new_full" symbol="purple_status_type_new_full">
				<return-type type="PurpleStatusType*"/>
				<parameters>
					<parameter name="primitive" type="PurpleStatusPrimitive"/>
					<parameter name="id" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="saveable" type="gboolean"/>
					<parameter name="user_settable" type="gboolean"/>
					<parameter name="independent" type="gboolean"/>
				</parameters>
			</method>
			<method name="new_with_attrs" symbol="purple_status_type_new_with_attrs">
				<return-type type="PurpleStatusType*"/>
				<parameters>
					<parameter name="primitive" type="PurpleStatusPrimitive"/>
					<parameter name="id" type="char*"/>
					<parameter name="name" type="char*"/>
					<parameter name="saveable" type="gboolean"/>
					<parameter name="user_settable" type="gboolean"/>
					<parameter name="independent" type="gboolean"/>
					<parameter name="attr_id" type="char*"/>
					<parameter name="attr_name" type="char*"/>
					<parameter name="attr_value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="set_primary_attr" symbol="purple_status_type_set_primary_attr">
				<return-type type="void"/>
				<parameters>
					<parameter name="status_type" type="PurpleStatusType*"/>
					<parameter name="attr_id" type="char*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleStoredImage">
		</struct>
		<struct name="PurpleStringref">
			<method name="cmp" symbol="purple_stringref_cmp">
				<return-type type="int"/>
				<parameters>
					<parameter name="s1" type="PurpleStringref*"/>
					<parameter name="s2" type="PurpleStringref*"/>
				</parameters>
			</method>
			<method name="len" symbol="purple_stringref_len">
				<return-type type="size_t"/>
				<parameters>
					<parameter name="stringref" type="PurpleStringref*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_stringref_new">
				<return-type type="PurpleStringref*"/>
				<parameters>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="new_noref" symbol="purple_stringref_new_noref">
				<return-type type="PurpleStringref*"/>
				<parameters>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="printf" symbol="purple_stringref_printf">
				<return-type type="PurpleStringref*"/>
				<parameters>
					<parameter name="format" type="char*"/>
				</parameters>
			</method>
			<method name="ref" symbol="purple_stringref_ref">
				<return-type type="PurpleStringref*"/>
				<parameters>
					<parameter name="stringref" type="PurpleStringref*"/>
				</parameters>
			</method>
			<method name="unref" symbol="purple_stringref_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="stringref" type="PurpleStringref*"/>
				</parameters>
			</method>
			<method name="value" symbol="purple_stringref_value">
				<return-type type="char*"/>
				<parameters>
					<parameter name="stringref" type="PurpleStringref*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleStunNatDiscovery">
			<field name="status" type="PurpleStunStatus"/>
			<field name="type" type="PurpleStunNatType"/>
			<field name="publicip" type="char[]"/>
			<field name="servername" type="char*"/>
			<field name="lookup_time" type="time_t"/>
		</struct>
		<struct name="PurpleTheme">
			<method name="get_author" symbol="purple_theme_get_author">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="purple_theme_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
				</parameters>
			</method>
			<method name="get_dir" symbol="purple_theme_get_dir">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
				</parameters>
			</method>
			<method name="get_image" symbol="purple_theme_get_image">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
				</parameters>
			</method>
			<method name="get_image_full" symbol="purple_theme_get_image_full">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="purple_theme_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
				</parameters>
			</method>
			<method name="get_type_string" symbol="purple_theme_get_type_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
				</parameters>
			</method>
			<method name="set_author" symbol="purple_theme_set_author">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
					<parameter name="author" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_description" symbol="purple_theme_set_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_dir" symbol="purple_theme_set_dir">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
					<parameter name="dir" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_image" symbol="purple_theme_set_image">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
					<parameter name="img" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="purple_theme_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<field name="parent" type="GObject"/>
			<field name="priv" type="gpointer"/>
		</struct>
		<struct name="PurpleThemeClass">
			<field name="parent_class" type="GObjectClass"/>
		</struct>
		<struct name="PurpleThemeLoader">
			<method name="build" symbol="purple_theme_loader_build">
				<return-type type="PurpleTheme*"/>
				<parameters>
					<parameter name="loader" type="PurpleThemeLoader*"/>
					<parameter name="dir" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_type_string" symbol="purple_theme_loader_get_type_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="PurpleThemeLoader*"/>
				</parameters>
			</method>
			<field name="parent" type="GObject"/>
			<field name="priv" type="gpointer"/>
		</struct>
		<struct name="PurpleThemeLoaderClass">
			<field name="parent_class" type="GObjectClass"/>
			<field name="purple_theme_loader_build" type="GCallback"/>
		</struct>
		<struct name="PurpleThemeManager">
			<method name="add_theme" symbol="purple_theme_manager_add_theme">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
				</parameters>
			</method>
			<method name="find_theme" symbol="purple_theme_manager_find_theme">
				<return-type type="PurpleTheme*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="type" type="gchar*"/>
				</parameters>
			</method>
			<method name="for_each_theme" symbol="purple_theme_manager_for_each_theme">
				<return-type type="void"/>
				<parameters>
					<parameter name="func" type="PTFunc"/>
				</parameters>
			</method>
			<method name="init" symbol="purple_theme_manager_init">
				<return-type type="void"/>
			</method>
			<method name="load_theme" symbol="purple_theme_manager_load_theme">
				<return-type type="PurpleTheme*"/>
				<parameters>
					<parameter name="theme_dir" type="gchar*"/>
					<parameter name="type" type="gchar*"/>
				</parameters>
			</method>
			<method name="refresh" symbol="purple_theme_manager_refresh">
				<return-type type="void"/>
			</method>
			<method name="register_type" symbol="purple_theme_manager_register_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="loader" type="PurpleThemeLoader*"/>
				</parameters>
			</method>
			<method name="remove_theme" symbol="purple_theme_manager_remove_theme">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="PurpleTheme*"/>
				</parameters>
			</method>
			<method name="uninit" symbol="purple_theme_manager_uninit">
				<return-type type="void"/>
			</method>
			<method name="unregister_type" symbol="purple_theme_manager_unregister_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="loader" type="PurpleThemeLoader*"/>
				</parameters>
			</method>
			<field name="parent" type="GObject"/>
		</struct>
		<struct name="PurpleThemeManagerClass">
			<field name="parent_class" type="GObjectClass"/>
		</struct>
		<struct name="PurpleTxtResponse">
			<method name="destroy" symbol="purple_txt_response_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="response" type="PurpleTxtResponse*"/>
				</parameters>
			</method>
			<method name="get_content" symbol="purple_txt_response_get_content">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="response" type="PurpleTxtResponse*"/>
				</parameters>
			</method>
		</struct>
		<struct name="PurpleUtilFetchUrlData">
		</struct>
		<struct name="PurpleValue">
			<method name="destroy" symbol="purple_value_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="dup" symbol="purple_value_dup">
				<return-type type="PurpleValue*"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_boolean" symbol="purple_value_get_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_boxed" symbol="purple_value_get_boxed">
				<return-type type="void*"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_char" symbol="purple_value_get_char">
				<return-type type="char"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_enum" symbol="purple_value_get_enum">
				<return-type type="int"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_int" symbol="purple_value_get_int">
				<return-type type="int"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_int64" symbol="purple_value_get_int64">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_long" symbol="purple_value_get_long">
				<return-type type="long"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_object" symbol="purple_value_get_object">
				<return-type type="void*"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_pointer" symbol="purple_value_get_pointer">
				<return-type type="void*"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_short" symbol="purple_value_get_short">
				<return-type type="short"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_specific_type" symbol="purple_value_get_specific_type">
				<return-type type="char*"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_string" symbol="purple_value_get_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_subtype" symbol="purple_value_get_subtype">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_uchar" symbol="purple_value_get_uchar">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_uint" symbol="purple_value_get_uint">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_uint64" symbol="purple_value_get_uint64">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_ulong" symbol="purple_value_get_ulong">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="get_ushort" symbol="purple_value_get_ushort">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="is_outgoing" symbol="purple_value_is_outgoing">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_value_new">
				<return-type type="PurpleValue*"/>
				<parameters>
					<parameter name="type" type="PurpleType"/>
				</parameters>
			</method>
			<method name="new_outgoing" symbol="purple_value_new_outgoing">
				<return-type type="PurpleValue*"/>
				<parameters>
					<parameter name="type" type="PurpleType"/>
				</parameters>
			</method>
			<method name="set_boolean" symbol="purple_value_set_boolean">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_boxed" symbol="purple_value_set_boxed">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="void*"/>
				</parameters>
			</method>
			<method name="set_char" symbol="purple_value_set_char">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="char"/>
				</parameters>
			</method>
			<method name="set_enum" symbol="purple_value_set_enum">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="int"/>
				</parameters>
			</method>
			<method name="set_int" symbol="purple_value_set_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="int"/>
				</parameters>
			</method>
			<method name="set_int64" symbol="purple_value_set_int64">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="gint64"/>
				</parameters>
			</method>
			<method name="set_long" symbol="purple_value_set_long">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="long"/>
				</parameters>
			</method>
			<method name="set_object" symbol="purple_value_set_object">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="void*"/>
				</parameters>
			</method>
			<method name="set_pointer" symbol="purple_value_set_pointer">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="void*"/>
				</parameters>
			</method>
			<method name="set_short" symbol="purple_value_set_short">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="short"/>
				</parameters>
			</method>
			<method name="set_string" symbol="purple_value_set_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="char*"/>
				</parameters>
			</method>
			<method name="set_uchar" symbol="purple_value_set_uchar">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="unsigned"/>
				</parameters>
			</method>
			<method name="set_uint" symbol="purple_value_set_uint">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="unsigned"/>
				</parameters>
			</method>
			<method name="set_uint64" symbol="purple_value_set_uint64">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="guint64"/>
				</parameters>
			</method>
			<method name="set_ulong" symbol="purple_value_set_ulong">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="unsigned"/>
				</parameters>
			</method>
			<method name="set_ushort" symbol="purple_value_set_ushort">
				<return-type type="void"/>
				<parameters>
					<parameter name="value" type="PurpleValue*"/>
					<parameter name="data" type="unsigned"/>
				</parameters>
			</method>
			<field name="type" type="PurpleType"/>
			<field name="flags" type="unsigned"/>
			<field name="data" type="gpointer"/>
			<field name="u" type="gpointer"/>
		</struct>
		<struct name="PurpleWhiteboard">
			<method name="clear" symbol="purple_whiteboard_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
				</parameters>
			</method>
			<method name="create" symbol="purple_whiteboard_create">
				<return-type type="PurpleWhiteboard*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="who" type="char*"/>
					<parameter name="state" type="int"/>
				</parameters>
			</method>
			<method name="destroy" symbol="purple_whiteboard_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
				</parameters>
			</method>
			<method name="draw_line" symbol="purple_whiteboard_draw_line">
				<return-type type="void"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
					<parameter name="x1" type="int"/>
					<parameter name="y1" type="int"/>
					<parameter name="x2" type="int"/>
					<parameter name="y2" type="int"/>
					<parameter name="color" type="int"/>
					<parameter name="size" type="int"/>
				</parameters>
			</method>
			<method name="draw_list_destroy" symbol="purple_whiteboard_draw_list_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="draw_list" type="GList*"/>
				</parameters>
			</method>
			<method name="draw_point" symbol="purple_whiteboard_draw_point">
				<return-type type="void"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
					<parameter name="color" type="int"/>
					<parameter name="size" type="int"/>
				</parameters>
			</method>
			<method name="get_brush" symbol="purple_whiteboard_get_brush">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
					<parameter name="size" type="int*"/>
					<parameter name="color" type="int*"/>
				</parameters>
			</method>
			<method name="get_dimensions" symbol="purple_whiteboard_get_dimensions">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
					<parameter name="width" type="int*"/>
					<parameter name="height" type="int*"/>
				</parameters>
			</method>
			<method name="get_session" symbol="purple_whiteboard_get_session">
				<return-type type="PurpleWhiteboard*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="who" type="char*"/>
				</parameters>
			</method>
			<method name="send_brush" symbol="purple_whiteboard_send_brush">
				<return-type type="void"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
					<parameter name="size" type="int"/>
					<parameter name="color" type="int"/>
				</parameters>
			</method>
			<method name="send_clear" symbol="purple_whiteboard_send_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
				</parameters>
			</method>
			<method name="send_draw_list" symbol="purple_whiteboard_send_draw_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="set_brush" symbol="purple_whiteboard_set_brush">
				<return-type type="void"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
					<parameter name="size" type="int"/>
					<parameter name="color" type="int"/>
				</parameters>
			</method>
			<method name="set_dimensions" symbol="purple_whiteboard_set_dimensions">
				<return-type type="void"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</method>
			<method name="set_prpl_ops" symbol="purple_whiteboard_set_prpl_ops">
				<return-type type="void"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
					<parameter name="ops" type="PurpleWhiteboardPrplOps*"/>
				</parameters>
			</method>
			<method name="set_ui_ops" symbol="purple_whiteboard_set_ui_ops">
				<return-type type="void"/>
				<parameters>
					<parameter name="ops" type="PurpleWhiteboardUiOps*"/>
				</parameters>
			</method>
			<method name="start" symbol="purple_whiteboard_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="wb" type="PurpleWhiteboard*"/>
				</parameters>
			</method>
			<field name="state" type="int"/>
			<field name="account" type="PurpleAccount*"/>
			<field name="who" type="char*"/>
			<field name="ui_data" type="void*"/>
			<field name="proto_data" type="void*"/>
			<field name="prpl_ops" type="PurpleWhiteboardPrplOps*"/>
			<field name="draw_list" type="GList*"/>
		</struct>
		<struct name="PurpleWhiteboardPrplOps">
			<field name="start" type="GCallback"/>
			<field name="end" type="GCallback"/>
			<field name="get_dimensions" type="GCallback"/>
			<field name="set_dimensions" type="GCallback"/>
			<field name="get_brush" type="GCallback"/>
			<field name="set_brush" type="GCallback"/>
			<field name="send_draw_list" type="GCallback"/>
			<field name="clear" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleWhiteboardUiOps">
			<field name="create" type="GCallback"/>
			<field name="destroy" type="GCallback"/>
			<field name="set_dimensions" type="GCallback"/>
			<field name="set_brush" type="GCallback"/>
			<field name="draw_point" type="GCallback"/>
			<field name="draw_line" type="GCallback"/>
			<field name="clear" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
			<field name="_purple_reserved2" type="GCallback"/>
			<field name="_purple_reserved3" type="GCallback"/>
			<field name="_purple_reserved4" type="GCallback"/>
		</struct>
		<struct name="PurpleXfer">
			<method name="add" symbol="purple_xfer_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="cancel_local" symbol="purple_xfer_cancel_local">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="cancel_remote" symbol="purple_xfer_cancel_remote">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="conversation_write" symbol="purple_xfer_conversation_write">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="message" type="char*"/>
					<parameter name="is_error" type="gboolean"/>
				</parameters>
			</method>
			<method name="end" symbol="purple_xfer_end">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="error" symbol="purple_xfer_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="type" type="PurpleXferType"/>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="who" type="char*"/>
					<parameter name="msg" type="char*"/>
				</parameters>
			</method>
			<method name="get_account" symbol="purple_xfer_get_account">
				<return-type type="PurpleAccount*"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_bytes_remaining" symbol="purple_xfer_get_bytes_remaining">
				<return-type type="size_t"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_bytes_sent" symbol="purple_xfer_get_bytes_sent">
				<return-type type="size_t"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_end_time" symbol="purple_xfer_get_end_time">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_filename" symbol="purple_xfer_get_filename">
				<return-type type="char*"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_local_filename" symbol="purple_xfer_get_local_filename">
				<return-type type="char*"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_local_port" symbol="purple_xfer_get_local_port">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_progress" symbol="purple_xfer_get_progress">
				<return-type type="double"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_remote_ip" symbol="purple_xfer_get_remote_ip">
				<return-type type="char*"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_remote_port" symbol="purple_xfer_get_remote_port">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_remote_user" symbol="purple_xfer_get_remote_user">
				<return-type type="char*"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="purple_xfer_get_size">
				<return-type type="size_t"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_start_time" symbol="purple_xfer_get_start_time">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_status" symbol="purple_xfer_get_status">
				<return-type type="PurpleXferStatusType"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="get_ui_ops" symbol="purple_xfer_get_ui_ops">
				<return-type type="PurpleXferUiOps*"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="is_canceled" symbol="purple_xfer_is_canceled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="is_completed" symbol="purple_xfer_is_completed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="new" symbol="purple_xfer_new">
				<return-type type="PurpleXfer*"/>
				<parameters>
					<parameter name="account" type="PurpleAccount*"/>
					<parameter name="type" type="PurpleXferType"/>
					<parameter name="who" type="char*"/>
				</parameters>
			</method>
			<method name="prpl_ready" symbol="purple_xfer_prpl_ready">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="read" symbol="purple_xfer_read">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="buffer" type="guchar**"/>
				</parameters>
			</method>
			<method name="ref" symbol="purple_xfer_ref">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="request" symbol="purple_xfer_request">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="request_accepted" symbol="purple_xfer_request_accepted">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="filename" type="char*"/>
				</parameters>
			</method>
			<method name="request_denied" symbol="purple_xfer_request_denied">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="set_ack_fnc" symbol="purple_xfer_set_ack_fnc">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="fnc" type="GCallback"/>
				</parameters>
			</method>
			<method name="set_bytes_sent" symbol="purple_xfer_set_bytes_sent">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="bytes_sent" type="size_t"/>
				</parameters>
			</method>
			<method name="set_cancel_recv_fnc" symbol="purple_xfer_set_cancel_recv_fnc">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="fnc" type="GCallback"/>
				</parameters>
			</method>
			<method name="set_cancel_send_fnc" symbol="purple_xfer_set_cancel_send_fnc">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="fnc" type="GCallback"/>
				</parameters>
			</method>
			<method name="set_completed" symbol="purple_xfer_set_completed">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="completed" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_end_fnc" symbol="purple_xfer_set_end_fnc">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="fnc" type="GCallback"/>
				</parameters>
			</method>
			<method name="set_filename" symbol="purple_xfer_set_filename">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="filename" type="char*"/>
				</parameters>
			</method>
			<method name="set_init_fnc" symbol="purple_xfer_set_init_fnc">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="fnc" type="GCallback"/>
				</parameters>
			</method>
			<method name="set_local_filename" symbol="purple_xfer_set_local_filename">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="filename" type="char*"/>
				</parameters>
			</method>
			<method name="set_message" symbol="purple_xfer_set_message">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="message" type="char*"/>
				</parameters>
			</method>
			<method name="set_read_fnc" symbol="purple_xfer_set_read_fnc">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="fnc" type="GCallback"/>
				</parameters>
			</method>
			<method name="set_request_denied_fnc" symbol="purple_xfer_set_request_denied_fnc">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="fnc" type="GCallback"/>
				</parameters>
			</method>
			<method name="set_size" symbol="purple_xfer_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="size" type="size_t"/>
				</parameters>
			</method>
			<method name="set_start_fnc" symbol="purple_xfer_set_start_fnc">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="fnc" type="GCallback"/>
				</parameters>
			</method>
			<method name="set_write_fnc" symbol="purple_xfer_set_write_fnc">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="fnc" type="GCallback"/>
				</parameters>
			</method>
			<method name="start" symbol="purple_xfer_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="fd" type="int"/>
					<parameter name="ip" type="char*"/>
					<parameter name="port" type="unsigned"/>
				</parameters>
			</method>
			<method name="ui_ready" symbol="purple_xfer_ui_ready">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="unref" symbol="purple_xfer_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="update_progress" symbol="purple_xfer_update_progress">
				<return-type type="void"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
				</parameters>
			</method>
			<method name="write" symbol="purple_xfer_write">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="xfer" type="PurpleXfer*"/>
					<parameter name="buffer" type="guchar*"/>
					<parameter name="size" type="gsize"/>
				</parameters>
			</method>
			<field name="ref" type="guint"/>
			<field name="type" type="PurpleXferType"/>
			<field name="account" type="PurpleAccount*"/>
			<field name="who" type="char*"/>
			<field name="message" type="char*"/>
			<field name="filename" type="char*"/>
			<field name="local_filename" type="char*"/>
			<field name="size" type="size_t"/>
			<field name="dest_fp" type="FILE*"/>
			<field name="remote_ip" type="char*"/>
			<field name="local_port" type="int"/>
			<field name="remote_port" type="int"/>
			<field name="fd" type="int"/>
			<field name="watcher" type="int"/>
			<field name="bytes_sent" type="size_t"/>
			<field name="bytes_remaining" type="size_t"/>
			<field name="start_time" type="time_t"/>
			<field name="end_time" type="time_t"/>
			<field name="current_buffer_size" type="size_t"/>
			<field name="status" type="PurpleXferStatusType"/>
			<field name="ops" type="gpointer"/>
			<field name="ui_ops" type="PurpleXferUiOps*"/>
			<field name="ui_data" type="void*"/>
			<field name="data" type="void*"/>
		</struct>
		<struct name="PurpleXferUiOps">
			<field name="new_xfer" type="GCallback"/>
			<field name="destroy" type="GCallback"/>
			<field name="add_xfer" type="GCallback"/>
			<field name="update_progress" type="GCallback"/>
			<field name="cancel_local" type="GCallback"/>
			<field name="cancel_remote" type="GCallback"/>
			<field name="ui_write" type="GCallback"/>
			<field name="ui_read" type="GCallback"/>
			<field name="data_not_sent" type="GCallback"/>
			<field name="_purple_reserved1" type="GCallback"/>
		</struct>
		<struct name="UPnPMappingAddRemove">
		</struct>
		<struct name="xmlnode">
			<method name="copy" symbol="xmlnode_copy">
				<return-type type="xmlnode*"/>
				<parameters>
					<parameter name="src" type="xmlnode*"/>
				</parameters>
			</method>
			<method name="free" symbol="xmlnode_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
				</parameters>
			</method>
			<method name="from_file" symbol="xmlnode_from_file">
				<return-type type="xmlnode*"/>
				<parameters>
					<parameter name="dir" type="char*"/>
					<parameter name="filename" type="char*"/>
					<parameter name="description" type="char*"/>
					<parameter name="process" type="char*"/>
				</parameters>
			</method>
			<method name="from_str" symbol="xmlnode_from_str">
				<return-type type="xmlnode*"/>
				<parameters>
					<parameter name="str" type="char*"/>
					<parameter name="size" type="gssize"/>
				</parameters>
			</method>
			<method name="get_attrib" symbol="xmlnode_get_attrib">
				<return-type type="char*"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="attr" type="char*"/>
				</parameters>
			</method>
			<method name="get_attrib_with_namespace" symbol="xmlnode_get_attrib_with_namespace">
				<return-type type="char*"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="xmlns" type="char*"/>
				</parameters>
			</method>
			<method name="get_child" symbol="xmlnode_get_child">
				<return-type type="xmlnode*"/>
				<parameters>
					<parameter name="parent" type="xmlnode*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_child_with_namespace" symbol="xmlnode_get_child_with_namespace">
				<return-type type="xmlnode*"/>
				<parameters>
					<parameter name="parent" type="xmlnode*"/>
					<parameter name="name" type="char*"/>
					<parameter name="xmlns" type="char*"/>
				</parameters>
			</method>
			<method name="get_data" symbol="xmlnode_get_data">
				<return-type type="char*"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
				</parameters>
			</method>
			<method name="get_data_unescaped" symbol="xmlnode_get_data_unescaped">
				<return-type type="char*"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
				</parameters>
			</method>
			<method name="get_namespace" symbol="xmlnode_get_namespace">
				<return-type type="char*"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
				</parameters>
			</method>
			<method name="get_next_twin" symbol="xmlnode_get_next_twin">
				<return-type type="xmlnode*"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="xmlnode_get_parent">
				<return-type type="xmlnode*"/>
				<parameters>
					<parameter name="child" type="xmlnode*"/>
				</parameters>
			</method>
			<method name="get_prefix" symbol="xmlnode_get_prefix">
				<return-type type="char*"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
				</parameters>
			</method>
			<method name="insert_child" symbol="xmlnode_insert_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="parent" type="xmlnode*"/>
					<parameter name="child" type="xmlnode*"/>
				</parameters>
			</method>
			<method name="insert_data" symbol="xmlnode_insert_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="data" type="char*"/>
					<parameter name="size" type="gssize"/>
				</parameters>
			</method>
			<method name="new" symbol="xmlnode_new">
				<return-type type="xmlnode*"/>
				<parameters>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="new_child" symbol="xmlnode_new_child">
				<return-type type="xmlnode*"/>
				<parameters>
					<parameter name="parent" type="xmlnode*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="remove_attrib" symbol="xmlnode_remove_attrib">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="attr" type="char*"/>
				</parameters>
			</method>
			<method name="remove_attrib_with_namespace" symbol="xmlnode_remove_attrib_with_namespace">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="xmlns" type="char*"/>
				</parameters>
			</method>
			<method name="set_attrib" symbol="xmlnode_set_attrib">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_attrib_full" symbol="xmlnode_set_attrib_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="xmlns" type="char*"/>
					<parameter name="prefix" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_attrib_with_namespace" symbol="xmlnode_set_attrib_with_namespace">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="xmlns" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_attrib_with_prefix" symbol="xmlnode_set_attrib_with_prefix">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="prefix" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_namespace" symbol="xmlnode_set_namespace">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="xmlns" type="char*"/>
				</parameters>
			</method>
			<method name="set_prefix" symbol="xmlnode_set_prefix">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="prefix" type="char*"/>
				</parameters>
			</method>
			<method name="to_formatted_str" symbol="xmlnode_to_formatted_str">
				<return-type type="char*"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="len" type="int*"/>
				</parameters>
			</method>
			<method name="to_str" symbol="xmlnode_to_str">
				<return-type type="char*"/>
				<parameters>
					<parameter name="node" type="xmlnode*"/>
					<parameter name="len" type="int*"/>
				</parameters>
			</method>
			<field name="name" type="char*"/>
			<field name="xmlns" type="char*"/>
			<field name="type" type="XMLNodeType"/>
			<field name="data" type="char*"/>
			<field name="data_sz" type="size_t"/>
			<field name="parent" type="xmlnode*"/>
			<field name="child" type="xmlnode*"/>
			<field name="lastchild" type="xmlnode*"/>
			<field name="next" type="xmlnode*"/>
			<field name="prefix" type="char*"/>
			<field name="namespace_map" type="GHashTable*"/>
		</struct>
		<enum name="PurpleAccountRequestType">
			<member name="PURPLE_ACCOUNT_REQUEST_AUTHORIZATION" value="0"/>
		</enum>
		<enum name="PurpleBlistNodeFlags">
			<member name="PURPLE_BLIST_NODE_FLAG_NO_SAVE" value="1"/>
		</enum>
		<enum name="PurpleBlistNodeType">
			<member name="PURPLE_BLIST_GROUP_NODE" value="0"/>
			<member name="PURPLE_BLIST_CONTACT_NODE" value="1"/>
			<member name="PURPLE_BLIST_BUDDY_NODE" value="2"/>
			<member name="PURPLE_BLIST_CHAT_NODE" value="3"/>
			<member name="PURPLE_BLIST_OTHER_NODE" value="4"/>
		</enum>
		<enum name="PurpleCertificateVerificationStatus">
			<member name="PURPLE_CERTIFICATE_INVALID" value="0"/>
			<member name="PURPLE_CERTIFICATE_VALID" value="1"/>
		</enum>
		<enum name="PurpleCipherBatchMode">
			<member name="PURPLE_CIPHER_BATCH_MODE_ECB" value="0"/>
			<member name="PURPLE_CIPHER_BATCH_MODE_CBC" value="1"/>
		</enum>
		<enum name="PurpleCipherCaps">
			<member name="PURPLE_CIPHER_CAPS_SET_OPT" value="2"/>
			<member name="PURPLE_CIPHER_CAPS_GET_OPT" value="4"/>
			<member name="PURPLE_CIPHER_CAPS_INIT" value="8"/>
			<member name="PURPLE_CIPHER_CAPS_RESET" value="16"/>
			<member name="PURPLE_CIPHER_CAPS_UNINIT" value="32"/>
			<member name="PURPLE_CIPHER_CAPS_SET_IV" value="64"/>
			<member name="PURPLE_CIPHER_CAPS_APPEND" value="128"/>
			<member name="PURPLE_CIPHER_CAPS_DIGEST" value="256"/>
			<member name="PURPLE_CIPHER_CAPS_ENCRYPT" value="512"/>
			<member name="PURPLE_CIPHER_CAPS_DECRYPT" value="1024"/>
			<member name="PURPLE_CIPHER_CAPS_SET_SALT" value="2048"/>
			<member name="PURPLE_CIPHER_CAPS_GET_SALT_SIZE" value="4096"/>
			<member name="PURPLE_CIPHER_CAPS_SET_KEY" value="8192"/>
			<member name="PURPLE_CIPHER_CAPS_GET_KEY_SIZE" value="16384"/>
			<member name="PURPLE_CIPHER_CAPS_SET_BATCH_MODE" value="32768"/>
			<member name="PURPLE_CIPHER_CAPS_GET_BATCH_MODE" value="65536"/>
			<member name="PURPLE_CIPHER_CAPS_GET_BLOCK_SIZE" value="131072"/>
			<member name="PURPLE_CIPHER_CAPS_SET_KEY_WITH_LEN" value="262144"/>
			<member name="PURPLE_CIPHER_CAPS_UNKNOWN" value="524288"/>
		</enum>
		<enum name="PurpleCmdFlag">
			<member name="PURPLE_CMD_FLAG_IM" value="1"/>
			<member name="PURPLE_CMD_FLAG_CHAT" value="2"/>
			<member name="PURPLE_CMD_FLAG_PRPL_ONLY" value="4"/>
			<member name="PURPLE_CMD_FLAG_ALLOW_WRONG_ARGS" value="8"/>
		</enum>
		<enum name="PurpleCmdPriority">
			<member name="PURPLE_CMD_P_VERY_LOW" value="-1000"/>
			<member name="PURPLE_CMD_P_LOW" value="0"/>
			<member name="PURPLE_CMD_P_DEFAULT" value="1000"/>
			<member name="PURPLE_CMD_P_PRPL" value="2000"/>
			<member name="PURPLE_CMD_P_PLUGIN" value="3000"/>
			<member name="PURPLE_CMD_P_ALIAS" value="4000"/>
			<member name="PURPLE_CMD_P_HIGH" value="5000"/>
			<member name="PURPLE_CMD_P_VERY_HIGH" value="6000"/>
		</enum>
		<enum name="PurpleCmdRet">
			<member name="PURPLE_CMD_RET_OK" value="0"/>
			<member name="PURPLE_CMD_RET_FAILED" value="1"/>
			<member name="PURPLE_CMD_RET_CONTINUE" value="2"/>
		</enum>
		<enum name="PurpleCmdStatus">
			<member name="PURPLE_CMD_STATUS_OK" value="0"/>
			<member name="PURPLE_CMD_STATUS_FAILED" value="1"/>
			<member name="PURPLE_CMD_STATUS_NOT_FOUND" value="2"/>
			<member name="PURPLE_CMD_STATUS_WRONG_ARGS" value="3"/>
			<member name="PURPLE_CMD_STATUS_WRONG_PRPL" value="4"/>
			<member name="PURPLE_CMD_STATUS_WRONG_TYPE" value="5"/>
		</enum>
		<enum name="PurpleConnectionError">
			<member name="PURPLE_CONNECTION_ERROR_NETWORK_ERROR" value="0"/>
			<member name="PURPLE_CONNECTION_ERROR_INVALID_USERNAME" value="1"/>
			<member name="PURPLE_CONNECTION_ERROR_AUTHENTICATION_FAILED" value="2"/>
			<member name="PURPLE_CONNECTION_ERROR_AUTHENTICATION_IMPOSSIBLE" value="3"/>
			<member name="PURPLE_CONNECTION_ERROR_NO_SSL_SUPPORT" value="4"/>
			<member name="PURPLE_CONNECTION_ERROR_ENCRYPTION_ERROR" value="5"/>
			<member name="PURPLE_CONNECTION_ERROR_NAME_IN_USE" value="6"/>
			<member name="PURPLE_CONNECTION_ERROR_INVALID_SETTINGS" value="7"/>
			<member name="PURPLE_CONNECTION_ERROR_CERT_NOT_PROVIDED" value="8"/>
			<member name="PURPLE_CONNECTION_ERROR_CERT_UNTRUSTED" value="9"/>
			<member name="PURPLE_CONNECTION_ERROR_CERT_EXPIRED" value="10"/>
			<member name="PURPLE_CONNECTION_ERROR_CERT_NOT_ACTIVATED" value="11"/>
			<member name="PURPLE_CONNECTION_ERROR_CERT_HOSTNAME_MISMATCH" value="12"/>
			<member name="PURPLE_CONNECTION_ERROR_CERT_FINGERPRINT_MISMATCH" value="13"/>
			<member name="PURPLE_CONNECTION_ERROR_CERT_SELF_SIGNED" value="14"/>
			<member name="PURPLE_CONNECTION_ERROR_CERT_OTHER_ERROR" value="15"/>
			<member name="PURPLE_CONNECTION_ERROR_OTHER_ERROR" value="16"/>
		</enum>
		<enum name="PurpleConnectionFlags">
			<member name="PURPLE_CONNECTION_HTML" value="1"/>
			<member name="PURPLE_CONNECTION_NO_BGCOLOR" value="2"/>
			<member name="PURPLE_CONNECTION_AUTO_RESP" value="4"/>
			<member name="PURPLE_CONNECTION_FORMATTING_WBFO" value="8"/>
			<member name="PURPLE_CONNECTION_NO_NEWLINES" value="16"/>
			<member name="PURPLE_CONNECTION_NO_FONTSIZE" value="32"/>
			<member name="PURPLE_CONNECTION_NO_URLDESC" value="64"/>
			<member name="PURPLE_CONNECTION_NO_IMAGES" value="128"/>
			<member name="PURPLE_CONNECTION_ALLOW_CUSTOM_SMILEY" value="256"/>
		</enum>
		<enum name="PurpleConnectionState">
			<member name="PURPLE_DISCONNECTED" value="0"/>
			<member name="PURPLE_CONNECTED" value="1"/>
			<member name="PURPLE_CONNECTING" value="2"/>
		</enum>
		<enum name="PurpleConvChatBuddyFlags">
			<member name="PURPLE_CBFLAGS_NONE" value="0"/>
			<member name="PURPLE_CBFLAGS_VOICE" value="1"/>
			<member name="PURPLE_CBFLAGS_HALFOP" value="2"/>
			<member name="PURPLE_CBFLAGS_OP" value="4"/>
			<member name="PURPLE_CBFLAGS_FOUNDER" value="8"/>
			<member name="PURPLE_CBFLAGS_TYPING" value="16"/>
		</enum>
		<enum name="PurpleConvUpdateType">
			<member name="PURPLE_CONV_UPDATE_ADD" value="0"/>
			<member name="PURPLE_CONV_UPDATE_REMOVE" value="1"/>
			<member name="PURPLE_CONV_UPDATE_ACCOUNT" value="2"/>
			<member name="PURPLE_CONV_UPDATE_TYPING" value="3"/>
			<member name="PURPLE_CONV_UPDATE_UNSEEN" value="4"/>
			<member name="PURPLE_CONV_UPDATE_LOGGING" value="5"/>
			<member name="PURPLE_CONV_UPDATE_TOPIC" value="6"/>
			<member name="PURPLE_CONV_ACCOUNT_ONLINE" value="7"/>
			<member name="PURPLE_CONV_ACCOUNT_OFFLINE" value="8"/>
			<member name="PURPLE_CONV_UPDATE_AWAY" value="9"/>
			<member name="PURPLE_CONV_UPDATE_ICON" value="10"/>
			<member name="PURPLE_CONV_UPDATE_TITLE" value="11"/>
			<member name="PURPLE_CONV_UPDATE_CHATLEFT" value="12"/>
			<member name="PURPLE_CONV_UPDATE_FEATURES" value="13"/>
		</enum>
		<enum name="PurpleConversationType">
			<member name="PURPLE_CONV_TYPE_UNKNOWN" value="0"/>
			<member name="PURPLE_CONV_TYPE_IM" value="1"/>
			<member name="PURPLE_CONV_TYPE_CHAT" value="2"/>
			<member name="PURPLE_CONV_TYPE_MISC" value="3"/>
			<member name="PURPLE_CONV_TYPE_ANY" value="4"/>
		</enum>
		<enum name="PurpleDebugLevel">
			<member name="PURPLE_DEBUG_ALL" value="0"/>
			<member name="PURPLE_DEBUG_MISC" value="1"/>
			<member name="PURPLE_DEBUG_INFO" value="2"/>
			<member name="PURPLE_DEBUG_WARNING" value="3"/>
			<member name="PURPLE_DEBUG_ERROR" value="4"/>
			<member name="PURPLE_DEBUG_FATAL" value="5"/>
		</enum>
		<enum name="PurpleDesktopItemType">
			<member name="PURPLE_DESKTOP_ITEM_TYPE_NULL" value="0"/>
			<member name="PURPLE_DESKTOP_ITEM_TYPE_OTHER" value="1"/>
			<member name="PURPLE_DESKTOP_ITEM_TYPE_APPLICATION" value="2"/>
			<member name="PURPLE_DESKTOP_ITEM_TYPE_LINK" value="3"/>
			<member name="PURPLE_DESKTOP_ITEM_TYPE_FSDEVICE" value="4"/>
			<member name="PURPLE_DESKTOP_ITEM_TYPE_MIME_TYPE" value="5"/>
			<member name="PURPLE_DESKTOP_ITEM_TYPE_DIRECTORY" value="6"/>
			<member name="PURPLE_DESKTOP_ITEM_TYPE_SERVICE" value="7"/>
			<member name="PURPLE_DESKTOP_ITEM_TYPE_SERVICE_TYPE" value="8"/>
		</enum>
		<enum name="PurpleIconScaleRules">
			<member name="PURPLE_ICON_SCALE_DISPLAY" value="1"/>
			<member name="PURPLE_ICON_SCALE_SEND" value="2"/>
		</enum>
		<enum name="PurpleInputCondition">
			<member name="PURPLE_INPUT_READ" value="1"/>
			<member name="PURPLE_INPUT_WRITE" value="2"/>
		</enum>
		<enum name="PurpleLogReadFlags">
			<member name="PURPLE_LOG_READ_NO_NEWLINE" value="1"/>
		</enum>
		<enum name="PurpleLogType">
			<member name="PURPLE_LOG_IM" value="0"/>
			<member name="PURPLE_LOG_CHAT" value="1"/>
			<member name="PURPLE_LOG_SYSTEM" value="2"/>
		</enum>
		<enum name="PurpleMediaCandidateType">
			<member name="PURPLE_MEDIA_CANDIDATE_TYPE_HOST" value="0"/>
			<member name="PURPLE_MEDIA_CANDIDATE_TYPE_SRFLX" value="1"/>
			<member name="PURPLE_MEDIA_CANDIDATE_TYPE_PRFLX" value="2"/>
			<member name="PURPLE_MEDIA_CANDIDATE_TYPE_RELAY" value="3"/>
			<member name="PURPLE_MEDIA_CANDIDATE_TYPE_MULTICAST" value="4"/>
		</enum>
		<enum name="PurpleMediaCaps">
			<member name="PURPLE_MEDIA_CAPS_NONE" value="0"/>
			<member name="PURPLE_MEDIA_CAPS_AUDIO" value="1"/>
			<member name="PURPLE_MEDIA_CAPS_AUDIO_SINGLE_DIRECTION" value="2"/>
			<member name="PURPLE_MEDIA_CAPS_VIDEO" value="4"/>
			<member name="PURPLE_MEDIA_CAPS_VIDEO_SINGLE_DIRECTION" value="8"/>
			<member name="PURPLE_MEDIA_CAPS_AUDIO_VIDEO" value="16"/>
			<member name="PURPLE_MEDIA_CAPS_MODIFY_SESSION" value="32"/>
			<member name="PURPLE_MEDIA_CAPS_CHANGE_DIRECTION" value="64"/>
		</enum>
		<enum name="PurpleMediaComponentType">
			<member name="PURPLE_MEDIA_COMPONENT_NONE" value="0"/>
			<member name="PURPLE_MEDIA_COMPONENT_RTP" value="1"/>
			<member name="PURPLE_MEDIA_COMPONENT_RTCP" value="2"/>
		</enum>
		<enum name="PurpleMediaElementType">
			<member name="PURPLE_MEDIA_ELEMENT_NONE" value="0"/>
			<member name="PURPLE_MEDIA_ELEMENT_AUDIO" value="1"/>
			<member name="PURPLE_MEDIA_ELEMENT_VIDEO" value="2"/>
			<member name="PURPLE_MEDIA_ELEMENT_AUDIO_VIDEO" value="3"/>
			<member name="PURPLE_MEDIA_ELEMENT_NO_SRCS" value="0"/>
			<member name="PURPLE_MEDIA_ELEMENT_ONE_SRC" value="4"/>
			<member name="PURPLE_MEDIA_ELEMENT_MULTI_SRC" value="8"/>
			<member name="PURPLE_MEDIA_ELEMENT_REQUEST_SRC" value="16"/>
			<member name="PURPLE_MEDIA_ELEMENT_NO_SINKS" value="0"/>
			<member name="PURPLE_MEDIA_ELEMENT_ONE_SINK" value="32"/>
			<member name="PURPLE_MEDIA_ELEMENT_MULTI_SINK" value="64"/>
			<member name="PURPLE_MEDIA_ELEMENT_REQUEST_SINK" value="128"/>
			<member name="PURPLE_MEDIA_ELEMENT_UNIQUE" value="256"/>
			<member name="PURPLE_MEDIA_ELEMENT_SRC" value="512"/>
			<member name="PURPLE_MEDIA_ELEMENT_SINK" value="1024"/>
		</enum>
		<enum name="PurpleMediaInfoType">
			<member name="PURPLE_MEDIA_INFO_HANGUP" value="0"/>
			<member name="PURPLE_MEDIA_INFO_ACCEPT" value="1"/>
			<member name="PURPLE_MEDIA_INFO_REJECT" value="2"/>
			<member name="PURPLE_MEDIA_INFO_MUTE" value="3"/>
			<member name="PURPLE_MEDIA_INFO_UNMUTE" value="4"/>
			<member name="PURPLE_MEDIA_INFO_PAUSE" value="5"/>
			<member name="PURPLE_MEDIA_INFO_UNPAUSE" value="6"/>
			<member name="PURPLE_MEDIA_INFO_HOLD" value="7"/>
			<member name="PURPLE_MEDIA_INFO_UNHOLD" value="8"/>
		</enum>
		<enum name="PurpleMediaNetworkProtocol">
			<member name="PURPLE_MEDIA_NETWORK_PROTOCOL_UDP" value="0"/>
			<member name="PURPLE_MEDIA_NETWORK_PROTOCOL_TCP" value="1"/>
		</enum>
		<enum name="PurpleMediaSessionType">
			<member name="PURPLE_MEDIA_NONE" value="0"/>
			<member name="PURPLE_MEDIA_RECV_AUDIO" value="1"/>
			<member name="PURPLE_MEDIA_SEND_AUDIO" value="2"/>
			<member name="PURPLE_MEDIA_RECV_VIDEO" value="4"/>
			<member name="PURPLE_MEDIA_SEND_VIDEO" value="8"/>
			<member name="PURPLE_MEDIA_AUDIO" value="3"/>
			<member name="PURPLE_MEDIA_VIDEO" value="12"/>
		</enum>
		<enum name="PurpleMediaState">
			<member name="PURPLE_MEDIA_STATE_NEW" value="0"/>
			<member name="PURPLE_MEDIA_STATE_CONNECTED" value="1"/>
			<member name="PURPLE_MEDIA_STATE_END" value="2"/>
		</enum>
		<enum name="PurpleMessageFlags">
			<member name="PURPLE_MESSAGE_SEND" value="1"/>
			<member name="PURPLE_MESSAGE_RECV" value="2"/>
			<member name="PURPLE_MESSAGE_SYSTEM" value="4"/>
			<member name="PURPLE_MESSAGE_AUTO_RESP" value="8"/>
			<member name="PURPLE_MESSAGE_ACTIVE_ONLY" value="16"/>
			<member name="PURPLE_MESSAGE_NICK" value="32"/>
			<member name="PURPLE_MESSAGE_NO_LOG" value="64"/>
			<member name="PURPLE_MESSAGE_WHISPER" value="128"/>
			<member name="PURPLE_MESSAGE_ERROR" value="512"/>
			<member name="PURPLE_MESSAGE_DELAYED" value="1024"/>
			<member name="PURPLE_MESSAGE_RAW" value="2048"/>
			<member name="PURPLE_MESSAGE_IMAGES" value="4096"/>
			<member name="PURPLE_MESSAGE_NOTIFY" value="8192"/>
			<member name="PURPLE_MESSAGE_NO_LINKIFY" value="16384"/>
			<member name="PURPLE_MESSAGE_INVISIBLE" value="32768"/>
		</enum>
		<enum name="PurpleNotifyMsgType">
			<member name="PURPLE_NOTIFY_MSG_ERROR" value="0"/>
			<member name="PURPLE_NOTIFY_MSG_WARNING" value="1"/>
			<member name="PURPLE_NOTIFY_MSG_INFO" value="2"/>
		</enum>
		<enum name="PurpleNotifySearchButtonType">
			<member name="PURPLE_NOTIFY_BUTTON_LABELED" value="0"/>
			<member name="PURPLE_NOTIFY_BUTTON_CONTINUE" value="1"/>
			<member name="PURPLE_NOTIFY_BUTTON_ADD" value="2"/>
			<member name="PURPLE_NOTIFY_BUTTON_INFO" value="3"/>
			<member name="PURPLE_NOTIFY_BUTTON_IM" value="4"/>
			<member name="PURPLE_NOTIFY_BUTTON_JOIN" value="5"/>
			<member name="PURPLE_NOTIFY_BUTTON_INVITE" value="6"/>
		</enum>
		<enum name="PurpleNotifyType">
			<member name="PURPLE_NOTIFY_MESSAGE" value="0"/>
			<member name="PURPLE_NOTIFY_EMAIL" value="1"/>
			<member name="PURPLE_NOTIFY_EMAILS" value="2"/>
			<member name="PURPLE_NOTIFY_FORMATTED" value="3"/>
			<member name="PURPLE_NOTIFY_SEARCHRESULTS" value="4"/>
			<member name="PURPLE_NOTIFY_USERINFO" value="5"/>
			<member name="PURPLE_NOTIFY_URI" value="6"/>
		</enum>
		<enum name="PurpleNotifyUserInfoEntryType">
			<member name="PURPLE_NOTIFY_USER_INFO_ENTRY_PAIR" value="0"/>
			<member name="PURPLE_NOTIFY_USER_INFO_ENTRY_SECTION_BREAK" value="1"/>
			<member name="PURPLE_NOTIFY_USER_INFO_ENTRY_SECTION_HEADER" value="2"/>
		</enum>
		<enum name="PurplePluginPrefType">
			<member name="PURPLE_PLUGIN_PREF_NONE" value="0"/>
			<member name="PURPLE_PLUGIN_PREF_CHOICE" value="1"/>
			<member name="PURPLE_PLUGIN_PREF_INFO" value="2"/>
			<member name="PURPLE_PLUGIN_PREF_STRING_FORMAT" value="3"/>
		</enum>
		<enum name="PurplePluginType">
			<member name="PURPLE_PLUGIN_UNKNOWN" value="-1"/>
			<member name="PURPLE_PLUGIN_STANDARD" value="0"/>
			<member name="PURPLE_PLUGIN_LOADER" value="1"/>
			<member name="PURPLE_PLUGIN_PROTOCOL" value="2"/>
		</enum>
		<enum name="PurplePmpType">
			<member name="PURPLE_PMP_TYPE_UDP" value="0"/>
			<member name="PURPLE_PMP_TYPE_TCP" value="1"/>
		</enum>
		<enum name="PurplePounceEvent">
			<member name="PURPLE_POUNCE_NONE" value="0"/>
			<member name="PURPLE_POUNCE_SIGNON" value="1"/>
			<member name="PURPLE_POUNCE_SIGNOFF" value="2"/>
			<member name="PURPLE_POUNCE_AWAY" value="4"/>
			<member name="PURPLE_POUNCE_AWAY_RETURN" value="8"/>
			<member name="PURPLE_POUNCE_IDLE" value="16"/>
			<member name="PURPLE_POUNCE_IDLE_RETURN" value="32"/>
			<member name="PURPLE_POUNCE_TYPING" value="64"/>
			<member name="PURPLE_POUNCE_TYPED" value="128"/>
			<member name="PURPLE_POUNCE_TYPING_STOPPED" value="256"/>
			<member name="PURPLE_POUNCE_MESSAGE_RECEIVED" value="512"/>
		</enum>
		<enum name="PurplePounceOption">
			<member name="PURPLE_POUNCE_OPTION_NONE" value="0"/>
			<member name="PURPLE_POUNCE_OPTION_AWAY" value="1"/>
		</enum>
		<enum name="PurplePrefType">
			<member name="PURPLE_PREF_NONE" value="0"/>
			<member name="PURPLE_PREF_BOOLEAN" value="1"/>
			<member name="PURPLE_PREF_INT" value="2"/>
			<member name="PURPLE_PREF_STRING" value="3"/>
			<member name="PURPLE_PREF_STRING_LIST" value="4"/>
			<member name="PURPLE_PREF_PATH" value="5"/>
			<member name="PURPLE_PREF_PATH_LIST" value="6"/>
		</enum>
		<enum name="PurplePresenceContext">
			<member name="PURPLE_PRESENCE_CONTEXT_UNSET" value="0"/>
			<member name="PURPLE_PRESENCE_CONTEXT_ACCOUNT" value="1"/>
			<member name="PURPLE_PRESENCE_CONTEXT_CONV" value="2"/>
			<member name="PURPLE_PRESENCE_CONTEXT_BUDDY" value="3"/>
		</enum>
		<enum name="PurplePrivacyType">
			<member name="PURPLE_PRIVACY_ALLOW_ALL" value="1"/>
			<member name="PURPLE_PRIVACY_DENY_ALL" value="2"/>
			<member name="PURPLE_PRIVACY_ALLOW_USERS" value="3"/>
			<member name="PURPLE_PRIVACY_DENY_USERS" value="4"/>
			<member name="PURPLE_PRIVACY_ALLOW_BUDDYLIST" value="5"/>
		</enum>
		<enum name="PurpleProtocolOptions">
			<member name="OPT_PROTO_UNIQUE_CHATNAME" value="4"/>
			<member name="OPT_PROTO_CHAT_TOPIC" value="8"/>
			<member name="OPT_PROTO_NO_PASSWORD" value="16"/>
			<member name="OPT_PROTO_MAIL_CHECK" value="32"/>
			<member name="OPT_PROTO_IM_IMAGE" value="64"/>
			<member name="OPT_PROTO_PASSWORD_OPTIONAL" value="128"/>
			<member name="OPT_PROTO_USE_POINTSIZE" value="256"/>
			<member name="OPT_PROTO_REGISTER_NOSCREENNAME" value="512"/>
			<member name="OPT_PROTO_SLASH_COMMANDS_NATIVE" value="1024"/>
		</enum>
		<enum name="PurpleProxyType">
			<member name="PURPLE_PROXY_USE_GLOBAL" value="-1"/>
			<member name="PURPLE_PROXY_NONE" value="0"/>
			<member name="PURPLE_PROXY_HTTP" value="1"/>
			<member name="PURPLE_PROXY_SOCKS4" value="2"/>
			<member name="PURPLE_PROXY_SOCKS5" value="3"/>
			<member name="PURPLE_PROXY_USE_ENVVAR" value="4"/>
		</enum>
		<enum name="PurpleRequestFieldType">
			<member name="PURPLE_REQUEST_FIELD_NONE" value="0"/>
			<member name="PURPLE_REQUEST_FIELD_STRING" value="1"/>
			<member name="PURPLE_REQUEST_FIELD_INTEGER" value="2"/>
			<member name="PURPLE_REQUEST_FIELD_BOOLEAN" value="3"/>
			<member name="PURPLE_REQUEST_FIELD_CHOICE" value="4"/>
			<member name="PURPLE_REQUEST_FIELD_LIST" value="5"/>
			<member name="PURPLE_REQUEST_FIELD_LABEL" value="6"/>
			<member name="PURPLE_REQUEST_FIELD_IMAGE" value="7"/>
			<member name="PURPLE_REQUEST_FIELD_ACCOUNT" value="8"/>
		</enum>
		<enum name="PurpleRequestType">
			<member name="PURPLE_REQUEST_INPUT" value="0"/>
			<member name="PURPLE_REQUEST_CHOICE" value="1"/>
			<member name="PURPLE_REQUEST_ACTION" value="2"/>
			<member name="PURPLE_REQUEST_FIELDS" value="3"/>
			<member name="PURPLE_REQUEST_FILE" value="4"/>
			<member name="PURPLE_REQUEST_FOLDER" value="5"/>
		</enum>
		<enum name="PurpleRoomlistFieldType">
			<member name="PURPLE_ROOMLIST_FIELD_BOOL" value="0"/>
			<member name="PURPLE_ROOMLIST_FIELD_INT" value="1"/>
			<member name="PURPLE_ROOMLIST_FIELD_STRING" value="2"/>
		</enum>
		<enum name="PurpleRoomlistRoomType">
			<member name="PURPLE_ROOMLIST_ROOMTYPE_CATEGORY" value="1"/>
			<member name="PURPLE_ROOMLIST_ROOMTYPE_ROOM" value="2"/>
		</enum>
		<enum name="PurpleSoundEventID">
			<member name="PURPLE_SOUND_BUDDY_ARRIVE" value="0"/>
			<member name="PURPLE_SOUND_BUDDY_LEAVE" value="1"/>
			<member name="PURPLE_SOUND_RECEIVE" value="2"/>
			<member name="PURPLE_SOUND_FIRST_RECEIVE" value="3"/>
			<member name="PURPLE_SOUND_SEND" value="4"/>
			<member name="PURPLE_SOUND_CHAT_JOIN" value="5"/>
			<member name="PURPLE_SOUND_CHAT_LEAVE" value="6"/>
			<member name="PURPLE_SOUND_CHAT_YOU_SAY" value="7"/>
			<member name="PURPLE_SOUND_CHAT_SAY" value="8"/>
			<member name="PURPLE_SOUND_POUNCE_DEFAULT" value="9"/>
			<member name="PURPLE_SOUND_CHAT_NICK" value="10"/>
			<member name="PURPLE_NUM_SOUNDS" value="11"/>
		</enum>
		<enum name="PurpleSslErrorType">
			<member name="PURPLE_SSL_HANDSHAKE_FAILED" value="1"/>
			<member name="PURPLE_SSL_CONNECT_FAILED" value="2"/>
			<member name="PURPLE_SSL_CERTIFICATE_INVALID" value="3"/>
		</enum>
		<enum name="PurpleStatusPrimitive">
			<member name="PURPLE_STATUS_UNSET" value="0"/>
			<member name="PURPLE_STATUS_OFFLINE" value="1"/>
			<member name="PURPLE_STATUS_AVAILABLE" value="2"/>
			<member name="PURPLE_STATUS_UNAVAILABLE" value="3"/>
			<member name="PURPLE_STATUS_INVISIBLE" value="4"/>
			<member name="PURPLE_STATUS_AWAY" value="5"/>
			<member name="PURPLE_STATUS_EXTENDED_AWAY" value="6"/>
			<member name="PURPLE_STATUS_MOBILE" value="7"/>
			<member name="PURPLE_STATUS_TUNE" value="8"/>
			<member name="PURPLE_STATUS_NUM_PRIMITIVES" value="9"/>
		</enum>
		<enum name="PurpleStringFormatType">
			<member name="PURPLE_STRING_FORMAT_TYPE_NONE" value="0"/>
			<member name="PURPLE_STRING_FORMAT_TYPE_MULTILINE" value="1"/>
			<member name="PURPLE_STRING_FORMAT_TYPE_HTML" value="2"/>
		</enum>
		<enum name="PurpleStunNatType">
			<member name="PURPLE_STUN_NAT_TYPE_PUBLIC_IP" value="0"/>
			<member name="PURPLE_STUN_NAT_TYPE_UNKNOWN_NAT" value="1"/>
			<member name="PURPLE_STUN_NAT_TYPE_FULL_CONE" value="2"/>
			<member name="PURPLE_STUN_NAT_TYPE_RESTRICTED_CONE" value="3"/>
			<member name="PURPLE_STUN_NAT_TYPE_PORT_RESTRICTED_CONE" value="4"/>
			<member name="PURPLE_STUN_NAT_TYPE_SYMMETRIC" value="5"/>
		</enum>
		<enum name="PurpleStunStatus">
			<member name="PURPLE_STUN_STATUS_UNDISCOVERED" value="-1"/>
			<member name="PURPLE_STUN_STATUS_UNKNOWN" value="0"/>
			<member name="PURPLE_STUN_STATUS_DISCOVERING" value="1"/>
			<member name="PURPLE_STUN_STATUS_DISCOVERED" value="2"/>
		</enum>
		<enum name="PurpleSubType">
			<member name="PURPLE_SUBTYPE_UNKNOWN" value="0"/>
			<member name="PURPLE_SUBTYPE_ACCOUNT" value="1"/>
			<member name="PURPLE_SUBTYPE_BLIST" value="2"/>
			<member name="PURPLE_SUBTYPE_BLIST_BUDDY" value="3"/>
			<member name="PURPLE_SUBTYPE_BLIST_GROUP" value="4"/>
			<member name="PURPLE_SUBTYPE_BLIST_CHAT" value="5"/>
			<member name="PURPLE_SUBTYPE_BUDDY_ICON" value="6"/>
			<member name="PURPLE_SUBTYPE_CONNECTION" value="7"/>
			<member name="PURPLE_SUBTYPE_CONVERSATION" value="8"/>
			<member name="PURPLE_SUBTYPE_PLUGIN" value="9"/>
			<member name="PURPLE_SUBTYPE_BLIST_NODE" value="10"/>
			<member name="PURPLE_SUBTYPE_CIPHER" value="11"/>
			<member name="PURPLE_SUBTYPE_STATUS" value="12"/>
			<member name="PURPLE_SUBTYPE_LOG" value="13"/>
			<member name="PURPLE_SUBTYPE_XFER" value="14"/>
			<member name="PURPLE_SUBTYPE_SAVEDSTATUS" value="15"/>
			<member name="PURPLE_SUBTYPE_XMLNODE" value="16"/>
			<member name="PURPLE_SUBTYPE_USERINFO" value="17"/>
			<member name="PURPLE_SUBTYPE_STORED_IMAGE" value="18"/>
			<member name="PURPLE_SUBTYPE_CERTIFICATEPOOL" value="19"/>
		</enum>
		<enum name="PurpleType">
			<member name="PURPLE_TYPE_UNKNOWN" value="0"/>
			<member name="PURPLE_TYPE_SUBTYPE" value="1"/>
			<member name="PURPLE_TYPE_CHAR" value="2"/>
			<member name="PURPLE_TYPE_UCHAR" value="3"/>
			<member name="PURPLE_TYPE_BOOLEAN" value="4"/>
			<member name="PURPLE_TYPE_SHORT" value="5"/>
			<member name="PURPLE_TYPE_USHORT" value="6"/>
			<member name="PURPLE_TYPE_INT" value="7"/>
			<member name="PURPLE_TYPE_UINT" value="8"/>
			<member name="PURPLE_TYPE_LONG" value="9"/>
			<member name="PURPLE_TYPE_ULONG" value="10"/>
			<member name="PURPLE_TYPE_INT64" value="11"/>
			<member name="PURPLE_TYPE_UINT64" value="12"/>
			<member name="PURPLE_TYPE_STRING" value="13"/>
			<member name="PURPLE_TYPE_OBJECT" value="14"/>
			<member name="PURPLE_TYPE_POINTER" value="15"/>
			<member name="PURPLE_TYPE_ENUM" value="16"/>
			<member name="PURPLE_TYPE_BOXED" value="17"/>
		</enum>
		<enum name="PurpleTypingState">
			<member name="PURPLE_NOT_TYPING" value="0"/>
			<member name="PURPLE_TYPING" value="1"/>
			<member name="PURPLE_TYPED" value="2"/>
		</enum>
		<enum name="PurpleXferStatusType">
			<member name="PURPLE_XFER_STATUS_UNKNOWN" value="0"/>
			<member name="PURPLE_XFER_STATUS_NOT_STARTED" value="1"/>
			<member name="PURPLE_XFER_STATUS_ACCEPTED" value="2"/>
			<member name="PURPLE_XFER_STATUS_STARTED" value="3"/>
			<member name="PURPLE_XFER_STATUS_DONE" value="4"/>
			<member name="PURPLE_XFER_STATUS_CANCEL_LOCAL" value="5"/>
			<member name="PURPLE_XFER_STATUS_CANCEL_REMOTE" value="6"/>
		</enum>
		<enum name="PurpleXferType">
			<member name="PURPLE_XFER_UNKNOWN" value="0"/>
			<member name="PURPLE_XFER_SEND" value="1"/>
			<member name="PURPLE_XFER_RECEIVE" value="2"/>
		</enum>
		<enum name="XMLNodeType">
			<member name="XMLNODE_TYPE_TAG" value="0"/>
			<member name="XMLNODE_TYPE_ATTRIB" value="1"/>
			<member name="XMLNODE_TYPE_DATA" value="2"/>
		</enum>
		<constant name="DBUS_INTERFACE_PURPLE" type="char*" value="im.pidgin.purple.PurpleInterface"/>
		<constant name="DBUS_PATH_PURPLE" type="char*" value="/im/pidgin/purple/PurpleObject"/>
		<constant name="DBUS_SERVICE_PURPLE" type="char*" value="im.pidgin.purple.PurpleService"/>
		<constant name="GAIM_DESKTOP_ITEM_ACTIONS" type="char*" value="Actions"/>
		<constant name="GAIM_DESKTOP_ITEM_COMMENT" type="char*" value="Comment"/>
		<constant name="GAIM_DESKTOP_ITEM_DEFAULT_APP" type="char*" value="DefaultApp"/>
		<constant name="GAIM_DESKTOP_ITEM_DEV" type="char*" value="Dev"/>
		<constant name="GAIM_DESKTOP_ITEM_DOC_PATH" type="char*" value="X-GNOME-DocPath"/>
		<constant name="GAIM_DESKTOP_ITEM_ENCODING" type="char*" value="Encoding"/>
		<constant name="GAIM_DESKTOP_ITEM_EXEC" type="char*" value="Exec"/>
		<constant name="GAIM_DESKTOP_ITEM_FILE_PATTERN" type="char*" value="FilePattern"/>
		<constant name="GAIM_DESKTOP_ITEM_FS_TYPE" type="char*" value="FSType"/>
		<constant name="GAIM_DESKTOP_ITEM_GENERIC_NAME" type="char*" value="GenericName"/>
		<constant name="GAIM_DESKTOP_ITEM_HIDDEN" type="char*" value="Hidden"/>
		<constant name="GAIM_DESKTOP_ITEM_ICON" type="char*" value="Icon"/>
		<constant name="GAIM_DESKTOP_ITEM_MIME_TYPE" type="char*" value="MimeType"/>
		<constant name="GAIM_DESKTOP_ITEM_MINI_ICON" type="char*" value="MiniIcon"/>
		<constant name="GAIM_DESKTOP_ITEM_MOUNT_POINT" type="char*" value="MountPoint"/>
		<constant name="GAIM_DESKTOP_ITEM_NAME" type="char*" value="Name"/>
		<constant name="GAIM_DESKTOP_ITEM_NO_DISPLAY" type="char*" value="NoDisplay"/>
		<constant name="GAIM_DESKTOP_ITEM_PATH" type="char*" value="Path"/>
		<constant name="GAIM_DESKTOP_ITEM_PATTERNS" type="char*" value="Patterns"/>
		<constant name="GAIM_DESKTOP_ITEM_READ_ONLY" type="char*" value="ReadOnly"/>
		<constant name="GAIM_DESKTOP_ITEM_SORT_ORDER" type="char*" value="SortOrder"/>
		<constant name="GAIM_DESKTOP_ITEM_SWALLOW_EXEC" type="char*" value="SwallowExec"/>
		<constant name="GAIM_DESKTOP_ITEM_SWALLOW_TITLE" type="char*" value="SwallowTitle"/>
		<constant name="GAIM_DESKTOP_ITEM_TERMINAL" type="char*" value="Terminal"/>
		<constant name="GAIM_DESKTOP_ITEM_TERMINAL_OPTIONS" type="char*" value="TerminalOptions"/>
		<constant name="GAIM_DESKTOP_ITEM_TRY_EXEC" type="char*" value="TryExec"/>
		<constant name="GAIM_DESKTOP_ITEM_TYPE" type="char*" value="Type"/>
		<constant name="GAIM_DESKTOP_ITEM_UNMOUNT_ICON" type="char*" value="UnmountIcon"/>
		<constant name="GAIM_DESKTOP_ITEM_URL" type="char*" value="URL"/>
		<constant name="GAIM_DESKTOP_ITEM_VERSION" type="char*" value="Version"/>
		<constant name="PURPLE_DEFAULT_ACTION_NONE" type="int" value="-1"/>
		<constant name="PURPLE_DESKTOP_ITEM_ACTIONS" type="char*" value="Actions"/>
		<constant name="PURPLE_DESKTOP_ITEM_COMMENT" type="char*" value="Comment"/>
		<constant name="PURPLE_DESKTOP_ITEM_DEFAULT_APP" type="char*" value="DefaultApp"/>
		<constant name="PURPLE_DESKTOP_ITEM_DEV" type="char*" value="Dev"/>
		<constant name="PURPLE_DESKTOP_ITEM_DOC_PATH" type="char*" value="X-GNOME-DocPath"/>
		<constant name="PURPLE_DESKTOP_ITEM_ENCODING" type="char*" value="Encoding"/>
		<constant name="PURPLE_DESKTOP_ITEM_EXEC" type="char*" value="Exec"/>
		<constant name="PURPLE_DESKTOP_ITEM_FILE_PATTERN" type="char*" value="FilePattern"/>
		<constant name="PURPLE_DESKTOP_ITEM_FS_TYPE" type="char*" value="FSType"/>
		<constant name="PURPLE_DESKTOP_ITEM_GENERIC_NAME" type="char*" value="GenericName"/>
		<constant name="PURPLE_DESKTOP_ITEM_HIDDEN" type="char*" value="Hidden"/>
		<constant name="PURPLE_DESKTOP_ITEM_ICON" type="char*" value="Icon"/>
		<constant name="PURPLE_DESKTOP_ITEM_MIME_TYPE" type="char*" value="MimeType"/>
		<constant name="PURPLE_DESKTOP_ITEM_MINI_ICON" type="char*" value="MiniIcon"/>
		<constant name="PURPLE_DESKTOP_ITEM_MOUNT_POINT" type="char*" value="MountPoint"/>
		<constant name="PURPLE_DESKTOP_ITEM_NAME" type="char*" value="Name"/>
		<constant name="PURPLE_DESKTOP_ITEM_NO_DISPLAY" type="char*" value="NoDisplay"/>
		<constant name="PURPLE_DESKTOP_ITEM_PATH" type="char*" value="Path"/>
		<constant name="PURPLE_DESKTOP_ITEM_PATTERNS" type="char*" value="Patterns"/>
		<constant name="PURPLE_DESKTOP_ITEM_READ_ONLY" type="char*" value="ReadOnly"/>
		<constant name="PURPLE_DESKTOP_ITEM_SORT_ORDER" type="char*" value="SortOrder"/>
		<constant name="PURPLE_DESKTOP_ITEM_SWALLOW_EXEC" type="char*" value="SwallowExec"/>
		<constant name="PURPLE_DESKTOP_ITEM_SWALLOW_TITLE" type="char*" value="SwallowTitle"/>
		<constant name="PURPLE_DESKTOP_ITEM_TERMINAL" type="char*" value="Terminal"/>
		<constant name="PURPLE_DESKTOP_ITEM_TERMINAL_OPTIONS" type="char*" value="TerminalOptions"/>
		<constant name="PURPLE_DESKTOP_ITEM_TRY_EXEC" type="char*" value="TryExec"/>
		<constant name="PURPLE_DESKTOP_ITEM_TYPE" type="char*" value="Type"/>
		<constant name="PURPLE_DESKTOP_ITEM_UNMOUNT_ICON" type="char*" value="UnmountIcon"/>
		<constant name="PURPLE_DESKTOP_ITEM_URL" type="char*" value="URL"/>
		<constant name="PURPLE_DESKTOP_ITEM_VERSION" type="char*" value="Version"/>
		<constant name="PURPLE_MAJOR_VERSION" type="int" value="2"/>
		<constant name="PURPLE_MICRO_VERSION" type="int" value="6"/>
		<constant name="PURPLE_MINOR_VERSION" type="int" value="6"/>
		<constant name="PURPLE_NO_TZ_OFF" type="int" value="-500000"/>
		<constant name="PURPLE_PLUGINS" type="int" value="1"/>
		<constant name="PURPLE_PLUGIN_FLAG_INVISIBLE" type="int" value="1"/>
		<constant name="PURPLE_PLUGIN_MAGIC" type="int" value="5"/>
		<constant name="PURPLE_PMP_LIFETIME" type="int" value="3600"/>
		<constant name="PURPLE_PRIORITY_DEFAULT" type="int" value="0"/>
		<constant name="PURPLE_PRIORITY_HIGHEST" type="int" value="9999"/>
		<constant name="PURPLE_PRIORITY_LOWEST" type="int" value="-9999"/>
		<constant name="PURPLE_SIGNAL_PRIORITY_DEFAULT" type="int" value="0"/>
		<constant name="PURPLE_SIGNAL_PRIORITY_HIGHEST" type="int" value="9999"/>
		<constant name="PURPLE_SIGNAL_PRIORITY_LOWEST" type="int" value="-9999"/>
		<constant name="PURPLE_SSL_DEFAULT_PORT" type="int" value="443"/>
		<constant name="PURPLE_TUNE_ALBUM" type="char*" value="tune_album"/>
		<constant name="PURPLE_TUNE_ARTIST" type="char*" value="tune_artist"/>
		<constant name="PURPLE_TUNE_COMMENT" type="char*" value="tune_comment"/>
		<constant name="PURPLE_TUNE_FULL" type="char*" value="tune_full"/>
		<constant name="PURPLE_TUNE_GENRE" type="char*" value="tune_genre"/>
		<constant name="PURPLE_TUNE_TIME" type="char*" value="tune_time"/>
		<constant name="PURPLE_TUNE_TITLE" type="char*" value="tune_title"/>
		<constant name="PURPLE_TUNE_TRACK" type="char*" value="tune_track"/>
		<constant name="PURPLE_TUNE_URL" type="char*" value="tune_url"/>
		<constant name="PURPLE_TUNE_YEAR" type="char*" value="tune_year"/>
	</namespace>
</api>
