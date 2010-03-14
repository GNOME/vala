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
		<struct name="GnomeGdkPixbufAsyncHandle">
		</struct>
		<struct name="GnomePasswordDialogDetails">
		</struct>
		<struct name="GnomeUIBuilderData">
			<field name="connect_func" type="GnomeUISignalConnectFunc"/>
			<field name="data" type="gpointer"/>
			<field name="is_interp" type="gboolean"/>
			<field name="relay_func" type="GtkCallbackMarshal"/>
			<field name="destroy_func" type="GDestroyNotify"/>
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
		<enum name="GnomeClientState" type-name="GnomeClientState" get-type="gnome_client_state_get_type">
			<member name="GNOME_CLIENT_IDLE" value="0"/>
			<member name="GNOME_CLIENT_SAVING_PHASE_1" value="1"/>
			<member name="GNOME_CLIENT_WAITING_FOR_PHASE_2" value="2"/>
			<member name="GNOME_CLIENT_SAVING_PHASE_2" value="3"/>
			<member name="GNOME_CLIENT_FROZEN" value="4"/>
			<member name="GNOME_CLIENT_DISCONNECTED" value="5"/>
			<member name="GNOME_CLIENT_REGISTERING" value="6"/>
		</enum>
		<enum name="GnomeDialogType" type-name="GnomeDialogType" get-type="gnome_dialog_type_get_type">
			<member name="GNOME_DIALOG_ERROR" value="0"/>
			<member name="GNOME_DIALOG_NORMAL" value="1"/>
		</enum>
		<enum name="GnomeEdgePosition" type-name="GnomeEdgePosition" get-type="gnome_edge_position_get_type">
			<member name="GNOME_EDGE_START" value="0"/>
			<member name="GNOME_EDGE_FINISH" value="1"/>
			<member name="GNOME_EDGE_OTHER" value="2"/>
			<member name="GNOME_EDGE_LAST" value="3"/>
		</enum>
		<enum name="GnomeFontPickerMode" type-name="GnomeFontPickerMode" get-type="gnome_font_picker_mode_get_type">
			<member name="GNOME_FONT_PICKER_MODE_PIXMAP" value="0"/>
			<member name="GNOME_FONT_PICKER_MODE_FONT_INFO" value="1"/>
			<member name="GNOME_FONT_PICKER_MODE_USER_WIDGET" value="2"/>
			<member name="GNOME_FONT_PICKER_MODE_UNKNOWN" value="3"/>
		</enum>
		<enum name="GnomeIconListMode" type-name="GnomeIconListMode" get-type="gnome_icon_list_mode_get_type">
			<member name="GNOME_ICON_LIST_ICONS" value="0"/>
			<member name="GNOME_ICON_LIST_TEXT_BELOW" value="1"/>
			<member name="GNOME_ICON_LIST_TEXT_RIGHT" value="2"/>
		</enum>
		<enum name="GnomeInteractStyle" type-name="GnomeInteractStyle" get-type="gnome_interact_style_get_type">
			<member name="GNOME_INTERACT_NONE" value="0"/>
			<member name="GNOME_INTERACT_ERRORS" value="1"/>
			<member name="GNOME_INTERACT_ANY" value="2"/>
		</enum>
		<enum name="GnomeMDIMode" type-name="GnomeMDIMode" get-type="gnome_mdi_mode_get_type">
			<member name="GNOME_MDI_NOTEBOOK" value="0"/>
			<member name="GNOME_MDI_TOPLEVEL" value="1"/>
			<member name="GNOME_MDI_MODAL" value="2"/>
			<member name="GNOME_MDI_DEFAULT_MODE" value="42"/>
		</enum>
		<enum name="GnomePasswordDialogRemember" type-name="GnomePasswordDialogRemember" get-type="gnome_password_dialog_remember_get_type">
			<member name="GNOME_PASSWORD_DIALOG_REMEMBER_NOTHING" value="0"/>
			<member name="GNOME_PASSWORD_DIALOG_REMEMBER_SESSION" value="1"/>
			<member name="GNOME_PASSWORD_DIALOG_REMEMBER_FOREVER" value="2"/>
		</enum>
		<enum name="GnomePreferencesType" type-name="GnomePreferencesType" get-type="gnome_preferences_type_get_type">
			<member name="GNOME_PREFERENCES_NEVER" value="0"/>
			<member name="GNOME_PREFERENCES_USER" value="1"/>
			<member name="GNOME_PREFERENCES_ALWAYS" value="2"/>
		</enum>
		<enum name="GnomeRestartStyle" type-name="GnomeRestartStyle" get-type="gnome_restart_style_get_type">
			<member name="GNOME_RESTART_IF_RUNNING" value="0"/>
			<member name="GNOME_RESTART_ANYWAY" value="1"/>
			<member name="GNOME_RESTART_IMMEDIATELY" value="2"/>
			<member name="GNOME_RESTART_NEVER" value="3"/>
		</enum>
		<enum name="GnomeSaveStyle" type-name="GnomeSaveStyle" get-type="gnome_save_style_get_type">
			<member name="GNOME_SAVE_GLOBAL" value="0"/>
			<member name="GNOME_SAVE_LOCAL" value="1"/>
			<member name="GNOME_SAVE_BOTH" value="2"/>
		</enum>
		<enum name="GnomeThumbnailSize" type-name="GnomeThumbnailSize" get-type="gnome_thumbnail_size_get_type">
			<member name="GNOME_THUMBNAIL_SIZE_NORMAL" value="0"/>
			<member name="GNOME_THUMBNAIL_SIZE_LARGE" value="1"/>
		</enum>
		<enum name="GnomeUIInfoConfigurableTypes" type-name="GnomeUIInfoConfigurableTypes" get-type="gnome_ui_info_configurable_types_get_type">
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
		<enum name="GnomeUIInfoType" type-name="GnomeUIInfoType" get-type="gnome_ui_info_type_get_type">
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
		<enum name="GnomeUIPixmapType" type-name="GnomeUIPixmapType" get-type="gnome_ui_pixmap_type_get_type">
			<member name="GNOME_APP_PIXMAP_NONE" value="0"/>
			<member name="GNOME_APP_PIXMAP_STOCK" value="1"/>
			<member name="GNOME_APP_PIXMAP_DATA" value="2"/>
			<member name="GNOME_APP_PIXMAP_FILENAME" value="3"/>
		</enum>
		<flags name="GnomeClientFlags" type-name="GnomeClientFlags" get-type="gnome_client_flags_get_type">
			<member name="GNOME_CLIENT_IS_CONNECTED" value="1"/>
			<member name="GNOME_CLIENT_RESTARTED" value="2"/>
			<member name="GNOME_CLIENT_RESTORED" value="4"/>
		</flags>
		<flags name="GnomeDateEditFlags" type-name="GnomeDateEditFlags" get-type="gnome_date_edit_flags_get_type">
			<member name="GNOME_DATE_EDIT_SHOW_TIME" value="1"/>
			<member name="GNOME_DATE_EDIT_24_HR" value="2"/>
			<member name="GNOME_DATE_EDIT_WEEK_STARTS_ON_MONDAY" value="4"/>
			<member name="GNOME_DATE_EDIT_DISPLAY_SECONDS" value="8"/>
		</flags>
		<flags name="GnomeIconLookupFlags" type-name="GnomeIconLookupFlags" get-type="gnome_icon_lookup_flags_get_type">
			<member name="GNOME_ICON_LOOKUP_FLAGS_NONE" value="0"/>
			<member name="GNOME_ICON_LOOKUP_FLAGS_EMBEDDING_TEXT" value="1"/>
			<member name="GNOME_ICON_LOOKUP_FLAGS_SHOW_SMALL_IMAGES_AS_THEMSELVES" value="2"/>
			<member name="GNOME_ICON_LOOKUP_FLAGS_ALLOW_SVG_AS_THEMSELVES" value="4"/>
		</flags>
		<flags name="GnomeIconLookupResultFlags" type-name="GnomeIconLookupResultFlags" get-type="gnome_icon_lookup_result_flags_get_type">
			<member name="GNOME_ICON_LOOKUP_RESULT_FLAGS_NONE" value="0"/>
			<member name="GNOME_ICON_LOOKUP_RESULT_FLAGS_THUMBNAIL" value="1"/>
		</flags>
		<object name="GnomeApp" parent="GtkWindow" type-name="GnomeApp" get-type="gnome_app_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
					<parameter name="destroy_func" type="GDestroyNotify"/>
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
					<parameter name="destroy_func" type="GDestroyNotify"/>
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
					<parameter name="destroy_func" type="GDestroyNotify"/>
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
			<constructor name="new" symbol="gnome_app_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="appname" type="gchar*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</constructor>
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
				<interface name="GtkBuildable"/>
				<interface name="GtkOrientable"/>
				<interface name="AtkImplementor"/>
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
					<parameter name="destroy" type="GDestroyNotify"/>
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
		<object name="GnomeDateEdit" parent="GtkHBox" type-name="GnomeDateEdit" get-type="gnome_date_edit_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="GtkOrientable"/>
				<interface name="AtkImplementor"/>
			</implements>
			<method name="construct" symbol="gnome_date_edit_construct">
				<return-type type="void"/>
				<parameters>
					<parameter name="gde" type="GnomeDateEdit*"/>
					<parameter name="the_time" type="time_t"/>
					<parameter name="flags" type="GnomeDateEditFlags"/>
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
		<object name="GnomeIconEntry" parent="GtkVBox" type-name="GnomeIconEntry" get-type="gnome_icon_entry_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="GtkOrientable"/>
				<interface name="AtkImplementor"/>
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
		<object name="GnomeIconSelection" parent="GtkVBox" type-name="GnomeIconSelection" get-type="gnome_icon_selection_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="GtkOrientable"/>
				<interface name="AtkImplementor"/>
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
		<object name="GnomePasswordDialog" parent="GtkDialog" type-name="GnomePasswordDialog" get-type="gnome_password_dialog_get_type">
			<implements>
				<interface name="GtkBuildable"/>
				<interface name="AtkImplementor"/>
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
