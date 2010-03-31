<?xml version="1.0"?>
<api version="1.0">
	<namespace name="GtkClutter">
		<function name="get_base_color" symbol="gtk_clutter_get_base_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="state" type="GtkStateType"/>
				<parameter name="color" type="ClutterColor*"/>
			</parameters>
		</function>
		<function name="get_bg_color" symbol="gtk_clutter_get_bg_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="state" type="GtkStateType"/>
				<parameter name="color" type="ClutterColor*"/>
			</parameters>
		</function>
		<function name="get_dark_color" symbol="gtk_clutter_get_dark_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="state" type="GtkStateType"/>
				<parameter name="color" type="ClutterColor*"/>
			</parameters>
		</function>
		<function name="get_fg_color" symbol="gtk_clutter_get_fg_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="state" type="GtkStateType"/>
				<parameter name="color" type="ClutterColor*"/>
			</parameters>
		</function>
		<function name="get_light_color" symbol="gtk_clutter_get_light_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="state" type="GtkStateType"/>
				<parameter name="color" type="ClutterColor*"/>
			</parameters>
		</function>
		<function name="get_mid_color" symbol="gtk_clutter_get_mid_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="state" type="GtkStateType"/>
				<parameter name="color" type="ClutterColor*"/>
			</parameters>
		</function>
		<function name="get_text_aa_color" symbol="gtk_clutter_get_text_aa_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="state" type="GtkStateType"/>
				<parameter name="color" type="ClutterColor*"/>
			</parameters>
		</function>
		<function name="get_text_color" symbol="gtk_clutter_get_text_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="state" type="GtkStateType"/>
				<parameter name="color" type="ClutterColor*"/>
			</parameters>
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
		<function name="texture_error_quark" symbol="gtk_clutter_texture_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="texture_new_from_icon_name" symbol="gtk_clutter_texture_new_from_icon_name">
			<return-type type="ClutterActor*"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="icon_name" type="gchar*"/>
				<parameter name="size" type="GtkIconSize"/>
			</parameters>
		</function>
		<function name="texture_new_from_pixbuf" symbol="gtk_clutter_texture_new_from_pixbuf">
			<return-type type="ClutterActor*"/>
			<parameters>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
			</parameters>
		</function>
		<function name="texture_new_from_stock" symbol="gtk_clutter_texture_new_from_stock">
			<return-type type="ClutterActor*"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="stock_id" type="gchar*"/>
				<parameter name="size" type="GtkIconSize"/>
			</parameters>
		</function>
		<function name="texture_set_from_icon_name" symbol="gtk_clutter_texture_set_from_icon_name">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="texture" type="ClutterTexture*"/>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="icon_name" type="gchar*"/>
				<parameter name="size" type="GtkIconSize"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="texture_set_from_pixbuf" symbol="gtk_clutter_texture_set_from_pixbuf">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="texture" type="ClutterTexture*"/>
				<parameter name="pixbuf" type="GdkPixbuf*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="texture_set_from_stock" symbol="gtk_clutter_texture_set_from_stock">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="texture" type="ClutterTexture*"/>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="stock_id" type="gchar*"/>
				<parameter name="size" type="GtkIconSize"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<enum name="ClutterGtkInitError">
			<member name="CLUTTER_INIT_ERROR_LAST" value="-3"/>
			<member name="CLUTTER_INIT_ERROR_GTK" value="-4"/>
		</enum>
		<enum name="ClutterGtkTextureError">
			<member name="CLUTTER_GTK_TEXTURE_INVALID_STOCK_ID" value="0"/>
			<member name="CLUTTER_GTK_TEXTURE_ERROR_LAST" value="1"/>
		</enum>
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
		<object name="GtkClutterViewport" parent="ClutterActor" type-name="GtkClutterViewport" get-type="gtk_clutter_viewport_get_type">
			<implements>
				<interface name="GtkClutterZoomable"/>
				<interface name="GtkClutterScrollable"/>
				<interface name="ClutterContainer"/>
				<interface name="ClutterScriptable"/>
			</implements>
			<method name="get_origin" symbol="gtk_clutter_viewport_get_origin">
				<return-type type="void"/>
				<parameters>
					<parameter name="viewport" type="GtkClutterViewport*"/>
					<parameter name="x" type="gfloat*"/>
					<parameter name="y" type="gfloat*"/>
					<parameter name="z" type="gfloat*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_clutter_viewport_new">
				<return-type type="ClutterActor*"/>
				<parameters>
					<parameter name="h_adjust" type="GtkAdjustment*"/>
					<parameter name="v_adjust" type="GtkAdjustment*"/>
					<parameter name="z_adjust" type="GtkAdjustment*"/>
				</parameters>
			</constructor>
			<property name="child" type="ClutterActor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="origin" type="ClutterVertex*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<interface name="GtkClutterScrollable" type-name="GtkClutterScrollable" get-type="gtk_clutter_scrollable_get_type">
			<method name="get_adjustments" symbol="gtk_clutter_scrollable_get_adjustments">
				<return-type type="void"/>
				<parameters>
					<parameter name="scrollable" type="GtkClutterScrollable*"/>
					<parameter name="h_adjust" type="GtkAdjustment**"/>
					<parameter name="v_adjust" type="GtkAdjustment**"/>
				</parameters>
			</method>
			<method name="set_adjustments" symbol="gtk_clutter_scrollable_set_adjustments">
				<return-type type="void"/>
				<parameters>
					<parameter name="scrollable" type="GtkClutterScrollable*"/>
					<parameter name="h_adjust" type="GtkAdjustment*"/>
					<parameter name="v_adjust" type="GtkAdjustment*"/>
				</parameters>
			</method>
			<vfunc name="get_adjustments">
				<return-type type="void"/>
				<parameters>
					<parameter name="scrollable" type="GtkClutterScrollable*"/>
					<parameter name="h_adjust" type="GtkAdjustment**"/>
					<parameter name="v_adjust" type="GtkAdjustment**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_adjustments">
				<return-type type="void"/>
				<parameters>
					<parameter name="scrollable" type="GtkClutterScrollable*"/>
					<parameter name="h_adjust" type="GtkAdjustment*"/>
					<parameter name="v_adjust" type="GtkAdjustment*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GtkClutterZoomable" type-name="GtkClutterZoomable" get-type="gtk_clutter_zoomable_get_type">
			<method name="get_adjustment" symbol="gtk_clutter_zoomable_get_adjustment">
				<return-type type="GtkAdjustment*"/>
				<parameters>
					<parameter name="zoomable" type="GtkClutterZoomable*"/>
				</parameters>
			</method>
			<method name="set_adjustment" symbol="gtk_clutter_zoomable_set_adjustment">
				<return-type type="void"/>
				<parameters>
					<parameter name="zoomable" type="GtkClutterZoomable*"/>
					<parameter name="z_adjust" type="GtkAdjustment*"/>
				</parameters>
			</method>
			<vfunc name="get_adjustment">
				<return-type type="GtkAdjustment*"/>
				<parameters>
					<parameter name="zoomable" type="GtkClutterZoomable*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_adjustment">
				<return-type type="void"/>
				<parameters>
					<parameter name="zoomable" type="GtkClutterZoomable*"/>
					<parameter name="z_adjust" type="GtkAdjustment*"/>
				</parameters>
			</vfunc>
		</interface>
	</namespace>
</api>
