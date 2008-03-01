<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Hildon">
		<function name="file_system_create_backend" symbol="hildon_file_system_create_backend">
			<return-type type="GtkFileSystem*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
				<parameter name="use_fallback" type="gboolean"/>
			</parameters>
		</function>
		<callback name="HildonFileSystemInfoCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="HildonFileSystemInfoHandle*"/>
				<parameter name="info" type="HildonFileSystemInfo*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="HildonFileSystemModelThumbnailCallback">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="uri" type="gchar*"/>
				<parameter name="path" type="gchar*"/>
				<parameter name="thumbnail_file" type="gchar*"/>
			</parameters>
		</callback>
		<struct name="HildonFileSystemInfo">
			<method name="async_cancel" symbol="hildon_file_system_info_async_cancel">
				<return-type type="void"/>
				<parameters>
					<parameter name="handle" type="HildonFileSystemInfoHandle*"/>
				</parameters>
			</method>
			<method name="async_new" symbol="hildon_file_system_info_async_new">
				<return-type type="HildonFileSystemInfoHandle*"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
					<parameter name="callback" type="HildonFileSystemInfoCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="hildon_file_system_info_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="HildonFileSystemInfo*"/>
				</parameters>
			</method>
			<method name="get_display_name" symbol="hildon_file_system_info_get_display_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="info" type="HildonFileSystemInfo*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="hildon_file_system_info_get_icon">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="info" type="HildonFileSystemInfo*"/>
					<parameter name="ref_widget" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="get_icon_at_size" symbol="hildon_file_system_info_get_icon_at_size">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="info" type="HildonFileSystemInfo*"/>
					<parameter name="ref_widget" type="GtkWidget*"/>
					<parameter name="size" type="gint"/>
				</parameters>
			</method>
			<method name="new" symbol="hildon_file_system_info_new">
				<return-type type="HildonFileSystemInfo*"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</struct>
		<struct name="HildonFileSystemInfoHandle">
		</struct>
		<struct name="HildonFileSystemStorageDialogPriv">
		</struct>
		<enum name="HildonFileSelectionMode">
			<member name="HILDON_FILE_SELECTION_MODE_LIST" value="0"/>
			<member name="HILDON_FILE_SELECTION_MODE_THUMBNAILS" value="1"/>
		</enum>
		<enum name="HildonFileSelectionPane">
			<member name="HILDON_FILE_SELECTION_PANE_NAVIGATION" value="0"/>
			<member name="HILDON_FILE_SELECTION_PANE_CONTENT" value="1"/>
		</enum>
		<enum name="HildonFileSelectionSortKey">
			<member name="HILDON_FILE_SELECTION_SORT_NAME" value="0"/>
			<member name="HILDON_FILE_SELECTION_SORT_TYPE" value="1"/>
			<member name="HILDON_FILE_SELECTION_SORT_MODIFIED" value="2"/>
			<member name="HILDON_FILE_SELECTION_SORT_SIZE" value="3"/>
		</enum>
		<enum name="HildonFileSelectionVisibleColumns">
			<member name="HILDON_FILE_SELECTION_SHOW_NAME" value="1"/>
			<member name="HILDON_FILE_SELECTION_SHOW_MODIFIED" value="2"/>
			<member name="HILDON_FILE_SELECTION_SHOW_SIZE" value="4"/>
			<member name="HILDON_FILE_SELECTION_SHOW_ALL" value="7"/>
		</enum>
		<enum name="HildonFileSystemModelColumns">
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_GTK_PATH_INTERNAL" value="0"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_LOCAL_PATH" value="1"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_URI" value="2"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_FILE_NAME" value="3"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_DISPLAY_NAME" value="4"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_SORT_KEY" value="5"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_MIME_TYPE" value="6"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_FILE_SIZE" value="7"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_FILE_TIME" value="8"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_IS_FOLDER" value="9"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_IS_AVAILABLE" value="10"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_HAS_LOCAL_PATH" value="11"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_TYPE" value="12"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_ICON" value="13"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_ICON_EXPANDED" value="14"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_ICON_COLLAPSED" value="15"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_THUMBNAIL" value="16"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_LOAD_READY" value="17"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_FREE_SPACE" value="18"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_TITLE" value="19"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_AUTHOR" value="20"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_IS_HIDDEN" value="21"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_UNAVAILABLE_REASON" value="22"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_FAILED_ACCESS_MESSAGE" value="23"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_SORT_WEIGHT" value="24"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_EXTRA_INFO" value="25"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_COLUMN_IS_DRIVE" value="26"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_NUM_COLUMNS" value="27"/>
		</enum>
		<enum name="HildonFileSystemModelItemType">
			<member name="HILDON_FILE_SYSTEM_MODEL_UNKNOWN" value="0"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_FILE" value="1"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_FOLDER" value="2"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_SAFE_FOLDER_IMAGES" value="3"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_SAFE_FOLDER_VIDEOS" value="4"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_SAFE_FOLDER_SOUNDS" value="5"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_SAFE_FOLDER_DOCUMENTS" value="6"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_SAFE_FOLDER_GAMES" value="7"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_MMC" value="8"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_GATEWAY" value="9"/>
			<member name="HILDON_FILE_SYSTEM_MODEL_LOCAL_DEVICE" value="10"/>
		</enum>
		<object name="HildonFileChooserDialog" parent="GtkDialog" type-name="HildonFileChooserDialog" get-type="hildon_file_chooser_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkFileChooser"/>
			</implements>
			<method name="add_extensions_combo" symbol="hildon_file_chooser_dialog_add_extensions_combo">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="self" type="HildonFileChooserDialog*"/>
					<parameter name="extensions" type="char**"/>
					<parameter name="ext_names" type="char**"/>
				</parameters>
			</method>
			<method name="add_extra" symbol="hildon_file_chooser_dialog_add_extra">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileChooserDialog*"/>
					<parameter name="widget" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="focus_to_input" symbol="hildon_file_chooser_dialog_focus_to_input">
				<return-type type="void"/>
				<parameters>
					<parameter name="d" type="HildonFileChooserDialog*"/>
				</parameters>
			</method>
			<method name="get_extension" symbol="hildon_file_chooser_dialog_get_extension">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="HildonFileChooserDialog*"/>
				</parameters>
			</method>
			<method name="get_safe_folder" symbol="hildon_file_chooser_dialog_get_safe_folder">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="HildonFileChooserDialog*"/>
				</parameters>
			</method>
			<method name="get_safe_folder_uri" symbol="hildon_file_chooser_dialog_get_safe_folder_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="HildonFileChooserDialog*"/>
				</parameters>
			</method>
			<method name="get_show_upnp" symbol="hildon_file_chooser_dialog_get_show_upnp">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonFileChooserDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_file_chooser_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="action" type="GtkFileChooserAction"/>
				</parameters>
			</constructor>
			<constructor name="new_with_properties" symbol="hildon_file_chooser_dialog_new_with_properties">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="first_property" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_extension" symbol="hildon_file_chooser_dialog_set_extension">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileChooserDialog*"/>
					<parameter name="extension" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_safe_folder" symbol="hildon_file_chooser_dialog_set_safe_folder">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileChooserDialog*"/>
					<parameter name="local_path" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_safe_folder_uri" symbol="hildon_file_chooser_dialog_set_safe_folder_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileChooserDialog*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_show_upnp" symbol="hildon_file_chooser_dialog_set_show_upnp">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileChooserDialog*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="autonaming" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="empty-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="file-system-model" type="HildonFileSystemModel*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="max-full-path-length" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="max-name-length" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="open-button-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="save-multiple" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="selection-mode" type="HildonFileChooserDialogSelectionMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-folder-button" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-location" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="HildonFileDetailsDialog" parent="GtkDialog" type-name="HildonFileDetailsDialog" get-type="hildon_file_details_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_file_iter" symbol="hildon_file_details_dialog_get_file_iter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonFileDetailsDialog*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="hildon_file_details_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_model" symbol="hildon_file_details_dialog_new_with_model">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="model" type="HildonFileSystemModel*"/>
				</parameters>
			</constructor>
			<method name="set_file_iter" symbol="hildon_file_details_dialog_set_file_iter">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileDetailsDialog*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<property name="additional-tab" type="GtkWidget*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="additional-tab-label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="enable-read-only-checkbox" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="model" type="HildonFileSystemModel*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-tabs" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="show-type-icon" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="HildonFileSelection" parent="GtkContainer" type-name="HildonFileSelection" get-type="hildon_file_selection_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="clear_multi_selection" symbol="hildon_file_selection_clear_multi_selection">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="content_iter_is_selected" symbol="hildon_file_selection_content_iter_is_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<method name="dim_current_selection" symbol="hildon_file_selection_dim_current_selection">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="get_active_content_iter" symbol="hildon_file_selection_get_active_content_iter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<method name="get_active_pane" symbol="hildon_file_selection_get_active_pane">
				<return-type type="HildonFileSelectionPane"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="get_column_headers_visible" symbol="hildon_file_selection_get_column_headers_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="get_current_content_iter" symbol="hildon_file_selection_get_current_content_iter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<method name="get_current_folder" symbol="hildon_file_selection_get_current_folder">
				<return-type type="GtkFilePath*"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="get_current_folder_iter" symbol="hildon_file_selection_get_current_folder_iter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<method name="get_current_folder_uri" symbol="hildon_file_selection_get_current_folder_uri">
				<return-type type="char*"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="get_filter" symbol="hildon_file_selection_get_filter">
				<return-type type="GtkFileFilter*"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="get_mode" symbol="hildon_file_selection_get_mode">
				<return-type type="HildonFileSelectionMode"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="get_select_multiple" symbol="hildon_file_selection_get_select_multiple">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="get_selected_paths" symbol="hildon_file_selection_get_selected_paths">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="get_selected_uris" symbol="hildon_file_selection_get_selected_uris">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="get_sort_key" symbol="hildon_file_selection_get_sort_key">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="key" type="HildonFileSelectionSortKey*"/>
					<parameter name="order" type="GtkSortType*"/>
				</parameters>
			</method>
			<method name="hide_content_pane" symbol="hildon_file_selection_hide_content_pane">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="move_cursor_to_uri" symbol="hildon_file_selection_move_cursor_to_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new_with_model" symbol="hildon_file_selection_new_with_model">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
				</parameters>
			</constructor>
			<method name="select_all" symbol="hildon_file_selection_select_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="select_path" symbol="hildon_file_selection_select_path">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="path" type="GtkFilePath*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="select_uri" symbol="hildon_file_selection_select_uri">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="uri" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_column_headers_visible" symbol="hildon_file_selection_set_column_headers_visible">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="visible" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_current_folder" symbol="hildon_file_selection_set_current_folder">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="folder" type="GtkFilePath*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_current_folder_uri" symbol="hildon_file_selection_set_current_folder_uri">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="folder" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_filter" symbol="hildon_file_selection_set_filter">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="filter" type="GtkFileFilter*"/>
				</parameters>
			</method>
			<method name="set_mode" symbol="hildon_file_selection_set_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="mode" type="HildonFileSelectionMode"/>
				</parameters>
			</method>
			<method name="set_select_multiple" symbol="hildon_file_selection_set_select_multiple">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="select_multiple" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_sort_key" symbol="hildon_file_selection_set_sort_key">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="key" type="HildonFileSelectionSortKey"/>
					<parameter name="order" type="GtkSortType"/>
				</parameters>
			</method>
			<method name="show_content_pane" symbol="hildon_file_selection_show_content_pane">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="undim_all" symbol="hildon_file_selection_undim_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="unselect_all" symbol="hildon_file_selection_unselect_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</method>
			<method name="unselect_path" symbol="hildon_file_selection_unselect_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="path" type="GtkFilePath*"/>
				</parameters>
			</method>
			<method name="unselect_uri" symbol="hildon_file_selection_unselect_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="uri" type="char*"/>
				</parameters>
			</method>
			<property name="active-pane" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="drag-enabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="empty-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="local-only" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="model" type="HildonFileSystemModel*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="pane-position" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="safe-folder" type="GtkFilePath*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-hidden" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-upnp" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="visible-columns" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="content-pane-context-menu" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</signal>
			<signal name="current-folder-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</signal>
			<signal name="file-activated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</signal>
			<signal name="location-insensitive" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</signal>
			<signal name="navigation-pane-context-menu" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</signal>
			<signal name="selection-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
				</parameters>
			</signal>
			<signal name="uris-dropped" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="HildonFileSelection*"/>
					<parameter name="destination" type="char*"/>
					<parameter name="sources" type="gpointer"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonFileSystemModel" parent="GObject" type-name="HildonFileSystemModel" get-type="hildon_file_system_model_get_type">
			<implements>
				<interface name="GtkTreeModel"/>
				<interface name="GtkTreeDragSource"/>
			</implements>
			<method name="autoname_uri" symbol="hildon_file_system_model_autoname_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
					<parameter name="uri" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="finished_loading" symbol="hildon_file_system_model_finished_loading">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
				</parameters>
			</method>
			<method name="iter_available" symbol="hildon_file_system_model_iter_available">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
					<parameter name="available" type="gboolean"/>
				</parameters>
			</method>
			<method name="load_local_path" symbol="hildon_file_system_model_load_local_path">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
					<parameter name="path" type="gchar*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<method name="load_path" symbol="hildon_file_system_model_load_path">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
					<parameter name="path" type="GtkFilePath*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<method name="load_uri" symbol="hildon_file_system_model_load_uri">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
					<parameter name="uri" type="gchar*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</method>
			<constructor name="new_item" symbol="hildon_file_system_model_new_item">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
					<parameter name="parent" type="GtkTreeIter*"/>
					<parameter name="stub_name" type="gchar*"/>
					<parameter name="extension" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="reset_available" symbol="hildon_file_system_model_reset_available">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
				</parameters>
			</method>
			<method name="search_local_path" symbol="hildon_file_system_model_search_local_path">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
					<parameter name="path" type="gchar*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
					<parameter name="start_iter" type="GtkTreeIter*"/>
					<parameter name="recursive" type="gboolean"/>
				</parameters>
			</method>
			<method name="search_path" symbol="hildon_file_system_model_search_path">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
					<parameter name="path" type="GtkFilePath*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
					<parameter name="start_iter" type="GtkTreeIter*"/>
					<parameter name="recursive" type="gboolean"/>
				</parameters>
			</method>
			<method name="search_uri" symbol="hildon_file_system_model_search_uri">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
					<parameter name="uri" type="gchar*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
					<parameter name="start_iter" type="GtkTreeIter*"/>
					<parameter name="recursive" type="gboolean"/>
				</parameters>
			</method>
			<property name="backend" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="backend-object" type="GtkFileSystem*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="multi-root" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="ref-widget" type="GtkWidget*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="root-dir" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="thumbnail-callback" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="device-disconnected" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</signal>
			<signal name="finished-loading" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="HildonFileSystemModel*"/>
					<parameter name="iter" type="GtkTreeIter*"/>
				</parameters>
			</signal>
		</object>
		<object name="HildonFileSystemStorageDialog" parent="GtkDialog" type-name="HildonFileSystemStorageDialog" get-type="hildon_file_system_storage_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="hildon_file_system_storage_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="parent" type="GtkWindow*"/>
					<parameter name="uri_str" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_uri" symbol="hildon_file_system_storage_dialog_set_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="uri_str" type="gchar*"/>
				</parameters>
			</method>
		</object>
	</namespace>
</api>
