<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gnome">
		<function name="accelerators_sync" symbol="gnome_accelerators_sync">
			<return-type type="void"/>
		</function>
		<function name="authentication_manager_dialog_is_visible" symbol="gnome_authentication_manager_dialog_is_visible">
			<return-type type="gboolean"/>
		</function>
		<function name="authentication_manager_init" symbol="gnome_authentication_manager_init">
			<return-type type="void"/>
		</function>
		<function name="error_dialog" symbol="gnome_error_dialog">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="error" type="gchar*"/>
			</parameters>
		</function>
		<function name="error_dialog_parented" symbol="gnome_error_dialog_parented">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="error" type="gchar*"/>
				<parameter name="parent" type="GtkWindow*"/>
			</parameters>
		</function>
		<function name="gdk_pixbuf_new_from_uri" symbol="gnome_gdk_pixbuf_new_from_uri">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
			</parameters>
		</function>
		<function name="gdk_pixbuf_new_from_uri_async" symbol="gnome_gdk_pixbuf_new_from_uri_async">
			<return-type type="GnomeGdkPixbufAsyncHandle*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
				<parameter name="load_callback" type="GnomeGdkPixbufLoadCallback"/>
				<parameter name="done_callback" type="GnomeGdkPixbufDoneCallback"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="gdk_pixbuf_new_from_uri_at_scale" symbol="gnome_gdk_pixbuf_new_from_uri_at_scale">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
				<parameter name="width" type="gint"/>
				<parameter name="height" type="gint"/>
				<parameter name="preserve_aspect_ratio" type="gboolean"/>
			</parameters>
		</function>
		<function name="gdk_pixbuf_new_from_uri_cancel" symbol="gnome_gdk_pixbuf_new_from_uri_cancel">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeGdkPixbufAsyncHandle*"/>
			</parameters>
		</function>
		<function name="gtk_module_info_get" symbol="gnome_gtk_module_info_get">
			<return-type type="GnomeModuleInfo*"/>
		</function>
		<function name="gtk_widget_add_popup_items" symbol="gnome_gtk_widget_add_popup_items">
			<return-type type="void"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="uiinfo" type="GnomeUIInfo*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="help_display_desktop_on_screen" symbol="gnome_help_display_desktop_on_screen">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="program" type="GnomeProgram*"/>
				<parameter name="doc_id" type="char*"/>
				<parameter name="file_name" type="char*"/>
				<parameter name="link_id" type="char*"/>
				<parameter name="screen" type="GdkScreen*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="help_display_on_screen" symbol="gnome_help_display_on_screen">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="file_name" type="char*"/>
				<parameter name="link_id" type="char*"/>
				<parameter name="screen" type="GdkScreen*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="help_display_uri_on_screen" symbol="gnome_help_display_uri_on_screen">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="help_uri" type="char*"/>
				<parameter name="screen" type="GdkScreen*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="help_display_with_doc_id_on_screen" symbol="gnome_help_display_with_doc_id_on_screen">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="program" type="GnomeProgram*"/>
				<parameter name="doc_id" type="char*"/>
				<parameter name="file_name" type="char*"/>
				<parameter name="link_id" type="char*"/>
				<parameter name="screen" type="GdkScreen*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="ice_init" symbol="gnome_ice_init">
			<return-type type="void"/>
		</function>
		<function name="icon_lookup" symbol="gnome_icon_lookup">
			<return-type type="char*"/>
			<parameters>
				<parameter name="icon_theme" type="GtkIconTheme*"/>
				<parameter name="thumbnail_factory" type="GnomeThumbnailFactory*"/>
				<parameter name="file_uri" type="char*"/>
				<parameter name="custom_icon" type="char*"/>
				<parameter name="file_info" type="GnomeVFSFileInfo*"/>
				<parameter name="mime_type" type="char*"/>
				<parameter name="flags" type="GnomeIconLookupFlags"/>
				<parameter name="result" type="GnomeIconLookupResultFlags*"/>
			</parameters>
		</function>
		<function name="icon_lookup_sync" symbol="gnome_icon_lookup_sync">
			<return-type type="char*"/>
			<parameters>
				<parameter name="icon_theme" type="GtkIconTheme*"/>
				<parameter name="thumbnail_factory" type="GnomeThumbnailFactory*"/>
				<parameter name="file_uri" type="char*"/>
				<parameter name="custom_icon" type="char*"/>
				<parameter name="flags" type="GnomeIconLookupFlags"/>
				<parameter name="result" type="GnomeIconLookupResultFlags*"/>
			</parameters>
		</function>
		<function name="init_with_popt_table" symbol="gnome_init_with_popt_table">
			<return-type type="int"/>
			<parameters>
				<parameter name="app_id" type="char*"/>
				<parameter name="app_version" type="char*"/>
				<parameter name="argc" type="int"/>
				<parameter name="argv" type="char**"/>
				<parameter name="options" type="struct poptOption*"/>
				<parameter name="flags" type="int"/>
				<parameter name="return_ctx" type="poptContext*"/>
			</parameters>
		</function>
		<function name="interaction_key_return" symbol="gnome_interaction_key_return">
			<return-type type="void"/>
			<parameters>
				<parameter name="key" type="gint"/>
				<parameter name="cancel_shutdown" type="gboolean"/>
			</parameters>
		</function>
		<function name="libgnomeui_module_info_get" symbol="libgnomeui_module_info_get">
			<return-type type="GnomeModuleInfo*"/>
		</function>
		<function name="master_client" symbol="gnome_master_client">
			<return-type type="GnomeClient*"/>
		</function>
		<function name="ok_cancel_dialog" symbol="gnome_ok_cancel_dialog">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="message" type="gchar*"/>
				<parameter name="callback" type="GnomeReplyCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="ok_cancel_dialog_modal" symbol="gnome_ok_cancel_dialog_modal">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="message" type="gchar*"/>
				<parameter name="callback" type="GnomeReplyCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="ok_cancel_dialog_modal_parented" symbol="gnome_ok_cancel_dialog_modal_parented">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="message" type="gchar*"/>
				<parameter name="callback" type="GnomeReplyCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="parent" type="GtkWindow*"/>
			</parameters>
		</function>
		<function name="ok_cancel_dialog_parented" symbol="gnome_ok_cancel_dialog_parented">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="message" type="gchar*"/>
				<parameter name="callback" type="GnomeReplyCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="parent" type="GtkWindow*"/>
			</parameters>
		</function>
		<function name="ok_dialog" symbol="gnome_ok_dialog">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="message" type="gchar*"/>
			</parameters>
		</function>
		<function name="ok_dialog_parented" symbol="gnome_ok_dialog_parented">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="message" type="gchar*"/>
				<parameter name="parent" type="GtkWindow*"/>
			</parameters>
		</function>
		<function name="popup_menu_append" symbol="gnome_popup_menu_append">
			<return-type type="void"/>
			<parameters>
				<parameter name="popup" type="GtkWidget*"/>
				<parameter name="uiinfo" type="GnomeUIInfo*"/>
			</parameters>
		</function>
		<function name="popup_menu_attach" symbol="gnome_popup_menu_attach">
			<return-type type="void"/>
			<parameters>
				<parameter name="popup" type="GtkWidget*"/>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="popup_menu_do_popup" symbol="gnome_popup_menu_do_popup">
			<return-type type="void"/>
			<parameters>
				<parameter name="popup" type="GtkWidget*"/>
				<parameter name="pos_func" type="GtkMenuPositionFunc"/>
				<parameter name="pos_data" type="gpointer"/>
				<parameter name="event" type="GdkEventButton*"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="for_widget" type="GtkWidget*"/>
			</parameters>
		</function>
		<function name="popup_menu_do_popup_modal" symbol="gnome_popup_menu_do_popup_modal">
			<return-type type="int"/>
			<parameters>
				<parameter name="popup" type="GtkWidget*"/>
				<parameter name="pos_func" type="GtkMenuPositionFunc"/>
				<parameter name="pos_data" type="gpointer"/>
				<parameter name="event" type="GdkEventButton*"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="for_widget" type="GtkWidget*"/>
			</parameters>
		</function>
		<function name="popup_menu_get_accel_group" symbol="gnome_popup_menu_get_accel_group">
			<return-type type="GtkAccelGroup*"/>
			<parameters>
				<parameter name="menu" type="GtkMenu*"/>
			</parameters>
		</function>
		<function name="popup_menu_new" symbol="gnome_popup_menu_new">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="uiinfo" type="GnomeUIInfo*"/>
			</parameters>
		</function>
		<function name="popup_menu_new_with_accelgroup" symbol="gnome_popup_menu_new_with_accelgroup">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="uiinfo" type="GnomeUIInfo*"/>
				<parameter name="accelgroup" type="GtkAccelGroup*"/>
			</parameters>
		</function>
		<function name="question_dialog" symbol="gnome_question_dialog">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="question" type="gchar*"/>
				<parameter name="callback" type="GnomeReplyCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="question_dialog_modal" symbol="gnome_question_dialog_modal">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="question" type="gchar*"/>
				<parameter name="callback" type="GnomeReplyCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="question_dialog_modal_parented" symbol="gnome_question_dialog_modal_parented">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="question" type="gchar*"/>
				<parameter name="callback" type="GnomeReplyCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="parent" type="GtkWindow*"/>
			</parameters>
		</function>
		<function name="question_dialog_parented" symbol="gnome_question_dialog_parented">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="question" type="gchar*"/>
				<parameter name="callback" type="GnomeReplyCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="parent" type="GtkWindow*"/>
			</parameters>
		</function>
		<function name="request_dialog" symbol="gnome_request_dialog">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="password" type="gboolean"/>
				<parameter name="prompt" type="gchar*"/>
				<parameter name="default_text" type="gchar*"/>
				<parameter name="max_length" type="guint16"/>
				<parameter name="callback" type="GnomeStringCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="parent" type="GtkWindow*"/>
			</parameters>
		</function>
		<function name="request_password_dialog" symbol="gnome_request_password_dialog">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="prompt" type="gchar*"/>
				<parameter name="callback" type="GnomeStringCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="request_password_dialog_parented" symbol="gnome_request_password_dialog_parented">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="prompt" type="gchar*"/>
				<parameter name="callback" type="GnomeStringCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="parent" type="GtkWindow*"/>
			</parameters>
		</function>
		<function name="request_string_dialog" symbol="gnome_request_string_dialog">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="prompt" type="gchar*"/>
				<parameter name="callback" type="GnomeStringCallback"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</function>
		<function name="request_string_dialog_parented" symbol="gnome_request_string_dialog_parented">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="prompt" type="gchar*"/>
				<parameter name="callback" type="GnomeStringCallback"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="parent" type="GtkWindow*"/>
			</parameters>
		</function>
		<function name="thumbnail_has_uri" symbol="gnome_thumbnail_has_uri">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
				<parameter name="uri" type="char*"/>
			</parameters>
		</function>
		<function name="thumbnail_is_valid" symbol="gnome_thumbnail_is_valid">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
				<parameter name="uri" type="char*"/>
				<parameter name="mtime" type="time_t"/>
			</parameters>
		</function>
		<function name="thumbnail_md5" symbol="gnome_thumbnail_md5">
			<return-type type="char*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
			</parameters>
		</function>
		<function name="thumbnail_path_for_uri" symbol="gnome_thumbnail_path_for_uri">
			<return-type type="char*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
				<parameter name="size" type="GnomeThumbnailSize"/>
			</parameters>
		</function>
		<function name="thumbnail_scale_down_pixbuf" symbol="gnome_thumbnail_scale_down_pixbuf">
			<return-type type="GdkPixbuf*"/>
			<parameters>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
				<parameter name="dest_width" type="int"/>
				<parameter name="dest_height" type="int"/>
			</parameters>
		</function>
		<function name="url_show_on_screen" symbol="gnome_url_show_on_screen">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="url" type="char*"/>
				<parameter name="screen" type="GdkScreen*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="warning_dialog" symbol="gnome_warning_dialog">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="warning" type="gchar*"/>
			</parameters>
		</function>
		<function name="warning_dialog_parented" symbol="gnome_warning_dialog_parented">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="warning" type="gchar*"/>
				<parameter name="parent" type="GtkWindow*"/>
			</parameters>
		</function>
		<function name="window_icon_init" symbol="gnome_window_icon_init">
			<return-type type="void"/>
		</function>
		<function name="window_icon_set_default_from_file" symbol="gnome_window_icon_set_default_from_file">
			<return-type type="void"/>
			<parameters>
				<parameter name="filename" type="char*"/>
			</parameters>
		</function>
		<function name="window_icon_set_default_from_file_list" symbol="gnome_window_icon_set_default_from_file_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="filenames" type="char**"/>
			</parameters>
		</function>
		<function name="window_icon_set_from_default" symbol="gnome_window_icon_set_from_default">
			<return-type type="void"/>
			<parameters>
				<parameter name="w" type="GtkWindow*"/>
			</parameters>
		</function>
		<function name="window_icon_set_from_file" symbol="gnome_window_icon_set_from_file">
			<return-type type="void"/>
			<parameters>
				<parameter name="w" type="GtkWindow*"/>
				<parameter name="filename" type="char*"/>
			</parameters>
		</function>
		<function name="window_icon_set_from_file_list" symbol="gnome_window_icon_set_from_file_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="w" type="GtkWindow*"/>
				<parameter name="filenames" type="char**"/>
			</parameters>
		</function>
		<function name="window_toplevel_set_title" symbol="gnome_window_toplevel_set_title">
			<return-type type="void"/>
			<parameters>
				<parameter name="window" type="GtkWindow*"/>
				<parameter name="doc_name" type="gchar*"/>
				<parameter name="app_name" type="gchar*"/>
				<parameter name="extension" type="gchar*"/>
			</parameters>
		</function>
		<callback name="GnomeAppProgressCancelFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeAppProgressFunc">
			<return-type type="gdouble"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeGdkPixbufDoneCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeGdkPixbufAsyncHandle*"/>
				<parameter name="cb_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeGdkPixbufLoadCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="GnomeGdkPixbufAsyncHandle*"/>
				<parameter name="error" type="GnomeVFSResult"/>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
				<parameter name="cb_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeInteractFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="client" type="GnomeClient*"/>
				<parameter name="key" type="gint"/>
				<parameter name="dialog_type" type="GnomeDialogType"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeMDIChildConfigFunc">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="p1" type="GnomeMDIChild*"/>
				<parameter name="p2" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeMDIChildCreator">
			<return-type type="GnomeMDIChild*"/>
			<parameters>
				<parameter name="p1" type="gchar*"/>
			</parameters>
		</callback>
		<callback name="GnomeMDIChildLabelFunc">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="p1" type="GnomeMDIChild*"/>
				<parameter name="p2" type="GtkWidget*"/>
				<parameter name="p3" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeMDIChildMenuCreator">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="p1" type="GnomeMDIChild*"/>
				<parameter name="p2" type="GtkWidget*"/>
				<parameter name="p3" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeMDIChildViewCreator">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="p1" type="GnomeMDIChild*"/>
				<parameter name="p2" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomePasswordDialogQualityFunc">
			<return-type type="gdouble"/>
			<parameters>
				<parameter name="password_dialog" type="GnomePasswordDialog*"/>
				<parameter name="password" type="char*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeReplyCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="reply" type="gint"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeStringCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeThemeFileLineFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="df" type="GnomeThemeFile*"/>
				<parameter name="key" type="char*"/>
				<parameter name="locale" type="char*"/>
				<parameter name="value" type="char*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeThemeFileSectionFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="df" type="GnomeThemeFile*"/>
				<parameter name="name" type="char*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GnomeUISignalConnectFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="uiinfo" type="GnomeUIInfo*"/>
				<parameter name="signal_name" type="char*"/>
				<parameter name="uibdata" type="GnomeUIBuilderData*"/>
			</parameters>
		</callback>
		<struct name="GnomeAppBarMsg">
		</struct>
		<struct name="GnomeAppProgressKey">
		</struct>
		<struct name="GnomeGdkPixbufAsyncHandle">
		</struct>
		<struct name="GnomeIconData">
			<method name="dup" symbol="gnome_icon_data_dup">
				<return-type type="GnomeIconData*"/>
				<parameters>
					<parameter name="icon_data" type="GnomeIconData*"/>
				</parameters>
			</method>
			<method name="free" symbol="gnome_icon_data_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon_data" type="GnomeIconData*"/>
				</parameters>
			</method>
			<field name="has_embedded_rect" type="gboolean"/>
			<field name="x0" type="int"/>
			<field name="y0" type="int"/>
			<field name="x1" type="int"/>
			<field name="y1" type="int"/>
			<field name="attach_points" type="GnomeIconDataPoint*"/>
			<field name="n_attach_points" type="int"/>
			<field name="display_name" type="char*"/>
		</struct>
		<struct name="GnomeIconDataPoint">
			<field name="x" type="int"/>
			<field name="y" type="int"/>
		</struct>
		<struct name="GnomeIconTheme">
			<method name="append_search_path" symbol="gnome_icon_theme_append_search_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="GnomeIconTheme*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="get_allow_svg" symbol="gnome_icon_theme_get_allow_svg">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="theme" type="GnomeIconTheme*"/>
				</parameters>
			</method>
			<method name="get_example_icon_name" symbol="gnome_icon_theme_get_example_icon_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="theme" type="GnomeIconTheme*"/>
				</parameters>
			</method>
			<method name="get_search_path" symbol="gnome_icon_theme_get_search_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="GnomeIconTheme*"/>
					<parameter name="path" type="char**[]"/>
					<parameter name="n_elements" type="int*"/>
				</parameters>
			</method>
			<method name="has_icon" symbol="gnome_icon_theme_has_icon">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="theme" type="GnomeIconTheme*"/>
					<parameter name="icon_name" type="char*"/>
				</parameters>
			</method>
			<method name="list_icons" symbol="gnome_icon_theme_list_icons">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="theme" type="GnomeIconTheme*"/>
					<parameter name="context" type="char*"/>
				</parameters>
			</method>
			<method name="lookup_icon" symbol="gnome_icon_theme_lookup_icon">
				<return-type type="char*"/>
				<parameters>
					<parameter name="theme" type="GnomeIconTheme*"/>
					<parameter name="icon_name" type="char*"/>
					<parameter name="size" type="int"/>
					<parameter name="icon_data" type="GnomeIconData**"/>
					<parameter name="base_size" type="int*"/>
				</parameters>
			</method>
			<method name="new" symbol="gnome_icon_theme_new">
				<return-type type="GnomeIconTheme*"/>
			</method>
			<method name="prepend_search_path" symbol="gnome_icon_theme_prepend_search_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="GnomeIconTheme*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="rescan_if_needed" symbol="gnome_icon_theme_rescan_if_needed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="theme" type="GnomeIconTheme*"/>
				</parameters>
			</method>
			<method name="set_allow_svg" symbol="gnome_icon_theme_set_allow_svg">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="GnomeIconTheme*"/>
					<parameter name="allow_svg" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_custom_theme" symbol="gnome_icon_theme_set_custom_theme">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="GnomeIconTheme*"/>
					<parameter name="theme_name" type="char*"/>
				</parameters>
			</method>
			<method name="set_search_path" symbol="gnome_icon_theme_set_search_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="theme" type="GnomeIconTheme*"/>
					<parameter name="path" type="char*[]"/>
					<parameter name="n_elements" type="int"/>
				</parameters>
			</method>
		</struct>
		<struct name="GnomeMessageBoxButton">
		</struct>
		<struct name="GnomePasswordDialogDetails">
		</struct>
		<struct name="GnomeThemeFile">
			<method name="foreach_key" symbol="gnome_theme_file_foreach_key">
				<return-type type="void"/>
				<parameters>
					<parameter name="df" type="GnomeThemeFile*"/>
					<parameter name="section" type="char*"/>
					<parameter name="include_localized" type="gboolean"/>
					<parameter name="func" type="GnomeThemeFileLineFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="foreach_section" symbol="gnome_theme_file_foreach_section">
				<return-type type="void"/>
				<parameters>
					<parameter name="df" type="GnomeThemeFile*"/>
					<parameter name="func" type="GnomeThemeFileSectionFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gnome_theme_file_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="df" type="GnomeThemeFile*"/>
				</parameters>
			</method>
			<method name="get_integer" symbol="gnome_theme_file_get_integer">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="df" type="GnomeThemeFile*"/>
					<parameter name="section" type="char*"/>
					<parameter name="keyname" type="char*"/>
					<parameter name="val" type="int*"/>
				</parameters>
			</method>
			<method name="get_locale_string" symbol="gnome_theme_file_get_locale_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="df" type="GnomeThemeFile*"/>
					<parameter name="section" type="char*"/>
					<parameter name="keyname" type="char*"/>
					<parameter name="val" type="char**"/>
				</parameters>
			</method>
			<method name="get_raw" symbol="gnome_theme_file_get_raw">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="df" type="GnomeThemeFile*"/>
					<parameter name="section" type="char*"/>
					<parameter name="keyname" type="char*"/>
					<parameter name="locale" type="char*"/>
					<parameter name="val" type="char**"/>
				</parameters>
			</method>
			<method name="get_string" symbol="gnome_theme_file_get_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="df" type="GnomeThemeFile*"/>
					<parameter name="section" type="char*"/>
					<parameter name="keyname" type="char*"/>
					<parameter name="val" type="char**"/>
				</parameters>
			</method>
			<method name="new_from_string" symbol="gnome_theme_file_new_from_string">
				<return-type type="GnomeThemeFile*"/>
				<parameters>
					<parameter name="data" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="parse_error_quark" symbol="gnome_theme_file_parse_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="to_string" symbol="gnome_theme_file_to_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="df" type="GnomeThemeFile*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GnomeUIBuilderData">
			<field name="connect_func" type="GnomeUISignalConnectFunc"/>
			<field name="data" type="gpointer"/>
			<field name="is_interp" type="gboolean"/>
			<field name="relay_func" type="GtkCallbackMarshal"/>
			<field name="destroy_func" type="GtkDestroyNotify"/>
		</struct>
		<struct name="GnomeUIInfo">
			<field name="type" type="GnomeUIInfoType"/>
			<field name="label" type="gchar*"/>
			<field name="hint" type="gchar*"/>
			<field name="moreinfo" type="gpointer"/>
			<field name="user_data" type="gpointer"/>
			<field name="unused_data" type="gpointer"/>
			<field name="pixmap_type" type="GnomeUIPixmapType"/>
			<field name="pixmap_info" type="gconstpointer"/>
			<field name="accelerator_key" type="guint"/>
			<field name="ac_mods" type="GdkModifierType"/>
			<field name="widget" type="GtkWidget*"/>
		</struct>
		<enum name="GnomeClientState">
			<member name="GNOME_CLIENT_IDLE" value="0"/>
			<member name="GNOME_CLIENT_SAVING_PHASE_1" value="1"/>
			<member name="GNOME_CLIENT_WAITING_FOR_PHASE_2" value="2"/>
			<member name="GNOME_CLIENT_SAVING_PHASE_2" value="3"/>
			<member name="GNOME_CLIENT_FROZEN" value="4"/>
			<member name="GNOME_CLIENT_DISCONNECTED" value="5"/>
			<member name="GNOME_CLIENT_REGISTERING" value="6"/>
		</enum>
		<enum name="GnomeDialogType">
			<member name="GNOME_DIALOG_ERROR" value="0"/>
			<member name="GNOME_DIALOG_NORMAL" value="1"/>
		</enum>
		<enum name="GnomeEdgePosition">
			<member name="GNOME_EDGE_START" value="0"/>
			<member name="GNOME_EDGE_FINISH" value="1"/>
			<member name="GNOME_EDGE_OTHER" value="2"/>
			<member name="GNOME_EDGE_LAST" value="3"/>
		</enum>
		<enum name="GnomeFontPickerMode">
			<member name="GNOME_FONT_PICKER_MODE_PIXMAP" value="0"/>
			<member name="GNOME_FONT_PICKER_MODE_FONT_INFO" value="1"/>
			<member name="GNOME_FONT_PICKER_MODE_USER_WIDGET" value="2"/>
			<member name="GNOME_FONT_PICKER_MODE_UNKNOWN" value="3"/>
		</enum>
		<enum name="GnomeIconListMode">
			<member name="GNOME_ICON_LIST_ICONS" value="0"/>
			<member name="GNOME_ICON_LIST_TEXT_BELOW" value="1"/>
			<member name="GNOME_ICON_LIST_TEXT_RIGHT" value="2"/>
		</enum>
		<enum name="GnomeInteractStyle">
			<member name="GNOME_INTERACT_NONE" value="0"/>
			<member name="GNOME_INTERACT_ERRORS" value="1"/>
			<member name="GNOME_INTERACT_ANY" value="2"/>
		</enum>
		<enum name="GnomeMDIMode">
			<member name="GNOME_MDI_NOTEBOOK" value="0"/>
			<member name="GNOME_MDI_TOPLEVEL" value="1"/>
			<member name="GNOME_MDI_MODAL" value="2"/>
			<member name="GNOME_MDI_DEFAULT_MODE" value="42"/>
		</enum>
		<enum name="GnomePasswordDialogRemember">
			<member name="GNOME_PASSWORD_DIALOG_REMEMBER_NOTHING" value="0"/>
			<member name="GNOME_PASSWORD_DIALOG_REMEMBER_SESSION" value="1"/>
			<member name="GNOME_PASSWORD_DIALOG_REMEMBER_FOREVER" value="2"/>
		</enum>
		<enum name="GnomePreferencesType">
			<member name="GNOME_PREFERENCES_NEVER" value="0"/>
			<member name="GNOME_PREFERENCES_USER" value="1"/>
			<member name="GNOME_PREFERENCES_ALWAYS" value="2"/>
		</enum>
		<enum name="GnomeRestartStyle">
			<member name="GNOME_RESTART_IF_RUNNING" value="0"/>
			<member name="GNOME_RESTART_ANYWAY" value="1"/>
			<member name="GNOME_RESTART_IMMEDIATELY" value="2"/>
			<member name="GNOME_RESTART_NEVER" value="3"/>
		</enum>
		<enum name="GnomeSaveStyle">
			<member name="GNOME_SAVE_GLOBAL" value="0"/>
			<member name="GNOME_SAVE_LOCAL" value="1"/>
			<member name="GNOME_SAVE_BOTH" value="2"/>
		</enum>
		<enum name="GnomeThemeFileParseError">
			<member name="GNOME_THEME_FILE_PARSE_ERROR_INVALID_SYNTAX" value="0"/>
			<member name="GNOME_THEME_FILE_PARSE_ERROR_INVALID_ESCAPES" value="1"/>
			<member name="GNOME_THEME_FILE_PARSE_ERROR_INVALID_CHARS" value="2"/>
		</enum>
		<enum name="GnomeThumbnailSize">
			<member name="GNOME_THUMBNAIL_SIZE_NORMAL" value="0"/>
			<member name="GNOME_THUMBNAIL_SIZE_LARGE" value="1"/>
		</enum>
		<enum name="GnomeUIInfoConfigurableTypes">
			<member name="GNOME_APP_CONFIGURABLE_ITEM_NEW" value="0"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_OPEN" value="1"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_SAVE" value="2"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_SAVE_AS" value="3"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_REVERT" value="4"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_PRINT" value="5"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_PRINT_SETUP" value="6"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_CLOSE" value="7"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_QUIT" value="8"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_CUT" value="9"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_COPY" value="10"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_PASTE" value="11"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_CLEAR" value="12"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_UNDO" value="13"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_REDO" value="14"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_FIND" value="15"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_FIND_AGAIN" value="16"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_REPLACE" value="17"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_PROPERTIES" value="18"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_PREFERENCES" value="19"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_ABOUT" value="20"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_SELECT_ALL" value="21"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_NEW_WINDOW" value="22"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_CLOSE_WINDOW" value="23"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_NEW_GAME" value="24"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_PAUSE_GAME" value="25"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_RESTART_GAME" value="26"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_UNDO_MOVE" value="27"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_REDO_MOVE" value="28"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_HINT" value="29"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_SCORES" value="30"/>
			<member name="GNOME_APP_CONFIGURABLE_ITEM_END_GAME" value="31"/>
		</enum>
		<enum name="GnomeUIInfoType">
			<member name="GNOME_APP_UI_ENDOFINFO" value="0"/>
			<member name="GNOME_APP_UI_ITEM" value="1"/>
			<member name="GNOME_APP_UI_TOGGLEITEM" value="2"/>
			<member name="GNOME_APP_UI_RADIOITEMS" value="3"/>
			<member name="GNOME_APP_UI_SUBTREE" value="4"/>
			<member name="GNOME_APP_UI_SEPARATOR" value="5"/>
			<member name="GNOME_APP_UI_HELP" value="6"/>
			<member name="GNOME_APP_UI_BUILDER_DATA" value="7"/>
			<member name="GNOME_APP_UI_ITEM_CONFIGURABLE" value="8"/>
			<member name="GNOME_APP_UI_SUBTREE_STOCK" value="9"/>
			<member name="GNOME_APP_UI_INCLUDE" value="10"/>
		</enum>
		<enum name="GnomeUIPixmapType">
			<member name="GNOME_APP_PIXMAP_NONE" value="0"/>
			<member name="GNOME_APP_PIXMAP_STOCK" value="1"/>
			<member name="GNOME_APP_PIXMAP_DATA" value="2"/>
			<member name="GNOME_APP_PIXMAP_FILENAME" value="3"/>
		</enum>
		<flags name="GnomeClientFlags">
			<member name="GNOME_CLIENT_IS_CONNECTED" value="1"/>
			<member name="GNOME_CLIENT_RESTARTED" value="2"/>
			<member name="GNOME_CLIENT_RESTORED" value="4"/>
		</flags>
		<flags name="GnomeDateEditFlags">
			<member name="GNOME_DATE_EDIT_SHOW_TIME" value="1"/>
			<member name="GNOME_DATE_EDIT_24_HR" value="2"/>
			<member name="GNOME_DATE_EDIT_WEEK_STARTS_ON_MONDAY" value="4"/>
		</flags>
		<flags name="GnomeIconLookupFlags">
			<member name="GNOME_ICON_LOOKUP_FLAGS_NONE" value="0"/>
			<member name="GNOME_ICON_LOOKUP_FLAGS_EMBEDDING_TEXT" value="1"/>
			<member name="GNOME_ICON_LOOKUP_FLAGS_SHOW_SMALL_IMAGES_AS_THEMSELVES" value="2"/>
			<member name="GNOME_ICON_LOOKUP_FLAGS_ALLOW_SVG_AS_THEMSELVES" value="4"/>
		</flags>
		<flags name="GnomeIconLookupResultFlags">
			<member name="GNOME_ICON_LOOKUP_RESULT_FLAGS_NONE" value="0"/>
			<member name="GNOME_ICON_LOOKUP_RESULT_FLAGS_THUMBNAIL" value="1"/>
		</flags>
		<object name="GnomeAbout" parent="GtkDialog" type-name="GnomeAbout" get-type="gnome_about_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="construct" symbol="gnome_about_construct">
				<return-type type="void"/>
				<parameters>
					<parameter name="about" type="GnomeAbout*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="version" type="gchar*"/>
					<parameter name="copyright" type="gchar*"/>
					<parameter name="comments" type="gchar*"/>
					<parameter name="authors" type="gchar**"/>
					<parameter name="documenters" type="gchar**"/>
					<parameter name="translator_credits" type="gchar*"/>
					<parameter name="logo_pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_about_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="version" type="gchar*"/>
					<parameter name="copyright" type="gchar*"/>
					<parameter name="comments" type="gchar*"/>
					<parameter name="authors" type="gchar**"/>
					<parameter name="documenters" type="gchar**"/>
					<parameter name="translator_credits" type="gchar*"/>
					<parameter name="logo_pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</constructor>
			<property name="authors" type="GValueArray*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="comments" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="copyright" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="documenters" type="GValueArray*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="logo" type="GdkPixbuf*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="translator-credits" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="version" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GnomeApp" parent="GtkWindow" type-name="GnomeApp" get-type="gnome_app_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="add_dock_item" symbol="gnome_app_add_dock_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="item" type="BonoboDockItem*"/>
					<parameter name="placement" type="BonoboDockPlacement"/>
					<parameter name="band_num" type="gint"/>
					<parameter name="band_position" type="gint"/>
					<parameter name="offset" type="gint"/>
				</parameters>
			</method>
			<method name="add_docked" symbol="gnome_app_add_docked">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="behavior" type="BonoboDockItemBehavior"/>
					<parameter name="placement" type="BonoboDockPlacement"/>
					<parameter name="band_num" type="gint"/>
					<parameter name="band_position" type="gint"/>
					<parameter name="offset" type="gint"/>
				</parameters>
			</method>
			<method name="add_toolbar" symbol="gnome_app_add_toolbar">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="toolbar" type="GtkToolbar*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="behavior" type="BonoboDockItemBehavior"/>
					<parameter name="placement" type="BonoboDockPlacement"/>
					<parameter name="band_num" type="gint"/>
					<parameter name="band_position" type="gint"/>
					<parameter name="offset" type="gint"/>
				</parameters>
			</method>
			<method name="construct" symbol="gnome_app_construct">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="appname" type="gchar*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<method name="create_menus" symbol="gnome_app_create_menus">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
				</parameters>
			</method>
			<method name="create_menus_custom" symbol="gnome_app_create_menus_custom">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="uibdata" type="GnomeUIBuilderData*"/>
				</parameters>
			</method>
			<method name="create_menus_interp" symbol="gnome_app_create_menus_interp">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="relay_func" type="GtkCallbackMarshal"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="destroy_func" type="GtkDestroyNotify"/>
				</parameters>
			</method>
			<method name="create_menus_with_data" symbol="gnome_app_create_menus_with_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="create_toolbar" symbol="gnome_app_create_toolbar">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
				</parameters>
			</method>
			<method name="create_toolbar_custom" symbol="gnome_app_create_toolbar_custom">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="uibdata" type="GnomeUIBuilderData*"/>
				</parameters>
			</method>
			<method name="create_toolbar_interp" symbol="gnome_app_create_toolbar_interp">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="relay_func" type="GtkCallbackMarshal"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="destroy_func" type="GtkDestroyNotify"/>
				</parameters>
			</method>
			<method name="create_toolbar_with_data" symbol="gnome_app_create_toolbar_with_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="enable_layout_config" symbol="gnome_app_enable_layout_config">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="enable" type="gboolean"/>
				</parameters>
			</method>
			<method name="error" symbol="gnome_app_error">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="error" type="gchar*"/>
				</parameters>
			</method>
			<method name="fill_menu" symbol="gnome_app_fill_menu">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu_shell" type="GtkMenuShell*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="accel_group" type="GtkAccelGroup*"/>
					<parameter name="uline_accels" type="gboolean"/>
					<parameter name="pos" type="gint"/>
				</parameters>
			</method>
			<method name="fill_menu_custom" symbol="gnome_app_fill_menu_custom">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu_shell" type="GtkMenuShell*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="uibdata" type="GnomeUIBuilderData*"/>
					<parameter name="accel_group" type="GtkAccelGroup*"/>
					<parameter name="uline_accels" type="gboolean"/>
					<parameter name="pos" type="gint"/>
				</parameters>
			</method>
			<method name="fill_menu_with_data" symbol="gnome_app_fill_menu_with_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="menu_shell" type="GtkMenuShell*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="accel_group" type="GtkAccelGroup*"/>
					<parameter name="uline_accels" type="gboolean"/>
					<parameter name="pos" type="gint"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="fill_toolbar" symbol="gnome_app_fill_toolbar">
				<return-type type="void"/>
				<parameters>
					<parameter name="toolbar" type="GtkToolbar*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="accel_group" type="GtkAccelGroup*"/>
				</parameters>
			</method>
			<method name="fill_toolbar_custom" symbol="gnome_app_fill_toolbar_custom">
				<return-type type="void"/>
				<parameters>
					<parameter name="toolbar" type="GtkToolbar*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="uibdata" type="GnomeUIBuilderData*"/>
					<parameter name="accel_group" type="GtkAccelGroup*"/>
				</parameters>
			</method>
			<method name="fill_toolbar_with_data" symbol="gnome_app_fill_toolbar_with_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="toolbar" type="GtkToolbar*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="accel_group" type="GtkAccelGroup*"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="find_menu_pos" symbol="gnome_app_find_menu_pos">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWidget*"/>
					<parameter name="path" type="gchar*"/>
					<parameter name="pos" type="gint*"/>
				</parameters>
			</method>
			<method name="flash" symbol="gnome_app_flash">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="flash" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_dock" symbol="gnome_app_get_dock">
				<return-type type="BonoboDock*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
				</parameters>
			</method>
			<method name="get_dock_item_by_name" symbol="gnome_app_get_dock_item_by_name">
				<return-type type="BonoboDockItem*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="helper_gettext" symbol="gnome_app_helper_gettext">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="string" type="gchar*"/>
				</parameters>
			</method>
			<method name="insert_menus" symbol="gnome_app_insert_menus">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="path" type="gchar*"/>
					<parameter name="menuinfo" type="GnomeUIInfo*"/>
				</parameters>
			</method>
			<method name="insert_menus_custom" symbol="gnome_app_insert_menus_custom">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="path" type="gchar*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
					<parameter name="uibdata" type="GnomeUIBuilderData*"/>
				</parameters>
			</method>
			<method name="insert_menus_interp" symbol="gnome_app_insert_menus_interp">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="path" type="gchar*"/>
					<parameter name="menuinfo" type="GnomeUIInfo*"/>
					<parameter name="relay_func" type="GtkCallbackMarshal"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="destroy_func" type="GtkDestroyNotify"/>
				</parameters>
			</method>
			<method name="insert_menus_with_data" symbol="gnome_app_insert_menus_with_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="path" type="gchar*"/>
					<parameter name="menuinfo" type="GnomeUIInfo*"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="install_appbar_menu_hints" symbol="gnome_app_install_appbar_menu_hints">
				<return-type type="void"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
				</parameters>
			</method>
			<method name="install_menu_hints" symbol="gnome_app_install_menu_hints">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
				</parameters>
			</method>
			<method name="install_statusbar_menu_hints" symbol="gnome_app_install_statusbar_menu_hints">
				<return-type type="void"/>
				<parameters>
					<parameter name="bar" type="GtkStatusbar*"/>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
				</parameters>
			</method>
			<method name="message" symbol="gnome_app_message">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="message" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_app_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="appname" type="gchar*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="ok_cancel" symbol="gnome_app_ok_cancel">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="message" type="gchar*"/>
					<parameter name="callback" type="GnomeReplyCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="ok_cancel_modal" symbol="gnome_app_ok_cancel_modal">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="message" type="gchar*"/>
					<parameter name="callback" type="GnomeReplyCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="progress_done" symbol="gnome_app_progress_done">
				<return-type type="void"/>
				<parameters>
					<parameter name="key" type="GnomeAppProgressKey"/>
				</parameters>
			</method>
			<method name="progress_manual" symbol="gnome_app_progress_manual">
				<return-type type="GnomeAppProgressKey"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="description" type="gchar*"/>
					<parameter name="cancel_cb" type="GnomeAppProgressCancelFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="progress_timeout" symbol="gnome_app_progress_timeout">
				<return-type type="GnomeAppProgressKey"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="description" type="gchar*"/>
					<parameter name="interval" type="guint32"/>
					<parameter name="percentage_cb" type="GnomeAppProgressFunc"/>
					<parameter name="cancel_cb" type="GnomeAppProgressCancelFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="question" symbol="gnome_app_question">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="question" type="gchar*"/>
					<parameter name="callback" type="GnomeReplyCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="question_modal" symbol="gnome_app_question_modal">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="question" type="gchar*"/>
					<parameter name="callback" type="GnomeReplyCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="remove_menu_range" symbol="gnome_app_remove_menu_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="path" type="gchar*"/>
					<parameter name="start" type="gint"/>
					<parameter name="items" type="gint"/>
				</parameters>
			</method>
			<method name="remove_menus" symbol="gnome_app_remove_menus">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="path" type="gchar*"/>
					<parameter name="items" type="gint"/>
				</parameters>
			</method>
			<method name="request_password" symbol="gnome_app_request_password">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="prompt" type="gchar*"/>
					<parameter name="callback" type="GnomeStringCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="request_string" symbol="gnome_app_request_string">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="prompt" type="gchar*"/>
					<parameter name="callback" type="GnomeStringCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_contents" symbol="gnome_app_set_contents">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="contents" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="set_menus" symbol="gnome_app_set_menus">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="menubar" type="GtkMenuBar*"/>
				</parameters>
			</method>
			<method name="set_progress" symbol="gnome_app_set_progress">
				<return-type type="void"/>
				<parameters>
					<parameter name="key" type="GnomeAppProgressKey"/>
					<parameter name="percent" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_statusbar" symbol="gnome_app_set_statusbar">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="statusbar" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="set_statusbar_custom" symbol="gnome_app_set_statusbar_custom">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="container" type="GtkWidget*"/>
					<parameter name="statusbar" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="set_toolbar" symbol="gnome_app_set_toolbar">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="toolbar" type="GtkToolbar*"/>
				</parameters>
			</method>
			<method name="setup_toolbar" symbol="gnome_app_setup_toolbar">
				<return-type type="void"/>
				<parameters>
					<parameter name="toolbar" type="GtkToolbar*"/>
					<parameter name="dock_item" type="BonoboDockItem*"/>
				</parameters>
			</method>
			<method name="ui_configure_configurable" symbol="gnome_app_ui_configure_configurable">
				<return-type type="void"/>
				<parameters>
					<parameter name="uiinfo" type="GnomeUIInfo*"/>
				</parameters>
			</method>
			<method name="warning" symbol="gnome_app_warning">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
					<parameter name="warning" type="gchar*"/>
				</parameters>
			</method>
			<property name="app-id" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<field name="name" type="gchar*"/>
			<field name="prefix" type="gchar*"/>
			<field name="dock" type="GtkWidget*"/>
			<field name="statusbar" type="GtkWidget*"/>
			<field name="vbox" type="GtkWidget*"/>
			<field name="menubar" type="GtkWidget*"/>
			<field name="contents" type="GtkWidget*"/>
			<field name="layout" type="BonoboDockLayout*"/>
			<field name="accel_group" type="GtkAccelGroup*"/>
			<field name="enable_layout_config" type="guint"/>
		</object>
		<object name="GnomeAppBar" parent="GtkHBox" type-name="GnomeAppBar" get-type="gnome_appbar_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="clear_prompt" symbol="gnome_appbar_clear_prompt">
				<return-type type="void"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
				</parameters>
			</method>
			<method name="clear_stack" symbol="gnome_appbar_clear_stack">
				<return-type type="void"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
				</parameters>
			</method>
			<method name="get_progress" symbol="gnome_appbar_get_progress">
				<return-type type="GtkProgressBar*"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
				</parameters>
			</method>
			<method name="get_response" symbol="gnome_appbar_get_response">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
				</parameters>
			</method>
			<method name="get_status" symbol="gnome_appbar_get_status">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_appbar_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="has_progress" type="gboolean"/>
					<parameter name="has_status" type="gboolean"/>
					<parameter name="interactivity" type="GnomePreferencesType"/>
				</parameters>
			</constructor>
			<method name="pop" symbol="gnome_appbar_pop">
				<return-type type="void"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
				</parameters>
			</method>
			<method name="push" symbol="gnome_appbar_push">
				<return-type type="void"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
					<parameter name="status" type="gchar*"/>
				</parameters>
			</method>
			<method name="refresh" symbol="gnome_appbar_refresh">
				<return-type type="void"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
				</parameters>
			</method>
			<method name="set_default" symbol="gnome_appbar_set_default">
				<return-type type="void"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
					<parameter name="default_status" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_progress_percentage" symbol="gnome_appbar_set_progress_percentage">
				<return-type type="void"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
					<parameter name="percentage" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_prompt" symbol="gnome_appbar_set_prompt">
				<return-type type="void"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
					<parameter name="prompt" type="gchar*"/>
					<parameter name="modal" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_status" symbol="gnome_appbar_set_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="appbar" type="GnomeAppBar*"/>
					<parameter name="status" type="gchar*"/>
				</parameters>
			</method>
			<property name="has-progress" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="has-status" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="interactivity" type="GnomePreferencesType" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="clear-prompt" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="ab" type="GnomeAppBar*"/>
				</parameters>
			</signal>
			<signal name="user-response" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="ab" type="GnomeAppBar*"/>
				</parameters>
			</signal>
		</object>
		<object name="GnomeClient" parent="GtkObject" type-name="GnomeClient" get-type="gnome_client_get_type">
			<method name="add_static_arg" symbol="gnome_client_add_static_arg">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</method>
			<method name="connect" symbol="gnome_client_connect">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</method>
			<method name="disable_master_connection" symbol="gnome_client_disable_master_connection">
				<return-type type="void"/>
			</method>
			<method name="disconnect" symbol="gnome_client_disconnect">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</method>
			<method name="flush" symbol="gnome_client_flush">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</method>
			<method name="get_config_prefix" symbol="gnome_client_get_config_prefix">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</method>
			<method name="get_desktop_id" symbol="gnome_client_get_desktop_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="gnome_client_get_flags">
				<return-type type="GnomeClientFlags"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</method>
			<method name="get_global_config_prefix" symbol="gnome_client_get_global_config_prefix">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gnome_client_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</method>
			<method name="get_previous_id" symbol="gnome_client_get_previous_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</method>
			<method name="module_info_get" symbol="gnome_client_module_info_get">
				<return-type type="GnomeModuleInfo*"/>
			</method>
			<constructor name="new" symbol="gnome_client_new">
				<return-type type="GnomeClient*"/>
			</constructor>
			<constructor name="new_without_connection" symbol="gnome_client_new_without_connection">
				<return-type type="GnomeClient*"/>
			</constructor>
			<method name="request_interaction" symbol="gnome_client_request_interaction">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="dialog_type" type="GnomeDialogType"/>
					<parameter name="function" type="GnomeInteractFunction"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="request_interaction_interp" symbol="gnome_client_request_interaction_interp">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="dialog_type" type="GnomeDialogType"/>
					<parameter name="function" type="GtkCallbackMarshal"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="destroy" type="GtkDestroyNotify"/>
				</parameters>
			</method>
			<method name="request_phase_2" symbol="gnome_client_request_phase_2">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</method>
			<method name="request_save" symbol="gnome_client_request_save">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="save_style" type="GnomeSaveStyle"/>
					<parameter name="shutdown" type="gboolean"/>
					<parameter name="interact_style" type="GnomeInteractStyle"/>
					<parameter name="fast" type="gboolean"/>
					<parameter name="global" type="gboolean"/>
				</parameters>
			</method>
			<method name="save_any_dialog" symbol="gnome_client_save_any_dialog">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="dialog" type="GtkDialog*"/>
				</parameters>
			</method>
			<method name="save_error_dialog" symbol="gnome_client_save_error_dialog">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="dialog" type="GtkDialog*"/>
				</parameters>
			</method>
			<method name="set_clone_command" symbol="gnome_client_set_clone_command">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="argc" type="gint"/>
					<parameter name="argv" type="gchar*[]"/>
				</parameters>
			</method>
			<method name="set_current_directory" symbol="gnome_client_set_current_directory">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="dir" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_discard_command" symbol="gnome_client_set_discard_command">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="argc" type="gint"/>
					<parameter name="argv" type="gchar*[]"/>
				</parameters>
			</method>
			<method name="set_environment" symbol="gnome_client_set_environment">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_global_config_prefix" symbol="gnome_client_set_global_config_prefix">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="prefix" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_id" symbol="gnome_client_set_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_priority" symbol="gnome_client_set_priority">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="priority" type="guint"/>
				</parameters>
			</method>
			<method name="set_process_id" symbol="gnome_client_set_process_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="pid" type="pid_t"/>
				</parameters>
			</method>
			<method name="set_program" symbol="gnome_client_set_program">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="program" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_resign_command" symbol="gnome_client_set_resign_command">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="argc" type="gint"/>
					<parameter name="argv" type="gchar*[]"/>
				</parameters>
			</method>
			<method name="set_restart_command" symbol="gnome_client_set_restart_command">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="argc" type="gint"/>
					<parameter name="argv" type="gchar*[]"/>
				</parameters>
			</method>
			<method name="set_restart_style" symbol="gnome_client_set_restart_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="style" type="GnomeRestartStyle"/>
				</parameters>
			</method>
			<method name="set_shutdown_command" symbol="gnome_client_set_shutdown_command">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="argc" type="gint"/>
					<parameter name="argv" type="gchar*[]"/>
				</parameters>
			</method>
			<method name="set_user_id" symbol="gnome_client_set_user_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<signal name="connect" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="restarted" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="die" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</signal>
			<signal name="disconnect" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</signal>
			<signal name="save-complete" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</signal>
			<signal name="save-yourself" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
					<parameter name="phase" type="gint"/>
					<parameter name="save_style" type="GnomeSaveStyle"/>
					<parameter name="shutdown" type="gboolean"/>
					<parameter name="interact_style" type="GnomeInteractStyle"/>
					<parameter name="fast" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="shutdown-cancelled" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="GnomeClient*"/>
				</parameters>
			</signal>
			<field name="smc_conn" type="gpointer"/>
			<field name="client_id" type="gchar*"/>
			<field name="previous_id" type="gchar*"/>
			<field name="config_prefix" type="gchar*"/>
			<field name="global_config_prefix" type="gchar*"/>
			<field name="static_args" type="GList*"/>
			<field name="clone_command" type="gchar**"/>
			<field name="current_directory" type="gchar*"/>
			<field name="discard_command" type="gchar**"/>
			<field name="environment" type="GHashTable*"/>
			<field name="process_id" type="pid_t"/>
			<field name="program" type="gchar*"/>
			<field name="resign_command" type="gchar**"/>
			<field name="restart_command" type="gchar**"/>
			<field name="restart_style" type="GnomeRestartStyle"/>
			<field name="shutdown_command" type="gchar**"/>
			<field name="user_id" type="gchar*"/>
			<field name="interaction_keys" type="GSList*"/>
			<field name="input_id" type="gint"/>
			<field name="save_style" type="guint"/>
			<field name="interact_style" type="guint"/>
			<field name="state" type="guint"/>
			<field name="shutdown" type="guint"/>
			<field name="fast" type="guint"/>
			<field name="save_phase_2_requested" type="guint"/>
			<field name="save_successfull" type="guint"/>
			<field name="save_yourself_emitted" type="guint"/>
			<field name="reserved" type="gpointer"/>
		</object>
		<object name="GnomeColorPicker" parent="GtkButton" type-name="GnomeColorPicker" get-type="gnome_color_picker_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_d" symbol="gnome_color_picker_get_d">
				<return-type type="void"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
					<parameter name="r" type="gdouble*"/>
					<parameter name="g" type="gdouble*"/>
					<parameter name="b" type="gdouble*"/>
					<parameter name="a" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_dither" symbol="gnome_color_picker_get_dither">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
				</parameters>
			</method>
			<method name="get_i16" symbol="gnome_color_picker_get_i16">
				<return-type type="void"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
					<parameter name="r" type="gushort*"/>
					<parameter name="g" type="gushort*"/>
					<parameter name="b" type="gushort*"/>
					<parameter name="a" type="gushort*"/>
				</parameters>
			</method>
			<method name="get_i8" symbol="gnome_color_picker_get_i8">
				<return-type type="void"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
					<parameter name="r" type="guint8*"/>
					<parameter name="g" type="guint8*"/>
					<parameter name="b" type="guint8*"/>
					<parameter name="a" type="guint8*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="gnome_color_picker_get_title">
				<return-type type="char*"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
				</parameters>
			</method>
			<method name="get_use_alpha" symbol="gnome_color_picker_get_use_alpha">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_color_picker_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_d" symbol="gnome_color_picker_set_d">
				<return-type type="void"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
					<parameter name="r" type="gdouble"/>
					<parameter name="g" type="gdouble"/>
					<parameter name="b" type="gdouble"/>
					<parameter name="a" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_dither" symbol="gnome_color_picker_set_dither">
				<return-type type="void"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
					<parameter name="dither" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_i16" symbol="gnome_color_picker_set_i16">
				<return-type type="void"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
					<parameter name="r" type="gushort"/>
					<parameter name="g" type="gushort"/>
					<parameter name="b" type="gushort"/>
					<parameter name="a" type="gushort"/>
				</parameters>
			</method>
			<method name="set_i8" symbol="gnome_color_picker_set_i8">
				<return-type type="void"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
					<parameter name="r" type="guint8"/>
					<parameter name="g" type="guint8"/>
					<parameter name="b" type="guint8"/>
					<parameter name="a" type="guint8"/>
				</parameters>
			</method>
			<method name="set_title" symbol="gnome_color_picker_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_use_alpha" symbol="gnome_color_picker_set_use_alpha">
				<return-type type="void"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
					<parameter name="use_alpha" type="gboolean"/>
				</parameters>
			</method>
			<property name="alpha" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="blue" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="dither" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="green" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="red" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-alpha" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="color-set" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="cp" type="GnomeColorPicker*"/>
					<parameter name="r" type="guint"/>
					<parameter name="g" type="guint"/>
					<parameter name="b" type="guint"/>
					<parameter name="a" type="guint"/>
				</parameters>
			</signal>
		</object>
		<object name="GnomeDateEdit" parent="GtkHBox" type-name="GnomeDateEdit" get-type="gnome_date_edit_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="construct" symbol="gnome_date_edit_construct">
				<return-type type="void"/>
				<parameters>
					<parameter name="gde" type="GnomeDateEdit*"/>
					<parameter name="the_time" type="time_t"/>
					<parameter name="flags" type="GnomeDateEditFlags"/>
				</parameters>
			</method>
			<method name="get_date" symbol="gnome_date_edit_get_date">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="gde" type="GnomeDateEdit*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="gnome_date_edit_get_flags">
				<return-type type="int"/>
				<parameters>
					<parameter name="gde" type="GnomeDateEdit*"/>
				</parameters>
			</method>
			<method name="get_initial_time" symbol="gnome_date_edit_get_initial_time">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="gde" type="GnomeDateEdit*"/>
				</parameters>
			</method>
			<method name="get_time" symbol="gnome_date_edit_get_time">
				<return-type type="time_t"/>
				<parameters>
					<parameter name="gde" type="GnomeDateEdit*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_date_edit_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="the_time" type="time_t"/>
					<parameter name="show_time" type="gboolean"/>
					<parameter name="use_24_format" type="gboolean"/>
				</parameters>
			</constructor>
			<constructor name="new_flags" symbol="gnome_date_edit_new_flags">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="the_time" type="time_t"/>
					<parameter name="flags" type="GnomeDateEditFlags"/>
				</parameters>
			</constructor>
			<method name="set_flags" symbol="gnome_date_edit_set_flags">
				<return-type type="void"/>
				<parameters>
					<parameter name="gde" type="GnomeDateEdit*"/>
					<parameter name="flags" type="GnomeDateEditFlags"/>
				</parameters>
			</method>
			<method name="set_popup_range" symbol="gnome_date_edit_set_popup_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="gde" type="GnomeDateEdit*"/>
					<parameter name="low_hour" type="int"/>
					<parameter name="up_hour" type="int"/>
				</parameters>
			</method>
			<method name="set_time" symbol="gnome_date_edit_set_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="gde" type="GnomeDateEdit*"/>
					<parameter name="the_time" type="time_t"/>
				</parameters>
			</method>
			<property name="dateedit-flags" type="GnomeDateEditFlags" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="initial-time" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="lower-hour" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="time" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="upper-hour" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="date-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="gde" type="GnomeDateEdit*"/>
				</parameters>
			</signal>
			<signal name="time-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="gde" type="GnomeDateEdit*"/>
				</parameters>
			</signal>
		</object>
		<object name="GnomeDialog" parent="GtkWindow" type-name="GnomeDialog" get-type="gnome_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="append_button" symbol="gnome_dialog_append_button">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="button_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="append_button_with_pixmap" symbol="gnome_dialog_append_button_with_pixmap">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="button_name" type="gchar*"/>
					<parameter name="pixmap_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="append_buttons" symbol="gnome_dialog_append_buttons">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="first" type="gchar*"/>
				</parameters>
			</method>
			<method name="append_buttons_with_pixmaps" symbol="gnome_dialog_append_buttons_with_pixmaps">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="names" type="gchar**"/>
					<parameter name="pixmaps" type="gchar**"/>
				</parameters>
			</method>
			<method name="append_buttonsv" symbol="gnome_dialog_append_buttonsv">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="buttons" type="gchar**"/>
				</parameters>
			</method>
			<method name="button_connect" symbol="gnome_dialog_button_connect">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="button" type="gint"/>
					<parameter name="callback" type="GCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="button_connect_object" symbol="gnome_dialog_button_connect_object">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="button" type="gint"/>
					<parameter name="callback" type="GCallback"/>
					<parameter name="obj" type="GtkObject*"/>
				</parameters>
			</method>
			<method name="close" symbol="gnome_dialog_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
				</parameters>
			</method>
			<method name="close_hides" symbol="gnome_dialog_close_hides">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="just_hide" type="gboolean"/>
				</parameters>
			</method>
			<method name="construct" symbol="gnome_dialog_construct">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="title" type="gchar*"/>
					<parameter name="ap" type="va_list"/>
				</parameters>
			</method>
			<method name="constructv" symbol="gnome_dialog_constructv">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="title" type="gchar*"/>
					<parameter name="buttons" type="gchar**"/>
				</parameters>
			</method>
			<method name="editable_enters" symbol="gnome_dialog_editable_enters">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="editable" type="GtkEditable*"/>
				</parameters>
			</method>
			<method name="grab_focus" symbol="gnome_dialog_grab_focus">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="button" type="gint"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="newv" symbol="gnome_dialog_newv">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="title" type="gchar*"/>
					<parameter name="buttons" type="gchar**"/>
				</parameters>
			</constructor>
			<method name="run" symbol="gnome_dialog_run">
				<return-type type="gint"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
				</parameters>
			</method>
			<method name="run_and_close" symbol="gnome_dialog_run_and_close">
				<return-type type="gint"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
				</parameters>
			</method>
			<method name="set_accelerator" symbol="gnome_dialog_set_accelerator">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="button" type="gint"/>
					<parameter name="accelerator_key" type="guchar"/>
					<parameter name="accelerator_mods" type="guint8"/>
				</parameters>
			</method>
			<method name="set_close" symbol="gnome_dialog_set_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="click_closes" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_default" symbol="gnome_dialog_set_default">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="button" type="gint"/>
				</parameters>
			</method>
			<method name="set_parent" symbol="gnome_dialog_set_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="parent" type="GtkWindow*"/>
				</parameters>
			</method>
			<method name="set_sensitive" symbol="gnome_dialog_set_sensitive">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="button" type="gint"/>
					<parameter name="setting" type="gboolean"/>
				</parameters>
			</method>
			<signal name="clicked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
					<parameter name="button_number" type="gint"/>
				</parameters>
			</signal>
			<signal name="close" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dialog" type="GnomeDialog*"/>
				</parameters>
			</signal>
			<field name="vbox" type="GtkWidget*"/>
			<field name="buttons" type="GList*"/>
			<field name="action_area" type="GtkWidget*"/>
			<field name="accelerators" type="GtkAccelGroup*"/>
			<field name="click_closes" type="unsigned"/>
			<field name="just_hide" type="unsigned"/>
		</object>
		<object name="GnomeDruid" parent="GtkContainer" type-name="GnomeDruid" get-type="gnome_druid_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="append_page" symbol="gnome_druid_append_page">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid" type="GnomeDruid*"/>
					<parameter name="page" type="GnomeDruidPage*"/>
				</parameters>
			</method>
			<method name="construct_with_window" symbol="gnome_druid_construct_with_window">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid" type="GnomeDruid*"/>
					<parameter name="title" type="char*"/>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="close_on_cancel" type="gboolean"/>
					<parameter name="window" type="GtkWidget**"/>
				</parameters>
			</method>
			<method name="insert_page" symbol="gnome_druid_insert_page">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid" type="GnomeDruid*"/>
					<parameter name="back_page" type="GnomeDruidPage*"/>
					<parameter name="page" type="GnomeDruidPage*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_druid_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_with_window" symbol="gnome_druid_new_with_window">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="title" type="char*"/>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="close_on_cancel" type="gboolean"/>
					<parameter name="window" type="GtkWidget**"/>
				</parameters>
			</constructor>
			<method name="prepend_page" symbol="gnome_druid_prepend_page">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid" type="GnomeDruid*"/>
					<parameter name="page" type="GnomeDruidPage*"/>
				</parameters>
			</method>
			<method name="set_buttons_sensitive" symbol="gnome_druid_set_buttons_sensitive">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid" type="GnomeDruid*"/>
					<parameter name="back_sensitive" type="gboolean"/>
					<parameter name="next_sensitive" type="gboolean"/>
					<parameter name="cancel_sensitive" type="gboolean"/>
					<parameter name="help_sensitive" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_page" symbol="gnome_druid_set_page">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid" type="GnomeDruid*"/>
					<parameter name="page" type="GnomeDruidPage*"/>
				</parameters>
			</method>
			<method name="set_show_finish" symbol="gnome_druid_set_show_finish">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid" type="GnomeDruid*"/>
					<parameter name="show_finish" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_show_help" symbol="gnome_druid_set_show_help">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid" type="GnomeDruid*"/>
					<parameter name="show_help" type="gboolean"/>
				</parameters>
			</method>
			<property name="show-finish" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-help" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="cancel" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid" type="GnomeDruid*"/>
				</parameters>
			</signal>
			<signal name="help" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid" type="GnomeDruid*"/>
				</parameters>
			</signal>
			<field name="help" type="GtkWidget*"/>
			<field name="back" type="GtkWidget*"/>
			<field name="next" type="GtkWidget*"/>
			<field name="cancel" type="GtkWidget*"/>
			<field name="finish" type="GtkWidget*"/>
		</object>
		<object name="GnomeDruidPage" parent="GtkBin" type-name="GnomeDruidPage" get-type="gnome_druid_page_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="back" symbol="gnome_druid_page_back">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="druid_page" type="GnomeDruidPage*"/>
				</parameters>
			</method>
			<method name="cancel" symbol="gnome_druid_page_cancel">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="druid_page" type="GnomeDruidPage*"/>
				</parameters>
			</method>
			<method name="finish" symbol="gnome_druid_page_finish">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page" type="GnomeDruidPage*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_druid_page_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="next" symbol="gnome_druid_page_next">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="druid_page" type="GnomeDruidPage*"/>
				</parameters>
			</method>
			<method name="prepare" symbol="gnome_druid_page_prepare">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page" type="GnomeDruidPage*"/>
				</parameters>
			</method>
			<signal name="back" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="druid_page" type="GnomeDruidPage*"/>
					<parameter name="druid" type="GtkWidget*"/>
				</parameters>
			</signal>
			<signal name="cancel" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="druid_page" type="GnomeDruidPage*"/>
					<parameter name="druid" type="GtkWidget*"/>
				</parameters>
			</signal>
			<signal name="finish" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page" type="GnomeDruidPage*"/>
					<parameter name="druid" type="GtkWidget*"/>
				</parameters>
			</signal>
			<signal name="next" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="druid_page" type="GnomeDruidPage*"/>
					<parameter name="druid" type="GtkWidget*"/>
				</parameters>
			</signal>
			<signal name="prepare" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page" type="GnomeDruidPage*"/>
					<parameter name="druid" type="GtkWidget*"/>
				</parameters>
			</signal>
			<vfunc name="configure_canvas">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page" type="GnomeDruidPage*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_sidebar_shown">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page" type="GnomeDruidPage*"/>
					<parameter name="sidebar_shown" type="gboolean"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GnomeDruidPageEdge" parent="GnomeDruidPage" type-name="GnomeDruidPageEdge" get-type="gnome_druid_page_edge_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="construct" symbol="gnome_druid_page_edge_construct">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_edge" type="GnomeDruidPageEdge*"/>
					<parameter name="position" type="GnomeEdgePosition"/>
					<parameter name="antialiased" type="gboolean"/>
					<parameter name="title" type="gchar*"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="logo" type="GdkPixbuf*"/>
					<parameter name="watermark" type="GdkPixbuf*"/>
					<parameter name="top_watermark" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_druid_page_edge_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="position" type="GnomeEdgePosition"/>
				</parameters>
			</constructor>
			<constructor name="new_aa" symbol="gnome_druid_page_edge_new_aa">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="position" type="GnomeEdgePosition"/>
				</parameters>
			</constructor>
			<constructor name="new_with_vals" symbol="gnome_druid_page_edge_new_with_vals">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="position" type="GnomeEdgePosition"/>
					<parameter name="antialiased" type="gboolean"/>
					<parameter name="title" type="gchar*"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="logo" type="GdkPixbuf*"/>
					<parameter name="watermark" type="GdkPixbuf*"/>
					<parameter name="top_watermark" type="GdkPixbuf*"/>
				</parameters>
			</constructor>
			<method name="set_bg_color" symbol="gnome_druid_page_edge_set_bg_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_edge" type="GnomeDruidPageEdge*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_logo" symbol="gnome_druid_page_edge_set_logo">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_edge" type="GnomeDruidPageEdge*"/>
					<parameter name="logo_image" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="set_logo_bg_color" symbol="gnome_druid_page_edge_set_logo_bg_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_edge" type="GnomeDruidPageEdge*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_text" symbol="gnome_druid_page_edge_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_edge" type="GnomeDruidPageEdge*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_text_color" symbol="gnome_druid_page_edge_set_text_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_edge" type="GnomeDruidPageEdge*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_textbox_color" symbol="gnome_druid_page_edge_set_textbox_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_edge" type="GnomeDruidPageEdge*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_title" symbol="gnome_druid_page_edge_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_edge" type="GnomeDruidPageEdge*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_title_color" symbol="gnome_druid_page_edge_set_title_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_edge" type="GnomeDruidPageEdge*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_top_watermark" symbol="gnome_druid_page_edge_set_top_watermark">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_edge" type="GnomeDruidPageEdge*"/>
					<parameter name="top_watermark_image" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="set_watermark" symbol="gnome_druid_page_edge_set_watermark">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_edge" type="GnomeDruidPageEdge*"/>
					<parameter name="watermark" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<field name="title" type="gchar*"/>
			<field name="text" type="gchar*"/>
			<field name="logo_image" type="GdkPixbuf*"/>
			<field name="watermark_image" type="GdkPixbuf*"/>
			<field name="top_watermark_image" type="GdkPixbuf*"/>
			<field name="background_color" type="GdkColor"/>
			<field name="textbox_color" type="GdkColor"/>
			<field name="logo_background_color" type="GdkColor"/>
			<field name="title_color" type="GdkColor"/>
			<field name="text_color" type="GdkColor"/>
			<field name="position" type="guint"/>
		</object>
		<object name="GnomeDruidPageStandard" parent="GnomeDruidPage" type-name="GnomeDruidPageStandard" get-type="gnome_druid_page_standard_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="append_item" symbol="gnome_druid_page_standard_append_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_standard" type="GnomeDruidPageStandard*"/>
					<parameter name="question" type="gchar*"/>
					<parameter name="item" type="GtkWidget*"/>
					<parameter name="additional_info" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_druid_page_standard_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_with_vals" symbol="gnome_druid_page_standard_new_with_vals">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="title" type="gchar*"/>
					<parameter name="logo" type="GdkPixbuf*"/>
					<parameter name="top_watermark" type="GdkPixbuf*"/>
				</parameters>
			</constructor>
			<method name="set_background" symbol="gnome_druid_page_standard_set_background">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_standard" type="GnomeDruidPageStandard*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_contents_background" symbol="gnome_druid_page_standard_set_contents_background">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_standard" type="GnomeDruidPageStandard*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_logo" symbol="gnome_druid_page_standard_set_logo">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_standard" type="GnomeDruidPageStandard*"/>
					<parameter name="logo_image" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="set_logo_background" symbol="gnome_druid_page_standard_set_logo_background">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_standard" type="GnomeDruidPageStandard*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_title" symbol="gnome_druid_page_standard_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_standard" type="GnomeDruidPageStandard*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_title_foreground" symbol="gnome_druid_page_standard_set_title_foreground">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_standard" type="GnomeDruidPageStandard*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_top_watermark" symbol="gnome_druid_page_standard_set_top_watermark">
				<return-type type="void"/>
				<parameters>
					<parameter name="druid_page_standard" type="GnomeDruidPageStandard*"/>
					<parameter name="top_watermark_image" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<property name="background" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="background-gdk" type="GdkColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="background-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="contents-background" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="contents-background-gdk" type="GdkColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="contents-background-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="logo" type="GdkPixbuf*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="logo-background" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="logo-background-gdk" type="GdkColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="logo-background-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title-foreground" type="char*" readable="0" writable="1" construct="0" construct-only="0"/>
			<property name="title-foreground-gdk" type="GdkColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title-foreground-set" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="top-watermark" type="GdkPixbuf*" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="vbox" type="GtkWidget*"/>
			<field name="title" type="gchar*"/>
			<field name="logo" type="GdkPixbuf*"/>
			<field name="top_watermark" type="GdkPixbuf*"/>
			<field name="title_foreground" type="GdkColor"/>
			<field name="background" type="GdkColor"/>
			<field name="logo_background" type="GdkColor"/>
			<field name="contents_background" type="GdkColor"/>
		</object>
		<object name="GnomeEntry" parent="GtkCombo" type-name="GnomeEntry" get-type="gnome_entry_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkEditable"/>
			</implements>
			<method name="append_history" symbol="gnome_entry_append_history">
				<return-type type="void"/>
				<parameters>
					<parameter name="gentry" type="GnomeEntry*"/>
					<parameter name="save" type="gboolean"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="clear_history" symbol="gnome_entry_clear_history">
				<return-type type="void"/>
				<parameters>
					<parameter name="gentry" type="GnomeEntry*"/>
				</parameters>
			</method>
			<method name="get_history_id" symbol="gnome_entry_get_history_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="gentry" type="GnomeEntry*"/>
				</parameters>
			</method>
			<method name="get_max_saved" symbol="gnome_entry_get_max_saved">
				<return-type type="guint"/>
				<parameters>
					<parameter name="gentry" type="GnomeEntry*"/>
				</parameters>
			</method>
			<method name="gtk_entry" symbol="gnome_entry_gtk_entry">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="gentry" type="GnomeEntry*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_entry_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="history_id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="prepend_history" symbol="gnome_entry_prepend_history">
				<return-type type="void"/>
				<parameters>
					<parameter name="gentry" type="GnomeEntry*"/>
					<parameter name="save" type="gboolean"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_history_id" symbol="gnome_entry_set_history_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="gentry" type="GnomeEntry*"/>
					<parameter name="history_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_max_saved" symbol="gnome_entry_set_max_saved">
				<return-type type="void"/>
				<parameters>
					<parameter name="gentry" type="GnomeEntry*"/>
					<parameter name="max_saved" type="guint"/>
				</parameters>
			</method>
			<property name="gtk-entry" type="GtkEntry*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="history-id" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="activate" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="GnomeEntry*"/>
				</parameters>
			</signal>
		</object>
		<object name="GnomeFileEntry" parent="GtkVBox" type-name="GnomeFileEntry" get-type="gnome_file_entry_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkEditable"/>
			</implements>
			<method name="construct" symbol="gnome_file_entry_construct">
				<return-type type="void"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
					<parameter name="history_id" type="char*"/>
					<parameter name="browse_dialog_title" type="char*"/>
				</parameters>
			</method>
			<method name="get_directory_entry" symbol="gnome_file_entry_get_directory_entry">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
				</parameters>
			</method>
			<method name="get_full_path" symbol="gnome_file_entry_get_full_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
					<parameter name="file_must_exist" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_modal" symbol="gnome_file_entry_get_modal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
				</parameters>
			</method>
			<method name="gnome_entry" symbol="gnome_file_entry_gnome_entry">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
				</parameters>
			</method>
			<method name="gtk_entry" symbol="gnome_file_entry_gtk_entry">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_file_entry_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="history_id" type="char*"/>
					<parameter name="browse_dialog_title" type="char*"/>
				</parameters>
			</constructor>
			<method name="set_default_path" symbol="gnome_file_entry_set_default_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="set_directory" symbol="gnome_file_entry_set_directory">
				<return-type type="void"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
					<parameter name="directory_entry" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_directory_entry" symbol="gnome_file_entry_set_directory_entry">
				<return-type type="void"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
					<parameter name="directory_entry" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_filename" symbol="gnome_file_entry_set_filename">
				<return-type type="void"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
					<parameter name="filename" type="char*"/>
				</parameters>
			</method>
			<method name="set_modal" symbol="gnome_file_entry_set_modal">
				<return-type type="void"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
					<parameter name="is_modal" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_title" symbol="gnome_file_entry_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
					<parameter name="browse_dialog_title" type="char*"/>
				</parameters>
			</method>
			<property name="browse-dialog-title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="default-path" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="directory-entry" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="filechooser-action" type="GtkFileChooserAction" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="filename" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="gnome-entry" type="GnomeEntry*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="gtk-entry" type="GtkEntry*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="history-id" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="modal" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-filechooser" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="activate" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
				</parameters>
			</signal>
			<signal name="browse-clicked" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="fentry" type="GnomeFileEntry*"/>
				</parameters>
			</signal>
			<field name="fsw" type="GtkWidget*"/>
			<field name="default_path" type="char*"/>
		</object>
		<object name="GnomeFontPicker" parent="GtkButton" type-name="GnomeFontPicker" get-type="gnome_font_picker_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="fi_set_show_size" symbol="gnome_font_picker_fi_set_show_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
					<parameter name="show_size" type="gboolean"/>
				</parameters>
			</method>
			<method name="fi_set_use_font_in_label" symbol="gnome_font_picker_fi_set_use_font_in_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
					<parameter name="use_font_in_label" type="gboolean"/>
					<parameter name="size" type="gint"/>
				</parameters>
			</method>
			<method name="get_font" symbol="gnome_font_picker_get_font">
				<return-type type="GdkFont*"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
				</parameters>
			</method>
			<method name="get_font_name" symbol="gnome_font_picker_get_font_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
				</parameters>
			</method>
			<method name="get_mode" symbol="gnome_font_picker_get_mode">
				<return-type type="GnomeFontPickerMode"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
				</parameters>
			</method>
			<method name="get_preview_text" symbol="gnome_font_picker_get_preview_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="gnome_font_picker_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_font_picker_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_font_name" symbol="gnome_font_picker_set_font_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
					<parameter name="fontname" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_mode" symbol="gnome_font_picker_set_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
					<parameter name="mode" type="GnomeFontPickerMode"/>
				</parameters>
			</method>
			<method name="set_preview_text" symbol="gnome_font_picker_set_preview_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_title" symbol="gnome_font_picker_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<method name="uw_get_widget" symbol="gnome_font_picker_uw_get_widget">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
				</parameters>
			</method>
			<method name="uw_set_widget" symbol="gnome_font_picker_uw_set_widget">
				<return-type type="void"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
					<parameter name="widget" type="GtkWidget*"/>
				</parameters>
			</method>
			<property name="font" type="gpointer" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="font-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label-font-size" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="mode" type="GnomeFontPickerMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="preview-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-size" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-font-in-label" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="font-set" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="gfp" type="GnomeFontPicker*"/>
					<parameter name="font_name" type="char*"/>
				</parameters>
			</signal>
		</object>
		<object name="GnomeHRef" parent="GtkButton" type-name="GnomeHRef" get-type="gnome_href_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_label" symbol="gnome_href_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="href" type="GnomeHRef*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="gnome_href_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="href" type="GnomeHRef*"/>
				</parameters>
			</method>
			<method name="get_url" symbol="gnome_href_get_url">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="href" type="GnomeHRef*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_href_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="url" type="gchar*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_label" symbol="gnome_href_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="href" type="GnomeHRef*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_text" symbol="gnome_href_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="href" type="GnomeHRef*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_url" symbol="gnome_href_set_url">
				<return-type type="void"/>
				<parameters>
					<parameter name="href" type="GnomeHRef*"/>
					<parameter name="url" type="gchar*"/>
				</parameters>
			</method>
			<property name="text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="url" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GnomeIconEntry" parent="GtkVBox" type-name="GnomeIconEntry" get-type="gnome_icon_entry_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="construct" symbol="gnome_icon_entry_construct">
				<return-type type="void"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
					<parameter name="history_id" type="gchar*"/>
					<parameter name="browse_dialog_title" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_filename" symbol="gnome_icon_entry_get_filename">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
				</parameters>
			</method>
			<method name="gnome_entry" symbol="gnome_icon_entry_gnome_entry">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
				</parameters>
			</method>
			<method name="gnome_file_entry" symbol="gnome_icon_entry_gnome_file_entry">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
				</parameters>
			</method>
			<method name="gtk_entry" symbol="gnome_icon_entry_gtk_entry">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_icon_entry_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="history_id" type="gchar*"/>
					<parameter name="browse_dialog_title" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="pick_dialog" symbol="gnome_icon_entry_pick_dialog">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
				</parameters>
			</method>
			<method name="set_browse_dialog_title" symbol="gnome_icon_entry_set_browse_dialog_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
					<parameter name="browse_dialog_title" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_filename" symbol="gnome_icon_entry_set_filename">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_history_id" symbol="gnome_icon_entry_set_history_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
					<parameter name="history_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_icon" symbol="gnome_icon_entry_set_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_max_saved" symbol="gnome_icon_entry_set_max_saved">
				<return-type type="void"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
					<parameter name="max_saved" type="guint"/>
				</parameters>
			</method>
			<method name="set_pixmap_subdir" symbol="gnome_icon_entry_set_pixmap_subdir">
				<return-type type="void"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
					<parameter name="subdir" type="gchar*"/>
				</parameters>
			</method>
			<property name="browse-dialog-title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="filename" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="history-id" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pick-dialog" type="GtkDialog*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="pixmap-subdir" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="browse" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
				</parameters>
			</signal>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="ientry" type="GnomeIconEntry*"/>
				</parameters>
			</signal>
		</object>
		<object name="GnomeIconList" parent="GnomeCanvas" type-name="GnomeIconList" get-type="gnome_icon_list_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="append" symbol="gnome_icon_list_append">
				<return-type type="int"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="icon_filename" type="char*"/>
					<parameter name="text" type="char*"/>
				</parameters>
			</method>
			<method name="append_pixbuf" symbol="gnome_icon_list_append_pixbuf">
				<return-type type="int"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="im" type="GdkPixbuf*"/>
					<parameter name="icon_filename" type="char*"/>
					<parameter name="text" type="char*"/>
				</parameters>
			</method>
			<method name="clear" symbol="gnome_icon_list_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
				</parameters>
			</method>
			<method name="construct" symbol="gnome_icon_list_construct">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="icon_width" type="guint"/>
					<parameter name="adj" type="GtkAdjustment*"/>
					<parameter name="flags" type="int"/>
				</parameters>
			</method>
			<method name="find_icon_from_data" symbol="gnome_icon_list_find_icon_from_data">
				<return-type type="int"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="find_icon_from_filename" symbol="gnome_icon_list_find_icon_from_filename">
				<return-type type="int"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="filename" type="char*"/>
				</parameters>
			</method>
			<method name="focus_icon" symbol="gnome_icon_list_focus_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="idx" type="gint"/>
				</parameters>
			</method>
			<method name="freeze" symbol="gnome_icon_list_freeze">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
				</parameters>
			</method>
			<method name="get_icon_at" symbol="gnome_icon_list_get_icon_at">
				<return-type type="int"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
				</parameters>
			</method>
			<method name="get_icon_data" symbol="gnome_icon_list_get_icon_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pos" type="int"/>
				</parameters>
			</method>
			<method name="get_icon_filename" symbol="gnome_icon_list_get_icon_filename">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="idx" type="int"/>
				</parameters>
			</method>
			<method name="get_icon_pixbuf_item" symbol="gnome_icon_list_get_icon_pixbuf_item">
				<return-type type="GnomeCanvasPixbuf*"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="idx" type="int"/>
				</parameters>
			</method>
			<method name="get_icon_text_item" symbol="gnome_icon_list_get_icon_text_item">
				<return-type type="GnomeIconTextItem*"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="idx" type="int"/>
				</parameters>
			</method>
			<method name="get_items_per_line" symbol="gnome_icon_list_get_items_per_line">
				<return-type type="int"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
				</parameters>
			</method>
			<method name="get_num_icons" symbol="gnome_icon_list_get_num_icons">
				<return-type type="guint"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
				</parameters>
			</method>
			<method name="get_selection" symbol="gnome_icon_list_get_selection">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
				</parameters>
			</method>
			<method name="get_selection_mode" symbol="gnome_icon_list_get_selection_mode">
				<return-type type="GtkSelectionMode"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
				</parameters>
			</method>
			<method name="icon_is_visible" symbol="gnome_icon_list_icon_is_visible">
				<return-type type="GtkVisibility"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pos" type="int"/>
				</parameters>
			</method>
			<method name="insert" symbol="gnome_icon_list_insert">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pos" type="int"/>
					<parameter name="icon_filename" type="char*"/>
					<parameter name="text" type="char*"/>
				</parameters>
			</method>
			<method name="insert_pixbuf" symbol="gnome_icon_list_insert_pixbuf">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pos" type="int"/>
					<parameter name="im" type="GdkPixbuf*"/>
					<parameter name="icon_filename" type="char*"/>
					<parameter name="text" type="char*"/>
				</parameters>
			</method>
			<method name="moveto" symbol="gnome_icon_list_moveto">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pos" type="int"/>
					<parameter name="yalign" type="double"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_icon_list_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="icon_width" type="guint"/>
					<parameter name="adj" type="GtkAdjustment*"/>
					<parameter name="flags" type="int"/>
				</parameters>
			</constructor>
			<method name="remove" symbol="gnome_icon_list_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pos" type="int"/>
				</parameters>
			</method>
			<method name="select_all" symbol="gnome_icon_list_select_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
				</parameters>
			</method>
			<method name="select_icon" symbol="gnome_icon_list_select_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pos" type="int"/>
				</parameters>
			</method>
			<method name="set_col_spacing" symbol="gnome_icon_list_set_col_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pixels" type="int"/>
				</parameters>
			</method>
			<method name="set_hadjustment" symbol="gnome_icon_list_set_hadjustment">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="hadj" type="GtkAdjustment*"/>
				</parameters>
			</method>
			<method name="set_icon_border" symbol="gnome_icon_list_set_icon_border">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pixels" type="int"/>
				</parameters>
			</method>
			<method name="set_icon_data" symbol="gnome_icon_list_set_icon_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="idx" type="int"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_icon_data_full" symbol="gnome_icon_list_set_icon_data_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pos" type="int"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_icon_width" symbol="gnome_icon_list_set_icon_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="w" type="int"/>
				</parameters>
			</method>
			<method name="set_row_spacing" symbol="gnome_icon_list_set_row_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pixels" type="int"/>
				</parameters>
			</method>
			<method name="set_selection_mode" symbol="gnome_icon_list_set_selection_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="mode" type="GtkSelectionMode"/>
				</parameters>
			</method>
			<method name="set_separators" symbol="gnome_icon_list_set_separators">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="sep" type="char*"/>
				</parameters>
			</method>
			<method name="set_text_spacing" symbol="gnome_icon_list_set_text_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pixels" type="int"/>
				</parameters>
			</method>
			<method name="set_vadjustment" symbol="gnome_icon_list_set_vadjustment">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="vadj" type="GtkAdjustment*"/>
				</parameters>
			</method>
			<method name="thaw" symbol="gnome_icon_list_thaw">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
				</parameters>
			</method>
			<method name="unselect_all" symbol="gnome_icon_list_unselect_all">
				<return-type type="int"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
				</parameters>
			</method>
			<method name="unselect_icon" symbol="gnome_icon_list_unselect_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="pos" type="int"/>
				</parameters>
			</method>
			<signal name="focus-icon" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="num" type="gint"/>
				</parameters>
			</signal>
			<signal name="move-cursor" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="dir" type="GtkDirectionType"/>
					<parameter name="clear_selection" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="select-icon" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="num" type="gint"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<signal name="text-changed" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="num" type="gint"/>
					<parameter name="new_text" type="char*"/>
				</parameters>
			</signal>
			<signal name="toggle-cursor-selection" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
				</parameters>
			</signal>
			<signal name="unselect-icon" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="gil" type="GnomeIconList*"/>
					<parameter name="num" type="gint"/>
					<parameter name="event" type="GdkEvent*"/>
				</parameters>
			</signal>
			<vfunc name="unused">
				<return-type type="void"/>
				<parameters>
					<parameter name="unused" type="GnomeIconList*"/>
				</parameters>
			</vfunc>
			<field name="adj" type="GtkAdjustment*"/>
			<field name="hadj" type="GtkAdjustment*"/>
		</object>
		<object name="GnomeIconSelection" parent="GtkVBox" type-name="GnomeIconSelection" get-type="gnome_icon_selection_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="add_defaults" symbol="gnome_icon_selection_add_defaults">
				<return-type type="void"/>
				<parameters>
					<parameter name="gis" type="GnomeIconSelection*"/>
				</parameters>
			</method>
			<method name="add_directory" symbol="gnome_icon_selection_add_directory">
				<return-type type="void"/>
				<parameters>
					<parameter name="gis" type="GnomeIconSelection*"/>
					<parameter name="dir" type="gchar*"/>
				</parameters>
			</method>
			<method name="clear" symbol="gnome_icon_selection_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="gis" type="GnomeIconSelection*"/>
					<parameter name="not_shown" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_box" symbol="gnome_icon_selection_get_box">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="gis" type="GnomeIconSelection*"/>
				</parameters>
			</method>
			<method name="get_gil" symbol="gnome_icon_selection_get_gil">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="gis" type="GnomeIconSelection*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gnome_icon_selection_get_icon">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="gis" type="GnomeIconSelection*"/>
					<parameter name="full_path" type="gboolean"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_icon_selection_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="select_icon" symbol="gnome_icon_selection_select_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="gis" type="GnomeIconSelection*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="show_icons" symbol="gnome_icon_selection_show_icons">
				<return-type type="void"/>
				<parameters>
					<parameter name="gis" type="GnomeIconSelection*"/>
				</parameters>
			</method>
			<method name="stop_loading" symbol="gnome_icon_selection_stop_loading">
				<return-type type="void"/>
				<parameters>
					<parameter name="gis" type="GnomeIconSelection*"/>
				</parameters>
			</method>
		</object>
		<object name="GnomeIconTextItem" parent="GnomeCanvasItem" type-name="GnomeIconTextItem" get-type="gnome_icon_text_item_get_type">
			<method name="configure" symbol="gnome_icon_text_item_configure">
				<return-type type="void"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
					<parameter name="width" type="int"/>
					<parameter name="fontname" type="char*"/>
					<parameter name="text" type="char*"/>
					<parameter name="is_editable" type="gboolean"/>
					<parameter name="is_static" type="gboolean"/>
				</parameters>
			</method>
			<method name="focus" symbol="gnome_icon_text_item_focus">
				<return-type type="void"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
					<parameter name="focused" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_editable" symbol="gnome_icon_text_item_get_editable">
				<return-type type="GtkEditable*"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="gnome_icon_text_item_get_text">
				<return-type type="char*"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
				</parameters>
			</method>
			<method name="select" symbol="gnome_icon_text_item_select">
				<return-type type="void"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
					<parameter name="sel" type="gboolean"/>
				</parameters>
			</method>
			<method name="setxy" symbol="gnome_icon_text_item_setxy">
				<return-type type="void"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
					<parameter name="x" type="int"/>
					<parameter name="y" type="int"/>
				</parameters>
			</method>
			<method name="start_editing" symbol="gnome_icon_text_item_start_editing">
				<return-type type="void"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
				</parameters>
			</method>
			<method name="stop_editing" symbol="gnome_icon_text_item_stop_editing">
				<return-type type="void"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
					<parameter name="accept" type="gboolean"/>
				</parameters>
			</method>
			<signal name="editing-started" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
				</parameters>
			</signal>
			<signal name="editing-stopped" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
				</parameters>
			</signal>
			<signal name="height-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
				</parameters>
			</signal>
			<signal name="selection-started" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
				</parameters>
			</signal>
			<signal name="selection-stopped" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
				</parameters>
			</signal>
			<signal name="text-changed" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
				</parameters>
			</signal>
			<signal name="width-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
				</parameters>
			</signal>
			<vfunc name="create_entry">
				<return-type type="GtkEntry*"/>
				<parameters>
					<parameter name="iti" type="GnomeIconTextItem*"/>
				</parameters>
			</vfunc>
			<field name="x" type="int"/>
			<field name="y" type="int"/>
			<field name="width" type="int"/>
			<field name="fontname" type="char*"/>
			<field name="text" type="char*"/>
			<field name="editing" type="unsigned"/>
			<field name="selected" type="unsigned"/>
			<field name="focused" type="unsigned"/>
			<field name="is_editable" type="unsigned"/>
			<field name="is_text_allocated" type="unsigned"/>
		</object>
		<object name="GnomeIconTheme" parent="GObject" type-name="GnomeIconTheme" get-type="gnome_icon_theme_get_type">
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon_theme" type="GnomeIconTheme*"/>
				</parameters>
			</signal>
		</object>
		<object name="GnomeMDI" parent="GtkObject" type-name="GnomeMDI" get-type="gnome_mdi_get_type">
			<method name="add_child" symbol="gnome_mdi_add_child">
				<return-type type="gint"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="child" type="GnomeMDIChild*"/>
				</parameters>
			</method>
			<method name="add_toplevel_view" symbol="gnome_mdi_add_toplevel_view">
				<return-type type="gint"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="child" type="GnomeMDIChild*"/>
				</parameters>
			</method>
			<method name="add_view" symbol="gnome_mdi_add_view">
				<return-type type="gint"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="child" type="GnomeMDIChild*"/>
				</parameters>
			</method>
			<method name="find_child" symbol="gnome_mdi_find_child">
				<return-type type="GnomeMDIChild*"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_active_child" symbol="gnome_mdi_get_active_child">
				<return-type type="GnomeMDIChild*"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
				</parameters>
			</method>
			<method name="get_active_view" symbol="gnome_mdi_get_active_view">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
				</parameters>
			</method>
			<method name="get_active_window" symbol="gnome_mdi_get_active_window">
				<return-type type="GnomeApp*"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
				</parameters>
			</method>
			<method name="get_app_from_view" symbol="gnome_mdi_get_app_from_view">
				<return-type type="GnomeApp*"/>
				<parameters>
					<parameter name="view" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="get_child_from_view" symbol="gnome_mdi_get_child_from_view">
				<return-type type="GnomeMDIChild*"/>
				<parameters>
					<parameter name="view" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="get_child_menu_info" symbol="gnome_mdi_get_child_menu_info">
				<return-type type="GnomeUIInfo*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
				</parameters>
			</method>
			<method name="get_menubar_info" symbol="gnome_mdi_get_menubar_info">
				<return-type type="GnomeUIInfo*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
				</parameters>
			</method>
			<method name="get_toolbar_info" symbol="gnome_mdi_get_toolbar_info">
				<return-type type="GnomeUIInfo*"/>
				<parameters>
					<parameter name="app" type="GnomeApp*"/>
				</parameters>
			</method>
			<method name="get_view_from_window" symbol="gnome_mdi_get_view_from_window">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="app" type="GnomeApp*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_mdi_new">
				<return-type type="GtkObject*"/>
				<parameters>
					<parameter name="appname" type="gchar*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="open_toplevel" symbol="gnome_mdi_open_toplevel">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
				</parameters>
			</method>
			<method name="register" symbol="gnome_mdi_register">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="object" type="GtkObject*"/>
				</parameters>
			</method>
			<method name="remove_all" symbol="gnome_mdi_remove_all">
				<return-type type="gint"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="force" type="gint"/>
				</parameters>
			</method>
			<method name="remove_child" symbol="gnome_mdi_remove_child">
				<return-type type="gint"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="child" type="GnomeMDIChild*"/>
					<parameter name="force" type="gint"/>
				</parameters>
			</method>
			<method name="remove_view" symbol="gnome_mdi_remove_view">
				<return-type type="gint"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="view" type="GtkWidget*"/>
					<parameter name="force" type="gint"/>
				</parameters>
			</method>
			<method name="restore_state" symbol="gnome_mdi_restore_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="section" type="gchar*"/>
					<parameter name="create_child_func" type="GnomeMDIChildCreator"/>
				</parameters>
			</method>
			<method name="save_state" symbol="gnome_mdi_save_state">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="section" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_active_view" symbol="gnome_mdi_set_active_view">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="view" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="set_child_list_path" symbol="gnome_mdi_set_child_list_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_child_menu_path" symbol="gnome_mdi_set_child_menu_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_menubar_template" symbol="gnome_mdi_set_menubar_template">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="menu_tmpl" type="GnomeUIInfo*"/>
				</parameters>
			</method>
			<method name="set_mode" symbol="gnome_mdi_set_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="mode" type="GnomeMDIMode"/>
				</parameters>
			</method>
			<method name="set_toolbar_template" symbol="gnome_mdi_set_toolbar_template">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="tbar_tmpl" type="GnomeUIInfo*"/>
				</parameters>
			</method>
			<method name="unregister" symbol="gnome_mdi_unregister">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="object" type="GtkObject*"/>
				</parameters>
			</method>
			<method name="update_child" symbol="gnome_mdi_update_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi" type="GnomeMDI*"/>
					<parameter name="child" type="GnomeMDIChild*"/>
				</parameters>
			</method>
			<signal name="add-child" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GnomeMDI*"/>
					<parameter name="p0" type="GnomeMDIChild*"/>
				</parameters>
			</signal>
			<signal name="add-view" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GnomeMDI*"/>
					<parameter name="p0" type="GtkWidget*"/>
				</parameters>
			</signal>
			<signal name="app-created" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GnomeMDI*"/>
					<parameter name="p0" type="GnomeApp*"/>
				</parameters>
			</signal>
			<signal name="child-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GnomeMDI*"/>
					<parameter name="p0" type="GnomeMDIChild*"/>
				</parameters>
			</signal>
			<signal name="remove-child" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GnomeMDI*"/>
					<parameter name="p0" type="GnomeMDIChild*"/>
				</parameters>
			</signal>
			<signal name="remove-view" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="GnomeMDI*"/>
					<parameter name="p0" type="GtkWidget*"/>
				</parameters>
			</signal>
			<signal name="view-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GnomeMDI*"/>
					<parameter name="p0" type="GtkWidget*"/>
				</parameters>
			</signal>
			<field name="mode" type="GnomeMDIMode"/>
			<field name="tab_pos" type="GtkPositionType"/>
			<field name="signal_id" type="guint"/>
			<field name="in_drag" type="guint"/>
			<field name="appname" type="gchar*"/>
			<field name="title" type="gchar*"/>
			<field name="menu_template" type="GnomeUIInfo*"/>
			<field name="toolbar_template" type="GnomeUIInfo*"/>
			<field name="active_child" type="GnomeMDIChild*"/>
			<field name="active_view" type="GtkWidget*"/>
			<field name="active_window" type="GnomeApp*"/>
			<field name="windows" type="GList*"/>
			<field name="children" type="GList*"/>
			<field name="registered" type="GSList*"/>
			<field name="child_menu_path" type="gchar*"/>
			<field name="child_list_path" type="gchar*"/>
			<field name="reserved" type="gpointer"/>
		</object>
		<object name="GnomeMDIChild" parent="GtkObject" type-name="GnomeMDIChild" get-type="gnome_mdi_child_get_type">
			<method name="add_view" symbol="gnome_mdi_child_add_view">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="mdi_child" type="GnomeMDIChild*"/>
				</parameters>
			</method>
			<method name="remove_view" symbol="gnome_mdi_child_remove_view">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi_child" type="GnomeMDIChild*"/>
					<parameter name="view" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="set_menu_template" symbol="gnome_mdi_child_set_menu_template">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi_child" type="GnomeMDIChild*"/>
					<parameter name="menu_tmpl" type="GnomeUIInfo*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="gnome_mdi_child_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="mdi_child" type="GnomeMDIChild*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<field name="parent" type="GtkObject*"/>
			<field name="name" type="gchar*"/>
			<field name="views" type="GList*"/>
			<field name="menu_template" type="GnomeUIInfo*"/>
			<field name="reserved" type="gpointer"/>
		</object>
		<object name="GnomeMDIGenericChild" parent="GnomeMDIChild" type-name="GnomeMDIGenericChild" get-type="gnome_mdi_generic_child_get_type">
			<constructor name="new" symbol="gnome_mdi_generic_child_new">
				<return-type type="GnomeMDIGenericChild*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_config_func" symbol="gnome_mdi_generic_child_set_config_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="child" type="GnomeMDIGenericChild*"/>
					<parameter name="func" type="GnomeMDIChildConfigFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_config_func_full" symbol="gnome_mdi_generic_child_set_config_func_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="child" type="GnomeMDIGenericChild*"/>
					<parameter name="func" type="GnomeMDIChildConfigFunc"/>
					<parameter name="marshal" type="GtkCallbackMarshal"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="notify" type="GtkDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_label_func" symbol="gnome_mdi_generic_child_set_label_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="child" type="GnomeMDIGenericChild*"/>
					<parameter name="func" type="GnomeMDIChildLabelFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_label_func_full" symbol="gnome_mdi_generic_child_set_label_func_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="child" type="GnomeMDIGenericChild*"/>
					<parameter name="func" type="GnomeMDIChildLabelFunc"/>
					<parameter name="marshal" type="GtkCallbackMarshal"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="notify" type="GtkDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_menu_creator" symbol="gnome_mdi_generic_child_set_menu_creator">
				<return-type type="void"/>
				<parameters>
					<parameter name="child" type="GnomeMDIGenericChild*"/>
					<parameter name="func" type="GnomeMDIChildMenuCreator"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_menu_creator_full" symbol="gnome_mdi_generic_child_set_menu_creator_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="child" type="GnomeMDIGenericChild*"/>
					<parameter name="func" type="GnomeMDIChildMenuCreator"/>
					<parameter name="marshal" type="GtkCallbackMarshal"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="notify" type="GtkDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_view_creator" symbol="gnome_mdi_generic_child_set_view_creator">
				<return-type type="void"/>
				<parameters>
					<parameter name="child" type="GnomeMDIGenericChild*"/>
					<parameter name="func" type="GnomeMDIChildViewCreator"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_view_creator_full" symbol="gnome_mdi_generic_child_set_view_creator_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="child" type="GnomeMDIGenericChild*"/>
					<parameter name="func" type="GnomeMDIChildViewCreator"/>
					<parameter name="marshal" type="GtkCallbackMarshal"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="notify" type="GtkDestroyNotify"/>
				</parameters>
			</method>
			<field name="create_view" type="GnomeMDIChildViewCreator"/>
			<field name="create_menus" type="GnomeMDIChildMenuCreator"/>
			<field name="get_config_string" type="GnomeMDIChildConfigFunc"/>
			<field name="set_label" type="GnomeMDIChildLabelFunc"/>
			<field name="create_view_cbm" type="GtkCallbackMarshal"/>
			<field name="create_menus_cbm" type="GtkCallbackMarshal"/>
			<field name="get_config_string_cbm" type="GtkCallbackMarshal"/>
			<field name="set_label_cbm" type="GtkCallbackMarshal"/>
			<field name="create_view_dn" type="GtkDestroyNotify"/>
			<field name="create_menus_dn" type="GtkDestroyNotify"/>
			<field name="get_config_string_dn" type="GtkDestroyNotify"/>
			<field name="set_label_dn" type="GtkDestroyNotify"/>
			<field name="create_view_data" type="gpointer"/>
			<field name="create_menus_data" type="gpointer"/>
			<field name="get_config_string_data" type="gpointer"/>
			<field name="set_label_data" type="gpointer"/>
			<field name="reserved" type="gpointer"/>
		</object>
		<object name="GnomeMessageBox" parent="GnomeDialog" type-name="GnomeMessageBox" get-type="gnome_message_box_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="construct" symbol="gnome_message_box_construct">
				<return-type type="void"/>
				<parameters>
					<parameter name="messagebox" type="GnomeMessageBox*"/>
					<parameter name="message" type="gchar*"/>
					<parameter name="message_box_type" type="gchar*"/>
					<parameter name="buttons" type="gchar**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_message_box_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="message" type="gchar*"/>
					<parameter name="message_box_type" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="newv" symbol="gnome_message_box_newv">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="message" type="gchar*"/>
					<parameter name="message_box_type" type="gchar*"/>
					<parameter name="buttons" type="gchar**"/>
				</parameters>
			</constructor>
		</object>
		<object name="GnomePasswordDialog" parent="GtkDialog" type-name="GnomePasswordDialog" get-type="gnome_password_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="anon_selected" symbol="gnome_password_dialog_anon_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
				</parameters>
			</method>
			<method name="get_domain" symbol="gnome_password_dialog_get_domain">
				<return-type type="char*"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
				</parameters>
			</method>
			<method name="get_new_password" symbol="gnome_password_dialog_get_new_password">
				<return-type type="char*"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
				</parameters>
			</method>
			<method name="get_password" symbol="gnome_password_dialog_get_password">
				<return-type type="char*"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
				</parameters>
			</method>
			<method name="get_remember" symbol="gnome_password_dialog_get_remember">
				<return-type type="GnomePasswordDialogRemember"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
				</parameters>
			</method>
			<method name="get_username" symbol="gnome_password_dialog_get_username">
				<return-type type="char*"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_password_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="dialog_title" type="char*"/>
					<parameter name="message" type="char*"/>
					<parameter name="username" type="char*"/>
					<parameter name="password" type="char*"/>
					<parameter name="readonly_username" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="run_and_block" symbol="gnome_password_dialog_run_and_block">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
				</parameters>
			</method>
			<method name="set_domain" symbol="gnome_password_dialog_set_domain">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="domain" type="char*"/>
				</parameters>
			</method>
			<method name="set_new_password" symbol="gnome_password_dialog_set_new_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</method>
			<method name="set_password" symbol="gnome_password_dialog_set_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</method>
			<method name="set_password_quality_func" symbol="gnome_password_dialog_set_password_quality_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="func" type="GnomePasswordDialogQualityFunc"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="dnotify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_readonly_domain" symbol="gnome_password_dialog_set_readonly_domain">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="readonly" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_readonly_username" symbol="gnome_password_dialog_set_readonly_username">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="readonly" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_remember" symbol="gnome_password_dialog_set_remember">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="remember" type="GnomePasswordDialogRemember"/>
				</parameters>
			</method>
			<method name="set_show_domain" symbol="gnome_password_dialog_set_show_domain">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="show" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_show_new_password" symbol="gnome_password_dialog_set_show_new_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="show" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_show_new_password_quality" symbol="gnome_password_dialog_set_show_new_password_quality">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="show" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_show_password" symbol="gnome_password_dialog_set_show_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="show" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_show_remember" symbol="gnome_password_dialog_set_show_remember">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="show_remember" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_show_username" symbol="gnome_password_dialog_set_show_username">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="show" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_show_userpass_buttons" symbol="gnome_password_dialog_set_show_userpass_buttons">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="show_userpass_buttons" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_username" symbol="gnome_password_dialog_set_username">
				<return-type type="void"/>
				<parameters>
					<parameter name="password_dialog" type="GnomePasswordDialog*"/>
					<parameter name="username" type="char*"/>
				</parameters>
			</method>
			<property name="anonymous" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="domain" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="message" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="message-markup" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="new-password" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="password" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="readonly-domain" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="readonly-username" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="remember-mode" type="GnomePasswordDialogRemember" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-domain" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-new-password" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-new-password-quality" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-password" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-remember" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-username" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-userpass-buttons" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="username" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<field name="details" type="GnomePasswordDialogDetails*"/>
		</object>
		<object name="GnomePixmap" parent="GtkImage" type-name="GnomePixmap" get-type="gnome_pixmap_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="load_file" symbol="gnome_pixmap_load_file">
				<return-type type="void"/>
				<parameters>
					<parameter name="gpixmap" type="GnomePixmap*"/>
					<parameter name="filename" type="char*"/>
				</parameters>
			</method>
			<method name="load_file_at_size" symbol="gnome_pixmap_load_file_at_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="gpixmap" type="GnomePixmap*"/>
					<parameter name="filename" type="char*"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</method>
			<method name="load_xpm_d" symbol="gnome_pixmap_load_xpm_d">
				<return-type type="void"/>
				<parameters>
					<parameter name="gpixmap" type="GnomePixmap*"/>
					<parameter name="xpm_data" type="char**"/>
				</parameters>
			</method>
			<method name="load_xpm_d_at_size" symbol="gnome_pixmap_load_xpm_d_at_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="gpixmap" type="GnomePixmap*"/>
					<parameter name="xpm_data" type="char**"/>
					<parameter name="width" type="int"/>
					<parameter name="height" type="int"/>
				</parameters>
			</method>
			<constructor name="new_from_file" symbol="gnome_pixmap_new_from_file">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_file_at_size" symbol="gnome_pixmap_new_from_file_at_size">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="filename" type="gchar*"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</constructor>
			<constructor name="new_from_gnome_pixmap" symbol="gnome_pixmap_new_from_gnome_pixmap">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="gpixmap" type="GnomePixmap*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_xpm_d" symbol="gnome_pixmap_new_from_xpm_d">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="xpm_data" type="gchar**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_xpm_d_at_size" symbol="gnome_pixmap_new_from_xpm_d_at_size">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="xpm_data" type="gchar**"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</constructor>
		</object>
		<object name="GnomePixmapEntry" parent="GnomeFileEntry" type-name="GnomePixmapEntry" get-type="gnome_pixmap_entry_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkEditable"/>
			</implements>
			<method name="construct" symbol="gnome_pixmap_entry_construct">
				<return-type type="void"/>
				<parameters>
					<parameter name="pentry" type="GnomePixmapEntry*"/>
					<parameter name="history_id" type="gchar*"/>
					<parameter name="browse_dialog_title" type="gchar*"/>
					<parameter name="do_preview" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_filename" symbol="gnome_pixmap_entry_get_filename">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="pentry" type="GnomePixmapEntry*"/>
				</parameters>
			</method>
			<method name="gnome_entry" symbol="gnome_pixmap_entry_gnome_entry">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="pentry" type="GnomePixmapEntry*"/>
				</parameters>
			</method>
			<method name="gnome_file_entry" symbol="gnome_pixmap_entry_gnome_file_entry">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="pentry" type="GnomePixmapEntry*"/>
				</parameters>
			</method>
			<method name="gtk_entry" symbol="gnome_pixmap_entry_gtk_entry">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="pentry" type="GnomePixmapEntry*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_pixmap_entry_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="history_id" type="gchar*"/>
					<parameter name="browse_dialog_title" type="gchar*"/>
					<parameter name="do_preview" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="preview_widget" symbol="gnome_pixmap_entry_preview_widget">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="pentry" type="GnomePixmapEntry*"/>
				</parameters>
			</method>
			<method name="scrolled_window" symbol="gnome_pixmap_entry_scrolled_window">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="pentry" type="GnomePixmapEntry*"/>
				</parameters>
			</method>
			<method name="set_pixmap_subdir" symbol="gnome_pixmap_entry_set_pixmap_subdir">
				<return-type type="void"/>
				<parameters>
					<parameter name="pentry" type="GnomePixmapEntry*"/>
					<parameter name="subdir" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_preview" symbol="gnome_pixmap_entry_set_preview">
				<return-type type="void"/>
				<parameters>
					<parameter name="pentry" type="GnomePixmapEntry*"/>
					<parameter name="do_preview" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_preview_size" symbol="gnome_pixmap_entry_set_preview_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="pentry" type="GnomePixmapEntry*"/>
					<parameter name="preview_w" type="gint"/>
					<parameter name="preview_h" type="gint"/>
				</parameters>
			</method>
			<property name="do-preview" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GnomePropertyBox" parent="GnomeDialog" type-name="GnomePropertyBox" get-type="gnome_property_box_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="append_page" symbol="gnome_property_box_append_page">
				<return-type type="gint"/>
				<parameters>
					<parameter name="property_box" type="GnomePropertyBox*"/>
					<parameter name="child" type="GtkWidget*"/>
					<parameter name="tab_label" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="changed" symbol="gnome_property_box_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="property_box" type="GnomePropertyBox*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_property_box_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_modified" symbol="gnome_property_box_set_modified">
				<return-type type="void"/>
				<parameters>
					<parameter name="property_box" type="GnomePropertyBox*"/>
					<parameter name="state" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_state" symbol="gnome_property_box_set_state">
				<return-type type="void"/>
				<parameters>
					<parameter name="property_box" type="GnomePropertyBox*"/>
					<parameter name="state" type="gboolean"/>
				</parameters>
			</method>
			<signal name="apply" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="propertybox" type="GnomePropertyBox*"/>
					<parameter name="page_num" type="gint"/>
				</parameters>
			</signal>
			<signal name="help" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="propertybox" type="GnomePropertyBox*"/>
					<parameter name="page_num" type="gint"/>
				</parameters>
			</signal>
			<field name="notebook" type="GtkWidget*"/>
			<field name="ok_button" type="GtkWidget*"/>
			<field name="apply_button" type="GtkWidget*"/>
			<field name="cancel_button" type="GtkWidget*"/>
			<field name="help_button" type="GtkWidget*"/>
			<field name="reserved" type="gpointer"/>
		</object>
		<object name="GnomeScores" parent="GtkDialog" type-name="GnomeScores" get-type="gnome_scores_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="construct" symbol="gnome_scores_construct">
				<return-type type="void"/>
				<parameters>
					<parameter name="gs" type="GnomeScores*"/>
					<parameter name="n_scores" type="guint"/>
					<parameter name="names" type="gchar**"/>
					<parameter name="scores" type="gfloat*"/>
					<parameter name="times" type="time_t*"/>
					<parameter name="clear" type="gboolean"/>
				</parameters>
			</method>
			<method name="display" symbol="gnome_scores_display">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="title" type="gchar*"/>
					<parameter name="app_name" type="gchar*"/>
					<parameter name="level" type="gchar*"/>
					<parameter name="pos" type="int"/>
				</parameters>
			</method>
			<method name="display_with_pixmap" symbol="gnome_scores_display_with_pixmap">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="pixmap_logo" type="gchar*"/>
					<parameter name="app_name" type="gchar*"/>
					<parameter name="level" type="gchar*"/>
					<parameter name="pos" type="int"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_scores_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="n_scores" type="guint"/>
					<parameter name="names" type="gchar**"/>
					<parameter name="scores" type="gfloat*"/>
					<parameter name="times" type="time_t*"/>
					<parameter name="clear" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_color" symbol="gnome_scores_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="gs" type="GnomeScores*"/>
					<parameter name="n" type="guint"/>
					<parameter name="col" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_colors" symbol="gnome_scores_set_colors">
				<return-type type="void"/>
				<parameters>
					<parameter name="gs" type="GnomeScores*"/>
					<parameter name="col" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_current_player" symbol="gnome_scores_set_current_player">
				<return-type type="void"/>
				<parameters>
					<parameter name="gs" type="GnomeScores*"/>
					<parameter name="i" type="gint"/>
				</parameters>
			</method>
			<method name="set_def_color" symbol="gnome_scores_set_def_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="gs" type="GnomeScores*"/>
					<parameter name="col" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_logo_label" symbol="gnome_scores_set_logo_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="gs" type="GnomeScores*"/>
					<parameter name="txt" type="gchar*"/>
					<parameter name="font" type="gchar*"/>
					<parameter name="col" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_logo_label_title" symbol="gnome_scores_set_logo_label_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="gs" type="GnomeScores*"/>
					<parameter name="txt" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_logo_pixmap" symbol="gnome_scores_set_logo_pixmap">
				<return-type type="void"/>
				<parameters>
					<parameter name="gs" type="GnomeScores*"/>
					<parameter name="pix_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_logo_widget" symbol="gnome_scores_set_logo_widget">
				<return-type type="void"/>
				<parameters>
					<parameter name="gs" type="GnomeScores*"/>
					<parameter name="w" type="GtkWidget*"/>
				</parameters>
			</method>
		</object>
		<object name="GnomeThumbnailFactory" parent="GObject" type-name="GnomeThumbnailFactory" get-type="gnome_thumbnail_factory_get_type">
			<method name="can_thumbnail" symbol="gnome_thumbnail_factory_can_thumbnail">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="factory" type="GnomeThumbnailFactory*"/>
					<parameter name="uri" type="char*"/>
					<parameter name="mime_type" type="char*"/>
					<parameter name="mtime" type="time_t"/>
				</parameters>
			</method>
			<method name="create_failed_thumbnail" symbol="gnome_thumbnail_factory_create_failed_thumbnail">
				<return-type type="void"/>
				<parameters>
					<parameter name="factory" type="GnomeThumbnailFactory*"/>
					<parameter name="uri" type="char*"/>
					<parameter name="mtime" type="time_t"/>
				</parameters>
			</method>
			<method name="generate_thumbnail" symbol="gnome_thumbnail_factory_generate_thumbnail">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="factory" type="GnomeThumbnailFactory*"/>
					<parameter name="uri" type="char*"/>
					<parameter name="mime_type" type="char*"/>
				</parameters>
			</method>
			<method name="has_valid_failed_thumbnail" symbol="gnome_thumbnail_factory_has_valid_failed_thumbnail">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="factory" type="GnomeThumbnailFactory*"/>
					<parameter name="uri" type="char*"/>
					<parameter name="mtime" type="time_t"/>
				</parameters>
			</method>
			<method name="lookup" symbol="gnome_thumbnail_factory_lookup">
				<return-type type="char*"/>
				<parameters>
					<parameter name="factory" type="GnomeThumbnailFactory*"/>
					<parameter name="uri" type="char*"/>
					<parameter name="mtime" type="time_t"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_thumbnail_factory_new">
				<return-type type="GnomeThumbnailFactory*"/>
				<parameters>
					<parameter name="size" type="GnomeThumbnailSize"/>
				</parameters>
			</constructor>
			<method name="save_thumbnail" symbol="gnome_thumbnail_factory_save_thumbnail">
				<return-type type="void"/>
				<parameters>
					<parameter name="factory" type="GnomeThumbnailFactory*"/>
					<parameter name="thumbnail" type="GdkPixbuf*"/>
					<parameter name="uri" type="char*"/>
					<parameter name="original_mtime" type="time_t"/>
				</parameters>
			</method>
		</object>
		<constant name="GNOMEUIINFO_KEY_UIBDATA" type="char*" value="uibdata"/>
		<constant name="GNOMEUIINFO_KEY_UIDATA" type="char*" value="uidata"/>
		<constant name="GNOME_APP_MENUBAR_NAME" type="char*" value="Menubar"/>
		<constant name="GNOME_APP_TOOLBAR_NAME" type="char*" value="Toolbar"/>
		<constant name="GNOME_CANCEL" type="int" value="1"/>
		<constant name="GNOME_CLIENT_PARAM_SM_CONNECT" type="char*" value="sm-connect"/>
		<constant name="GNOME_KEY_MOD_CLEAR" type="int" value="0"/>
		<constant name="GNOME_KEY_MOD_CLOSE_WINDOW" type="int" value="0"/>
		<constant name="GNOME_KEY_MOD_NEW_WINDOW" type="int" value="0"/>
		<constant name="GNOME_KEY_MOD_PAUSE_GAME" type="int" value="0"/>
		<constant name="GNOME_KEY_MOD_PRINT_SETUP" type="int" value="0"/>
		<constant name="GNOME_KEY_MOD_REDO" type="int" value="0"/>
		<constant name="GNOME_KEY_MOD_REDO_MOVE" type="int" value="0"/>
		<constant name="GNOME_KEY_MOD_SAVE_AS" type="int" value="0"/>
		<constant name="GNOME_KEY_NAME_CLEAR" type="int" value="0"/>
		<constant name="GNOME_KEY_NAME_CLOSE_WINDOW" type="int" value="0"/>
		<constant name="GNOME_KEY_NAME_NEW_WINDOW" type="int" value="0"/>
		<constant name="GNOME_KEY_NAME_PRINT_SETUP" type="int" value="0"/>
		<constant name="GNOME_MESSAGE_BOX_ERROR" type="char*" value="error"/>
		<constant name="GNOME_MESSAGE_BOX_GENERIC" type="char*" value="generic"/>
		<constant name="GNOME_MESSAGE_BOX_INFO" type="char*" value="info"/>
		<constant name="GNOME_MESSAGE_BOX_QUESTION" type="char*" value="question"/>
		<constant name="GNOME_MESSAGE_BOX_WARNING" type="char*" value="warning"/>
		<constant name="GNOME_NO" type="int" value="1"/>
		<constant name="GNOME_OK" type="int" value="0"/>
		<constant name="GNOME_PAD" type="int" value="8"/>
		<constant name="GNOME_PAD_BIG" type="int" value="12"/>
		<constant name="GNOME_PAD_SMALL" type="int" value="4"/>
		<constant name="GNOME_PROPERTY_BOX_DIRTY" type="char*" value="gnome_property_box_dirty"/>
		<constant name="GNOME_STOCK_ABOUT" type="char*" value="gnome-stock-about"/>
		<constant name="GNOME_STOCK_ATTACH" type="char*" value="gnome-stock-attach"/>
		<constant name="GNOME_STOCK_AUTHENTICATION" type="char*" value="gnome-stock-authentication"/>
		<constant name="GNOME_STOCK_BLANK" type="char*" value="gnome-stock-blank"/>
		<constant name="GNOME_STOCK_BOOK_BLUE" type="char*" value="gnome-stock-book-blue"/>
		<constant name="GNOME_STOCK_BOOK_GREEN" type="char*" value="gnome-stock-book-green"/>
		<constant name="GNOME_STOCK_BOOK_OPEN" type="char*" value="gnome-stock-book-open"/>
		<constant name="GNOME_STOCK_BOOK_RED" type="char*" value="gnome-stock-book-red"/>
		<constant name="GNOME_STOCK_BOOK_YELLOW" type="char*" value="gnome-stock-book-yellow"/>
		<constant name="GNOME_STOCK_LINE_IN" type="char*" value="gnome-stock-line-in"/>
		<constant name="GNOME_STOCK_MAIL" type="char*" value="gnome-stock-mail"/>
		<constant name="GNOME_STOCK_MAIL_FWD" type="char*" value="gnome-stock-mail-fwd"/>
		<constant name="GNOME_STOCK_MAIL_NEW" type="char*" value="gnome-stock-mail-new"/>
		<constant name="GNOME_STOCK_MAIL_RCV" type="char*" value="gnome-stock-mail-rcv"/>
		<constant name="GNOME_STOCK_MAIL_RPL" type="char*" value="gnome-stock-mail-rpl"/>
		<constant name="GNOME_STOCK_MAIL_SND" type="char*" value="gnome-stock-mail-snd"/>
		<constant name="GNOME_STOCK_MIC" type="char*" value="gnome-stock-mic"/>
		<constant name="GNOME_STOCK_MIDI" type="char*" value="gnome-stock-midi"/>
		<constant name="GNOME_STOCK_MULTIPLE_FILE" type="char*" value="gnome-stock-multiple-file"/>
		<constant name="GNOME_STOCK_NOT" type="char*" value="gnome-stock-not"/>
		<constant name="GNOME_STOCK_SCORES" type="char*" value="gnome-stock-scores"/>
		<constant name="GNOME_STOCK_TABLE_BORDERS" type="char*" value="gnome-stock-table-borders"/>
		<constant name="GNOME_STOCK_TABLE_FILL" type="char*" value="gnome-stock-table-fill"/>
		<constant name="GNOME_STOCK_TEXT_BULLETED_LIST" type="char*" value="gnome-stock-text-bulleted-list"/>
		<constant name="GNOME_STOCK_TEXT_INDENT" type="char*" value="gnome-stock-text-indent"/>
		<constant name="GNOME_STOCK_TEXT_NUMBERED_LIST" type="char*" value="gnome-stock-text-numbered-list"/>
		<constant name="GNOME_STOCK_TEXT_UNINDENT" type="char*" value="gnome-stock-text-unindent"/>
		<constant name="GNOME_STOCK_TIMER" type="char*" value="gnome-stock-timer"/>
		<constant name="GNOME_STOCK_TIMER_STOP" type="char*" value="gnome-stock-timer-stop"/>
		<constant name="GNOME_STOCK_TRASH" type="char*" value="gnome-stock-trash"/>
		<constant name="GNOME_STOCK_TRASH_FULL" type="char*" value="gnome-stock-trash-full"/>
		<constant name="GNOME_STOCK_VOLUME" type="char*" value="gnome-stock-volume"/>
		<constant name="GNOME_YES" type="int" value="0"/>
		<constant name="LIBGNOMEUI_PARAM_CRASH_DIALOG" type="char*" value="show-crash-dialog"/>
		<constant name="LIBGNOMEUI_PARAM_DEFAULT_ICON" type="char*" value="default-icon"/>
		<constant name="LIBGNOMEUI_PARAM_DISPLAY" type="char*" value="display"/>
	</namespace>
</api>
