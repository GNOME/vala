<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Sexy">
		<function name="spell_error_quark" symbol="sexy_spell_error_quark">
			<return-type type="GQuark"/>
		</function>
		<struct name="SexyIconEntryPriv">
		</struct>
		<struct name="SexySpellEntryPriv">
		</struct>
		<struct name="SexyTreeViewPriv">
		</struct>
		<enum name="SexyIconEntryPosition" type-name="SexyIconEntryPosition" get-type="sexy_icon_entry_position_get_type">
			<member name="SEXY_ICON_ENTRY_PRIMARY" value="0"/>
			<member name="SEXY_ICON_ENTRY_SECONDARY" value="1"/>
		</enum>
		<enum name="SexySpellError" type-name="SexySpellError" get-type="sexy_spell_error_get_type">
			<member name="SEXY_SPELL_ERROR_BACKEND" value="0"/>
		</enum>
		<object name="SexyIconEntry" parent="GtkEntry" type-name="SexyIconEntry" get-type="sexy_icon_entry_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkEditable"/>
				<interface name="GtkCellEditable"/>
			</implements>
			<method name="add_clear_button" symbol="sexy_icon_entry_add_clear_button">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon_entry" type="SexyIconEntry*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="sexy_icon_entry_get_icon">
				<return-type type="GtkImage*"/>
				<parameters>
					<parameter name="entry" type="SexyIconEntry*"/>
					<parameter name="position" type="SexyIconEntryPosition"/>
				</parameters>
			</method>
			<method name="get_icon_highlight" symbol="sexy_icon_entry_get_icon_highlight">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="SexyIconEntry*"/>
					<parameter name="position" type="SexyIconEntryPosition"/>
				</parameters>
			</method>
			<constructor name="new" symbol="sexy_icon_entry_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_icon" symbol="sexy_icon_entry_set_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="SexyIconEntry*"/>
					<parameter name="position" type="SexyIconEntryPosition"/>
					<parameter name="icon" type="GtkImage*"/>
				</parameters>
			</method>
			<method name="set_icon_highlight" symbol="sexy_icon_entry_set_icon_highlight">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="SexyIconEntry*"/>
					<parameter name="position" type="SexyIconEntryPosition"/>
					<parameter name="highlight" type="gboolean"/>
				</parameters>
			</method>
			<signal name="icon-pressed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="SexyIconEntry*"/>
					<parameter name="icon_pos" type="gint"/>
					<parameter name="button" type="gint"/>
				</parameters>
			</signal>
			<signal name="icon-released" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="SexyIconEntry*"/>
					<parameter name="icon_pos" type="gint"/>
					<parameter name="button" type="gint"/>
				</parameters>
			</signal>
			<vfunc name="gtk_reserved1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="gtk_reserved2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="gtk_reserved3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="gtk_reserved4">
				<return-type type="void"/>
			</vfunc>
			<field name="gtk_reserved1" type="GCallback"/>
			<field name="gtk_reserved2" type="GCallback"/>
			<field name="gtk_reserved3" type="GCallback"/>
			<field name="gtk_reserved4" type="GCallback"/>
		</object>
		<object name="SexySpellEntry" parent="GtkEntry" type-name="SexySpellEntry" get-type="sexy_spell_entry_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
				<interface name="GtkEditable"/>
				<interface name="GtkCellEditable"/>
			</implements>
			<method name="activate_default_languages" symbol="sexy_spell_entry_activate_default_languages">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="SexySpellEntry*"/>
				</parameters>
			</method>
			<method name="activate_language" symbol="sexy_spell_entry_activate_language">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="SexySpellEntry*"/>
					<parameter name="lang" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="deactivate_language" symbol="sexy_spell_entry_deactivate_language">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="SexySpellEntry*"/>
					<parameter name="lang" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_active_languages" symbol="sexy_spell_entry_get_active_languages">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="entry" type="SexySpellEntry*"/>
				</parameters>
			</method>
			<method name="get_language_name" symbol="sexy_spell_entry_get_language_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="entry" type="SexySpellEntry*"/>
					<parameter name="lang" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_languages" symbol="sexy_spell_entry_get_languages">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="entry" type="SexySpellEntry*"/>
				</parameters>
			</method>
			<method name="is_checked" symbol="sexy_spell_entry_is_checked">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="SexySpellEntry*"/>
				</parameters>
			</method>
			<method name="language_is_active" symbol="sexy_spell_entry_language_is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="SexySpellEntry*"/>
					<parameter name="lang" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="sexy_spell_entry_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_active_languages" symbol="sexy_spell_entry_set_active_languages">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="SexySpellEntry*"/>
					<parameter name="langs" type="GSList*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_checked" symbol="sexy_spell_entry_set_checked">
				<return-type type="void"/>
				<parameters>
					<parameter name="entry" type="SexySpellEntry*"/>
					<parameter name="checked" type="gboolean"/>
				</parameters>
			</method>
			<signal name="word-check" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="entry" type="SexySpellEntry*"/>
					<parameter name="word" type="char*"/>
				</parameters>
			</signal>
			<vfunc name="gtk_reserved1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="gtk_reserved2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="gtk_reserved3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="gtk_reserved4">
				<return-type type="void"/>
			</vfunc>
			<field name="gtk_reserved1" type="GCallback"/>
			<field name="gtk_reserved2" type="GCallback"/>
			<field name="gtk_reserved3" type="GCallback"/>
			<field name="gtk_reserved4" type="GCallback"/>
		</object>
		<object name="SexyTooltip" parent="GtkWindow" type-name="SexyTooltip" get-type="sexy_tooltip_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="sexy_tooltip_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<constructor name="new_with_label" symbol="sexy_tooltip_new_with_label">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="position_to_rect" symbol="sexy_tooltip_position_to_rect">
				<return-type type="void"/>
				<parameters>
					<parameter name="tooltip" type="SexyTooltip*"/>
					<parameter name="rect" type="GdkRectangle*"/>
					<parameter name="screen" type="GdkScreen*"/>
				</parameters>
			</method>
			<method name="position_to_widget" symbol="sexy_tooltip_position_to_widget">
				<return-type type="void"/>
				<parameters>
					<parameter name="tooltip" type="SexyTooltip*"/>
					<parameter name="widget" type="GtkWidget*"/>
				</parameters>
			</method>
		</object>
		<object name="SexyTreeView" parent="GtkTreeView" type-name="SexyTreeView" get-type="sexy_tree_view_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="sexy_tree_view_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_tooltip_label_column" symbol="sexy_tree_view_set_tooltip_label_column">
				<return-type type="void"/>
				<parameters>
					<parameter name="treeview" type="SexyTreeView*"/>
					<parameter name="column" type="guint"/>
				</parameters>
			</method>
			<signal name="get-tooltip" when="LAST">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="treeview" type="SexyTreeView*"/>
					<parameter name="path" type="GtkTreePath*"/>
					<parameter name="column" type="GtkTreeViewColumn*"/>
				</parameters>
			</signal>
		</object>
		<object name="SexyUrlLabel" parent="GtkLabel" type-name="SexyUrlLabel" get-type="sexy_url_label_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<constructor name="new" symbol="sexy_url_label_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="set_markup" symbol="sexy_url_label_set_markup">
				<return-type type="void"/>
				<parameters>
					<parameter name="url_label" type="SexyUrlLabel*"/>
					<parameter name="markup" type="gchar*"/>
				</parameters>
			</method>
			<signal name="url-activated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="url_label" type="SexyUrlLabel*"/>
					<parameter name="url" type="char*"/>
				</parameters>
			</signal>
			<vfunc name="gtk_reserved1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="gtk_reserved2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="gtk_reserved3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="gtk_reserved4">
				<return-type type="void"/>
			</vfunc>
			<field name="gtk_reserved1" type="GCallback"/>
			<field name="gtk_reserved2" type="GCallback"/>
			<field name="gtk_reserved3" type="GCallback"/>
			<field name="gtk_reserved4" type="GCallback"/>
		</object>
	</namespace>
</api>
