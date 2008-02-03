<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Json">
		<function name="construct_gobject" symbol="json_construct_gobject">
			<return-type type="GObject*"/>
			<parameters>
				<parameter name="gtype" type="GType"/>
				<parameter name="data" type="gchar*"/>
				<parameter name="length" type="gsize"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="serialize_gobject" symbol="json_serialize_gobject">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="gobject" type="GObject*"/>
				<parameter name="length" type="gsize*"/>
			</parameters>
		</function>
		<boxed name="JsonArray" type-name="JsonArray" get-type="json_array_get_type">
			<method name="add_element" symbol="json_array_add_element">
				<return-type type="void"/>
				<parameters>
					<parameter name="array" type="JsonArray*"/>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="get_element" symbol="json_array_get_element">
				<return-type type="JsonNode*"/>
				<parameters>
					<parameter name="array" type="JsonArray*"/>
					<parameter name="index_" type="guint"/>
				</parameters>
			</method>
			<method name="get_elements" symbol="json_array_get_elements">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="array" type="JsonArray*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="json_array_get_length">
				<return-type type="guint"/>
				<parameters>
					<parameter name="array" type="JsonArray*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="json_array_new">
				<return-type type="JsonArray*"/>
			</constructor>
			<method name="ref" symbol="json_array_ref">
				<return-type type="JsonArray*"/>
				<parameters>
					<parameter name="array" type="JsonArray*"/>
				</parameters>
			</method>
			<method name="remove_element" symbol="json_array_remove_element">
				<return-type type="void"/>
				<parameters>
					<parameter name="array" type="JsonArray*"/>
					<parameter name="index_" type="guint"/>
				</parameters>
			</method>
			<method name="sized_new" symbol="json_array_sized_new">
				<return-type type="JsonArray*"/>
				<parameters>
					<parameter name="n_elements" type="guint"/>
				</parameters>
			</method>
			<method name="unref" symbol="json_array_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="array" type="JsonArray*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="JsonNode" type-name="JsonNode" get-type="json_node_get_type">
			<method name="copy" symbol="json_node_copy">
				<return-type type="JsonNode*"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="dup_array" symbol="json_node_dup_array">
				<return-type type="JsonArray*"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="dup_object" symbol="json_node_dup_object">
				<return-type type="JsonObject*"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="dup_string" symbol="json_node_dup_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="free" symbol="json_node_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="get_array" symbol="json_node_get_array">
				<return-type type="JsonArray*"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="get_boolean" symbol="json_node_get_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="get_double" symbol="json_node_get_double">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="get_int" symbol="json_node_get_int">
				<return-type type="gint"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="get_object" symbol="json_node_get_object">
				<return-type type="JsonObject*"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="json_node_get_parent">
				<return-type type="JsonNode*"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="get_string" symbol="json_node_get_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="json_node_get_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_value_type" symbol="json_node_get_value_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="json_node_new">
				<return-type type="JsonNode*"/>
				<parameters>
					<parameter name="type" type="JsonNodeType"/>
				</parameters>
			</constructor>
			<method name="set_array" symbol="json_node_set_array">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
					<parameter name="array" type="JsonArray*"/>
				</parameters>
			</method>
			<method name="set_boolean" symbol="json_node_set_boolean">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_double" symbol="json_node_set_double">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
					<parameter name="value" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_int" symbol="json_node_set_int">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_object" symbol="json_node_set_object">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
					<parameter name="object" type="JsonObject*"/>
				</parameters>
			</method>
			<method name="set_string" symbol="json_node_set_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_value" symbol="json_node_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="take_array" symbol="json_node_take_array">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
					<parameter name="array" type="JsonArray*"/>
				</parameters>
			</method>
			<method name="take_object" symbol="json_node_take_object">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
					<parameter name="object" type="JsonObject*"/>
				</parameters>
			</method>
			<method name="type_name" symbol="json_node_type_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<field name="type" type="JsonNodeType"/>
			<field name="data" type="gpointer"/>
			<field name="parent" type="JsonNode*"/>
		</boxed>
		<boxed name="JsonObject" type-name="JsonObject" get-type="json_object_get_type">
			<method name="add_member" symbol="json_object_add_member">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="JsonObject*"/>
					<parameter name="member_name" type="gchar*"/>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="get_member" symbol="json_object_get_member">
				<return-type type="JsonNode*"/>
				<parameters>
					<parameter name="object" type="JsonObject*"/>
					<parameter name="member_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_members" symbol="json_object_get_members">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="object" type="JsonObject*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="json_object_get_size">
				<return-type type="guint"/>
				<parameters>
					<parameter name="object" type="JsonObject*"/>
				</parameters>
			</method>
			<method name="get_values" symbol="json_object_get_values">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="object" type="JsonObject*"/>
				</parameters>
			</method>
			<method name="has_member" symbol="json_object_has_member">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="object" type="JsonObject*"/>
					<parameter name="member_name" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="json_object_new">
				<return-type type="JsonObject*"/>
			</constructor>
			<method name="ref" symbol="json_object_ref">
				<return-type type="JsonObject*"/>
				<parameters>
					<parameter name="object" type="JsonObject*"/>
				</parameters>
			</method>
			<method name="remove_member" symbol="json_object_remove_member">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="JsonObject*"/>
					<parameter name="member_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="unref" symbol="json_object_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="JsonObject*"/>
				</parameters>
			</method>
		</boxed>
		<enum name="JsonNodeType">
			<member name="JSON_NODE_OBJECT" value="0"/>
			<member name="JSON_NODE_ARRAY" value="1"/>
			<member name="JSON_NODE_VALUE" value="2"/>
			<member name="JSON_NODE_NULL" value="3"/>
		</enum>
		<enum name="JsonParserError">
			<member name="JSON_PARSER_ERROR_PARSE" value="0"/>
			<member name="JSON_PARSER_ERROR_UNKNOWN" value="1"/>
		</enum>
		<enum name="JsonTokenType">
			<member name="JSON_TOKEN_INVALID" value="270"/>
			<member name="JSON_TOKEN_TRUE" value="271"/>
			<member name="JSON_TOKEN_FALSE" value="272"/>
			<member name="JSON_TOKEN_NULL" value="273"/>
			<member name="JSON_TOKEN_VAR" value="274"/>
			<member name="JSON_TOKEN_LAST" value="275"/>
		</enum>
		<object name="JsonGenerator" parent="GObject" type-name="JsonGenerator" get-type="json_generator_get_type">
			<constructor name="new" symbol="json_generator_new">
				<return-type type="JsonGenerator*"/>
			</constructor>
			<method name="set_root" symbol="json_generator_set_root">
				<return-type type="void"/>
				<parameters>
					<parameter name="generator" type="JsonGenerator*"/>
					<parameter name="node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="to_data" symbol="json_generator_to_data">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="generator" type="JsonGenerator*"/>
					<parameter name="length" type="gsize*"/>
				</parameters>
			</method>
			<method name="to_file" symbol="json_generator_to_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="generator" type="JsonGenerator*"/>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="indent" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="pretty" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="root" type="JsonNode*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="JsonParser" parent="GObject" type-name="JsonParser" get-type="json_parser_get_type">
			<method name="error_quark" symbol="json_parser_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_current_line" symbol="json_parser_get_current_line">
				<return-type type="guint"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
				</parameters>
			</method>
			<method name="get_current_pos" symbol="json_parser_get_current_pos">
				<return-type type="guint"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
				</parameters>
			</method>
			<method name="get_root" symbol="json_parser_get_root">
				<return-type type="JsonNode*"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
				</parameters>
			</method>
			<method name="has_assignment" symbol="json_parser_has_assignment">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
					<parameter name="variable_name" type="gchar**"/>
				</parameters>
			</method>
			<method name="load_from_data" symbol="json_parser_load_from_data">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="length" type="gsize"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="load_from_file" symbol="json_parser_load_from_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="json_parser_new">
				<return-type type="JsonParser*"/>
			</constructor>
			<signal name="array-element" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
					<parameter name="array" type="JsonArray*"/>
					<parameter name="index_" type="gint"/>
				</parameters>
			</signal>
			<signal name="array-end" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
					<parameter name="array" type="JsonArray*"/>
				</parameters>
			</signal>
			<signal name="array-start" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
				</parameters>
			</signal>
			<signal name="error" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
					<parameter name="error" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="object-end" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
					<parameter name="object" type="JsonObject*"/>
				</parameters>
			</signal>
			<signal name="object-member" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
					<parameter name="object" type="JsonObject*"/>
					<parameter name="member_name" type="char*"/>
				</parameters>
			</signal>
			<signal name="object-start" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
				</parameters>
			</signal>
			<signal name="parse-end" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
				</parameters>
			</signal>
			<signal name="parse-start" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="JsonParser*"/>
				</parameters>
			</signal>
		</object>
		<interface name="JsonSerializable" type-name="JsonSerializable" get-type="json_serializable_get_type">
			<method name="deserialize_property" symbol="json_serializable_deserialize_property">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="serializable" type="JsonSerializable*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="pspec" type="GParamSpec*"/>
					<parameter name="property_node" type="JsonNode*"/>
				</parameters>
			</method>
			<method name="serialize_property" symbol="json_serializable_serialize_property">
				<return-type type="JsonNode*"/>
				<parameters>
					<parameter name="serializable" type="JsonSerializable*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</method>
			<vfunc name="deserialize_property">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="serializable" type="JsonSerializable*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="pspec" type="GParamSpec*"/>
					<parameter name="property_node" type="JsonNode*"/>
				</parameters>
			</vfunc>
			<vfunc name="serialize_property">
				<return-type type="JsonNode*"/>
				<parameters>
					<parameter name="serializable" type="JsonSerializable*"/>
					<parameter name="property_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="JSON_MAJOR_VERSION" type="int" value="0"/>
		<constant name="JSON_MICRO_VERSION" type="int" value="0"/>
		<constant name="JSON_MINOR_VERSION" type="int" value="4"/>
		<constant name="JSON_VERSION_HEX" type="int" value="0"/>
		<constant name="JSON_VERSION_S" type="char*" value="0.4.0"/>
	</namespace>
</api>
