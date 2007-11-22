<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Glade">
		<function name="enum_from_string" symbol="glade_enum_from_string">
			<return-type type="gint"/>
			<parameters>
				<parameter name="type" type="GType"/>
				<parameter name="string" type="char*"/>
			</parameters>
		</function>
		<function name="flags_from_string" symbol="glade_flags_from_string">
			<return-type type="guint"/>
			<parameters>
				<parameter name="type" type="GType"/>
				<parameter name="string" type="char*"/>
			</parameters>
		</function>
		<function name="get_widget_name" symbol="glade_get_widget_name">
			<return-type type="char*"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
			</parameters>
		</function>
		<function name="get_widget_tree" symbol="glade_get_widget_tree">
			<return-type type="GladeXML*"/>
			<parameters>
				<parameter name="widget" type="GtkWidget*"/>
			</parameters>
		</function>
		<function name="init" symbol="glade_init">
			<return-type type="void"/>
		</function>
		<function name="module_check_version" symbol="glade_module_check_version">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="version" type="gint"/>
			</parameters>
		</function>
		<function name="module_register_widgets" symbol="glade_module_register_widgets">
			<return-type type="void"/>
		</function>
		<function name="parser_parse_buffer" symbol="glade_parser_parse_buffer">
			<return-type type="GladeInterface*"/>
			<parameters>
				<parameter name="buffer" type="gchar*"/>
				<parameter name="len" type="gint"/>
				<parameter name="domain" type="gchar*"/>
			</parameters>
		</function>
		<function name="parser_parse_file" symbol="glade_parser_parse_file">
			<return-type type="GladeInterface*"/>
			<parameters>
				<parameter name="file" type="gchar*"/>
				<parameter name="domain" type="gchar*"/>
			</parameters>
		</function>
		<function name="provide" symbol="glade_provide">
			<return-type type="void"/>
			<parameters>
				<parameter name="library" type="gchar*"/>
			</parameters>
		</function>
		<function name="register_custom_prop" symbol="glade_register_custom_prop">
			<return-type type="void"/>
			<parameters>
				<parameter name="type" type="GType"/>
				<parameter name="prop_name" type="gchar*"/>
				<parameter name="apply_prop" type="GladeApplyCustomPropFunc"/>
			</parameters>
		</function>
		<function name="register_widget" symbol="glade_register_widget">
			<return-type type="void"/>
			<parameters>
				<parameter name="type" type="GType"/>
				<parameter name="new_func" type="GladeNewFunc"/>
				<parameter name="build_children" type="GladeBuildChildrenFunc"/>
				<parameter name="find_internal_child" type="GladeFindInternalChildFunc"/>
			</parameters>
		</function>
		<function name="require" symbol="glade_require">
			<return-type type="void"/>
			<parameters>
				<parameter name="library" type="gchar*"/>
			</parameters>
		</function>
		<function name="set_custom_handler" symbol="glade_set_custom_handler">
			<return-type type="void"/>
			<parameters>
				<parameter name="handler" type="GladeXMLCustomWidgetHandler"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="standard_build_children" symbol="glade_standard_build_children">
			<return-type type="void"/>
			<parameters>
				<parameter name="self" type="GladeXML*"/>
				<parameter name="parent" type="GtkWidget*"/>
				<parameter name="info" type="GladeWidgetInfo*"/>
			</parameters>
		</function>
		<function name="standard_build_widget" symbol="glade_standard_build_widget">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="xml" type="GladeXML*"/>
				<parameter name="widget_type" type="GType"/>
				<parameter name="info" type="GladeWidgetInfo*"/>
			</parameters>
		</function>
		<callback name="GladeApplyCustomPropFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="xml" type="GladeXML*"/>
				<parameter name="widget" type="GtkWidget*"/>
				<parameter name="propname" type="gchar*"/>
				<parameter name="value" type="gchar*"/>
			</parameters>
		</callback>
		<callback name="GladeBuildChildrenFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="xml" type="GladeXML*"/>
				<parameter name="parent" type="GtkWidget*"/>
				<parameter name="info" type="GladeWidgetInfo*"/>
			</parameters>
		</callback>
		<callback name="GladeFindInternalChildFunc">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="xml" type="GladeXML*"/>
				<parameter name="parent" type="GtkWidget*"/>
				<parameter name="childname" type="gchar*"/>
			</parameters>
		</callback>
		<callback name="GladeNewFunc">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="xml" type="GladeXML*"/>
				<parameter name="widget_type" type="GType"/>
				<parameter name="info" type="GladeWidgetInfo*"/>
			</parameters>
		</callback>
		<callback name="GladeXMLConnectFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="handler_name" type="gchar*"/>
				<parameter name="object" type="GObject*"/>
				<parameter name="signal_name" type="gchar*"/>
				<parameter name="signal_data" type="gchar*"/>
				<parameter name="connect_object" type="GObject*"/>
				<parameter name="after" type="gboolean"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GladeXMLCustomWidgetHandler">
			<return-type type="GtkWidget*"/>
			<parameters>
				<parameter name="xml" type="GladeXML*"/>
				<parameter name="func_name" type="gchar*"/>
				<parameter name="name" type="gchar*"/>
				<parameter name="string1" type="gchar*"/>
				<parameter name="string2" type="gchar*"/>
				<parameter name="int1" type="gint"/>
				<parameter name="int2" type="gint"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GladeAccelInfo">
			<field name="key" type="guint"/>
			<field name="modifiers" type="GdkModifierType"/>
			<field name="signal" type="gchar*"/>
		</struct>
		<struct name="GladeAtkActionInfo">
			<field name="action_name" type="gchar*"/>
			<field name="description" type="gchar*"/>
		</struct>
		<struct name="GladeAtkRelationInfo">
			<field name="target" type="gchar*"/>
			<field name="type" type="gchar*"/>
		</struct>
		<struct name="GladeChildInfo">
			<field name="properties" type="GladeProperty*"/>
			<field name="n_properties" type="guint"/>
			<field name="child" type="GladeWidgetInfo*"/>
			<field name="internal_child" type="gchar*"/>
		</struct>
		<struct name="GladeInterface">
			<method name="destroy" symbol="glade_interface_destroy">
				<return-type type="void"/>
				<parameters>
					<parameter name="interface" type="GladeInterface*"/>
				</parameters>
			</method>
			<method name="dump" symbol="glade_interface_dump">
				<return-type type="void"/>
				<parameters>
					<parameter name="interface" type="GladeInterface*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<field name="requires" type="gchar**"/>
			<field name="n_requires" type="guint"/>
			<field name="toplevels" type="GladeWidgetInfo**"/>
			<field name="n_toplevels" type="guint"/>
			<field name="names" type="GHashTable*"/>
			<field name="strings" type="GHashTable*"/>
		</struct>
		<struct name="GladeProperty">
			<field name="name" type="gchar*"/>
			<field name="value" type="gchar*"/>
		</struct>
		<struct name="GladeSignalInfo">
			<field name="name" type="gchar*"/>
			<field name="handler" type="gchar*"/>
			<field name="object" type="gchar*"/>
			<field name="after" type="guint"/>
		</struct>
		<struct name="GladeWidgetInfo">
			<field name="parent" type="GladeWidgetInfo*"/>
			<field name="classname" type="gchar*"/>
			<field name="name" type="gchar*"/>
			<field name="properties" type="GladeProperty*"/>
			<field name="n_properties" type="guint"/>
			<field name="atk_props" type="GladeProperty*"/>
			<field name="n_atk_props" type="guint"/>
			<field name="signals" type="GladeSignalInfo*"/>
			<field name="n_signals" type="guint"/>
			<field name="atk_actions" type="GladeAtkActionInfo*"/>
			<field name="n_atk_actions" type="guint"/>
			<field name="relations" type="GladeAtkRelationInfo*"/>
			<field name="n_relations" type="guint"/>
			<field name="accels" type="GladeAccelInfo*"/>
			<field name="n_accels" type="guint"/>
			<field name="children" type="GladeChildInfo*"/>
			<field name="n_children" type="guint"/>
		</struct>
		<object name="GladeXML" parent="GObject" type-name="GladeXML" get-type="glade_xml_get_type">
			<method name="build_widget" symbol="glade_xml_build_widget">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="info" type="GladeWidgetInfo*"/>
				</parameters>
			</method>
			<method name="construct" symbol="glade_xml_construct">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="fname" type="char*"/>
					<parameter name="root" type="char*"/>
					<parameter name="domain" type="char*"/>
				</parameters>
			</method>
			<method name="construct_from_buffer" symbol="glade_xml_construct_from_buffer">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="buffer" type="char*"/>
					<parameter name="size" type="int"/>
					<parameter name="root" type="char*"/>
					<parameter name="domain" type="char*"/>
				</parameters>
			</method>
			<method name="ensure_accel" symbol="glade_xml_ensure_accel">
				<return-type type="GtkAccelGroup*"/>
				<parameters>
					<parameter name="xml" type="GladeXML*"/>
				</parameters>
			</method>
			<method name="get_widget" symbol="glade_xml_get_widget">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_widget_prefix" symbol="glade_xml_get_widget_prefix">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="handle_internal_child" symbol="glade_xml_handle_internal_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="parent" type="GtkWidget*"/>
					<parameter name="child_info" type="GladeChildInfo*"/>
				</parameters>
			</method>
			<method name="handle_widget_prop" symbol="glade_xml_handle_widget_prop">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="prop_name" type="gchar*"/>
					<parameter name="value_name" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="glade_xml_new">
				<return-type type="GladeXML*"/>
				<parameters>
					<parameter name="fname" type="char*"/>
					<parameter name="root" type="char*"/>
					<parameter name="domain" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_buffer" symbol="glade_xml_new_from_buffer">
				<return-type type="GladeXML*"/>
				<parameters>
					<parameter name="buffer" type="char*"/>
					<parameter name="size" type="int"/>
					<parameter name="root" type="char*"/>
					<parameter name="domain" type="char*"/>
				</parameters>
			</constructor>
			<method name="relative_file" symbol="glade_xml_relative_file">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_common_params" symbol="glade_xml_set_common_params">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="widget" type="GtkWidget*"/>
					<parameter name="info" type="GladeWidgetInfo*"/>
				</parameters>
			</method>
			<method name="set_packing_property" symbol="glade_xml_set_packing_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="parent" type="GtkWidget*"/>
					<parameter name="child" type="GtkWidget*"/>
					<parameter name="name" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_toplevel" symbol="glade_xml_set_toplevel">
				<return-type type="void"/>
				<parameters>
					<parameter name="xml" type="GladeXML*"/>
					<parameter name="window" type="GtkWindow*"/>
				</parameters>
			</method>
			<method name="set_value_from_string" symbol="glade_xml_set_value_from_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="xml" type="GladeXML*"/>
					<parameter name="pspec" type="GParamSpec*"/>
					<parameter name="string" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="signal_autoconnect" symbol="glade_xml_signal_autoconnect">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
				</parameters>
			</method>
			<method name="signal_autoconnect_full" symbol="glade_xml_signal_autoconnect_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="func" type="GladeXMLConnectFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="signal_connect" symbol="glade_xml_signal_connect">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="handlername" type="char*"/>
					<parameter name="func" type="GCallback"/>
				</parameters>
			</method>
			<method name="signal_connect_data" symbol="glade_xml_signal_connect_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="handlername" type="char*"/>
					<parameter name="func" type="GCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="signal_connect_full" symbol="glade_xml_signal_connect_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="handler_name" type="gchar*"/>
					<parameter name="func" type="GladeXMLConnectFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<vfunc name="lookup_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="self" type="GladeXML*"/>
					<parameter name="gtypename" type="char*"/>
				</parameters>
			</vfunc>
			<field name="filename" type="char*"/>
		</object>
		<constant name="GLADE_MODULE_API_VERSION" type="int" value="1"/>
	</namespace>
</api>
