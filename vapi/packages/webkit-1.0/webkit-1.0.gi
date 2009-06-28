<?xml version="1.0"?>
<api version="1.0">
	<namespace name="WebKit">
		<function name="check_version" symbol="webkit_check_version">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="major" type="guint"/>
				<parameter name="minor" type="guint"/>
				<parameter name="micro" type="guint"/>
			</parameters>
		</function>
		<function name="get_default_session" symbol="webkit_get_default_session">
			<return-type type="SoupSession*"/>
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
		<enum name="WebKitLoadStatus" type-name="WebKitLoadStatus" get-type="webkit_load_status_get_type">
			<member name="WEBKIT_LOAD_PROVISIONAL" value="0"/>
			<member name="WEBKIT_LOAD_COMMITTED" value="1"/>
			<member name="WEBKIT_LOAD_FINISHED" value="2"/>
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
		</enum>
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
		<object name="WebKitSoupAuthDialog" parent="GObject" type-name="WebKitSoupAuthDialog" get-type="webkit_soup_auth_dialog_get_type">
			<implements>
				<interface name="SoupSessionFeature"/>
			</implements>
			<signal name="current-toplevel" when="LAST">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="feature" type="WebKitSoupAuthDialog*"/>
					<parameter name="message" type="SoupMessage*"/>
				</parameters>
			</signal>
		</object>
		<object name="WebKitWebBackForwardList" parent="GObject" type-name="WebKitWebBackForwardList" get-type="webkit_web_back_forward_list_get_type">
			<method name="add_item" symbol="webkit_web_back_forward_list_add_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_back_forward_list" type="WebKitWebBackForwardList*"/>
					<parameter name="history_item" type="WebKitWebHistoryItem*"/>
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
		<object name="WebKitWebFrame" parent="GObject" type-name="WebKitWebFrame" get-type="webkit_web_frame_get_type">
			<method name="find_frame" symbol="webkit_web_frame_find_frame">
				<return-type type="WebKitWebFrame*"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_global_context" symbol="webkit_web_frame_get_global_context">
				<return-type type="JSGlobalContextRef"/>
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
			<method name="get_parent" symbol="webkit_web_frame_get_parent">
				<return-type type="WebKitWebFrame*"/>
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
			<method name="stop_loading" symbol="webkit_web_frame_stop_loading">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
				</parameters>
			</method>
			<property name="load-status" type="WebKitLoadStatus" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
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
			<signal name="load-committed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
				</parameters>
			</signal>
			<signal name="load-done" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="WebKitWebFrame*"/>
					<parameter name="p0" type="gboolean"/>
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
			<property name="inspected-uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="javascript-profiling-enabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
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
		<object name="WebKitWebSettings" parent="GObject" type-name="WebKitWebSettings" get-type="webkit_web_settings_get_type">
			<method name="copy" symbol="webkit_web_settings_copy">
				<return-type type="WebKitWebSettings*"/>
				<parameters>
					<parameter name="web_settings" type="WebKitWebSettings*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="webkit_web_settings_new">
				<return-type type="WebKitWebSettings*"/>
			</constructor>
			<property name="auto-load-images" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="auto-shrink-images" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="cursive-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="default-encoding" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="default-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="default-font-size" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="default-monospace-font-size" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-caret-browsing" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-developer-extras" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-html5-database" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-html5-local-storage" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-plugins" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-private-browsing" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-scripts" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-spell-checking" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enforce-96-dpi" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="fantasy-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="minimum-font-size" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="minimum-logical-font-size" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="monospace-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="print-backgrounds" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="resizable-text-areas" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="sans-serif-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="serif-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="spell-checking-languages" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
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
			<method name="can_show_mime_type" symbol="webkit_web_view_can_show_mime_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="mime_type" type="gchar*"/>
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
					<parameter name="webView" type="WebKitWebView*"/>
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
					<parameter name="webView" type="WebKitWebView*"/>
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
					<parameter name="webView" type="WebKitWebView*"/>
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
					<parameter name="webView" type="WebKitWebView*"/>
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
			<property name="load-status" type="WebKitLoadStatus" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="paste-target-list" type="GtkTargetList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="progress" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="settings" type="WebKitWebSettings*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="transparent" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="web-inspector" type="WebKitWebInspector*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="window-features" type="WebKitWebWindowFeatures*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="zoom-level" type="gfloat" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="console-message" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="message" type="char*"/>
					<parameter name="line_number" type="gint"/>
					<parameter name="source_id" type="char*"/>
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
			<signal name="download-requested" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="GObject*"/>
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
					<parameter name="p2" type="gpointer"/>
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
		<constant name="WEBKIT_MAJOR_VERSION" type="int" value="1"/>
		<constant name="WEBKIT_MICRO_VERSION" type="int" value="10"/>
		<constant name="WEBKIT_MINOR_VERSION" type="int" value="1"/>
		<constant name="WEBKIT_SOUP_AUTH_DIALOG_H" type="int" value="1"/>
	</namespace>
</api>
