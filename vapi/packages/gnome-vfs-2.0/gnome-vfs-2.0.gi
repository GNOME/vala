<?xml version="1.0"?>
<api version="1.0">
	<namespace name="GnomeVFS">
		<function name="application_is_user_owned_application" symbol="gnome_vfs_application_is_user_owned_application">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="application" type="GnomeVFSMimeApplication*"/>
			</parameters>
		</function>
		<function name="application_registry_add_mime_type" symbol="gnome_vfs_application_registry_add_mime_type">
			<return-type type="void"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_clear_mime_types" symbol="gnome_vfs_application_registry_clear_mime_types">
			<return-type type="void"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_exists" symbol="gnome_vfs_application_registry_exists">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_get_applications" symbol="gnome_vfs_application_registry_get_applications">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_get_bool_value" symbol="gnome_vfs_application_registry_get_bool_value">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
				<parameter name="key" type="char*"/>
				<parameter name="got_key" type="gboolean*"/>
			</parameters>
		</function>
		<function name="application_registry_get_keys" symbol="gnome_vfs_application_registry_get_keys">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_get_mime_application" symbol="gnome_vfs_application_registry_get_mime_application">
			<return-type type="GnomeVFSMimeApplication*"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_get_mime_types" symbol="gnome_vfs_application_registry_get_mime_types">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_peek_value" symbol="gnome_vfs_application_registry_peek_value">
			<return-type type="char*"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
				<parameter name="key" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_reload" symbol="gnome_vfs_application_registry_reload">
			<return-type type="void"/>
		</function>
		<function name="application_registry_remove_application" symbol="gnome_vfs_application_registry_remove_application">
			<return-type type="void"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_remove_mime_type" symbol="gnome_vfs_application_registry_remove_mime_type">
			<return-type type="void"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_save_mime_application" symbol="gnome_vfs_application_registry_save_mime_application">
			<return-type type="void"/>
			<parameters>
				<parameter name="application" type="GnomeVFSMimeApplication*"/>
			</parameters>
		</function>
		<function name="application_registry_set_bool_value" symbol="gnome_vfs_application_registry_set_bool_value">
			<return-type type="void"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
				<parameter name="key" type="char*"/>
				<parameter name="value" type="gboolean"/>
			</parameters>
		</function>
		<function name="application_registry_set_value" symbol="gnome_vfs_application_registry_set_value">
			<return-type type="void"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
				<parameter name="key" type="char*"/>
				<parameter name="value" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_shutdown" symbol="gnome_vfs_application_registry_shutdown">
			<return-type type="void"/>
		</function>
		<function name="application_registry_supports_mime_type" symbol="gnome_vfs_application_registry_supports_mime_type">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_supports_uri_scheme" symbol="gnome_vfs_application_registry_supports_uri_scheme">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
				<parameter name="uri_scheme" type="char*"/>
			</parameters>
		</function>
		<function name="application_registry_sync" symbol="gnome_vfs_application_registry_sync">
			<return-type type="GnomeVFSResult"/>
		</function>
		<function name="application_registry_unset_key" symbol="gnome_vfs_application_registry_unset_key">
			<return-type type="void"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
				<parameter name="key" type="char*"/>
			</parameters>
		</function>
		<function name="async_cancel" symbol="gnome_vfs_async_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
			</parameters>
		</function>
		<function name="async_close" symbol="gnome_vfs_async_close">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="callback" type="GnomeVFSAsyncCloseCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_create" symbol="gnome_vfs_async_create">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="open_mode" type="GnomeVFSOpenMode"/>
				<parameter name="exclusive" type="gboolean"/>
				<parameter name="perm" type="guint"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncOpenCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_create_as_channel" symbol="gnome_vfs_async_create_as_channel">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="open_mode" type="GnomeVFSOpenMode"/>
				<parameter name="exclusive" type="gboolean"/>
				<parameter name="perm" type="guint"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncCreateAsChannelCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_create_symbolic_link" symbol="gnome_vfs_async_create_symbolic_link">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="uri_reference" type="gchar*"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncOpenCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_create_uri" symbol="gnome_vfs_async_create_uri">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="open_mode" type="GnomeVFSOpenMode"/>
				<parameter name="exclusive" type="gboolean"/>
				<parameter name="perm" type="guint"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncOpenCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_create_uri_as_channel" symbol="gnome_vfs_async_create_uri_as_channel">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="open_mode" type="GnomeVFSOpenMode"/>
				<parameter name="exclusive" type="gboolean"/>
				<parameter name="perm" type="guint"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncCreateAsChannelCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_file_control" symbol="gnome_vfs_async_file_control">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="operation" type="char*"/>
				<parameter name="operation_data" type="gpointer"/>
				<parameter name="operation_data_destroy_func" type="GDestroyNotify"/>
				<parameter name="callback" type="GnomeVFSAsyncFileControlCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_find_directory" symbol="gnome_vfs_async_find_directory">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="near_uri_list" type="GList*"/>
				<parameter name="kind" type="GnomeVFSFindDirectoryKind"/>
				<parameter name="create_if_needed" type="gboolean"/>
				<parameter name="find_if_needed" type="gboolean"/>
				<parameter name="permissions" type="guint"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncFindDirectoryCallback"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_get_file_info" symbol="gnome_vfs_async_get_file_info">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="uri_list" type="GList*"/>
				<parameter name="options" type="GnomeVFSFileInfoOptions"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncGetFileInfoCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_get_job_limit" symbol="gnome_vfs_async_get_job_limit">
			<return-type type="int"/>
		</function>
		<function name="async_load_directory" symbol="gnome_vfs_async_load_directory">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="options" type="GnomeVFSFileInfoOptions"/>
				<parameter name="items_per_notification" type="guint"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncDirectoryLoadCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_load_directory_uri" symbol="gnome_vfs_async_load_directory_uri">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="options" type="GnomeVFSFileInfoOptions"/>
				<parameter name="items_per_notification" type="guint"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncDirectoryLoadCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_module_callback_pop" symbol="gnome_vfs_async_module_callback_pop">
			<return-type type="void"/>
			<parameters>
				<parameter name="callback_name" type="char*"/>
			</parameters>
		</function>
		<function name="async_module_callback_push" symbol="gnome_vfs_async_module_callback_push">
			<return-type type="void"/>
			<parameters>
				<parameter name="callback_name" type="char*"/>
				<parameter name="callback" type="GnomeVFSAsyncModuleCallback"/>
				<parameter name="callback_data" type="gpointer"/>
				<parameter name="destroy_notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="async_module_callback_set_default" symbol="gnome_vfs_async_module_callback_set_default">
			<return-type type="void"/>
			<parameters>
				<parameter name="callback_name" type="char*"/>
				<parameter name="callback" type="GnomeVFSAsyncModuleCallback"/>
				<parameter name="callback_data" type="gpointer"/>
				<parameter name="destroy_notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="async_open" symbol="gnome_vfs_async_open">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="open_mode" type="GnomeVFSOpenMode"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncOpenCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_open_as_channel" symbol="gnome_vfs_async_open_as_channel">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="open_mode" type="GnomeVFSOpenMode"/>
				<parameter name="advised_block_size" type="guint"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncOpenAsChannelCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_open_uri" symbol="gnome_vfs_async_open_uri">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="open_mode" type="GnomeVFSOpenMode"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncOpenCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_open_uri_as_channel" symbol="gnome_vfs_async_open_uri_as_channel">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="open_mode" type="GnomeVFSOpenMode"/>
				<parameter name="advised_block_size" type="guint"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncOpenAsChannelCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_read" symbol="gnome_vfs_async_read">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="buffer" type="gpointer"/>
				<parameter name="bytes" type="guint"/>
				<parameter name="callback" type="GnomeVFSAsyncReadCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_seek" symbol="gnome_vfs_async_seek">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="whence" type="GnomeVFSSeekPosition"/>
				<parameter name="offset" type="GnomeVFSFileOffset"/>
				<parameter name="callback" type="GnomeVFSAsyncSeekCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_set_file_info" symbol="gnome_vfs_async_set_file_info">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="info" type="GnomeVFSFileInfo*"/>
				<parameter name="mask" type="GnomeVFSSetFileInfoMask"/>
				<parameter name="options" type="GnomeVFSFileInfoOptions"/>
				<parameter name="priority" type="int"/>
				<parameter name="callback" type="GnomeVFSAsyncSetFileInfoCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_set_job_limit" symbol="gnome_vfs_async_set_job_limit">
			<return-type type="void"/>
			<parameters>
				<parameter name="limit" type="int"/>
			</parameters>
		</function>
		<function name="async_write" symbol="gnome_vfs_async_write">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="buffer" type="gconstpointer"/>
				<parameter name="bytes" type="guint"/>
				<parameter name="callback" type="GnomeVFSAsyncWriteCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="async_xfer" symbol="gnome_vfs_async_xfer">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle_return" type="GnomeVFSAsyncHandle**"/>
				<parameter name="source_uri_list" type="GList*"/>
				<parameter name="target_uri_list" type="GList*"/>
				<parameter name="xfer_options" type="GnomeVFSXferOptions"/>
				<parameter name="error_mode" type="GnomeVFSXferErrorMode"/>
				<parameter name="overwrite_mode" type="GnomeVFSXferOverwriteMode"/>
				<parameter name="priority" type="int"/>
				<parameter name="progress_update_callback" type="GnomeVFSAsyncXferProgressCallback"/>
				<parameter name="update_callback_data" type="gpointer"/>
				<parameter name="progress_sync_callback" type="GnomeVFSXferProgressCallback"/>
				<parameter name="sync_callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="check_same_fs" symbol="gnome_vfs_check_same_fs">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="source" type="gchar*"/>
				<parameter name="target" type="gchar*"/>
				<parameter name="same_fs_return" type="gboolean*"/>
			</parameters>
		</function>
		<function name="check_same_fs_uris" symbol="gnome_vfs_check_same_fs_uris">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="source_uri" type="GnomeVFSURI*"/>
				<parameter name="target_uri" type="GnomeVFSURI*"/>
				<parameter name="same_fs_return" type="gboolean*"/>
			</parameters>
		</function>
		<function name="close" symbol="gnome_vfs_close">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle*"/>
			</parameters>
		</function>
		<function name="connect_to_server" symbol="gnome_vfs_connect_to_server">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="char*"/>
				<parameter name="display_name" type="char*"/>
				<parameter name="icon" type="char*"/>
			</parameters>
		</function>
		<function name="create" symbol="gnome_vfs_create">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle**"/>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="open_mode" type="GnomeVFSOpenMode"/>
				<parameter name="exclusive" type="gboolean"/>
				<parameter name="perm" type="guint"/>
			</parameters>
		</function>
		<function name="create_symbolic_link" symbol="gnome_vfs_create_symbolic_link">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="target_reference" type="gchar*"/>
			</parameters>
		</function>
		<function name="create_uri" symbol="gnome_vfs_create_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle**"/>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="open_mode" type="GnomeVFSOpenMode"/>
				<parameter name="exclusive" type="gboolean"/>
				<parameter name="perm" type="guint"/>
			</parameters>
		</function>
		<function name="directory_close" symbol="gnome_vfs_directory_close">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSDirectoryHandle*"/>
			</parameters>
		</function>
		<function name="directory_list_load" symbol="gnome_vfs_directory_list_load">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="list" type="GList**"/>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="options" type="GnomeVFSFileInfoOptions"/>
			</parameters>
		</function>
		<function name="directory_open" symbol="gnome_vfs_directory_open">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSDirectoryHandle**"/>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="options" type="GnomeVFSFileInfoOptions"/>
			</parameters>
		</function>
		<function name="directory_open_from_uri" symbol="gnome_vfs_directory_open_from_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSDirectoryHandle**"/>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="options" type="GnomeVFSFileInfoOptions"/>
			</parameters>
		</function>
		<function name="directory_read_next" symbol="gnome_vfs_directory_read_next">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSDirectoryHandle*"/>
				<parameter name="file_info" type="GnomeVFSFileInfo*"/>
			</parameters>
		</function>
		<function name="directory_visit" symbol="gnome_vfs_directory_visit">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="info_options" type="GnomeVFSFileInfoOptions"/>
				<parameter name="visit_options" type="GnomeVFSDirectoryVisitOptions"/>
				<parameter name="callback" type="GnomeVFSDirectoryVisitFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="directory_visit_files" symbol="gnome_vfs_directory_visit_files">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="file_list" type="GList*"/>
				<parameter name="info_options" type="GnomeVFSFileInfoOptions"/>
				<parameter name="visit_options" type="GnomeVFSDirectoryVisitOptions"/>
				<parameter name="callback" type="GnomeVFSDirectoryVisitFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="directory_visit_files_at_uri" symbol="gnome_vfs_directory_visit_files_at_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="file_list" type="GList*"/>
				<parameter name="info_options" type="GnomeVFSFileInfoOptions"/>
				<parameter name="visit_options" type="GnomeVFSDirectoryVisitOptions"/>
				<parameter name="callback" type="GnomeVFSDirectoryVisitFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="directory_visit_uri" symbol="gnome_vfs_directory_visit_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="info_options" type="GnomeVFSFileInfoOptions"/>
				<parameter name="visit_options" type="GnomeVFSDirectoryVisitOptions"/>
				<parameter name="callback" type="GnomeVFSDirectoryVisitFunc"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="dns_sd_browse" symbol="gnome_vfs_dns_sd_browse">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSDNSSDBrowseHandle**"/>
				<parameter name="domain" type="char*"/>
				<parameter name="type" type="char*"/>
				<parameter name="callback" type="GnomeVFSDNSSDBrowseCallback"/>
				<parameter name="callback_data" type="gpointer"/>
				<parameter name="callback_data_destroy_func" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="dns_sd_browse_sync" symbol="gnome_vfs_dns_sd_browse_sync">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="domain" type="char*"/>
				<parameter name="type" type="char*"/>
				<parameter name="timeout_msec" type="int"/>
				<parameter name="n_services" type="int*"/>
				<parameter name="services" type="GnomeVFSDNSSDService**"/>
			</parameters>
		</function>
		<function name="dns_sd_cancel_resolve" symbol="gnome_vfs_dns_sd_cancel_resolve">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSDNSSDResolveHandle*"/>
			</parameters>
		</function>
		<function name="dns_sd_list_browse_domains_sync" symbol="gnome_vfs_dns_sd_list_browse_domains_sync">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="domain" type="char*"/>
				<parameter name="timeout_msec" type="int"/>
				<parameter name="domains" type="GList**"/>
			</parameters>
		</function>
		<function name="dns_sd_resolve" symbol="gnome_vfs_dns_sd_resolve">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSDNSSDResolveHandle**"/>
				<parameter name="name" type="char*"/>
				<parameter name="type" type="char*"/>
				<parameter name="domain" type="char*"/>
				<parameter name="timeout" type="int"/>
				<parameter name="callback" type="GnomeVFSDNSSDResolveCallback"/>
				<parameter name="callback_data" type="gpointer"/>
				<parameter name="callback_data_destroy_func" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="dns_sd_resolve_sync" symbol="gnome_vfs_dns_sd_resolve_sync">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="type" type="char*"/>
				<parameter name="domain" type="char*"/>
				<parameter name="timeout_msec" type="int"/>
				<parameter name="host" type="char**"/>
				<parameter name="port" type="int*"/>
				<parameter name="text" type="GHashTable**"/>
				<parameter name="text_raw_len_out" type="int*"/>
				<parameter name="text_raw_out" type="char**"/>
			</parameters>
		</function>
		<function name="dns_sd_stop_browse" symbol="gnome_vfs_dns_sd_stop_browse">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSDNSSDBrowseHandle*"/>
			</parameters>
		</function>
		<function name="escape_host_and_path_string" symbol="gnome_vfs_escape_host_and_path_string">
			<return-type type="char*"/>
			<parameters>
				<parameter name="path" type="char*"/>
			</parameters>
		</function>
		<function name="escape_path_string" symbol="gnome_vfs_escape_path_string">
			<return-type type="char*"/>
			<parameters>
				<parameter name="path" type="char*"/>
			</parameters>
		</function>
		<function name="escape_set" symbol="gnome_vfs_escape_set">
			<return-type type="char*"/>
			<parameters>
				<parameter name="string" type="char*"/>
				<parameter name="match_set" type="char*"/>
			</parameters>
		</function>
		<function name="escape_slashes" symbol="gnome_vfs_escape_slashes">
			<return-type type="char*"/>
			<parameters>
				<parameter name="string" type="char*"/>
			</parameters>
		</function>
		<function name="escape_string" symbol="gnome_vfs_escape_string">
			<return-type type="char*"/>
			<parameters>
				<parameter name="string" type="char*"/>
			</parameters>
		</function>
		<function name="expand_initial_tilde" symbol="gnome_vfs_expand_initial_tilde">
			<return-type type="char*"/>
			<parameters>
				<parameter name="path" type="char*"/>
			</parameters>
		</function>
		<function name="file_control" symbol="gnome_vfs_file_control">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle*"/>
				<parameter name="operation" type="char*"/>
				<parameter name="operation_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="find_directory" symbol="gnome_vfs_find_directory">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="near_uri" type="GnomeVFSURI*"/>
				<parameter name="kind" type="GnomeVFSFindDirectoryKind"/>
				<parameter name="result" type="GnomeVFSURI**"/>
				<parameter name="create_if_needed" type="gboolean"/>
				<parameter name="find_if_needed" type="gboolean"/>
				<parameter name="permissions" type="guint"/>
			</parameters>
		</function>
		<function name="forget_cache" symbol="gnome_vfs_forget_cache">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle*"/>
				<parameter name="offset" type="GnomeVFSFileOffset"/>
				<parameter name="size" type="GnomeVFSFileSize"/>
			</parameters>
		</function>
		<function name="format_file_size_for_display" symbol="gnome_vfs_format_file_size_for_display">
			<return-type type="char*"/>
			<parameters>
				<parameter name="size" type="GnomeVFSFileSize"/>
			</parameters>
		</function>
		<function name="format_uri_for_display" symbol="gnome_vfs_format_uri_for_display">
			<return-type type="char*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
			</parameters>
		</function>
		<function name="get_default_browse_domains" symbol="gnome_vfs_get_default_browse_domains">
			<return-type type="GList*"/>
		</function>
		<function name="get_file_info" symbol="gnome_vfs_get_file_info">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="info" type="GnomeVFSFileInfo*"/>
				<parameter name="options" type="GnomeVFSFileInfoOptions"/>
			</parameters>
		</function>
		<function name="get_file_info_from_handle" symbol="gnome_vfs_get_file_info_from_handle">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle*"/>
				<parameter name="info" type="GnomeVFSFileInfo*"/>
				<parameter name="options" type="GnomeVFSFileInfoOptions"/>
			</parameters>
		</function>
		<function name="get_file_info_uri" symbol="gnome_vfs_get_file_info_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="info" type="GnomeVFSFileInfo*"/>
				<parameter name="options" type="GnomeVFSFileInfoOptions"/>
			</parameters>
		</function>
		<function name="get_file_mime_type" symbol="gnome_vfs_get_file_mime_type">
			<return-type type="char*"/>
			<parameters>
				<parameter name="path" type="char*"/>
				<parameter name="optional_stat_info" type="struct stat*"/>
				<parameter name="suffix_only" type="gboolean"/>
			</parameters>
		</function>
		<function name="get_file_mime_type_fast" symbol="gnome_vfs_get_file_mime_type_fast">
			<return-type type="char*"/>
			<parameters>
				<parameter name="path" type="char*"/>
				<parameter name="optional_stat_info" type="struct stat*"/>
			</parameters>
		</function>
		<function name="get_local_path_from_uri" symbol="gnome_vfs_get_local_path_from_uri">
			<return-type type="char*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
			</parameters>
		</function>
		<function name="get_mime_type" symbol="gnome_vfs_get_mime_type">
			<return-type type="char*"/>
			<parameters>
				<parameter name="text_uri" type="char*"/>
			</parameters>
		</function>
		<function name="get_mime_type_common" symbol="gnome_vfs_get_mime_type_common">
			<return-type type="char*"/>
			<parameters>
				<parameter name="uri" type="GnomeVFSURI*"/>
			</parameters>
		</function>
		<function name="get_mime_type_for_data" symbol="gnome_vfs_get_mime_type_for_data">
			<return-type type="char*"/>
			<parameters>
				<parameter name="data" type="gconstpointer"/>
				<parameter name="data_size" type="int"/>
			</parameters>
		</function>
		<function name="get_mime_type_for_name" symbol="gnome_vfs_get_mime_type_for_name">
			<return-type type="char*"/>
			<parameters>
				<parameter name="filename" type="char*"/>
			</parameters>
		</function>
		<function name="get_mime_type_for_name_and_data" symbol="gnome_vfs_get_mime_type_for_name_and_data">
			<return-type type="char*"/>
			<parameters>
				<parameter name="filename" type="char*"/>
				<parameter name="data" type="gconstpointer"/>
				<parameter name="data_size" type="gssize"/>
			</parameters>
		</function>
		<function name="get_mime_type_from_file_data" symbol="gnome_vfs_get_mime_type_from_file_data">
			<return-type type="char*"/>
			<parameters>
				<parameter name="uri" type="GnomeVFSURI*"/>
			</parameters>
		</function>
		<function name="get_mime_type_from_uri" symbol="gnome_vfs_get_mime_type_from_uri">
			<return-type type="char*"/>
			<parameters>
				<parameter name="uri" type="GnomeVFSURI*"/>
			</parameters>
		</function>
		<function name="get_slow_mime_type" symbol="gnome_vfs_get_slow_mime_type">
			<return-type type="char*"/>
			<parameters>
				<parameter name="text_uri" type="char*"/>
			</parameters>
		</function>
		<function name="get_supertype_from_mime_type" symbol="gnome_vfs_get_supertype_from_mime_type">
			<return-type type="char*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="get_uri_from_local_path" symbol="gnome_vfs_get_uri_from_local_path">
			<return-type type="char*"/>
			<parameters>
				<parameter name="local_full_path" type="char*"/>
			</parameters>
		</function>
		<function name="get_uri_scheme" symbol="gnome_vfs_get_uri_scheme">
			<return-type type="char*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
			</parameters>
		</function>
		<function name="get_volume_free_space" symbol="gnome_vfs_get_volume_free_space">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="vfs_uri" type="GnomeVFSURI*"/>
				<parameter name="size" type="GnomeVFSFileSize*"/>
			</parameters>
		</function>
		<function name="get_volume_monitor" symbol="gnome_vfs_get_volume_monitor">
			<return-type type="GnomeVFSVolumeMonitor*"/>
		</function>
		<function name="icon_path_from_filename" symbol="gnome_vfs_icon_path_from_filename">
			<return-type type="char*"/>
			<parameters>
				<parameter name="filename" type="char*"/>
			</parameters>
		</function>
		<function name="init" symbol="gnome_vfs_init">
			<return-type type="gboolean"/>
		</function>
		<function name="initialized" symbol="gnome_vfs_initialized">
			<return-type type="gboolean"/>
		</function>
		<function name="is_executable_command_string" symbol="gnome_vfs_is_executable_command_string">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="command_string" type="char*"/>
			</parameters>
		</function>
		<function name="is_primary_thread" symbol="gnome_vfs_is_primary_thread">
			<return-type type="gboolean"/>
		</function>
		<function name="list_deep_free" symbol="gnome_vfs_list_deep_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GList*"/>
			</parameters>
		</function>
		<function name="loadinit" symbol="gnome_vfs_loadinit">
			<return-type type="void"/>
			<parameters>
				<parameter name="app" type="gpointer"/>
				<parameter name="modinfo" type="gpointer"/>
			</parameters>
		</function>
		<function name="make_directory" symbol="gnome_vfs_make_directory">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="perm" type="guint"/>
			</parameters>
		</function>
		<function name="make_directory_for_uri" symbol="gnome_vfs_make_directory_for_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="perm" type="guint"/>
			</parameters>
		</function>
		<function name="make_path_name_canonical" symbol="gnome_vfs_make_path_name_canonical">
			<return-type type="char*"/>
			<parameters>
				<parameter name="path" type="char*"/>
			</parameters>
		</function>
		<function name="make_uri_canonical" symbol="gnome_vfs_make_uri_canonical">
			<return-type type="char*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
			</parameters>
		</function>
		<function name="make_uri_canonical_strip_fragment" symbol="gnome_vfs_make_uri_canonical_strip_fragment">
			<return-type type="char*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
			</parameters>
		</function>
		<function name="make_uri_from_input" symbol="gnome_vfs_make_uri_from_input">
			<return-type type="char*"/>
			<parameters>
				<parameter name="location" type="char*"/>
			</parameters>
		</function>
		<function name="make_uri_from_input_with_dirs" symbol="gnome_vfs_make_uri_from_input_with_dirs">
			<return-type type="char*"/>
			<parameters>
				<parameter name="location" type="char*"/>
				<parameter name="dirs" type="GnomeVFSMakeURIDirs"/>
			</parameters>
		</function>
		<function name="make_uri_from_input_with_trailing_ws" symbol="gnome_vfs_make_uri_from_input_with_trailing_ws">
			<return-type type="char*"/>
			<parameters>
				<parameter name="location" type="char*"/>
			</parameters>
		</function>
		<function name="make_uri_from_shell_arg" symbol="gnome_vfs_make_uri_from_shell_arg">
			<return-type type="char*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
			</parameters>
		</function>
		<function name="make_uri_full_from_relative" symbol="gnome_vfs_make_uri_full_from_relative">
			<return-type type="char*"/>
			<parameters>
				<parameter name="base_uri" type="char*"/>
				<parameter name="relative_uri" type="char*"/>
			</parameters>
		</function>
		<function name="mime_add_application_to_short_list" symbol="gnome_vfs_mime_add_application_to_short_list">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="application_id" type="char*"/>
			</parameters>
		</function>
		<function name="mime_add_component_to_short_list" symbol="gnome_vfs_mime_add_component_to_short_list">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="iid" type="char*"/>
			</parameters>
		</function>
		<function name="mime_add_extension" symbol="gnome_vfs_mime_add_extension">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="extension" type="char*"/>
			</parameters>
		</function>
		<function name="mime_can_be_executable" symbol="gnome_vfs_mime_can_be_executable">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_component_list_free" symbol="gnome_vfs_mime_component_list_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="list" type="GList*"/>
			</parameters>
		</function>
		<function name="mime_extend_all_applications" symbol="gnome_vfs_mime_extend_all_applications">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="application_ids" type="GList*"/>
			</parameters>
		</function>
		<function name="mime_get_all_applications" symbol="gnome_vfs_mime_get_all_applications">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_all_applications_for_uri" symbol="gnome_vfs_mime_get_all_applications_for_uri">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_all_components" symbol="gnome_vfs_mime_get_all_components">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_all_desktop_entries" symbol="gnome_vfs_mime_get_all_desktop_entries">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_default_action" symbol="gnome_vfs_mime_get_default_action">
			<return-type type="GnomeVFSMimeAction*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_default_action_type" symbol="gnome_vfs_mime_get_default_action_type">
			<return-type type="GnomeVFSMimeActionType"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_default_application" symbol="gnome_vfs_mime_get_default_application">
			<return-type type="GnomeVFSMimeApplication*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_default_application_for_uri" symbol="gnome_vfs_mime_get_default_application_for_uri">
			<return-type type="GnomeVFSMimeApplication*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_default_component" symbol="gnome_vfs_mime_get_default_component">
			<return-type type="void*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_default_desktop_entry" symbol="gnome_vfs_mime_get_default_desktop_entry">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_description" symbol="gnome_vfs_mime_get_description">
			<return-type type="char*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_icon" symbol="gnome_vfs_mime_get_icon">
			<return-type type="char*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_short_list_applications" symbol="gnome_vfs_mime_get_short_list_applications">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_get_short_list_components" symbol="gnome_vfs_mime_get_short_list_components">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_id_in_application_list" symbol="gnome_vfs_mime_id_in_application_list">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="id" type="char*"/>
				<parameter name="applications" type="GList*"/>
			</parameters>
		</function>
		<function name="mime_id_in_component_list" symbol="gnome_vfs_mime_id_in_component_list">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="iid" type="char*"/>
				<parameter name="components" type="GList*"/>
			</parameters>
		</function>
		<function name="mime_id_list_from_application_list" symbol="gnome_vfs_mime_id_list_from_application_list">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="applications" type="GList*"/>
			</parameters>
		</function>
		<function name="mime_id_list_from_component_list" symbol="gnome_vfs_mime_id_list_from_component_list">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="components" type="GList*"/>
			</parameters>
		</function>
		<function name="mime_info_cache_reload" symbol="gnome_vfs_mime_info_cache_reload">
			<return-type type="void"/>
			<parameters>
				<parameter name="dir" type="char*"/>
			</parameters>
		</function>
		<function name="mime_reload" symbol="gnome_vfs_mime_reload">
			<return-type type="void"/>
		</function>
		<function name="mime_remove_application_from_list" symbol="gnome_vfs_mime_remove_application_from_list">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="applications" type="GList*"/>
				<parameter name="application_id" type="char*"/>
				<parameter name="did_remove" type="gboolean*"/>
			</parameters>
		</function>
		<function name="mime_remove_application_from_short_list" symbol="gnome_vfs_mime_remove_application_from_short_list">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="application_id" type="char*"/>
			</parameters>
		</function>
		<function name="mime_remove_component_from_list" symbol="gnome_vfs_mime_remove_component_from_list">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="components" type="GList*"/>
				<parameter name="iid" type="char*"/>
				<parameter name="did_remove" type="gboolean*"/>
			</parameters>
		</function>
		<function name="mime_remove_component_from_short_list" symbol="gnome_vfs_mime_remove_component_from_short_list">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="iid" type="char*"/>
			</parameters>
		</function>
		<function name="mime_remove_extension" symbol="gnome_vfs_mime_remove_extension">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="extension" type="char*"/>
			</parameters>
		</function>
		<function name="mime_remove_from_all_applications" symbol="gnome_vfs_mime_remove_from_all_applications">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="application_ids" type="GList*"/>
			</parameters>
		</function>
		<function name="mime_set_can_be_executable" symbol="gnome_vfs_mime_set_can_be_executable">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="new_value" type="gboolean"/>
			</parameters>
		</function>
		<function name="mime_set_default_action_type" symbol="gnome_vfs_mime_set_default_action_type">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="action_type" type="GnomeVFSMimeActionType"/>
			</parameters>
		</function>
		<function name="mime_set_default_application" symbol="gnome_vfs_mime_set_default_application">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="application_id" type="char*"/>
			</parameters>
		</function>
		<function name="mime_set_default_component" symbol="gnome_vfs_mime_set_default_component">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="component_iid" type="char*"/>
			</parameters>
		</function>
		<function name="mime_set_description" symbol="gnome_vfs_mime_set_description">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="description" type="char*"/>
			</parameters>
		</function>
		<function name="mime_set_icon" symbol="gnome_vfs_mime_set_icon">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="filename" type="char*"/>
			</parameters>
		</function>
		<function name="mime_set_short_list_applications" symbol="gnome_vfs_mime_set_short_list_applications">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="application_ids" type="GList*"/>
			</parameters>
		</function>
		<function name="mime_set_short_list_components" symbol="gnome_vfs_mime_set_short_list_components">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="component_iids" type="GList*"/>
			</parameters>
		</function>
		<function name="mime_shutdown" symbol="gnome_vfs_mime_shutdown">
			<return-type type="void"/>
		</function>
		<function name="mime_type_from_name" symbol="gnome_vfs_mime_type_from_name">
			<return-type type="char*"/>
			<parameters>
				<parameter name="filename" type="char*"/>
			</parameters>
		</function>
		<function name="mime_type_from_name_or_default" symbol="gnome_vfs_mime_type_from_name_or_default">
			<return-type type="char*"/>
			<parameters>
				<parameter name="filename" type="char*"/>
				<parameter name="defaultv" type="char*"/>
			</parameters>
		</function>
		<function name="mime_type_get_equivalence" symbol="gnome_vfs_mime_type_get_equivalence">
			<return-type type="GnomeVFSMimeEquivalence"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
				<parameter name="base_mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="mime_type_is_equal" symbol="gnome_vfs_mime_type_is_equal">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="a" type="char*"/>
				<parameter name="b" type="char*"/>
			</parameters>
		</function>
		<function name="mime_type_is_supertype" symbol="gnome_vfs_mime_type_is_supertype">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="mime_type" type="char*"/>
			</parameters>
		</function>
		<function name="module_callback_pop" symbol="gnome_vfs_module_callback_pop">
			<return-type type="void"/>
			<parameters>
				<parameter name="callback_name" type="char*"/>
			</parameters>
		</function>
		<function name="module_callback_push" symbol="gnome_vfs_module_callback_push">
			<return-type type="void"/>
			<parameters>
				<parameter name="callback_name" type="char*"/>
				<parameter name="callback" type="GnomeVFSModuleCallback"/>
				<parameter name="callback_data" type="gpointer"/>
				<parameter name="destroy_notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="module_callback_set_default" symbol="gnome_vfs_module_callback_set_default">
			<return-type type="void"/>
			<parameters>
				<parameter name="callback_name" type="char*"/>
				<parameter name="callback" type="GnomeVFSModuleCallback"/>
				<parameter name="callback_data" type="gpointer"/>
				<parameter name="destroy_notify" type="GDestroyNotify"/>
			</parameters>
		</function>
		<function name="monitor_add" symbol="gnome_vfs_monitor_add">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSMonitorHandle**"/>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="monitor_type" type="GnomeVFSMonitorType"/>
				<parameter name="callback" type="GnomeVFSMonitorCallback"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="monitor_cancel" symbol="gnome_vfs_monitor_cancel">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSMonitorHandle*"/>
			</parameters>
		</function>
		<function name="move" symbol="gnome_vfs_move">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="old_text_uri" type="gchar*"/>
				<parameter name="new_text_uri" type="gchar*"/>
				<parameter name="force_replace" type="gboolean"/>
			</parameters>
		</function>
		<function name="move_uri" symbol="gnome_vfs_move_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="old_uri" type="GnomeVFSURI*"/>
				<parameter name="new_uri" type="GnomeVFSURI*"/>
				<parameter name="force_replace" type="gboolean"/>
			</parameters>
		</function>
		<function name="open" symbol="gnome_vfs_open">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle**"/>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="open_mode" type="GnomeVFSOpenMode"/>
			</parameters>
		</function>
		<function name="open_fd" symbol="gnome_vfs_open_fd">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle**"/>
				<parameter name="filedes" type="int"/>
			</parameters>
		</function>
		<function name="open_uri" symbol="gnome_vfs_open_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle**"/>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="open_mode" type="GnomeVFSOpenMode"/>
			</parameters>
		</function>
		<function name="postinit" symbol="gnome_vfs_postinit">
			<return-type type="void"/>
			<parameters>
				<parameter name="app" type="gpointer"/>
				<parameter name="modinfo" type="gpointer"/>
			</parameters>
		</function>
		<function name="preinit" symbol="gnome_vfs_preinit">
			<return-type type="void"/>
			<parameters>
				<parameter name="app" type="gpointer"/>
				<parameter name="modinfo" type="gpointer"/>
			</parameters>
		</function>
		<function name="read" symbol="gnome_vfs_read">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle*"/>
				<parameter name="buffer" type="gpointer"/>
				<parameter name="bytes" type="GnomeVFSFileSize"/>
				<parameter name="bytes_read" type="GnomeVFSFileSize*"/>
			</parameters>
		</function>
		<function name="read_entire_file" symbol="gnome_vfs_read_entire_file">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="uri" type="char*"/>
				<parameter name="file_size" type="int*"/>
				<parameter name="file_contents" type="char**"/>
			</parameters>
		</function>
		<function name="remove_directory" symbol="gnome_vfs_remove_directory">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="text_uri" type="gchar*"/>
			</parameters>
		</function>
		<function name="remove_directory_from_uri" symbol="gnome_vfs_remove_directory_from_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="uri" type="GnomeVFSURI*"/>
			</parameters>
		</function>
		<function name="resolve" symbol="gnome_vfs_resolve">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="hostname" type="char*"/>
				<parameter name="handle" type="GnomeVFSResolveHandle**"/>
			</parameters>
		</function>
		<function name="resolve_free" symbol="gnome_vfs_resolve_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSResolveHandle*"/>
			</parameters>
		</function>
		<function name="resolve_next_address" symbol="gnome_vfs_resolve_next_address">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSResolveHandle*"/>
				<parameter name="address" type="GnomeVFSAddress**"/>
			</parameters>
		</function>
		<function name="resolve_reset_to_beginning" symbol="gnome_vfs_resolve_reset_to_beginning">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSResolveHandle*"/>
			</parameters>
		</function>
		<function name="result_from_errno" symbol="gnome_vfs_result_from_errno">
			<return-type type="GnomeVFSResult"/>
		</function>
		<function name="result_from_errno_code" symbol="gnome_vfs_result_from_errno_code">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="errno_code" type="int"/>
			</parameters>
		</function>
		<function name="result_from_h_errno" symbol="gnome_vfs_result_from_h_errno">
			<return-type type="GnomeVFSResult"/>
		</function>
		<function name="result_from_h_errno_val" symbol="gnome_vfs_result_from_h_errno_val">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="h_errno_code" type="int"/>
			</parameters>
		</function>
		<function name="result_to_string" symbol="gnome_vfs_result_to_string">
			<return-type type="char*"/>
			<parameters>
				<parameter name="result" type="GnomeVFSResult"/>
			</parameters>
		</function>
		<function name="seek" symbol="gnome_vfs_seek">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle*"/>
				<parameter name="whence" type="GnomeVFSSeekPosition"/>
				<parameter name="offset" type="GnomeVFSFileOffset"/>
			</parameters>
		</function>
		<function name="set_file_info" symbol="gnome_vfs_set_file_info">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="info" type="GnomeVFSFileInfo*"/>
				<parameter name="mask" type="GnomeVFSSetFileInfoMask"/>
			</parameters>
		</function>
		<function name="set_file_info_uri" symbol="gnome_vfs_set_file_info_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="info" type="GnomeVFSFileInfo*"/>
				<parameter name="mask" type="GnomeVFSSetFileInfoMask"/>
			</parameters>
		</function>
		<function name="shutdown" symbol="gnome_vfs_shutdown">
			<return-type type="void"/>
		</function>
		<function name="tell" symbol="gnome_vfs_tell">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle*"/>
				<parameter name="offset_return" type="GnomeVFSFileSize*"/>
			</parameters>
		</function>
		<function name="truncate" symbol="gnome_vfs_truncate">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="text_uri" type="gchar*"/>
				<parameter name="length" type="GnomeVFSFileSize"/>
			</parameters>
		</function>
		<function name="truncate_handle" symbol="gnome_vfs_truncate_handle">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle*"/>
				<parameter name="length" type="GnomeVFSFileSize"/>
			</parameters>
		</function>
		<function name="truncate_uri" symbol="gnome_vfs_truncate_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="uri" type="GnomeVFSURI*"/>
				<parameter name="length" type="GnomeVFSFileSize"/>
			</parameters>
		</function>
		<function name="unescape_string" symbol="gnome_vfs_unescape_string">
			<return-type type="char*"/>
			<parameters>
				<parameter name="escaped_string" type="char*"/>
				<parameter name="illegal_characters" type="char*"/>
			</parameters>
		</function>
		<function name="unescape_string_for_display" symbol="gnome_vfs_unescape_string_for_display">
			<return-type type="char*"/>
			<parameters>
				<parameter name="escaped" type="char*"/>
			</parameters>
		</function>
		<function name="unlink" symbol="gnome_vfs_unlink">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="text_uri" type="gchar*"/>
			</parameters>
		</function>
		<function name="unlink_from_uri" symbol="gnome_vfs_unlink_from_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="uri" type="GnomeVFSURI*"/>
			</parameters>
		</function>
		<function name="uris_match" symbol="gnome_vfs_uris_match">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="uri_1" type="char*"/>
				<parameter name="uri_2" type="char*"/>
			</parameters>
		</function>
		<function name="url_show" symbol="gnome_vfs_url_show">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="url" type="char*"/>
			</parameters>
		</function>
		<function name="url_show_with_env" symbol="gnome_vfs_url_show_with_env">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="url" type="char*"/>
				<parameter name="envp" type="char**"/>
			</parameters>
		</function>
		<function name="write" symbol="gnome_vfs_write">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSHandle*"/>
				<parameter name="buffer" type="gconstpointer"/>
				<parameter name="bytes" type="GnomeVFSFileSize"/>
				<parameter name="bytes_written" type="GnomeVFSFileSize*"/>
			</parameters>
		</function>
		<function name="xfer_delete_list" symbol="gnome_vfs_xfer_delete_list">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="source_uri_list" type="GList*"/>
				<parameter name="error_mode" type="GnomeVFSXferErrorMode"/>
				<parameter name="xfer_options" type="GnomeVFSXferOptions"/>
				<parameter name="progress_callback" type="GnomeVFSXferProgressCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="xfer_uri" symbol="gnome_vfs_xfer_uri">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="source_uri" type="GnomeVFSURI*"/>
				<parameter name="target_uri" type="GnomeVFSURI*"/>
				<parameter name="xfer_options" type="GnomeVFSXferOptions"/>
				<parameter name="error_mode" type="GnomeVFSXferErrorMode"/>
				<parameter name="overwrite_mode" type="GnomeVFSXferOverwriteMode"/>
				<parameter name="progress_callback" type="GnomeVFSXferProgressCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="xfer_uri_list" symbol="gnome_vfs_xfer_uri_list">
			<return-type type="GnomeVFSResult"/>
			<parameters>
				<parameter name="source_uri_list" type="GList*"/>
				<parameter name="target_uri_list" type="GList*"/>
				<parameter name="xfer_options" type="GnomeVFSXferOptions"/>
				<parameter name="error_mode" type="GnomeVFSXferErrorMode"/>
				<parameter name="overwrite_mode" type="GnomeVFSXferOverwriteMode"/>
				<parameter name="progress_callback" type="GnomeVFSXferProgressCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<callback name="GnomeVFSAsyncCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncCloseCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncCreateAsChannelCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="channel" type="GIOChannel*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncCreateCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncDirectoryLoadCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="list" type="GList*"/>
				<parameter name="entries_read" type="guint"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncFileControlCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="operation_data" type="gpointer"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncFindDirectoryCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="results" type="GList*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncGetFileInfoCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="results" type="GList*"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncModuleCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="in" type="gconstpointer"/>
				<parameter name="in_size" type="gsize"/>
				<parameter name="out" type="gpointer"/>
				<parameter name="out_size" type="gsize"/>
				<parameter name="callback_data" type="gpointer"/>
				<parameter name="response" type="GnomeVFSModuleCallbackResponse"/>
				<parameter name="response_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncOpenAsChannelCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="channel" type="GIOChannel*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncOpenCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncReadCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="buffer" type="gpointer"/>
				<parameter name="bytes_requested" type="GnomeVFSFileSize"/>
				<parameter name="bytes_read" type="GnomeVFSFileSize"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncSeekCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncSetFileInfoCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="file_info" type="GnomeVFSFileInfo*"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncWriteCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="buffer" type="gconstpointer"/>
				<parameter name="bytes_requested" type="GnomeVFSFileSize"/>
				<parameter name="bytes_written" type="GnomeVFSFileSize"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSAsyncXferProgressCallback">
			<return-type type="gint"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSAsyncHandle*"/>
				<parameter name="info" type="GnomeVFSXferProgressInfo*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSDNSSDBrowseCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSDNSSDBrowseHandle*"/>
				<parameter name="status" type="GnomeVFSDNSSDServiceStatus"/>
				<parameter name="service" type="GnomeVFSDNSSDService*"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSDNSSDResolveCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSDNSSDResolveHandle*"/>
				<parameter name="result" type="GnomeVFSResult"/>
				<parameter name="service" type="GnomeVFSDNSSDService*"/>
				<parameter name="host" type="char*"/>
				<parameter name="port" type="int"/>
				<parameter name="text" type="GHashTable*"/>
				<parameter name="text_raw_len" type="int"/>
				<parameter name="text_raw" type="char*"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSDirectoryVisitFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="rel_path" type="gchar*"/>
				<parameter name="info" type="GnomeVFSFileInfo*"/>
				<parameter name="recursing_will_loop" type="gboolean"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="recurse" type="gboolean*"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSModuleCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="in" type="gconstpointer"/>
				<parameter name="in_size" type="gsize"/>
				<parameter name="out" type="gpointer"/>
				<parameter name="out_size" type="gsize"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSModuleCallbackResponse">
			<return-type type="void"/>
			<parameters>
				<parameter name="response_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSMonitorCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeVFSMonitorHandle*"/>
				<parameter name="monitor_uri" type="gchar*"/>
				<parameter name="info_uri" type="gchar*"/>
				<parameter name="event_type" type="GnomeVFSMonitorEventType"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSVolumeOpCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="succeeded" type="gboolean"/>
				<parameter name="error" type="char*"/>
				<parameter name="detailed_error" type="char*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeVFSXferProgressCallback">
			<return-type type="gint"/>
			<parameters>
				<parameter name="info" type="GnomeVFSXferProgressInfo*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GnomeVFSACLKind">
			<method name="to_string" symbol="gnome_vfs_acl_kind_to_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="kind" type="GnomeVFSACLKind"/>
				</parameters>
			</method>
		</struct>
		<struct name="GnomeVFSACLPerm">
			<method name="to_string" symbol="gnome_vfs_acl_perm_to_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="perm" type="GnomeVFSACLPerm"/>
				</parameters>
			</method>
		</struct>
		<struct name="GnomeVFSAsyncHandle">
		</struct>
		<struct name="GnomeVFSCancellation">
			<method name="ack" symbol="gnome_vfs_cancellation_ack">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellation" type="GnomeVFSCancellation*"/>
				</parameters>
			</method>
			<method name="cancel" symbol="gnome_vfs_cancellation_cancel">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellation" type="GnomeVFSCancellation*"/>
				</parameters>
			</method>
			<method name="check" symbol="gnome_vfs_cancellation_check">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cancellation" type="GnomeVFSCancellation*"/>
				</parameters>
			</method>
			<method name="destroy" symbol="gnome_vfs_cancellation_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellation" type="GnomeVFSCancellation*"/>
				</parameters>
			</method>
			<method name="get_fd" symbol="gnome_vfs_cancellation_get_fd">
				<return-type type="gint"/>
				<parameters>
					<parameter name="cancellation" type="GnomeVFSCancellation*"/>
				</parameters>
			</method>
			<method name="new" symbol="gnome_vfs_cancellation_new">
				<return-type type="GnomeVFSCancellation*"/>
			</method>
		</struct>
		<struct name="GnomeVFSContext">
			<method name="check_cancellation_current" symbol="gnome_vfs_context_check_cancellation_current">
				<return-type type="gboolean"/>
			</method>
			<method name="free" symbol="gnome_vfs_context_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="ctx" type="GnomeVFSContext*"/>
				</parameters>
			</method>
			<method name="get_cancellation" symbol="gnome_vfs_context_get_cancellation">
				<return-type type="GnomeVFSCancellation*"/>
				<parameters>
					<parameter name="ctx" type="GnomeVFSContext*"/>
				</parameters>
			</method>
			<method name="new" symbol="gnome_vfs_context_new">
				<return-type type="GnomeVFSContext*"/>
			</method>
			<method name="peek_current" symbol="gnome_vfs_context_peek_current">
				<return-type type="GnomeVFSContext*"/>
			</method>
		</struct>
		<struct name="GnomeVFSDNSSDBrowseHandle">
		</struct>
		<struct name="GnomeVFSDNSSDResolveHandle">
		</struct>
		<struct name="GnomeVFSDNSSDService">
			<method name="list_free" symbol="gnome_vfs_dns_sd_service_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="services" type="GnomeVFSDNSSDService*"/>
					<parameter name="n_services" type="int"/>
				</parameters>
			</method>
			<field name="name" type="char*"/>
			<field name="type" type="char*"/>
			<field name="domain" type="char*"/>
		</struct>
		<struct name="GnomeVFSDirectoryHandle">
		</struct>
		<struct name="GnomeVFSFileOffset">
		</struct>
		<struct name="GnomeVFSFileSize">
		</struct>
		<struct name="GnomeVFSFindDirectoryResult">
			<method name="dup" symbol="gnome_vfs_find_directory_result_dup">
				<return-type type="GnomeVFSFindDirectoryResult*"/>
				<parameters>
					<parameter name="result" type="GnomeVFSFindDirectoryResult*"/>
				</parameters>
			</method>
			<method name="free" symbol="gnome_vfs_find_directory_result_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="result" type="GnomeVFSFindDirectoryResult*"/>
				</parameters>
			</method>
			<field name="uri" type="GnomeVFSURI*"/>
			<field name="result" type="GnomeVFSResult"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSGetFileInfoResult">
			<method name="dup" symbol="gnome_vfs_get_file_info_result_dup">
				<return-type type="GnomeVFSGetFileInfoResult*"/>
				<parameters>
					<parameter name="result" type="GnomeVFSGetFileInfoResult*"/>
				</parameters>
			</method>
			<method name="free" symbol="gnome_vfs_get_file_info_result_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="result" type="GnomeVFSGetFileInfoResult*"/>
				</parameters>
			</method>
			<field name="uri" type="GnomeVFSURI*"/>
			<field name="result" type="GnomeVFSResult"/>
			<field name="file_info" type="GnomeVFSFileInfo*"/>
		</struct>
		<struct name="GnomeVFSHandle">
		</struct>
		<struct name="GnomeVFSInodeNumber">
		</struct>
		<struct name="GnomeVFSMethodHandle">
		</struct>
		<struct name="GnomeVFSMimeAction">
			<method name="free" symbol="gnome_vfs_mime_action_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="action" type="GnomeVFSMimeAction*"/>
				</parameters>
			</method>
			<method name="launch" symbol="gnome_vfs_mime_action_launch">
				<return-type type="GnomeVFSResult"/>
				<parameters>
					<parameter name="action" type="GnomeVFSMimeAction*"/>
					<parameter name="uris" type="GList*"/>
				</parameters>
			</method>
			<method name="launch_with_env" symbol="gnome_vfs_mime_action_launch_with_env">
				<return-type type="GnomeVFSResult"/>
				<parameters>
					<parameter name="action" type="GnomeVFSMimeAction*"/>
					<parameter name="uris" type="GList*"/>
					<parameter name="envp" type="char**"/>
				</parameters>
			</method>
			<field name="action_type" type="GnomeVFSMimeActionType"/>
			<field name="action" type="gpointer"/>
			<field name="reserved1" type="void*"/>
		</struct>
		<struct name="GnomeVFSMimeApplication">
			<method name="copy" symbol="gnome_vfs_mime_application_copy">
				<return-type type="GnomeVFSMimeApplication*"/>
				<parameters>
					<parameter name="application" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="equal" symbol="gnome_vfs_mime_application_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="app_a" type="GnomeVFSMimeApplication*"/>
					<parameter name="app_b" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="free" symbol="gnome_vfs_mime_application_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="application" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="get_binary_name" symbol="gnome_vfs_mime_application_get_binary_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="get_desktop_file_path" symbol="gnome_vfs_mime_application_get_desktop_file_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="get_desktop_id" symbol="gnome_vfs_mime_application_get_desktop_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="get_exec" symbol="gnome_vfs_mime_application_get_exec">
				<return-type type="char*"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="get_generic_name" symbol="gnome_vfs_mime_application_get_generic_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gnome_vfs_mime_application_get_icon">
				<return-type type="char*"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gnome_vfs_mime_application_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="get_startup_wm_class" symbol="gnome_vfs_mime_application_get_startup_wm_class">
				<return-type type="char*"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="launch" symbol="gnome_vfs_mime_application_launch">
				<return-type type="GnomeVFSResult"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
					<parameter name="uris" type="GList*"/>
				</parameters>
			</method>
			<method name="launch_with_env" symbol="gnome_vfs_mime_application_launch_with_env">
				<return-type type="GnomeVFSResult"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
					<parameter name="uris" type="GList*"/>
					<parameter name="envp" type="char**"/>
				</parameters>
			</method>
			<method name="list_free" symbol="gnome_vfs_mime_application_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="new_from_desktop_id" symbol="gnome_vfs_mime_application_new_from_desktop_id">
				<return-type type="GnomeVFSMimeApplication*"/>
				<parameters>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="new_from_id" symbol="gnome_vfs_mime_application_new_from_id">
				<return-type type="GnomeVFSMimeApplication*"/>
				<parameters>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="requires_terminal" symbol="gnome_vfs_mime_application_requires_terminal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="supports_startup_notification" symbol="gnome_vfs_mime_application_supports_startup_notification">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<method name="supports_uris" symbol="gnome_vfs_mime_application_supports_uris">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="app" type="GnomeVFSMimeApplication*"/>
				</parameters>
			</method>
			<field name="id" type="char*"/>
			<field name="name" type="char*"/>
			<field name="command" type="char*"/>
			<field name="can_open_multiple_files" type="gboolean"/>
			<field name="expects_uris" type="GnomeVFSMimeApplicationArgumentType"/>
			<field name="supported_uri_schemes" type="GList*"/>
			<field name="requires_terminal" type="gboolean"/>
			<field name="reserved1" type="void*"/>
			<field name="priv" type="GnomeVFSMimeApplicationPrivate*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackAdditionalHeadersIn">
			<field name="uri" type="GnomeVFSURI*"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackAdditionalHeadersOut">
			<field name="headers" type="GList*"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackAuthenticationIn">
			<field name="uri" type="char*"/>
			<field name="realm" type="char*"/>
			<field name="previous_attempt_failed" type="gboolean"/>
			<field name="auth_type" type="GnomeVFSModuleCallbackAuthenticationAuthType"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackAuthenticationOut">
			<field name="username" type="char*"/>
			<field name="password" type="char*"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackFillAuthenticationIn">
			<field name="uri" type="char*"/>
			<field name="protocol" type="char*"/>
			<field name="server" type="char*"/>
			<field name="object" type="char*"/>
			<field name="port" type="int"/>
			<field name="authtype" type="char*"/>
			<field name="username" type="char*"/>
			<field name="domain" type="char*"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackFillAuthenticationOut">
			<field name="valid" type="gboolean"/>
			<field name="username" type="char*"/>
			<field name="domain" type="char*"/>
			<field name="password" type="char*"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackFullAuthenticationIn">
			<field name="flags" type="GnomeVFSModuleCallbackFullAuthenticationFlags"/>
			<field name="uri" type="char*"/>
			<field name="protocol" type="char*"/>
			<field name="server" type="char*"/>
			<field name="object" type="char*"/>
			<field name="port" type="int"/>
			<field name="authtype" type="char*"/>
			<field name="username" type="char*"/>
			<field name="domain" type="char*"/>
			<field name="default_user" type="char*"/>
			<field name="default_domain" type="char*"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackFullAuthenticationOut">
			<field name="abort_auth" type="gboolean"/>
			<field name="username" type="char*"/>
			<field name="domain" type="char*"/>
			<field name="password" type="char*"/>
			<field name="save_password" type="gboolean"/>
			<field name="keyring" type="char*"/>
			<field name="out_flags" type="gsize"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackQuestionIn">
			<field name="primary_message" type="char*"/>
			<field name="secondary_message" type="char*"/>
			<field name="choices" type="char**"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackQuestionOut">
			<field name="answer" type="int"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackReceivedHeadersIn">
			<field name="uri" type="GnomeVFSURI*"/>
			<field name="headers" type="GList*"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackReceivedHeadersOut">
			<field name="dummy" type="int"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackSaveAuthenticationIn">
			<field name="keyring" type="char*"/>
			<field name="uri" type="char*"/>
			<field name="protocol" type="char*"/>
			<field name="server" type="char*"/>
			<field name="object" type="char*"/>
			<field name="port" type="int"/>
			<field name="authtype" type="char*"/>
			<field name="username" type="char*"/>
			<field name="domain" type="char*"/>
			<field name="password" type="char*"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackSaveAuthenticationOut">
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackStatusMessageIn">
			<field name="uri" type="char*"/>
			<field name="message" type="char*"/>
			<field name="percentage" type="int"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSModuleCallbackStatusMessageOut">
			<field name="dummy" type="int"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSMonitorHandle">
		</struct>
		<struct name="GnomeVFSProgressCallbackState">
			<field name="progress_info" type="GnomeVFSXferProgressInfo*"/>
			<field name="sync_callback" type="GnomeVFSXferProgressCallback"/>
			<field name="update_callback" type="GnomeVFSXferProgressCallback"/>
			<field name="user_data" type="gpointer"/>
			<field name="async_job_data" type="gpointer"/>
			<field name="next_update_callback_time" type="gint64"/>
			<field name="next_text_update_callback_time" type="gint64"/>
			<field name="update_callback_period" type="gint64"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSResolveHandle">
		</struct>
		<struct name="GnomeVFSToplevelURI">
			<field name="uri" type="GnomeVFSURI"/>
			<field name="host_name" type="gchar*"/>
			<field name="host_port" type="guint"/>
			<field name="user_name" type="gchar*"/>
			<field name="password" type="gchar*"/>
			<field name="urn" type="gchar*"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSURI">
			<method name="append_file_name" symbol="gnome_vfs_uri_append_file_name">
				<return-type type="GnomeVFSURI*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="append_path" symbol="gnome_vfs_uri_append_path">
				<return-type type="GnomeVFSURI*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="append_string" symbol="gnome_vfs_uri_append_string">
				<return-type type="GnomeVFSURI*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
					<parameter name="uri_fragment" type="char*"/>
				</parameters>
			</method>
			<method name="dup" symbol="gnome_vfs_uri_dup">
				<return-type type="GnomeVFSURI*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="equal" symbol="gnome_vfs_uri_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="a" type="GnomeVFSURI*"/>
					<parameter name="b" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="exists" symbol="gnome_vfs_uri_exists">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="extract_dirname" symbol="gnome_vfs_uri_extract_dirname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="extract_short_name" symbol="gnome_vfs_uri_extract_short_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="extract_short_path_name" symbol="gnome_vfs_uri_extract_short_path_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="get_fragment_identifier" symbol="gnome_vfs_uri_get_fragment_identifier">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="get_host_name" symbol="gnome_vfs_uri_get_host_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="get_host_port" symbol="gnome_vfs_uri_get_host_port">
				<return-type type="guint"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="gnome_vfs_uri_get_parent">
				<return-type type="GnomeVFSURI*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="get_password" symbol="gnome_vfs_uri_get_password">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="get_path" symbol="gnome_vfs_uri_get_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="get_scheme" symbol="gnome_vfs_uri_get_scheme">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="get_toplevel" symbol="gnome_vfs_uri_get_toplevel">
				<return-type type="GnomeVFSToplevelURI*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="get_user_name" symbol="gnome_vfs_uri_get_user_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="has_parent" symbol="gnome_vfs_uri_has_parent">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="hash" symbol="gnome_vfs_uri_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="p" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="hequal" symbol="gnome_vfs_uri_hequal">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="gconstpointer"/>
					<parameter name="b" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="is_local" symbol="gnome_vfs_uri_is_local">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="is_parent" symbol="gnome_vfs_uri_is_parent">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="possible_parent" type="GnomeVFSURI*"/>
					<parameter name="possible_child" type="GnomeVFSURI*"/>
					<parameter name="recursive" type="gboolean"/>
				</parameters>
			</method>
			<method name="list_copy" symbol="gnome_vfs_uri_list_copy">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="list_free" symbol="gnome_vfs_uri_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="list_parse" symbol="gnome_vfs_uri_list_parse">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="uri_list" type="gchar*"/>
				</parameters>
			</method>
			<method name="list_ref" symbol="gnome_vfs_uri_list_ref">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="list_unref" symbol="gnome_vfs_uri_list_unref">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="make_full_from_relative" symbol="gnome_vfs_uri_make_full_from_relative">
				<return-type type="char*"/>
				<parameters>
					<parameter name="base_uri" type="char*"/>
					<parameter name="relative_uri" type="char*"/>
				</parameters>
			</method>
			<method name="new" symbol="gnome_vfs_uri_new">
				<return-type type="GnomeVFSURI*"/>
				<parameters>
					<parameter name="text_uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="ref" symbol="gnome_vfs_uri_ref">
				<return-type type="GnomeVFSURI*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<method name="resolve_relative" symbol="gnome_vfs_uri_resolve_relative">
				<return-type type="GnomeVFSURI*"/>
				<parameters>
					<parameter name="base" type="GnomeVFSURI*"/>
					<parameter name="relative_reference" type="gchar*"/>
				</parameters>
			</method>
			<method name="resolve_symbolic_link" symbol="gnome_vfs_uri_resolve_symbolic_link">
				<return-type type="GnomeVFSURI*"/>
				<parameters>
					<parameter name="base" type="GnomeVFSURI*"/>
					<parameter name="relative_reference" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_host_name" symbol="gnome_vfs_uri_set_host_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
					<parameter name="host_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_host_port" symbol="gnome_vfs_uri_set_host_port">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
					<parameter name="host_port" type="guint"/>
				</parameters>
			</method>
			<method name="set_password" symbol="gnome_vfs_uri_set_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
					<parameter name="password" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_user_name" symbol="gnome_vfs_uri_set_user_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
					<parameter name="user_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="gnome_vfs_uri_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
					<parameter name="hide_options" type="GnomeVFSURIHideOptions"/>
				</parameters>
			</method>
			<method name="unref" symbol="gnome_vfs_uri_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="GnomeVFSURI*"/>
				</parameters>
			</method>
			<field name="ref_count" type="guint"/>
			<field name="text" type="gchar*"/>
			<field name="fragment_id" type="gchar*"/>
			<field name="method_string" type="gchar*"/>
			<field name="method" type="struct GnomeVFSMethod*"/>
			<field name="parent" type="struct GnomeVFSURI*"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<struct name="GnomeVFSXferProgressInfo">
			<field name="status" type="GnomeVFSXferProgressStatus"/>
			<field name="vfs_status" type="GnomeVFSResult"/>
			<field name="phase" type="GnomeVFSXferPhase"/>
			<field name="source_name" type="gchar*"/>
			<field name="target_name" type="gchar*"/>
			<field name="file_index" type="gulong"/>
			<field name="files_total" type="gulong"/>
			<field name="bytes_total" type="GnomeVFSFileSize"/>
			<field name="file_size" type="GnomeVFSFileSize"/>
			<field name="bytes_copied" type="GnomeVFSFileSize"/>
			<field name="total_bytes_copied" type="GnomeVFSFileSize"/>
			<field name="duplicate_name" type="gchar*"/>
			<field name="duplicate_count" type="int"/>
			<field name="top_level_item" type="gboolean"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
		</struct>
		<boxed name="GnomeVFSAddress" type-name="GnomeVFSAddress" get-type="gnome_vfs_address_get_type">
			<method name="dup" symbol="gnome_vfs_address_dup">
				<return-type type="GnomeVFSAddress*"/>
				<parameters>
					<parameter name="address" type="GnomeVFSAddress*"/>
				</parameters>
			</method>
			<method name="equal" symbol="gnome_vfs_address_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="a" type="GnomeVFSAddress*"/>
					<parameter name="b" type="GnomeVFSAddress*"/>
				</parameters>
			</method>
			<method name="free" symbol="gnome_vfs_address_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="address" type="GnomeVFSAddress*"/>
				</parameters>
			</method>
			<method name="get_family_type" symbol="gnome_vfs_address_get_family_type">
				<return-type type="int"/>
				<parameters>
					<parameter name="address" type="GnomeVFSAddress*"/>
				</parameters>
			</method>
			<method name="get_ipv4" symbol="gnome_vfs_address_get_ipv4">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="address" type="GnomeVFSAddress*"/>
				</parameters>
			</method>
			<method name="get_sockaddr" symbol="gnome_vfs_address_get_sockaddr">
				<return-type type="struct sockaddr*"/>
				<parameters>
					<parameter name="address" type="GnomeVFSAddress*"/>
					<parameter name="port" type="guint16"/>
					<parameter name="len" type="int*"/>
				</parameters>
			</method>
			<method name="match" symbol="gnome_vfs_address_match">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="a" type="GnomeVFSAddress*"/>
					<parameter name="b" type="GnomeVFSAddress*"/>
					<parameter name="prefix" type="guint"/>
				</parameters>
			</method>
			<constructor name="new_from_ipv4" symbol="gnome_vfs_address_new_from_ipv4">
				<return-type type="GnomeVFSAddress*"/>
				<parameters>
					<parameter name="ipv4_address" type="guint32"/>
				</parameters>
			</constructor>
			<constructor name="new_from_sockaddr" symbol="gnome_vfs_address_new_from_sockaddr">
				<return-type type="GnomeVFSAddress*"/>
				<parameters>
					<parameter name="sa" type="struct sockaddr*"/>
					<parameter name="len" type="int"/>
				</parameters>
			</constructor>
			<constructor name="new_from_string" symbol="gnome_vfs_address_new_from_string">
				<return-type type="GnomeVFSAddress*"/>
				<parameters>
					<parameter name="address" type="char*"/>
				</parameters>
			</constructor>
			<method name="to_string" symbol="gnome_vfs_address_to_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="address" type="GnomeVFSAddress*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="GnomeVFSFileInfo" type-name="GnomeVFSFileInfo" get-type="gnome_vfs_file_info_get_type">
			<method name="clear" symbol="gnome_vfs_file_info_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GnomeVFSFileInfo*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gnome_vfs_file_info_copy">
				<return-type type="void"/>
				<parameters>
					<parameter name="dest" type="GnomeVFSFileInfo*"/>
					<parameter name="src" type="GnomeVFSFileInfo*"/>
				</parameters>
			</method>
			<method name="dup" symbol="gnome_vfs_file_info_dup">
				<return-type type="GnomeVFSFileInfo*"/>
				<parameters>
					<parameter name="orig" type="GnomeVFSFileInfo*"/>
				</parameters>
			</method>
			<method name="get_mime_type" symbol="gnome_vfs_file_info_get_mime_type">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GnomeVFSFileInfo*"/>
				</parameters>
			</method>
			<method name="list_copy" symbol="gnome_vfs_file_info_list_copy">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="list_free" symbol="gnome_vfs_file_info_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="list_ref" symbol="gnome_vfs_file_info_list_ref">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="list_unref" symbol="gnome_vfs_file_info_list_unref">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="matches" symbol="gnome_vfs_file_info_matches">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="a" type="GnomeVFSFileInfo*"/>
					<parameter name="b" type="GnomeVFSFileInfo*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_vfs_file_info_new">
				<return-type type="GnomeVFSFileInfo*"/>
			</constructor>
			<method name="ref" symbol="gnome_vfs_file_info_ref">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GnomeVFSFileInfo*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gnome_vfs_file_info_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GnomeVFSFileInfo*"/>
				</parameters>
			</method>
			<field name="name" type="char*"/>
			<field name="valid_fields" type="GnomeVFSFileInfoFields"/>
			<field name="type" type="GnomeVFSFileType"/>
			<field name="permissions" type="GnomeVFSFilePermissions"/>
			<field name="flags" type="GnomeVFSFileFlags"/>
			<field name="device" type="dev_t"/>
			<field name="inode" type="GnomeVFSInodeNumber"/>
			<field name="link_count" type="guint"/>
			<field name="uid" type="guint"/>
			<field name="gid" type="guint"/>
			<field name="size" type="GnomeVFSFileSize"/>
			<field name="block_count" type="GnomeVFSFileSize"/>
			<field name="io_block_size" type="guint"/>
			<field name="atime" type="time_t"/>
			<field name="mtime" type="time_t"/>
			<field name="ctime" type="time_t"/>
			<field name="symlink_name" type="char*"/>
			<field name="mime_type" type="char*"/>
			<field name="refcount" type="guint"/>
			<field name="acl" type="GnomeVFSACL*"/>
			<field name="selinux_context" type="char*"/>
			<field name="reserved1" type="void*"/>
			<field name="reserved2" type="void*"/>
			<field name="reserved3" type="void*"/>
		</boxed>
		<boxed name="GnomeVfsFindDirectoryResult" type-name="GnomeVfsFindDirectoryResult" get-type="gnome_vfs_find_directory_result_get_type">
		</boxed>
		<boxed name="GnomeVfsGetFileInfoResult" type-name="GnomeVfsGetFileInfoResult" get-type="gnome_vfs_get_file_info_result_get_type">
		</boxed>
		<enum name="GnomeVFSDNSSDServiceStatus" type-name="GnomeVFSDNSSDServiceStatus" get-type="gnome_vfs_dns_sd_service_status_get_type">
			<member name="GNOME_VFS_DNS_SD_SERVICE_ADDED" value="0"/>
			<member name="GNOME_VFS_DNS_SD_SERVICE_REMOVED" value="1"/>
		</enum>
		<enum name="GnomeVFSDeviceType" type-name="GnomeVFSDeviceType" get-type="gnome_vfs_device_type_get_type">
			<member name="GNOME_VFS_DEVICE_TYPE_UNKNOWN" value="0"/>
			<member name="GNOME_VFS_DEVICE_TYPE_AUDIO_CD" value="1"/>
			<member name="GNOME_VFS_DEVICE_TYPE_VIDEO_DVD" value="2"/>
			<member name="GNOME_VFS_DEVICE_TYPE_HARDDRIVE" value="3"/>
			<member name="GNOME_VFS_DEVICE_TYPE_CDROM" value="4"/>
			<member name="GNOME_VFS_DEVICE_TYPE_FLOPPY" value="5"/>
			<member name="GNOME_VFS_DEVICE_TYPE_ZIP" value="6"/>
			<member name="GNOME_VFS_DEVICE_TYPE_JAZ" value="7"/>
			<member name="GNOME_VFS_DEVICE_TYPE_NFS" value="8"/>
			<member name="GNOME_VFS_DEVICE_TYPE_AUTOFS" value="9"/>
			<member name="GNOME_VFS_DEVICE_TYPE_CAMERA" value="10"/>
			<member name="GNOME_VFS_DEVICE_TYPE_MEMORY_STICK" value="11"/>
			<member name="GNOME_VFS_DEVICE_TYPE_SMB" value="12"/>
			<member name="GNOME_VFS_DEVICE_TYPE_APPLE" value="13"/>
			<member name="GNOME_VFS_DEVICE_TYPE_MUSIC_PLAYER" value="14"/>
			<member name="GNOME_VFS_DEVICE_TYPE_WINDOWS" value="15"/>
			<member name="GNOME_VFS_DEVICE_TYPE_LOOPBACK" value="16"/>
			<member name="GNOME_VFS_DEVICE_TYPE_NETWORK" value="17"/>
		</enum>
		<enum name="GnomeVFSFileType" type-name="GnomeVFSFileType" get-type="gnome_vfs_file_type_get_type">
			<member name="GNOME_VFS_FILE_TYPE_UNKNOWN" value="0"/>
			<member name="GNOME_VFS_FILE_TYPE_REGULAR" value="1"/>
			<member name="GNOME_VFS_FILE_TYPE_DIRECTORY" value="2"/>
			<member name="GNOME_VFS_FILE_TYPE_FIFO" value="3"/>
			<member name="GNOME_VFS_FILE_TYPE_SOCKET" value="4"/>
			<member name="GNOME_VFS_FILE_TYPE_CHARACTER_DEVICE" value="5"/>
			<member name="GNOME_VFS_FILE_TYPE_BLOCK_DEVICE" value="6"/>
			<member name="GNOME_VFS_FILE_TYPE_SYMBOLIC_LINK" value="7"/>
		</enum>
		<enum name="GnomeVFSFindDirectoryKind" type-name="GnomeVFSFindDirectoryKind" get-type="gnome_vfs_find_directory_kind_get_type">
			<member name="GNOME_VFS_DIRECTORY_KIND_DESKTOP" value="1000"/>
			<member name="GNOME_VFS_DIRECTORY_KIND_TRASH" value="1001"/>
		</enum>
		<enum name="GnomeVFSMimeActionType" type-name="GnomeVFSMimeActionType" get-type="gnome_vfs_mime_action_type_get_type">
			<member name="GNOME_VFS_MIME_ACTION_TYPE_NONE" value="0"/>
			<member name="GNOME_VFS_MIME_ACTION_TYPE_APPLICATION" value="1"/>
			<member name="GNOME_VFS_MIME_ACTION_TYPE_COMPONENT" value="2"/>
		</enum>
		<enum name="GnomeVFSMimeApplicationArgumentType" type-name="GnomeVFSMimeApplicationArgumentType" get-type="gnome_vfs_mime_application_argument_type_get_type">
			<member name="GNOME_VFS_MIME_APPLICATION_ARGUMENT_TYPE_URIS" value="0"/>
			<member name="GNOME_VFS_MIME_APPLICATION_ARGUMENT_TYPE_PATHS" value="1"/>
			<member name="GNOME_VFS_MIME_APPLICATION_ARGUMENT_TYPE_URIS_FOR_NON_FILES" value="2"/>
		</enum>
		<enum name="GnomeVFSMimeEquivalence" type-name="GnomeVFSMimeEquivalence" get-type="gnome_vfs_mime_equivalence_get_type">
			<member name="GNOME_VFS_MIME_UNRELATED" value="0"/>
			<member name="GNOME_VFS_MIME_IDENTICAL" value="1"/>
			<member name="GNOME_VFS_MIME_PARENT" value="2"/>
		</enum>
		<enum name="GnomeVFSModuleCallbackAuthenticationAuthType" type-name="GnomeVFSModuleCallbackAuthenticationAuthType" get-type="gnome_vfs_module_callback_authentication_auth_type_get_type">
			<member name="AuthTypeBasic" value="0"/>
			<member name="AuthTypeDigest" value="1"/>
		</enum>
		<enum name="GnomeVFSMonitorEventType" type-name="GnomeVFSMonitorEventType" get-type="gnome_vfs_monitor_event_type_get_type">
			<member name="GNOME_VFS_MONITOR_EVENT_CHANGED" value="0"/>
			<member name="GNOME_VFS_MONITOR_EVENT_DELETED" value="1"/>
			<member name="GNOME_VFS_MONITOR_EVENT_STARTEXECUTING" value="2"/>
			<member name="GNOME_VFS_MONITOR_EVENT_STOPEXECUTING" value="3"/>
			<member name="GNOME_VFS_MONITOR_EVENT_CREATED" value="4"/>
			<member name="GNOME_VFS_MONITOR_EVENT_METADATA_CHANGED" value="5"/>
		</enum>
		<enum name="GnomeVFSMonitorType" type-name="GnomeVFSMonitorType" get-type="gnome_vfs_monitor_type_get_type">
			<member name="GNOME_VFS_MONITOR_FILE" value="0"/>
			<member name="GNOME_VFS_MONITOR_DIRECTORY" value="1"/>
		</enum>
		<enum name="GnomeVFSResult" type-name="GnomeVFSResult" get-type="gnome_vfs_result_get_type">
			<member name="GNOME_VFS_OK" value="0"/>
			<member name="GNOME_VFS_ERROR_NOT_FOUND" value="1"/>
			<member name="GNOME_VFS_ERROR_GENERIC" value="2"/>
			<member name="GNOME_VFS_ERROR_INTERNAL" value="3"/>
			<member name="GNOME_VFS_ERROR_BAD_PARAMETERS" value="4"/>
			<member name="GNOME_VFS_ERROR_NOT_SUPPORTED" value="5"/>
			<member name="GNOME_VFS_ERROR_IO" value="6"/>
			<member name="GNOME_VFS_ERROR_CORRUPTED_DATA" value="7"/>
			<member name="GNOME_VFS_ERROR_WRONG_FORMAT" value="8"/>
			<member name="GNOME_VFS_ERROR_BAD_FILE" value="9"/>
			<member name="GNOME_VFS_ERROR_TOO_BIG" value="10"/>
			<member name="GNOME_VFS_ERROR_NO_SPACE" value="11"/>
			<member name="GNOME_VFS_ERROR_READ_ONLY" value="12"/>
			<member name="GNOME_VFS_ERROR_INVALID_URI" value="13"/>
			<member name="GNOME_VFS_ERROR_NOT_OPEN" value="14"/>
			<member name="GNOME_VFS_ERROR_INVALID_OPEN_MODE" value="15"/>
			<member name="GNOME_VFS_ERROR_ACCESS_DENIED" value="16"/>
			<member name="GNOME_VFS_ERROR_TOO_MANY_OPEN_FILES" value="17"/>
			<member name="GNOME_VFS_ERROR_EOF" value="18"/>
			<member name="GNOME_VFS_ERROR_NOT_A_DIRECTORY" value="19"/>
			<member name="GNOME_VFS_ERROR_IN_PROGRESS" value="20"/>
			<member name="GNOME_VFS_ERROR_INTERRUPTED" value="21"/>
			<member name="GNOME_VFS_ERROR_FILE_EXISTS" value="22"/>
			<member name="GNOME_VFS_ERROR_LOOP" value="23"/>
			<member name="GNOME_VFS_ERROR_NOT_PERMITTED" value="24"/>
			<member name="GNOME_VFS_ERROR_IS_DIRECTORY" value="25"/>
			<member name="GNOME_VFS_ERROR_NO_MEMORY" value="26"/>
			<member name="GNOME_VFS_ERROR_HOST_NOT_FOUND" value="27"/>
			<member name="GNOME_VFS_ERROR_INVALID_HOST_NAME" value="28"/>
			<member name="GNOME_VFS_ERROR_HOST_HAS_NO_ADDRESS" value="29"/>
			<member name="GNOME_VFS_ERROR_LOGIN_FAILED" value="30"/>
			<member name="GNOME_VFS_ERROR_CANCELLED" value="31"/>
			<member name="GNOME_VFS_ERROR_DIRECTORY_BUSY" value="32"/>
			<member name="GNOME_VFS_ERROR_DIRECTORY_NOT_EMPTY" value="33"/>
			<member name="GNOME_VFS_ERROR_TOO_MANY_LINKS" value="34"/>
			<member name="GNOME_VFS_ERROR_READ_ONLY_FILE_SYSTEM" value="35"/>
			<member name="GNOME_VFS_ERROR_NOT_SAME_FILE_SYSTEM" value="36"/>
			<member name="GNOME_VFS_ERROR_NAME_TOO_LONG" value="37"/>
			<member name="GNOME_VFS_ERROR_SERVICE_NOT_AVAILABLE" value="38"/>
			<member name="GNOME_VFS_ERROR_SERVICE_OBSOLETE" value="39"/>
			<member name="GNOME_VFS_ERROR_PROTOCOL_ERROR" value="40"/>
			<member name="GNOME_VFS_ERROR_NO_MASTER_BROWSER" value="41"/>
			<member name="GNOME_VFS_ERROR_NO_DEFAULT" value="42"/>
			<member name="GNOME_VFS_ERROR_NO_HANDLER" value="43"/>
			<member name="GNOME_VFS_ERROR_PARSE" value="44"/>
			<member name="GNOME_VFS_ERROR_LAUNCH" value="45"/>
			<member name="GNOME_VFS_ERROR_TIMEOUT" value="46"/>
			<member name="GNOME_VFS_ERROR_NAMESERVER" value="47"/>
			<member name="GNOME_VFS_ERROR_LOCKED" value="48"/>
			<member name="GNOME_VFS_ERROR_DEPRECATED_FUNCTION" value="49"/>
			<member name="GNOME_VFS_ERROR_INVALID_FILENAME" value="50"/>
			<member name="GNOME_VFS_ERROR_NOT_A_SYMBOLIC_LINK" value="51"/>
			<member name="GNOME_VFS_NUM_ERRORS" value="52"/>
		</enum>
		<enum name="GnomeVFSSeekPosition" type-name="GnomeVFSSeekPosition" get-type="gnome_vfs_seek_position_get_type">
			<member name="GNOME_VFS_SEEK_START" value="0"/>
			<member name="GNOME_VFS_SEEK_CURRENT" value="1"/>
			<member name="GNOME_VFS_SEEK_END" value="2"/>
		</enum>
		<enum name="GnomeVFSVolumeType" type-name="GnomeVFSVolumeType" get-type="gnome_vfs_volume_type_get_type">
			<member name="GNOME_VFS_VOLUME_TYPE_MOUNTPOINT" value="0"/>
			<member name="GNOME_VFS_VOLUME_TYPE_VFS_MOUNT" value="1"/>
			<member name="GNOME_VFS_VOLUME_TYPE_CONNECTED_SERVER" value="2"/>
		</enum>
		<enum name="GnomeVFSXferErrorAction" type-name="GnomeVFSXferErrorAction" get-type="gnome_vfs_xfer_error_action_get_type">
			<member name="GNOME_VFS_XFER_ERROR_ACTION_ABORT" value="0"/>
			<member name="GNOME_VFS_XFER_ERROR_ACTION_RETRY" value="1"/>
			<member name="GNOME_VFS_XFER_ERROR_ACTION_SKIP" value="2"/>
		</enum>
		<enum name="GnomeVFSXferErrorMode" type-name="GnomeVFSXferErrorMode" get-type="gnome_vfs_xfer_error_mode_get_type">
			<member name="GNOME_VFS_XFER_ERROR_MODE_ABORT" value="0"/>
			<member name="GNOME_VFS_XFER_ERROR_MODE_QUERY" value="1"/>
		</enum>
		<enum name="GnomeVFSXferOverwriteAction" type-name="GnomeVFSXferOverwriteAction" get-type="gnome_vfs_xfer_overwrite_action_get_type">
			<member name="GNOME_VFS_XFER_OVERWRITE_ACTION_ABORT" value="0"/>
			<member name="GNOME_VFS_XFER_OVERWRITE_ACTION_REPLACE" value="1"/>
			<member name="GNOME_VFS_XFER_OVERWRITE_ACTION_REPLACE_ALL" value="2"/>
			<member name="GNOME_VFS_XFER_OVERWRITE_ACTION_SKIP" value="3"/>
			<member name="GNOME_VFS_XFER_OVERWRITE_ACTION_SKIP_ALL" value="4"/>
		</enum>
		<enum name="GnomeVFSXferOverwriteMode" type-name="GnomeVFSXferOverwriteMode" get-type="gnome_vfs_xfer_overwrite_mode_get_type">
			<member name="GNOME_VFS_XFER_OVERWRITE_MODE_ABORT" value="0"/>
			<member name="GNOME_VFS_XFER_OVERWRITE_MODE_QUERY" value="1"/>
			<member name="GNOME_VFS_XFER_OVERWRITE_MODE_REPLACE" value="2"/>
			<member name="GNOME_VFS_XFER_OVERWRITE_MODE_SKIP" value="3"/>
		</enum>
		<enum name="GnomeVFSXferPhase" type-name="GnomeVFSXferPhase" get-type="gnome_vfs_xfer_phase_get_type">
			<member name="GNOME_VFS_XFER_PHASE_INITIAL" value="0"/>
			<member name="GNOME_VFS_XFER_CHECKING_DESTINATION" value="1"/>
			<member name="GNOME_VFS_XFER_PHASE_COLLECTING" value="2"/>
			<member name="GNOME_VFS_XFER_PHASE_READYTOGO" value="3"/>
			<member name="GNOME_VFS_XFER_PHASE_OPENSOURCE" value="4"/>
			<member name="GNOME_VFS_XFER_PHASE_OPENTARGET" value="5"/>
			<member name="GNOME_VFS_XFER_PHASE_COPYING" value="6"/>
			<member name="GNOME_VFS_XFER_PHASE_MOVING" value="7"/>
			<member name="GNOME_VFS_XFER_PHASE_READSOURCE" value="8"/>
			<member name="GNOME_VFS_XFER_PHASE_WRITETARGET" value="9"/>
			<member name="GNOME_VFS_XFER_PHASE_CLOSESOURCE" value="10"/>
			<member name="GNOME_VFS_XFER_PHASE_CLOSETARGET" value="11"/>
			<member name="GNOME_VFS_XFER_PHASE_DELETESOURCE" value="12"/>
			<member name="GNOME_VFS_XFER_PHASE_SETATTRIBUTES" value="13"/>
			<member name="GNOME_VFS_XFER_PHASE_FILECOMPLETED" value="14"/>
			<member name="GNOME_VFS_XFER_PHASE_CLEANUP" value="15"/>
			<member name="GNOME_VFS_XFER_PHASE_COMPLETED" value="16"/>
			<member name="GNOME_VFS_XFER_NUM_PHASES" value="17"/>
		</enum>
		<enum name="GnomeVFSXferProgressStatus" type-name="GnomeVFSXferProgressStatus" get-type="gnome_vfs_xfer_progress_status_get_type">
			<member name="GNOME_VFS_XFER_PROGRESS_STATUS_OK" value="0"/>
			<member name="GNOME_VFS_XFER_PROGRESS_STATUS_VFSERROR" value="1"/>
			<member name="GNOME_VFS_XFER_PROGRESS_STATUS_OVERWRITE" value="2"/>
			<member name="GNOME_VFS_XFER_PROGRESS_STATUS_DUPLICATE" value="3"/>
		</enum>
		<flags name="GnomeVFSDirectoryVisitOptions" type-name="GnomeVFSDirectoryVisitOptions" get-type="gnome_vfs_directory_visit_options_get_type">
			<member name="GNOME_VFS_DIRECTORY_VISIT_DEFAULT" value="0"/>
			<member name="GNOME_VFS_DIRECTORY_VISIT_SAMEFS" value="1"/>
			<member name="GNOME_VFS_DIRECTORY_VISIT_LOOPCHECK" value="2"/>
			<member name="GNOME_VFS_DIRECTORY_VISIT_IGNORE_RECURSE_ERROR" value="4"/>
		</flags>
		<flags name="GnomeVFSFileFlags" type-name="GnomeVFSFileFlags" get-type="gnome_vfs_file_flags_get_type">
			<member name="GNOME_VFS_FILE_FLAGS_NONE" value="0"/>
			<member name="GNOME_VFS_FILE_FLAGS_SYMLINK" value="1"/>
			<member name="GNOME_VFS_FILE_FLAGS_LOCAL" value="2"/>
		</flags>
		<flags name="GnomeVFSFileInfoFields" type-name="GnomeVFSFileInfoFields" get-type="gnome_vfs_file_info_fields_get_type">
			<member name="GNOME_VFS_FILE_INFO_FIELDS_NONE" value="0"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_TYPE" value="1"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_PERMISSIONS" value="2"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_FLAGS" value="4"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_DEVICE" value="8"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_INODE" value="16"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_LINK_COUNT" value="32"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_SIZE" value="64"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_BLOCK_COUNT" value="128"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_IO_BLOCK_SIZE" value="256"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_ATIME" value="512"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_MTIME" value="1024"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_CTIME" value="2048"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_SYMLINK_NAME" value="4096"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_MIME_TYPE" value="8192"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_ACCESS" value="16384"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_IDS" value="32768"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_ACL" value="65536"/>
			<member name="GNOME_VFS_FILE_INFO_FIELDS_SELINUX_CONTEXT" value="131072"/>
		</flags>
		<flags name="GnomeVFSFileInfoOptions" type-name="GnomeVFSFileInfoOptions" get-type="gnome_vfs_file_info_options_get_type">
			<member name="GNOME_VFS_FILE_INFO_DEFAULT" value="0"/>
			<member name="GNOME_VFS_FILE_INFO_GET_MIME_TYPE" value="1"/>
			<member name="GNOME_VFS_FILE_INFO_FORCE_FAST_MIME_TYPE" value="2"/>
			<member name="GNOME_VFS_FILE_INFO_FORCE_SLOW_MIME_TYPE" value="4"/>
			<member name="GNOME_VFS_FILE_INFO_FOLLOW_LINKS" value="8"/>
			<member name="GNOME_VFS_FILE_INFO_GET_ACCESS_RIGHTS" value="16"/>
			<member name="GNOME_VFS_FILE_INFO_NAME_ONLY" value="32"/>
			<member name="GNOME_VFS_FILE_INFO_GET_ACL" value="64"/>
			<member name="GNOME_VFS_FILE_INFO_GET_SELINUX_CONTEXT" value="128"/>
		</flags>
		<flags name="GnomeVFSFilePermissions" type-name="GnomeVFSFilePermissions" get-type="gnome_vfs_file_permissions_get_type">
			<member name="GNOME_VFS_PERM_SUID" value="2048"/>
			<member name="GNOME_VFS_PERM_SGID" value="1024"/>
			<member name="GNOME_VFS_PERM_STICKY" value="512"/>
			<member name="GNOME_VFS_PERM_USER_READ" value="256"/>
			<member name="GNOME_VFS_PERM_USER_WRITE" value="128"/>
			<member name="GNOME_VFS_PERM_USER_EXEC" value="64"/>
			<member name="GNOME_VFS_PERM_USER_ALL" value="448"/>
			<member name="GNOME_VFS_PERM_GROUP_READ" value="32"/>
			<member name="GNOME_VFS_PERM_GROUP_WRITE" value="16"/>
			<member name="GNOME_VFS_PERM_GROUP_EXEC" value="8"/>
			<member name="GNOME_VFS_PERM_GROUP_ALL" value="56"/>
			<member name="GNOME_VFS_PERM_OTHER_READ" value="4"/>
			<member name="GNOME_VFS_PERM_OTHER_WRITE" value="2"/>
			<member name="GNOME_VFS_PERM_OTHER_EXEC" value="1"/>
			<member name="GNOME_VFS_PERM_OTHER_ALL" value="7"/>
			<member name="GNOME_VFS_PERM_ACCESS_READABLE" value="65536"/>
			<member name="GNOME_VFS_PERM_ACCESS_WRITABLE" value="131072"/>
			<member name="GNOME_VFS_PERM_ACCESS_EXECUTABLE" value="262144"/>
		</flags>
		<flags name="GnomeVFSMakeURIDirs" type-name="GnomeVFSMakeURIDirs" get-type="gnome_vfs_make_uri_dirs_get_type">
			<member name="GNOME_VFS_MAKE_URI_DIR_NONE" value="0"/>
			<member name="GNOME_VFS_MAKE_URI_DIR_HOMEDIR" value="1"/>
			<member name="GNOME_VFS_MAKE_URI_DIR_CURRENT" value="2"/>
		</flags>
		<flags name="GnomeVFSModuleCallbackFullAuthenticationFlags" type-name="GnomeVFSModuleCallbackFullAuthenticationFlags" get-type="gnome_vfs_module_callback_full_authentication_flags_get_type">
			<member name="GNOME_VFS_MODULE_CALLBACK_FULL_AUTHENTICATION_PREVIOUS_ATTEMPT_FAILED" value="1"/>
			<member name="GNOME_VFS_MODULE_CALLBACK_FULL_AUTHENTICATION_NEED_PASSWORD" value="2"/>
			<member name="GNOME_VFS_MODULE_CALLBACK_FULL_AUTHENTICATION_NEED_USERNAME" value="4"/>
			<member name="GNOME_VFS_MODULE_CALLBACK_FULL_AUTHENTICATION_NEED_DOMAIN" value="8"/>
			<member name="GNOME_VFS_MODULE_CALLBACK_FULL_AUTHENTICATION_SAVING_SUPPORTED" value="16"/>
			<member name="GNOME_VFS_MODULE_CALLBACK_FULL_AUTHENTICATION_ANON_SUPPORTED" value="32"/>
		</flags>
		<flags name="GnomeVFSModuleCallbackFullAuthenticationOutFlags" type-name="GnomeVFSModuleCallbackFullAuthenticationOutFlags" get-type="gnome_vfs_module_callback_full_authentication_out_flags_get_type">
			<member name="GNOME_VFS_MODULE_CALLBACK_FULL_AUTHENTICATION_OUT_ANON_SELECTED" value="1"/>
		</flags>
		<flags name="GnomeVFSOpenMode" type-name="GnomeVFSOpenMode" get-type="gnome_vfs_open_mode_get_type">
			<member name="GNOME_VFS_OPEN_NONE" value="0"/>
			<member name="GNOME_VFS_OPEN_READ" value="1"/>
			<member name="GNOME_VFS_OPEN_WRITE" value="2"/>
			<member name="GNOME_VFS_OPEN_RANDOM" value="4"/>
			<member name="GNOME_VFS_OPEN_TRUNCATE" value="8"/>
		</flags>
		<flags name="GnomeVFSSetFileInfoMask" type-name="GnomeVFSSetFileInfoMask" get-type="gnome_vfs_set_file_info_mask_get_type">
			<member name="GNOME_VFS_SET_FILE_INFO_NONE" value="0"/>
			<member name="GNOME_VFS_SET_FILE_INFO_NAME" value="1"/>
			<member name="GNOME_VFS_SET_FILE_INFO_PERMISSIONS" value="2"/>
			<member name="GNOME_VFS_SET_FILE_INFO_OWNER" value="4"/>
			<member name="GNOME_VFS_SET_FILE_INFO_TIME" value="8"/>
			<member name="GNOME_VFS_SET_FILE_INFO_ACL" value="16"/>
			<member name="GNOME_VFS_SET_FILE_INFO_SELINUX_CONTEXT" value="32"/>
			<member name="GNOME_VFS_SET_FILE_INFO_SYMLINK_NAME" value="64"/>
		</flags>
		<flags name="GnomeVFSURIHideOptions" type-name="GnomeVFSURIHideOptions" get-type="gnome_vfs_uri_hide_options_get_type">
			<member name="GNOME_VFS_URI_HIDE_NONE" value="0"/>
			<member name="GNOME_VFS_URI_HIDE_USER_NAME" value="1"/>
			<member name="GNOME_VFS_URI_HIDE_PASSWORD" value="2"/>
			<member name="GNOME_VFS_URI_HIDE_HOST_NAME" value="4"/>
			<member name="GNOME_VFS_URI_HIDE_HOST_PORT" value="8"/>
			<member name="GNOME_VFS_URI_HIDE_TOPLEVEL_METHOD" value="16"/>
			<member name="GNOME_VFS_URI_HIDE_FRAGMENT_IDENTIFIER" value="256"/>
		</flags>
		<flags name="GnomeVFSXferOptions" type-name="GnomeVFSXferOptions" get-type="gnome_vfs_xfer_options_get_type">
			<member name="GNOME_VFS_XFER_DEFAULT" value="0"/>
			<member name="GNOME_VFS_XFER_UNUSED_1" value="1"/>
			<member name="GNOME_VFS_XFER_FOLLOW_LINKS" value="2"/>
			<member name="GNOME_VFS_XFER_UNUSED_2" value="4"/>
			<member name="GNOME_VFS_XFER_RECURSIVE" value="8"/>
			<member name="GNOME_VFS_XFER_SAMEFS" value="16"/>
			<member name="GNOME_VFS_XFER_DELETE_ITEMS" value="32"/>
			<member name="GNOME_VFS_XFER_EMPTY_DIRECTORIES" value="64"/>
			<member name="GNOME_VFS_XFER_NEW_UNIQUE_DIRECTORY" value="128"/>
			<member name="GNOME_VFS_XFER_REMOVESOURCE" value="256"/>
			<member name="GNOME_VFS_XFER_USE_UNIQUE_NAMES" value="512"/>
			<member name="GNOME_VFS_XFER_LINK_ITEMS" value="1024"/>
			<member name="GNOME_VFS_XFER_FOLLOW_LINKS_RECURSIVE" value="2048"/>
			<member name="GNOME_VFS_XFER_TARGET_DEFAULT_PERMS" value="4096"/>
		</flags>
		<object name="GnomeVFSACE" parent="GObject" type-name="GnomeVFSACE" get-type="gnome_vfs_ace_get_type">
			<method name="add_perm" symbol="gnome_vfs_ace_add_perm">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
					<parameter name="perm" type="GnomeVFSACLPerm"/>
				</parameters>
			</method>
			<method name="check_perm" symbol="gnome_vfs_ace_check_perm">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
					<parameter name="perm" type="GnomeVFSACLPerm"/>
				</parameters>
			</method>
			<method name="copy_perms" symbol="gnome_vfs_ace_copy_perms">
				<return-type type="void"/>
				<parameters>
					<parameter name="source" type="GnomeVFSACE*"/>
					<parameter name="dest" type="GnomeVFSACE*"/>
				</parameters>
			</method>
			<method name="del_perm" symbol="gnome_vfs_ace_del_perm">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
					<parameter name="perm" type="GnomeVFSACLPerm"/>
				</parameters>
			</method>
			<method name="equal" symbol="gnome_vfs_ace_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry_a" type="GnomeVFSACE*"/>
					<parameter name="entry_b" type="GnomeVFSACE*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gnome_vfs_ace_get_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
				</parameters>
			</method>
			<method name="get_inherit" symbol="gnome_vfs_ace_get_inherit">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
				</parameters>
			</method>
			<method name="get_kind" symbol="gnome_vfs_ace_get_kind">
				<return-type type="GnomeVFSACLKind"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
				</parameters>
			</method>
			<method name="get_negative" symbol="gnome_vfs_ace_get_negative">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
				</parameters>
			</method>
			<method name="get_perms" symbol="gnome_vfs_ace_get_perms">
				<return-type type="GnomeVFSACLPerm*"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_vfs_ace_new">
				<return-type type="GnomeVFSACE*"/>
				<parameters>
					<parameter name="kind" type="GnomeVFSACLKind"/>
					<parameter name="id" type="char*"/>
					<parameter name="perms" type="GnomeVFSACLPerm*"/>
				</parameters>
			</constructor>
			<method name="set_id" symbol="gnome_vfs_ace_set_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
					<parameter name="id" type="char*"/>
				</parameters>
			</method>
			<method name="set_inherit" symbol="gnome_vfs_ace_set_inherit">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
					<parameter name="inherit" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_kind" symbol="gnome_vfs_ace_set_kind">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
					<parameter name="kind" type="GnomeVFSACLKind"/>
				</parameters>
			</method>
			<method name="set_negative" symbol="gnome_vfs_ace_set_negative">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
					<parameter name="negative" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_perms" symbol="gnome_vfs_ace_set_perms">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GnomeVFSACE*"/>
					<parameter name="perms" type="GnomeVFSACLPerm*"/>
				</parameters>
			</method>
			<property name="id" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="inherit" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="kind" type="guint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="negative" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="permissions" type="gpointer" readable="1" writable="1" construct="1" construct-only="0"/>
			<vfunc name="reserved1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="reserved4">
				<return-type type="void"/>
			</vfunc>
		</object>
		<object name="GnomeVFSACL" parent="GObject" type-name="GnomeVFSACL" get-type="gnome_vfs_acl_get_type">
			<method name="clear" symbol="gnome_vfs_acl_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="acl" type="GnomeVFSACL*"/>
				</parameters>
			</method>
			<method name="free_ace_list" symbol="gnome_vfs_acl_free_ace_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="ace_list" type="GList*"/>
				</parameters>
			</method>
			<method name="get_ace_list" symbol="gnome_vfs_acl_get_ace_list">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="acl" type="GnomeVFSACL*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_vfs_acl_new">
				<return-type type="GnomeVFSACL*"/>
			</constructor>
			<method name="set" symbol="gnome_vfs_acl_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="acl" type="GnomeVFSACL*"/>
					<parameter name="ace" type="GnomeVFSACE*"/>
				</parameters>
			</method>
			<method name="unset" symbol="gnome_vfs_acl_unset">
				<return-type type="void"/>
				<parameters>
					<parameter name="acl" type="GnomeVFSACL*"/>
					<parameter name="ace" type="GnomeVFSACE*"/>
				</parameters>
			</method>
		</object>
		<object name="GnomeVFSDrive" parent="GObject" type-name="GnomeVFSDrive" get-type="gnome_vfs_drive_get_type">
			<method name="compare" symbol="gnome_vfs_drive_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GnomeVFSDrive*"/>
					<parameter name="b" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="eject" symbol="gnome_vfs_drive_eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
					<parameter name="callback" type="GnomeVFSVolumeOpCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_activation_uri" symbol="gnome_vfs_drive_get_activation_uri">
				<return-type type="char*"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="get_device_path" symbol="gnome_vfs_drive_get_device_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="get_device_type" symbol="gnome_vfs_drive_get_device_type">
				<return-type type="GnomeVFSDeviceType"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="get_display_name" symbol="gnome_vfs_drive_get_display_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="get_hal_udi" symbol="gnome_vfs_drive_get_hal_udi">
				<return-type type="char*"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gnome_vfs_drive_get_icon">
				<return-type type="char*"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gnome_vfs_drive_get_id">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="get_mounted_volume" symbol="gnome_vfs_drive_get_mounted_volume">
				<return-type type="GnomeVFSVolume*"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="get_mounted_volumes" symbol="gnome_vfs_drive_get_mounted_volumes">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="is_connected" symbol="gnome_vfs_drive_is_connected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="is_mounted" symbol="gnome_vfs_drive_is_mounted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="is_user_visible" symbol="gnome_vfs_drive_is_user_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="mount" symbol="gnome_vfs_drive_mount">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
					<parameter name="callback" type="GnomeVFSVolumeOpCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="needs_eject" symbol="gnome_vfs_drive_needs_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="ref" symbol="gnome_vfs_drive_ref">
				<return-type type="GnomeVFSDrive*"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="unmount" symbol="gnome_vfs_drive_unmount">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
					<parameter name="callback" type="GnomeVFSVolumeOpCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="unref" symbol="gnome_vfs_drive_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</method>
			<method name="volume_list_free" symbol="gnome_vfs_drive_volume_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="volumes" type="GList*"/>
				</parameters>
			</method>
			<signal name="volume-mounted" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</signal>
			<signal name="volume-pre-unmount" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</signal>
			<signal name="volume-unmounted" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GnomeVFSDrive*"/>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</signal>
		</object>
		<object name="GnomeVFSMIMEMonitor" parent="GObject" type-name="GnomeVFSMIMEMonitor" get-type="gnome_vfs_mime_monitor_get_type">
			<method name="get" symbol="gnome_vfs_mime_monitor_get">
				<return-type type="GnomeVFSMIMEMonitor*"/>
			</method>
			<signal name="data-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="GnomeVFSMIMEMonitor*"/>
				</parameters>
			</signal>
		</object>
		<object name="GnomeVFSVolume" parent="GObject" type-name="GnomeVFSVolume" get-type="gnome_vfs_volume_get_type">
			<method name="compare" symbol="gnome_vfs_volume_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GnomeVFSVolume*"/>
					<parameter name="b" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="eject" symbol="gnome_vfs_volume_eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
					<parameter name="callback" type="GnomeVFSVolumeOpCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_activation_uri" symbol="gnome_vfs_volume_get_activation_uri">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="get_device_path" symbol="gnome_vfs_volume_get_device_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="get_device_type" symbol="gnome_vfs_volume_get_device_type">
				<return-type type="GnomeVFSDeviceType"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="get_display_name" symbol="gnome_vfs_volume_get_display_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="get_drive" symbol="gnome_vfs_volume_get_drive">
				<return-type type="GnomeVFSDrive*"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="get_filesystem_type" symbol="gnome_vfs_volume_get_filesystem_type">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="get_hal_udi" symbol="gnome_vfs_volume_get_hal_udi">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gnome_vfs_volume_get_icon">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gnome_vfs_volume_get_id">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="get_volume_type" symbol="gnome_vfs_volume_get_volume_type">
				<return-type type="GnomeVFSVolumeType"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="handles_trash" symbol="gnome_vfs_volume_handles_trash">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="is_mounted" symbol="gnome_vfs_volume_is_mounted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="is_read_only" symbol="gnome_vfs_volume_is_read_only">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="is_user_visible" symbol="gnome_vfs_volume_is_user_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="ref" symbol="gnome_vfs_volume_ref">
				<return-type type="GnomeVFSVolume*"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
			<method name="unmount" symbol="gnome_vfs_volume_unmount">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
					<parameter name="callback" type="GnomeVFSVolumeOpCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="unref" symbol="gnome_vfs_volume_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</method>
		</object>
		<object name="GnomeVFSVolumeMonitor" parent="GObject" type-name="GnomeVFSVolumeMonitor" get-type="gnome_vfs_volume_monitor_get_type">
			<method name="get_connected_drives" symbol="gnome_vfs_volume_monitor_get_connected_drives">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="volume_monitor" type="GnomeVFSVolumeMonitor*"/>
				</parameters>
			</method>
			<method name="get_drive_by_id" symbol="gnome_vfs_volume_monitor_get_drive_by_id">
				<return-type type="GnomeVFSDrive*"/>
				<parameters>
					<parameter name="volume_monitor" type="GnomeVFSVolumeMonitor*"/>
					<parameter name="id" type="gulong"/>
				</parameters>
			</method>
			<method name="get_mounted_volumes" symbol="gnome_vfs_volume_monitor_get_mounted_volumes">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="volume_monitor" type="GnomeVFSVolumeMonitor*"/>
				</parameters>
			</method>
			<method name="get_volume_by_id" symbol="gnome_vfs_volume_monitor_get_volume_by_id">
				<return-type type="GnomeVFSVolume*"/>
				<parameters>
					<parameter name="volume_monitor" type="GnomeVFSVolumeMonitor*"/>
					<parameter name="id" type="gulong"/>
				</parameters>
			</method>
			<method name="get_volume_for_path" symbol="gnome_vfs_volume_monitor_get_volume_for_path">
				<return-type type="GnomeVFSVolume*"/>
				<parameters>
					<parameter name="volume_monitor" type="GnomeVFSVolumeMonitor*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="ref" symbol="gnome_vfs_volume_monitor_ref">
				<return-type type="GnomeVFSVolumeMonitor*"/>
				<parameters>
					<parameter name="volume_monitor" type="GnomeVFSVolumeMonitor*"/>
				</parameters>
			</method>
			<method name="unref" symbol="gnome_vfs_volume_monitor_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GnomeVFSVolumeMonitor*"/>
				</parameters>
			</method>
			<signal name="drive-connected" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GnomeVFSVolumeMonitor*"/>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</signal>
			<signal name="drive-disconnected" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GnomeVFSVolumeMonitor*"/>
					<parameter name="drive" type="GnomeVFSDrive*"/>
				</parameters>
			</signal>
			<signal name="volume-mounted" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GnomeVFSVolumeMonitor*"/>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</signal>
			<signal name="volume-pre-unmount" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GnomeVFSVolumeMonitor*"/>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</signal>
			<signal name="volume-unmounted" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GnomeVFSVolumeMonitor*"/>
					<parameter name="volume" type="GnomeVFSVolume*"/>
				</parameters>
			</signal>
		</object>
		<constant name="DESKTOP_ENTRY_GROUP" type="char*" value="Desktop Entry"/>
		<constant name="GNOME_VFS_APPLICATION_REGISTRY_CAN_OPEN_MULTIPLE_FILES" type="char*" value="can_open_multiple_files"/>
		<constant name="GNOME_VFS_APPLICATION_REGISTRY_COMMAND" type="char*" value="command"/>
		<constant name="GNOME_VFS_APPLICATION_REGISTRY_NAME" type="char*" value="name"/>
		<constant name="GNOME_VFS_APPLICATION_REGISTRY_REQUIRES_TERMINAL" type="char*" value="requires_terminal"/>
		<constant name="GNOME_VFS_APPLICATION_REGISTRY_STARTUP_NOTIFY" type="char*" value="startup_notify"/>
		<constant name="GNOME_VFS_APPLICATION_REGISTRY_USES_GNOMEVFS" type="char*" value="uses_gnomevfs"/>
		<constant name="GNOME_VFS_MAJOR_VERSION" type="int" value="2"/>
		<constant name="GNOME_VFS_MICRO_VERSION" type="int" value="3"/>
		<constant name="GNOME_VFS_MIME_TYPE_UNKNOWN" type="char*" value="application/octet-stream"/>
		<constant name="GNOME_VFS_MINOR_VERSION" type="int" value="24"/>
		<constant name="GNOME_VFS_MODULE_CALLBACK_AUTHENTICATION" type="char*" value="simple-authentication"/>
		<constant name="GNOME_VFS_MODULE_CALLBACK_FILL_AUTHENTICATION" type="char*" value="fill-authentication"/>
		<constant name="GNOME_VFS_MODULE_CALLBACK_FULL_AUTHENTICATION" type="char*" value="full-authentication"/>
		<constant name="GNOME_VFS_MODULE_CALLBACK_HTTP_PROXY_AUTHENTICATION" type="char*" value="http:proxy-authentication"/>
		<constant name="GNOME_VFS_MODULE_CALLBACK_HTTP_RECEIVED_HEADERS" type="char*" value="http:received-headers"/>
		<constant name="GNOME_VFS_MODULE_CALLBACK_HTTP_SEND_ADDITIONAL_HEADERS" type="char*" value="http:send-additional-headers"/>
		<constant name="GNOME_VFS_MODULE_CALLBACK_QUESTION" type="char*" value="ask-question"/>
		<constant name="GNOME_VFS_MODULE_CALLBACK_SAVE_AUTHENTICATION" type="char*" value="save-authentication"/>
		<constant name="GNOME_VFS_MODULE_CALLBACK_STATUS_MESSAGE" type="char*" value="status-message"/>
		<constant name="GNOME_VFS_PRIORITY_DEFAULT" type="int" value="0"/>
		<constant name="GNOME_VFS_PRIORITY_MAX" type="int" value="10"/>
		<constant name="GNOME_VFS_PRIORITY_MIN" type="int" value="-10"/>
		<constant name="GNOME_VFS_URI_MAGIC_STR" type="char*" value="#"/>
		<constant name="GNOME_VFS_URI_PATH_STR" type="char*" value="/"/>
		<constant name="S_IRGRP" type="int" value="0"/>
		<constant name="S_IROTH" type="int" value="0"/>
		<constant name="S_ISGID" type="int" value="0"/>
		<constant name="S_ISUID" type="int" value="0"/>
		<constant name="S_IWGRP" type="int" value="0"/>
		<constant name="S_IWOTH" type="int" value="0"/>
		<constant name="S_IXGRP" type="int" value="0"/>
		<constant name="S_IXOTH" type="int" value="0"/>
	</namespace>
</api>
