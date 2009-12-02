<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Unique">
		<boxed name="UniqueMessageData" type-name="UniqueMessageData" get-type="unique_message_data_get_type">
			<method name="copy" symbol="unique_message_data_copy">
				<return-type type="UniqueMessageData*"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
				</parameters>
			</method>
			<method name="free" symbol="unique_message_data_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
				</parameters>
			</method>
			<method name="get" symbol="unique_message_data_get">
				<return-type type="guchar*"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
					<parameter name="length" type="gsize*"/>
				</parameters>
			</method>
			<method name="get_filename" symbol="unique_message_data_get_filename">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="unique_message_data_get_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
				</parameters>
			</method>
			<method name="get_startup_id" symbol="unique_message_data_get_startup_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="unique_message_data_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
				</parameters>
			</method>
			<method name="get_uris" symbol="unique_message_data_get_uris">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
				</parameters>
			</method>
			<method name="get_workspace" symbol="unique_message_data_get_workspace">
				<return-type type="guint"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="unique_message_data_new">
				<return-type type="UniqueMessageData*"/>
			</constructor>
			<method name="set" symbol="unique_message_data_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
					<parameter name="data" type="guchar*"/>
					<parameter name="length" type="gsize"/>
				</parameters>
			</method>
			<method name="set_filename" symbol="unique_message_data_set_filename">
				<return-type type="void"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_text" symbol="unique_message_data_set_text">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
					<parameter name="str" type="gchar*"/>
					<parameter name="length" type="gssize"/>
				</parameters>
			</method>
			<method name="set_uris" symbol="unique_message_data_set_uris">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="message_data" type="UniqueMessageData*"/>
					<parameter name="uris" type="gchar**"/>
				</parameters>
			</method>
		</boxed>
		<enum name="UniqueCommand" type-name="UniqueCommand" get-type="unique_command_get_type">
			<member name="UNIQUE_INVALID" value="0"/>
			<member name="UNIQUE_ACTIVATE" value="-1"/>
			<member name="UNIQUE_NEW" value="-2"/>
			<member name="UNIQUE_OPEN" value="-3"/>
			<member name="UNIQUE_CLOSE" value="-4"/>
		</enum>
		<enum name="UniqueResponse" type-name="UniqueResponse" get-type="unique_response_get_type">
			<member name="UNIQUE_RESPONSE_INVALID" value="0"/>
			<member name="UNIQUE_RESPONSE_OK" value="1"/>
			<member name="UNIQUE_RESPONSE_CANCEL" value="2"/>
			<member name="UNIQUE_RESPONSE_FAIL" value="3"/>
			<member name="UNIQUE_RESPONSE_PASSTHROUGH" value="4"/>
		</enum>
		<object name="UniqueApp" parent="GObject" type-name="UniqueApp" get-type="unique_app_get_type">
			<method name="add_command" symbol="unique_app_add_command">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="UniqueApp*"/>
					<parameter name="command_name" type="gchar*"/>
					<parameter name="command_id" type="gint"/>
				</parameters>
			</method>
			<method name="is_running" symbol="unique_app_is_running">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="app" type="UniqueApp*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="unique_app_new">
				<return-type type="UniqueApp*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="startup_id" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_commands" symbol="unique_app_new_with_commands">
				<return-type type="UniqueApp*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="startup_id" type="gchar*"/>
					<parameter name="first_command_name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="send_message" symbol="unique_app_send_message">
				<return-type type="UniqueResponse"/>
				<parameters>
					<parameter name="app" type="UniqueApp*"/>
					<parameter name="command_id" type="gint"/>
					<parameter name="message_data" type="UniqueMessageData*"/>
				</parameters>
			</method>
			<method name="watch_window" symbol="unique_app_watch_window">
				<return-type type="void"/>
				<parameters>
					<parameter name="app" type="UniqueApp*"/>
					<parameter name="window" type="GtkWindow*"/>
				</parameters>
			</method>
			<property name="is-running" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="screen" type="GdkScreen*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="startup-id" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<signal name="message-received" when="LAST">
				<return-type type="UniqueResponse"/>
				<parameters>
					<parameter name="app" type="UniqueApp*"/>
					<parameter name="command" type="gint"/>
					<parameter name="message_data" type="UniqueMessageData*"/>
					<parameter name="time_" type="guint"/>
				</parameters>
			</signal>
		</object>
		<object name="UniqueBackend" parent="GObject" type-name="UniqueBackend" get-type="unique_backend_get_type">
			<method name="create" symbol="unique_backend_create">
				<return-type type="UniqueBackend*"/>
			</method>
			<method name="get_name" symbol="unique_backend_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="backend" type="UniqueBackend*"/>
				</parameters>
			</method>
			<method name="get_screen" symbol="unique_backend_get_screen">
				<return-type type="GdkScreen*"/>
				<parameters>
					<parameter name="backend" type="UniqueBackend*"/>
				</parameters>
			</method>
			<method name="get_startup_id" symbol="unique_backend_get_startup_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="backend" type="UniqueBackend*"/>
				</parameters>
			</method>
			<method name="get_workspace" symbol="unique_backend_get_workspace">
				<return-type type="guint"/>
				<parameters>
					<parameter name="backend" type="UniqueBackend*"/>
				</parameters>
			</method>
			<method name="request_name" symbol="unique_backend_request_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="backend" type="UniqueBackend*"/>
				</parameters>
			</method>
			<method name="send_message" symbol="unique_backend_send_message">
				<return-type type="UniqueResponse"/>
				<parameters>
					<parameter name="backend" type="UniqueBackend*"/>
					<parameter name="command_id" type="gint"/>
					<parameter name="message_data" type="UniqueMessageData*"/>
					<parameter name="time_" type="guint"/>
				</parameters>
			</method>
			<method name="set_name" symbol="unique_backend_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="UniqueBackend*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_screen" symbol="unique_backend_set_screen">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="UniqueBackend*"/>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="set_startup_id" symbol="unique_backend_set_startup_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="backend" type="UniqueBackend*"/>
					<parameter name="startup_id" type="gchar*"/>
				</parameters>
			</method>
			<vfunc name="request_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="backend" type="UniqueBackend*"/>
				</parameters>
			</vfunc>
			<vfunc name="send_message">
				<return-type type="UniqueResponse"/>
				<parameters>
					<parameter name="backend" type="UniqueBackend*"/>
					<parameter name="command_id" type="gint"/>
					<parameter name="message_data" type="UniqueMessageData*"/>
					<parameter name="time_" type="guint"/>
				</parameters>
			</vfunc>
			<field name="parent" type="UniqueApp*"/>
			<field name="name" type="gchar*"/>
			<field name="startup_id" type="gchar*"/>
			<field name="screen" type="GdkScreen*"/>
			<field name="workspace" type="guint"/>
		</object>
		<constant name="UNIQUE_API_VERSION_S" type="char*" value="1.0"/>
		<constant name="UNIQUE_DEFAULT_BACKEND_S" type="char*" value="dbus"/>
		<constant name="UNIQUE_MAJOR_VERSION" type="int" value="1"/>
		<constant name="UNIQUE_MICRO_VERSION" type="int" value="6"/>
		<constant name="UNIQUE_MINOR_VERSION" type="int" value="1"/>
		<constant name="UNIQUE_PROTOCOL_VERSION_S" type="char*" value="1.0"/>
		<constant name="UNIQUE_VERSION_HEX" type="int" value="0"/>
		<constant name="UNIQUE_VERSION_S" type="char*" value="1.1.6"/>
	</namespace>
</api>
