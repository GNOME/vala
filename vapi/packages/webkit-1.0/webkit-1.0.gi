<?xml version="1.0"?>
<api version="1.0">
	<namespace name="WebKit">
		<function name="application_cache_get_database_directory_path" symbol="webkit_application_cache_get_database_directory_path">
			<return-type type="gchar*"/>
		</function>
		<function name="application_cache_get_maximum_size" symbol="webkit_application_cache_get_maximum_size">
			<return-type type="unsigned"/>
		</function>
		<function name="application_cache_set_maximum_size" symbol="webkit_application_cache_set_maximum_size">
			<return-type type="void"/>
			<parameters>
				<parameter name="size" type="unsigned"/>
			</parameters>
		</function>
		<function name="check_version" symbol="webkit_check_version">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="major" type="guint"/>
				<parameter name="minor" type="guint"/>
				<parameter name="micro" type="guint"/>
			</parameters>
		</function>
		<function name="context_menu_item_get_action" symbol="webkit_context_menu_item_get_action">
			<return-type type="WebKitContextMenuAction"/>
			<parameters>
				<parameter name="item" type="GtkMenuItem*"/>
			</parameters>
		</function>
		<function name="geolocation_policy_allow" symbol="webkit_geolocation_policy_allow">
			<return-type type="void"/>
			<parameters>
				<parameter name="decision" type="WebKitGeolocationPolicyDecision*"/>
			</parameters>
		</function>
		<function name="geolocation_policy_deny" symbol="webkit_geolocation_policy_deny">
			<return-type type="void"/>
			<parameters>
				<parameter name="decision" type="WebKitGeolocationPolicyDecision*"/>
			</parameters>
		</function>
		<function name="get_cache_model" symbol="webkit_get_cache_model">
			<return-type type="WebKitCacheModel"/>
		</function>
		<function name="get_default_session" symbol="webkit_get_default_session">
			<return-type type="SoupSession*"/>
		</function>
		<function name="get_default_web_database_quota" symbol="webkit_get_default_web_database_quota">
			<return-type type="guint64"/>
		</function>
		<function name="get_favicon_database" symbol="webkit_get_favicon_database">
			<return-type type="WebKitFaviconDatabase*"/>
		</function>
		<function name="get_icon_database" symbol="webkit_get_icon_database">
			<return-type type="WebKitIconDatabase*"/>
		</function>
		<function name="get_security_policy_for_uri_scheme" symbol="webkit_get_security_policy_for_uri_scheme">
			<return-type type="WebKitSecurityPolicy"/>
			<parameters>
				<parameter name="scheme" type="gchar*"/>
			</parameters>
		</function>
		<function name="get_text_checker" symbol="webkit_get_text_checker">
			<return-type type="GObject*"/>
		</function>
		<function name="get_web_database_directory_path" symbol="webkit_get_web_database_directory_path">
			<return-type type="gchar*"/>
		</function>
		<function name="get_web_plugin_database" symbol="webkit_get_web_plugin_database">
			<return-type type="WebKitWebPluginDatabase*"/>
		</function>
		<function name="major_version" symbol="webkit_major_version">
			<return-type type="guint"/>
		</function>
		<function name="micro_version" symbol="webkit_micro_version">
			<return-type type="guint"/>
		</function>
		<function name="minor_version" symbol="webkit_minor_version">
			<return-type type="guint"/>
		</function>
		<function name="network_error_quark" symbol="webkit_network_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="plugin_error_quark" symbol="webkit_plugin_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="policy_error_quark" symbol="webkit_policy_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="remove_all_web_databases" symbol="webkit_remove_all_web_databases">
			<return-type type="void"/>
		</function>
		<function name="set_cache_model" symbol="webkit_set_cache_model">
			<return-type type="void"/>
			<parameters>
				<parameter name="cache_model" type="WebKitCacheModel"/>
			</parameters>
		</function>
		<function name="set_default_web_database_quota" symbol="webkit_set_default_web_database_quota">
			<return-type type="void"/>
			<parameters>
				<parameter name="defaultQuota" type="guint64"/>
			</parameters>
		</function>
		<function name="set_security_policy_for_uri_scheme" symbol="webkit_set_security_policy_for_uri_scheme">
			<return-type type="void"/>
			<parameters>
				<parameter name="scheme" type="gchar*"/>
				<parameter name="policy" type="WebKitSecurityPolicy"/>
			</parameters>
		</function>
		<function name="set_text_checker" symbol="webkit_set_text_checker">
			<return-type type="void"/>
			<parameters>
				<parameter name="checker" type="GObject*"/>
			</parameters>
		</function>
		<function name="set_web_database_directory_path" symbol="webkit_set_web_database_directory_path">
			<return-type type="void"/>
			<parameters>
				<parameter name="path" type="gchar*"/>
			</parameters>
		</function>
		<struct name="WebKitDOMEventTargetClass">
		</struct>
		<struct name="WebKitWebPluginMIMEType">
			<field name="name" type="char*"/>
			<field name="description" type="char*"/>
			<field name="extensions" type="char**"/>
		</struct>
		<enum name="WebKitCacheModel" type-name="WebKitCacheModel" get-type="webkit_cache_model_get_type">
			<member name="WEBKIT_CACHE_MODEL_DEFAULT" value="0"/>
			<member name="WEBKIT_CACHE_MODEL_DOCUMENT_VIEWER" value="1"/>
			<member name="WEBKIT_CACHE_MODEL_WEB_BROWSER" value="2"/>
			<member name="WEBKIT_CACHE_MODEL_DOCUMENT_BROWSER" value="3"/>
		</enum>
		<enum name="WebKitContextMenuAction" type-name="WebKitContextMenuAction" get-type="webkit_context_menu_action_get_type">
			<member name="WEBKIT_CONTEXT_MENU_ACTION_NO_ACTION" value="0"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_OPEN_LINK" value="1"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_OPEN_LINK_IN_NEW_WINDOW" value="2"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_DOWNLOAD_LINK_TO_DISK" value="3"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_COPY_LINK_TO_CLIPBOARD" value="4"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_OPEN_IMAGE_IN_NEW_WINDOW" value="5"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_DOWNLOAD_IMAGE_TO_DISK" value="6"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_COPY_IMAGE_TO_CLIPBOARD" value="7"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_COPY_IMAGE_URL_TO_CLIPBOARD" value="8"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_OPEN_FRAME_IN_NEW_WINDOW" value="9"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_GO_BACK" value="10"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_GO_FORWARD" value="11"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_STOP" value="12"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_RELOAD" value="13"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_COPY" value="14"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_CUT" value="15"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_PASTE" value="16"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_DELETE" value="17"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_SELECT_ALL" value="18"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_INPUT_METHODS" value="19"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_UNICODE" value="20"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_SPELLING_GUESS" value="21"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_NO_GUESSES_FOUND" value="22"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_IGNORE_SPELLING" value="23"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_LEARN_SPELLING" value="24"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_IGNORE_GRAMMAR" value="25"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_FONT_MENU" value="26"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_BOLD" value="27"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_ITALIC" value="28"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_UNDERLINE" value="29"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_OUTLINE" value="30"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_INSPECT_ELEMENT" value="31"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_OPEN_MEDIA_IN_NEW_WINDOW" value="32"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_COPY_MEDIA_LINK_TO_CLIPBOARD" value="33"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_TOGGLE_MEDIA_CONTROLS" value="34"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_TOGGLE_MEDIA_LOOP" value="35"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_ENTER_VIDEO_FULLSCREEN" value="36"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_MEDIA_PLAY_PAUSE" value="37"/>
			<member name="WEBKIT_CONTEXT_MENU_ACTION_MEDIA_MUTE" value="38"/>
		</enum>
		<enum name="WebKitDownloadError" type-name="WebKitDownloadError" get-type="webkit_download_error_get_type">
			<member name="WEBKIT_DOWNLOAD_ERROR_CANCELLED_BY_USER" value="0"/>
			<member name="WEBKIT_DOWNLOAD_ERROR_DESTINATION" value="1"/>
			<member name="WEBKIT_DOWNLOAD_ERROR_NETWORK" value="2"/>
		</enum>
		<enum name="WebKitDownloadStatus" type-name="WebKitDownloadStatus" get-type="webkit_download_status_get_type">
			<member name="WEBKIT_DOWNLOAD_STATUS_ERROR" value="-1"/>
			<member name="WEBKIT_DOWNLOAD_STATUS_CREATED" value="0"/>
			<member name="WEBKIT_DOWNLOAD_STATUS_STARTED" value="1"/>
			<member name="WEBKIT_DOWNLOAD_STATUS_CANCELLED" value="2"/>
			<member name="WEBKIT_DOWNLOAD_STATUS_FINISHED" value="3"/>
		</enum>
		<enum name="WebKitEditingBehavior" type-name="WebKitEditingBehavior" get-type="webkit_editing_behavior_get_type">
			<member name="WEBKIT_EDITING_BEHAVIOR_MAC" value="0"/>
			<member name="WEBKIT_EDITING_BEHAVIOR_WINDOWS" value="1"/>
			<member name="WEBKIT_EDITING_BEHAVIOR_UNIX" value="2"/>
		</enum>
		<enum name="WebKitInsertAction" type-name="WebKitInsertAction" get-type="webkit_insert_action_get_type">
			<member name="WEBKIT_INSERT_ACTION_TYPED" value="0"/>
			<member name="WEBKIT_INSERT_ACTION_PASTED" value="1"/>
			<member name="WEBKIT_INSERT_ACTION_DROPPED" value="2"/>
		</enum>
		<enum name="WebKitLoadStatus" type-name="WebKitLoadStatus" get-type="webkit_load_status_get_type">
			<member name="WEBKIT_LOAD_PROVISIONAL" value="0"/>
			<member name="WEBKIT_LOAD_COMMITTED" value="1"/>
			<member name="WEBKIT_LOAD_FINISHED" value="2"/>
			<member name="WEBKIT_LOAD_FIRST_VISUALLY_NON_EMPTY_LAYOUT" value="3"/>
			<member name="WEBKIT_LOAD_FAILED" value="4"/>
		</enum>
		<enum name="WebKitNavigationResponse" type-name="WebKitNavigationResponse" get-type="webkit_navigation_response_get_type">
			<member name="WEBKIT_NAVIGATION_RESPONSE_ACCEPT" value="0"/>
			<member name="WEBKIT_NAVIGATION_RESPONSE_IGNORE" value="1"/>
			<member name="WEBKIT_NAVIGATION_RESPONSE_DOWNLOAD" value="2"/>
		</enum>
		<enum name="WebKitNetworkError" type-name="WebKitNetworkError" get-type="webkit_network_error_get_type">
			<member name="WEBKIT_NETWORK_ERROR_FAILED" value="399"/>
			<member name="WEBKIT_NETWORK_ERROR_TRANSPORT" value="300"/>
			<member name="WEBKIT_NETWORK_ERROR_UNKNOWN_PROTOCOL" value="301"/>
			<member name="WEBKIT_NETWORK_ERROR_CANCELLED" value="302"/>
			<member name="WEBKIT_NETWORK_ERROR_FILE_DOES_NOT_EXIST" value="303"/>
		</enum>
		<enum name="WebKitPluginError" type-name="WebKitPluginError" get-type="webkit_plugin_error_get_type">
			<member name="WEBKIT_PLUGIN_ERROR_FAILED" value="299"/>
			<member name="WEBKIT_PLUGIN_ERROR_CANNOT_FIND_PLUGIN" value="200"/>
			<member name="WEBKIT_PLUGIN_ERROR_CANNOT_LOAD_PLUGIN" value="201"/>
			<member name="WEBKIT_PLUGIN_ERROR_JAVA_UNAVAILABLE" value="202"/>
			<member name="WEBKIT_PLUGIN_ERROR_CONNECTION_CANCELLED" value="203"/>
			<member name="WEBKIT_PLUGIN_ERROR_WILL_HANDLE_LOAD" value="204"/>
		</enum>
		<enum name="WebKitPolicyError" type-name="WebKitPolicyError" get-type="webkit_policy_error_get_type">
			<member name="WEBKIT_POLICY_ERROR_FAILED" value="199"/>
			<member name="WEBKIT_POLICY_ERROR_CANNOT_SHOW_MIME_TYPE" value="100"/>
			<member name="WEBKIT_POLICY_ERROR_CANNOT_SHOW_URL" value="101"/>
			<member name="WEBKIT_POLICY_ERROR_FRAME_LOAD_INTERRUPTED_BY_POLICY_CHANGE" value="102"/>
			<member name="WEBKIT_POLICY_ERROR_CANNOT_USE_RESTRICTED_PORT" value="103"/>
		</enum>
		<enum name="WebKitSelectionAffinity" type-name="WebKitSelectionAffinity" get-type="webkit_selection_affinity_get_type">
			<member name="WEBKIT_SELECTION_AFFINITY_UPSTREAM" value="0"/>
			<member name="WEBKIT_SELECTION_AFFINITY_DOWNSTREAM" value="1"/>
		</enum>
		<enum name="WebKitWebNavigationReason" type-name="WebKitWebNavigationReason" get-type="webkit_web_navigation_reason_get_type">
			<member name="WEBKIT_WEB_NAVIGATION_REASON_LINK_CLICKED" value="0"/>
			<member name="WEBKIT_WEB_NAVIGATION_REASON_FORM_SUBMITTED" value="1"/>
			<member name="WEBKIT_WEB_NAVIGATION_REASON_BACK_FORWARD" value="2"/>
			<member name="WEBKIT_WEB_NAVIGATION_REASON_RELOAD" value="3"/>
			<member name="WEBKIT_WEB_NAVIGATION_REASON_FORM_RESUBMITTED" value="4"/>
			<member name="WEBKIT_WEB_NAVIGATION_REASON_OTHER" value="5"/>
		</enum>
		<enum name="WebKitWebViewTargetInfo" type-name="WebKitWebViewTargetInfo" get-type="webkit_web_view_target_info_get_type">
			<member name="WEBKIT_WEB_VIEW_TARGET_INFO_HTML" value="0"/>
			<member name="WEBKIT_WEB_VIEW_TARGET_INFO_TEXT" value="1"/>
			<member name="WEBKIT_WEB_VIEW_TARGET_INFO_IMAGE" value="2"/>
			<member name="WEBKIT_WEB_VIEW_TARGET_INFO_URI_LIST" value="3"/>
			<member name="WEBKIT_WEB_VIEW_TARGET_INFO_NETSCAPE_URL" value="4"/>
		</enum>
		<enum name="WebKitWebViewViewMode" type-name="WebKitWebViewViewMode" get-type="webkit_web_view_view_mode_get_type">
			<member name="WEBKIT_WEB_VIEW_VIEW_MODE_WINDOWED" value="0"/>
			<member name="WEBKIT_WEB_VIEW_VIEW_MODE_FLOATING" value="1"/>
			<member name="WEBKIT_WEB_VIEW_VIEW_MODE_FULLSCREEN" value="2"/>
			<member name="WEBKIT_WEB_VIEW_VIEW_MODE_MAXIMIZED" value="3"/>
			<member name="WEBKIT_WEB_VIEW_VIEW_MODE_MINIMIZED" value="4"/>
		</enum>
		<flags name="WebKitHitTestResultContext" type-name="WebKitHitTestResultContext" get-type="webkit_hit_test_result_context_get_type">
			<member name="WEBKIT_HIT_TEST_RESULT_CONTEXT_DOCUMENT" value="2"/>
			<member name="WEBKIT_HIT_TEST_RESULT_CONTEXT_LINK" value="4"/>
			<member name="WEBKIT_HIT_TEST_RESULT_CONTEXT_IMAGE" value="8"/>
			<member name="WEBKIT_HIT_TEST_RESULT_CONTEXT_MEDIA" value="16"/>
			<member name="WEBKIT_HIT_TEST_RESULT_CONTEXT_SELECTION" value="32"/>
			<member name="WEBKIT_HIT_TEST_RESULT_CONTEXT_EDITABLE" value="64"/>
		</flags>
		<flags name="WebKitSecurityPolicy" type-name="WebKitSecurityPolicy" get-type="webkit_security_policy_get_type">
			<member name="WEBKIT_SECURITY_POLICY_LOCAL" value="2"/>
			<member name="WEBKIT_SECURITY_POLICY_NO_ACCESS_TO_OTHER_SCHEME" value="4"/>
			<member name="WEBKIT_SECURITY_POLICY_DISPLAY_ISOLATED" value="8"/>
			<member name="WEBKIT_SECURITY_POLICY_SECURE" value="16"/>
			<member name="WEBKIT_SECURITY_POLICY_CORS_ENABLED" value="32"/>
			<member name="WEBKIT_SECURITY_POLICY_EMPTY_DOCUMENT" value="64"/>
		</flags>
		<object name="WebKitDOMAttr" parent="WebKitDOMNode" type-name="WebKitDOMAttr" get-type="webkit_dom_attr_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_is_id" symbol="webkit_dom_attr_get_is_id">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAttr*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_attr_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAttr*"/>
				</parameters>
			</method>
			<method name="get_owner_element" symbol="webkit_dom_attr_get_owner_element">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAttr*"/>
				</parameters>
			</method>
			<method name="get_specified" symbol="webkit_dom_attr_get_specified">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAttr*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="webkit_dom_attr_get_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAttr*"/>
				</parameters>
			</method>
			<method name="set_value" symbol="webkit_dom_attr_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAttr*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="is-id" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="owner-element" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="specified" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMAudioTrack" parent="WebKitDOMObject" type-name="WebKitDOMAudioTrack" get-type="webkit_dom_audio_track_get_type">
			<method name="get_enabled" symbol="webkit_dom_audio_track_get_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAudioTrack*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="webkit_dom_audio_track_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAudioTrack*"/>
				</parameters>
			</method>
			<method name="get_kind" symbol="webkit_dom_audio_track_get_kind">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAudioTrack*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="webkit_dom_audio_track_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAudioTrack*"/>
				</parameters>
			</method>
			<method name="get_language" symbol="webkit_dom_audio_track_get_language">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAudioTrack*"/>
				</parameters>
			</method>
			<method name="set_enabled" symbol="webkit_dom_audio_track_set_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAudioTrack*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="enabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="kind" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="language" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMAudioTrackList" parent="WebKitDOMObject" type-name="WebKitDOMAudioTrackList" get-type="webkit_dom_audio_track_list_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="dispatch_event" symbol="webkit_dom_audio_track_list_dispatch_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAudioTrackList*"/>
					<parameter name="evt" type="WebKitDOMEvent*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_audio_track_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAudioTrackList*"/>
				</parameters>
			</method>
			<method name="get_track_by_id" symbol="webkit_dom_audio_track_list_get_track_by_id">
				<return-type type="WebKitDOMAudioTrack*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAudioTrackList*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_audio_track_list_item">
				<return-type type="WebKitDOMAudioTrack*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMAudioTrackList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMBarInfo" parent="WebKitDOMObject" type-name="WebKitDOMBarInfo" get-type="webkit_dom_bar_info_get_type">
			<method name="get_visible" symbol="webkit_dom_bar_info_get_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="void*"/>
				</parameters>
			</method>
			<property name="visible" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMBarProp" parent="WebKitDOMObject" type-name="WebKitDOMBarProp" get-type="webkit_dom_bar_prop_get_type">
			<method name="get_visible" symbol="webkit_dom_bar_prop_get_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMBarProp*"/>
				</parameters>
			</method>
			<property name="visible" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMBatteryManager" parent="WebKitDOMObject" type-name="WebKitDOMBatteryManager" get-type="webkit_dom_battery_manager_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="dispatch_event" symbol="webkit_dom_battery_manager_dispatch_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMBatteryManager*"/>
					<parameter name="event" type="WebKitDOMEvent*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_charging" symbol="webkit_dom_battery_manager_get_charging">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMBatteryManager*"/>
				</parameters>
			</method>
			<method name="get_charging_time" symbol="webkit_dom_battery_manager_get_charging_time">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMBatteryManager*"/>
				</parameters>
			</method>
			<method name="get_discharging_time" symbol="webkit_dom_battery_manager_get_discharging_time">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMBatteryManager*"/>
				</parameters>
			</method>
			<method name="get_level" symbol="webkit_dom_battery_manager_get_level">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMBatteryManager*"/>
				</parameters>
			</method>
			<property name="charging" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="charging-time" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="discharging-time" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="level" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMBlob" parent="WebKitDOMObject" type-name="WebKitDOMBlob" get-type="webkit_dom_blob_get_type">
			<method name="get_size" symbol="webkit_dom_blob_get_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMBlob*"/>
				</parameters>
			</method>
			<method name="slice" symbol="webkit_dom_blob_slice">
				<return-type type="WebKitDOMBlob*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMBlob*"/>
					<parameter name="start" type="gint64"/>
					<parameter name="end" type="gint64"/>
					<parameter name="contentType" type="gchar*"/>
				</parameters>
			</method>
			<method name="webkit_slice" symbol="webkit_dom_blob_webkit_slice">
				<return-type type="WebKitDOMBlob*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMBlob*"/>
					<parameter name="start" type="gint64"/>
					<parameter name="end" type="gint64"/>
					<parameter name="content_type" type="gchar*"/>
				</parameters>
			</method>
			<property name="size" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMCDATASection" parent="WebKitDOMText" type-name="WebKitDOMCDATASection" get-type="webkit_dom_cdata_section_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
		</object>
		<object name="WebKitDOMCSSRule" parent="WebKitDOMObject" type-name="WebKitDOMCSSRule" get-type="webkit_dom_css_rule_get_type">
			<method name="get_css_text" symbol="webkit_dom_css_rule_get_css_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSRule*"/>
				</parameters>
			</method>
			<method name="get_parent_rule" symbol="webkit_dom_css_rule_get_parent_rule">
				<return-type type="WebKitDOMCSSRule*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSRule*"/>
				</parameters>
			</method>
			<method name="get_parent_style_sheet" symbol="webkit_dom_css_rule_get_parent_style_sheet">
				<return-type type="WebKitDOMCSSStyleSheet*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSRule*"/>
				</parameters>
			</method>
			<method name="set_css_text" symbol="webkit_dom_css_rule_set_css_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSRule*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="css-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="parent-rule" type="WebKitDOMCSSRule*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="parent-style-sheet" type="WebKitDOMCSSStyleSheet*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="type" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMCSSRuleList" parent="WebKitDOMObject" type-name="WebKitDOMCSSRuleList" get-type="webkit_dom_css_rule_list_get_type">
			<method name="get_length" symbol="webkit_dom_css_rule_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSRuleList*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_css_rule_list_item">
				<return-type type="WebKitDOMCSSRule*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSRuleList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMCSSStyleDeclaration" parent="WebKitDOMObject" type-name="WebKitDOMCSSStyleDeclaration" get-type="webkit_dom_css_style_declaration_get_type">
			<method name="get_css_text" symbol="webkit_dom_css_style_declaration_get_css_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleDeclaration*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_css_style_declaration_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleDeclaration*"/>
				</parameters>
			</method>
			<method name="get_parent_rule" symbol="webkit_dom_css_style_declaration_get_parent_rule">
				<return-type type="WebKitDOMCSSRule*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleDeclaration*"/>
				</parameters>
			</method>
			<method name="get_property_css_value" symbol="webkit_dom_css_style_declaration_get_property_css_value">
				<return-type type="WebKitDOMCSSValue*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleDeclaration*"/>
					<parameter name="propertyName" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_property_priority" symbol="webkit_dom_css_style_declaration_get_property_priority">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleDeclaration*"/>
					<parameter name="propertyName" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_property_shorthand" symbol="webkit_dom_css_style_declaration_get_property_shorthand">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleDeclaration*"/>
					<parameter name="propertyName" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_property_value" symbol="webkit_dom_css_style_declaration_get_property_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleDeclaration*"/>
					<parameter name="propertyName" type="gchar*"/>
				</parameters>
			</method>
			<method name="is_property_implicit" symbol="webkit_dom_css_style_declaration_is_property_implicit">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleDeclaration*"/>
					<parameter name="propertyName" type="gchar*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_css_style_declaration_item">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleDeclaration*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<method name="remove_property" symbol="webkit_dom_css_style_declaration_remove_property">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleDeclaration*"/>
					<parameter name="propertyName" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_css_text" symbol="webkit_dom_css_style_declaration_set_css_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleDeclaration*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_property" symbol="webkit_dom_css_style_declaration_set_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleDeclaration*"/>
					<parameter name="propertyName" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="priority" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="css-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="parent-rule" type="WebKitDOMCSSRule*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMCSSStyleSheet" parent="WebKitDOMStyleSheet" type-name="WebKitDOMCSSStyleSheet" get-type="webkit_dom_css_style_sheet_get_type">
			<method name="add_rule" symbol="webkit_dom_css_style_sheet_add_rule">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleSheet*"/>
					<parameter name="selector" type="gchar*"/>
					<parameter name="style" type="gchar*"/>
					<parameter name="index" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="delete_rule" symbol="webkit_dom_css_style_sheet_delete_rule">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleSheet*"/>
					<parameter name="index" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_css_rules" symbol="webkit_dom_css_style_sheet_get_css_rules">
				<return-type type="WebKitDOMCSSRuleList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleSheet*"/>
				</parameters>
			</method>
			<method name="get_owner_rule" symbol="webkit_dom_css_style_sheet_get_owner_rule">
				<return-type type="WebKitDOMCSSRule*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleSheet*"/>
				</parameters>
			</method>
			<method name="get_rules" symbol="webkit_dom_css_style_sheet_get_rules">
				<return-type type="WebKitDOMCSSRuleList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleSheet*"/>
				</parameters>
			</method>
			<method name="insert_rule" symbol="webkit_dom_css_style_sheet_insert_rule">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleSheet*"/>
					<parameter name="rule" type="gchar*"/>
					<parameter name="index" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="remove_rule" symbol="webkit_dom_css_style_sheet_remove_rule">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSStyleSheet*"/>
					<parameter name="index" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="css-rules" type="WebKitDOMCSSRuleList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="owner-rule" type="WebKitDOMCSSRule*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="rules" type="WebKitDOMCSSRuleList*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMCSSValue" parent="WebKitDOMObject" type-name="WebKitDOMCSSValue" get-type="webkit_dom_css_value_get_type">
			<method name="get_css_text" symbol="webkit_dom_css_value_get_css_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSValue*"/>
				</parameters>
			</method>
			<method name="get_css_value_type" symbol="webkit_dom_css_value_get_css_value_type">
				<return-type type="gushort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSValue*"/>
				</parameters>
			</method>
			<method name="set_css_text" symbol="webkit_dom_css_value_set_css_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCSSValue*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="css-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="css-value-type" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMCharacterData" parent="WebKitDOMNode" type-name="WebKitDOMCharacterData" get-type="webkit_dom_character_data_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="append_data" symbol="webkit_dom_character_data_append_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCharacterData*"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="delete_data" symbol="webkit_dom_character_data_delete_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCharacterData*"/>
					<parameter name="offset" type="gulong"/>
					<parameter name="length" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_data" symbol="webkit_dom_character_data_get_data">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCharacterData*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_character_data_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCharacterData*"/>
				</parameters>
			</method>
			<method name="insert_data" symbol="webkit_dom_character_data_insert_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCharacterData*"/>
					<parameter name="offset" type="gulong"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="remove" symbol="webkit_dom_character_data_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCharacterData*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="replace_data" symbol="webkit_dom_character_data_replace_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCharacterData*"/>
					<parameter name="offset" type="gulong"/>
					<parameter name="length" type="gulong"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_data" symbol="webkit_dom_character_data_set_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCharacterData*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="substring_data" symbol="webkit_dom_character_data_substring_data">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMCharacterData*"/>
					<parameter name="offset" type="gulong"/>
					<parameter name="length" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="data" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMComment" parent="WebKitDOMCharacterData" type-name="WebKitDOMComment" get-type="webkit_dom_comment_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
		</object>
		<object name="WebKitDOMConsole" parent="WebKitDOMObject" type-name="WebKitDOMConsole" get-type="webkit_dom_console_get_type">
			<method name="get_memory" symbol="webkit_dom_console_get_memory">
				<return-type type="void*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMConsole*"/>
				</parameters>
			</method>
			<method name="group_end" symbol="webkit_dom_console_group_end">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMConsole*"/>
				</parameters>
			</method>
			<method name="time" symbol="webkit_dom_console_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMConsole*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
		</object>
		<object name="WebKitDOMDOMApplicationCache" parent="WebKitDOMObject" type-name="WebKitDOMDOMApplicationCache" get-type="webkit_dom_dom_application_cache_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="abort" symbol="webkit_dom_dom_application_cache_abort">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMApplicationCache*"/>
				</parameters>
			</method>
			<method name="dispatch_event" symbol="webkit_dom_dom_application_cache_dispatch_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMApplicationCache*"/>
					<parameter name="evt" type="WebKitDOMEvent*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_status" symbol="webkit_dom_dom_application_cache_get_status">
				<return-type type="gushort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMApplicationCache*"/>
				</parameters>
			</method>
			<method name="swap_cache" symbol="webkit_dom_dom_application_cache_swap_cache">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMApplicationCache*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="update" symbol="webkit_dom_dom_application_cache_update">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMApplicationCache*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="status" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDOMImplementation" parent="WebKitDOMObject" type-name="WebKitDOMDOMImplementation" get-type="webkit_dom_dom_implementation_get_type">
			<method name="create_css_style_sheet" symbol="webkit_dom_dom_implementation_create_css_style_sheet">
				<return-type type="WebKitDOMCSSStyleSheet*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMImplementation*"/>
					<parameter name="title" type="gchar*"/>
					<parameter name="media" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_document" symbol="webkit_dom_dom_implementation_create_document">
				<return-type type="WebKitDOMDocument*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMImplementation*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="qualifiedName" type="gchar*"/>
					<parameter name="doctype" type="WebKitDOMDocumentType*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_document_type" symbol="webkit_dom_dom_implementation_create_document_type">
				<return-type type="WebKitDOMDocumentType*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMImplementation*"/>
					<parameter name="qualifiedName" type="gchar*"/>
					<parameter name="publicId" type="gchar*"/>
					<parameter name="systemId" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_html_document" symbol="webkit_dom_dom_implementation_create_html_document">
				<return-type type="WebKitDOMHTMLDocument*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMImplementation*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<method name="has_feature" symbol="webkit_dom_dom_implementation_has_feature">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMImplementation*"/>
					<parameter name="feature" type="gchar*"/>
					<parameter name="version" type="gchar*"/>
				</parameters>
			</method>
		</object>
		<object name="WebKitDOMDOMMimeType" parent="WebKitDOMObject" type-name="WebKitDOMDOMMimeType" get-type="webkit_dom_dom_mime_type_get_type">
			<method name="get_description" symbol="webkit_dom_dom_mime_type_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMMimeType*"/>
				</parameters>
			</method>
			<method name="get_enabled_plugin" symbol="webkit_dom_dom_mime_type_get_enabled_plugin">
				<return-type type="WebKitDOMDOMPlugin*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMMimeType*"/>
				</parameters>
			</method>
			<method name="get_suffixes" symbol="webkit_dom_dom_mime_type_get_suffixes">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMMimeType*"/>
				</parameters>
			</method>
			<property name="description" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="enabled-plugin" type="WebKitDOMDOMPlugin*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="suffixes" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDOMMimeTypeArray" parent="WebKitDOMObject" type-name="WebKitDOMDOMMimeTypeArray" get-type="webkit_dom_dom_mime_type_array_get_type">
			<method name="get_length" symbol="webkit_dom_dom_mime_type_array_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMMimeTypeArray*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_dom_mime_type_array_item">
				<return-type type="WebKitDOMDOMMimeType*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMMimeTypeArray*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<method name="named_item" symbol="webkit_dom_dom_mime_type_array_named_item">
				<return-type type="WebKitDOMDOMMimeType*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMMimeTypeArray*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDOMNamedFlowCollection" parent="WebKitDOMObject" type-name="WebKitDOMDOMNamedFlowCollection" get-type="webkit_dom_dom_named_flow_collection_get_type">
			<method name="get_length" symbol="webkit_dom_dom_named_flow_collection_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMNamedFlowCollection*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_dom_named_flow_collection_item">
				<return-type type="WebKitDOMWebKitNamedFlow*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMNamedFlowCollection*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<method name="named_item" symbol="webkit_dom_dom_named_flow_collection_named_item">
				<return-type type="WebKitDOMWebKitNamedFlow*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMNamedFlowCollection*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDOMPlugin" parent="WebKitDOMObject" type-name="WebKitDOMDOMPlugin" get-type="webkit_dom_dom_plugin_get_type">
			<method name="get_description" symbol="webkit_dom_dom_plugin_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMPlugin*"/>
				</parameters>
			</method>
			<method name="get_filename" symbol="webkit_dom_dom_plugin_get_filename">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMPlugin*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_dom_plugin_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMPlugin*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_dom_plugin_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMPlugin*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_dom_plugin_item">
				<return-type type="WebKitDOMDOMMimeType*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMPlugin*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<method name="named_item" symbol="webkit_dom_dom_plugin_named_item">
				<return-type type="WebKitDOMDOMMimeType*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMPlugin*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<property name="description" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="filename" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDOMPluginArray" parent="WebKitDOMObject" type-name="WebKitDOMDOMPluginArray" get-type="webkit_dom_dom_plugin_array_get_type">
			<method name="get_length" symbol="webkit_dom_dom_plugin_array_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMPluginArray*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_dom_plugin_array_item">
				<return-type type="WebKitDOMDOMPlugin*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMPluginArray*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<method name="named_item" symbol="webkit_dom_dom_plugin_array_named_item">
				<return-type type="WebKitDOMDOMPlugin*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMPluginArray*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="refresh" symbol="webkit_dom_dom_plugin_array_refresh">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMPluginArray*"/>
					<parameter name="reload" type="gboolean"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDOMSecurityPolicy" parent="WebKitDOMObject" type-name="WebKitDOMDOMSecurityPolicy" get-type="webkit_dom_dom_security_policy_get_type">
			<method name="allows_connection_to" symbol="webkit_dom_dom_security_policy_allows_connection_to">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
					<parameter name="url" type="gchar*"/>
				</parameters>
			</method>
			<method name="allows_font_from" symbol="webkit_dom_dom_security_policy_allows_font_from">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
					<parameter name="url" type="gchar*"/>
				</parameters>
			</method>
			<method name="allows_form_action" symbol="webkit_dom_dom_security_policy_allows_form_action">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
					<parameter name="url" type="gchar*"/>
				</parameters>
			</method>
			<method name="allows_frame_from" symbol="webkit_dom_dom_security_policy_allows_frame_from">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
					<parameter name="url" type="gchar*"/>
				</parameters>
			</method>
			<method name="allows_image_from" symbol="webkit_dom_dom_security_policy_allows_image_from">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
					<parameter name="url" type="gchar*"/>
				</parameters>
			</method>
			<method name="allows_media_from" symbol="webkit_dom_dom_security_policy_allows_media_from">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
					<parameter name="url" type="gchar*"/>
				</parameters>
			</method>
			<method name="allows_object_from" symbol="webkit_dom_dom_security_policy_allows_object_from">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
					<parameter name="url" type="gchar*"/>
				</parameters>
			</method>
			<method name="allows_plugin_type" symbol="webkit_dom_dom_security_policy_allows_plugin_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
					<parameter name="type" type="gchar*"/>
				</parameters>
			</method>
			<method name="allows_script_from" symbol="webkit_dom_dom_security_policy_allows_script_from">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
					<parameter name="url" type="gchar*"/>
				</parameters>
			</method>
			<method name="allows_style_from" symbol="webkit_dom_dom_security_policy_allows_style_from">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
					<parameter name="url" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_allows_eval" symbol="webkit_dom_dom_security_policy_get_allows_eval">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
				</parameters>
			</method>
			<method name="get_allows_inline_script" symbol="webkit_dom_dom_security_policy_get_allows_inline_script">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
				</parameters>
			</method>
			<method name="get_allows_inline_style" symbol="webkit_dom_dom_security_policy_get_allows_inline_style">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
				</parameters>
			</method>
			<method name="get_is_active" symbol="webkit_dom_dom_security_policy_get_is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
				</parameters>
			</method>
			<method name="get_report_ur_is" symbol="webkit_dom_dom_security_policy_get_report_ur_is">
				<return-type type="WebKitDOMDOMStringList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSecurityPolicy*"/>
				</parameters>
			</method>
			<property name="allows-eval" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="allows-inline-script" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="allows-inline-style" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-active" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="report-ur-is" type="WebKitDOMDOMStringList*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDOMSelection" parent="WebKitDOMObject" type-name="WebKitDOMDOMSelection" get-type="webkit_dom_dom_selection_get_type">
			<method name="add_range" symbol="webkit_dom_dom_selection_add_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
					<parameter name="range" type="WebKitDOMRange*"/>
				</parameters>
			</method>
			<method name="collapse" symbol="webkit_dom_dom_selection_collapse">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
					<parameter name="node" type="WebKitDOMNode*"/>
					<parameter name="index" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="collapse_to_end" symbol="webkit_dom_dom_selection_collapse_to_end">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="collapse_to_start" symbol="webkit_dom_dom_selection_collapse_to_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="contains_node" symbol="webkit_dom_dom_selection_contains_node">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
					<parameter name="node" type="WebKitDOMNode*"/>
					<parameter name="allowPartial" type="gboolean"/>
				</parameters>
			</method>
			<method name="delete_from_document" symbol="webkit_dom_dom_selection_delete_from_document">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="empty" symbol="webkit_dom_dom_selection_empty">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="extend" symbol="webkit_dom_dom_selection_extend">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
					<parameter name="node" type="WebKitDOMNode*"/>
					<parameter name="offset" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_anchor_node" symbol="webkit_dom_dom_selection_get_anchor_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="get_anchor_offset" symbol="webkit_dom_dom_selection_get_anchor_offset">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="get_base_node" symbol="webkit_dom_dom_selection_get_base_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="get_base_offset" symbol="webkit_dom_dom_selection_get_base_offset">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="get_extent_node" symbol="webkit_dom_dom_selection_get_extent_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="get_extent_offset" symbol="webkit_dom_dom_selection_get_extent_offset">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="get_focus_node" symbol="webkit_dom_dom_selection_get_focus_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="get_focus_offset" symbol="webkit_dom_dom_selection_get_focus_offset">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="get_is_collapsed" symbol="webkit_dom_dom_selection_get_is_collapsed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="get_range_at" symbol="webkit_dom_dom_selection_get_range_at">
				<return-type type="WebKitDOMRange*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
					<parameter name="index" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_range_count" symbol="webkit_dom_dom_selection_get_range_count">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="modify" symbol="webkit_dom_dom_selection_modify">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
					<parameter name="alter" type="gchar*"/>
					<parameter name="direction" type="gchar*"/>
					<parameter name="granularity" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove_all_ranges" symbol="webkit_dom_dom_selection_remove_all_ranges">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
				</parameters>
			</method>
			<method name="select_all_children" symbol="webkit_dom_dom_selection_select_all_children">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
					<parameter name="node" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_base_and_extent" symbol="webkit_dom_dom_selection_set_base_and_extent">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
					<parameter name="baseNode" type="WebKitDOMNode*"/>
					<parameter name="baseOffset" type="glong"/>
					<parameter name="extentNode" type="WebKitDOMNode*"/>
					<parameter name="extentOffset" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_position" symbol="webkit_dom_dom_selection_set_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSelection*"/>
					<parameter name="node" type="WebKitDOMNode*"/>
					<parameter name="offset" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="anchor-node" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="anchor-offset" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="base-node" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="base-offset" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="extent-node" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="extent-offset" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="focus-node" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="focus-offset" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-collapsed" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="range-count" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDOMSettableTokenList" parent="WebKitDOMDOMTokenList" type-name="WebKitDOMDOMSettableTokenList" get-type="webkit_dom_dom_settable_token_list_get_type">
			<method name="get_value" symbol="webkit_dom_dom_settable_token_list_get_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSettableTokenList*"/>
				</parameters>
			</method>
			<method name="set_value" symbol="webkit_dom_dom_settable_token_list_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMSettableTokenList*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDOMStringList" parent="WebKitDOMObject" type-name="WebKitDOMDOMStringList" get-type="webkit_dom_dom_string_list_get_type">
			<method name="contains" symbol="webkit_dom_dom_string_list_contains">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMStringList*"/>
					<parameter name="string" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_dom_string_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMStringList*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_dom_string_list_item">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMStringList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDOMStringMap" parent="WebKitDOMObject" type-name="WebKitDOMDOMStringMap" get-type="webkit_dom_dom_string_map_get_type">
		</object>
		<object name="WebKitDOMDOMTokenList" parent="WebKitDOMObject" type-name="WebKitDOMDOMTokenList" get-type="webkit_dom_dom_token_list_get_type">
			<method name="add" symbol="webkit_dom_dom_token_list_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMTokenList*"/>
					<parameter name="tokens" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="contains" symbol="webkit_dom_dom_token_list_contains">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMTokenList*"/>
					<parameter name="token" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_dom_token_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMTokenList*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_dom_token_list_item">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMTokenList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<method name="remove" symbol="webkit_dom_dom_token_list_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMTokenList*"/>
					<parameter name="tokens" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="toggle" symbol="webkit_dom_dom_token_list_toggle">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMTokenList*"/>
					<parameter name="token" type="gchar*"/>
					<parameter name="force" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDOMWindow" parent="WebKitDOMObject" type-name="WebKitDOMDOMWindow" get-type="webkit_dom_dom_window_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="alert" symbol="webkit_dom_dom_window_alert">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="message" type="gchar*"/>
				</parameters>
			</method>
			<method name="atob" symbol="webkit_dom_dom_window_atob">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="string" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="blur" symbol="webkit_dom_dom_window_blur">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="btoa" symbol="webkit_dom_dom_window_btoa">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="string" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="cancel_animation_frame" symbol="webkit_dom_dom_window_cancel_animation_frame">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="id" type="glong"/>
				</parameters>
			</method>
			<method name="capture_events" symbol="webkit_dom_dom_window_capture_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="clear_interval" symbol="webkit_dom_dom_window_clear_interval">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="handle" type="glong"/>
				</parameters>
			</method>
			<method name="clear_timeout" symbol="webkit_dom_dom_window_clear_timeout">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="handle" type="glong"/>
				</parameters>
			</method>
			<method name="close" symbol="webkit_dom_dom_window_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="confirm" symbol="webkit_dom_dom_window_confirm">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="message" type="gchar*"/>
				</parameters>
			</method>
			<method name="dispatch_event" symbol="webkit_dom_dom_window_dispatch_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="evt" type="WebKitDOMEvent*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="find" symbol="webkit_dom_dom_window_find">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="string" type="gchar*"/>
					<parameter name="caseSensitive" type="gboolean"/>
					<parameter name="backwards" type="gboolean"/>
					<parameter name="wrap" type="gboolean"/>
					<parameter name="wholeWord" type="gboolean"/>
					<parameter name="searchInFrames" type="gboolean"/>
					<parameter name="showDialog" type="gboolean"/>
				</parameters>
			</method>
			<method name="focus" symbol="webkit_dom_dom_window_focus">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_application_cache" symbol="webkit_dom_dom_window_get_application_cache">
				<return-type type="WebKitDOMDOMApplicationCache*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_client_information" symbol="webkit_dom_dom_window_get_client_information">
				<return-type type="WebKitDOMNavigator*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_closed" symbol="webkit_dom_dom_window_get_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_computed_style" symbol="webkit_dom_dom_window_get_computed_style">
				<return-type type="WebKitDOMCSSStyleDeclaration*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="element" type="WebKitDOMElement*"/>
					<parameter name="pseudoElement" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_console" symbol="webkit_dom_dom_window_get_console">
				<return-type type="WebKitDOMConsole*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_css" symbol="webkit_dom_dom_window_get_css">
				<return-type type="WebKitDOMDOMWindowCSS*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_default_status" symbol="webkit_dom_dom_window_get_default_status">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_device_pixel_ratio" symbol="webkit_dom_dom_window_get_device_pixel_ratio">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_document" symbol="webkit_dom_dom_window_get_document">
				<return-type type="WebKitDOMDocument*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_frame_element" symbol="webkit_dom_dom_window_get_frame_element">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_frames" symbol="webkit_dom_dom_window_get_frames">
				<return-type type="WebKitDOMDOMWindow*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_history" symbol="webkit_dom_dom_window_get_history">
				<return-type type="WebKitDOMHistory*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_inner_height" symbol="webkit_dom_dom_window_get_inner_height">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_inner_width" symbol="webkit_dom_dom_window_get_inner_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_dom_window_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_local_storage" symbol="webkit_dom_dom_window_get_local_storage">
				<return-type type="WebKitDOMStorage*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_locationbar" symbol="webkit_dom_dom_window_get_locationbar">
				<return-type type="WebKitDOMBarProp*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_menubar" symbol="webkit_dom_dom_window_get_menubar">
				<return-type type="WebKitDOMBarProp*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_dom_window_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_navigator" symbol="webkit_dom_dom_window_get_navigator">
				<return-type type="WebKitDOMNavigator*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_offscreen_buffering" symbol="webkit_dom_dom_window_get_offscreen_buffering">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_opener" symbol="webkit_dom_dom_window_get_opener">
				<return-type type="WebKitDOMDOMWindow*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_outer_height" symbol="webkit_dom_dom_window_get_outer_height">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_outer_width" symbol="webkit_dom_dom_window_get_outer_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_page_x_offset" symbol="webkit_dom_dom_window_get_page_x_offset">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_page_y_offset" symbol="webkit_dom_dom_window_get_page_y_offset">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="webkit_dom_dom_window_get_parent">
				<return-type type="WebKitDOMDOMWindow*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_performance" symbol="webkit_dom_dom_window_get_performance">
				<return-type type="WebKitDOMPerformance*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_personalbar" symbol="webkit_dom_dom_window_get_personalbar">
				<return-type type="WebKitDOMBarProp*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="webkit_dom_dom_window_get_screen">
				<return-type type="WebKitDOMScreen*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_screen_left" symbol="webkit_dom_dom_window_get_screen_left">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_screen_top" symbol="webkit_dom_dom_window_get_screen_top">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_screen_x" symbol="webkit_dom_dom_window_get_screen_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_screen_y" symbol="webkit_dom_dom_window_get_screen_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_scroll_x" symbol="webkit_dom_dom_window_get_scroll_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_scroll_y" symbol="webkit_dom_dom_window_get_scroll_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_scrollbars" symbol="webkit_dom_dom_window_get_scrollbars">
				<return-type type="WebKitDOMBarProp*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_selection" symbol="webkit_dom_dom_window_get_selection">
				<return-type type="WebKitDOMDOMSelection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_self" symbol="webkit_dom_dom_window_get_self">
				<return-type type="WebKitDOMDOMWindow*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_session_storage" symbol="webkit_dom_dom_window_get_session_storage">
				<return-type type="WebKitDOMStorage*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_status" symbol="webkit_dom_dom_window_get_status">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_statusbar" symbol="webkit_dom_dom_window_get_statusbar">
				<return-type type="WebKitDOMBarProp*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_style_media" symbol="webkit_dom_dom_window_get_style_media">
				<return-type type="WebKitDOMStyleMedia*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_toolbar" symbol="webkit_dom_dom_window_get_toolbar">
				<return-type type="WebKitDOMBarProp*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_top" symbol="webkit_dom_dom_window_get_top">
				<return-type type="WebKitDOMDOMWindow*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_webkit_storage_info" symbol="webkit_dom_dom_window_get_webkit_storage_info">
				<return-type type="WebKitDOMStorageInfo*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="get_window" symbol="webkit_dom_dom_window_get_window">
				<return-type type="WebKitDOMDOMWindow*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="match_media" symbol="webkit_dom_dom_window_match_media">
				<return-type type="WebKitDOMMediaQueryList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="query" type="gchar*"/>
				</parameters>
			</method>
			<method name="move_by" symbol="webkit_dom_dom_window_move_by">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="x" type="gfloat"/>
					<parameter name="y" type="gfloat"/>
				</parameters>
			</method>
			<method name="move_to" symbol="webkit_dom_dom_window_move_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="x" type="gfloat"/>
					<parameter name="y" type="gfloat"/>
				</parameters>
			</method>
			<method name="print" symbol="webkit_dom_dom_window_print">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="prompt" symbol="webkit_dom_dom_window_prompt">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="message" type="gchar*"/>
					<parameter name="defaultValue" type="gchar*"/>
				</parameters>
			</method>
			<method name="release_events" symbol="webkit_dom_dom_window_release_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="resize_by" symbol="webkit_dom_dom_window_resize_by">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="x" type="gfloat"/>
					<parameter name="y" type="gfloat"/>
				</parameters>
			</method>
			<method name="resize_to" symbol="webkit_dom_dom_window_resize_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="width" type="gfloat"/>
					<parameter name="height" type="gfloat"/>
				</parameters>
			</method>
			<method name="scroll" symbol="webkit_dom_dom_window_scroll">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="x" type="glong"/>
					<parameter name="y" type="glong"/>
				</parameters>
			</method>
			<method name="scroll_by" symbol="webkit_dom_dom_window_scroll_by">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="x" type="glong"/>
					<parameter name="y" type="glong"/>
				</parameters>
			</method>
			<method name="scroll_to" symbol="webkit_dom_dom_window_scroll_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="x" type="glong"/>
					<parameter name="y" type="glong"/>
				</parameters>
			</method>
			<method name="set_default_status" symbol="webkit_dom_dom_window_set_default_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_dom_window_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_status" symbol="webkit_dom_dom_window_set_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="stop" symbol="webkit_dom_dom_window_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
				</parameters>
			</method>
			<method name="webkit_cancel_animation_frame" symbol="webkit_dom_dom_window_webkit_cancel_animation_frame">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="id" type="glong"/>
				</parameters>
			</method>
			<method name="webkit_cancel_request_animation_frame" symbol="webkit_dom_dom_window_webkit_cancel_request_animation_frame">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="id" type="glong"/>
				</parameters>
			</method>
			<method name="webkit_convert_point_from_node_to_page" symbol="webkit_dom_dom_window_webkit_convert_point_from_node_to_page">
				<return-type type="WebKitDOMWebKitPoint*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="node" type="WebKitDOMNode*"/>
					<parameter name="p" type="WebKitDOMWebKitPoint*"/>
				</parameters>
			</method>
			<method name="webkit_convert_point_from_page_to_node" symbol="webkit_dom_dom_window_webkit_convert_point_from_page_to_node">
				<return-type type="WebKitDOMWebKitPoint*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindow*"/>
					<parameter name="node" type="WebKitDOMNode*"/>
					<parameter name="p" type="WebKitDOMWebKitPoint*"/>
				</parameters>
			</method>
			<property name="application-cache" type="WebKitDOMDOMApplicationCache*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="client-information" type="WebKitDOMNavigator*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="closed" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="console" type="WebKitDOMConsole*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="css" type="WebKitDOMDOMWindowCSS*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="default-status" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="device-pixel-ratio" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="document" type="WebKitDOMDocument*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="frame-element" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="frames" type="WebKitDOMDOMWindow*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="history" type="WebKitDOMHistory*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="inner-height" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="inner-width" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="local-storage" type="WebKitDOMStorage*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="locationbar" type="WebKitDOMBarProp*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="menubar" type="WebKitDOMBarProp*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="navigator" type="WebKitDOMNavigator*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="offscreen-buffering" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="opener" type="WebKitDOMDOMWindow*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="outer-height" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="outer-width" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="page-x-offset" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="page-y-offset" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="parent" type="WebKitDOMDOMWindow*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="performance" type="WebKitDOMPerformance*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="personalbar" type="WebKitDOMBarProp*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="screen" type="WebKitDOMScreen*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="screen-left" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="screen-top" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="screen-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="screen-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="scroll-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="scroll-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="scrollbars" type="WebKitDOMBarProp*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="self" type="WebKitDOMDOMWindow*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="session-storage" type="WebKitDOMStorage*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="status" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="statusbar" type="WebKitDOMBarProp*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="style-media" type="WebKitDOMStyleMedia*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="toolbar" type="WebKitDOMBarProp*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="top" type="WebKitDOMDOMWindow*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-storage-info" type="WebKitDOMStorageInfo*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="window" type="WebKitDOMDOMWindow*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDOMWindowCSS" parent="WebKitDOMObject" type-name="WebKitDOMDOMWindowCSS" get-type="webkit_dom_dom_window_css_get_type">
			<method name="supports" symbol="webkit_dom_dom_window_css_supports">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDOMWindowCSS*"/>
					<parameter name="property" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
		</object>
		<object name="WebKitDOMDatabase" parent="WebKitDOMObject" type-name="WebKitDOMDatabase" get-type="webkit_dom_database_get_type">
			<method name="get_version" symbol="webkit_dom_database_get_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDatabase*"/>
				</parameters>
			</method>
			<property name="version" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDocument" parent="WebKitDOMNode" type-name="WebKitDOMDocument" get-type="webkit_dom_document_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="adopt_node" symbol="webkit_dom_document_adopt_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="source" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="caret_range_from_point" symbol="webkit_dom_document_caret_range_from_point">
				<return-type type="WebKitDOMRange*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="x" type="glong"/>
					<parameter name="y" type="glong"/>
				</parameters>
			</method>
			<method name="create_attribute" symbol="webkit_dom_document_create_attribute">
				<return-type type="WebKitDOMAttr*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_attribute_ns" symbol="webkit_dom_document_create_attribute_ns">
				<return-type type="WebKitDOMAttr*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="qualifiedName" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_cdata_section" symbol="webkit_dom_document_create_cdata_section">
				<return-type type="WebKitDOMCDATASection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_comment" symbol="webkit_dom_document_create_comment">
				<return-type type="WebKitDOMComment*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="data" type="gchar*"/>
				</parameters>
			</method>
			<method name="create_css_style_declaration" symbol="webkit_dom_document_create_css_style_declaration">
				<return-type type="WebKitDOMCSSStyleDeclaration*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="create_document_fragment" symbol="webkit_dom_document_create_document_fragment">
				<return-type type="WebKitDOMDocumentFragment*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="create_element" symbol="webkit_dom_document_create_element">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="tagName" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_element_ns" symbol="webkit_dom_document_create_element_ns">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="qualifiedName" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_entity_reference" symbol="webkit_dom_document_create_entity_reference">
				<return-type type="WebKitDOMEntityReference*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_event" symbol="webkit_dom_document_create_event">
				<return-type type="WebKitDOMEvent*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="eventType" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_expression" symbol="webkit_dom_document_create_expression">
				<return-type type="WebKitDOMXPathExpression*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="expression" type="gchar*"/>
					<parameter name="resolver" type="WebKitDOMXPathNSResolver*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_node_iterator" symbol="webkit_dom_document_create_node_iterator">
				<return-type type="WebKitDOMNodeIterator*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="root" type="WebKitDOMNode*"/>
					<parameter name="whatToShow" type="gulong"/>
					<parameter name="filter" type="WebKitDOMNodeFilter*"/>
					<parameter name="expandEntityReferences" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_ns_resolver" symbol="webkit_dom_document_create_ns_resolver">
				<return-type type="WebKitDOMXPathNSResolver*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="nodeResolver" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="create_processing_instruction" symbol="webkit_dom_document_create_processing_instruction">
				<return-type type="WebKitDOMProcessingInstruction*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="target" type="gchar*"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_range" symbol="webkit_dom_document_create_range">
				<return-type type="WebKitDOMRange*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="create_text_node" symbol="webkit_dom_document_create_text_node">
				<return-type type="WebKitDOMText*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="data" type="gchar*"/>
				</parameters>
			</method>
			<method name="create_touch" symbol="webkit_dom_document_create_touch">
				<return-type type="WebKitDOMTouch*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="window" type="WebKitDOMDOMWindow*"/>
					<parameter name="target" type="WebKitDOMEventTarget*"/>
					<parameter name="identifier" type="glong"/>
					<parameter name="pageX" type="glong"/>
					<parameter name="pageY" type="glong"/>
					<parameter name="screenX" type="glong"/>
					<parameter name="screenY" type="glong"/>
					<parameter name="webkitRadiusX" type="glong"/>
					<parameter name="webkitRadiusY" type="glong"/>
					<parameter name="webkitRotationAngle" type="gfloat"/>
					<parameter name="webkitForce" type="gfloat"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_tree_walker" symbol="webkit_dom_document_create_tree_walker">
				<return-type type="WebKitDOMTreeWalker*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="root" type="WebKitDOMNode*"/>
					<parameter name="whatToShow" type="gulong"/>
					<parameter name="filter" type="WebKitDOMNodeFilter*"/>
					<parameter name="expandEntityReferences" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="element_from_point" symbol="webkit_dom_document_element_from_point">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="x" type="glong"/>
					<parameter name="y" type="glong"/>
				</parameters>
			</method>
			<method name="evaluate" symbol="webkit_dom_document_evaluate">
				<return-type type="WebKitDOMXPathResult*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="expression" type="gchar*"/>
					<parameter name="contextNode" type="WebKitDOMNode*"/>
					<parameter name="resolver" type="WebKitDOMXPathNSResolver*"/>
					<parameter name="type" type="gushort"/>
					<parameter name="inResult" type="WebKitDOMXPathResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="exec_command" symbol="webkit_dom_document_exec_command">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="command" type="gchar*"/>
					<parameter name="userInterface" type="gboolean"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_anchors" symbol="webkit_dom_document_get_anchors">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_applets" symbol="webkit_dom_document_get_applets">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_body" symbol="webkit_dom_document_get_body">
				<return-type type="WebKitDOMHTMLElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_character_set" symbol="webkit_dom_document_get_character_set">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_charset" symbol="webkit_dom_document_get_charset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_compat_mode" symbol="webkit_dom_document_get_compat_mode">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_cookie" symbol="webkit_dom_document_get_cookie">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_current_script" symbol="webkit_dom_document_get_current_script">
				<return-type type="WebKitDOMHTMLScriptElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_default_charset" symbol="webkit_dom_document_get_default_charset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_default_view" symbol="webkit_dom_document_get_default_view">
				<return-type type="WebKitDOMDOMWindow*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_doctype" symbol="webkit_dom_document_get_doctype">
				<return-type type="WebKitDOMDocumentType*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_document_element" symbol="webkit_dom_document_get_document_element">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_document_uri" symbol="webkit_dom_document_get_document_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_domain" symbol="webkit_dom_document_get_domain">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_element_by_id" symbol="webkit_dom_document_get_element_by_id">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="elementId" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_elements_by_class_name" symbol="webkit_dom_document_get_elements_by_class_name">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="tagname" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_elements_by_name" symbol="webkit_dom_document_get_elements_by_name">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="elementName" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_elements_by_tag_name" symbol="webkit_dom_document_get_elements_by_tag_name">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="tagname" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_elements_by_tag_name_ns" symbol="webkit_dom_document_get_elements_by_tag_name_ns">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="localName" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_forms" symbol="webkit_dom_document_get_forms">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_head" symbol="webkit_dom_document_get_head">
				<return-type type="WebKitDOMHTMLHeadElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_hidden" symbol="webkit_dom_document_get_hidden">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_images" symbol="webkit_dom_document_get_images">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_implementation" symbol="webkit_dom_document_get_implementation">
				<return-type type="WebKitDOMDOMImplementation*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_input_encoding" symbol="webkit_dom_document_get_input_encoding">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_last_modified" symbol="webkit_dom_document_get_last_modified">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_links" symbol="webkit_dom_document_get_links">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_override_style" symbol="webkit_dom_document_get_override_style">
				<return-type type="WebKitDOMCSSStyleDeclaration*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="element" type="WebKitDOMElement*"/>
					<parameter name="pseudoElement" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_preferred_stylesheet_set" symbol="webkit_dom_document_get_preferred_stylesheet_set">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_ready_state" symbol="webkit_dom_document_get_ready_state">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_referrer" symbol="webkit_dom_document_get_referrer">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_security_policy" symbol="webkit_dom_document_get_security_policy">
				<return-type type="WebKitDOMDOMSecurityPolicy*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_selected_stylesheet_set" symbol="webkit_dom_document_get_selected_stylesheet_set">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_style_sheets" symbol="webkit_dom_document_get_style_sheets">
				<return-type type="WebKitDOMStyleSheetList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="webkit_dom_document_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_url" symbol="webkit_dom_document_get_url">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_visibility_state" symbol="webkit_dom_document_get_visibility_state">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_webkit_current_full_screen_element" symbol="webkit_dom_document_get_webkit_current_full_screen_element">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_webkit_full_screen_keyboard_input_allowed" symbol="webkit_dom_document_get_webkit_full_screen_keyboard_input_allowed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_webkit_fullscreen_element" symbol="webkit_dom_document_get_webkit_fullscreen_element">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_webkit_fullscreen_enabled" symbol="webkit_dom_document_get_webkit_fullscreen_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_webkit_hidden" symbol="webkit_dom_document_get_webkit_hidden">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_webkit_is_full_screen" symbol="webkit_dom_document_get_webkit_is_full_screen">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_webkit_pointer_lock_element" symbol="webkit_dom_document_get_webkit_pointer_lock_element">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_webkit_visibility_state" symbol="webkit_dom_document_get_webkit_visibility_state">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_xml_encoding" symbol="webkit_dom_document_get_xml_encoding">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_xml_standalone" symbol="webkit_dom_document_get_xml_standalone">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="get_xml_version" symbol="webkit_dom_document_get_xml_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="import_node" symbol="webkit_dom_document_import_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="importedNode" type="WebKitDOMNode*"/>
					<parameter name="deep" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_command_enabled" symbol="webkit_dom_document_query_command_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="command" type="gchar*"/>
				</parameters>
			</method>
			<method name="query_command_indeterm" symbol="webkit_dom_document_query_command_indeterm">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="command" type="gchar*"/>
				</parameters>
			</method>
			<method name="query_command_state" symbol="webkit_dom_document_query_command_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="command" type="gchar*"/>
				</parameters>
			</method>
			<method name="query_command_supported" symbol="webkit_dom_document_query_command_supported">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="command" type="gchar*"/>
				</parameters>
			</method>
			<method name="query_command_value" symbol="webkit_dom_document_query_command_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="command" type="gchar*"/>
				</parameters>
			</method>
			<method name="query_selector" symbol="webkit_dom_document_query_selector">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="selectors" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_selector_all" symbol="webkit_dom_document_query_selector_all">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="selectors" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_body" symbol="webkit_dom_document_set_body">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="value" type="WebKitDOMHTMLElement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_charset" symbol="webkit_dom_document_set_charset">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_cookie" symbol="webkit_dom_document_set_cookie">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_document_uri" symbol="webkit_dom_document_set_document_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_selected_stylesheet_set" symbol="webkit_dom_document_set_selected_stylesheet_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_title" symbol="webkit_dom_document_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_xml_standalone" symbol="webkit_dom_document_set_xml_standalone">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="value" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_xml_version" symbol="webkit_dom_document_set_xml_version">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="webkit_cancel_full_screen" symbol="webkit_dom_document_webkit_cancel_full_screen">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="webkit_exit_fullscreen" symbol="webkit_dom_document_webkit_exit_fullscreen">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="webkit_exit_pointer_lock" symbol="webkit_dom_document_webkit_exit_pointer_lock">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<method name="webkit_get_named_flows" symbol="webkit_dom_document_webkit_get_named_flows">
				<return-type type="WebKitDOMDOMNamedFlowCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocument*"/>
				</parameters>
			</method>
			<property name="anchors" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="applets" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="body" type="WebKitDOMHTMLElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="character-set" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="charset" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="compat-mode" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="cookie" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="current-script" type="WebKitDOMHTMLScriptElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="default-charset" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="default-view" type="WebKitDOMDOMWindow*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="doctype" type="WebKitDOMDocumentType*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="document-element" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="document-uri" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="domain" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="forms" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="head" type="WebKitDOMHTMLHeadElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="hidden" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="images" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="implementation" type="WebKitDOMDOMImplementation*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="input-encoding" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="last-modified" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="links" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="preferred-stylesheet-set" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="ready-state" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="referrer" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="security-policy" type="WebKitDOMDOMSecurityPolicy*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="selected-stylesheet-set" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="style-sheets" type="WebKitDOMStyleSheetList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="url" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="visibility-state" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-current-full-screen-element" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-full-screen-keyboard-input-allowed" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-fullscreen-element" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-fullscreen-enabled" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-is-full-screen" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-pointer-lock-element" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="xml-encoding" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="xml-standalone" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="xml-version" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMDocumentFragment" parent="WebKitDOMNode" type-name="WebKitDOMDocumentFragment" get-type="webkit_dom_document_fragment_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="query_selector" symbol="webkit_dom_document_fragment_query_selector">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocumentFragment*"/>
					<parameter name="selectors" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_selector_all" symbol="webkit_dom_document_fragment_query_selector_all">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocumentFragment*"/>
					<parameter name="selectors" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</object>
		<object name="WebKitDOMDocumentType" parent="WebKitDOMNode" type-name="WebKitDOMDocumentType" get-type="webkit_dom_document_type_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_entities" symbol="webkit_dom_document_type_get_entities">
				<return-type type="WebKitDOMNamedNodeMap*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocumentType*"/>
				</parameters>
			</method>
			<method name="get_internal_subset" symbol="webkit_dom_document_type_get_internal_subset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocumentType*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_document_type_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocumentType*"/>
				</parameters>
			</method>
			<method name="get_notations" symbol="webkit_dom_document_type_get_notations">
				<return-type type="WebKitDOMNamedNodeMap*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocumentType*"/>
				</parameters>
			</method>
			<method name="get_public_id" symbol="webkit_dom_document_type_get_public_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocumentType*"/>
				</parameters>
			</method>
			<method name="get_system_id" symbol="webkit_dom_document_type_get_system_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocumentType*"/>
				</parameters>
			</method>
			<method name="remove" symbol="webkit_dom_document_type_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMDocumentType*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="entities" type="WebKitDOMNamedNodeMap*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="internal-subset" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="notations" type="WebKitDOMNamedNodeMap*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="public-id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="system-id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMElement" parent="WebKitDOMNode" type-name="WebKitDOMElement" get-type="webkit_dom_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="blur" symbol="webkit_dom_element_blur">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="focus" symbol="webkit_dom_element_focus">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_attribute" symbol="webkit_dom_element_get_attribute">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_attribute_node" symbol="webkit_dom_element_get_attribute_node">
				<return-type type="WebKitDOMAttr*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_attribute_node_ns" symbol="webkit_dom_element_get_attribute_node_ns">
				<return-type type="WebKitDOMAttr*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="localName" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_attribute_ns" symbol="webkit_dom_element_get_attribute_ns">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="localName" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_attributes" symbol="webkit_dom_element_get_attributes">
				<return-type type="WebKitDOMNamedNodeMap*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_child_element_count" symbol="webkit_dom_element_get_child_element_count">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_class_list" symbol="webkit_dom_element_get_class_list">
				<return-type type="WebKitDOMDOMTokenList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_class_name" symbol="webkit_dom_element_get_class_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_client_height" symbol="webkit_dom_element_get_client_height">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_client_left" symbol="webkit_dom_element_get_client_left">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_client_top" symbol="webkit_dom_element_get_client_top">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_client_width" symbol="webkit_dom_element_get_client_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_elements_by_class_name" symbol="webkit_dom_element_get_elements_by_class_name">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_elements_by_tag_name" symbol="webkit_dom_element_get_elements_by_tag_name">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_elements_by_tag_name_ns" symbol="webkit_dom_element_get_elements_by_tag_name_ns">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="localName" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_first_element_child" symbol="webkit_dom_element_get_first_element_child">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="webkit_dom_element_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_last_element_child" symbol="webkit_dom_element_get_last_element_child">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_next_element_sibling" symbol="webkit_dom_element_get_next_element_sibling">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_offset_height" symbol="webkit_dom_element_get_offset_height">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_offset_left" symbol="webkit_dom_element_get_offset_left">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_offset_parent" symbol="webkit_dom_element_get_offset_parent">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_offset_top" symbol="webkit_dom_element_get_offset_top">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_offset_width" symbol="webkit_dom_element_get_offset_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_previous_element_sibling" symbol="webkit_dom_element_get_previous_element_sibling">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_scroll_height" symbol="webkit_dom_element_get_scroll_height">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_scroll_left" symbol="webkit_dom_element_get_scroll_left">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_scroll_top" symbol="webkit_dom_element_get_scroll_top">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_scroll_width" symbol="webkit_dom_element_get_scroll_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_style" symbol="webkit_dom_element_get_style">
				<return-type type="WebKitDOMCSSStyleDeclaration*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_tag_name" symbol="webkit_dom_element_get_tag_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_region_overflow" symbol="webkit_dom_element_get_webkit_region_overflow">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="element" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_region_overset" symbol="webkit_dom_element_get_webkit_region_overset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="has_attribute" symbol="webkit_dom_element_has_attribute">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="has_attribute_ns" symbol="webkit_dom_element_has_attribute_ns">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="localName" type="gchar*"/>
				</parameters>
			</method>
			<method name="has_attributes" symbol="webkit_dom_element_has_attributes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="query_selector" symbol="webkit_dom_element_query_selector">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="selectors" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_selector_all" symbol="webkit_dom_element_query_selector_all">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="selectors" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="remove" symbol="webkit_dom_element_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="remove_attribute" symbol="webkit_dom_element_remove_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove_attribute_node" symbol="webkit_dom_element_remove_attribute_node">
				<return-type type="WebKitDOMAttr*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="oldAttr" type="WebKitDOMAttr*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="remove_attribute_ns" symbol="webkit_dom_element_remove_attribute_ns">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="localName" type="gchar*"/>
				</parameters>
			</method>
			<method name="scroll_by_lines" symbol="webkit_dom_element_scroll_by_lines">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="lines" type="glong"/>
				</parameters>
			</method>
			<method name="scroll_by_pages" symbol="webkit_dom_element_scroll_by_pages">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="pages" type="glong"/>
				</parameters>
			</method>
			<method name="scroll_into_view" symbol="webkit_dom_element_scroll_into_view">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="alignWithTop" type="gboolean"/>
				</parameters>
			</method>
			<method name="scroll_into_view_if_needed" symbol="webkit_dom_element_scroll_into_view_if_needed">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="centerIfNeeded" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_attribute" symbol="webkit_dom_element_set_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_node" symbol="webkit_dom_element_set_attribute_node">
				<return-type type="WebKitDOMAttr*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="newAttr" type="WebKitDOMAttr*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_node_ns" symbol="webkit_dom_element_set_attribute_node_ns">
				<return-type type="WebKitDOMAttr*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="newAttr" type="WebKitDOMAttr*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_ns" symbol="webkit_dom_element_set_attribute_ns">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="qualifiedName" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_class_name" symbol="webkit_dom_element_set_class_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_id" symbol="webkit_dom_element_set_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_scroll_left" symbol="webkit_dom_element_set_scroll_left">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_scroll_top" symbol="webkit_dom_element_set_scroll_top">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="webkit_matches_selector" symbol="webkit_dom_element_webkit_matches_selector">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="selectors" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="webkit_request_full_screen" symbol="webkit_dom_element_webkit_request_full_screen">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
					<parameter name="flags" type="gushort"/>
				</parameters>
			</method>
			<method name="webkit_request_fullscreen" symbol="webkit_dom_element_webkit_request_fullscreen">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<method name="webkit_request_pointer_lock" symbol="webkit_dom_element_webkit_request_pointer_lock">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMElement*"/>
				</parameters>
			</method>
			<property name="attributes" type="WebKitDOMNamedNodeMap*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="child-element-count" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="class-list" type="WebKitDOMDOMTokenList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="class-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="client-height" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="client-left" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="client-top" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="client-width" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="first-element-child" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="id" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="last-element-child" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="next-element-sibling" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="offset-height" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="offset-left" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="offset-parent" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="offset-top" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="offset-width" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="previous-element-sibling" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="scroll-height" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="scroll-left" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scroll-top" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scroll-width" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="style" type="WebKitDOMCSSStyleDeclaration*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="tag-name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-region-overset" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMEntityReference" parent="WebKitDOMNode" type-name="WebKitDOMEntityReference" get-type="webkit_dom_entity_reference_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
		</object>
		<object name="WebKitDOMEvent" parent="WebKitDOMObject" type-name="WebKitDOMEvent" get-type="webkit_dom_event_get_type">
			<method name="get_bubbles" symbol="webkit_dom_event_get_bubbles">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<method name="get_cancel_bubble" symbol="webkit_dom_event_get_cancel_bubble">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<method name="get_cancelable" symbol="webkit_dom_event_get_cancelable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<method name="get_current_target" symbol="webkit_dom_event_get_current_target">
				<return-type type="WebKitDOMEventTarget*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<method name="get_default_prevented" symbol="webkit_dom_event_get_default_prevented">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<method name="get_event_phase" symbol="webkit_dom_event_get_event_phase">
				<return-type type="gushort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<method name="get_return_value" symbol="webkit_dom_event_get_return_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<method name="get_src_element" symbol="webkit_dom_event_get_src_element">
				<return-type type="WebKitDOMEventTarget*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<method name="get_target" symbol="webkit_dom_event_get_target">
				<return-type type="WebKitDOMEventTarget*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<method name="get_time_stamp" symbol="webkit_dom_event_get_time_stamp">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<method name="init_event" symbol="webkit_dom_event_init_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
					<parameter name="eventTypeArg" type="gchar*"/>
					<parameter name="canBubbleArg" type="gboolean"/>
					<parameter name="cancelableArg" type="gboolean"/>
				</parameters>
			</method>
			<method name="prevent_default" symbol="webkit_dom_event_prevent_default">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<method name="set_cancel_bubble" symbol="webkit_dom_event_set_cancel_bubble">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_return_value" symbol="webkit_dom_event_set_return_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="stop_immediate_propagation" symbol="webkit_dom_event_stop_immediate_propagation">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<method name="stop_propagation" symbol="webkit_dom_event_stop_propagation">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMEvent*"/>
				</parameters>
			</method>
			<property name="bubbles" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="cancel-bubble" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="cancelable" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="current-target" type="WebKitDOMEventTarget*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="default-prevented" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="event-phase" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="return-value" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="src-element" type="WebKitDOMEventTarget*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="target" type="WebKitDOMEventTarget*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="time-stamp" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMFile" parent="WebKitDOMBlob" type-name="WebKitDOMFile" get-type="webkit_dom_file_get_type">
			<method name="get_name" symbol="webkit_dom_file_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMFile*"/>
				</parameters>
			</method>
			<method name="get_webkit_relative_path" symbol="webkit_dom_file_get_webkit_relative_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMFile*"/>
				</parameters>
			</method>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-relative-path" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMFileList" parent="WebKitDOMObject" type-name="WebKitDOMFileList" get-type="webkit_dom_file_list_get_type">
			<method name="get_length" symbol="webkit_dom_file_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMFileList*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_file_list_item">
				<return-type type="WebKitDOMFile*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMFileList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMGamepad" parent="WebKitDOMObject" type-name="WebKitDOMGamepad" get-type="webkit_dom_gamepad_get_type">
			<method name="get_id" symbol="webkit_dom_gamepad_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMGamepad*"/>
				</parameters>
			</method>
			<method name="get_index" symbol="webkit_dom_gamepad_get_index">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMGamepad*"/>
				</parameters>
			</method>
			<method name="get_timestamp" symbol="webkit_dom_gamepad_get_timestamp">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMGamepad*"/>
				</parameters>
			</method>
			<property name="id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="index" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="timestamp" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMGamepadList" parent="WebKitDOMObject" type-name="WebKitDOMGamepadList" get-type="webkit_dom_gamepad_list_get_type">
			<method name="get_length" symbol="webkit_dom_gamepad_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMGamepadList*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_gamepad_list_item">
				<return-type type="WebKitDOMGamepad*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMGamepadList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMGeolocation" parent="WebKitDOMObject" type-name="WebKitDOMGeolocation" get-type="webkit_dom_geolocation_get_type">
			<method name="clear_watch" symbol="webkit_dom_geolocation_clear_watch">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMGeolocation*"/>
					<parameter name="watchID" type="glong"/>
				</parameters>
			</method>
		</object>
		<object name="WebKitDOMHTMLAnchorElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLAnchorElement" get-type="webkit_dom_html_anchor_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_charset" symbol="webkit_dom_html_anchor_element_get_charset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_coords" symbol="webkit_dom_html_anchor_element_get_coords">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_download" symbol="webkit_dom_html_anchor_element_get_download">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_hash" symbol="webkit_dom_html_anchor_element_get_hash">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_host" symbol="webkit_dom_html_anchor_element_get_host">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_hostname" symbol="webkit_dom_html_anchor_element_get_hostname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_href" symbol="webkit_dom_html_anchor_element_get_href">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_hreflang" symbol="webkit_dom_html_anchor_element_get_hreflang">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_anchor_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_origin" symbol="webkit_dom_html_anchor_element_get_origin">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_pathname" symbol="webkit_dom_html_anchor_element_get_pathname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_ping" symbol="webkit_dom_html_anchor_element_get_ping">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="webkit_dom_html_anchor_element_get_port">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="webkit_dom_html_anchor_element_get_protocol">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_rel" symbol="webkit_dom_html_anchor_element_get_rel">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_rev" symbol="webkit_dom_html_anchor_element_get_rev">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_search" symbol="webkit_dom_html_anchor_element_get_search">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_shape" symbol="webkit_dom_html_anchor_element_get_shape">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_target" symbol="webkit_dom_html_anchor_element_get_target">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="webkit_dom_html_anchor_element_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
				</parameters>
			</method>
			<method name="set_charset" symbol="webkit_dom_html_anchor_element_set_charset">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_coords" symbol="webkit_dom_html_anchor_element_set_coords">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_download" symbol="webkit_dom_html_anchor_element_set_download">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_hash" symbol="webkit_dom_html_anchor_element_set_hash">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_host" symbol="webkit_dom_html_anchor_element_set_host">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_hostname" symbol="webkit_dom_html_anchor_element_set_hostname">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_href" symbol="webkit_dom_html_anchor_element_set_href">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_hreflang" symbol="webkit_dom_html_anchor_element_set_hreflang">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_anchor_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_pathname" symbol="webkit_dom_html_anchor_element_set_pathname">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_ping" symbol="webkit_dom_html_anchor_element_set_ping">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_port" symbol="webkit_dom_html_anchor_element_set_port">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_protocol" symbol="webkit_dom_html_anchor_element_set_protocol">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_rel" symbol="webkit_dom_html_anchor_element_set_rel">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_rev" symbol="webkit_dom_html_anchor_element_set_rev">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_search" symbol="webkit_dom_html_anchor_element_set_search">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_shape" symbol="webkit_dom_html_anchor_element_set_shape">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_target" symbol="webkit_dom_html_anchor_element_set_target">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAnchorElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="charset" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="coords" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="download" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="hash" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="host" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="hostname" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="href" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="hreflang" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="origin" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="pathname" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ping" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="port" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="protocol" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rel" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rev" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="search" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="shape" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="target" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLAppletElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLAppletElement" get-type="webkit_dom_html_applet_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_align" symbol="webkit_dom_html_applet_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
				</parameters>
			</method>
			<method name="get_alt" symbol="webkit_dom_html_applet_element_get_alt">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
				</parameters>
			</method>
			<method name="get_archive" symbol="webkit_dom_html_applet_element_get_archive">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
				</parameters>
			</method>
			<method name="get_code" symbol="webkit_dom_html_applet_element_get_code">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
				</parameters>
			</method>
			<method name="get_code_base" symbol="webkit_dom_html_applet_element_get_code_base">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="webkit_dom_html_applet_element_get_height">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
				</parameters>
			</method>
			<method name="get_hspace" symbol="webkit_dom_html_applet_element_get_hspace">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_applet_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
				</parameters>
			</method>
			<method name="get_object" symbol="webkit_dom_html_applet_element_get_object">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
				</parameters>
			</method>
			<method name="get_vspace" symbol="webkit_dom_html_applet_element_get_vspace">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_applet_element_get_width">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_applet_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_alt" symbol="webkit_dom_html_applet_element_set_alt">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_archive" symbol="webkit_dom_html_applet_element_set_archive">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_code" symbol="webkit_dom_html_applet_element_set_code">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_code_base" symbol="webkit_dom_html_applet_element_set_code_base">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_height" symbol="webkit_dom_html_applet_element_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_hspace" symbol="webkit_dom_html_applet_element_set_hspace">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_applet_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_object" symbol="webkit_dom_html_applet_element_set_object">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_vspace" symbol="webkit_dom_html_applet_element_set_vspace">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_applet_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAppletElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="alt" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="archive" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="code" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="code-base" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="hspace" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="object" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vspace" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLAreaElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLAreaElement" get-type="webkit_dom_html_area_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_alt" symbol="webkit_dom_html_area_element_get_alt">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_coords" symbol="webkit_dom_html_area_element_get_coords">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_hash" symbol="webkit_dom_html_area_element_get_hash">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_host" symbol="webkit_dom_html_area_element_get_host">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_hostname" symbol="webkit_dom_html_area_element_get_hostname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_href" symbol="webkit_dom_html_area_element_get_href">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_no_href" symbol="webkit_dom_html_area_element_get_no_href">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_pathname" symbol="webkit_dom_html_area_element_get_pathname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_ping" symbol="webkit_dom_html_area_element_get_ping">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="webkit_dom_html_area_element_get_port">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="webkit_dom_html_area_element_get_protocol">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_search" symbol="webkit_dom_html_area_element_get_search">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_shape" symbol="webkit_dom_html_area_element_get_shape">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="get_target" symbol="webkit_dom_html_area_element_get_target">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
				</parameters>
			</method>
			<method name="set_alt" symbol="webkit_dom_html_area_element_set_alt">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_coords" symbol="webkit_dom_html_area_element_set_coords">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_href" symbol="webkit_dom_html_area_element_set_href">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_no_href" symbol="webkit_dom_html_area_element_set_no_href">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_ping" symbol="webkit_dom_html_area_element_set_ping">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_shape" symbol="webkit_dom_html_area_element_set_shape">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_target" symbol="webkit_dom_html_area_element_set_target">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="alt" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="coords" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="hash" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="host" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="hostname" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="href" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="no-href" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pathname" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="ping" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="port" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="protocol" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="search" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="shape" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="target" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLAudioElement" parent="WebKitDOMHTMLMediaElement" type-name="WebKitDOMHTMLAudioElement" get-type="webkit_dom_html_audio_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
		</object>
		<object name="WebKitDOMHTMLBRElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLBRElement" get-type="webkit_dom_htmlbr_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_clear" symbol="webkit_dom_htmlbr_element_get_clear">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBRElement*"/>
				</parameters>
			</method>
			<method name="set_clear" symbol="webkit_dom_htmlbr_element_set_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBRElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="clear" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLBaseElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLBaseElement" get-type="webkit_dom_html_base_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_href" symbol="webkit_dom_html_base_element_get_href">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBaseElement*"/>
				</parameters>
			</method>
			<method name="get_target" symbol="webkit_dom_html_base_element_get_target">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBaseElement*"/>
				</parameters>
			</method>
			<method name="set_href" symbol="webkit_dom_html_base_element_set_href">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBaseElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_target" symbol="webkit_dom_html_base_element_set_target">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBaseElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="href" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="target" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLBaseFontElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLBaseFontElement" get-type="webkit_dom_html_base_font_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_color" symbol="webkit_dom_html_base_font_element_get_color">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBaseFontElement*"/>
				</parameters>
			</method>
			<method name="get_face" symbol="webkit_dom_html_base_font_element_get_face">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBaseFontElement*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="webkit_dom_html_base_font_element_get_size">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBaseFontElement*"/>
				</parameters>
			</method>
			<method name="set_color" symbol="webkit_dom_html_base_font_element_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBaseFontElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_face" symbol="webkit_dom_html_base_font_element_set_face">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBaseFontElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_size" symbol="webkit_dom_html_base_font_element_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBaseFontElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<property name="color" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="face" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="size" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLBodyElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLBodyElement" get-type="webkit_dom_html_body_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_a_link" symbol="webkit_dom_html_body_element_get_a_link">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBodyElement*"/>
				</parameters>
			</method>
			<method name="get_background" symbol="webkit_dom_html_body_element_get_background">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBodyElement*"/>
				</parameters>
			</method>
			<method name="get_bg_color" symbol="webkit_dom_html_body_element_get_bg_color">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBodyElement*"/>
				</parameters>
			</method>
			<method name="get_link" symbol="webkit_dom_html_body_element_get_link">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBodyElement*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="webkit_dom_html_body_element_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBodyElement*"/>
				</parameters>
			</method>
			<method name="get_v_link" symbol="webkit_dom_html_body_element_get_v_link">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBodyElement*"/>
				</parameters>
			</method>
			<method name="set_a_link" symbol="webkit_dom_html_body_element_set_a_link">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBodyElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_background" symbol="webkit_dom_html_body_element_set_background">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBodyElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_bg_color" symbol="webkit_dom_html_body_element_set_bg_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBodyElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_link" symbol="webkit_dom_html_body_element_set_link">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBodyElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_text" symbol="webkit_dom_html_body_element_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBodyElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_v_link" symbol="webkit_dom_html_body_element_set_v_link">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLBodyElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="a-link" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="background" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="bg-color" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="link" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="v-link" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLButtonElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLButtonElement" get-type="webkit_dom_html_button_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="check_validity" symbol="webkit_dom_html_button_element_check_validity">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_autofocus" symbol="webkit_dom_html_button_element_get_autofocus">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_disabled" symbol="webkit_dom_html_button_element_get_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_form" symbol="webkit_dom_html_button_element_get_form">
				<return-type type="WebKitDOMHTMLFormElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_form_action" symbol="webkit_dom_html_button_element_get_form_action">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_form_enctype" symbol="webkit_dom_html_button_element_get_form_enctype">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_form_method" symbol="webkit_dom_html_button_element_get_form_method">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_form_no_validate" symbol="webkit_dom_html_button_element_get_form_no_validate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_form_target" symbol="webkit_dom_html_button_element_get_form_target">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_labels" symbol="webkit_dom_html_button_element_get_labels">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_button_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_validation_message" symbol="webkit_dom_html_button_element_get_validation_message">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_validity" symbol="webkit_dom_html_button_element_get_validity">
				<return-type type="WebKitDOMValidityState*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="webkit_dom_html_button_element_get_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="get_will_validate" symbol="webkit_dom_html_button_element_get_will_validate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
				</parameters>
			</method>
			<method name="set_autofocus" symbol="webkit_dom_html_button_element_set_autofocus">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_custom_validity" symbol="webkit_dom_html_button_element_set_custom_validity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
					<parameter name="error" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="webkit_dom_html_button_element_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_form_action" symbol="webkit_dom_html_button_element_set_form_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_form_enctype" symbol="webkit_dom_html_button_element_set_form_enctype">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_form_method" symbol="webkit_dom_html_button_element_set_form_method">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_form_no_validate" symbol="webkit_dom_html_button_element_set_form_no_validate">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_form_target" symbol="webkit_dom_html_button_element_set_form_target">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_button_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_value" symbol="webkit_dom_html_button_element_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLButtonElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="autofocus" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form" type="WebKitDOMHTMLFormElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="form-action" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form-enctype" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form-method" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form-no-validate" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form-target" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="labels" type="WebKitDOMNodeList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="validation-message" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="validity" type="WebKitDOMValidityState*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="will-validate" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLCanvasElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLCanvasElement" get-type="webkit_dom_html_canvas_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_height" symbol="webkit_dom_html_canvas_element_get_height">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLCanvasElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_canvas_element_get_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLCanvasElement*"/>
				</parameters>
			</method>
			<method name="set_height" symbol="webkit_dom_html_canvas_element_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLCanvasElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_canvas_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLCanvasElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<property name="height" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLCollection" parent="WebKitDOMObject" type-name="WebKitDOMHTMLCollection" get-type="webkit_dom_html_collection_get_type">
			<method name="get_length" symbol="webkit_dom_html_collection_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLCollection*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_html_collection_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLCollection*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<method name="named_item" symbol="webkit_dom_html_collection_named_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLCollection*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLDListElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLDListElement" get-type="webkit_dom_htmld_list_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_compact" symbol="webkit_dom_htmld_list_element_get_compact">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDListElement*"/>
				</parameters>
			</method>
			<method name="set_compact" symbol="webkit_dom_htmld_list_element_set_compact">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDListElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="compact" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLDetailsElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLDetailsElement" get-type="webkit_dom_html_details_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_open" symbol="webkit_dom_html_details_element_get_open">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDetailsElement*"/>
				</parameters>
			</method>
			<method name="set_open" symbol="webkit_dom_html_details_element_set_open">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDetailsElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="open" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLDirectoryElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLDirectoryElement" get-type="webkit_dom_html_directory_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_compact" symbol="webkit_dom_html_directory_element_get_compact">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDirectoryElement*"/>
				</parameters>
			</method>
			<method name="set_compact" symbol="webkit_dom_html_directory_element_set_compact">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDirectoryElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="compact" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLDivElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLDivElement" get-type="webkit_dom_html_div_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_align" symbol="webkit_dom_html_div_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDivElement*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_div_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDivElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLDocument" parent="WebKitDOMDocument" type-name="WebKitDOMHTMLDocument" get-type="webkit_dom_html_document_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="capture_events" symbol="webkit_dom_html_document_capture_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="clear" symbol="webkit_dom_html_document_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="close" symbol="webkit_dom_html_document_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_active_element" symbol="webkit_dom_html_document_get_active_element">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_alink_color" symbol="webkit_dom_html_document_get_alink_color">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_bg_color" symbol="webkit_dom_html_document_get_bg_color">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_compat_mode" symbol="webkit_dom_html_document_get_compat_mode">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_design_mode" symbol="webkit_dom_html_document_get_design_mode">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_dir" symbol="webkit_dom_html_document_get_dir">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_embeds" symbol="webkit_dom_html_document_get_embeds">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_fg_color" symbol="webkit_dom_html_document_get_fg_color">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="webkit_dom_html_document_get_height">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_link_color" symbol="webkit_dom_html_document_get_link_color">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_plugins" symbol="webkit_dom_html_document_get_plugins">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_scripts" symbol="webkit_dom_html_document_get_scripts">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_vlink_color" symbol="webkit_dom_html_document_get_vlink_color">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_document_get_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="has_focus" symbol="webkit_dom_html_document_has_focus">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="open" symbol="webkit_dom_html_document_open">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="release_events" symbol="webkit_dom_html_document_release_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
				</parameters>
			</method>
			<method name="set_alink_color" symbol="webkit_dom_html_document_set_alink_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_bg_color" symbol="webkit_dom_html_document_set_bg_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_design_mode" symbol="webkit_dom_html_document_set_design_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_dir" symbol="webkit_dom_html_document_set_dir">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_fg_color" symbol="webkit_dom_html_document_set_fg_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_link_color" symbol="webkit_dom_html_document_set_link_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_vlink_color" symbol="webkit_dom_html_document_set_vlink_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLDocument*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="active-element" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="alink-color" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="bg-color" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="compat-mode" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="design-mode" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="dir" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="embeds" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="fg-color" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="link-color" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="plugins" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="scripts" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="vlink-color" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLElement" parent="WebKitDOMElement" type-name="WebKitDOMHTMLElement" get-type="webkit_dom_html_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="click" symbol="webkit_dom_html_element_click">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_access_key" symbol="webkit_dom_html_element_get_access_key">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_children" symbol="webkit_dom_html_element_get_children">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_class_list" symbol="webkit_dom_html_element_get_class_list">
				<return-type type="WebKitDOMDOMTokenList*"/>
				<parameters>
					<parameter name="element" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_class_name" symbol="webkit_dom_html_element_get_class_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="element" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_content_editable" symbol="webkit_dom_html_element_get_content_editable">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_dir" symbol="webkit_dom_html_element_get_dir">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_draggable" symbol="webkit_dom_html_element_get_draggable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_hidden" symbol="webkit_dom_html_element_get_hidden">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="webkit_dom_html_element_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_inner_html" symbol="webkit_dom_html_element_get_inner_html">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_inner_text" symbol="webkit_dom_html_element_get_inner_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_is_content_editable" symbol="webkit_dom_html_element_get_is_content_editable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_item_id" symbol="webkit_dom_html_element_get_item_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_item_prop" symbol="webkit_dom_html_element_get_item_prop">
				<return-type type="WebKitDOMDOMSettableTokenList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_item_ref" symbol="webkit_dom_html_element_get_item_ref">
				<return-type type="WebKitDOMDOMSettableTokenList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_item_scope" symbol="webkit_dom_html_element_get_item_scope">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_item_type" symbol="webkit_dom_html_element_get_item_type">
				<return-type type="void*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_lang" symbol="webkit_dom_html_element_get_lang">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_outer_html" symbol="webkit_dom_html_element_get_outer_html">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_outer_text" symbol="webkit_dom_html_element_get_outer_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_spellcheck" symbol="webkit_dom_html_element_get_spellcheck">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_tab_index" symbol="webkit_dom_html_element_get_tab_index">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="webkit_dom_html_element_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_translate" symbol="webkit_dom_html_element_get_translate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="get_webkitdropzone" symbol="webkit_dom_html_element_get_webkitdropzone">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</method>
			<method name="insert_adjacent_element" symbol="webkit_dom_html_element_insert_adjacent_element">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="where" type="gchar*"/>
					<parameter name="element" type="WebKitDOMElement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="insert_adjacent_html" symbol="webkit_dom_html_element_insert_adjacent_html">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="where" type="gchar*"/>
					<parameter name="html" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="insert_adjacent_text" symbol="webkit_dom_html_element_insert_adjacent_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="where" type="gchar*"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_access_key" symbol="webkit_dom_html_element_set_access_key">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_class_name" symbol="webkit_dom_html_element_set_class_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="element" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_content_editable" symbol="webkit_dom_html_element_set_content_editable">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_dir" symbol="webkit_dom_html_element_set_dir">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_draggable" symbol="webkit_dom_html_element_set_draggable">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_hidden" symbol="webkit_dom_html_element_set_hidden">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_id" symbol="webkit_dom_html_element_set_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_inner_html" symbol="webkit_dom_html_element_set_inner_html">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_inner_text" symbol="webkit_dom_html_element_set_inner_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_item_id" symbol="webkit_dom_html_element_set_item_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_item_scope" symbol="webkit_dom_html_element_set_item_scope">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_lang" symbol="webkit_dom_html_element_set_lang">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_outer_html" symbol="webkit_dom_html_element_set_outer_html">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_outer_text" symbol="webkit_dom_html_element_set_outer_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_spellcheck" symbol="webkit_dom_html_element_set_spellcheck">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_tab_index" symbol="webkit_dom_html_element_set_tab_index">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_title" symbol="webkit_dom_html_element_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_translate" symbol="webkit_dom_html_element_set_translate">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_webkitdropzone" symbol="webkit_dom_html_element_set_webkitdropzone">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="access-key" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="children" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="content-editable" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="dir" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="draggable" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="hidden" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="inner-html" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="inner-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-content-editable" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="lang" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="outer-html" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="outer-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="spellcheck" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="tab-index" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="translate" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="webkitdropzone" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLEmbedElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLEmbedElement" get-type="webkit_dom_html_embed_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_align" symbol="webkit_dom_html_embed_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLEmbedElement*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="webkit_dom_html_embed_element_get_height">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLEmbedElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_embed_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLEmbedElement*"/>
				</parameters>
			</method>
			<method name="get_src" symbol="webkit_dom_html_embed_element_get_src">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLEmbedElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_embed_element_get_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLEmbedElement*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_embed_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLEmbedElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_height" symbol="webkit_dom_html_embed_element_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLEmbedElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_embed_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLEmbedElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_src" symbol="webkit_dom_html_embed_element_set_src">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLEmbedElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_embed_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLEmbedElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="src" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLFieldSetElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLFieldSetElement" get-type="webkit_dom_html_field_set_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="check_validity" symbol="webkit_dom_html_field_set_element_check_validity">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFieldSetElement*"/>
				</parameters>
			</method>
			<method name="get_disabled" symbol="webkit_dom_html_field_set_element_get_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFieldSetElement*"/>
				</parameters>
			</method>
			<method name="get_elements" symbol="webkit_dom_html_field_set_element_get_elements">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFieldSetElement*"/>
				</parameters>
			</method>
			<method name="get_form" symbol="webkit_dom_html_field_set_element_get_form">
				<return-type type="WebKitDOMHTMLFormElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFieldSetElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_field_set_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFieldSetElement*"/>
				</parameters>
			</method>
			<method name="get_validation_message" symbol="webkit_dom_html_field_set_element_get_validation_message">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFieldSetElement*"/>
				</parameters>
			</method>
			<method name="get_validity" symbol="webkit_dom_html_field_set_element_get_validity">
				<return-type type="WebKitDOMValidityState*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFieldSetElement*"/>
				</parameters>
			</method>
			<method name="get_will_validate" symbol="webkit_dom_html_field_set_element_get_will_validate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFieldSetElement*"/>
				</parameters>
			</method>
			<method name="set_custom_validity" symbol="webkit_dom_html_field_set_element_set_custom_validity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFieldSetElement*"/>
					<parameter name="error" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="webkit_dom_html_field_set_element_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFieldSetElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_field_set_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFieldSetElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="elements" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="form" type="WebKitDOMHTMLFormElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="validation-message" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="validity" type="WebKitDOMValidityState*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="will-validate" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLFontElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLFontElement" get-type="webkit_dom_html_font_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_color" symbol="webkit_dom_html_font_element_get_color">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFontElement*"/>
				</parameters>
			</method>
			<method name="get_face" symbol="webkit_dom_html_font_element_get_face">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFontElement*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="webkit_dom_html_font_element_get_size">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFontElement*"/>
				</parameters>
			</method>
			<method name="set_color" symbol="webkit_dom_html_font_element_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFontElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_face" symbol="webkit_dom_html_font_element_set_face">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFontElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_size" symbol="webkit_dom_html_font_element_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFontElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="color" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="face" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="size" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLFormElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLFormElement" get-type="webkit_dom_html_form_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="check_validity" symbol="webkit_dom_html_form_element_check_validity">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="dispatch_form_change" symbol="webkit_dom_html_form_element_dispatch_form_change">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="dispatch_form_input" symbol="webkit_dom_html_form_element_dispatch_form_input">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_accept_charset" symbol="webkit_dom_html_form_element_get_accept_charset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_action" symbol="webkit_dom_html_form_element_get_action">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_autocapitalize" symbol="webkit_dom_html_form_element_get_autocapitalize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_autocomplete" symbol="webkit_dom_html_form_element_get_autocomplete">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_autocorrect" symbol="webkit_dom_html_form_element_get_autocorrect">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_elements" symbol="webkit_dom_html_form_element_get_elements">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_encoding" symbol="webkit_dom_html_form_element_get_encoding">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_enctype" symbol="webkit_dom_html_form_element_get_enctype">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_html_form_element_get_length">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_method" symbol="webkit_dom_html_form_element_get_method">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_form_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_no_validate" symbol="webkit_dom_html_form_element_get_no_validate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="get_target" symbol="webkit_dom_html_form_element_get_target">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="reset" symbol="webkit_dom_html_form_element_reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<method name="set_accept_charset" symbol="webkit_dom_html_form_element_set_accept_charset">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_action" symbol="webkit_dom_html_form_element_set_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_autocapitalize" symbol="webkit_dom_html_form_element_set_autocapitalize">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_autocomplete" symbol="webkit_dom_html_form_element_set_autocomplete">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_autocorrect" symbol="webkit_dom_html_form_element_set_autocorrect">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_encoding" symbol="webkit_dom_html_form_element_set_encoding">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_enctype" symbol="webkit_dom_html_form_element_set_enctype">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_method" symbol="webkit_dom_html_form_element_set_method">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_form_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_no_validate" symbol="webkit_dom_html_form_element_set_no_validate">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_target" symbol="webkit_dom_html_form_element_set_target">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="submit" symbol="webkit_dom_html_form_element_submit">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFormElement*"/>
				</parameters>
			</method>
			<property name="accept-charset" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="action" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="autocapitalize" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="autocomplete" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="autocorrect" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="elements" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="encoding" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="enctype" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="length" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="method" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="no-validate" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="target" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLFrameElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLFrameElement" get-type="webkit_dom_html_frame_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_content_document" symbol="webkit_dom_html_frame_element_get_content_document">
				<return-type type="WebKitDOMDocument*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
				</parameters>
			</method>
			<method name="get_content_window" symbol="webkit_dom_html_frame_element_get_content_window">
				<return-type type="WebKitDOMDOMWindow*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
				</parameters>
			</method>
			<method name="get_frame_border" symbol="webkit_dom_html_frame_element_get_frame_border">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="webkit_dom_html_frame_element_get_height">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
				</parameters>
			</method>
			<method name="get_long_desc" symbol="webkit_dom_html_frame_element_get_long_desc">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
				</parameters>
			</method>
			<method name="get_margin_height" symbol="webkit_dom_html_frame_element_get_margin_height">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
				</parameters>
			</method>
			<method name="get_margin_width" symbol="webkit_dom_html_frame_element_get_margin_width">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_frame_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
				</parameters>
			</method>
			<method name="get_no_resize" symbol="webkit_dom_html_frame_element_get_no_resize">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
				</parameters>
			</method>
			<method name="get_scrolling" symbol="webkit_dom_html_frame_element_get_scrolling">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
				</parameters>
			</method>
			<method name="get_src" symbol="webkit_dom_html_frame_element_get_src">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_frame_element_get_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
				</parameters>
			</method>
			<method name="set_frame_border" symbol="webkit_dom_html_frame_element_set_frame_border">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_long_desc" symbol="webkit_dom_html_frame_element_set_long_desc">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_margin_height" symbol="webkit_dom_html_frame_element_set_margin_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_margin_width" symbol="webkit_dom_html_frame_element_set_margin_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_frame_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_no_resize" symbol="webkit_dom_html_frame_element_set_no_resize">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_scrolling" symbol="webkit_dom_html_frame_element_set_scrolling">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_src" symbol="webkit_dom_html_frame_element_set_src">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="content-document" type="WebKitDOMDocument*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="content-window" type="WebKitDOMDOMWindow*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="frame-border" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="long-desc" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="margin-height" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="margin-width" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="no-resize" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scrolling" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="src" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLFrameSetElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLFrameSetElement" get-type="webkit_dom_html_frame_set_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_cols" symbol="webkit_dom_html_frame_set_element_get_cols">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameSetElement*"/>
				</parameters>
			</method>
			<method name="get_rows" symbol="webkit_dom_html_frame_set_element_get_rows">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameSetElement*"/>
				</parameters>
			</method>
			<method name="set_cols" symbol="webkit_dom_html_frame_set_element_set_cols">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameSetElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_rows" symbol="webkit_dom_html_frame_set_element_set_rows">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLFrameSetElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="cols" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rows" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLHRElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLHRElement" get-type="webkit_dom_htmlhr_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_align" symbol="webkit_dom_htmlhr_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHRElement*"/>
				</parameters>
			</method>
			<method name="get_no_shade" symbol="webkit_dom_htmlhr_element_get_no_shade">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHRElement*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="webkit_dom_htmlhr_element_get_size">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHRElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_htmlhr_element_get_width">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHRElement*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_htmlhr_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHRElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_no_shade" symbol="webkit_dom_htmlhr_element_set_no_shade">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHRElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_size" symbol="webkit_dom_htmlhr_element_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHRElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_htmlhr_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHRElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="no-shade" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="size" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLHeadElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLHeadElement" get-type="webkit_dom_html_head_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_profile" symbol="webkit_dom_html_head_element_get_profile">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHeadElement*"/>
				</parameters>
			</method>
			<method name="set_profile" symbol="webkit_dom_html_head_element_set_profile">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHeadElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="profile" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLHeadingElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLHeadingElement" get-type="webkit_dom_html_heading_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_align" symbol="webkit_dom_html_heading_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHeadingElement*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_heading_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHeadingElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLHtmlElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLHtmlElement" get-type="webkit_dom_html_html_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_manifest" symbol="webkit_dom_html_html_element_get_manifest">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHtmlElement*"/>
				</parameters>
			</method>
			<method name="get_version" symbol="webkit_dom_html_html_element_get_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHtmlElement*"/>
				</parameters>
			</method>
			<method name="set_manifest" symbol="webkit_dom_html_html_element_set_manifest">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHtmlElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_version" symbol="webkit_dom_html_html_element_set_version">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLHtmlElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="manifest" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="version" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLIFrameElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLIFrameElement" get-type="webkit_dom_html_iframe_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_align" symbol="webkit_dom_html_iframe_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_content_document" symbol="webkit_dom_html_iframe_element_get_content_document">
				<return-type type="WebKitDOMDocument*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_content_window" symbol="webkit_dom_html_iframe_element_get_content_window">
				<return-type type="WebKitDOMDOMWindow*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_frame_border" symbol="webkit_dom_html_iframe_element_get_frame_border">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="webkit_dom_html_iframe_element_get_height">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_long_desc" symbol="webkit_dom_html_iframe_element_get_long_desc">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_margin_height" symbol="webkit_dom_html_iframe_element_get_margin_height">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_margin_width" symbol="webkit_dom_html_iframe_element_get_margin_width">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_iframe_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_sandbox" symbol="webkit_dom_html_iframe_element_get_sandbox">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_scrolling" symbol="webkit_dom_html_iframe_element_get_scrolling">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_seamless" symbol="webkit_dom_html_iframe_element_get_seamless">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_src" symbol="webkit_dom_html_iframe_element_get_src">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_srcdoc" symbol="webkit_dom_html_iframe_element_get_srcdoc">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_iframe_element_get_width">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_iframe_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_frame_border" symbol="webkit_dom_html_iframe_element_set_frame_border">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_height" symbol="webkit_dom_html_iframe_element_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_long_desc" symbol="webkit_dom_html_iframe_element_set_long_desc">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_margin_height" symbol="webkit_dom_html_iframe_element_set_margin_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_margin_width" symbol="webkit_dom_html_iframe_element_set_margin_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_iframe_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_sandbox" symbol="webkit_dom_html_iframe_element_set_sandbox">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_scrolling" symbol="webkit_dom_html_iframe_element_set_scrolling">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_seamless" symbol="webkit_dom_html_iframe_element_set_seamless">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_src" symbol="webkit_dom_html_iframe_element_set_src">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_srcdoc" symbol="webkit_dom_html_iframe_element_set_srcdoc">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_iframe_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLIFrameElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="content-document" type="WebKitDOMDocument*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="content-window" type="WebKitDOMDOMWindow*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="frame-border" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="long-desc" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="margin-height" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="margin-width" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sandbox" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scrolling" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="seamless" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="src" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="srcdoc" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLImageElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLImageElement" get-type="webkit_dom_html_image_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_align" symbol="webkit_dom_html_image_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_alt" symbol="webkit_dom_html_image_element_get_alt">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_border" symbol="webkit_dom_html_image_element_get_border">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_complete" symbol="webkit_dom_html_image_element_get_complete">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_cross_origin" symbol="webkit_dom_html_image_element_get_cross_origin">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="webkit_dom_html_image_element_get_height">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_hspace" symbol="webkit_dom_html_image_element_get_hspace">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_is_map" symbol="webkit_dom_html_image_element_get_is_map">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_long_desc" symbol="webkit_dom_html_image_element_get_long_desc">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_lowsrc" symbol="webkit_dom_html_image_element_get_lowsrc">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_image_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_natural_height" symbol="webkit_dom_html_image_element_get_natural_height">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_natural_width" symbol="webkit_dom_html_image_element_get_natural_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_src" symbol="webkit_dom_html_image_element_get_src">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_srcset" symbol="webkit_dom_html_image_element_get_srcset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_use_map" symbol="webkit_dom_html_image_element_get_use_map">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_vspace" symbol="webkit_dom_html_image_element_get_vspace">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_image_element_get_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_x" symbol="webkit_dom_html_image_element_get_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="get_y" symbol="webkit_dom_html_image_element_get_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_image_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_alt" symbol="webkit_dom_html_image_element_set_alt">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_border" symbol="webkit_dom_html_image_element_set_border">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_cross_origin" symbol="webkit_dom_html_image_element_set_cross_origin">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_height" symbol="webkit_dom_html_image_element_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_hspace" symbol="webkit_dom_html_image_element_set_hspace">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_is_map" symbol="webkit_dom_html_image_element_set_is_map">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_long_desc" symbol="webkit_dom_html_image_element_set_long_desc">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_lowsrc" symbol="webkit_dom_html_image_element_set_lowsrc">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_image_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_src" symbol="webkit_dom_html_image_element_set_src">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_srcset" symbol="webkit_dom_html_image_element_set_srcset">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_use_map" symbol="webkit_dom_html_image_element_set_use_map">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_vspace" symbol="webkit_dom_html_image_element_set_vspace">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_image_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLImageElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="alt" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="border" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="complete" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="cross-origin" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="hspace" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-map" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="long-desc" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="lowsrc" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="natural-height" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="natural-width" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="src" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="srcset" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-map" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vspace" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLInputElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLInputElement" get-type="webkit_dom_html_input_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="check_validity" symbol="webkit_dom_html_input_element_check_validity">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_accept" symbol="webkit_dom_html_input_element_get_accept">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_align" symbol="webkit_dom_html_input_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_alt" symbol="webkit_dom_html_input_element_get_alt">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_autocapitalize" symbol="webkit_dom_html_input_element_get_autocapitalize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_autocomplete" symbol="webkit_dom_html_input_element_get_autocomplete">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_autocorrect" symbol="webkit_dom_html_input_element_get_autocorrect">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_autofocus" symbol="webkit_dom_html_input_element_get_autofocus">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_capture" symbol="webkit_dom_html_input_element_get_capture">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_checked" symbol="webkit_dom_html_input_element_get_checked">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_default_checked" symbol="webkit_dom_html_input_element_get_default_checked">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_default_value" symbol="webkit_dom_html_input_element_get_default_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_dir_name" symbol="webkit_dom_html_input_element_get_dir_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_disabled" symbol="webkit_dom_html_input_element_get_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_files" symbol="webkit_dom_html_input_element_get_files">
				<return-type type="WebKitDOMFileList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_form" symbol="webkit_dom_html_input_element_get_form">
				<return-type type="WebKitDOMHTMLFormElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_form_action" symbol="webkit_dom_html_input_element_get_form_action">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_form_enctype" symbol="webkit_dom_html_input_element_get_form_enctype">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_form_method" symbol="webkit_dom_html_input_element_get_form_method">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_form_no_validate" symbol="webkit_dom_html_input_element_get_form_no_validate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_form_target" symbol="webkit_dom_html_input_element_get_form_target">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="webkit_dom_html_input_element_get_height">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_incremental" symbol="webkit_dom_html_input_element_get_incremental">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_indeterminate" symbol="webkit_dom_html_input_element_get_indeterminate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_labels" symbol="webkit_dom_html_input_element_get_labels">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_list" symbol="webkit_dom_html_input_element_get_list">
				<return-type type="WebKitDOMHTMLElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_max" symbol="webkit_dom_html_input_element_get_max">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_max_length" symbol="webkit_dom_html_input_element_get_max_length">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_min" symbol="webkit_dom_html_input_element_get_min">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_multiple" symbol="webkit_dom_html_input_element_get_multiple">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_input_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_pattern" symbol="webkit_dom_html_input_element_get_pattern">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_placeholder" symbol="webkit_dom_html_input_element_get_placeholder">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_read_only" symbol="webkit_dom_html_input_element_get_read_only">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_required" symbol="webkit_dom_html_input_element_get_required">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="webkit_dom_html_input_element_get_size">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_src" symbol="webkit_dom_html_input_element_get_src">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_step" symbol="webkit_dom_html_input_element_get_step">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_use_map" symbol="webkit_dom_html_input_element_get_use_map">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_validation_message" symbol="webkit_dom_html_input_element_get_validation_message">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_validity" symbol="webkit_dom_html_input_element_get_validity">
				<return-type type="WebKitDOMValidityState*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="webkit_dom_html_input_element_get_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_value_as_number" symbol="webkit_dom_html_input_element_get_value_as_number">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_grammar" symbol="webkit_dom_html_input_element_get_webkit_grammar">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_speech" symbol="webkit_dom_html_input_element_get_webkit_speech">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_webkitdirectory" symbol="webkit_dom_html_input_element_get_webkitdirectory">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_input_element_get_width">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="get_will_validate" symbol="webkit_dom_html_input_element_get_will_validate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="is_edited" symbol="webkit_dom_html_input_element_is_edited">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="input" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="select" symbol="webkit_dom_html_input_element_select">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
				</parameters>
			</method>
			<method name="set_accept" symbol="webkit_dom_html_input_element_set_accept">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_input_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_alt" symbol="webkit_dom_html_input_element_set_alt">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_autocapitalize" symbol="webkit_dom_html_input_element_set_autocapitalize">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_autocomplete" symbol="webkit_dom_html_input_element_set_autocomplete">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_autocorrect" symbol="webkit_dom_html_input_element_set_autocorrect">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_autofocus" symbol="webkit_dom_html_input_element_set_autofocus">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_capture" symbol="webkit_dom_html_input_element_set_capture">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_checked" symbol="webkit_dom_html_input_element_set_checked">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_custom_validity" symbol="webkit_dom_html_input_element_set_custom_validity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="error" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_default_checked" symbol="webkit_dom_html_input_element_set_default_checked">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_default_value" symbol="webkit_dom_html_input_element_set_default_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_dir_name" symbol="webkit_dom_html_input_element_set_dir_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="webkit_dom_html_input_element_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_files" symbol="webkit_dom_html_input_element_set_files">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="WebKitDOMFileList*"/>
				</parameters>
			</method>
			<method name="set_form_action" symbol="webkit_dom_html_input_element_set_form_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_form_enctype" symbol="webkit_dom_html_input_element_set_form_enctype">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_form_method" symbol="webkit_dom_html_input_element_set_form_method">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_form_no_validate" symbol="webkit_dom_html_input_element_set_form_no_validate">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_form_target" symbol="webkit_dom_html_input_element_set_form_target">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_height" symbol="webkit_dom_html_input_element_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gulong"/>
				</parameters>
			</method>
			<method name="set_incremental" symbol="webkit_dom_html_input_element_set_incremental">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_indeterminate" symbol="webkit_dom_html_input_element_set_indeterminate">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_max" symbol="webkit_dom_html_input_element_set_max">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_max_length" symbol="webkit_dom_html_input_element_set_max_length">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_min" symbol="webkit_dom_html_input_element_set_min">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_multiple" symbol="webkit_dom_html_input_element_set_multiple">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_input_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_pattern" symbol="webkit_dom_html_input_element_set_pattern">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_placeholder" symbol="webkit_dom_html_input_element_set_placeholder">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_range_text" symbol="webkit_dom_html_input_element_set_range_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="replacement" type="gchar*"/>
					<parameter name="start" type="gulong"/>
					<parameter name="end" type="gulong"/>
					<parameter name="selectionMode" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_read_only" symbol="webkit_dom_html_input_element_set_read_only">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_required" symbol="webkit_dom_html_input_element_set_required">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_size" symbol="webkit_dom_html_input_element_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_src" symbol="webkit_dom_html_input_element_set_src">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_step" symbol="webkit_dom_html_input_element_set_step">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_use_map" symbol="webkit_dom_html_input_element_set_use_map">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_value" symbol="webkit_dom_html_input_element_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_value_as_number" symbol="webkit_dom_html_input_element_set_value_as_number">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gdouble"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_value_for_user" symbol="webkit_dom_html_input_element_set_value_for_user">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_webkit_grammar" symbol="webkit_dom_html_input_element_set_webkit_grammar">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_webkit_speech" symbol="webkit_dom_html_input_element_set_webkit_speech">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_webkitdirectory" symbol="webkit_dom_html_input_element_set_webkitdirectory">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_input_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="value" type="gulong"/>
				</parameters>
			</method>
			<method name="step_down" symbol="webkit_dom_html_input_element_step_down">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="n" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="step_up" symbol="webkit_dom_html_input_element_step_up">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLInputElement*"/>
					<parameter name="n" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="accept" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="alt" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="autocapitalize" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="autocomplete" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="autocorrect" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="autofocus" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="capture" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="checked" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="default-checked" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="default-value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="dir-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="files" type="WebKitDOMFileList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="form" type="WebKitDOMHTMLFormElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="form-action" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form-enctype" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form-method" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form-no-validate" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form-target" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="incremental" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="indeterminate" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="labels" type="WebKitDOMNodeList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="list" type="WebKitDOMHTMLElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="max" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-length" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="min" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="multiple" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pattern" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="placeholder" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="read-only" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="required" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="size" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="src" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="step" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-map" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="validation-message" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="validity" type="WebKitDOMValidityState*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="value-as-number" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="webkit-grammar" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="webkit-speech" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="webkitdirectory" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="will-validate" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLKeygenElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLKeygenElement" get-type="webkit_dom_html_keygen_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="check_validity" symbol="webkit_dom_html_keygen_element_check_validity">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
				</parameters>
			</method>
			<method name="get_autofocus" symbol="webkit_dom_html_keygen_element_get_autofocus">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
				</parameters>
			</method>
			<method name="get_challenge" symbol="webkit_dom_html_keygen_element_get_challenge">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
				</parameters>
			</method>
			<method name="get_disabled" symbol="webkit_dom_html_keygen_element_get_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
				</parameters>
			</method>
			<method name="get_form" symbol="webkit_dom_html_keygen_element_get_form">
				<return-type type="WebKitDOMHTMLFormElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
				</parameters>
			</method>
			<method name="get_keytype" symbol="webkit_dom_html_keygen_element_get_keytype">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
				</parameters>
			</method>
			<method name="get_labels" symbol="webkit_dom_html_keygen_element_get_labels">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_keygen_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
				</parameters>
			</method>
			<method name="get_validation_message" symbol="webkit_dom_html_keygen_element_get_validation_message">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
				</parameters>
			</method>
			<method name="get_validity" symbol="webkit_dom_html_keygen_element_get_validity">
				<return-type type="WebKitDOMValidityState*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
				</parameters>
			</method>
			<method name="get_will_validate" symbol="webkit_dom_html_keygen_element_get_will_validate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
				</parameters>
			</method>
			<method name="set_autofocus" symbol="webkit_dom_html_keygen_element_set_autofocus">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_challenge" symbol="webkit_dom_html_keygen_element_set_challenge">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_custom_validity" symbol="webkit_dom_html_keygen_element_set_custom_validity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
					<parameter name="error" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="webkit_dom_html_keygen_element_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_keytype" symbol="webkit_dom_html_keygen_element_set_keytype">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_keygen_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLKeygenElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="autofocus" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="challenge" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form" type="WebKitDOMHTMLFormElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="keytype" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="labels" type="WebKitDOMNodeList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="validation-message" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="validity" type="WebKitDOMValidityState*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="will-validate" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLLIElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLLIElement" get-type="webkit_dom_htmlli_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_value" symbol="webkit_dom_htmlli_element_get_value">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLIElement*"/>
				</parameters>
			</method>
			<method name="set_value" symbol="webkit_dom_htmlli_element_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLIElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<property name="type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="value" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLLabelElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLLabelElement" get-type="webkit_dom_html_label_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_control" symbol="webkit_dom_html_label_element_get_control">
				<return-type type="WebKitDOMHTMLElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLabelElement*"/>
				</parameters>
			</method>
			<method name="get_form" symbol="webkit_dom_html_label_element_get_form">
				<return-type type="WebKitDOMHTMLFormElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLabelElement*"/>
				</parameters>
			</method>
			<method name="get_html_for" symbol="webkit_dom_html_label_element_get_html_for">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLabelElement*"/>
				</parameters>
			</method>
			<method name="set_html_for" symbol="webkit_dom_html_label_element_set_html_for">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLabelElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="control" type="WebKitDOMHTMLElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="form" type="WebKitDOMHTMLFormElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="html-for" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLLegendElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLLegendElement" get-type="webkit_dom_html_legend_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_align" symbol="webkit_dom_html_legend_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLegendElement*"/>
				</parameters>
			</method>
			<method name="get_form" symbol="webkit_dom_html_legend_element_get_form">
				<return-type type="WebKitDOMHTMLFormElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLegendElement*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_legend_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLegendElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form" type="WebKitDOMHTMLFormElement*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLLinkElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLLinkElement" get-type="webkit_dom_html_link_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_charset" symbol="webkit_dom_html_link_element_get_charset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
				</parameters>
			</method>
			<method name="get_disabled" symbol="webkit_dom_html_link_element_get_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
				</parameters>
			</method>
			<method name="get_href" symbol="webkit_dom_html_link_element_get_href">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
				</parameters>
			</method>
			<method name="get_hreflang" symbol="webkit_dom_html_link_element_get_hreflang">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
				</parameters>
			</method>
			<method name="get_media" symbol="webkit_dom_html_link_element_get_media">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
				</parameters>
			</method>
			<method name="get_rel" symbol="webkit_dom_html_link_element_get_rel">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
				</parameters>
			</method>
			<method name="get_rev" symbol="webkit_dom_html_link_element_get_rev">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
				</parameters>
			</method>
			<method name="get_sheet" symbol="webkit_dom_html_link_element_get_sheet">
				<return-type type="WebKitDOMStyleSheet*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
				</parameters>
			</method>
			<method name="get_target" symbol="webkit_dom_html_link_element_get_target">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
				</parameters>
			</method>
			<method name="set_charset" symbol="webkit_dom_html_link_element_set_charset">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="webkit_dom_html_link_element_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_href" symbol="webkit_dom_html_link_element_set_href">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_hreflang" symbol="webkit_dom_html_link_element_set_hreflang">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_media" symbol="webkit_dom_html_link_element_set_media">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_rel" symbol="webkit_dom_html_link_element_set_rel">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_rev" symbol="webkit_dom_html_link_element_set_rev">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_target" symbol="webkit_dom_html_link_element_set_target">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLLinkElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="charset" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="href" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="hreflang" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="media" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rel" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rev" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sheet" type="WebKitDOMStyleSheet*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="target" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLMapElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLMapElement" get-type="webkit_dom_html_map_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_areas" symbol="webkit_dom_html_map_element_get_areas">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMapElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_map_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMapElement*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_map_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMapElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="areas" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLMarqueeElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLMarqueeElement" get-type="webkit_dom_html_marquee_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_behavior" symbol="webkit_dom_html_marquee_element_get_behavior">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<method name="get_bg_color" symbol="webkit_dom_html_marquee_element_get_bg_color">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<method name="get_direction" symbol="webkit_dom_html_marquee_element_get_direction">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="webkit_dom_html_marquee_element_get_height">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<method name="get_hspace" symbol="webkit_dom_html_marquee_element_get_hspace">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<method name="get_loop" symbol="webkit_dom_html_marquee_element_get_loop">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<method name="get_scroll_amount" symbol="webkit_dom_html_marquee_element_get_scroll_amount">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<method name="get_scroll_delay" symbol="webkit_dom_html_marquee_element_get_scroll_delay">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<method name="get_true_speed" symbol="webkit_dom_html_marquee_element_get_true_speed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<method name="get_vspace" symbol="webkit_dom_html_marquee_element_get_vspace">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_marquee_element_get_width">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<method name="set_behavior" symbol="webkit_dom_html_marquee_element_set_behavior">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_bg_color" symbol="webkit_dom_html_marquee_element_set_bg_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_direction" symbol="webkit_dom_html_marquee_element_set_direction">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_height" symbol="webkit_dom_html_marquee_element_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_hspace" symbol="webkit_dom_html_marquee_element_set_hspace">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
					<parameter name="value" type="gulong"/>
				</parameters>
			</method>
			<method name="set_loop" symbol="webkit_dom_html_marquee_element_set_loop">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
					<parameter name="value" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_scroll_amount" symbol="webkit_dom_html_marquee_element_set_scroll_amount">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
					<parameter name="value" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_scroll_delay" symbol="webkit_dom_html_marquee_element_set_scroll_delay">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
					<parameter name="value" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_true_speed" symbol="webkit_dom_html_marquee_element_set_true_speed">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_vspace" symbol="webkit_dom_html_marquee_element_set_vspace">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
					<parameter name="value" type="gulong"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_marquee_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="start" symbol="webkit_dom_html_marquee_element_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<method name="stop" symbol="webkit_dom_html_marquee_element_stop">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMarqueeElement*"/>
				</parameters>
			</method>
			<property name="behavior" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="bg-color" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="direction" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="hspace" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="loop" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scroll-amount" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scroll-delay" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="true-speed" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="vspace" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLMediaElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLMediaElement" get-type="webkit_dom_html_media_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="add_text_track" symbol="webkit_dom_html_media_element_add_text_track">
				<return-type type="WebKitDOMTextTrack*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="kind" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
					<parameter name="language" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="can_play_type" symbol="webkit_dom_html_media_element_can_play_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="type" type="gchar*"/>
				</parameters>
			</method>
			<method name="fast_seek" symbol="webkit_dom_html_media_element_fast_seek">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="time" type="gdouble"/>
				</parameters>
			</method>
			<method name="get_audio_tracks" symbol="webkit_dom_html_media_element_get_audio_tracks">
				<return-type type="WebKitDOMAudioTrackList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_autoplay" symbol="webkit_dom_html_media_element_get_autoplay">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_buffered" symbol="webkit_dom_html_media_element_get_buffered">
				<return-type type="WebKitDOMTimeRanges*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_controller" symbol="webkit_dom_html_media_element_get_controller">
				<return-type type="WebKitDOMMediaController*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_controls" symbol="webkit_dom_html_media_element_get_controls">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_current_src" symbol="webkit_dom_html_media_element_get_current_src">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_current_time" symbol="webkit_dom_html_media_element_get_current_time">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_default_muted" symbol="webkit_dom_html_media_element_get_default_muted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_default_playback_rate" symbol="webkit_dom_html_media_element_get_default_playback_rate">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_duration" symbol="webkit_dom_html_media_element_get_duration">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_ended" symbol="webkit_dom_html_media_element_get_ended">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_error" symbol="webkit_dom_html_media_element_get_error">
				<return-type type="WebKitDOMMediaError*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_initial_time" symbol="webkit_dom_html_media_element_get_initial_time">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_loop" symbol="webkit_dom_html_media_element_get_loop">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_media_group" symbol="webkit_dom_html_media_element_get_media_group">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_muted" symbol="webkit_dom_html_media_element_get_muted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_network_state" symbol="webkit_dom_html_media_element_get_network_state">
				<return-type type="gushort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_paused" symbol="webkit_dom_html_media_element_get_paused">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_playback_rate" symbol="webkit_dom_html_media_element_get_playback_rate">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_played" symbol="webkit_dom_html_media_element_get_played">
				<return-type type="WebKitDOMTimeRanges*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_preload" symbol="webkit_dom_html_media_element_get_preload">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_ready_state" symbol="webkit_dom_html_media_element_get_ready_state">
				<return-type type="gushort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_seekable" symbol="webkit_dom_html_media_element_get_seekable">
				<return-type type="WebKitDOMTimeRanges*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_seeking" symbol="webkit_dom_html_media_element_get_seeking">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_src" symbol="webkit_dom_html_media_element_get_src">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_start_time" symbol="webkit_dom_html_media_element_get_start_time">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_text_tracks" symbol="webkit_dom_html_media_element_get_text_tracks">
				<return-type type="WebKitDOMTextTrackList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_video_tracks" symbol="webkit_dom_html_media_element_get_video_tracks">
				<return-type type="WebKitDOMVideoTrackList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_volume" symbol="webkit_dom_html_media_element_get_volume">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_audio_decoded_byte_count" symbol="webkit_dom_html_media_element_get_webkit_audio_decoded_byte_count">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_closed_captions_visible" symbol="webkit_dom_html_media_element_get_webkit_closed_captions_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_current_playback_target_is_wireless" symbol="webkit_dom_html_media_element_get_webkit_current_playback_target_is_wireless">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_has_closed_captions" symbol="webkit_dom_html_media_element_get_webkit_has_closed_captions">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_preserves_pitch" symbol="webkit_dom_html_media_element_get_webkit_preserves_pitch">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_video_decoded_byte_count" symbol="webkit_dom_html_media_element_get_webkit_video_decoded_byte_count">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="load" symbol="webkit_dom_html_media_element_load">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="pause" symbol="webkit_dom_html_media_element_pause">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="play" symbol="webkit_dom_html_media_element_play">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<method name="set_autoplay" symbol="webkit_dom_html_media_element_set_autoplay">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_controls" symbol="webkit_dom_html_media_element_set_controls">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_current_time" symbol="webkit_dom_html_media_element_set_current_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gdouble"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_default_muted" symbol="webkit_dom_html_media_element_set_default_muted">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_default_playback_rate" symbol="webkit_dom_html_media_element_set_default_playback_rate">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_loop" symbol="webkit_dom_html_media_element_set_loop">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_media_group" symbol="webkit_dom_html_media_element_set_media_group">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_muted" symbol="webkit_dom_html_media_element_set_muted">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_playback_rate" symbol="webkit_dom_html_media_element_set_playback_rate">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_preload" symbol="webkit_dom_html_media_element_set_preload">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_src" symbol="webkit_dom_html_media_element_set_src">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_volume" symbol="webkit_dom_html_media_element_set_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gdouble"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_webkit_closed_captions_visible" symbol="webkit_dom_html_media_element_set_webkit_closed_captions_visible">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_webkit_preserves_pitch" symbol="webkit_dom_html_media_element_set_webkit_preserves_pitch">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="webkit_show_playback_target_picker" symbol="webkit_dom_html_media_element_webkit_show_playback_target_picker">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMediaElement*"/>
				</parameters>
			</method>
			<property name="audio-tracks" type="WebKitDOMAudioTrackList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="autoplay" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="buffered" type="WebKitDOMTimeRanges*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="controller" type="WebKitDOMMediaController*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="controls" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="current-src" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="current-time" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="default-muted" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="default-playback-rate" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="duration" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="ended" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="error" type="WebKitDOMMediaError*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="loop" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="media-group" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="muted" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="network-state" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="paused" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="playback-rate" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="played" type="WebKitDOMTimeRanges*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="preload" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ready-state" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="seekable" type="WebKitDOMTimeRanges*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="seeking" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="src" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text-tracks" type="WebKitDOMTextTrackList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="video-tracks" type="WebKitDOMVideoTrackList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="volume" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="webkit-audio-decoded-byte-count" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-closed-captions-visible" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="webkit-current-playback-target-is-wireless" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-has-closed-captions" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-preserves-pitch" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="webkit-video-decoded-byte-count" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLMenuElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLMenuElement" get-type="webkit_dom_html_menu_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_compact" symbol="webkit_dom_html_menu_element_get_compact">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMenuElement*"/>
				</parameters>
			</method>
			<method name="set_compact" symbol="webkit_dom_html_menu_element_set_compact">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMenuElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="compact" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLMetaElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLMetaElement" get-type="webkit_dom_html_meta_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_content" symbol="webkit_dom_html_meta_element_get_content">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMetaElement*"/>
				</parameters>
			</method>
			<method name="get_http_equiv" symbol="webkit_dom_html_meta_element_get_http_equiv">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMetaElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_meta_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMetaElement*"/>
				</parameters>
			</method>
			<method name="get_scheme" symbol="webkit_dom_html_meta_element_get_scheme">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMetaElement*"/>
				</parameters>
			</method>
			<method name="set_content" symbol="webkit_dom_html_meta_element_set_content">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMetaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_http_equiv" symbol="webkit_dom_html_meta_element_set_http_equiv">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMetaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_meta_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMetaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_scheme" symbol="webkit_dom_html_meta_element_set_scheme">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLMetaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="content" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="http-equiv" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scheme" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLModElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLModElement" get-type="webkit_dom_html_mod_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_cite" symbol="webkit_dom_html_mod_element_get_cite">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLModElement*"/>
				</parameters>
			</method>
			<method name="get_date_time" symbol="webkit_dom_html_mod_element_get_date_time">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLModElement*"/>
				</parameters>
			</method>
			<method name="set_cite" symbol="webkit_dom_html_mod_element_set_cite">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLModElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_date_time" symbol="webkit_dom_html_mod_element_set_date_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLModElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="cite" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="date-time" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLOListElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLOListElement" get-type="webkit_dom_htmlo_list_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_compact" symbol="webkit_dom_htmlo_list_element_get_compact">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOListElement*"/>
				</parameters>
			</method>
			<method name="get_reversed" symbol="webkit_dom_htmlo_list_element_get_reversed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOListElement*"/>
				</parameters>
			</method>
			<method name="get_start" symbol="webkit_dom_htmlo_list_element_get_start">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOListElement*"/>
				</parameters>
			</method>
			<method name="set_compact" symbol="webkit_dom_htmlo_list_element_set_compact">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOListElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_reversed" symbol="webkit_dom_htmlo_list_element_set_reversed">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOListElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_start" symbol="webkit_dom_htmlo_list_element_set_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOListElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<property name="compact" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="reversed" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="start" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLObjectElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLObjectElement" get-type="webkit_dom_html_object_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="check_validity" symbol="webkit_dom_html_object_element_check_validity">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_align" symbol="webkit_dom_html_object_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_archive" symbol="webkit_dom_html_object_element_get_archive">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_border" symbol="webkit_dom_html_object_element_get_border">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_code" symbol="webkit_dom_html_object_element_get_code">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_code_base" symbol="webkit_dom_html_object_element_get_code_base">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_code_type" symbol="webkit_dom_html_object_element_get_code_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_content_document" symbol="webkit_dom_html_object_element_get_content_document">
				<return-type type="WebKitDOMDocument*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_data" symbol="webkit_dom_html_object_element_get_data">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_declare" symbol="webkit_dom_html_object_element_get_declare">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_form" symbol="webkit_dom_html_object_element_get_form">
				<return-type type="WebKitDOMHTMLFormElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="webkit_dom_html_object_element_get_height">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_hspace" symbol="webkit_dom_html_object_element_get_hspace">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_object_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_standby" symbol="webkit_dom_html_object_element_get_standby">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_use_map" symbol="webkit_dom_html_object_element_get_use_map">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_validation_message" symbol="webkit_dom_html_object_element_get_validation_message">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_validity" symbol="webkit_dom_html_object_element_get_validity">
				<return-type type="WebKitDOMValidityState*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_vspace" symbol="webkit_dom_html_object_element_get_vspace">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_object_element_get_width">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="get_will_validate" symbol="webkit_dom_html_object_element_get_will_validate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_object_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_archive" symbol="webkit_dom_html_object_element_set_archive">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_border" symbol="webkit_dom_html_object_element_set_border">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_code" symbol="webkit_dom_html_object_element_set_code">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_code_base" symbol="webkit_dom_html_object_element_set_code_base">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_code_type" symbol="webkit_dom_html_object_element_set_code_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_custom_validity" symbol="webkit_dom_html_object_element_set_custom_validity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="error" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_data" symbol="webkit_dom_html_object_element_set_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_declare" symbol="webkit_dom_html_object_element_set_declare">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_height" symbol="webkit_dom_html_object_element_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_hspace" symbol="webkit_dom_html_object_element_set_hspace">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_object_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_standby" symbol="webkit_dom_html_object_element_set_standby">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_use_map" symbol="webkit_dom_html_object_element_set_use_map">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_vspace" symbol="webkit_dom_html_object_element_set_vspace">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_object_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLObjectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="archive" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="border" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="code" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="code-base" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="code-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="content-document" type="WebKitDOMDocument*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="data" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="declare" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form" type="WebKitDOMHTMLFormElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="height" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="hspace" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="standby" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="use-map" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="validation-message" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="validity" type="WebKitDOMValidityState*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="vspace" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="will-validate" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLOptGroupElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLOptGroupElement" get-type="webkit_dom_html_opt_group_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_disabled" symbol="webkit_dom_html_opt_group_element_get_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptGroupElement*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="webkit_dom_html_opt_group_element_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptGroupElement*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="webkit_dom_html_opt_group_element_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptGroupElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_label" symbol="webkit_dom_html_opt_group_element_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptGroupElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLOptionElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLOptionElement" get-type="webkit_dom_html_option_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_default_selected" symbol="webkit_dom_html_option_element_get_default_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
				</parameters>
			</method>
			<method name="get_disabled" symbol="webkit_dom_html_option_element_get_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
				</parameters>
			</method>
			<method name="get_form" symbol="webkit_dom_html_option_element_get_form">
				<return-type type="WebKitDOMHTMLFormElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
				</parameters>
			</method>
			<method name="get_index" symbol="webkit_dom_html_option_element_get_index">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="webkit_dom_html_option_element_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
				</parameters>
			</method>
			<method name="get_selected" symbol="webkit_dom_html_option_element_get_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="webkit_dom_html_option_element_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="webkit_dom_html_option_element_get_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
				</parameters>
			</method>
			<method name="set_default_selected" symbol="webkit_dom_html_option_element_set_default_selected">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="webkit_dom_html_option_element_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_label" symbol="webkit_dom_html_option_element_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_selected" symbol="webkit_dom_html_option_element_set_selected">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_value" symbol="webkit_dom_html_option_element_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="default-selected" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form" type="WebKitDOMHTMLFormElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="index" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="selected" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLOptionsCollection" parent="WebKitDOMHTMLCollection" type-name="WebKitDOMHTMLOptionsCollection" get-type="webkit_dom_html_options_collection_get_type">
			<method name="get_length" symbol="webkit_dom_html_options_collection_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionsCollection*"/>
				</parameters>
			</method>
			<method name="get_selected_index" symbol="webkit_dom_html_options_collection_get_selected_index">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionsCollection*"/>
				</parameters>
			</method>
			<method name="named_item" symbol="webkit_dom_html_options_collection_named_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionsCollection*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_selected_index" symbol="webkit_dom_html_options_collection_set_selected_index">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLOptionsCollection*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="selected-index" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLParagraphElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLParagraphElement" get-type="webkit_dom_html_paragraph_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_align" symbol="webkit_dom_html_paragraph_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLParagraphElement*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_paragraph_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLParagraphElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLParamElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLParamElement" get-type="webkit_dom_html_param_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_name" symbol="webkit_dom_html_param_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLParamElement*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="webkit_dom_html_param_element_get_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLParamElement*"/>
				</parameters>
			</method>
			<method name="get_value_type" symbol="webkit_dom_html_param_element_get_value_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLParamElement*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_param_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLParamElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_value" symbol="webkit_dom_html_param_element_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLParamElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_value_type" symbol="webkit_dom_html_param_element_set_value_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLParamElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="value-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLPreElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLPreElement" get-type="webkit_dom_html_pre_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_width" symbol="webkit_dom_html_pre_element_get_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLPreElement*"/>
				</parameters>
			</method>
			<method name="get_wrap" symbol="webkit_dom_html_pre_element_get_wrap">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLPreElement*"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_pre_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLPreElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_wrap" symbol="webkit_dom_html_pre_element_set_wrap">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLPreElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="width" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="wrap" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLPropertiesCollection" parent="WebKitDOMHTMLCollection" type-name="WebKitDOMHTMLPropertiesCollection" get-type="webkit_dom_html_properties_collection_get_type">
			<method name="get_length" symbol="webkit_dom_html_properties_collection_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="void*"/>
				</parameters>
			</method>
			<method name="get_names" symbol="webkit_dom_html_properties_collection_get_names">
				<return-type type="WebKitDOMDOMStringList*"/>
				<parameters>
					<parameter name="self" type="void*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_html_properties_collection_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="void*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<method name="named_item" symbol="webkit_dom_html_properties_collection_named_item">
				<return-type type="void*"/>
				<parameters>
					<parameter name="self" type="void*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="names" type="WebKitDOMDOMStringList*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLQuoteElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLQuoteElement" get-type="webkit_dom_html_quote_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_cite" symbol="webkit_dom_html_quote_element_get_cite">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLQuoteElement*"/>
				</parameters>
			</method>
			<method name="set_cite" symbol="webkit_dom_html_quote_element_set_cite">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLQuoteElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="cite" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLScriptElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLScriptElement" get-type="webkit_dom_html_script_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_async" symbol="webkit_dom_html_script_element_get_async">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
				</parameters>
			</method>
			<method name="get_charset" symbol="webkit_dom_html_script_element_get_charset">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
				</parameters>
			</method>
			<method name="get_cross_origin" symbol="webkit_dom_html_script_element_get_cross_origin">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
				</parameters>
			</method>
			<method name="get_defer" symbol="webkit_dom_html_script_element_get_defer">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
				</parameters>
			</method>
			<method name="get_event" symbol="webkit_dom_html_script_element_get_event">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
				</parameters>
			</method>
			<method name="get_html_for" symbol="webkit_dom_html_script_element_get_html_for">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
				</parameters>
			</method>
			<method name="get_nonce" symbol="webkit_dom_html_script_element_get_nonce">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
				</parameters>
			</method>
			<method name="get_src" symbol="webkit_dom_html_script_element_get_src">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="webkit_dom_html_script_element_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
				</parameters>
			</method>
			<method name="set_async" symbol="webkit_dom_html_script_element_set_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_charset" symbol="webkit_dom_html_script_element_set_charset">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_cross_origin" symbol="webkit_dom_html_script_element_set_cross_origin">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_defer" symbol="webkit_dom_html_script_element_set_defer">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_event" symbol="webkit_dom_html_script_element_set_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_html_for" symbol="webkit_dom_html_script_element_set_html_for">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_nonce" symbol="webkit_dom_html_script_element_set_nonce">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_src" symbol="webkit_dom_html_script_element_set_src">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_text" symbol="webkit_dom_html_script_element_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLScriptElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="async" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="charset" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="cross-origin" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="defer" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="event" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="html-for" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="nonce" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="src" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLSelectElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLSelectElement" get-type="webkit_dom_html_select_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="add" symbol="webkit_dom_html_select_element_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="element" type="WebKitDOMHTMLElement*"/>
					<parameter name="before" type="WebKitDOMHTMLElement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="check_validity" symbol="webkit_dom_html_select_element_check_validity">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_autofocus" symbol="webkit_dom_html_select_element_get_autofocus">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_disabled" symbol="webkit_dom_html_select_element_get_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_form" symbol="webkit_dom_html_select_element_get_form">
				<return-type type="WebKitDOMHTMLFormElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_labels" symbol="webkit_dom_html_select_element_get_labels">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_html_select_element_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_multiple" symbol="webkit_dom_html_select_element_get_multiple">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_select_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_options" symbol="webkit_dom_html_select_element_get_options">
				<return-type type="WebKitDOMHTMLOptionsCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_required" symbol="webkit_dom_html_select_element_get_required">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_selected_index" symbol="webkit_dom_html_select_element_get_selected_index">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_selected_options" symbol="webkit_dom_html_select_element_get_selected_options">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="webkit_dom_html_select_element_get_size">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_validation_message" symbol="webkit_dom_html_select_element_get_validation_message">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_validity" symbol="webkit_dom_html_select_element_get_validity">
				<return-type type="WebKitDOMValidityState*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="webkit_dom_html_select_element_get_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="get_will_validate" symbol="webkit_dom_html_select_element_get_will_validate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_html_select_element_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<method name="named_item" symbol="webkit_dom_html_select_element_named_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove" symbol="webkit_dom_html_select_element_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="index" type="glong"/>
				</parameters>
			</method>
			<method name="set_autofocus" symbol="webkit_dom_html_select_element_set_autofocus">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_custom_validity" symbol="webkit_dom_html_select_element_set_custom_validity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="error" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="webkit_dom_html_select_element_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_length" symbol="webkit_dom_html_select_element_set_length">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="value" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_multiple" symbol="webkit_dom_html_select_element_set_multiple">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_select_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_required" symbol="webkit_dom_html_select_element_set_required">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_selected_index" symbol="webkit_dom_html_select_element_set_selected_index">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_size" symbol="webkit_dom_html_select_element_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_value" symbol="webkit_dom_html_select_element_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLSelectElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="autofocus" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form" type="WebKitDOMHTMLFormElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="labels" type="WebKitDOMNodeList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="length" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="multiple" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="options" type="WebKitDOMHTMLOptionsCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="required" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="selected-index" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="selected-options" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="size" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="validation-message" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="validity" type="WebKitDOMValidityState*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="will-validate" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLStyleElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLStyleElement" get-type="webkit_dom_html_style_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_disabled" symbol="webkit_dom_html_style_element_get_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLStyleElement*"/>
				</parameters>
			</method>
			<method name="get_media" symbol="webkit_dom_html_style_element_get_media">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLStyleElement*"/>
				</parameters>
			</method>
			<method name="get_scoped" symbol="webkit_dom_html_style_element_get_scoped">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLStyleElement*"/>
				</parameters>
			</method>
			<method name="get_sheet" symbol="webkit_dom_html_style_element_get_sheet">
				<return-type type="WebKitDOMStyleSheet*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLStyleElement*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="webkit_dom_html_style_element_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLStyleElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_media" symbol="webkit_dom_html_style_element_set_media">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLStyleElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_scoped" symbol="webkit_dom_html_style_element_set_scoped">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLStyleElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="media" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sheet" type="WebKitDOMStyleSheet*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLTableCaptionElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLTableCaptionElement" get-type="webkit_dom_html_table_caption_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_align" symbol="webkit_dom_html_table_caption_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCaptionElement*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_table_caption_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCaptionElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLTableCellElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLTableCellElement" get-type="webkit_dom_html_table_cell_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_abbr" symbol="webkit_dom_html_table_cell_element_get_abbr">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_align" symbol="webkit_dom_html_table_cell_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_axis" symbol="webkit_dom_html_table_cell_element_get_axis">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_bg_color" symbol="webkit_dom_html_table_cell_element_get_bg_color">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_cell_index" symbol="webkit_dom_html_table_cell_element_get_cell_index">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_ch" symbol="webkit_dom_html_table_cell_element_get_ch">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_ch_off" symbol="webkit_dom_html_table_cell_element_get_ch_off">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_col_span" symbol="webkit_dom_html_table_cell_element_get_col_span">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_headers" symbol="webkit_dom_html_table_cell_element_get_headers">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="webkit_dom_html_table_cell_element_get_height">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_no_wrap" symbol="webkit_dom_html_table_cell_element_get_no_wrap">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_row_span" symbol="webkit_dom_html_table_cell_element_get_row_span">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_scope" symbol="webkit_dom_html_table_cell_element_get_scope">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_v_align" symbol="webkit_dom_html_table_cell_element_get_v_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_table_cell_element_get_width">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
				</parameters>
			</method>
			<method name="set_abbr" symbol="webkit_dom_html_table_cell_element_set_abbr">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_table_cell_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_axis" symbol="webkit_dom_html_table_cell_element_set_axis">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_bg_color" symbol="webkit_dom_html_table_cell_element_set_bg_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_ch" symbol="webkit_dom_html_table_cell_element_set_ch">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_ch_off" symbol="webkit_dom_html_table_cell_element_set_ch_off">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_col_span" symbol="webkit_dom_html_table_cell_element_set_col_span">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_headers" symbol="webkit_dom_html_table_cell_element_set_headers">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_height" symbol="webkit_dom_html_table_cell_element_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_no_wrap" symbol="webkit_dom_html_table_cell_element_set_no_wrap">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_row_span" symbol="webkit_dom_html_table_cell_element_set_row_span">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_scope" symbol="webkit_dom_html_table_cell_element_set_scope">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_v_align" symbol="webkit_dom_html_table_cell_element_set_v_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_table_cell_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableCellElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="abbr" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="axis" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="bg-color" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="cell-index" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="ch" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ch-off" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="col-span" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="headers" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="no-wrap" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="row-span" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scope" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="v-align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLTableColElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLTableColElement" get-type="webkit_dom_html_table_col_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_align" symbol="webkit_dom_html_table_col_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableColElement*"/>
				</parameters>
			</method>
			<method name="get_ch" symbol="webkit_dom_html_table_col_element_get_ch">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableColElement*"/>
				</parameters>
			</method>
			<method name="get_ch_off" symbol="webkit_dom_html_table_col_element_get_ch_off">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableColElement*"/>
				</parameters>
			</method>
			<method name="get_span" symbol="webkit_dom_html_table_col_element_get_span">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableColElement*"/>
				</parameters>
			</method>
			<method name="get_v_align" symbol="webkit_dom_html_table_col_element_get_v_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableColElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_table_col_element_get_width">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableColElement*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_table_col_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableColElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_ch" symbol="webkit_dom_html_table_col_element_set_ch">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableColElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_ch_off" symbol="webkit_dom_html_table_col_element_set_ch_off">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableColElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_span" symbol="webkit_dom_html_table_col_element_set_span">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableColElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_v_align" symbol="webkit_dom_html_table_col_element_set_v_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableColElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_table_col_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableColElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ch" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ch-off" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="span" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="v-align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLTableElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLTableElement" get-type="webkit_dom_html_table_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="create_caption" symbol="webkit_dom_html_table_element_create_caption">
				<return-type type="WebKitDOMHTMLElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="create_t_body" symbol="webkit_dom_html_table_element_create_t_body">
				<return-type type="WebKitDOMHTMLElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="create_t_foot" symbol="webkit_dom_html_table_element_create_t_foot">
				<return-type type="WebKitDOMHTMLElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="create_t_head" symbol="webkit_dom_html_table_element_create_t_head">
				<return-type type="WebKitDOMHTMLElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="delete_caption" symbol="webkit_dom_html_table_element_delete_caption">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="delete_row" symbol="webkit_dom_html_table_element_delete_row">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="index" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="delete_t_foot" symbol="webkit_dom_html_table_element_delete_t_foot">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="delete_t_head" symbol="webkit_dom_html_table_element_delete_t_head">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_align" symbol="webkit_dom_html_table_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_bg_color" symbol="webkit_dom_html_table_element_get_bg_color">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_border" symbol="webkit_dom_html_table_element_get_border">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_caption" symbol="webkit_dom_html_table_element_get_caption">
				<return-type type="WebKitDOMHTMLTableCaptionElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_cell_padding" symbol="webkit_dom_html_table_element_get_cell_padding">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_cell_spacing" symbol="webkit_dom_html_table_element_get_cell_spacing">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_frame" symbol="webkit_dom_html_table_element_get_frame">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_rows" symbol="webkit_dom_html_table_element_get_rows">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_rules" symbol="webkit_dom_html_table_element_get_rules">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_summary" symbol="webkit_dom_html_table_element_get_summary">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_t_bodies" symbol="webkit_dom_html_table_element_get_t_bodies">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_t_foot" symbol="webkit_dom_html_table_element_get_t_foot">
				<return-type type="WebKitDOMHTMLTableSectionElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_t_head" symbol="webkit_dom_html_table_element_get_t_head">
				<return-type type="WebKitDOMHTMLTableSectionElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_table_element_get_width">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
				</parameters>
			</method>
			<method name="insert_row" symbol="webkit_dom_html_table_element_insert_row">
				<return-type type="WebKitDOMHTMLElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="index" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_table_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_bg_color" symbol="webkit_dom_html_table_element_set_bg_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_border" symbol="webkit_dom_html_table_element_set_border">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_caption" symbol="webkit_dom_html_table_element_set_caption">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="value" type="WebKitDOMHTMLTableCaptionElement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_cell_padding" symbol="webkit_dom_html_table_element_set_cell_padding">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_cell_spacing" symbol="webkit_dom_html_table_element_set_cell_spacing">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_frame" symbol="webkit_dom_html_table_element_set_frame">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_rules" symbol="webkit_dom_html_table_element_set_rules">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_summary" symbol="webkit_dom_html_table_element_set_summary">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_t_foot" symbol="webkit_dom_html_table_element_set_t_foot">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="value" type="WebKitDOMHTMLTableSectionElement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_t_head" symbol="webkit_dom_html_table_element_set_t_head">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="value" type="WebKitDOMHTMLTableSectionElement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_table_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="bg-color" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="border" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="caption" type="WebKitDOMHTMLTableCaptionElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="cell-padding" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="cell-spacing" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="frame" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rows" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="rules" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="summary" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="t-bodies" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="t-foot" type="WebKitDOMHTMLTableSectionElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="t-head" type="WebKitDOMHTMLTableSectionElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="width" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLTableRowElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLTableRowElement" get-type="webkit_dom_html_table_row_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="delete_cell" symbol="webkit_dom_html_table_row_element_delete_cell">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
					<parameter name="index" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_align" symbol="webkit_dom_html_table_row_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
				</parameters>
			</method>
			<method name="get_bg_color" symbol="webkit_dom_html_table_row_element_get_bg_color">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
				</parameters>
			</method>
			<method name="get_cells" symbol="webkit_dom_html_table_row_element_get_cells">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
				</parameters>
			</method>
			<method name="get_ch" symbol="webkit_dom_html_table_row_element_get_ch">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
				</parameters>
			</method>
			<method name="get_ch_off" symbol="webkit_dom_html_table_row_element_get_ch_off">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
				</parameters>
			</method>
			<method name="get_row_index" symbol="webkit_dom_html_table_row_element_get_row_index">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
				</parameters>
			</method>
			<method name="get_section_row_index" symbol="webkit_dom_html_table_row_element_get_section_row_index">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
				</parameters>
			</method>
			<method name="get_v_align" symbol="webkit_dom_html_table_row_element_get_v_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
				</parameters>
			</method>
			<method name="insert_cell" symbol="webkit_dom_html_table_row_element_insert_cell">
				<return-type type="WebKitDOMHTMLElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
					<parameter name="index" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_table_row_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_bg_color" symbol="webkit_dom_html_table_row_element_set_bg_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_ch" symbol="webkit_dom_html_table_row_element_set_ch">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_ch_off" symbol="webkit_dom_html_table_row_element_set_ch_off">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_v_align" symbol="webkit_dom_html_table_row_element_set_v_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableRowElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="bg-color" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="cells" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="ch" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ch-off" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="row-index" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="section-row-index" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="v-align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLTableSectionElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLTableSectionElement" get-type="webkit_dom_html_table_section_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="delete_row" symbol="webkit_dom_html_table_section_element_delete_row">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableSectionElement*"/>
					<parameter name="index" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_align" symbol="webkit_dom_html_table_section_element_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableSectionElement*"/>
				</parameters>
			</method>
			<method name="get_ch" symbol="webkit_dom_html_table_section_element_get_ch">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableSectionElement*"/>
				</parameters>
			</method>
			<method name="get_ch_off" symbol="webkit_dom_html_table_section_element_get_ch_off">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableSectionElement*"/>
				</parameters>
			</method>
			<method name="get_rows" symbol="webkit_dom_html_table_section_element_get_rows">
				<return-type type="WebKitDOMHTMLCollection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableSectionElement*"/>
				</parameters>
			</method>
			<method name="get_v_align" symbol="webkit_dom_html_table_section_element_get_v_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableSectionElement*"/>
				</parameters>
			</method>
			<method name="insert_row" symbol="webkit_dom_html_table_section_element_insert_row">
				<return-type type="WebKitDOMHTMLElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableSectionElement*"/>
					<parameter name="index" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_html_table_section_element_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableSectionElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_ch" symbol="webkit_dom_html_table_section_element_set_ch">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableSectionElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_ch_off" symbol="webkit_dom_html_table_section_element_set_ch_off">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableSectionElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_v_align" symbol="webkit_dom_html_table_section_element_set_v_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTableSectionElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ch" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="ch-off" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rows" type="WebKitDOMHTMLCollection*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="v-align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLTextAreaElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLTextAreaElement" get-type="webkit_dom_html_text_area_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="check_validity" symbol="webkit_dom_html_text_area_element_check_validity">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_autocapitalize" symbol="webkit_dom_html_text_area_element_get_autocapitalize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_autocorrect" symbol="webkit_dom_html_text_area_element_get_autocorrect">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_autofocus" symbol="webkit_dom_html_text_area_element_get_autofocus">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_cols" symbol="webkit_dom_html_text_area_element_get_cols">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_default_value" symbol="webkit_dom_html_text_area_element_get_default_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_dir_name" symbol="webkit_dom_html_text_area_element_get_dir_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_disabled" symbol="webkit_dom_html_text_area_element_get_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_form" symbol="webkit_dom_html_text_area_element_get_form">
				<return-type type="WebKitDOMHTMLFormElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_labels" symbol="webkit_dom_html_text_area_element_get_labels">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_max_length" symbol="webkit_dom_html_text_area_element_get_max_length">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_html_text_area_element_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_placeholder" symbol="webkit_dom_html_text_area_element_get_placeholder">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_read_only" symbol="webkit_dom_html_text_area_element_get_read_only">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_required" symbol="webkit_dom_html_text_area_element_get_required">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_rows" symbol="webkit_dom_html_text_area_element_get_rows">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_selection_direction" symbol="webkit_dom_html_text_area_element_get_selection_direction">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_selection_end" symbol="webkit_dom_html_text_area_element_get_selection_end">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_selection_start" symbol="webkit_dom_html_text_area_element_get_selection_start">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_text_length" symbol="webkit_dom_html_text_area_element_get_text_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_validation_message" symbol="webkit_dom_html_text_area_element_get_validation_message">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_validity" symbol="webkit_dom_html_text_area_element_get_validity">
				<return-type type="WebKitDOMValidityState*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="webkit_dom_html_text_area_element_get_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_will_validate" symbol="webkit_dom_html_text_area_element_get_will_validate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="get_wrap" symbol="webkit_dom_html_text_area_element_get_wrap">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="is_edited" symbol="webkit_dom_html_text_area_element_is_edited">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="input" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="select" symbol="webkit_dom_html_text_area_element_select">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
				</parameters>
			</method>
			<method name="set_autocapitalize" symbol="webkit_dom_html_text_area_element_set_autocapitalize">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_autocorrect" symbol="webkit_dom_html_text_area_element_set_autocorrect">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_autofocus" symbol="webkit_dom_html_text_area_element_set_autofocus">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_cols" symbol="webkit_dom_html_text_area_element_set_cols">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_custom_validity" symbol="webkit_dom_html_text_area_element_set_custom_validity">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="error" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_default_value" symbol="webkit_dom_html_text_area_element_set_default_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_dir_name" symbol="webkit_dom_html_text_area_element_set_dir_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="webkit_dom_html_text_area_element_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_max_length" symbol="webkit_dom_html_text_area_element_set_max_length">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_name" symbol="webkit_dom_html_text_area_element_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_placeholder" symbol="webkit_dom_html_text_area_element_set_placeholder">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_range_text" symbol="webkit_dom_html_text_area_element_set_range_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="replacement" type="gchar*"/>
					<parameter name="start" type="gulong"/>
					<parameter name="end" type="gulong"/>
					<parameter name="selectionMode" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_read_only" symbol="webkit_dom_html_text_area_element_set_read_only">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_required" symbol="webkit_dom_html_text_area_element_set_required">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_rows" symbol="webkit_dom_html_text_area_element_set_rows">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_selection_direction" symbol="webkit_dom_html_text_area_element_set_selection_direction">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_selection_end" symbol="webkit_dom_html_text_area_element_set_selection_end">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_selection_range" symbol="webkit_dom_html_text_area_element_set_selection_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="start" type="glong"/>
					<parameter name="end" type="glong"/>
					<parameter name="direction" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_selection_start" symbol="webkit_dom_html_text_area_element_set_selection_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="glong"/>
				</parameters>
			</method>
			<method name="set_value" symbol="webkit_dom_html_text_area_element_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_wrap" symbol="webkit_dom_html_text_area_element_set_wrap">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTextAreaElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="autocapitalize" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="autocorrect" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="autofocus" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="cols" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="default-value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="dir-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="form" type="WebKitDOMHTMLFormElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="labels" type="WebKitDOMNodeList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="max-length" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="placeholder" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="read-only" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="required" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rows" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="selection-direction" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="selection-end" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="selection-start" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text-length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="validation-message" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="validity" type="WebKitDOMValidityState*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="will-validate" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="wrap" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLTitleElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLTitleElement" get-type="webkit_dom_html_title_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_text" symbol="webkit_dom_html_title_element_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTitleElement*"/>
				</parameters>
			</method>
			<method name="set_text" symbol="webkit_dom_html_title_element_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLTitleElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLUListElement" parent="WebKitDOMHTMLElement" type-name="WebKitDOMHTMLUListElement" get-type="webkit_dom_htmlu_list_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_compact" symbol="webkit_dom_htmlu_list_element_get_compact">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLUListElement*"/>
				</parameters>
			</method>
			<method name="set_compact" symbol="webkit_dom_htmlu_list_element_set_compact">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLUListElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="compact" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHTMLVideoElement" parent="WebKitDOMHTMLMediaElement" type-name="WebKitDOMHTMLVideoElement" get-type="webkit_dom_html_video_element_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_height" symbol="webkit_dom_html_video_element_get_height">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
				</parameters>
			</method>
			<method name="get_poster" symbol="webkit_dom_html_video_element_get_poster">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
				</parameters>
			</method>
			<method name="get_video_height" symbol="webkit_dom_html_video_element_get_video_height">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
				</parameters>
			</method>
			<method name="get_video_width" symbol="webkit_dom_html_video_element_get_video_width">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_decoded_frame_count" symbol="webkit_dom_html_video_element_get_webkit_decoded_frame_count">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_displaying_fullscreen" symbol="webkit_dom_html_video_element_get_webkit_displaying_fullscreen">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_dropped_frame_count" symbol="webkit_dom_html_video_element_get_webkit_dropped_frame_count">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_supports_fullscreen" symbol="webkit_dom_html_video_element_get_webkit_supports_fullscreen">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
				</parameters>
			</method>
			<method name="get_webkit_wireless_video_playback_disabled" symbol="webkit_dom_html_video_element_get_webkit_wireless_video_playback_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_html_video_element_get_width">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
				</parameters>
			</method>
			<method name="set_height" symbol="webkit_dom_html_video_element_set_height">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
					<parameter name="value" type="gulong"/>
				</parameters>
			</method>
			<method name="set_poster" symbol="webkit_dom_html_video_element_set_poster">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_webkit_wireless_video_playback_disabled" symbol="webkit_dom_html_video_element_set_webkit_wireless_video_playback_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_width" symbol="webkit_dom_html_video_element_set_width">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
					<parameter name="value" type="gulong"/>
				</parameters>
			</method>
			<method name="webkit_enter_full_screen" symbol="webkit_dom_html_video_element_webkit_enter_full_screen">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="webkit_enter_fullscreen" symbol="webkit_dom_html_video_element_webkit_enter_fullscreen">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="webkit_exit_full_screen" symbol="webkit_dom_html_video_element_webkit_exit_full_screen">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
				</parameters>
			</method>
			<method name="webkit_exit_fullscreen" symbol="webkit_dom_html_video_element_webkit_exit_fullscreen">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHTMLVideoElement*"/>
				</parameters>
			</method>
			<property name="height" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="poster" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="video-height" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="video-width" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-decoded-frame-count" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-displaying-fullscreen" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-dropped-frame-count" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-supports-fullscreen" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-wireless-video-playback-disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="width" type="gulong" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMHistory" parent="WebKitDOMObject" type-name="WebKitDOMHistory" get-type="webkit_dom_history_get_type">
			<method name="back" symbol="webkit_dom_history_back">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHistory*"/>
				</parameters>
			</method>
			<method name="forward" symbol="webkit_dom_history_forward">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHistory*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_history_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHistory*"/>
				</parameters>
			</method>
			<method name="go" symbol="webkit_dom_history_go">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMHistory*"/>
					<parameter name="distance" type="glong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMKeyboardEvent" parent="WebKitDOMUIEvent" type-name="WebKitDOMKeyboardEvent" get-type="webkit_dom_keyboard_event_get_type">
			<method name="get_alt_graph_key" symbol="webkit_dom_keyboard_event_get_alt_graph_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMKeyboardEvent*"/>
				</parameters>
			</method>
			<method name="get_alt_key" symbol="webkit_dom_keyboard_event_get_alt_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMKeyboardEvent*"/>
				</parameters>
			</method>
			<method name="get_ctrl_key" symbol="webkit_dom_keyboard_event_get_ctrl_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMKeyboardEvent*"/>
				</parameters>
			</method>
			<method name="get_key_identifier" symbol="webkit_dom_keyboard_event_get_key_identifier">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMKeyboardEvent*"/>
				</parameters>
			</method>
			<method name="get_key_location" symbol="webkit_dom_keyboard_event_get_key_location">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMKeyboardEvent*"/>
				</parameters>
			</method>
			<method name="get_meta_key" symbol="webkit_dom_keyboard_event_get_meta_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMKeyboardEvent*"/>
				</parameters>
			</method>
			<method name="get_modifier_state" symbol="webkit_dom_keyboard_event_get_modifier_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMKeyboardEvent*"/>
					<parameter name="keyIdentifierArg" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_shift_key" symbol="webkit_dom_keyboard_event_get_shift_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMKeyboardEvent*"/>
				</parameters>
			</method>
			<method name="init_keyboard_event" symbol="webkit_dom_keyboard_event_init_keyboard_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMKeyboardEvent*"/>
					<parameter name="type" type="gchar*"/>
					<parameter name="canBubble" type="gboolean"/>
					<parameter name="cancelable" type="gboolean"/>
					<parameter name="view" type="WebKitDOMDOMWindow*"/>
					<parameter name="keyIdentifier" type="gchar*"/>
					<parameter name="location" type="gulong"/>
					<parameter name="ctrlKey" type="gboolean"/>
					<parameter name="altKey" type="gboolean"/>
					<parameter name="shiftKey" type="gboolean"/>
					<parameter name="metaKey" type="gboolean"/>
					<parameter name="altGraphKey" type="gboolean"/>
				</parameters>
			</method>
			<property name="alt-graph-key" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="alt-key" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="ctrl-key" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="key-identifier" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="key-location" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="meta-key" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="shift-key" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMLocation" parent="WebKitDOMObject" type-name="WebKitDOMLocation" get-type="webkit_dom_location_get_type">
			<method name="get_ancestor_origins" symbol="webkit_dom_location_get_ancestor_origins">
				<return-type type="WebKitDOMDOMStringList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMLocation*"/>
				</parameters>
			</method>
			<method name="get_hash" symbol="webkit_dom_location_get_hash">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMLocation*"/>
				</parameters>
			</method>
			<method name="get_host" symbol="webkit_dom_location_get_host">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMLocation*"/>
				</parameters>
			</method>
			<method name="get_hostname" symbol="webkit_dom_location_get_hostname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMLocation*"/>
				</parameters>
			</method>
			<method name="get_href" symbol="webkit_dom_location_get_href">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMLocation*"/>
				</parameters>
			</method>
			<method name="get_origin" symbol="webkit_dom_location_get_origin">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMLocation*"/>
				</parameters>
			</method>
			<method name="get_pathname" symbol="webkit_dom_location_get_pathname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMLocation*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="webkit_dom_location_get_port">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMLocation*"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="webkit_dom_location_get_protocol">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMLocation*"/>
				</parameters>
			</method>
			<method name="get_search" symbol="webkit_dom_location_get_search">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMLocation*"/>
				</parameters>
			</method>
			<property name="ancestor-origins" type="WebKitDOMDOMStringList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="hash" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="host" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="hostname" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="href" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="origin" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="pathname" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="port" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="protocol" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="search" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMMediaController" parent="WebKitDOMObject" type-name="WebKitDOMMediaController" get-type="webkit_dom_media_controller_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_buffered" symbol="webkit_dom_media_controller_get_buffered">
				<return-type type="WebKitDOMTimeRanges*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="get_current_time" symbol="webkit_dom_media_controller_get_current_time">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="get_default_playback_rate" symbol="webkit_dom_media_controller_get_default_playback_rate">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="get_duration" symbol="webkit_dom_media_controller_get_duration">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="get_muted" symbol="webkit_dom_media_controller_get_muted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="get_paused" symbol="webkit_dom_media_controller_get_paused">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="get_playback_rate" symbol="webkit_dom_media_controller_get_playback_rate">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="get_playback_state" symbol="webkit_dom_media_controller_get_playback_state">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="get_played" symbol="webkit_dom_media_controller_get_played">
				<return-type type="WebKitDOMTimeRanges*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="get_seekable" symbol="webkit_dom_media_controller_get_seekable">
				<return-type type="WebKitDOMTimeRanges*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="get_volume" symbol="webkit_dom_media_controller_get_volume">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="pause" symbol="webkit_dom_media_controller_pause">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="play" symbol="webkit_dom_media_controller_play">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<method name="set_current_time" symbol="webkit_dom_media_controller_set_current_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
					<parameter name="value" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_default_playback_rate" symbol="webkit_dom_media_controller_set_default_playback_rate">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
					<parameter name="value" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_muted" symbol="webkit_dom_media_controller_set_muted">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_playback_rate" symbol="webkit_dom_media_controller_set_playback_rate">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
					<parameter name="value" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_volume" symbol="webkit_dom_media_controller_set_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
					<parameter name="value" type="gdouble"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="unpause" symbol="webkit_dom_media_controller_unpause">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaController*"/>
				</parameters>
			</method>
			<property name="buffered" type="WebKitDOMTimeRanges*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="current-time" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="default-playback-rate" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="duration" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="muted" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="paused" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="playback-rate" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="playback-state" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="played" type="WebKitDOMTimeRanges*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="seekable" type="WebKitDOMTimeRanges*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="volume" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMMediaError" parent="WebKitDOMObject" type-name="WebKitDOMMediaError" get-type="webkit_dom_media_error_get_type">
			<method name="get_code" symbol="webkit_dom_media_error_get_code">
				<return-type type="gushort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaError*"/>
				</parameters>
			</method>
			<property name="code" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMMediaList" parent="WebKitDOMObject" type-name="WebKitDOMMediaList" get-type="webkit_dom_media_list_get_type">
			<method name="append_medium" symbol="webkit_dom_media_list_append_medium">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaList*"/>
					<parameter name="newMedium" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="delete_medium" symbol="webkit_dom_media_list_delete_medium">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaList*"/>
					<parameter name="oldMedium" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_media_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaList*"/>
				</parameters>
			</method>
			<method name="get_media_text" symbol="webkit_dom_media_list_get_media_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaList*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_media_list_item">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<method name="set_media_text" symbol="webkit_dom_media_list_set_media_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaList*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="media-text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMMediaQueryList" parent="WebKitDOMObject" type-name="WebKitDOMMediaQueryList" get-type="webkit_dom_media_query_list_get_type">
			<method name="get_matches" symbol="webkit_dom_media_query_list_get_matches">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaQueryList*"/>
				</parameters>
			</method>
			<method name="get_media" symbol="webkit_dom_media_query_list_get_media">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMediaQueryList*"/>
				</parameters>
			</method>
			<property name="matches" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="media" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMMemoryInfo" parent="WebKitDOMObject" type-name="WebKitDOMMemoryInfo" get-type="webkit_dom_memory_info_get_type">
			<method name="get_js_heap_size_limit" symbol="webkit_dom_memory_info_get_js_heap_size_limit">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="void*"/>
				</parameters>
			</method>
			<method name="get_total_js_heap_size" symbol="webkit_dom_memory_info_get_total_js_heap_size">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="void*"/>
				</parameters>
			</method>
			<method name="get_used_js_heap_size" symbol="webkit_dom_memory_info_get_used_js_heap_size">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="void*"/>
				</parameters>
			</method>
			<property name="js-heap-size-limit" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="total-js-heap-size" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="used-js-heap-size" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMMessagePort" parent="WebKitDOMObject" type-name="WebKitDOMMessagePort" get-type="webkit_dom_message_port_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
		</object>
		<object name="WebKitDOMMicroDataItemValue" parent="WebKitDOMObject" type-name="WebKitDOMMicroDataItemValue" get-type="webkit_dom_micro_data_item_value_get_type">
		</object>
		<object name="WebKitDOMMouseEvent" parent="WebKitDOMUIEvent" type-name="WebKitDOMMouseEvent" get-type="webkit_dom_mouse_event_get_type">
			<method name="get_alt_key" symbol="webkit_dom_mouse_event_get_alt_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_button" symbol="webkit_dom_mouse_event_get_button">
				<return-type type="gushort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_client_x" symbol="webkit_dom_mouse_event_get_client_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_client_y" symbol="webkit_dom_mouse_event_get_client_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_ctrl_key" symbol="webkit_dom_mouse_event_get_ctrl_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_from_element" symbol="webkit_dom_mouse_event_get_from_element">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_meta_key" symbol="webkit_dom_mouse_event_get_meta_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_offset_x" symbol="webkit_dom_mouse_event_get_offset_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_offset_y" symbol="webkit_dom_mouse_event_get_offset_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_related_target" symbol="webkit_dom_mouse_event_get_related_target">
				<return-type type="WebKitDOMEventTarget*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_screen_x" symbol="webkit_dom_mouse_event_get_screen_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_screen_y" symbol="webkit_dom_mouse_event_get_screen_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_shift_key" symbol="webkit_dom_mouse_event_get_shift_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_to_element" symbol="webkit_dom_mouse_event_get_to_element">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_webkit_movement_x" symbol="webkit_dom_mouse_event_get_webkit_movement_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_webkit_movement_y" symbol="webkit_dom_mouse_event_get_webkit_movement_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_x" symbol="webkit_dom_mouse_event_get_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="get_y" symbol="webkit_dom_mouse_event_get_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
				</parameters>
			</method>
			<method name="init_mouse_event" symbol="webkit_dom_mouse_event_init_mouse_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMMouseEvent*"/>
					<parameter name="type" type="gchar*"/>
					<parameter name="canBubble" type="gboolean"/>
					<parameter name="cancelable" type="gboolean"/>
					<parameter name="view" type="WebKitDOMDOMWindow*"/>
					<parameter name="detail" type="glong"/>
					<parameter name="screenX" type="glong"/>
					<parameter name="screenY" type="glong"/>
					<parameter name="clientX" type="glong"/>
					<parameter name="clientY" type="glong"/>
					<parameter name="ctrlKey" type="gboolean"/>
					<parameter name="altKey" type="gboolean"/>
					<parameter name="shiftKey" type="gboolean"/>
					<parameter name="metaKey" type="gboolean"/>
					<parameter name="button" type="gushort"/>
					<parameter name="relatedTarget" type="WebKitDOMEventTarget*"/>
				</parameters>
			</method>
			<property name="alt-key" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="button" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="client-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="client-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="ctrl-key" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="from-element" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="meta-key" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="offset-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="offset-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="related-target" type="WebKitDOMEventTarget*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="screen-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="screen-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="shift-key" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="to-element" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-movement-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-movement-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMNamedNodeMap" parent="WebKitDOMObject" type-name="WebKitDOMNamedNodeMap" get-type="webkit_dom_named_node_map_get_type">
			<method name="get_length" symbol="webkit_dom_named_node_map_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNamedNodeMap*"/>
				</parameters>
			</method>
			<method name="get_named_item" symbol="webkit_dom_named_node_map_get_named_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNamedNodeMap*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_named_item_ns" symbol="webkit_dom_named_node_map_get_named_item_ns">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNamedNodeMap*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="localName" type="gchar*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_named_node_map_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNamedNodeMap*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<method name="remove_named_item" symbol="webkit_dom_named_node_map_remove_named_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNamedNodeMap*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="remove_named_item_ns" symbol="webkit_dom_named_node_map_remove_named_item_ns">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNamedNodeMap*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="localName" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_named_item" symbol="webkit_dom_named_node_map_set_named_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNamedNodeMap*"/>
					<parameter name="node" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_named_item_ns" symbol="webkit_dom_named_node_map_set_named_item_ns">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNamedNodeMap*"/>
					<parameter name="node" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMNavigator" parent="WebKitDOMObject" type-name="WebKitDOMNavigator" get-type="webkit_dom_navigator_get_type">
			<method name="get_app_code_name" symbol="webkit_dom_navigator_get_app_code_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_app_name" symbol="webkit_dom_navigator_get_app_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_app_version" symbol="webkit_dom_navigator_get_app_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_cookie_enabled" symbol="webkit_dom_navigator_get_cookie_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_geolocation" symbol="webkit_dom_navigator_get_geolocation">
				<return-type type="WebKitDOMGeolocation*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_language" symbol="webkit_dom_navigator_get_language">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_mime_types" symbol="webkit_dom_navigator_get_mime_types">
				<return-type type="WebKitDOMDOMMimeTypeArray*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_on_line" symbol="webkit_dom_navigator_get_on_line">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_platform" symbol="webkit_dom_navigator_get_platform">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_plugins" symbol="webkit_dom_navigator_get_plugins">
				<return-type type="WebKitDOMDOMPluginArray*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_product" symbol="webkit_dom_navigator_get_product">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_product_sub" symbol="webkit_dom_navigator_get_product_sub">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_storage_updates" symbol="webkit_dom_navigator_get_storage_updates">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_user_agent" symbol="webkit_dom_navigator_get_user_agent">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_vendor" symbol="webkit_dom_navigator_get_vendor">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_vendor_sub" symbol="webkit_dom_navigator_get_vendor_sub">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_webkit_battery" symbol="webkit_dom_navigator_get_webkit_battery">
				<return-type type="WebKitDOMBatteryManager*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_webkit_persistent_storage" symbol="webkit_dom_navigator_get_webkit_persistent_storage">
				<return-type type="WebKitDOMStorageQuota*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="get_webkit_temporary_storage" symbol="webkit_dom_navigator_get_webkit_temporary_storage">
				<return-type type="WebKitDOMStorageQuota*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="is_protocol_handler_registered" symbol="webkit_dom_navigator_is_protocol_handler_registered">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
					<parameter name="scheme" type="gchar*"/>
					<parameter name="url" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="java_enabled" symbol="webkit_dom_navigator_java_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<method name="register_protocol_handler" symbol="webkit_dom_navigator_register_protocol_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
					<parameter name="scheme" type="gchar*"/>
					<parameter name="url" type="gchar*"/>
					<parameter name="title" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="unregister_protocol_handler" symbol="webkit_dom_navigator_unregister_protocol_handler">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
					<parameter name="scheme" type="gchar*"/>
					<parameter name="url" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="webkit_get_gamepads" symbol="webkit_dom_navigator_webkit_get_gamepads">
				<return-type type="WebKitDOMGamepadList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNavigator*"/>
				</parameters>
			</method>
			<property name="app-code-name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="app-name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="app-version" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="cookie-enabled" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="geolocation" type="WebKitDOMGeolocation*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="language" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="mime-types" type="WebKitDOMDOMMimeTypeArray*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="on-line" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="platform" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="plugins" type="WebKitDOMDOMPluginArray*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="product" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="product-sub" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="user-agent" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="vendor" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="vendor-sub" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-battery" type="WebKitDOMBatteryManager*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-persistent-storage" type="WebKitDOMStorageQuota*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-temporary-storage" type="WebKitDOMStorageQuota*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMNode" parent="WebKitDOMObject" type-name="WebKitDOMNode" get-type="webkit_dom_node_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="append_child" symbol="webkit_dom_node_append_child">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="newChild" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="clone_node" symbol="webkit_dom_node_clone_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="deep" type="gboolean"/>
				</parameters>
			</method>
			<method name="compare_document_position" symbol="webkit_dom_node_compare_document_position">
				<return-type type="gushort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="other" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="contains" symbol="webkit_dom_node_contains">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="other" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="dispatch_event" symbol="webkit_dom_node_dispatch_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="event" type="WebKitDOMEvent*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_attributes" symbol="webkit_dom_node_get_attributes">
				<return-type type="WebKitDOMNamedNodeMap*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_base_uri" symbol="webkit_dom_node_get_base_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_child_nodes" symbol="webkit_dom_node_get_child_nodes">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_first_child" symbol="webkit_dom_node_get_first_child">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_last_child" symbol="webkit_dom_node_get_last_child">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_local_name" symbol="webkit_dom_node_get_local_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_namespace_uri" symbol="webkit_dom_node_get_namespace_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_next_sibling" symbol="webkit_dom_node_get_next_sibling">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_node_name" symbol="webkit_dom_node_get_node_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_node_type" symbol="webkit_dom_node_get_node_type">
				<return-type type="gushort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_node_value" symbol="webkit_dom_node_get_node_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_owner_document" symbol="webkit_dom_node_get_owner_document">
				<return-type type="WebKitDOMDocument*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_parent_element" symbol="webkit_dom_node_get_parent_element">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_parent_node" symbol="webkit_dom_node_get_parent_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_prefix" symbol="webkit_dom_node_get_prefix">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_previous_sibling" symbol="webkit_dom_node_get_previous_sibling">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_text_content" symbol="webkit_dom_node_get_text_content">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="has_attributes" symbol="webkit_dom_node_has_attributes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="has_child_nodes" symbol="webkit_dom_node_has_child_nodes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="insert_before" symbol="webkit_dom_node_insert_before">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="newChild" type="WebKitDOMNode*"/>
					<parameter name="refChild" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="is_default_namespace" symbol="webkit_dom_node_is_default_namespace">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="namespaceURI" type="gchar*"/>
				</parameters>
			</method>
			<method name="is_equal_node" symbol="webkit_dom_node_is_equal_node">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="other" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="is_same_node" symbol="webkit_dom_node_is_same_node">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="other" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="is_supported" symbol="webkit_dom_node_is_supported">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="feature" type="gchar*"/>
					<parameter name="version" type="gchar*"/>
				</parameters>
			</method>
			<method name="lookup_namespace_uri" symbol="webkit_dom_node_lookup_namespace_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="prefix" type="gchar*"/>
				</parameters>
			</method>
			<method name="lookup_prefix" symbol="webkit_dom_node_lookup_prefix">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="namespaceURI" type="gchar*"/>
				</parameters>
			</method>
			<method name="normalize" symbol="webkit_dom_node_normalize">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="remove_child" symbol="webkit_dom_node_remove_child">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="oldChild" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="replace_child" symbol="webkit_dom_node_replace_child">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="newChild" type="WebKitDOMNode*"/>
					<parameter name="oldChild" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_node_value" symbol="webkit_dom_node_set_node_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_prefix" symbol="webkit_dom_node_set_prefix">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_text_content" symbol="webkit_dom_node_set_text_content">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNode*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="base-uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="child-nodes" type="WebKitDOMNodeList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="first-child" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="last-child" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="local-name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="namespace-uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="next-sibling" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="node-name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="node-type" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="node-value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="owner-document" type="WebKitDOMDocument*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="parent-element" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="parent-node" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="prefix" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="previous-sibling" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="text-content" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMNodeFilter" parent="WebKitDOMObject" type-name="WebKitDOMNodeFilter" get-type="webkit_dom_node_filter_get_type">
			<method name="accept_node" symbol="webkit_dom_node_filter_accept_node">
				<return-type type="gshort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNodeFilter*"/>
					<parameter name="n" type="WebKitDOMNode*"/>
				</parameters>
			</method>
		</object>
		<object name="WebKitDOMNodeIterator" parent="WebKitDOMObject" type-name="WebKitDOMNodeIterator" get-type="webkit_dom_node_iterator_get_type">
			<method name="detach" symbol="webkit_dom_node_iterator_detach">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNodeIterator*"/>
				</parameters>
			</method>
			<method name="get_expand_entity_references" symbol="webkit_dom_node_iterator_get_expand_entity_references">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNodeIterator*"/>
				</parameters>
			</method>
			<method name="get_filter" symbol="webkit_dom_node_iterator_get_filter">
				<return-type type="WebKitDOMNodeFilter*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNodeIterator*"/>
				</parameters>
			</method>
			<method name="get_pointer_before_reference_node" symbol="webkit_dom_node_iterator_get_pointer_before_reference_node">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNodeIterator*"/>
				</parameters>
			</method>
			<method name="get_reference_node" symbol="webkit_dom_node_iterator_get_reference_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNodeIterator*"/>
				</parameters>
			</method>
			<method name="get_root" symbol="webkit_dom_node_iterator_get_root">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNodeIterator*"/>
				</parameters>
			</method>
			<method name="get_what_to_show" symbol="webkit_dom_node_iterator_get_what_to_show">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNodeIterator*"/>
				</parameters>
			</method>
			<method name="next_node" symbol="webkit_dom_node_iterator_next_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNodeIterator*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="previous_node" symbol="webkit_dom_node_iterator_previous_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNodeIterator*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="expand-entity-references" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="filter" type="WebKitDOMNodeFilter*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="pointer-before-reference-node" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="reference-node" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="root" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="what-to-show" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMNodeList" parent="WebKitDOMObject" type-name="WebKitDOMNodeList" get-type="webkit_dom_node_list_get_type">
			<method name="get_length" symbol="webkit_dom_node_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNodeList*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_node_list_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMNodeList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMObject" parent="GObject" type-name="WebKitDOMObject" get-type="webkit_dom_object_get_type">
			<property name="core-object" type="gpointer" readable="0" writable="1" construct="0" construct-only="1"/>
			<field name="coreObject" type="gpointer"/>
		</object>
		<object name="WebKitDOMPerformance" parent="WebKitDOMObject" type-name="WebKitDOMPerformance" get-type="webkit_dom_performance_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_memory" symbol="webkit_dom_performance_get_memory">
				<return-type type="void*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformance*"/>
				</parameters>
			</method>
			<method name="get_navigation" symbol="webkit_dom_performance_get_navigation">
				<return-type type="WebKitDOMPerformanceNavigation*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformance*"/>
				</parameters>
			</method>
			<method name="get_timing" symbol="webkit_dom_performance_get_timing">
				<return-type type="WebKitDOMPerformanceTiming*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformance*"/>
				</parameters>
			</method>
			<method name="now" symbol="webkit_dom_performance_now">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformance*"/>
				</parameters>
			</method>
			<property name="navigation" type="WebKitDOMPerformanceNavigation*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="timing" type="WebKitDOMPerformanceTiming*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMPerformanceEntry" parent="WebKitDOMObject" type-name="WebKitDOMPerformanceEntry" get-type="webkit_dom_performance_entry_get_type">
			<method name="get_duration" symbol="webkit_dom_performance_entry_get_duration">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceEntry*"/>
				</parameters>
			</method>
			<method name="get_entry_type" symbol="webkit_dom_performance_entry_get_entry_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceEntry*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_performance_entry_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceEntry*"/>
				</parameters>
			</method>
			<method name="get_start_time" symbol="webkit_dom_performance_entry_get_start_time">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceEntry*"/>
				</parameters>
			</method>
			<property name="duration" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="entry-type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="start-time" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMPerformanceEntryList" parent="WebKitDOMObject" type-name="WebKitDOMPerformanceEntryList" get-type="webkit_dom_performance_entry_list_get_type">
			<method name="get_length" symbol="webkit_dom_performance_entry_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceEntryList*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_performance_entry_list_item">
				<return-type type="WebKitDOMPerformanceEntry*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceEntryList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMPerformanceNavigation" parent="WebKitDOMObject" type-name="WebKitDOMPerformanceNavigation" get-type="webkit_dom_performance_navigation_get_type">
			<method name="get_redirect_count" symbol="webkit_dom_performance_navigation_get_redirect_count">
				<return-type type="gushort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceNavigation*"/>
				</parameters>
			</method>
			<property name="redirect-count" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="type" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMPerformanceTiming" parent="WebKitDOMObject" type-name="WebKitDOMPerformanceTiming" get-type="webkit_dom_performance_timing_get_type">
			<method name="get_connect_end" symbol="webkit_dom_performance_timing_get_connect_end">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_connect_start" symbol="webkit_dom_performance_timing_get_connect_start">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_dom_complete" symbol="webkit_dom_performance_timing_get_dom_complete">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_dom_content_loaded_event_end" symbol="webkit_dom_performance_timing_get_dom_content_loaded_event_end">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_dom_content_loaded_event_start" symbol="webkit_dom_performance_timing_get_dom_content_loaded_event_start">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_dom_interactive" symbol="webkit_dom_performance_timing_get_dom_interactive">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_dom_loading" symbol="webkit_dom_performance_timing_get_dom_loading">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_domain_lookup_end" symbol="webkit_dom_performance_timing_get_domain_lookup_end">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_domain_lookup_start" symbol="webkit_dom_performance_timing_get_domain_lookup_start">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_fetch_start" symbol="webkit_dom_performance_timing_get_fetch_start">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_load_event_end" symbol="webkit_dom_performance_timing_get_load_event_end">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_load_event_start" symbol="webkit_dom_performance_timing_get_load_event_start">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_navigation_start" symbol="webkit_dom_performance_timing_get_navigation_start">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_redirect_end" symbol="webkit_dom_performance_timing_get_redirect_end">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_redirect_start" symbol="webkit_dom_performance_timing_get_redirect_start">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_request_start" symbol="webkit_dom_performance_timing_get_request_start">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_response_end" symbol="webkit_dom_performance_timing_get_response_end">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_response_start" symbol="webkit_dom_performance_timing_get_response_start">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_secure_connection_start" symbol="webkit_dom_performance_timing_get_secure_connection_start">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_unload_event_end" symbol="webkit_dom_performance_timing_get_unload_event_end">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<method name="get_unload_event_start" symbol="webkit_dom_performance_timing_get_unload_event_start">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="self" type="WebKitDOMPerformanceTiming*"/>
				</parameters>
			</method>
			<property name="connect-end" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="connect-start" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="dom-complete" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="dom-content-loaded-event-end" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="dom-content-loaded-event-start" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="dom-interactive" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="dom-loading" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="domain-lookup-end" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="domain-lookup-start" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="fetch-start" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="load-event-end" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="load-event-start" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="navigation-start" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="redirect-end" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="redirect-start" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="request-start" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="response-end" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="response-start" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="secure-connection-start" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="unload-event-end" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="unload-event-start" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMProcessingInstruction" parent="WebKitDOMCharacterData" type-name="WebKitDOMProcessingInstruction" get-type="webkit_dom_processing_instruction_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_data" symbol="webkit_dom_processing_instruction_get_data">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMProcessingInstruction*"/>
				</parameters>
			</method>
			<method name="get_sheet" symbol="webkit_dom_processing_instruction_get_sheet">
				<return-type type="WebKitDOMStyleSheet*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMProcessingInstruction*"/>
				</parameters>
			</method>
			<method name="get_target" symbol="webkit_dom_processing_instruction_get_target">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMProcessingInstruction*"/>
				</parameters>
			</method>
			<method name="set_data" symbol="webkit_dom_processing_instruction_set_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMProcessingInstruction*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="sheet" type="WebKitDOMStyleSheet*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="target" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMPropertyNodeList" parent="WebKitDOMNodeList" type-name="WebKitDOMPropertyNodeList" get-type="webkit_dom_property_node_list_get_type">
			<method name="get_length" symbol="webkit_dom_property_node_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="void*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_property_node_list_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="void*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMRange" parent="WebKitDOMObject" type-name="WebKitDOMRange" get-type="webkit_dom_range_get_type">
			<method name="clone_contents" symbol="webkit_dom_range_clone_contents">
				<return-type type="WebKitDOMDocumentFragment*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="clone_range" symbol="webkit_dom_range_clone_range">
				<return-type type="WebKitDOMRange*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="collapse" symbol="webkit_dom_range_collapse">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="toStart" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="compare_boundary_points" symbol="webkit_dom_range_compare_boundary_points">
				<return-type type="gshort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="how" type="gushort"/>
					<parameter name="sourceRange" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="compare_node" symbol="webkit_dom_range_compare_node">
				<return-type type="gshort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="refNode" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="compare_point" symbol="webkit_dom_range_compare_point">
				<return-type type="gshort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="refNode" type="WebKitDOMNode*"/>
					<parameter name="offset" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_contextual_fragment" symbol="webkit_dom_range_create_contextual_fragment">
				<return-type type="WebKitDOMDocumentFragment*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="html" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="delete_contents" symbol="webkit_dom_range_delete_contents">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="detach" symbol="webkit_dom_range_detach">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="expand" symbol="webkit_dom_range_expand">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="unit" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="extract_contents" symbol="webkit_dom_range_extract_contents">
				<return-type type="WebKitDOMDocumentFragment*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_collapsed" symbol="webkit_dom_range_get_collapsed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_common_ancestor_container" symbol="webkit_dom_range_get_common_ancestor_container">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_end_container" symbol="webkit_dom_range_get_end_container">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_end_offset" symbol="webkit_dom_range_get_end_offset">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_start_container" symbol="webkit_dom_range_get_start_container">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_start_offset" symbol="webkit_dom_range_get_start_offset">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_text" symbol="webkit_dom_range_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
				</parameters>
			</method>
			<method name="insert_node" symbol="webkit_dom_range_insert_node">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="newNode" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="intersects_node" symbol="webkit_dom_range_intersects_node">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="refNode" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="is_point_in_range" symbol="webkit_dom_range_is_point_in_range">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="refNode" type="WebKitDOMNode*"/>
					<parameter name="offset" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="select_node" symbol="webkit_dom_range_select_node">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="refNode" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="select_node_contents" symbol="webkit_dom_range_select_node_contents">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="refNode" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_end" symbol="webkit_dom_range_set_end">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="refNode" type="WebKitDOMNode*"/>
					<parameter name="offset" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_end_after" symbol="webkit_dom_range_set_end_after">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="refNode" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_end_before" symbol="webkit_dom_range_set_end_before">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="refNode" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_start" symbol="webkit_dom_range_set_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="refNode" type="WebKitDOMNode*"/>
					<parameter name="offset" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_start_after" symbol="webkit_dom_range_set_start_after">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="refNode" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_start_before" symbol="webkit_dom_range_set_start_before">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="refNode" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="surround_contents" symbol="webkit_dom_range_surround_contents">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="newParent" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="to_string" symbol="webkit_dom_range_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMRange*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="collapsed" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="common-ancestor-container" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="end-container" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="end-offset" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="start-container" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="start-offset" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMScreen" parent="WebKitDOMObject" type-name="WebKitDOMScreen" get-type="webkit_dom_screen_get_type">
			<method name="get_avail_height" symbol="webkit_dom_screen_get_avail_height">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMScreen*"/>
				</parameters>
			</method>
			<method name="get_avail_left" symbol="webkit_dom_screen_get_avail_left">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMScreen*"/>
				</parameters>
			</method>
			<method name="get_avail_top" symbol="webkit_dom_screen_get_avail_top">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMScreen*"/>
				</parameters>
			</method>
			<method name="get_avail_width" symbol="webkit_dom_screen_get_avail_width">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMScreen*"/>
				</parameters>
			</method>
			<method name="get_color_depth" symbol="webkit_dom_screen_get_color_depth">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMScreen*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="webkit_dom_screen_get_height">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMScreen*"/>
				</parameters>
			</method>
			<method name="get_pixel_depth" symbol="webkit_dom_screen_get_pixel_depth">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMScreen*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="webkit_dom_screen_get_width">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMScreen*"/>
				</parameters>
			</method>
			<property name="avail-height" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="avail-left" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="avail-top" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="avail-width" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="color-depth" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="height" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="pixel-depth" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="width" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMShadowRoot" parent="WebKitDOMDocumentFragment" type-name="WebKitDOMShadowRoot" get-type="webkit_dom_shadow_root_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="element_from_point" symbol="webkit_dom_shadow_root_element_from_point">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
					<parameter name="x" type="glong"/>
					<parameter name="y" type="glong"/>
				</parameters>
			</method>
			<method name="get_active_element" symbol="webkit_dom_shadow_root_get_active_element">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
				</parameters>
			</method>
			<method name="get_apply_author_styles" symbol="webkit_dom_shadow_root_get_apply_author_styles">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
				</parameters>
			</method>
			<method name="get_element_by_id" symbol="webkit_dom_shadow_root_get_element_by_id">
				<return-type type="WebKitDOMElement*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
					<parameter name="elementId" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_elements_by_class_name" symbol="webkit_dom_shadow_root_get_elements_by_class_name">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
					<parameter name="className" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_elements_by_tag_name" symbol="webkit_dom_shadow_root_get_elements_by_tag_name">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
					<parameter name="tagName" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_elements_by_tag_name_ns" symbol="webkit_dom_shadow_root_get_elements_by_tag_name_ns">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
					<parameter name="namespaceURI" type="gchar*"/>
					<parameter name="localName" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_inner_html" symbol="webkit_dom_shadow_root_get_inner_html">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
				</parameters>
			</method>
			<method name="get_reset_style_inheritance" symbol="webkit_dom_shadow_root_get_reset_style_inheritance">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
				</parameters>
			</method>
			<method name="get_selection" symbol="webkit_dom_shadow_root_get_selection">
				<return-type type="WebKitDOMDOMSelection*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
				</parameters>
			</method>
			<method name="set_apply_author_styles" symbol="webkit_dom_shadow_root_set_apply_author_styles">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_inner_html" symbol="webkit_dom_shadow_root_set_inner_html">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_reset_style_inheritance" symbol="webkit_dom_shadow_root_set_reset_style_inheritance">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMShadowRoot*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="active-element" type="WebKitDOMElement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="apply-author-styles" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="inner-html" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="reset-style-inheritance" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMStorage" parent="WebKitDOMObject" type-name="WebKitDOMStorage" get-type="webkit_dom_storage_get_type">
			<method name="clear" symbol="webkit_dom_storage_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStorage*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_item" symbol="webkit_dom_storage_get_item">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStorage*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_storage_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStorage*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="key" symbol="webkit_dom_storage_key">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStorage*"/>
					<parameter name="index" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="remove_item" symbol="webkit_dom_storage_remove_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStorage*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_item" symbol="webkit_dom_storage_set_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStorage*"/>
					<parameter name="key" type="gchar*"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMStorageInfo" parent="WebKitDOMObject" type-name="WebKitDOMStorageInfo" get-type="webkit_dom_storage_info_get_type">
		</object>
		<object name="WebKitDOMStorageQuota" parent="WebKitDOMObject" type-name="WebKitDOMStorageQuota" get-type="webkit_dom_storage_quota_get_type">
		</object>
		<object name="WebKitDOMStyleMedia" parent="WebKitDOMObject" type-name="WebKitDOMStyleMedia" get-type="webkit_dom_style_media_get_type">
			<method name="match_medium" symbol="webkit_dom_style_media_match_medium">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStyleMedia*"/>
					<parameter name="mediaquery" type="gchar*"/>
				</parameters>
			</method>
			<property name="type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMStyleSheet" parent="WebKitDOMObject" type-name="WebKitDOMStyleSheet" get-type="webkit_dom_style_sheet_get_type">
			<method name="get_disabled" symbol="webkit_dom_style_sheet_get_disabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStyleSheet*"/>
				</parameters>
			</method>
			<method name="get_href" symbol="webkit_dom_style_sheet_get_href">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStyleSheet*"/>
				</parameters>
			</method>
			<method name="get_media" symbol="webkit_dom_style_sheet_get_media">
				<return-type type="WebKitDOMMediaList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStyleSheet*"/>
				</parameters>
			</method>
			<method name="get_owner_node" symbol="webkit_dom_style_sheet_get_owner_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStyleSheet*"/>
				</parameters>
			</method>
			<method name="get_parent_style_sheet" symbol="webkit_dom_style_sheet_get_parent_style_sheet">
				<return-type type="WebKitDOMStyleSheet*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStyleSheet*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="webkit_dom_style_sheet_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStyleSheet*"/>
				</parameters>
			</method>
			<method name="set_disabled" symbol="webkit_dom_style_sheet_set_disabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStyleSheet*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="disabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="href" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="media" type="WebKitDOMMediaList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="owner-node" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="parent-style-sheet" type="WebKitDOMStyleSheet*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMStyleSheetList" parent="WebKitDOMObject" type-name="WebKitDOMStyleSheetList" get-type="webkit_dom_style_sheet_list_get_type">
			<method name="get_length" symbol="webkit_dom_style_sheet_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStyleSheetList*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_style_sheet_list_item">
				<return-type type="WebKitDOMStyleSheet*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMStyleSheetList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMText" parent="WebKitDOMCharacterData" type-name="WebKitDOMText" get-type="webkit_dom_text_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="get_whole_text" symbol="webkit_dom_text_get_whole_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMText*"/>
				</parameters>
			</method>
			<method name="replace_whole_text" symbol="webkit_dom_text_replace_whole_text">
				<return-type type="WebKitDOMText*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMText*"/>
					<parameter name="content" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="split_text" symbol="webkit_dom_text_split_text">
				<return-type type="WebKitDOMText*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMText*"/>
					<parameter name="offset" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="whole-text" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMTextTrack" parent="WebKitDOMObject" type-name="WebKitDOMTextTrack" get-type="webkit_dom_text_track_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="add_cue" symbol="webkit_dom_text_track_add_cue">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrack*"/>
					<parameter name="cue" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="dispatch_event" symbol="webkit_dom_text_track_dispatch_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrack*"/>
					<parameter name="evt" type="WebKitDOMEvent*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_active_cues" symbol="webkit_dom_text_track_get_active_cues">
				<return-type type="WebKitDOMTextTrackCueList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrack*"/>
				</parameters>
			</method>
			<method name="get_cues" symbol="webkit_dom_text_track_get_cues">
				<return-type type="WebKitDOMTextTrackCueList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrack*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="webkit_dom_text_track_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrack*"/>
				</parameters>
			</method>
			<method name="get_kind" symbol="webkit_dom_text_track_get_kind">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrack*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="webkit_dom_text_track_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrack*"/>
				</parameters>
			</method>
			<method name="get_language" symbol="webkit_dom_text_track_get_language">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrack*"/>
				</parameters>
			</method>
			<method name="get_mode" symbol="webkit_dom_text_track_get_mode">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrack*"/>
				</parameters>
			</method>
			<method name="remove_cue" symbol="webkit_dom_text_track_remove_cue">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrack*"/>
					<parameter name="cue" type="WebKitDOMTextTrackCue*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_mode" symbol="webkit_dom_text_track_set_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrack*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="active-cues" type="WebKitDOMTextTrackCueList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="cues" type="WebKitDOMTextTrackCueList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="kind" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="language" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="mode" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMTextTrackCue" parent="WebKitDOMObject" type-name="WebKitDOMTextTrackCue" get-type="webkit_dom_text_track_cue_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="dispatch_event" symbol="webkit_dom_text_track_cue_dispatch_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
					<parameter name="evt" type="WebKitDOMEvent*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_align" symbol="webkit_dom_text_track_cue_get_align">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="get_cue_as_html" symbol="webkit_dom_text_track_cue_get_cue_as_html">
				<return-type type="WebKitDOMDocumentFragment*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="get_end_time" symbol="webkit_dom_text_track_cue_get_end_time">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="webkit_dom_text_track_cue_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="get_line" symbol="webkit_dom_text_track_cue_get_line">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="get_pause_on_exit" symbol="webkit_dom_text_track_cue_get_pause_on_exit">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="get_position" symbol="webkit_dom_text_track_cue_get_position">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="webkit_dom_text_track_cue_get_size">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="get_snap_to_lines" symbol="webkit_dom_text_track_cue_get_snap_to_lines">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="get_start_time" symbol="webkit_dom_text_track_cue_get_start_time">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="webkit_dom_text_track_cue_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="get_track" symbol="webkit_dom_text_track_cue_get_track">
				<return-type type="WebKitDOMTextTrack*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="get_vertical" symbol="webkit_dom_text_track_cue_get_vertical">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
				</parameters>
			</method>
			<method name="set_align" symbol="webkit_dom_text_track_cue_set_align">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_end_time" symbol="webkit_dom_text_track_cue_set_end_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
					<parameter name="value" type="gdouble"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_id" symbol="webkit_dom_text_track_cue_set_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_line" symbol="webkit_dom_text_track_cue_set_line">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
					<parameter name="value" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_pause_on_exit" symbol="webkit_dom_text_track_cue_set_pause_on_exit">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_position" symbol="webkit_dom_text_track_cue_set_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
					<parameter name="value" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_size" symbol="webkit_dom_text_track_cue_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
					<parameter name="value" type="glong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_snap_to_lines" symbol="webkit_dom_text_track_cue_set_snap_to_lines">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_start_time" symbol="webkit_dom_text_track_cue_set_start_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
					<parameter name="value" type="gdouble"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_text" symbol="webkit_dom_text_track_cue_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_vertical" symbol="webkit_dom_text_track_cue_set_vertical">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCue*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="align" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="end-time" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="id" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="line" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pause-on-exit" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="position" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="size" type="glong" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="snap-to-lines" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="start-time" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="track" type="WebKitDOMTextTrack*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="vertical" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMTextTrackCueList" parent="WebKitDOMObject" type-name="WebKitDOMTextTrackCueList" get-type="webkit_dom_text_track_cue_list_get_type">
			<method name="get_cue_by_id" symbol="webkit_dom_text_track_cue_list_get_cue_by_id">
				<return-type type="WebKitDOMTextTrackCue*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCueList*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_text_track_cue_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCueList*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_text_track_cue_list_item">
				<return-type type="WebKitDOMTextTrackCue*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackCueList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMTextTrackList" parent="WebKitDOMObject" type-name="WebKitDOMTextTrackList" get-type="webkit_dom_text_track_list_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="dispatch_event" symbol="webkit_dom_text_track_list_dispatch_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackList*"/>
					<parameter name="evt" type="WebKitDOMEvent*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_text_track_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackList*"/>
				</parameters>
			</method>
			<method name="get_track_by_id" symbol="webkit_dom_text_track_list_get_track_by_id">
				<return-type type="WebKitDOMTextTrack*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackList*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_text_track_list_item">
				<return-type type="WebKitDOMTextTrack*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTextTrackList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMTimeRanges" parent="WebKitDOMObject" type-name="WebKitDOMTimeRanges" get-type="webkit_dom_time_ranges_get_type">
			<method name="end" symbol="webkit_dom_time_ranges_end">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTimeRanges*"/>
					<parameter name="index" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_time_ranges_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTimeRanges*"/>
				</parameters>
			</method>
			<method name="start" symbol="webkit_dom_time_ranges_start">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTimeRanges*"/>
					<parameter name="index" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMTouch" parent="WebKitDOMObject" type-name="WebKitDOMTouch" get-type="webkit_dom_touch_get_type">
			<method name="get_client_x" symbol="webkit_dom_touch_get_client_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTouch*"/>
				</parameters>
			</method>
			<method name="get_client_y" symbol="webkit_dom_touch_get_client_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTouch*"/>
				</parameters>
			</method>
			<method name="get_identifier" symbol="webkit_dom_touch_get_identifier">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTouch*"/>
				</parameters>
			</method>
			<method name="get_page_x" symbol="webkit_dom_touch_get_page_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTouch*"/>
				</parameters>
			</method>
			<method name="get_page_y" symbol="webkit_dom_touch_get_page_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTouch*"/>
				</parameters>
			</method>
			<method name="get_screen_x" symbol="webkit_dom_touch_get_screen_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTouch*"/>
				</parameters>
			</method>
			<method name="get_screen_y" symbol="webkit_dom_touch_get_screen_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTouch*"/>
				</parameters>
			</method>
			<method name="get_target" symbol="webkit_dom_touch_get_target">
				<return-type type="WebKitDOMEventTarget*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTouch*"/>
				</parameters>
			</method>
			<method name="get_webkit_force" symbol="webkit_dom_touch_get_webkit_force">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTouch*"/>
				</parameters>
			</method>
			<method name="get_webkit_radius_x" symbol="webkit_dom_touch_get_webkit_radius_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTouch*"/>
				</parameters>
			</method>
			<method name="get_webkit_radius_y" symbol="webkit_dom_touch_get_webkit_radius_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTouch*"/>
				</parameters>
			</method>
			<method name="get_webkit_rotation_angle" symbol="webkit_dom_touch_get_webkit_rotation_angle">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTouch*"/>
				</parameters>
			</method>
			<property name="client-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="client-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="identifier" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="page-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="page-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="screen-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="screen-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="target" type="WebKitDOMEventTarget*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-force" type="gfloat" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-radius-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-radius-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-rotation-angle" type="gfloat" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMTrackEvent" parent="WebKitDOMEvent" type-name="WebKitDOMTrackEvent" get-type="webkit_dom_track_event_get_type">
		</object>
		<object name="WebKitDOMTreeWalker" parent="WebKitDOMObject" type-name="WebKitDOMTreeWalker" get-type="webkit_dom_tree_walker_get_type">
			<method name="first_child" symbol="webkit_dom_tree_walker_first_child">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
				</parameters>
			</method>
			<method name="get_current_node" symbol="webkit_dom_tree_walker_get_current_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
				</parameters>
			</method>
			<method name="get_expand_entity_references" symbol="webkit_dom_tree_walker_get_expand_entity_references">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
				</parameters>
			</method>
			<method name="get_filter" symbol="webkit_dom_tree_walker_get_filter">
				<return-type type="WebKitDOMNodeFilter*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
				</parameters>
			</method>
			<method name="get_root" symbol="webkit_dom_tree_walker_get_root">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
				</parameters>
			</method>
			<method name="get_what_to_show" symbol="webkit_dom_tree_walker_get_what_to_show">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
				</parameters>
			</method>
			<method name="last_child" symbol="webkit_dom_tree_walker_last_child">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
				</parameters>
			</method>
			<method name="next_node" symbol="webkit_dom_tree_walker_next_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
				</parameters>
			</method>
			<method name="next_sibling" symbol="webkit_dom_tree_walker_next_sibling">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
				</parameters>
			</method>
			<method name="parent_node" symbol="webkit_dom_tree_walker_parent_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
				</parameters>
			</method>
			<method name="previous_node" symbol="webkit_dom_tree_walker_previous_node">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
				</parameters>
			</method>
			<method name="previous_sibling" symbol="webkit_dom_tree_walker_previous_sibling">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
				</parameters>
			</method>
			<method name="set_current_node" symbol="webkit_dom_tree_walker_set_current_node">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMTreeWalker*"/>
					<parameter name="value" type="WebKitDOMNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="current-node" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="expand-entity-references" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="filter" type="WebKitDOMNodeFilter*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="root" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="what-to-show" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMUIEvent" parent="WebKitDOMEvent" type-name="WebKitDOMUIEvent" get-type="webkit_dom_ui_event_get_type">
			<method name="get_char_code" symbol="webkit_dom_ui_event_get_char_code">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMUIEvent*"/>
				</parameters>
			</method>
			<method name="get_detail" symbol="webkit_dom_ui_event_get_detail">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMUIEvent*"/>
				</parameters>
			</method>
			<method name="get_key_code" symbol="webkit_dom_ui_event_get_key_code">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMUIEvent*"/>
				</parameters>
			</method>
			<method name="get_layer_x" symbol="webkit_dom_ui_event_get_layer_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMUIEvent*"/>
				</parameters>
			</method>
			<method name="get_layer_y" symbol="webkit_dom_ui_event_get_layer_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMUIEvent*"/>
				</parameters>
			</method>
			<method name="get_page_x" symbol="webkit_dom_ui_event_get_page_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMUIEvent*"/>
				</parameters>
			</method>
			<method name="get_page_y" symbol="webkit_dom_ui_event_get_page_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMUIEvent*"/>
				</parameters>
			</method>
			<method name="get_view" symbol="webkit_dom_ui_event_get_view">
				<return-type type="WebKitDOMDOMWindow*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMUIEvent*"/>
				</parameters>
			</method>
			<method name="get_which" symbol="webkit_dom_ui_event_get_which">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMUIEvent*"/>
				</parameters>
			</method>
			<method name="init_ui_event" symbol="webkit_dom_ui_event_init_ui_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMUIEvent*"/>
					<parameter name="type" type="gchar*"/>
					<parameter name="canBubble" type="gboolean"/>
					<parameter name="cancelable" type="gboolean"/>
					<parameter name="view" type="WebKitDOMDOMWindow*"/>
					<parameter name="detail" type="glong"/>
				</parameters>
			</method>
			<property name="char-code" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="detail" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="key-code" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="layer-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="layer-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="page-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="page-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="view" type="WebKitDOMDOMWindow*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="which" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMValidityState" parent="WebKitDOMObject" type-name="WebKitDOMValidityState" get-type="webkit_dom_validity_state_get_type">
			<method name="get_bad_input" symbol="webkit_dom_validity_state_get_bad_input">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMValidityState*"/>
				</parameters>
			</method>
			<method name="get_custom_error" symbol="webkit_dom_validity_state_get_custom_error">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMValidityState*"/>
				</parameters>
			</method>
			<method name="get_pattern_mismatch" symbol="webkit_dom_validity_state_get_pattern_mismatch">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMValidityState*"/>
				</parameters>
			</method>
			<method name="get_range_overflow" symbol="webkit_dom_validity_state_get_range_overflow">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMValidityState*"/>
				</parameters>
			</method>
			<method name="get_range_underflow" symbol="webkit_dom_validity_state_get_range_underflow">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMValidityState*"/>
				</parameters>
			</method>
			<method name="get_step_mismatch" symbol="webkit_dom_validity_state_get_step_mismatch">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMValidityState*"/>
				</parameters>
			</method>
			<method name="get_too_long" symbol="webkit_dom_validity_state_get_too_long">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMValidityState*"/>
				</parameters>
			</method>
			<method name="get_type_mismatch" symbol="webkit_dom_validity_state_get_type_mismatch">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMValidityState*"/>
				</parameters>
			</method>
			<method name="get_valid" symbol="webkit_dom_validity_state_get_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMValidityState*"/>
				</parameters>
			</method>
			<method name="get_value_missing" symbol="webkit_dom_validity_state_get_value_missing">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMValidityState*"/>
				</parameters>
			</method>
			<property name="bad-input" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="custom-error" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="pattern-mismatch" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="range-overflow" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="range-underflow" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="step-mismatch" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="too-long" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="type-mismatch" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="valid" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="value-missing" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMVideoPlaybackQuality" parent="WebKitDOMObject" type-name="WebKitDOMVideoPlaybackQuality" get-type="webkit_dom_video_playback_quality_get_type">
			<method name="get_corrupted_video_frames" symbol="webkit_dom_video_playback_quality_get_corrupted_video_frames">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoPlaybackQuality*"/>
				</parameters>
			</method>
			<method name="get_creation_time" symbol="webkit_dom_video_playback_quality_get_creation_time">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoPlaybackQuality*"/>
				</parameters>
			</method>
			<method name="get_dropped_video_frames" symbol="webkit_dom_video_playback_quality_get_dropped_video_frames">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoPlaybackQuality*"/>
				</parameters>
			</method>
			<method name="get_total_frame_delay" symbol="webkit_dom_video_playback_quality_get_total_frame_delay">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoPlaybackQuality*"/>
				</parameters>
			</method>
			<method name="get_total_video_frames" symbol="webkit_dom_video_playback_quality_get_total_video_frames">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoPlaybackQuality*"/>
				</parameters>
			</method>
			<property name="corrupted-video-frames" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="creation-time" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="dropped-video-frames" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="total-frame-delay" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="total-video-frames" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMVideoTrack" parent="WebKitDOMObject" type-name="WebKitDOMVideoTrack" get-type="webkit_dom_video_track_get_type">
			<method name="get_id" symbol="webkit_dom_video_track_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoTrack*"/>
				</parameters>
			</method>
			<method name="get_kind" symbol="webkit_dom_video_track_get_kind">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoTrack*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="webkit_dom_video_track_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoTrack*"/>
				</parameters>
			</method>
			<method name="get_language" symbol="webkit_dom_video_track_get_language">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoTrack*"/>
				</parameters>
			</method>
			<method name="get_selected" symbol="webkit_dom_video_track_get_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoTrack*"/>
				</parameters>
			</method>
			<method name="set_selected" symbol="webkit_dom_video_track_set_selected">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoTrack*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="kind" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="language" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="selected" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMVideoTrackList" parent="WebKitDOMObject" type-name="WebKitDOMVideoTrackList" get-type="webkit_dom_video_track_list_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="dispatch_event" symbol="webkit_dom_video_track_list_dispatch_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoTrackList*"/>
					<parameter name="evt" type="WebKitDOMEvent*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_length" symbol="webkit_dom_video_track_list_get_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoTrackList*"/>
				</parameters>
			</method>
			<method name="get_track_by_id" symbol="webkit_dom_video_track_list_get_track_by_id">
				<return-type type="WebKitDOMVideoTrack*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoTrackList*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="item" symbol="webkit_dom_video_track_list_item">
				<return-type type="WebKitDOMVideoTrack*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMVideoTrackList*"/>
					<parameter name="index" type="gulong"/>
				</parameters>
			</method>
			<property name="length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMWebKitNamedFlow" parent="WebKitDOMObject" type-name="WebKitDOMWebKitNamedFlow" get-type="webkit_dom_webkit_named_flow_get_type">
			<implements>
				<interface name="WebKitDOMEventTarget"/>
			</implements>
			<method name="dispatch_event" symbol="webkit_dom_webkit_named_flow_dispatch_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWebKitNamedFlow*"/>
					<parameter name="event" type="WebKitDOMEvent*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_content" symbol="webkit_dom_webkit_named_flow_get_content">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWebKitNamedFlow*"/>
				</parameters>
			</method>
			<method name="get_content_nodes" symbol="webkit_dom_webkit_named_flow_get_content_nodes">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="flow" type="WebKitDOMWebKitNamedFlow*"/>
				</parameters>
			</method>
			<method name="get_first_empty_region_index" symbol="webkit_dom_webkit_named_flow_get_first_empty_region_index">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWebKitNamedFlow*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_dom_webkit_named_flow_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWebKitNamedFlow*"/>
				</parameters>
			</method>
			<method name="get_overflow" symbol="webkit_dom_webkit_named_flow_get_overflow">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="flow" type="WebKitDOMWebKitNamedFlow*"/>
				</parameters>
			</method>
			<method name="get_overset" symbol="webkit_dom_webkit_named_flow_get_overset">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWebKitNamedFlow*"/>
				</parameters>
			</method>
			<method name="get_regions" symbol="webkit_dom_webkit_named_flow_get_regions">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWebKitNamedFlow*"/>
				</parameters>
			</method>
			<method name="get_regions_by_content" symbol="webkit_dom_webkit_named_flow_get_regions_by_content">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWebKitNamedFlow*"/>
					<parameter name="contentNode" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="get_regions_by_content_node" symbol="webkit_dom_webkit_named_flow_get_regions_by_content_node">
				<return-type type="WebKitDOMNodeList*"/>
				<parameters>
					<parameter name="flow" type="WebKitDOMWebKitNamedFlow*"/>
					<parameter name="content_node" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<property name="first-empty-region-index" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="overset" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMWebKitPoint" parent="WebKitDOMObject" type-name="WebKitDOMWebKitPoint" get-type="webkit_dom_webkit_point_get_type">
			<method name="get_x" symbol="webkit_dom_webkit_point_get_x">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWebKitPoint*"/>
				</parameters>
			</method>
			<method name="get_y" symbol="webkit_dom_webkit_point_get_y">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWebKitPoint*"/>
				</parameters>
			</method>
			<method name="set_x" symbol="webkit_dom_webkit_point_set_x">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWebKitPoint*"/>
					<parameter name="value" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_y" symbol="webkit_dom_webkit_point_set_y">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWebKitPoint*"/>
					<parameter name="value" type="gfloat"/>
				</parameters>
			</method>
			<property name="x" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="y" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMWheelEvent" parent="WebKitDOMMouseEvent" type-name="WebKitDOMWheelEvent" get-type="webkit_dom_wheel_event_get_type">
			<method name="get_delta_mode" symbol="webkit_dom_wheel_event_get_delta_mode">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWheelEvent*"/>
				</parameters>
			</method>
			<method name="get_delta_x" symbol="webkit_dom_wheel_event_get_delta_x">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWheelEvent*"/>
				</parameters>
			</method>
			<method name="get_delta_y" symbol="webkit_dom_wheel_event_get_delta_y">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWheelEvent*"/>
				</parameters>
			</method>
			<method name="get_delta_z" symbol="webkit_dom_wheel_event_get_delta_z">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWheelEvent*"/>
				</parameters>
			</method>
			<method name="get_webkit_direction_inverted_from_device" symbol="webkit_dom_wheel_event_get_webkit_direction_inverted_from_device">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWheelEvent*"/>
				</parameters>
			</method>
			<method name="get_wheel_delta" symbol="webkit_dom_wheel_event_get_wheel_delta">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWheelEvent*"/>
				</parameters>
			</method>
			<method name="get_wheel_delta_x" symbol="webkit_dom_wheel_event_get_wheel_delta_x">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWheelEvent*"/>
				</parameters>
			</method>
			<method name="get_wheel_delta_y" symbol="webkit_dom_wheel_event_get_wheel_delta_y">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWheelEvent*"/>
				</parameters>
			</method>
			<method name="init_wheel_event" symbol="webkit_dom_wheel_event_init_wheel_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="WebKitDOMWheelEvent*"/>
					<parameter name="wheelDeltaX" type="glong"/>
					<parameter name="wheelDeltaY" type="glong"/>
					<parameter name="view" type="WebKitDOMDOMWindow*"/>
					<parameter name="screenX" type="glong"/>
					<parameter name="screenY" type="glong"/>
					<parameter name="clientX" type="glong"/>
					<parameter name="clientY" type="glong"/>
					<parameter name="ctrlKey" type="gboolean"/>
					<parameter name="altKey" type="gboolean"/>
					<parameter name="shiftKey" type="gboolean"/>
					<parameter name="metaKey" type="gboolean"/>
				</parameters>
			</method>
			<property name="delta-mode" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="delta-x" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="delta-y" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="delta-z" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="webkit-direction-inverted-from-device" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="wheel-delta" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="wheel-delta-x" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="wheel-delta-y" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDOMXPathExpression" parent="WebKitDOMObject" type-name="WebKitDOMXPathExpression" get-type="webkit_dom_xpath_expression_get_type">
			<method name="evaluate" symbol="webkit_dom_xpath_expression_evaluate">
				<return-type type="WebKitDOMXPathResult*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMXPathExpression*"/>
					<parameter name="contextNode" type="WebKitDOMNode*"/>
					<parameter name="type" type="gushort"/>
					<parameter name="inResult" type="WebKitDOMXPathResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</object>
		<object name="WebKitDOMXPathNSResolver" parent="WebKitDOMObject" type-name="WebKitDOMXPathNSResolver" get-type="webkit_dom_xpath_ns_resolver_get_type">
			<method name="lookup_namespace_uri" symbol="webkit_dom_xpath_ns_resolver_lookup_namespace_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMXPathNSResolver*"/>
					<parameter name="prefix" type="gchar*"/>
				</parameters>
			</method>
		</object>
		<object name="WebKitDOMXPathResult" parent="WebKitDOMObject" type-name="WebKitDOMXPathResult" get-type="webkit_dom_xpath_result_get_type">
			<method name="get_boolean_value" symbol="webkit_dom_xpath_result_get_boolean_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMXPathResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_invalid_iterator_state" symbol="webkit_dom_xpath_result_get_invalid_iterator_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="WebKitDOMXPathResult*"/>
				</parameters>
			</method>
			<method name="get_number_value" symbol="webkit_dom_xpath_result_get_number_value">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="WebKitDOMXPathResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_result_type" symbol="webkit_dom_xpath_result_get_result_type">
				<return-type type="gushort"/>
				<parameters>
					<parameter name="self" type="WebKitDOMXPathResult*"/>
				</parameters>
			</method>
			<method name="get_single_node_value" symbol="webkit_dom_xpath_result_get_single_node_value">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMXPathResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_snapshot_length" symbol="webkit_dom_xpath_result_get_snapshot_length">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="self" type="WebKitDOMXPathResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_string_value" symbol="webkit_dom_xpath_result_get_string_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMXPathResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="iterate_next" symbol="webkit_dom_xpath_result_iterate_next">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMXPathResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="snapshot_item" symbol="webkit_dom_xpath_result_snapshot_item">
				<return-type type="WebKitDOMNode*"/>
				<parameters>
					<parameter name="self" type="WebKitDOMXPathResult*"/>
					<parameter name="index" type="gulong"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="boolean-value" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="invalid-iterator-state" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="number-value" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="result-type" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="single-node-value" type="WebKitDOMNode*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="snapshot-length" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="string-value" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitDownload" parent="GObject" type-name="WebKitDownload" get-type="webkit_download_get_type">
			<method name="cancel" symbol="webkit_download_cancel">
				<return-type type="void"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
				</parameters>
			</method>
			<method name="get_current_size" symbol="webkit_download_get_current_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
				</parameters>
			</method>
			<method name="get_destination_uri" symbol="webkit_download_get_destination_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
				</parameters>
			</method>
			<method name="get_elapsed_time" symbol="webkit_download_get_elapsed_time">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
				</parameters>
			</method>
			<method name="get_network_request" symbol="webkit_download_get_network_request">
				<return-type type="WebKitNetworkRequest*"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
				</parameters>
			</method>
			<method name="get_network_response" symbol="webkit_download_get_network_response">
				<return-type type="WebKitNetworkResponse*"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
				</parameters>
			</method>
			<method name="get_progress" symbol="webkit_download_get_progress">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
				</parameters>
			</method>
			<method name="get_status" symbol="webkit_download_get_status">
				<return-type type="WebKitDownloadStatus"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
				</parameters>
			</method>
			<method name="get_suggested_filename" symbol="webkit_download_get_suggested_filename">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
				</parameters>
			</method>
			<method name="get_total_size" symbol="webkit_download_get_total_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="webkit_download_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="webkit_download_new">
				<return-type type="WebKitDownload*"/>
				<parameters>
					<parameter name="request" type="WebKitNetworkRequest*"/>
				</parameters>
			</constructor>
			<method name="set_destination_uri" symbol="webkit_download_set_destination_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
					<parameter name="destination_uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="start" symbol="webkit_download_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="download" type="WebKitDownload*"/>
				</parameters>
			</method>
			<property name="current-size" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="destination-uri" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="network-request" type="WebKitNetworkRequest*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="network-response" type="WebKitNetworkResponse*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="progress" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="status" type="WebKitDownloadStatus" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="suggested-filename" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="total-size" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="error" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitDownload*"/>
					<parameter name="p0" type="gint"/>
					<parameter name="p1" type="gint"/>
					<parameter name="p2" type="char*"/>
				</parameters>
			</signal>
		</object>
		<object name="WebKitFaviconDatabase" parent="GObject" type-name="WebKitFaviconDatabase" get-type="webkit_favicon_database_get_type">
			<method name="clear" symbol="webkit_favicon_database_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="database" type="WebKitFaviconDatabase*"/>
				</parameters>
			</method>
			<method name="get_favicon_pixbuf" symbol="webkit_favicon_database_get_favicon_pixbuf">
				<return-type type="void"/>
				<parameters>
					<parameter name="database" type="WebKitFaviconDatabase*"/>
					<parameter name="page_uri" type="gchar*"/>
					<parameter name="width" type="guint"/>
					<parameter name="height" type="guint"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_favicon_pixbuf_finish" symbol="webkit_favicon_database_get_favicon_pixbuf_finish">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="database" type="WebKitFaviconDatabase*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_favicon_uri" symbol="webkit_favicon_database_get_favicon_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="database" type="WebKitFaviconDatabase*"/>
					<parameter name="page_uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_path" symbol="webkit_favicon_database_get_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="database" type="WebKitFaviconDatabase*"/>
				</parameters>
			</method>
			<method name="set_path" symbol="webkit_favicon_database_set_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="database" type="WebKitFaviconDatabase*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="try_get_favicon_pixbuf" symbol="webkit_favicon_database_try_get_favicon_pixbuf">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="database" type="WebKitFaviconDatabase*"/>
					<parameter name="page_uri" type="gchar*"/>
					<parameter name="width" type="guint"/>
					<parameter name="height" type="guint"/>
				</parameters>
			</method>
			<property name="path" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="icon-loaded" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitFaviconDatabase*"/>
					<parameter name="p0" type="char*"/>
				</parameters>
			</signal>
		</object>
		<object name="WebKitFileChooserRequest" parent="GObject" type-name="WebKitFileChooserRequest" get-type="webkit_file_chooser_request_get_type">
			<method name="get_mime_types" symbol="webkit_file_chooser_request_get_mime_types">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="request" type="WebKitFileChooserRequest*"/>
				</parameters>
			</method>
			<method name="get_mime_types_filter" symbol="webkit_file_chooser_request_get_mime_types_filter">
				<return-type type="GtkFileFilter*"/>
				<parameters>
					<parameter name="request" type="WebKitFileChooserRequest*"/>
				</parameters>
			</method>
			<method name="get_select_multiple" symbol="webkit_file_chooser_request_get_select_multiple">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="request" type="WebKitFileChooserRequest*"/>
				</parameters>
			</method>
			<method name="get_selected_files" symbol="webkit_file_chooser_request_get_selected_files">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="request" type="WebKitFileChooserRequest*"/>
				</parameters>
			</method>
			<method name="select_files" symbol="webkit_file_chooser_request_select_files">
				<return-type type="void"/>
				<parameters>
					<parameter name="request" type="WebKitFileChooserRequest*"/>
					<parameter name="files" type="gchar**"/>
				</parameters>
			</method>
			<property name="filter" type="GtkFileFilter*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="mime-types" type="GStrv*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="select-multiple" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="selected-files" type="GStrv*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitGeolocationPolicyDecision" parent="GObject" type-name="WebKitGeolocationPolicyDecision" get-type="webkit_geolocation_policy_decision_get_type">
		</object>
		<object name="WebKitHitTestResult" parent="GObject" type-name="WebKitHitTestResult" get-type="webkit_hit_test_result_get_type">
			<property name="context" type="WebKitHitTestResultContext" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="image-uri" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="inner-node" type="WebKitDOMNode*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="link-uri" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="media-uri" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="x" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="y" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="WebKitIconDatabase" parent="GObject" type-name="WebKitIconDatabase" get-type="webkit_icon_database_get_type">
			<method name="clear" symbol="webkit_icon_database_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="database" type="WebKitIconDatabase*"/>
				</parameters>
			</method>
			<method name="get_icon_pixbuf" symbol="webkit_icon_database_get_icon_pixbuf">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="database" type="WebKitIconDatabase*"/>
					<parameter name="page_uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_icon_uri" symbol="webkit_icon_database_get_icon_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="database" type="WebKitIconDatabase*"/>
					<parameter name="page_uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_path" symbol="webkit_icon_database_get_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="database" type="WebKitIconDatabase*"/>
				</parameters>
			</method>
			<method name="set_path" symbol="webkit_icon_database_set_path">
				<return-type type="void"/>
				<parameters>
					<parameter name="database" type="WebKitIconDatabase*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<property name="path" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="icon-loaded" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitIconDatabase*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
					<parameter name="p1" type="char*"/>
				</parameters>
			</signal>
		</object>
		<object name="WebKitNetworkRequest" parent="GObject" type-name="WebKitNetworkRequest" get-type="webkit_network_request_get_type">
			<method name="get_message" symbol="webkit_network_request_get_message">
				<return-type type="SoupMessage*"/>
				<parameters>
					<parameter name="request" type="WebKitNetworkRequest*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="webkit_network_request_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="request" type="WebKitNetworkRequest*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="webkit_network_request_new">
				<return-type type="WebKitNetworkRequest*"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_uri" symbol="webkit_network_request_set_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="request" type="WebKitNetworkRequest*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<property name="message" type="SoupMessage*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="uri" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitNetworkResponse" parent="GObject" type-name="WebKitNetworkResponse" get-type="webkit_network_response_get_type">
			<method name="get_message" symbol="webkit_network_response_get_message">
				<return-type type="SoupMessage*"/>
				<parameters>
					<parameter name="response" type="WebKitNetworkResponse*"/>
				</parameters>
			</method>
			<method name="get_suggested_filename" symbol="webkit_network_response_get_suggested_filename">
				<return-type type="char*"/>
				<parameters>
					<parameter name="response" type="WebKitNetworkResponse*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="webkit_network_response_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="response" type="WebKitNetworkResponse*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="webkit_network_response_new">
				<return-type type="WebKitNetworkResponse*"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_uri" symbol="webkit_network_response_set_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="response" type="WebKitNetworkResponse*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<property name="message" type="SoupMessage*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="suggested-filename" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitSecurityOrigin" parent="GObject" type-name="WebKitSecurityOrigin" get-type="webkit_security_origin_get_type">
			<method name="get_all_web_databases" symbol="webkit_security_origin_get_all_web_databases">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="securityOrigin" type="WebKitSecurityOrigin*"/>
				</parameters>
			</method>
			<method name="get_host" symbol="webkit_security_origin_get_host">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="securityOrigin" type="WebKitSecurityOrigin*"/>
				</parameters>
			</method>
			<method name="get_port" symbol="webkit_security_origin_get_port">
				<return-type type="guint"/>
				<parameters>
					<parameter name="securityOrigin" type="WebKitSecurityOrigin*"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="webkit_security_origin_get_protocol">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="securityOrigin" type="WebKitSecurityOrigin*"/>
				</parameters>
			</method>
			<method name="get_web_database_quota" symbol="webkit_security_origin_get_web_database_quota">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="securityOrigin" type="WebKitSecurityOrigin*"/>
				</parameters>
			</method>
			<method name="get_web_database_usage" symbol="webkit_security_origin_get_web_database_usage">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="securityOrigin" type="WebKitSecurityOrigin*"/>
				</parameters>
			</method>
			<method name="set_web_database_quota" symbol="webkit_security_origin_set_web_database_quota">
				<return-type type="void"/>
				<parameters>
					<parameter name="securityOrigin" type="WebKitSecurityOrigin*"/>
					<parameter name="quota" type="guint64"/>
				</parameters>
			</method>
			<property name="host" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="port" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="protocol" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="web-database-quota" type="guint64" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="web-database-usage" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitSoupAuthDialog" parent="GObject" type-name="WebKitSoupAuthDialog" get-type="webkit_soup_auth_dialog_get_type">
			<implements>
				<interface name="SoupSessionFeature"/>
			</implements>
			<signal name="current-toplevel" when="LAST">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="authDialog" type="WebKitSoupAuthDialog*"/>
					<parameter name="message" type="SoupMessage*"/>
				</parameters>
			</signal>
		</object>
		<object name="WebKitViewportAttributes" parent="GObject" type-name="WebKitViewportAttributes" get-type="webkit_viewport_attributes_get_type">
			<method name="recompute" symbol="webkit_viewport_attributes_recompute">
				<return-type type="void"/>
				<parameters>
					<parameter name="viewportAttributes" type="WebKitViewportAttributes*"/>
				</parameters>
			</method>
			<property name="available-height" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="available-width" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="desktop-width" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="device-dpi" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="device-height" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="device-pixel-ratio" type="gfloat" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="device-width" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="height" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="initial-scale-factor" type="gfloat" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="maximum-scale-factor" type="gfloat" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="minimum-scale-factor" type="gfloat" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="user-scalable" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="valid" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="width" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitWebBackForwardList" parent="GObject" type-name="WebKitWebBackForwardList" get-type="webkit_web_back_forward_list_get_type">
			<method name="add_item" symbol="webkit_web_back_forward_list_add_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
					<parameter name="history_item" type="WebKitWebHistoryItem*"/>
				</parameters>
			</method>
			<method name="clear" symbol="webkit_web_back_forward_list_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
				</parameters>
			</method>
			<method name="contains_item" symbol="webkit_web_back_forward_list_contains_item">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
					<parameter name="history_item" type="WebKitWebHistoryItem*"/>
				</parameters>
			</method>
			<method name="get_back_item" symbol="webkit_web_back_forward_list_get_back_item">
				<return-type type="WebKitWebHistoryItem*"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
				</parameters>
			</method>
			<method name="get_back_length" symbol="webkit_web_back_forward_list_get_back_length">
				<return-type type="gint"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
				</parameters>
			</method>
			<method name="get_back_list_with_limit" symbol="webkit_web_back_forward_list_get_back_list_with_limit">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
					<parameter name="limit" type="gint"/>
				</parameters>
			</method>
			<method name="get_current_item" symbol="webkit_web_back_forward_list_get_current_item">
				<return-type type="WebKitWebHistoryItem*"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
				</parameters>
			</method>
			<method name="get_forward_item" symbol="webkit_web_back_forward_list_get_forward_item">
				<return-type type="WebKitWebHistoryItem*"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
				</parameters>
			</method>
			<method name="get_forward_length" symbol="webkit_web_back_forward_list_get_forward_length">
				<return-type type="gint"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
				</parameters>
			</method>
			<method name="get_forward_list_with_limit" symbol="webkit_web_back_forward_list_get_forward_list_with_limit">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
					<parameter name="limit" type="gint"/>
				</parameters>
			</method>
			<method name="get_limit" symbol="webkit_web_back_forward_list_get_limit">
				<return-type type="gint"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
				</parameters>
			</method>
			<method name="get_nth_item" symbol="webkit_web_back_forward_list_get_nth_item">
				<return-type type="WebKitWebHistoryItem*"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
					<parameter name="index" type="gint"/>
				</parameters>
			</method>
			<method name="go_back" symbol="webkit_web_back_forward_list_go_back">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
				</parameters>
			</method>
			<method name="go_forward" symbol="webkit_web_back_forward_list_go_forward">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
				</parameters>
			</method>
			<method name="go_to_item" symbol="webkit_web_back_forward_list_go_to_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
					<parameter name="history_item" type="WebKitWebHistoryItem*"/>
				</parameters>
			</method>
			<constructor name="new_with_web_view" symbol="webkit_web_back_forward_list_new_with_web_view">
				<return-type type="WebKitWebBackForwardList*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</constructor>
			<method name="set_limit" symbol="webkit_web_back_forward_list_set_limit">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
					<parameter name="limit" type="gint"/>
				</parameters>
			</method>
		</object>
		<object name="WebKitWebDataSource" parent="GObject" type-name="WebKitWebDataSource" get-type="webkit_web_data_source_get_type">
			<method name="get_data" symbol="webkit_web_data_source_get_data">
				<return-type type="GString*"/>
				<parameters>
					<parameter name="data_source" type="WebKitWebDataSource*"/>
				</parameters>
			</method>
			<method name="get_encoding" symbol="webkit_web_data_source_get_encoding">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="data_source" type="WebKitWebDataSource*"/>
				</parameters>
			</method>
			<method name="get_initial_request" symbol="webkit_web_data_source_get_initial_request">
				<return-type type="WebKitNetworkRequest*"/>
				<parameters>
					<parameter name="data_source" type="WebKitWebDataSource*"/>
				</parameters>
			</method>
			<method name="get_main_resource" symbol="webkit_web_data_source_get_main_resource">
				<return-type type="WebKitWebResource*"/>
				<parameters>
					<parameter name="data_source" type="WebKitWebDataSource*"/>
				</parameters>
			</method>
			<method name="get_request" symbol="webkit_web_data_source_get_request">
				<return-type type="WebKitNetworkRequest*"/>
				<parameters>
					<parameter name="data_source" type="WebKitWebDataSource*"/>
				</parameters>
			</method>
			<method name="get_subresources" symbol="webkit_web_data_source_get_subresources">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="data_source" type="WebKitWebDataSource*"/>
				</parameters>
			</method>
			<method name="get_unreachable_uri" symbol="webkit_web_data_source_get_unreachable_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="data_source" type="WebKitWebDataSource*"/>
				</parameters>
			</method>
			<method name="get_web_frame" symbol="webkit_web_data_source_get_web_frame">
				<return-type type="WebKitWebFrame*"/>
				<parameters>
					<parameter name="data_source" type="WebKitWebDataSource*"/>
				</parameters>
			</method>
			<method name="is_loading" symbol="webkit_web_data_source_is_loading">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="data_source" type="WebKitWebDataSource*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="webkit_web_data_source_new">
				<return-type type="WebKitWebDataSource*"/>
			</constructor>
			<constructor name="new_with_request" symbol="webkit_web_data_source_new_with_request">
				<return-type type="WebKitWebDataSource*"/>
				<parameters>
					<parameter name="request" type="WebKitNetworkRequest*"/>
				</parameters>
			</constructor>
		</object>
		<object name="WebKitWebDatabase" parent="GObject" type-name="WebKitWebDatabase" get-type="webkit_web_database_get_type">
			<method name="get_display_name" symbol="webkit_web_database_get_display_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="webDatabase" type="WebKitWebDatabase*"/>
				</parameters>
			</method>
			<method name="get_expected_size" symbol="webkit_web_database_get_expected_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="webDatabase" type="WebKitWebDatabase*"/>
				</parameters>
			</method>
			<method name="get_filename" symbol="webkit_web_database_get_filename">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="webDatabase" type="WebKitWebDatabase*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_web_database_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="webDatabase" type="WebKitWebDatabase*"/>
				</parameters>
			</method>
			<method name="get_security_origin" symbol="webkit_web_database_get_security_origin">
				<return-type type="WebKitSecurityOrigin*"/>
				<parameters>
					<parameter name="webDatabase" type="WebKitWebDatabase*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="webkit_web_database_get_size">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="webDatabase" type="WebKitWebDatabase*"/>
				</parameters>
			</method>
			<method name="remove" symbol="webkit_web_database_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="webDatabase" type="WebKitWebDatabase*"/>
				</parameters>
			</method>
			<property name="display-name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="expected-size" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="filename" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="security-origin" type="WebKitSecurityOrigin*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="size" type="guint64" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitWebFrame" parent="GObject" type-name="WebKitWebFrame" get-type="webkit_web_frame_get_type">
			<method name="find_frame" symbol="webkit_web_frame_find_frame">
				<return-type type="WebKitWebFrame*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_data_source" symbol="webkit_web_frame_get_data_source">
				<return-type type="WebKitWebDataSource*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_dom_document" symbol="webkit_web_frame_get_dom_document">
				<return-type type="WebKitDOMDocument*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_global_context" symbol="webkit_web_frame_get_global_context">
				<return-type type="JSGlobalContextRef"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_horizontal_scrollbar_policy" symbol="webkit_web_frame_get_horizontal_scrollbar_policy">
				<return-type type="GtkPolicyType"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_load_status" symbol="webkit_web_frame_get_load_status">
				<return-type type="WebKitLoadStatus"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_web_frame_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_network_response" symbol="webkit_web_frame_get_network_response">
				<return-type type="WebKitNetworkResponse*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="webkit_web_frame_get_parent">
				<return-type type="WebKitWebFrame*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_provisional_data_source" symbol="webkit_web_frame_get_provisional_data_source">
				<return-type type="WebKitWebDataSource*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_range_for_word_around_caret" symbol="webkit_web_frame_get_range_for_word_around_caret">
				<return-type type="WebKitDOMRange*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_security_origin" symbol="webkit_web_frame_get_security_origin">
				<return-type type="WebKitSecurityOrigin*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="webkit_web_frame_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="webkit_web_frame_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_vertical_scrollbar_policy" symbol="webkit_web_frame_get_vertical_scrollbar_policy">
				<return-type type="GtkPolicyType"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="get_web_view" symbol="webkit_web_frame_get_web_view">
				<return-type type="WebKitWebView*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="load_alternate_string" symbol="webkit_web_frame_load_alternate_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="content" type="gchar*"/>
					<parameter name="base_url" type="gchar*"/>
					<parameter name="unreachable_url" type="gchar*"/>
				</parameters>
			</method>
			<method name="load_request" symbol="webkit_web_frame_load_request">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="request" type="WebKitNetworkRequest*"/>
				</parameters>
			</method>
			<method name="load_string" symbol="webkit_web_frame_load_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="content" type="gchar*"/>
					<parameter name="mime_type" type="gchar*"/>
					<parameter name="encoding" type="gchar*"/>
					<parameter name="base_uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="load_uri" symbol="webkit_web_frame_load_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="webkit_web_frame_new">
				<return-type type="WebKitWebFrame*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</constructor>
			<method name="print" symbol="webkit_web_frame_print">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="print_full" symbol="webkit_web_frame_print_full">
				<return-type type="GtkPrintOperationResult"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="operation" type="GtkPrintOperation*"/>
					<parameter name="action" type="GtkPrintOperationAction"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="reload" symbol="webkit_web_frame_reload">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<method name="replace_selection" symbol="webkit_web_frame_replace_selection">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="text" type="char*"/>
				</parameters>
			</method>
			<method name="stop_loading" symbol="webkit_web_frame_stop_loading">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<property name="horizontal-scrollbar-policy" type="GtkPolicyType" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="load-status" type="WebKitLoadStatus" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="vertical-scrollbar-policy" type="GtkPolicyType" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="cleared" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="hovering-over-link" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
					<parameter name="p0" type="char*"/>
					<parameter name="p1" type="char*"/>
				</parameters>
			</signal>
			<signal name="insecure-content-run" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
					<parameter name="p0" type="WebKitSecurityOrigin*"/>
					<parameter name="p1" type="char*"/>
				</parameters>
			</signal>
			<signal name="load-committed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="resource-content-length-received" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
					<parameter name="p0" type="WebKitWebResource*"/>
					<parameter name="p1" type="gint"/>
				</parameters>
			</signal>
			<signal name="resource-load-failed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
					<parameter name="p0" type="WebKitWebResource*"/>
					<parameter name="p1" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="resource-load-finished" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
					<parameter name="p0" type="WebKitWebResource*"/>
				</parameters>
			</signal>
			<signal name="resource-request-starting" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
					<parameter name="p0" type="WebKitWebResource*"/>
					<parameter name="p1" type="WebKitNetworkRequest*"/>
					<parameter name="p2" type="WebKitNetworkResponse*"/>
				</parameters>
			</signal>
			<signal name="resource-response-received" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
					<parameter name="p0" type="WebKitWebResource*"/>
					<parameter name="p1" type="WebKitNetworkResponse*"/>
				</parameters>
			</signal>
			<signal name="scrollbars-policy-changed" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="title-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
					<parameter name="p0" type="char*"/>
				</parameters>
			</signal>
		</object>
		<object name="WebKitWebHistoryItem" parent="GObject" type-name="WebKitWebHistoryItem" get-type="webkit_web_history_item_get_type">
			<method name="copy" symbol="webkit_web_history_item_copy">
				<return-type type="WebKitWebHistoryItem*"/>
				<parameters>
					<parameter name="web_history_item" type="WebKitWebHistoryItem*"/>
				</parameters>
			</method>
			<method name="get_alternate_title" symbol="webkit_web_history_item_get_alternate_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_history_item" type="WebKitWebHistoryItem*"/>
				</parameters>
			</method>
			<method name="get_last_visited_time" symbol="webkit_web_history_item_get_last_visited_time">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="web_history_item" type="WebKitWebHistoryItem*"/>
				</parameters>
			</method>
			<method name="get_original_uri" symbol="webkit_web_history_item_get_original_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_history_item" type="WebKitWebHistoryItem*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="webkit_web_history_item_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_history_item" type="WebKitWebHistoryItem*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="webkit_web_history_item_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_history_item" type="WebKitWebHistoryItem*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="webkit_web_history_item_new">
				<return-type type="WebKitWebHistoryItem*"/>
			</constructor>
			<constructor name="new_with_data" symbol="webkit_web_history_item_new_with_data">
				<return-type type="WebKitWebHistoryItem*"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_alternate_title" symbol="webkit_web_history_item_set_alternate_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_history_item" type="WebKitWebHistoryItem*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<property name="alternate-title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="last-visited-time" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="original-uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitWebInspector" parent="GObject" type-name="WebKitWebInspector" get-type="webkit_web_inspector_get_type">
			<method name="close" symbol="webkit_web_inspector_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_inspector" type="WebKitWebInspector*"/>
				</parameters>
			</method>
			<method name="get_inspected_uri" symbol="webkit_web_inspector_get_inspected_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_inspector" type="WebKitWebInspector*"/>
				</parameters>
			</method>
			<method name="get_web_view" symbol="webkit_web_inspector_get_web_view">
				<return-type type="WebKitWebView*"/>
				<parameters>
					<parameter name="web_inspector" type="WebKitWebInspector*"/>
				</parameters>
			</method>
			<method name="inspect_coordinates" symbol="webkit_web_inspector_inspect_coordinates">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_inspector" type="WebKitWebInspector*"/>
					<parameter name="x" type="gdouble"/>
					<parameter name="y" type="gdouble"/>
				</parameters>
			</method>
			<method name="inspect_node" symbol="webkit_web_inspector_inspect_node">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_inspector" type="WebKitWebInspector*"/>
					<parameter name="node" type="WebKitDOMNode*"/>
				</parameters>
			</method>
			<method name="show" symbol="webkit_web_inspector_show">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_inspector" type="WebKitWebInspector*"/>
				</parameters>
			</method>
			<property name="inspected-uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="javascript-profiling-enabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="timeline-profiling-enabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="web-view" type="WebKitWebView*" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="attach-window" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebInspector*"/>
				</parameters>
			</signal>
			<signal name="close-window" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebInspector*"/>
				</parameters>
			</signal>
			<signal name="detach-window" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebInspector*"/>
				</parameters>
			</signal>
			<signal name="finished" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebInspector*"/>
				</parameters>
			</signal>
			<signal name="inspect-web-view" when="LAST">
				<return-type type="WebKitWebView*"/>
				<parameters>
					<parameter name="object" type="WebKitWebInspector*"/>
					<parameter name="p0" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="show-window" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebInspector*"/>
				</parameters>
			</signal>
		</object>
		<object name="WebKitWebNavigationAction" parent="GObject" type-name="WebKitWebNavigationAction" get-type="webkit_web_navigation_action_get_type">
			<method name="get_button" symbol="webkit_web_navigation_action_get_button">
				<return-type type="gint"/>
				<parameters>
					<parameter name="navigationAction" type="WebKitWebNavigationAction*"/>
				</parameters>
			</method>
			<method name="get_modifier_state" symbol="webkit_web_navigation_action_get_modifier_state">
				<return-type type="gint"/>
				<parameters>
					<parameter name="navigationAction" type="WebKitWebNavigationAction*"/>
				</parameters>
			</method>
			<method name="get_original_uri" symbol="webkit_web_navigation_action_get_original_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="navigationAction" type="WebKitWebNavigationAction*"/>
				</parameters>
			</method>
			<method name="get_reason" symbol="webkit_web_navigation_action_get_reason">
				<return-type type="WebKitWebNavigationReason"/>
				<parameters>
					<parameter name="navigationAction" type="WebKitWebNavigationAction*"/>
				</parameters>
			</method>
			<method name="get_target_frame" symbol="webkit_web_navigation_action_get_target_frame">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="navigationAction" type="WebKitWebNavigationAction*"/>
				</parameters>
			</method>
			<method name="set_original_uri" symbol="webkit_web_navigation_action_set_original_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="navigationAction" type="WebKitWebNavigationAction*"/>
					<parameter name="originalUri" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_reason" symbol="webkit_web_navigation_action_set_reason">
				<return-type type="void"/>
				<parameters>
					<parameter name="navigationAction" type="WebKitWebNavigationAction*"/>
					<parameter name="reason" type="WebKitWebNavigationReason"/>
				</parameters>
			</method>
			<property name="button" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="modifier-state" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="original-uri" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="reason" type="WebKitWebNavigationReason" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="target-frame" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="WebKitWebPlugin" parent="GObject" type-name="WebKitWebPlugin" get-type="webkit_web_plugin_get_type">
			<method name="get_description" symbol="webkit_web_plugin_get_description">
				<return-type type="char*"/>
				<parameters>
					<parameter name="plugin" type="WebKitWebPlugin*"/>
				</parameters>
			</method>
			<method name="get_enabled" symbol="webkit_web_plugin_get_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="plugin" type="WebKitWebPlugin*"/>
				</parameters>
			</method>
			<method name="get_mimetypes" symbol="webkit_web_plugin_get_mimetypes">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="plugin" type="WebKitWebPlugin*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="webkit_web_plugin_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="plugin" type="WebKitWebPlugin*"/>
				</parameters>
			</method>
			<method name="get_path" symbol="webkit_web_plugin_get_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="plugin" type="WebKitWebPlugin*"/>
				</parameters>
			</method>
			<method name="set_enabled" symbol="webkit_web_plugin_set_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="plugin" type="WebKitWebPlugin*"/>
					<parameter name="enabled" type="gboolean"/>
				</parameters>
			</method>
			<property name="enabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="WebKitWebPluginDatabase" parent="GObject" type-name="WebKitWebPluginDatabase" get-type="webkit_web_plugin_database_get_type">
			<method name="get_plugin_for_mimetype" symbol="webkit_web_plugin_database_get_plugin_for_mimetype">
				<return-type type="WebKitWebPlugin*"/>
				<parameters>
					<parameter name="database" type="WebKitWebPluginDatabase*"/>
					<parameter name="mime_type" type="char*"/>
				</parameters>
			</method>
			<method name="get_plugins" symbol="webkit_web_plugin_database_get_plugins">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="database" type="WebKitWebPluginDatabase*"/>
				</parameters>
			</method>
			<method name="plugins_list_free" symbol="webkit_web_plugin_database_plugins_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GSList*"/>
				</parameters>
			</method>
			<method name="refresh" symbol="webkit_web_plugin_database_refresh">
				<return-type type="void"/>
				<parameters>
					<parameter name="database" type="WebKitWebPluginDatabase*"/>
				</parameters>
			</method>
		</object>
		<object name="WebKitWebPolicyDecision" parent="GObject" type-name="WebKitWebPolicyDecision" get-type="webkit_web_policy_decision_get_type">
			<method name="download" symbol="webkit_web_policy_decision_download">
				<return-type type="void"/>
				<parameters>
					<parameter name="decision" type="WebKitWebPolicyDecision*"/>
				</parameters>
			</method>
			<method name="ignore" symbol="webkit_web_policy_decision_ignore">
				<return-type type="void"/>
				<parameters>
					<parameter name="decision" type="WebKitWebPolicyDecision*"/>
				</parameters>
			</method>
			<method name="use" symbol="webkit_web_policy_decision_use">
				<return-type type="void"/>
				<parameters>
					<parameter name="decision" type="WebKitWebPolicyDecision*"/>
				</parameters>
			</method>
		</object>
		<object name="WebKitWebResource" parent="GObject" type-name="WebKitWebResource" get-type="webkit_web_resource_get_type">
			<method name="get_data" symbol="webkit_web_resource_get_data">
				<return-type type="GString*"/>
				<parameters>
					<parameter name="web_resource" type="WebKitWebResource*"/>
				</parameters>
			</method>
			<method name="get_encoding" symbol="webkit_web_resource_get_encoding">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_resource" type="WebKitWebResource*"/>
				</parameters>
			</method>
			<method name="get_frame_name" symbol="webkit_web_resource_get_frame_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_resource" type="WebKitWebResource*"/>
				</parameters>
			</method>
			<method name="get_mime_type" symbol="webkit_web_resource_get_mime_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_resource" type="WebKitWebResource*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="webkit_web_resource_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_resource" type="WebKitWebResource*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="webkit_web_resource_new">
				<return-type type="WebKitWebResource*"/>
				<parameters>
					<parameter name="data" type="gchar*"/>
					<parameter name="size" type="gssize"/>
					<parameter name="uri" type="gchar*"/>
					<parameter name="mime_type" type="gchar*"/>
					<parameter name="encoding" type="gchar*"/>
					<parameter name="frame_name" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="encoding" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="frame-name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="mime-type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="content-length-received" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebResource*"/>
					<parameter name="p0" type="gint"/>
				</parameters>
			</signal>
			<signal name="load-failed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebResource*"/>
					<parameter name="p0" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="load-finished" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebResource*"/>
				</parameters>
			</signal>
			<signal name="response-received" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebResource*"/>
					<parameter name="p0" type="WebKitNetworkResponse*"/>
				</parameters>
			</signal>
		</object>
		<object name="WebKitWebSettings" parent="GObject" type-name="WebKitWebSettings" get-type="webkit_web_settings_get_type">
			<method name="copy" symbol="webkit_web_settings_copy">
				<return-type type="WebKitWebSettings*"/>
				<parameters>
					<parameter name="web_settings" type="WebKitWebSettings*"/>
				</parameters>
			</method>
			<method name="get_user_agent" symbol="webkit_web_settings_get_user_agent">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_settings" type="WebKitWebSettings*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="webkit_web_settings_new">
				<return-type type="WebKitWebSettings*"/>
			</constructor>
			<property name="auto-load-images" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="auto-resize-window" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="auto-shrink-images" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="cursive-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="default-encoding" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="default-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="default-font-size" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="default-monospace-font-size" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="editing-behavior" type="WebKitEditingBehavior" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-accelerated-compositing" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-caret-browsing" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-default-context-menu" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-developer-extras" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-display-of-insecure-content" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-dns-prefetching" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-dom-paste" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-file-access-from-file-uris" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-frame-flattening" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-fullscreen" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-html5-database" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-html5-local-storage" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-hyperlink-auditing" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-java-applet" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-media-stream" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-mediasource" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-offline-web-application-cache" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-page-cache" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-plugins" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-private-browsing" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-running-of-insecure-content" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-scripts" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-site-specific-quirks" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-smooth-scrolling" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-spatial-navigation" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-spell-checking" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-universal-access-from-file-uris" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-webaudio" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-webgl" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-xss-auditor" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enforce-96-dpi" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="fantasy-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="html5-local-storage-database-path" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="javascript-can-access-clipboard" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="javascript-can-open-windows-automatically" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="media-playback-allows-inline" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="media-playback-requires-user-gesture" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="minimum-font-size" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="minimum-logical-font-size" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="monospace-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="print-backgrounds" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="resizable-text-areas" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="respect-image-orientation" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="sans-serif-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="serif-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="spell-checking-languages" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="tab-key-cycles-through-elements" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="user-agent" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="user-stylesheet-uri" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="zoom-step" type="gfloat" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="WebKitWebView" parent="GtkContainer" type-name="WebKitWebView" get-type="webkit_web_view_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="can_copy_clipboard" symbol="webkit_web_view_can_copy_clipboard">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="can_cut_clipboard" symbol="webkit_web_view_can_cut_clipboard">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="can_go_back" symbol="webkit_web_view_can_go_back">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="can_go_back_or_forward" symbol="webkit_web_view_can_go_back_or_forward">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="steps" type="gint"/>
				</parameters>
			</method>
			<method name="can_go_forward" symbol="webkit_web_view_can_go_forward">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="can_paste_clipboard" symbol="webkit_web_view_can_paste_clipboard">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="can_redo" symbol="webkit_web_view_can_redo">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="can_show_mime_type" symbol="webkit_web_view_can_show_mime_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="mime_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="can_undo" symbol="webkit_web_view_can_undo">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="copy_clipboard" symbol="webkit_web_view_copy_clipboard">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="cut_clipboard" symbol="webkit_web_view_cut_clipboard">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="delete_selection" symbol="webkit_web_view_delete_selection">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="execute_script" symbol="webkit_web_view_execute_script">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="script" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_back_forward_list" symbol="webkit_web_view_get_back_forward_list">
				<return-type type="WebKitWebBackForwardList*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_copy_target_list" symbol="webkit_web_view_get_copy_target_list">
				<return-type type="GtkTargetList*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_custom_encoding" symbol="webkit_web_view_get_custom_encoding">
				<return-type type="char*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_dom_document" symbol="webkit_web_view_get_dom_document">
				<return-type type="WebKitDOMDocument*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_editable" symbol="webkit_web_view_get_editable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_encoding" symbol="webkit_web_view_get_encoding">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_focused_frame" symbol="webkit_web_view_get_focused_frame">
				<return-type type="WebKitWebFrame*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_full_content_zoom" symbol="webkit_web_view_get_full_content_zoom">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_hit_test_result" symbol="webkit_web_view_get_hit_test_result">
				<return-type type="WebKitHitTestResult*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="event" type="GdkEventButton*"/>
				</parameters>
			</method>
			<method name="get_icon_pixbuf" symbol="webkit_web_view_get_icon_pixbuf">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_icon_uri" symbol="webkit_web_view_get_icon_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_inspector" symbol="webkit_web_view_get_inspector">
				<return-type type="WebKitWebInspector*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_load_status" symbol="webkit_web_view_get_load_status">
				<return-type type="WebKitLoadStatus"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_main_frame" symbol="webkit_web_view_get_main_frame">
				<return-type type="WebKitWebFrame*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_paste_target_list" symbol="webkit_web_view_get_paste_target_list">
				<return-type type="GtkTargetList*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_progress" symbol="webkit_web_view_get_progress">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_settings" symbol="webkit_web_view_get_settings">
				<return-type type="WebKitWebSettings*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_snapshot" symbol="webkit_web_view_get_snapshot">
				<return-type type="cairo_surface_t*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="webkit_web_view_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_transparent" symbol="webkit_web_view_get_transparent">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="webkit_web_view_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_view_mode" symbol="webkit_web_view_get_view_mode">
				<return-type type="WebKitWebViewViewMode"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_view_source_mode" symbol="webkit_web_view_get_view_source_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_viewport_attributes" symbol="webkit_web_view_get_viewport_attributes">
				<return-type type="WebKitViewportAttributes*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_window_features" symbol="webkit_web_view_get_window_features">
				<return-type type="WebKitWebWindowFeatures*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="get_zoom_level" symbol="webkit_web_view_get_zoom_level">
				<return-type type="gfloat"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="go_back" symbol="webkit_web_view_go_back">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="go_back_or_forward" symbol="webkit_web_view_go_back_or_forward">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="steps" type="gint"/>
				</parameters>
			</method>
			<method name="go_forward" symbol="webkit_web_view_go_forward">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="go_to_back_forward_item" symbol="webkit_web_view_go_to_back_forward_item">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="item" type="WebKitWebHistoryItem*"/>
				</parameters>
			</method>
			<method name="has_selection" symbol="webkit_web_view_has_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="load_html_string" symbol="webkit_web_view_load_html_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="content" type="gchar*"/>
					<parameter name="base_uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="load_request" symbol="webkit_web_view_load_request">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="request" type="WebKitNetworkRequest*"/>
				</parameters>
			</method>
			<method name="load_string" symbol="webkit_web_view_load_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="content" type="gchar*"/>
					<parameter name="mime_type" type="gchar*"/>
					<parameter name="encoding" type="gchar*"/>
					<parameter name="base_uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="load_uri" symbol="webkit_web_view_load_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="mark_text_matches" symbol="webkit_web_view_mark_text_matches">
				<return-type type="guint"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="string" type="gchar*"/>
					<parameter name="case_sensitive" type="gboolean"/>
					<parameter name="limit" type="guint"/>
				</parameters>
			</method>
			<method name="move_cursor" symbol="webkit_web_view_move_cursor">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="step" type="GtkMovementStep"/>
					<parameter name="count" type="gint"/>
				</parameters>
			</method>
			<constructor name="new" symbol="webkit_web_view_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="open" symbol="webkit_web_view_open">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="paste_clipboard" symbol="webkit_web_view_paste_clipboard">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="redo" symbol="webkit_web_view_redo">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="reload" symbol="webkit_web_view_reload">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="reload_bypass_cache" symbol="webkit_web_view_reload_bypass_cache">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="search_text" symbol="webkit_web_view_search_text">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="text" type="gchar*"/>
					<parameter name="case_sensitive" type="gboolean"/>
					<parameter name="forward" type="gboolean"/>
					<parameter name="wrap" type="gboolean"/>
				</parameters>
			</method>
			<method name="select_all" symbol="webkit_web_view_select_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="set_custom_encoding" symbol="webkit_web_view_set_custom_encoding">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="encoding" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_editable" symbol="webkit_web_view_set_editable">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="flag" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_full_content_zoom" symbol="webkit_web_view_set_full_content_zoom">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="full_content_zoom" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_highlight_text_matches" symbol="webkit_web_view_set_highlight_text_matches">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="highlight" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_maintains_back_forward_list" symbol="webkit_web_view_set_maintains_back_forward_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="flag" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_settings" symbol="webkit_web_view_set_settings">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="settings" type="WebKitWebSettings*"/>
				</parameters>
			</method>
			<method name="set_transparent" symbol="webkit_web_view_set_transparent">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="flag" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_view_mode" symbol="webkit_web_view_set_view_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="mode" type="WebKitWebViewViewMode"/>
				</parameters>
			</method>
			<method name="set_view_source_mode" symbol="webkit_web_view_set_view_source_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="view_source_mode" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_zoom_level" symbol="webkit_web_view_set_zoom_level">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="zoom_level" type="gfloat"/>
				</parameters>
			</method>
			<method name="stop_loading" symbol="webkit_web_view_stop_loading">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="try_get_favicon_pixbuf" symbol="webkit_web_view_try_get_favicon_pixbuf">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="width" type="guint"/>
					<parameter name="height" type="guint"/>
				</parameters>
			</method>
			<method name="undo" symbol="webkit_web_view_undo">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="unmark_text_matches" symbol="webkit_web_view_unmark_text_matches">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="zoom_in" symbol="webkit_web_view_zoom_in">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="zoom_out" symbol="webkit_web_view_zoom_out">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<property name="copy-target-list" type="GtkTargetList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="custom-encoding" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="editable" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="encoding" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="full-content-zoom" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="icon-uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="im-context" type="GtkIMContext*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="load-status" type="WebKitLoadStatus" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="paste-target-list" type="GtkTargetList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="progress" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="self-scrolling" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="settings" type="WebKitWebSettings*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="transparent" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="view-mode" type="WebKitWebViewViewMode" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="viewport-attributes" type="WebKitViewportAttributes*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="web-inspector" type="WebKitWebInspector*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="window-features" type="WebKitWebWindowFeatures*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="zoom-level" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="close-web-view" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="console-message" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="message" type="char*"/>
					<parameter name="line_number" type="gint"/>
					<parameter name="source_id" type="char*"/>
				</parameters>
			</signal>
			<signal name="context-menu" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="GtkWidget*"/>
					<parameter name="p1" type="WebKitHitTestResult*"/>
					<parameter name="p2" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="copy-clipboard" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="create-plugin-widget" when="LAST">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="char*"/>
					<parameter name="p1" type="char*"/>
					<parameter name="p2" type="GHashTable*"/>
				</parameters>
			</signal>
			<signal name="create-web-view" when="LAST">
				<return-type type="WebKitWebView*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="web_frame" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="cut-clipboard" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="database-quota-exceeded" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="GObject*"/>
					<parameter name="p1" type="GObject*"/>
				</parameters>
			</signal>
			<signal name="document-load-finished" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="download-requested" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitDownload*"/>
				</parameters>
			</signal>
			<signal name="editing-began" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="editing-ended" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="entering-fullscreen" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</signal>
			<signal name="frame-created" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="geolocation-policy-decision-cancelled" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="geolocation-policy-decision-requested" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
					<parameter name="p1" type="WebKitGeolocationPolicyDecision*"/>
				</parameters>
			</signal>
			<signal name="hovering-over-link" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="char*"/>
					<parameter name="p1" type="char*"/>
				</parameters>
			</signal>
			<signal name="icon-loaded" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="char*"/>
				</parameters>
			</signal>
			<signal name="leaving-fullscreen" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</signal>
			<signal name="load-committed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="load-error" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
					<parameter name="p1" type="char*"/>
					<parameter name="p2" type="GError*"/>
				</parameters>
			</signal>
			<signal name="load-finished" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="load-progress-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="gint"/>
				</parameters>
			</signal>
			<signal name="load-started" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="mime-type-policy-decision-requested" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
					<parameter name="p1" type="WebKitNetworkRequest*"/>
					<parameter name="p2" type="char*"/>
					<parameter name="p3" type="WebKitWebPolicyDecision*"/>
				</parameters>
			</signal>
			<signal name="move-cursor" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="step" type="GtkMovementStep"/>
					<parameter name="count" type="gint"/>
				</parameters>
			</signal>
			<signal name="navigation-policy-decision-requested" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
					<parameter name="p1" type="WebKitNetworkRequest*"/>
					<parameter name="p2" type="WebKitWebNavigationAction*"/>
					<parameter name="p3" type="WebKitWebPolicyDecision*"/>
				</parameters>
			</signal>
			<signal name="navigation-requested" when="LAST">
				<return-type type="WebKitNavigationResponse"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="request" type="WebKitNetworkRequest*"/>
				</parameters>
			</signal>
			<signal name="new-window-policy-decision-requested" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
					<parameter name="p1" type="WebKitNetworkRequest*"/>
					<parameter name="p2" type="WebKitWebNavigationAction*"/>
					<parameter name="p3" type="WebKitWebPolicyDecision*"/>
				</parameters>
			</signal>
			<signal name="onload-event" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="paste-clipboard" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="populate-popup" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="GtkMenu*"/>
				</parameters>
			</signal>
			<signal name="print-requested" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="redo" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="resource-content-length-received" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
					<parameter name="p1" type="WebKitWebResource*"/>
					<parameter name="p2" type="gint"/>
				</parameters>
			</signal>
			<signal name="resource-load-failed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
					<parameter name="p1" type="WebKitWebResource*"/>
					<parameter name="p2" type="GError*"/>
				</parameters>
			</signal>
			<signal name="resource-load-finished" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
					<parameter name="p1" type="WebKitWebResource*"/>
				</parameters>
			</signal>
			<signal name="resource-request-starting" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
					<parameter name="p1" type="WebKitWebResource*"/>
					<parameter name="p2" type="WebKitNetworkRequest*"/>
					<parameter name="p3" type="WebKitNetworkResponse*"/>
				</parameters>
			</signal>
			<signal name="resource-response-received" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
					<parameter name="p1" type="WebKitWebResource*"/>
					<parameter name="p2" type="WebKitNetworkResponse*"/>
				</parameters>
			</signal>
			<signal name="run-file-chooser" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="request" type="WebKitFileChooserRequest*"/>
				</parameters>
			</signal>
			<signal name="script-alert" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="alert_message" type="char*"/>
				</parameters>
			</signal>
			<signal name="script-confirm" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="confirm_message" type="char*"/>
					<parameter name="did_confirm" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="script-prompt" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="message" type="char*"/>
					<parameter name="default_value" type="char*"/>
					<parameter name="value" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="select-all" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="selection-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="set-scroll-adjustments" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="hadjustment" type="GtkAdjustment*"/>
					<parameter name="vadjustment" type="GtkAdjustment*"/>
				</parameters>
			</signal>
			<signal name="should-apply-style" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitDOMCSSStyleDeclaration*"/>
					<parameter name="p1" type="WebKitDOMRange*"/>
				</parameters>
			</signal>
			<signal name="should-begin-editing" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitDOMRange*"/>
				</parameters>
			</signal>
			<signal name="should-change-selected-range" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitDOMRange*"/>
					<parameter name="p1" type="WebKitDOMRange*"/>
					<parameter name="p2" type="WebKitSelectionAffinity"/>
					<parameter name="p3" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="should-delete-range" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitDOMRange*"/>
				</parameters>
			</signal>
			<signal name="should-end-editing" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitDOMRange*"/>
				</parameters>
			</signal>
			<signal name="should-insert-node" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitDOMNode*"/>
					<parameter name="p1" type="WebKitDOMRange*"/>
					<parameter name="p2" type="WebKitInsertAction"/>
				</parameters>
			</signal>
			<signal name="should-insert-text" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="char*"/>
					<parameter name="p1" type="WebKitDOMRange*"/>
					<parameter name="p2" type="WebKitInsertAction"/>
				</parameters>
			</signal>
			<signal name="should-show-delete-interface-for-element" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitDOMHTMLElement*"/>
				</parameters>
			</signal>
			<signal name="status-bar-text-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="char*"/>
				</parameters>
			</signal>
			<signal name="title-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitWebFrame*"/>
					<parameter name="p1" type="char*"/>
				</parameters>
			</signal>
			<signal name="undo" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="user-changed-contents" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="viewport-attributes-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitViewportAttributes*"/>
				</parameters>
			</signal>
			<signal name="viewport-attributes-recompute-requested" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="WebKitViewportAttributes*"/>
				</parameters>
			</signal>
			<signal name="web-view-ready" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="window-object-cleared" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="context" type="gpointer"/>
					<parameter name="window_object" type="gpointer"/>
				</parameters>
			</signal>
			<vfunc name="choose_file">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="old_file" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="should_allow_editing_action">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="WebKitWebWindowFeatures" parent="GObject" type-name="WebKitWebWindowFeatures" get-type="webkit_web_window_features_get_type">
			<method name="equal" symbol="webkit_web_window_features_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="features1" type="WebKitWebWindowFeatures*"/>
					<parameter name="features2" type="WebKitWebWindowFeatures*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="webkit_web_window_features_new">
				<return-type type="WebKitWebWindowFeatures*"/>
			</constructor>
			<property name="fullscreen" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="height" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="locationbar-visible" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="menubar-visible" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="scrollbar-visible" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="statusbar-visible" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="toolbar-visible" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="width" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="x" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="y" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<interface name="WebKitDOMEventTarget" type-name="WebKitDOMEventTarget" get-type="webkit_dom_event_target_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="add_event_listener" symbol="webkit_dom_event_target_add_event_listener">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="target" type="WebKitDOMEventTarget*"/>
					<parameter name="event_name" type="char*"/>
					<parameter name="handler" type="GCallback"/>
					<parameter name="use_capture" type="gboolean"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="add_event_listener_with_closure" symbol="webkit_dom_event_target_add_event_listener_with_closure">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="target" type="WebKitDOMEventTarget*"/>
					<parameter name="event_name" type="char*"/>
					<parameter name="handler" type="GClosure*"/>
					<parameter name="use_capture" type="gboolean"/>
				</parameters>
			</method>
			<method name="dispatch_event" symbol="webkit_dom_event_target_dispatch_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="target" type="WebKitDOMEventTarget*"/>
					<parameter name="event" type="WebKitDOMEvent*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="remove_event_listener" symbol="webkit_dom_event_target_remove_event_listener">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="target" type="WebKitDOMEventTarget*"/>
					<parameter name="event_name" type="char*"/>
					<parameter name="handler" type="GCallback"/>
					<parameter name="use_capture" type="gboolean"/>
				</parameters>
			</method>
			<method name="remove_event_listener_with_closure" symbol="webkit_dom_event_target_remove_event_listener_with_closure">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="target" type="WebKitDOMEventTarget*"/>
					<parameter name="event_name" type="char*"/>
					<parameter name="handler" type="GClosure*"/>
					<parameter name="use_capture" type="gboolean"/>
				</parameters>
			</method>
			<vfunc name="add_event_listener">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="target" type="WebKitDOMEventTarget*"/>
					<parameter name="event_name" type="char*"/>
					<parameter name="handler" type="GClosure*"/>
					<parameter name="use_capture" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="dispatch_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="target" type="WebKitDOMEventTarget*"/>
					<parameter name="event" type="WebKitDOMEvent*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_event_listener">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="target" type="WebKitDOMEventTarget*"/>
					<parameter name="event_name" type="char*"/>
					<parameter name="handler" type="GClosure*"/>
					<parameter name="use_capture" type="gboolean"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="WebKitSpellChecker" type-name="WebKitSpellChecker" get-type="webkit_spell_checker_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="check_spelling_of_string" symbol="webkit_spell_checker_check_spelling_of_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="checker" type="WebKitSpellChecker*"/>
					<parameter name="string" type="char*"/>
					<parameter name="misspelling_location" type="int*"/>
					<parameter name="misspelling_length" type="int*"/>
				</parameters>
			</method>
			<method name="get_autocorrect_suggestions_for_misspelled_word" symbol="webkit_spell_checker_get_autocorrect_suggestions_for_misspelled_word">
				<return-type type="char*"/>
				<parameters>
					<parameter name="checker" type="WebKitSpellChecker*"/>
					<parameter name="word" type="char*"/>
				</parameters>
			</method>
			<method name="get_guesses_for_word" symbol="webkit_spell_checker_get_guesses_for_word">
				<return-type type="char**"/>
				<parameters>
					<parameter name="checker" type="WebKitSpellChecker*"/>
					<parameter name="word" type="char*"/>
					<parameter name="context" type="char*"/>
				</parameters>
			</method>
			<method name="ignore_word" symbol="webkit_spell_checker_ignore_word">
				<return-type type="void"/>
				<parameters>
					<parameter name="checker" type="WebKitSpellChecker*"/>
					<parameter name="word" type="char*"/>
				</parameters>
			</method>
			<method name="learn_word" symbol="webkit_spell_checker_learn_word">
				<return-type type="void"/>
				<parameters>
					<parameter name="checker" type="WebKitSpellChecker*"/>
					<parameter name="word" type="char*"/>
				</parameters>
			</method>
			<method name="update_spell_checking_languages" symbol="webkit_spell_checker_update_spell_checking_languages">
				<return-type type="void"/>
				<parameters>
					<parameter name="checker" type="WebKitSpellChecker*"/>
					<parameter name="languages" type="char*"/>
				</parameters>
			</method>
			<vfunc name="check_spelling_of_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="checker" type="WebKitSpellChecker*"/>
					<parameter name="string" type="char*"/>
					<parameter name="misspelling_location" type="int*"/>
					<parameter name="misspelling_length" type="int*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_autocorrect_suggestions_for_misspelled_word">
				<return-type type="char*"/>
				<parameters>
					<parameter name="checker" type="WebKitSpellChecker*"/>
					<parameter name="word" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_guesses_for_word">
				<return-type type="char**"/>
				<parameters>
					<parameter name="checker" type="WebKitSpellChecker*"/>
					<parameter name="word" type="char*"/>
					<parameter name="context" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="ignore_word">
				<return-type type="void"/>
				<parameters>
					<parameter name="checker" type="WebKitSpellChecker*"/>
					<parameter name="word" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="learn_word">
				<return-type type="void"/>
				<parameters>
					<parameter name="checker" type="WebKitSpellChecker*"/>
					<parameter name="word" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="update_spell_checking_languages">
				<return-type type="void"/>
				<parameters>
					<parameter name="checker" type="WebKitSpellChecker*"/>
					<parameter name="languages" type="char*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="WEBKIT_MAJOR_VERSION" type="int" value="2"/>
		<constant name="WEBKIT_MICRO_VERSION" type="int" value="11"/>
		<constant name="WEBKIT_MINOR_VERSION" type="int" value="4"/>
		<constant name="WEBKIT_USER_AGENT_MAJOR_VERSION" type="int" value="538"/>
		<constant name="WEBKIT_USER_AGENT_MINOR_VERSION" type="int" value="15"/>
	</namespace>
</api>
