<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Notify">
		<function name="get_app_name" symbol="notify_get_app_name">
			<return-type type="char*"/>
		</function>
		<function name="get_server_caps" symbol="notify_get_server_caps">
			<return-type type="GList*"/>
		</function>
		<function name="get_server_info" symbol="notify_get_server_info">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="ret_name" type="char**"/>
				<parameter name="ret_vendor" type="char**"/>
				<parameter name="ret_version" type="char**"/>
				<parameter name="ret_spec_version" type="char**"/>
			</parameters>
		</function>
		<function name="init" symbol="notify_init">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="app_name" type="char*"/>
			</parameters>
		</function>
		<function name="is_initted" symbol="notify_is_initted">
			<return-type type="gboolean"/>
		</function>
		<function name="uninit" symbol="notify_uninit">
			<return-type type="void"/>
		</function>
		<callback name="NotifyActionCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="notification" type="NotifyNotification*"/>
				<parameter name="action" type="char*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<enum name="NotifyUrgency" type-name="NotifyUrgency" get-type="notify_urgency_get_type">
			<member name="NOTIFY_URGENCY_LOW" value="0"/>
			<member name="NOTIFY_URGENCY_NORMAL" value="1"/>
			<member name="NOTIFY_URGENCY_CRITICAL" value="2"/>
		</enum>
		<object name="NotifyNotification" parent="GObject" type-name="NotifyNotification" get-type="notify_notification_get_type">
			<method name="add_action" symbol="notify_notification_add_action">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="action" type="char*"/>
					<parameter name="label" type="char*"/>
					<parameter name="callback" type="NotifyActionCallback"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="free_func" type="GFreeFunc"/>
				</parameters>
			</method>
			<method name="clear_actions" symbol="notify_notification_clear_actions">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
				</parameters>
			</method>
			<method name="clear_hints" symbol="notify_notification_clear_hints">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
				</parameters>
			</method>
			<method name="close" symbol="notify_notification_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_closed_reason" symbol="notify_notification_get_closed_reason">
				<return-type type="gint"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="notify_notification_new">
				<return-type type="NotifyNotification*"/>
				<parameters>
					<parameter name="summary" type="char*"/>
					<parameter name="body" type="char*"/>
					<parameter name="icon" type="char*"/>
				</parameters>
			</constructor>
			<method name="set_category" symbol="notify_notification_set_category">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="category" type="char*"/>
				</parameters>
			</method>
			<method name="set_hint" symbol="notify_notification_set_hint">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="key" type="char*"/>
					<parameter name="value" type="GVariant*"/>
				</parameters>
			</method>
			<method name="set_hint_byte" symbol="notify_notification_set_hint_byte">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="key" type="char*"/>
					<parameter name="value" type="guchar"/>
				</parameters>
			</method>
			<method name="set_hint_byte_array" symbol="notify_notification_set_hint_byte_array">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="key" type="char*"/>
					<parameter name="value" type="guchar*"/>
					<parameter name="len" type="gsize"/>
				</parameters>
			</method>
			<method name="set_hint_double" symbol="notify_notification_set_hint_double">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="key" type="char*"/>
					<parameter name="value" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_hint_int32" symbol="notify_notification_set_hint_int32">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="key" type="char*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_hint_string" symbol="notify_notification_set_hint_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="key" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_hint_uint32" symbol="notify_notification_set_hint_uint32">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="key" type="char*"/>
					<parameter name="value" type="guint"/>
				</parameters>
			</method>
			<method name="set_icon_from_pixbuf" symbol="notify_notification_set_icon_from_pixbuf">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="icon" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="set_image_from_pixbuf" symbol="notify_notification_set_image_from_pixbuf">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="image" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="set_timeout" symbol="notify_notification_set_timeout">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="timeout" type="gint"/>
				</parameters>
			</method>
			<method name="set_urgency" symbol="notify_notification_set_urgency">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="urgency" type="NotifyUrgency"/>
				</parameters>
			</method>
			<method name="show" symbol="notify_notification_show">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="update" symbol="notify_notification_update">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
					<parameter name="summary" type="char*"/>
					<parameter name="body" type="char*"/>
					<parameter name="icon" type="char*"/>
				</parameters>
			</method>
			<property name="body" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="closed-reason" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="icon-name" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="id" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="summary" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="closed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="notification" type="NotifyNotification*"/>
				</parameters>
			</signal>
		</object>
		<constant name="NOTIFY_EXPIRES_DEFAULT" type="int" value="-1"/>
		<constant name="NOTIFY_EXPIRES_NEVER" type="int" value="0"/>
		<constant name="NOTIFY_VERSION_MAJOR" type="int" value="0"/>
		<constant name="NOTIFY_VERSION_MICRO" type="int" value="0"/>
		<constant name="NOTIFY_VERSION_MINOR" type="int" value="7"/>
	</namespace>
</api>
