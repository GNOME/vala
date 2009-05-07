<?xml version="1.0"?>
<api version="1.0">
	<namespace name="GnomeKeyring">
		<function name="acl_copy" symbol="gnome_keyring_acl_copy">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="list" type="GList*"/>
			</parameters>
		</function>
		<function name="acl_free" symbol="gnome_keyring_acl_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="acl" type="GList*"/>
			</parameters>
		</function>
		<function name="cancel_request" symbol="gnome_keyring_cancel_request">
			<return-type type="void"/>
			<parameters>
				<parameter name="request" type="gpointer"/>
			</parameters>
		</function>
		<function name="change_password" symbol="gnome_keyring_change_password">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="original" type="char*"/>
				<parameter name="password" type="char*"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="change_password_sync" symbol="gnome_keyring_change_password_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="original" type="char*"/>
				<parameter name="password" type="char*"/>
			</parameters>
		</function>
		<function name="create" symbol="gnome_keyring_create">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring_name" type="char*"/>
				<parameter name="password" type="char*"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="create_sync" symbol="gnome_keyring_create_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring_name" type="char*"/>
				<parameter name="password" type="char*"/>
			</parameters>
		</function>
		<function name="daemon_prepare_environment_sync" symbol="gnome_keyring_daemon_prepare_environment_sync">
			<return-type type="GnomeKeyringResult"/>
		</function>
		<function name="daemon_set_display_sync" symbol="gnome_keyring_daemon_set_display_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="display" type="char*"/>
			</parameters>
		</function>
		<function name="delete" symbol="gnome_keyring_delete">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="delete_password" symbol="gnome_keyring_delete_password">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="schema" type="GnomeKeyringPasswordSchema*"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="delete_password_sync" symbol="gnome_keyring_delete_password_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="schema" type="GnomeKeyringPasswordSchema*"/>
			</parameters>
		</function>
		<function name="delete_sync" symbol="gnome_keyring_delete_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
			</parameters>
		</function>
		<function name="find_items" symbol="gnome_keyring_find_items">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="type" type="GnomeKeyringItemType"/>
				<parameter name="attributes" type="GnomeKeyringAttributeList*"/>
				<parameter name="callback" type="GnomeKeyringOperationGetListCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="find_items_sync" symbol="gnome_keyring_find_items_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="type" type="GnomeKeyringItemType"/>
				<parameter name="attributes" type="GnomeKeyringAttributeList*"/>
				<parameter name="found" type="GList**"/>
			</parameters>
		</function>
		<function name="find_itemsv" symbol="gnome_keyring_find_itemsv">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="type" type="GnomeKeyringItemType"/>
				<parameter name="callback" type="GnomeKeyringOperationGetListCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="find_itemsv_sync" symbol="gnome_keyring_find_itemsv_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="type" type="GnomeKeyringItemType"/>
				<parameter name="found" type="GList**"/>
			</parameters>
		</function>
		<function name="find_network_password" symbol="gnome_keyring_find_network_password">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="user" type="char*"/>
				<parameter name="domain" type="char*"/>
				<parameter name="server" type="char*"/>
				<parameter name="object" type="char*"/>
				<parameter name="protocol" type="char*"/>
				<parameter name="authtype" type="char*"/>
				<parameter name="port" type="guint32"/>
				<parameter name="callback" type="GnomeKeyringOperationGetListCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="find_network_password_sync" symbol="gnome_keyring_find_network_password_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="user" type="char*"/>
				<parameter name="domain" type="char*"/>
				<parameter name="server" type="char*"/>
				<parameter name="object" type="char*"/>
				<parameter name="protocol" type="char*"/>
				<parameter name="authtype" type="char*"/>
				<parameter name="port" type="guint32"/>
				<parameter name="results" type="GList**"/>
			</parameters>
		</function>
		<function name="find_password" symbol="gnome_keyring_find_password">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="schema" type="GnomeKeyringPasswordSchema*"/>
				<parameter name="callback" type="GnomeKeyringOperationGetStringCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="find_password_sync" symbol="gnome_keyring_find_password_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="schema" type="GnomeKeyringPasswordSchema*"/>
				<parameter name="password" type="gchar**"/>
			</parameters>
		</function>
		<function name="free_password" symbol="gnome_keyring_free_password">
			<return-type type="void"/>
			<parameters>
				<parameter name="password" type="gchar*"/>
			</parameters>
		</function>
		<function name="get_default_keyring" symbol="gnome_keyring_get_default_keyring">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="callback" type="GnomeKeyringOperationGetStringCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="get_default_keyring_sync" symbol="gnome_keyring_get_default_keyring_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char**"/>
			</parameters>
		</function>
		<function name="get_info" symbol="gnome_keyring_get_info">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="callback" type="GnomeKeyringOperationGetKeyringInfoCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="get_info_sync" symbol="gnome_keyring_get_info_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="info" type="GnomeKeyringInfo**"/>
			</parameters>
		</function>
		<function name="is_available" symbol="gnome_keyring_is_available">
			<return-type type="gboolean"/>
		</function>
		<function name="item_ac_get_access_type" symbol="gnome_keyring_item_ac_get_access_type">
			<return-type type="GnomeKeyringAccessType"/>
			<parameters>
				<parameter name="ac" type="GnomeKeyringAccessControl*"/>
			</parameters>
		</function>
		<function name="item_ac_get_display_name" symbol="gnome_keyring_item_ac_get_display_name">
			<return-type type="char*"/>
			<parameters>
				<parameter name="ac" type="GnomeKeyringAccessControl*"/>
			</parameters>
		</function>
		<function name="item_ac_get_path_name" symbol="gnome_keyring_item_ac_get_path_name">
			<return-type type="char*"/>
			<parameters>
				<parameter name="ac" type="GnomeKeyringAccessControl*"/>
			</parameters>
		</function>
		<function name="item_ac_set_access_type" symbol="gnome_keyring_item_ac_set_access_type">
			<return-type type="void"/>
			<parameters>
				<parameter name="ac" type="GnomeKeyringAccessControl*"/>
				<parameter name="value" type="GnomeKeyringAccessType"/>
			</parameters>
		</function>
		<function name="item_ac_set_display_name" symbol="gnome_keyring_item_ac_set_display_name">
			<return-type type="void"/>
			<parameters>
				<parameter name="ac" type="GnomeKeyringAccessControl*"/>
				<parameter name="value" type="char*"/>
			</parameters>
		</function>
		<function name="item_ac_set_path_name" symbol="gnome_keyring_item_ac_set_path_name">
			<return-type type="void"/>
			<parameters>
				<parameter name="ac" type="GnomeKeyringAccessControl*"/>
				<parameter name="value" type="char*"/>
			</parameters>
		</function>
		<function name="item_create" symbol="gnome_keyring_item_create">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="type" type="GnomeKeyringItemType"/>
				<parameter name="display_name" type="char*"/>
				<parameter name="attributes" type="GnomeKeyringAttributeList*"/>
				<parameter name="secret" type="char*"/>
				<parameter name="update_if_exists" type="gboolean"/>
				<parameter name="callback" type="GnomeKeyringOperationGetIntCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="item_create_sync" symbol="gnome_keyring_item_create_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="type" type="GnomeKeyringItemType"/>
				<parameter name="display_name" type="char*"/>
				<parameter name="attributes" type="GnomeKeyringAttributeList*"/>
				<parameter name="secret" type="char*"/>
				<parameter name="update_if_exists" type="gboolean"/>
				<parameter name="item_id" type="guint32*"/>
			</parameters>
		</function>
		<function name="item_delete" symbol="gnome_keyring_item_delete">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="item_delete_sync" symbol="gnome_keyring_item_delete_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
			</parameters>
		</function>
		<function name="item_get_acl" symbol="gnome_keyring_item_get_acl">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="callback" type="GnomeKeyringOperationGetListCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="item_get_acl_sync" symbol="gnome_keyring_item_get_acl_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="acl" type="GList**"/>
			</parameters>
		</function>
		<function name="item_get_attributes" symbol="gnome_keyring_item_get_attributes">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="callback" type="GnomeKeyringOperationGetAttributesCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="item_get_attributes_sync" symbol="gnome_keyring_item_get_attributes_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="attributes" type="GnomeKeyringAttributeList**"/>
			</parameters>
		</function>
		<function name="item_get_info" symbol="gnome_keyring_item_get_info">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="callback" type="GnomeKeyringOperationGetItemInfoCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="item_get_info_full" symbol="gnome_keyring_item_get_info_full">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="flags" type="guint32"/>
				<parameter name="callback" type="GnomeKeyringOperationGetItemInfoCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="item_get_info_full_sync" symbol="gnome_keyring_item_get_info_full_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="flags" type="guint32"/>
				<parameter name="info" type="GnomeKeyringItemInfo**"/>
			</parameters>
		</function>
		<function name="item_get_info_sync" symbol="gnome_keyring_item_get_info_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="info" type="GnomeKeyringItemInfo**"/>
			</parameters>
		</function>
		<function name="item_grant_access_rights" symbol="gnome_keyring_item_grant_access_rights">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="gchar*"/>
				<parameter name="display_name" type="gchar*"/>
				<parameter name="full_path" type="gchar*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="rights" type="GnomeKeyringAccessType"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="item_grant_access_rights_sync" symbol="gnome_keyring_item_grant_access_rights_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="display_name" type="char*"/>
				<parameter name="full_path" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="rights" type="GnomeKeyringAccessType"/>
			</parameters>
		</function>
		<function name="item_set_acl" symbol="gnome_keyring_item_set_acl">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="acl" type="GList*"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="item_set_acl_sync" symbol="gnome_keyring_item_set_acl_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="acl" type="GList*"/>
			</parameters>
		</function>
		<function name="item_set_attributes" symbol="gnome_keyring_item_set_attributes">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="attributes" type="GnomeKeyringAttributeList*"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="item_set_attributes_sync" symbol="gnome_keyring_item_set_attributes_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="attributes" type="GnomeKeyringAttributeList*"/>
			</parameters>
		</function>
		<function name="item_set_info" symbol="gnome_keyring_item_set_info">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="info" type="GnomeKeyringItemInfo*"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="item_set_info_sync" symbol="gnome_keyring_item_set_info_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="id" type="guint32"/>
				<parameter name="info" type="GnomeKeyringItemInfo*"/>
			</parameters>
		</function>
		<function name="list_item_ids" symbol="gnome_keyring_list_item_ids">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="callback" type="GnomeKeyringOperationGetListCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="list_item_ids_sync" symbol="gnome_keyring_list_item_ids_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="ids" type="GList**"/>
			</parameters>
		</function>
		<function name="list_keyring_names" symbol="gnome_keyring_list_keyring_names">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="callback" type="GnomeKeyringOperationGetListCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="list_keyring_names_sync" symbol="gnome_keyring_list_keyring_names_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyrings" type="GList**"/>
			</parameters>
		</function>
		<function name="lock" symbol="gnome_keyring_lock">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="lock_all" symbol="gnome_keyring_lock_all">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="lock_all_sync" symbol="gnome_keyring_lock_all_sync">
			<return-type type="GnomeKeyringResult"/>
		</function>
		<function name="lock_sync" symbol="gnome_keyring_lock_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
			</parameters>
		</function>
		<function name="memory_alloc" symbol="gnome_keyring_memory_alloc">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="sz" type="gulong"/>
			</parameters>
		</function>
		<function name="memory_free" symbol="gnome_keyring_memory_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="p" type="gpointer"/>
			</parameters>
		</function>
		<function name="memory_is_secure" symbol="gnome_keyring_memory_is_secure">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="p" type="gpointer"/>
			</parameters>
		</function>
		<function name="memory_realloc" symbol="gnome_keyring_memory_realloc">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="p" type="gpointer"/>
				<parameter name="sz" type="gulong"/>
			</parameters>
		</function>
		<function name="memory_strdup" symbol="gnome_keyring_memory_strdup">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="memory_try_alloc" symbol="gnome_keyring_memory_try_alloc">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="sz" type="gulong"/>
			</parameters>
		</function>
		<function name="memory_try_realloc" symbol="gnome_keyring_memory_try_realloc">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="p" type="gpointer"/>
				<parameter name="sz" type="gulong"/>
			</parameters>
		</function>
		<function name="network_password_free" symbol="gnome_keyring_network_password_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="data" type="GnomeKeyringNetworkPasswordData*"/>
			</parameters>
		</function>
		<function name="network_password_list_free" symbol="gnome_keyring_network_password_list_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GList*"/>
			</parameters>
		</function>
		<function name="result_to_message" symbol="gnome_keyring_result_to_message">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="res" type="GnomeKeyringResult"/>
			</parameters>
		</function>
		<function name="set_default_keyring" symbol="gnome_keyring_set_default_keyring">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="set_default_keyring_sync" symbol="gnome_keyring_set_default_keyring_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
			</parameters>
		</function>
		<function name="set_info" symbol="gnome_keyring_set_info">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="info" type="GnomeKeyringInfo*"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="set_info_sync" symbol="gnome_keyring_set_info_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="info" type="GnomeKeyringInfo*"/>
			</parameters>
		</function>
		<function name="set_network_password" symbol="gnome_keyring_set_network_password">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="user" type="char*"/>
				<parameter name="domain" type="char*"/>
				<parameter name="server" type="char*"/>
				<parameter name="object" type="char*"/>
				<parameter name="protocol" type="char*"/>
				<parameter name="authtype" type="char*"/>
				<parameter name="port" type="guint32"/>
				<parameter name="password" type="char*"/>
				<parameter name="callback" type="GnomeKeyringOperationGetIntCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="set_network_password_sync" symbol="gnome_keyring_set_network_password_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="user" type="char*"/>
				<parameter name="domain" type="char*"/>
				<parameter name="server" type="char*"/>
				<parameter name="object" type="char*"/>
				<parameter name="protocol" type="char*"/>
				<parameter name="authtype" type="char*"/>
				<parameter name="port" type="guint32"/>
				<parameter name="password" type="char*"/>
				<parameter name="item_id" type="guint32*"/>
			</parameters>
		</function>
		<function name="store_password" symbol="gnome_keyring_store_password">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="schema" type="GnomeKeyringPasswordSchema*"/>
				<parameter name="keyring" type="gchar*"/>
				<parameter name="display_name" type="gchar*"/>
				<parameter name="password" type="gchar*"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="store_password_sync" symbol="gnome_keyring_store_password_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="schema" type="GnomeKeyringPasswordSchema*"/>
				<parameter name="keyring" type="gchar*"/>
				<parameter name="display_name" type="gchar*"/>
				<parameter name="password" type="gchar*"/>
			</parameters>
		</function>
		<function name="string_list_free" symbol="gnome_keyring_string_list_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="strings" type="GList*"/>
			</parameters>
		</function>
		<function name="unlock" symbol="gnome_keyring_unlock">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="password" type="char*"/>
				<parameter name="callback" type="GnomeKeyringOperationDoneCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy_data" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="unlock_sync" symbol="gnome_keyring_unlock_sync">
			<return-type type="GnomeKeyringResult"/>
			<parameters>
				<parameter name="keyring" type="char*"/>
				<parameter name="password" type="char*"/>
			</parameters>
		</function>
		<callback name="GnomeKeyringOperationDoneCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="result" type="GnomeKeyringResult"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeKeyringOperationGetAttributesCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="result" type="GnomeKeyringResult"/>
				<parameter name="attributes" type="GnomeKeyringAttributeList*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeKeyringOperationGetIntCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="result" type="GnomeKeyringResult"/>
				<parameter name="val" type="guint32"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeKeyringOperationGetItemInfoCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="result" type="GnomeKeyringResult"/>
				<parameter name="info" type="GnomeKeyringItemInfo*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeKeyringOperationGetKeyringInfoCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="result" type="GnomeKeyringResult"/>
				<parameter name="info" type="GnomeKeyringInfo*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeKeyringOperationGetListCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="result" type="GnomeKeyringResult"/>
				<parameter name="list" type="GList*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeKeyringOperationGetStringCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="result" type="GnomeKeyringResult"/>
				<parameter name="string" type="char*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GnomeKeyringAccessControl">
			<method name="copy" symbol="gnome_keyring_access_control_copy">
				<return-type type="GnomeKeyringAccessControl*"/>
				<parameters>
					<parameter name="ac" type="GnomeKeyringAccessControl*"/>
				</parameters>
			</method>
			<method name="free" symbol="gnome_keyring_access_control_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="ac" type="GnomeKeyringAccessControl*"/>
				</parameters>
			</method>
			<method name="new" symbol="gnome_keyring_access_control_new">
				<return-type type="GnomeKeyringAccessControl*"/>
				<parameters>
					<parameter name="application" type="GnomeKeyringApplicationRef*"/>
					<parameter name="types_allowed" type="GnomeKeyringAccessType"/>
				</parameters>
			</method>
		</struct>
		<struct name="GnomeKeyringApplicationRef">
			<method name="copy" symbol="gnome_keyring_application_ref_copy">
				<return-type type="GnomeKeyringApplicationRef*"/>
				<parameters>
					<parameter name="app" type="GnomeKeyringApplicationRef*"/>
				</parameters>
			</method>
			<method name="free" symbol="gnome_keyring_application_ref_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeKeyringApplicationRef*"/>
				</parameters>
			</method>
			<method name="new" symbol="gnome_keyring_application_ref_new">
				<return-type type="GnomeKeyringApplicationRef*"/>
			</method>
		</struct>
		<struct name="GnomeKeyringAttribute">
			<field name="name" type="char*"/>
			<field name="type" type="GnomeKeyringAttributeType"/>
			<field name="value" type="gpointer"/>
		</struct>
		<struct name="GnomeKeyringAttributeList">
			<method name="append_string" symbol="gnome_keyring_attribute_list_append_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="attributes" type="GnomeKeyringAttributeList*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="append_uint32" symbol="gnome_keyring_attribute_list_append_uint32">
				<return-type type="void"/>
				<parameters>
					<parameter name="attributes" type="GnomeKeyringAttributeList*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="guint32"/>
				</parameters>
			</method>
			<method name="copy" symbol="gnome_keyring_attribute_list_copy">
				<return-type type="GnomeKeyringAttributeList*"/>
				<parameters>
					<parameter name="attributes" type="GnomeKeyringAttributeList*"/>
				</parameters>
			</method>
			<method name="free" symbol="gnome_keyring_attribute_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="attributes" type="GnomeKeyringAttributeList*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GnomeKeyringFound">
			<method name="free" symbol="gnome_keyring_found_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="found" type="GnomeKeyringFound*"/>
				</parameters>
			</method>
			<method name="list_free" symbol="gnome_keyring_found_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="found_list" type="GList*"/>
				</parameters>
			</method>
			<field name="keyring" type="char*"/>
			<field name="item_id" type="guint"/>
			<field name="attributes" type="GnomeKeyringAttributeList*"/>
			<field name="secret" type="char*"/>
		</struct>
		<struct name="GnomeKeyringInfo">
			<method name="copy" symbol="gnome_keyring_info_copy">
				<return-type type="GnomeKeyringInfo*"/>
				<parameters>
					<parameter name="keyring_info" type="GnomeKeyringInfo*"/>
				</parameters>
			</method>
			<method name="free" symbol="gnome_keyring_info_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="keyring_info" type="GnomeKeyringInfo*"/>
				</parameters>
			</method>
			<method name="get_ctime" symbol="gnome_keyring_info_get_ctime">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="keyring_info" type="GnomeKeyringInfo*"/>
				</parameters>
			</method>
			<method name="get_is_locked" symbol="gnome_keyring_info_get_is_locked">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="keyring_info" type="GnomeKeyringInfo*"/>
				</parameters>
			</method>
			<method name="get_lock_on_idle" symbol="gnome_keyring_info_get_lock_on_idle">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="keyring_info" type="GnomeKeyringInfo*"/>
				</parameters>
			</method>
			<method name="get_lock_timeout" symbol="gnome_keyring_info_get_lock_timeout">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="keyring_info" type="GnomeKeyringInfo*"/>
				</parameters>
			</method>
			<method name="get_mtime" symbol="gnome_keyring_info_get_mtime">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="keyring_info" type="GnomeKeyringInfo*"/>
				</parameters>
			</method>
			<method name="set_lock_on_idle" symbol="gnome_keyring_info_set_lock_on_idle">
				<return-type type="void"/>
				<parameters>
					<parameter name="keyring_info" type="GnomeKeyringInfo*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_lock_timeout" symbol="gnome_keyring_info_set_lock_timeout">
				<return-type type="void"/>
				<parameters>
					<parameter name="keyring_info" type="GnomeKeyringInfo*"/>
					<parameter name="value" type="guint32"/>
				</parameters>
			</method>
		</struct>
		<struct name="GnomeKeyringItemInfo">
			<method name="copy" symbol="gnome_keyring_item_info_copy">
				<return-type type="GnomeKeyringItemInfo*"/>
				<parameters>
					<parameter name="item_info" type="GnomeKeyringItemInfo*"/>
				</parameters>
			</method>
			<method name="free" symbol="gnome_keyring_item_info_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="item_info" type="GnomeKeyringItemInfo*"/>
				</parameters>
			</method>
			<method name="get_ctime" symbol="gnome_keyring_item_info_get_ctime">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="item_info" type="GnomeKeyringItemInfo*"/>
				</parameters>
			</method>
			<method name="get_display_name" symbol="gnome_keyring_item_info_get_display_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="item_info" type="GnomeKeyringItemInfo*"/>
				</parameters>
			</method>
			<method name="get_mtime" symbol="gnome_keyring_item_info_get_mtime">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="item_info" type="GnomeKeyringItemInfo*"/>
				</parameters>
			</method>
			<method name="get_secret" symbol="gnome_keyring_item_info_get_secret">
				<return-type type="char*"/>
				<parameters>
					<parameter name="item_info" type="GnomeKeyringItemInfo*"/>
				</parameters>
			</method>
			<method name="new" symbol="gnome_keyring_item_info_new">
				<return-type type="GnomeKeyringItemInfo*"/>
			</method>
			<method name="set_display_name" symbol="gnome_keyring_item_info_set_display_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="item_info" type="GnomeKeyringItemInfo*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_secret" symbol="gnome_keyring_item_info_set_secret">
				<return-type type="void"/>
				<parameters>
					<parameter name="item_info" type="GnomeKeyringItemInfo*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_type" symbol="gnome_keyring_item_info_set_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="item_info" type="GnomeKeyringItemInfo*"/>
					<parameter name="type" type="GnomeKeyringItemType"/>
				</parameters>
			</method>
		</struct>
		<struct name="GnomeKeyringNetworkPasswordData">
			<field name="keyring" type="char*"/>
			<field name="item_id" type="guint32"/>
			<field name="protocol" type="char*"/>
			<field name="server" type="char*"/>
			<field name="object" type="char*"/>
			<field name="authtype" type="char*"/>
			<field name="port" type="guint32"/>
			<field name="user" type="char*"/>
			<field name="domain" type="char*"/>
			<field name="password" type="char*"/>
		</struct>
		<struct name="GnomeKeyringPasswordSchema">
			<field name="item_type" type="GnomeKeyringItemType"/>
			<field name="attributes" type="gpointer[]"/>
			<field name="reserved1" type="gpointer"/>
			<field name="reserved2" type="gpointer"/>
			<field name="reserved3" type="gpointer"/>
		</struct>
		<enum name="GnomeKeyringAccessRestriction">
			<member name="GNOME_KEYRING_ACCESS_ASK" value="0"/>
			<member name="GNOME_KEYRING_ACCESS_DENY" value="1"/>
			<member name="GNOME_KEYRING_ACCESS_ALLOW" value="2"/>
		</enum>
		<enum name="GnomeKeyringAccessType">
			<member name="GNOME_KEYRING_ACCESS_READ" value="1"/>
			<member name="GNOME_KEYRING_ACCESS_WRITE" value="2"/>
			<member name="GNOME_KEYRING_ACCESS_REMOVE" value="4"/>
		</enum>
		<enum name="GnomeKeyringAttributeType">
			<member name="GNOME_KEYRING_ATTRIBUTE_TYPE_STRING" value="0"/>
			<member name="GNOME_KEYRING_ATTRIBUTE_TYPE_UINT32" value="1"/>
		</enum>
		<enum name="GnomeKeyringItemInfoFlags">
			<member name="GNOME_KEYRING_ITEM_INFO_BASICS" value="0"/>
			<member name="GNOME_KEYRING_ITEM_INFO_SECRET" value="1"/>
		</enum>
		<enum name="GnomeKeyringItemType">
			<member name="GNOME_KEYRING_ITEM_GENERIC_SECRET" value="0"/>
			<member name="GNOME_KEYRING_ITEM_NETWORK_PASSWORD" value="1"/>
			<member name="GNOME_KEYRING_ITEM_NOTE" value="2"/>
			<member name="GNOME_KEYRING_ITEM_CHAINED_KEYRING_PASSWORD" value="3"/>
			<member name="GNOME_KEYRING_ITEM_ENCRYPTION_KEY_PASSWORD" value="4"/>
			<member name="GNOME_KEYRING_ITEM_PK_STORAGE" value="256"/>
			<member name="GNOME_KEYRING_ITEM_LAST_TYPE" value="257"/>
		</enum>
		<enum name="GnomeKeyringResult">
			<member name="GNOME_KEYRING_RESULT_OK" value="0"/>
			<member name="GNOME_KEYRING_RESULT_DENIED" value="1"/>
			<member name="GNOME_KEYRING_RESULT_NO_KEYRING_DAEMON" value="2"/>
			<member name="GNOME_KEYRING_RESULT_ALREADY_UNLOCKED" value="3"/>
			<member name="GNOME_KEYRING_RESULT_NO_SUCH_KEYRING" value="4"/>
			<member name="GNOME_KEYRING_RESULT_BAD_ARGUMENTS" value="5"/>
			<member name="GNOME_KEYRING_RESULT_IO_ERROR" value="6"/>
			<member name="GNOME_KEYRING_RESULT_CANCELLED" value="7"/>
			<member name="GNOME_KEYRING_RESULT_KEYRING_ALREADY_EXISTS" value="8"/>
			<member name="GNOME_KEYRING_RESULT_NO_MATCH" value="9"/>
		</enum>
		<constant name="GNOME_KEYRING_ITEM_APPLICATION_SECRET" type="int" value="16777216"/>
		<constant name="GNOME_KEYRING_ITEM_INFO_ALL" type="int" value="0"/>
		<constant name="GNOME_KEYRING_ITEM_TYPE_MASK" type="int" value="65535"/>
		<constant name="GNOME_KEYRING_SESSION" type="char*" value="session"/>
	</namespace>
</api>
