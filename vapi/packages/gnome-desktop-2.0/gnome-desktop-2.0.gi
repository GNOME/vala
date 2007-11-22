<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gnome">
		<boxed name="GnomeDesktopItem" type-name="GnomeDesktopItem" get-type="gnome_desktop_item_get_type">
			<method name="attr_exists" symbol="gnome_desktop_item_attr_exists">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
				</parameters>
			</method>
			<method name="clear_localestring" symbol="gnome_desktop_item_clear_localestring">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
				</parameters>
			</method>
			<method name="clear_section" symbol="gnome_desktop_item_clear_section">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="section" type="char*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gnome_desktop_item_copy">
				<return-type type="GnomeDesktopItem*"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
				</parameters>
			</method>
			<method name="drop_uri_list" symbol="gnome_desktop_item_drop_uri_list">
				<return-type type="int"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="uri_list" type="char*"/>
					<parameter name="flags" type="GnomeDesktopItemLaunchFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="drop_uri_list_with_env" symbol="gnome_desktop_item_drop_uri_list_with_env">
				<return-type type="int"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="uri_list" type="char*"/>
					<parameter name="flags" type="GnomeDesktopItemLaunchFlags"/>
					<parameter name="envp" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gnome_desktop_item_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="exists" symbol="gnome_desktop_item_exists">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
				</parameters>
			</method>
			<method name="find_icon" symbol="gnome_desktop_item_find_icon">
				<return-type type="char*"/>
				<parameters>
					<parameter name="icon_theme" type="GtkIconTheme*"/>
					<parameter name="icon" type="char*"/>
					<parameter name="desired_size" type="int"/>
					<parameter name="flags" type="int"/>
				</parameters>
			</method>
			<method name="get_attr_locale" symbol="gnome_desktop_item_get_attr_locale">
				<return-type type="char*"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
				</parameters>
			</method>
			<method name="get_boolean" symbol="gnome_desktop_item_get_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
				</parameters>
			</method>
			<method name="get_entry_type" symbol="gnome_desktop_item_get_entry_type">
				<return-type type="GnomeDesktopItemType"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
				</parameters>
			</method>
			<method name="get_file_status" symbol="gnome_desktop_item_get_file_status">
				<return-type type="GnomeDesktopItemStatus"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gnome_desktop_item_get_icon">
				<return-type type="char*"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="icon_theme" type="GtkIconTheme*"/>
				</parameters>
			</method>
			<method name="get_languages" symbol="gnome_desktop_item_get_languages">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
				</parameters>
			</method>
			<method name="get_localestring" symbol="gnome_desktop_item_get_localestring">
				<return-type type="char*"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
				</parameters>
			</method>
			<method name="get_localestring_lang" symbol="gnome_desktop_item_get_localestring_lang">
				<return-type type="char*"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="language" type="char*"/>
				</parameters>
			</method>
			<method name="get_location" symbol="gnome_desktop_item_get_location">
				<return-type type="char*"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
				</parameters>
			</method>
			<method name="get_string" symbol="gnome_desktop_item_get_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
				</parameters>
			</method>
			<method name="get_strings" symbol="gnome_desktop_item_get_strings">
				<return-type type="char**"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
				</parameters>
			</method>
			<method name="launch" symbol="gnome_desktop_item_launch">
				<return-type type="int"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="file_list" type="GList*"/>
					<parameter name="flags" type="GnomeDesktopItemLaunchFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="launch_on_screen" symbol="gnome_desktop_item_launch_on_screen">
				<return-type type="int"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="file_list" type="GList*"/>
					<parameter name="flags" type="GnomeDesktopItemLaunchFlags"/>
					<parameter name="screen" type="GdkScreen*"/>
					<parameter name="workspace" type="int"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="launch_with_env" symbol="gnome_desktop_item_launch_with_env">
				<return-type type="int"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="file_list" type="GList*"/>
					<parameter name="flags" type="GnomeDesktopItemLaunchFlags"/>
					<parameter name="envp" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_desktop_item_new">
				<return-type type="GnomeDesktopItem*"/>
			</constructor>
			<constructor name="new_from_basename" symbol="gnome_desktop_item_new_from_basename">
				<return-type type="GnomeDesktopItem*"/>
				<parameters>
					<parameter name="basename" type="char*"/>
					<parameter name="flags" type="GnomeDesktopItemLoadFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_file" symbol="gnome_desktop_item_new_from_file">
				<return-type type="GnomeDesktopItem*"/>
				<parameters>
					<parameter name="file" type="char*"/>
					<parameter name="flags" type="GnomeDesktopItemLoadFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_string" symbol="gnome_desktop_item_new_from_string">
				<return-type type="GnomeDesktopItem*"/>
				<parameters>
					<parameter name="uri" type="char*"/>
					<parameter name="string" type="char*"/>
					<parameter name="length" type="gssize"/>
					<parameter name="flags" type="GnomeDesktopItemLoadFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_uri" symbol="gnome_desktop_item_new_from_uri">
				<return-type type="GnomeDesktopItem*"/>
				<parameters>
					<parameter name="uri" type="char*"/>
					<parameter name="flags" type="GnomeDesktopItemLoadFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="ref" symbol="gnome_desktop_item_ref">
				<return-type type="GnomeDesktopItem*"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
				</parameters>
			</method>
			<method name="save" symbol="gnome_desktop_item_save">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="under" type="char*"/>
					<parameter name="force" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_boolean" symbol="gnome_desktop_item_set_boolean">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_entry_type" symbol="gnome_desktop_item_set_entry_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="type" type="GnomeDesktopItemType"/>
				</parameters>
			</method>
			<method name="set_launch_time" symbol="gnome_desktop_item_set_launch_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="timestamp" type="guint32"/>
				</parameters>
			</method>
			<method name="set_localestring" symbol="gnome_desktop_item_set_localestring">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_localestring_lang" symbol="gnome_desktop_item_set_localestring_lang">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="language" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_location" symbol="gnome_desktop_item_set_location">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="location" type="char*"/>
				</parameters>
			</method>
			<method name="set_location_file" symbol="gnome_desktop_item_set_location_file">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="file" type="char*"/>
				</parameters>
			</method>
			<method name="set_string" symbol="gnome_desktop_item_set_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_strings" symbol="gnome_desktop_item_set_strings">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
					<parameter name="attr" type="char*"/>
					<parameter name="strings" type="char**"/>
				</parameters>
			</method>
			<method name="unref" symbol="gnome_desktop_item_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="item" type="GnomeDesktopItem*"/>
				</parameters>
			</method>
		</boxed>
		<enum name="GnomeDesktopItemError">
			<member name="GNOME_DESKTOP_ITEM_ERROR_NO_FILENAME" value="0"/>
			<member name="GNOME_DESKTOP_ITEM_ERROR_UNKNOWN_ENCODING" value="1"/>
			<member name="GNOME_DESKTOP_ITEM_ERROR_CANNOT_OPEN" value="2"/>
			<member name="GNOME_DESKTOP_ITEM_ERROR_NO_EXEC_STRING" value="3"/>
			<member name="GNOME_DESKTOP_ITEM_ERROR_BAD_EXEC_STRING" value="4"/>
			<member name="GNOME_DESKTOP_ITEM_ERROR_NO_URL" value="5"/>
			<member name="GNOME_DESKTOP_ITEM_ERROR_NOT_LAUNCHABLE" value="6"/>
			<member name="GNOME_DESKTOP_ITEM_ERROR_INVALID_TYPE" value="7"/>
		</enum>
		<enum name="GnomeDesktopItemIconFlags">
			<member name="GNOME_DESKTOP_ITEM_ICON_NO_KDE" value="1"/>
		</enum>
		<enum name="GnomeDesktopItemLaunchFlags">
			<member name="GNOME_DESKTOP_ITEM_LAUNCH_ONLY_ONE" value="1"/>
			<member name="GNOME_DESKTOP_ITEM_LAUNCH_USE_CURRENT_DIR" value="2"/>
			<member name="GNOME_DESKTOP_ITEM_LAUNCH_APPEND_URIS" value="4"/>
			<member name="GNOME_DESKTOP_ITEM_LAUNCH_APPEND_PATHS" value="8"/>
			<member name="GNOME_DESKTOP_ITEM_LAUNCH_DO_NOT_REAP_CHILD" value="16"/>
		</enum>
		<enum name="GnomeDesktopItemLoadFlags">
			<member name="GNOME_DESKTOP_ITEM_LOAD_ONLY_IF_EXISTS" value="1"/>
			<member name="GNOME_DESKTOP_ITEM_LOAD_NO_TRANSLATIONS" value="2"/>
		</enum>
		<enum name="GnomeDesktopItemStatus">
			<member name="GNOME_DESKTOP_ITEM_UNCHANGED" value="0"/>
			<member name="GNOME_DESKTOP_ITEM_CHANGED" value="1"/>
			<member name="GNOME_DESKTOP_ITEM_DISAPPEARED" value="2"/>
		</enum>
		<enum name="GnomeDesktopItemType">
			<member name="GNOME_DESKTOP_ITEM_TYPE_NULL" value="0"/>
			<member name="GNOME_DESKTOP_ITEM_TYPE_OTHER" value="1"/>
			<member name="GNOME_DESKTOP_ITEM_TYPE_APPLICATION" value="2"/>
			<member name="GNOME_DESKTOP_ITEM_TYPE_LINK" value="3"/>
			<member name="GNOME_DESKTOP_ITEM_TYPE_FSDEVICE" value="4"/>
			<member name="GNOME_DESKTOP_ITEM_TYPE_MIME_TYPE" value="5"/>
			<member name="GNOME_DESKTOP_ITEM_TYPE_DIRECTORY" value="6"/>
			<member name="GNOME_DESKTOP_ITEM_TYPE_SERVICE" value="7"/>
			<member name="GNOME_DESKTOP_ITEM_TYPE_SERVICE_TYPE" value="8"/>
		</enum>
		<object name="GnomeDItemEdit" parent="GtkNotebook" type-name="GnomeDItemEdit" get-type="gnome_ditem_edit_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="clear" symbol="gnome_ditem_edit_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="dee" type="GnomeDItemEdit*"/>
				</parameters>
			</method>
			<method name="get_ditem" symbol="gnome_ditem_edit_get_ditem">
				<return-type type="GnomeDesktopItem*"/>
				<parameters>
					<parameter name="dee" type="GnomeDItemEdit*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gnome_ditem_edit_get_icon">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dee" type="GnomeDItemEdit*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gnome_ditem_edit_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dee" type="GnomeDItemEdit*"/>
				</parameters>
			</method>
			<method name="grab_focus" symbol="gnome_ditem_edit_grab_focus">
				<return-type type="void"/>
				<parameters>
					<parameter name="dee" type="GnomeDItemEdit*"/>
				</parameters>
			</method>
			<method name="load_uri" symbol="gnome_ditem_edit_load_uri">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dee" type="GnomeDItemEdit*"/>
					<parameter name="uri" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gnome_ditem_edit_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_directory_only" symbol="gnome_ditem_edit_set_directory_only">
				<return-type type="void"/>
				<parameters>
					<parameter name="dee" type="GnomeDItemEdit*"/>
					<parameter name="directory_only" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_ditem" symbol="gnome_ditem_edit_set_ditem">
				<return-type type="void"/>
				<parameters>
					<parameter name="dee" type="GnomeDItemEdit*"/>
					<parameter name="ditem" type="GnomeDesktopItem*"/>
				</parameters>
			</method>
			<method name="set_editable" symbol="gnome_ditem_edit_set_editable">
				<return-type type="void"/>
				<parameters>
					<parameter name="dee" type="GnomeDItemEdit*"/>
					<parameter name="editable" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_entry_type" symbol="gnome_ditem_edit_set_entry_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="dee" type="GnomeDItemEdit*"/>
					<parameter name="type" type="char*"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="gee" type="GnomeDItemEdit*"/>
				</parameters>
			</signal>
			<signal name="icon-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="gee" type="GnomeDItemEdit*"/>
				</parameters>
			</signal>
			<signal name="name-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="gee" type="GnomeDItemEdit*"/>
				</parameters>
			</signal>
		</object>
		<object name="GnomeHint" parent="GtkDialog" type-name="GnomeHint" get-type="gnome_hint_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="gnome_hint_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="hintfile" type="gchar*"/>
					<parameter name="title" type="gchar*"/>
					<parameter name="background_image" type="gchar*"/>
					<parameter name="logo_image" type="gchar*"/>
					<parameter name="startupkey" type="gchar*"/>
				</parameters>
			</constructor>
		</object>
		<constant name="GNOME_DESKTOP_ITEM_ACTIONS" type="char*" value="Actions"/>
		<constant name="GNOME_DESKTOP_ITEM_CATEGORIES" type="char*" value="Categories"/>
		<constant name="GNOME_DESKTOP_ITEM_COMMENT" type="char*" value="Comment"/>
		<constant name="GNOME_DESKTOP_ITEM_DEFAULT_APP" type="char*" value="DefaultApp"/>
		<constant name="GNOME_DESKTOP_ITEM_DEV" type="char*" value="Dev"/>
		<constant name="GNOME_DESKTOP_ITEM_DOC_PATH" type="char*" value="X-GNOME-DocPath"/>
		<constant name="GNOME_DESKTOP_ITEM_ENCODING" type="char*" value="Encoding"/>
		<constant name="GNOME_DESKTOP_ITEM_EXEC" type="char*" value="Exec"/>
		<constant name="GNOME_DESKTOP_ITEM_FILE_PATTERN" type="char*" value="FilePattern"/>
		<constant name="GNOME_DESKTOP_ITEM_FS_TYPE" type="char*" value="FSType"/>
		<constant name="GNOME_DESKTOP_ITEM_GENERIC_NAME" type="char*" value="GenericName"/>
		<constant name="GNOME_DESKTOP_ITEM_HIDDEN" type="char*" value="Hidden"/>
		<constant name="GNOME_DESKTOP_ITEM_ICON" type="char*" value="Icon"/>
		<constant name="GNOME_DESKTOP_ITEM_MIME_TYPE" type="char*" value="MimeType"/>
		<constant name="GNOME_DESKTOP_ITEM_MINI_ICON" type="char*" value="MiniIcon"/>
		<constant name="GNOME_DESKTOP_ITEM_MOUNT_POINT" type="char*" value="MountPoint"/>
		<constant name="GNOME_DESKTOP_ITEM_NAME" type="char*" value="Name"/>
		<constant name="GNOME_DESKTOP_ITEM_NO_DISPLAY" type="char*" value="NoDisplay"/>
		<constant name="GNOME_DESKTOP_ITEM_ONLY_SHOW_IN" type="char*" value="OnlyShowIn"/>
		<constant name="GNOME_DESKTOP_ITEM_PATH" type="char*" value="Path"/>
		<constant name="GNOME_DESKTOP_ITEM_PATTERNS" type="char*" value="Patterns"/>
		<constant name="GNOME_DESKTOP_ITEM_READ_ONLY" type="char*" value="ReadOnly"/>
		<constant name="GNOME_DESKTOP_ITEM_SORT_ORDER" type="char*" value="SortOrder"/>
		<constant name="GNOME_DESKTOP_ITEM_SWALLOW_EXEC" type="char*" value="SwallowExec"/>
		<constant name="GNOME_DESKTOP_ITEM_SWALLOW_TITLE" type="char*" value="SwallowTitle"/>
		<constant name="GNOME_DESKTOP_ITEM_TERMINAL" type="char*" value="Terminal"/>
		<constant name="GNOME_DESKTOP_ITEM_TERMINAL_OPTIONS" type="char*" value="TerminalOptions"/>
		<constant name="GNOME_DESKTOP_ITEM_TRY_EXEC" type="char*" value="TryExec"/>
		<constant name="GNOME_DESKTOP_ITEM_TYPE" type="char*" value="Type"/>
		<constant name="GNOME_DESKTOP_ITEM_UNMOUNT_ICON" type="char*" value="UnmountIcon"/>
		<constant name="GNOME_DESKTOP_ITEM_URL" type="char*" value="URL"/>
		<constant name="GNOME_DESKTOP_ITEM_VERSION" type="char*" value="Version"/>
	</namespace>
</api>
