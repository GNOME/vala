<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Twitter">
		<function name="date_to_time_val" symbol="twitter_date_to_time_val">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="date" type="gchar*"/>
				<parameter name="time_" type="GTimeVal*"/>
			</parameters>
		</function>
		<function name="error_from_status" symbol="twitter_error_from_status">
			<return-type type="TwitterError"/>
			<parameters>
				<parameter name="status" type="guint"/>
			</parameters>
		</function>
		<function name="error_quark" symbol="twitter_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="http_date_from_delta" symbol="twitter_http_date_from_delta">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="seconds" type="gint"/>
			</parameters>
		</function>
		<function name="http_date_from_time_t" symbol="twitter_http_date_from_time_t">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="time_" type="time_t"/>
			</parameters>
		</function>
		<function name="http_date_to_delta" symbol="twitter_http_date_to_delta">
			<return-type type="gint"/>
			<parameters>
				<parameter name="date" type="gchar*"/>
			</parameters>
		</function>
		<function name="http_date_to_time_t" symbol="twitter_http_date_to_time_t">
			<return-type type="time_t"/>
			<parameters>
				<parameter name="date" type="gchar*"/>
			</parameters>
		</function>
		<enum name="TwitterAuthState" type-name="TwitterAuthState" get-type="twitter_auth_state_get_type">
			<member name="TWITTER_AUTH_NEGOTIATING" value="0"/>
			<member name="TWITTER_AUTH_RETRY" value="1"/>
			<member name="TWITTER_AUTH_FAILED" value="2"/>
			<member name="TWITTER_AUTH_SUCCESS" value="3"/>
		</enum>
		<enum name="TwitterError" type-name="TwitterError" get-type="twitter_error_get_type">
			<member name="TWITTER_ERROR_HOST_NOT_FOUND" value="0"/>
			<member name="TWITTER_ERROR_CANCELLED" value="1"/>
			<member name="TWITTER_ERROR_PERMISSION_DENIED" value="2"/>
			<member name="TWITTER_ERROR_NOT_FOUND" value="3"/>
			<member name="TWITTER_ERROR_TIMED_OUT" value="4"/>
			<member name="TWITTER_ERROR_FAILED" value="5"/>
			<member name="TWITTER_ERROR_NOT_MODIFIED" value="6"/>
			<member name="TWITTER_ERROR_PARSE_ERROR" value="7"/>
		</enum>
		<enum name="TwitterProvider" type-name="TwitterProvider" get-type="twitter_provider_get_type">
			<member name="TWITTER_CUSTOM_PROVIDER" value="0"/>
			<member name="TWITTER_DEFAULT_PROVIDER" value="1"/>
			<member name="TWITTER_IDENTI_CA" value="2"/>
		</enum>
		<object name="TwitterClient" parent="GObject" type-name="TwitterClient" get-type="twitter_client_get_type">
			<method name="add_favorite" symbol="twitter_client_add_favorite">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="status_id" type="guint"/>
				</parameters>
			</method>
			<method name="add_friend" symbol="twitter_client_add_friend">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="user" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_status" symbol="twitter_client_add_status">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="end_session" symbol="twitter_client_end_session">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
				</parameters>
			</method>
			<method name="follow_user" symbol="twitter_client_follow_user">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="user" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_archive" symbol="twitter_client_get_archive">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="page" type="gint"/>
				</parameters>
			</method>
			<method name="get_base_url" symbol="twitter_client_get_base_url">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
				</parameters>
			</method>
			<method name="get_favorites" symbol="twitter_client_get_favorites">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="user" type="gchar*"/>
					<parameter name="page" type="gint"/>
				</parameters>
			</method>
			<method name="get_followers" symbol="twitter_client_get_followers">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="page" type="gint"/>
					<parameter name="omit_status" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_friends" symbol="twitter_client_get_friends">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="user" type="gchar*"/>
					<parameter name="page" type="gint"/>
					<parameter name="omit_status" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_friends_timeline" symbol="twitter_client_get_friends_timeline">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="friend_" type="gchar*"/>
					<parameter name="since_date" type="gint64"/>
				</parameters>
			</method>
			<method name="get_provider" symbol="twitter_client_get_provider">
				<return-type type="TwitterProvider"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
				</parameters>
			</method>
			<method name="get_public_timeline" symbol="twitter_client_get_public_timeline">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="since_id" type="guint"/>
				</parameters>
			</method>
			<method name="get_rate_limit" symbol="twitter_client_get_rate_limit">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="limit" type="gint*"/>
					<parameter name="remaining" type="gint*"/>
				</parameters>
			</method>
			<method name="get_replies" symbol="twitter_client_get_replies">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
				</parameters>
			</method>
			<method name="get_status" symbol="twitter_client_get_status">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="status_id" type="guint"/>
				</parameters>
			</method>
			<method name="get_user" symbol="twitter_client_get_user">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="email" type="gchar**"/>
					<parameter name="password" type="gchar**"/>
				</parameters>
			</method>
			<method name="get_user_timeline" symbol="twitter_client_get_user_timeline">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="user" type="gchar*"/>
					<parameter name="count" type="guint"/>
					<parameter name="since_date" type="gint64"/>
				</parameters>
			</method>
			<method name="leave_user" symbol="twitter_client_leave_user">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="user" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="twitter_client_new">
				<return-type type="TwitterClient*"/>
			</constructor>
			<constructor name="new_for_user" symbol="twitter_client_new_for_user">
				<return-type type="TwitterClient*"/>
				<parameters>
					<parameter name="email" type="gchar*"/>
					<parameter name="password" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_full" symbol="twitter_client_new_full">
				<return-type type="TwitterClient*"/>
				<parameters>
					<parameter name="provider" type="TwitterProvider"/>
					<parameter name="base_url" type="gchar*"/>
					<parameter name="email" type="gchar*"/>
					<parameter name="password" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="remove_favorite" symbol="twitter_client_remove_favorite">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="status_id" type="guint"/>
				</parameters>
			</method>
			<method name="remove_friend" symbol="twitter_client_remove_friend">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="user" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove_status" symbol="twitter_client_remove_status">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="status_id" type="guint"/>
				</parameters>
			</method>
			<method name="set_user" symbol="twitter_client_set_user">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="email" type="gchar*"/>
					<parameter name="password" type="gchar*"/>
				</parameters>
			</method>
			<method name="show_user_from_email" symbol="twitter_client_show_user_from_email">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="email" type="gchar*"/>
				</parameters>
			</method>
			<method name="show_user_from_id" symbol="twitter_client_show_user_from_id">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="id_or_screen_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="verify_user" symbol="twitter_client_verify_user">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
				</parameters>
			</method>
			<property name="base-url" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="email" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-requests" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="password" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="provider" type="TwitterProvider" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="remaining-requests" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="user-agent" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="authenticate" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="state" type="TwitterAuthState"/>
				</parameters>
			</signal>
			<signal name="session-ended" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
				</parameters>
			</signal>
			<signal name="status-received" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="handle" type="gulong"/>
					<parameter name="status" type="TwitterStatus*"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</signal>
			<signal name="timeline-complete" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
				</parameters>
			</signal>
			<signal name="user-received" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="handle" type="gulong"/>
					<parameter name="user" type="TwitterUser*"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</signal>
			<signal name="user-verified" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="client" type="TwitterClient*"/>
					<parameter name="handle" type="gulong"/>
					<parameter name="is_verified" type="gboolean"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</signal>
		</object>
		<object name="TwitterStatus" parent="GInitiallyUnowned" type-name="TwitterStatus" get-type="twitter_status_get_type">
			<method name="get_created_at" symbol="twitter_status_get_created_at">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="status" type="TwitterStatus*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="twitter_status_get_id">
				<return-type type="guint"/>
				<parameters>
					<parameter name="status" type="TwitterStatus*"/>
				</parameters>
			</method>
			<method name="get_reply_to_status" symbol="twitter_status_get_reply_to_status">
				<return-type type="guint"/>
				<parameters>
					<parameter name="status" type="TwitterStatus*"/>
				</parameters>
			</method>
			<method name="get_reply_to_user" symbol="twitter_status_get_reply_to_user">
				<return-type type="guint"/>
				<parameters>
					<parameter name="status" type="TwitterStatus*"/>
				</parameters>
			</method>
			<method name="get_source" symbol="twitter_status_get_source">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="status" type="TwitterStatus*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="twitter_status_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="status" type="TwitterStatus*"/>
				</parameters>
			</method>
			<method name="get_truncated" symbol="twitter_status_get_truncated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status" type="TwitterStatus*"/>
				</parameters>
			</method>
			<method name="get_url" symbol="twitter_status_get_url">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="status" type="TwitterStatus*"/>
				</parameters>
			</method>
			<method name="get_user" symbol="twitter_status_get_user">
				<return-type type="TwitterUser*"/>
				<parameters>
					<parameter name="status" type="TwitterStatus*"/>
				</parameters>
			</method>
			<method name="load_from_data" symbol="twitter_status_load_from_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="status" type="TwitterStatus*"/>
					<parameter name="buffer" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="twitter_status_new">
				<return-type type="TwitterStatus*"/>
			</constructor>
			<constructor name="new_from_data" symbol="twitter_status_new_from_data">
				<return-type type="TwitterStatus*"/>
				<parameters>
					<parameter name="buffer" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="created-at" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="id" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="reply-to-status" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="reply-to-user" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="source" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="text" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="truncated" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="url" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="user" type="TwitterUser*" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="TwitterStatus*"/>
				</parameters>
			</signal>
		</object>
		<object name="TwitterTimeline" parent="GObject" type-name="TwitterTimeline" get-type="twitter_timeline_get_type">
			<method name="get_all" symbol="twitter_timeline_get_all">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="timeline" type="TwitterTimeline*"/>
				</parameters>
			</method>
			<method name="get_count" symbol="twitter_timeline_get_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="timeline" type="TwitterTimeline*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="twitter_timeline_get_id">
				<return-type type="TwitterStatus*"/>
				<parameters>
					<parameter name="timeline" type="TwitterTimeline*"/>
					<parameter name="id" type="guint"/>
				</parameters>
			</method>
			<method name="get_pos" symbol="twitter_timeline_get_pos">
				<return-type type="TwitterStatus*"/>
				<parameters>
					<parameter name="timeline" type="TwitterTimeline*"/>
					<parameter name="index_" type="gint"/>
				</parameters>
			</method>
			<method name="load_from_data" symbol="twitter_timeline_load_from_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="timeline" type="TwitterTimeline*"/>
					<parameter name="buffer" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="twitter_timeline_new">
				<return-type type="TwitterTimeline*"/>
			</constructor>
			<constructor name="new_from_data" symbol="twitter_timeline_new_from_data">
				<return-type type="TwitterTimeline*"/>
				<parameters>
					<parameter name="buffer" type="gchar*"/>
				</parameters>
			</constructor>
		</object>
		<object name="TwitterUser" parent="GInitiallyUnowned" type-name="TwitterUser" get-type="twitter_user_get_type">
			<method name="get_created_at" symbol="twitter_user_get_created_at">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="twitter_user_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_favorites_count" symbol="twitter_user_get_favorites_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_followers_count" symbol="twitter_user_get_followers_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_following" symbol="twitter_user_get_following">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_friends_count" symbol="twitter_user_get_friends_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="twitter_user_get_id">
				<return-type type="guint"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_location" symbol="twitter_user_get_location">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="twitter_user_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_profile_image" symbol="twitter_user_get_profile_image">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_profile_image_url" symbol="twitter_user_get_profile_image_url">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_protected" symbol="twitter_user_get_protected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_screen_name" symbol="twitter_user_get_screen_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_status" symbol="twitter_user_get_status">
				<return-type type="TwitterStatus*"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_statuses_count" symbol="twitter_user_get_statuses_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_time_zone" symbol="twitter_user_get_time_zone">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_url" symbol="twitter_user_get_url">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="get_utc_offset" symbol="twitter_user_get_utc_offset">
				<return-type type="gint"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</method>
			<method name="load_from_data" symbol="twitter_user_load_from_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
					<parameter name="buffer" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="twitter_user_new">
				<return-type type="TwitterUser*"/>
			</constructor>
			<constructor name="new_from_data" symbol="twitter_user_new_from_data">
				<return-type type="TwitterUser*"/>
				<parameters>
					<parameter name="buffer" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="created-at" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="description" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="favorites-count" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="followers-count" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="following" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="friends-count" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="id" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="location" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="profile-image-url" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="protected" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="screen-name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="status" type="TwitterStatus*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="statuses-count" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="time-zone" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="url" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="utc-offset" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="user" type="TwitterUser*"/>
				</parameters>
			</signal>
		</object>
		<object name="TwitterUserList" parent="GObject" type-name="TwitterUserList" get-type="twitter_user_list_get_type">
			<method name="get_all" symbol="twitter_user_list_get_all">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="user_list" type="TwitterUserList*"/>
				</parameters>
			</method>
			<method name="get_count" symbol="twitter_user_list_get_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="user_list" type="TwitterUserList*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="twitter_user_list_get_id">
				<return-type type="TwitterUser*"/>
				<parameters>
					<parameter name="user_list" type="TwitterUserList*"/>
					<parameter name="id" type="guint"/>
				</parameters>
			</method>
			<method name="get_pos" symbol="twitter_user_list_get_pos">
				<return-type type="TwitterUser*"/>
				<parameters>
					<parameter name="user_list" type="TwitterUserList*"/>
					<parameter name="index_" type="gint"/>
				</parameters>
			</method>
			<method name="load_from_data" symbol="twitter_user_list_load_from_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="user_list" type="TwitterUserList*"/>
					<parameter name="buffer" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="twitter_user_list_new">
				<return-type type="TwitterUserList*"/>
			</constructor>
			<constructor name="new_from_data" symbol="twitter_user_list_new_from_data">
				<return-type type="TwitterUserList*"/>
				<parameters>
					<parameter name="buffer" type="gchar*"/>
				</parameters>
			</constructor>
		</object>
		<constant name="TWITTER_GLIB_API_VERSION_S" type="char*" value="1.0"/>
		<constant name="TWITTER_GLIB_MAJOR_VERSION" type="int" value="0"/>
		<constant name="TWITTER_GLIB_MICRO_VERSION" type="int" value="9"/>
		<constant name="TWITTER_GLIB_MINOR_VERSION" type="int" value="9"/>
		<constant name="TWITTER_GLIB_VERSION_HEX" type="int" value="0"/>
		<constant name="TWITTER_GLIB_VERSION_S" type="char*" value="0.9.9"/>
	</namespace>
</api>
