<?xml version="1.0"?>
<api version="1.0">
	<namespace name="GtkClutter">
		<function name="check_version" symbol="gtk_clutter_check_version">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="major" type="guint"/>
				<parameter name="minor" type="guint"/>
				<parameter name="micro" type="guint"/>
			</parameters>
		</function>
		<function name="get_option_group" symbol="gtk_clutter_get_option_group">
			<return-type type="GOptionGroup*"/>
		</function>
		<function name="init" symbol="gtk_clutter_init">
			<return-type type="ClutterInitError"/>
			<parameters>
				<parameter name="argc" type="int*"/>
				<parameter name="argv" type="char***"/>
			</parameters>
		</function>
		<function name="init_with_args" symbol="gtk_clutter_init_with_args">
			<return-type type="ClutterInitError"/>
			<parameters>
				<parameter name="argc" type="int*"/>
				<parameter name="argv" type="char***"/>
				<parameter name="parameter_string" type="char*"/>
				<parameter name="entries" type="GOptionEntry*"/>
				<parameter name="translation_domain" type="char*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<enum name="GtkClutterTextureError">
			<member name="GTK_CLUTTER_TEXTURE_ERROR_INVALID_STOCK_ID" value="0"/>
		</enum>
		<object name="GtkClutterActor" parent="ClutterActor" type-name="GtkClutterActor" get-type="gtk_clutter_actor_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="ClutterAnimatable"/>
				<interface name="AtkImplementor"/>
				<interface name="ClutterContainer"/>
			</implements>
			<method name="get_contents" symbol="gtk_clutter_actor_get_contents">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="actor" type="GtkClutterActor*"/>
				</parameters>
			</method>
			<method name="get_widget" symbol="gtk_clutter_actor_get_widget">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="actor" type="GtkClutterActor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_clutter_actor_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<constructor name="new_with_contents" symbol="gtk_clutter_actor_new_with_contents">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="contents" type="GtkWidget*"/>
				</parameters>
			</constructor>
			<property name="contents" type="GtkWidget*" readable="1" writable="1" construct="1" construct-only="0"/>
		</object>
		<object name="GtkClutterEmbed" parent="GtkContainer" type-name="GtkClutterEmbed" get-type="gtk_clutter_embed_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_stage" symbol="gtk_clutter_embed_get_stage">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="embed" type="GtkClutterEmbed*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_clutter_embed_new">
				<return-type type="GtkWidget*"/>
			</constructor>
		</object>
		<object name="GtkClutterTexture" parent="ClutterTexture" type-name="GtkClutterTexture" get-type="gtk_clutter_texture_get_type">
			<implements>
				<interface name="ClutterScriptable"/>
				<interface name="ClutterAnimatable"/>
				<interface name="AtkImplementor"/>
			</implements>
			<method name="error_quark" symbol="gtk_clutter_texture_error_quark">
				<return-type type="GQuark"/>
			</method>
			<constructor name="new" symbol="gtk_clutter_texture_new">
				<return-type type="ClutterActor*"/>
			</constructor>
			<method name="set_from_icon_name" symbol="gtk_clutter_texture_set_from_icon_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="texture" type="GtkClutterTexture*"/>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="icon_name" type="gchar*"/>
					<parameter name="icon_size" type="GtkIconSize"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_from_pixbuf" symbol="gtk_clutter_texture_set_from_pixbuf">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="texture" type="GtkClutterTexture*"/>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_from_stock" symbol="gtk_clutter_texture_set_from_stock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="texture" type="GtkClutterTexture*"/>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="stock_id" type="gchar*"/>
					<parameter name="icon_size" type="GtkIconSize"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</object>
		<object name="GtkClutterWindow" parent="GtkWindow" type-name="GtkClutterWindow" get-type="gtk_clutter_window_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_stage" symbol="gtk_clutter_window_get_stage">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="window" type="GtkClutterWindow*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_clutter_window_new">
				<return-type type="GtkWidget*"/>
			</constructor>
		</object>
		<constant name="CLUTTER_GTK_MAJOR_VERSION" type="int" value="1"/>
		<constant name="CLUTTER_GTK_MICRO_VERSION" type="int" value="0"/>
		<constant name="CLUTTER_GTK_MINOR_VERSION" type="int" value="0"/>
		<constant name="CLUTTER_GTK_VERSION_HEX" type="int" value="0"/>
		<constant name="CLUTTER_GTK_VERSION_S" type="char*" value="1.0.0"/>
	</namespace>
</api>
