<?xml version="1.0"?>
<api version="1.0">
	<namespace name="WebKit">
		<enum name="WebKitNavigationResponse">
			<member name="WEBKIT_NAVIGATION_RESPONSE_ACCEPT" value="0"/>
			<member name="WEBKIT_NAVIGATION_RESPONSE_IGNORE" value="1"/>
			<member name="WEBKIT_NAVIGATION_RESPONSE_DOWNLOAD" value="2"/>
		</enum>
		<enum name="WebKitWebViewTargetInfo">
			<member name="WEBKIT_WEB_VIEW_TARGET_INFO_HTML" value="-1"/>
			<member name="WEBKIT_WEB_VIEW_TARGET_INFO_TEXT" value="-2"/>
		</enum>
		<object name="WebKitNetworkRequest" parent="GObject" type-name="WebKitNetworkRequest" get-type="webkit_network_request_get_type">
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
			<method name="load_request" symbol="webkit_web_frame_load_request">
				<return-type type="void"/>
				<parameters>
					<parameter name="frame" type="WebKitWebFrame*"/>
					<parameter name="request" type="WebKitNetworkRequest*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="webkit_web_frame_new">
				<return-type type="WebKitWebFrame*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</constructor>
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
			<property name="enable-plugins" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-scripts" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="fantasy-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="minimum-font-size" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="minimum-logical-font-size" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="monospace-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="print-backgrounds" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="resizable-text-areas" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="sans-serif-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="serif-font-family" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="user-stylesheet-uri" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
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
			<method name="can_go_backward" symbol="webkit_web_view_can_go_backward">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
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
			<method name="get_copy_target_list" symbol="webkit_web_view_get_copy_target_list">
				<return-type type="GtkTargetList*"/>
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
			<method name="get_settings" symbol="webkit_web_view_get_settings">
				<return-type type="WebKitWebSettings*"/>
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
			<method name="go_backward" symbol="webkit_web_view_go_backward">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</method>
			<method name="go_forward" symbol="webkit_web_view_go_forward">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
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
			<method name="load_string" symbol="webkit_web_view_load_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="content" type="gchar*"/>
					<parameter name="content_mime_type" type="gchar*"/>
					<parameter name="content_encoding" type="gchar*"/>
					<parameter name="base_uri" type="gchar*"/>
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
			<method name="search_text" symbol="webkit_web_view_search_text">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="string" type="gchar*"/>
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
			<method name="set_editable" symbol="webkit_web_view_set_editable">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="flag" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_highlight_text_matches" symbol="webkit_web_view_set_highlight_text_matches">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="highlight" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_settings" symbol="webkit_web_view_set_settings">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="settings" type="WebKitWebSettings*"/>
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
			<property name="copy-target-list" type="GtkTargetList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="editable" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="paste-target-list" type="GtkTargetList*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="settings" type="WebKitWebSettings*" readable="1" writable="1" construct="0" construct-only="0"/>
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
			<signal name="cut-clipboard" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
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
			<signal name="navigation-requested" when="LAST">
				<return-type type="gint"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="frame" type="GObject*"/>
					<parameter name="request" type="GObject*"/>
				</parameters>
			</signal>
			<signal name="paste-clipboard" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</signal>
			<signal name="script-alert" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="frame" type="GObject*"/>
					<parameter name="alert_message" type="char*"/>
				</parameters>
			</signal>
			<signal name="script-confirm" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="frame" type="GObject*"/>
					<parameter name="confirm_message" type="char*"/>
					<parameter name="did_confirm" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="script-prompt" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
					<parameter name="frame" type="GObject*"/>
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
					<parameter name="object" type="WebKitWebView*"/>
					<parameter name="p0" type="GtkAdjustment*"/>
					<parameter name="p1" type="GtkAdjustment*"/>
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
			<vfunc name="create_web_view">
				<return-type type="WebKitWebView*"/>
				<parameters>
					<parameter name="web_view" type="WebKitWebView*"/>
				</parameters>
			</vfunc>
		</object>
	</namespace>
</api>
