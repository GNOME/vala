<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gda">
		<function name="alphanum_to_text" symbol="gda_alphanum_to_text">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="text" type="gchar*"/>
			</parameters>
		</function>
		<function name="completion_list_get" symbol="gda_completion_list_get">
			<return-type type="gchar**"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="sql" type="gchar*"/>
				<parameter name="start" type="gint"/>
				<parameter name="end" type="gint"/>
			</parameters>
		</function>
		<function name="compute_dml_statements" symbol="gda_compute_dml_statements">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="select_stmt" type="GdaStatement*"/>
				<parameter name="require_pk" type="gboolean"/>
				<parameter name="insert_stmt" type="GdaStatement**"/>
				<parameter name="update_stmt" type="GdaStatement**"/>
				<parameter name="delete_stmt" type="GdaStatement**"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="compute_select_statement_from_update" symbol="gda_compute_select_statement_from_update">
			<return-type type="GdaSqlStatement*"/>
			<parameters>
				<parameter name="update_stmt" type="GdaStatement*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="compute_unique_table_row_condition" symbol="gda_compute_unique_table_row_condition">
			<return-type type="GdaSqlExpr*"/>
			<parameters>
				<parameter name="stsel" type="GdaSqlStatementSelect*"/>
				<parameter name="mtable" type="GdaMetaTable*"/>
				<parameter name="require_pk" type="gboolean"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="compute_unique_table_row_condition_with_cnc" symbol="gda_compute_unique_table_row_condition_with_cnc">
			<return-type type="GdaSqlExpr*"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="stsel" type="GdaSqlStatementSelect*"/>
				<parameter name="mtable" type="GdaMetaTable*"/>
				<parameter name="require_pk" type="gboolean"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="default_escape_string" symbol="gda_default_escape_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="default_unescape_string" symbol="gda_default_unescape_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="delete_row_from_table" symbol="gda_delete_row_from_table">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="table" type="gchar*"/>
				<parameter name="condition_column_name" type="gchar*"/>
				<parameter name="condition_value" type="GValue*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="dsn_split" symbol="gda_dsn_split">
			<return-type type="void"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
				<parameter name="out_dsn" type="gchar**"/>
				<parameter name="out_username" type="gchar**"/>
				<parameter name="out_password" type="gchar**"/>
			</parameters>
		</function>
		<function name="easy_error_quark" symbol="gda_easy_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="execute_non_select_command" symbol="gda_execute_non_select_command">
			<return-type type="gint"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="sql" type="gchar*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="execute_select_command" symbol="gda_execute_select_command">
			<return-type type="GdaDataModel*"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="sql" type="gchar*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="g_type_from_string" symbol="gda_g_type_from_string">
			<return-type type="GType"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="g_type_to_string" symbol="gda_g_type_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="type" type="GType"/>
			</parameters>
		</function>
		<function name="gbr_get_file_path" symbol="gda_gbr_get_file_path">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="where" type="GdaPrefixDir"/>
			</parameters>
		</function>
		<function name="gbr_init" symbol="gda_gbr_init">
			<return-type type="void"/>
		</function>
		<function name="get_application_exec_path" symbol="gda_get_application_exec_path">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="app_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="get_default_handler" symbol="gda_get_default_handler">
			<return-type type="GdaDataHandler*"/>
			<parameters>
				<parameter name="for_type" type="GType"/>
			</parameters>
		</function>
		<function name="identifier_equal" symbol="gda_identifier_equal">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="id1" type="gchar*"/>
				<parameter name="id2" type="gchar*"/>
			</parameters>
		</function>
		<function name="identifier_hash" symbol="gda_identifier_hash">
			<return-type type="guint"/>
			<parameters>
				<parameter name="id" type="gchar*"/>
			</parameters>
		</function>
		<function name="init" symbol="gda_init">
			<return-type type="void"/>
		</function>
		<function name="insert_row_into_table" symbol="gda_insert_row_into_table">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="table" type="gchar*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="insert_row_into_table_v" symbol="gda_insert_row_into_table_v">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="table" type="gchar*"/>
				<parameter name="col_names" type="GSList*"/>
				<parameter name="values" type="GSList*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="locale_changed" symbol="gda_locale_changed">
			<return-type type="void"/>
		</function>
		<function name="log_disable" symbol="gda_log_disable">
			<return-type type="void"/>
		</function>
		<function name="log_enable" symbol="gda_log_enable">
			<return-type type="void"/>
		</function>
		<function name="log_error" symbol="gda_log_error">
			<return-type type="void"/>
			<parameters>
				<parameter name="format" type="gchar*"/>
			</parameters>
		</function>
		<function name="log_is_enabled" symbol="gda_log_is_enabled">
			<return-type type="gboolean"/>
		</function>
		<function name="log_message" symbol="gda_log_message">
			<return-type type="void"/>
			<parameters>
				<parameter name="format" type="gchar*"/>
			</parameters>
		</function>
		<function name="parse_iso8601_date" symbol="gda_parse_iso8601_date">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="gdate" type="GDate*"/>
				<parameter name="value" type="gchar*"/>
			</parameters>
		</function>
		<function name="parse_iso8601_time" symbol="gda_parse_iso8601_time">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="timegda" type="GdaTime*"/>
				<parameter name="value" type="gchar*"/>
			</parameters>
		</function>
		<function name="parse_iso8601_timestamp" symbol="gda_parse_iso8601_timestamp">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="timestamp" type="GdaTimestamp*"/>
				<parameter name="value" type="gchar*"/>
			</parameters>
		</function>
		<function name="parse_sql_string" symbol="gda_parse_sql_string">
			<return-type type="GdaStatement*"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="sql" type="gchar*"/>
				<parameter name="params" type="GdaSet**"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="perform_create_database" symbol="gda_perform_create_database">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="provider" type="gchar*"/>
				<parameter name="op" type="GdaServerOperation*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="perform_create_table" symbol="gda_perform_create_table">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="op" type="GdaServerOperation*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="perform_drop_database" symbol="gda_perform_drop_database">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="provider" type="gchar*"/>
				<parameter name="op" type="GdaServerOperation*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="perform_drop_table" symbol="gda_perform_drop_table">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="op" type="GdaServerOperation*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="prepare_create_database" symbol="gda_prepare_create_database">
			<return-type type="GdaServerOperation*"/>
			<parameters>
				<parameter name="provider" type="gchar*"/>
				<parameter name="db_name" type="gchar*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="prepare_create_table" symbol="gda_prepare_create_table">
			<return-type type="GdaServerOperation*"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="table_name" type="gchar*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="prepare_drop_database" symbol="gda_prepare_drop_database">
			<return-type type="GdaServerOperation*"/>
			<parameters>
				<parameter name="provider" type="gchar*"/>
				<parameter name="db_name" type="gchar*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="prepare_drop_table" symbol="gda_prepare_drop_table">
			<return-type type="GdaServerOperation*"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="table_name" type="gchar*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="rfc1738_decode" symbol="gda_rfc1738_decode">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="rfc1738_encode" symbol="gda_rfc1738_encode">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="string" type="gchar*"/>
			</parameters>
		</function>
		<function name="select_alter_select_for_empty" symbol="gda_select_alter_select_for_empty">
			<return-type type="GdaStatement*"/>
			<parameters>
				<parameter name="stmt" type="GdaStatement*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="short_get_type" symbol="gda_short_get_type">
			<return-type type="GType"/>
		</function>
		<function name="sql_error_quark" symbol="gda_sql_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="sql_identifier_add_quotes" symbol="gda_sql_identifier_add_quotes">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="sql_identifier_needs_quotes" symbol="gda_sql_identifier_needs_quotes">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="sql_identifier_quote" symbol="gda_sql_identifier_quote">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="id" type="gchar*"/>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="prov" type="GdaServerProvider*"/>
				<parameter name="meta_store_convention" type="gboolean"/>
				<parameter name="force_quotes" type="gboolean"/>
			</parameters>
		</function>
		<function name="sql_identifier_remove_quotes" symbol="gda_sql_identifier_remove_quotes">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="sql_identifier_split" symbol="gda_sql_identifier_split">
			<return-type type="gchar**"/>
			<parameters>
				<parameter name="id" type="gchar*"/>
			</parameters>
		</function>
		<function name="sql_value_stringify" symbol="gda_sql_value_stringify">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="string_to_binary" symbol="gda_string_to_binary">
			<return-type type="GdaBinary*"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="string_to_blob" symbol="gda_string_to_blob">
			<return-type type="GdaBlob*"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="text_to_alphanum" symbol="gda_text_to_alphanum">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="text" type="gchar*"/>
			</parameters>
		</function>
		<function name="update_row_in_table" symbol="gda_update_row_in_table">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="table" type="gchar*"/>
				<parameter name="condition_column_name" type="gchar*"/>
				<parameter name="condition_value" type="GValue*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="update_row_in_table_v" symbol="gda_update_row_in_table_v">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="table" type="gchar*"/>
				<parameter name="condition_column_name" type="gchar*"/>
				<parameter name="condition_value" type="GValue*"/>
				<parameter name="col_names" type="GSList*"/>
				<parameter name="values" type="GSList*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="ushort_get_type" symbol="gda_ushort_get_type">
			<return-type type="GType"/>
		</function>
		<function name="utility_check_data_model" symbol="gda_utility_check_data_model">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="model" type="GdaDataModel*"/>
				<parameter name="nbcols" type="gint"/>
			</parameters>
		</function>
		<function name="utility_data_model_dump_data_to_xml" symbol="gda_utility_data_model_dump_data_to_xml">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="model" type="GdaDataModel*"/>
				<parameter name="parent" type="xmlNodePtr"/>
				<parameter name="cols" type="gint*"/>
				<parameter name="nb_cols" type="gint"/>
				<parameter name="rows" type="gint*"/>
				<parameter name="nb_rows" type="gint"/>
				<parameter name="use_col_ids" type="gboolean"/>
			</parameters>
		</function>
		<function name="utility_data_model_find_column_description" symbol="gda_utility_data_model_find_column_description">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="model" type="GdaDataSelect*"/>
				<parameter name="field_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="utility_holder_load_attributes" symbol="gda_utility_holder_load_attributes">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="holder" type="GdaHolder*"/>
				<parameter name="node" type="xmlNodePtr"/>
				<parameter name="sources" type="GSList*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="value_compare" symbol="gda_value_compare">
			<return-type type="gint"/>
			<parameters>
				<parameter name="value1" type="GValue*"/>
				<parameter name="value2" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_copy" symbol="gda_value_copy">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_differ" symbol="gda_value_differ">
			<return-type type="gint"/>
			<parameters>
				<parameter name="value1" type="GValue*"/>
				<parameter name="value2" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_free" symbol="gda_value_free">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_binary" symbol="gda_value_get_binary">
			<return-type type="GdaBinary*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_blob" symbol="gda_value_get_blob">
			<return-type type="GdaBlob*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_geometric_point" symbol="gda_value_get_geometric_point">
			<return-type type="GdaGeometricPoint*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_list" symbol="gda_value_get_list">
			<return-type type="GdaValueList*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_numeric" symbol="gda_value_get_numeric">
			<return-type type="GdaNumeric*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_short" symbol="gda_value_get_short">
			<return-type type="gshort"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_time" symbol="gda_value_get_time">
			<return-type type="GdaTime*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_timestamp" symbol="gda_value_get_timestamp">
			<return-type type="GdaTimestamp*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_get_ushort" symbol="gda_value_get_ushort">
			<return-type type="gushort"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_is_null" symbol="gda_value_is_null">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_is_number" symbol="gda_value_is_number">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_new" symbol="gda_value_new">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="type" type="GType"/>
			</parameters>
		</function>
		<function name="value_new_binary" symbol="gda_value_new_binary">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="val" type="guchar*"/>
				<parameter name="size" type="glong"/>
			</parameters>
		</function>
		<function name="value_new_blob" symbol="gda_value_new_blob">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="val" type="guchar*"/>
				<parameter name="size" type="glong"/>
			</parameters>
		</function>
		<function name="value_new_blob_from_file" symbol="gda_value_new_blob_from_file">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="filename" type="gchar*"/>
			</parameters>
		</function>
		<function name="value_new_from_string" symbol="gda_value_new_from_string">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="as_string" type="gchar*"/>
				<parameter name="type" type="GType"/>
			</parameters>
		</function>
		<function name="value_new_from_xml" symbol="gda_value_new_from_xml">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="node" type="xmlNodePtr"/>
			</parameters>
		</function>
		<function name="value_new_timestamp_from_timet" symbol="gda_value_new_timestamp_from_timet">
			<return-type type="GValue*"/>
			<parameters>
				<parameter name="val" type="time_t"/>
			</parameters>
		</function>
		<function name="value_reset_with_type" symbol="gda_value_reset_with_type">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="type" type="GType"/>
			</parameters>
		</function>
		<function name="value_set_binary" symbol="gda_value_set_binary">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="binary" type="GdaBinary*"/>
			</parameters>
		</function>
		<function name="value_set_blob" symbol="gda_value_set_blob">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="blob" type="GdaBlob*"/>
			</parameters>
		</function>
		<function name="value_set_from_string" symbol="gda_value_set_from_string">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="as_string" type="gchar*"/>
				<parameter name="type" type="GType"/>
			</parameters>
		</function>
		<function name="value_set_from_value" symbol="gda_value_set_from_value">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="from" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_set_geometric_point" symbol="gda_value_set_geometric_point">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="val" type="GdaGeometricPoint*"/>
			</parameters>
		</function>
		<function name="value_set_list" symbol="gda_value_set_list">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="val" type="GdaValueList*"/>
			</parameters>
		</function>
		<function name="value_set_null" symbol="gda_value_set_null">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_set_numeric" symbol="gda_value_set_numeric">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="val" type="GdaNumeric*"/>
			</parameters>
		</function>
		<function name="value_set_short" symbol="gda_value_set_short">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="val" type="gshort"/>
			</parameters>
		</function>
		<function name="value_set_time" symbol="gda_value_set_time">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="val" type="GdaTime*"/>
			</parameters>
		</function>
		<function name="value_set_timestamp" symbol="gda_value_set_timestamp">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="val" type="GdaTimestamp*"/>
			</parameters>
		</function>
		<function name="value_set_ushort" symbol="gda_value_set_ushort">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="val" type="gushort"/>
			</parameters>
		</function>
		<function name="value_stringify" symbol="gda_value_stringify">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<function name="value_take_binary" symbol="gda_value_take_binary">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="binary" type="GdaBinary*"/>
			</parameters>
		</function>
		<function name="value_take_blob" symbol="gda_value_take_blob">
			<return-type type="void"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="blob" type="GdaBlob*"/>
			</parameters>
		</function>
		<function name="value_to_xml" symbol="gda_value_to_xml">
			<return-type type="xmlNodePtr"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
			</parameters>
		</function>
		<callback name="GdaAttributesManagerFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="att_name" type="gchar*"/>
				<parameter name="value" type="GValue*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GdaAttributesManagerSignal">
			<return-type type="void"/>
			<parameters>
				<parameter name="obj" type="GObject*"/>
				<parameter name="att_name" type="gchar*"/>
				<parameter name="value" type="GValue*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GdaServerProviderAsyncCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="provider" type="GdaServerProvider*"/>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="task_id" type="guint"/>
				<parameter name="result_status" type="gboolean"/>
				<parameter name="error" type="GError*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GdaServerProviderExecCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="provider" type="GdaServerProvider*"/>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="task_id" type="guint"/>
				<parameter name="result_obj" type="GObject*"/>
				<parameter name="error" type="GError*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GdaSqlForeachFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="p1" type="GdaSqlAnyPart*"/>
				<parameter name="p2" type="gpointer"/>
				<parameter name="p3" type="GError**"/>
			</parameters>
		</callback>
		<callback name="GdaSqlRenderingExpr">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="expr" type="GdaSqlExpr*"/>
				<parameter name="context" type="GdaSqlRenderingContext*"/>
				<parameter name="is_default" type="gboolean*"/>
				<parameter name="is_null" type="gboolean*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</callback>
		<callback name="GdaSqlRenderingFunc">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="node" type="GdaSqlAnyPart*"/>
				<parameter name="context" type="GdaSqlRenderingContext*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</callback>
		<callback name="GdaSqlRenderingPSpecFunc">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="pspec" type="GdaSqlParamSpec*"/>
				<parameter name="expr" type="GdaSqlExpr*"/>
				<parameter name="context" type="GdaSqlRenderingContext*"/>
				<parameter name="is_default" type="gboolean*"/>
				<parameter name="is_null" type="gboolean*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</callback>
		<callback name="GdaSqlRenderingValue">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="value" type="GValue*"/>
				<parameter name="context" type="GdaSqlRenderingContext*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</callback>
		<callback name="GdaSqlReservedKeywordsFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="word" type="gchar*"/>
			</parameters>
		</callback>
		<callback name="GdaThreadWrapperCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="wrapper" type="GdaThreadWrapper*"/>
				<parameter name="instance" type="gpointer"/>
				<parameter name="signame" type="gchar*"/>
				<parameter name="n_param_values" type="gint"/>
				<parameter name="param_values" type="GValue*"/>
				<parameter name="gda_reserved" type="gpointer"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GdaThreadWrapperFunc">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="arg" type="gpointer"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</callback>
		<callback name="GdaThreadWrapperVoidFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="arg" type="gpointer"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</callback>
		<callback name="GdaTreeManagerNodeFunc">
			<return-type type="GdaTreeNode*"/>
			<parameters>
				<parameter name="manager" type="GdaTreeManager*"/>
				<parameter name="parent" type="GdaTreeNode*"/>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</callback>
		<callback name="GdaTreeManagerNodesFunc">
			<return-type type="GSList*"/>
			<parameters>
				<parameter name="manager" type="GdaTreeManager*"/>
				<parameter name="node" type="GdaTreeNode*"/>
				<parameter name="children_nodes" type="GSList*"/>
				<parameter name="out_error" type="gboolean*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</callback>
		<callback name="GdaVConnectionHubFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="cnc" type="GdaConnection*"/>
				<parameter name="ns" type="gchar*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GdaVconnectionDataModelCreateColumnsFunc">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="p1" type="GdaVconnectionDataModelSpec*"/>
				<parameter name="p2" type="GError**"/>
			</parameters>
		</callback>
		<callback name="GdaVconnectionDataModelCreateFModelFunc">
			<return-type type="GdaDataModel*"/>
			<parameters>
				<parameter name="p1" type="GdaVconnectionDataModelSpec*"/>
				<parameter name="p2" type="int"/>
				<parameter name="p3" type="char*"/>
				<parameter name="p4" type="int"/>
				<parameter name="p5" type="GValue**"/>
			</parameters>
		</callback>
		<callback name="GdaVconnectionDataModelCreateModelFunc">
			<return-type type="GdaDataModel*"/>
			<parameters>
				<parameter name="p1" type="GdaVconnectionDataModelSpec*"/>
			</parameters>
		</callback>
		<callback name="GdaVconnectionDataModelFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="GdaDataModel*"/>
				<parameter name="p2" type="gchar*"/>
				<parameter name="p3" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GdaVconnectionDataModelParseFilterFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="p1" type="GdaVconnectionDataModelSpec*"/>
				<parameter name="p2" type="GdaVconnectionDataModelFilter*"/>
			</parameters>
		</callback>
		<struct name="GdaAttributesManager">
			<method name="clear" symbol="gda_attributes_manager_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="mgr" type="GdaAttributesManager*"/>
					<parameter name="ptr" type="gpointer"/>
				</parameters>
			</method>
			<method name="copy" symbol="gda_attributes_manager_copy">
				<return-type type="void"/>
				<parameters>
					<parameter name="from_mgr" type="GdaAttributesManager*"/>
					<parameter name="from" type="gpointer*"/>
					<parameter name="to_mgr" type="GdaAttributesManager*"/>
					<parameter name="to" type="gpointer*"/>
				</parameters>
			</method>
			<method name="foreach" symbol="gda_attributes_manager_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="mgr" type="GdaAttributesManager*"/>
					<parameter name="ptr" type="gpointer"/>
					<parameter name="func" type="GdaAttributesManagerFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_attributes_manager_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="mgr" type="GdaAttributesManager*"/>
				</parameters>
			</method>
			<method name="get" symbol="gda_attributes_manager_get">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="mgr" type="GdaAttributesManager*"/>
					<parameter name="ptr" type="gpointer"/>
					<parameter name="att_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_attributes_manager_new">
				<return-type type="GdaAttributesManager*"/>
				<parameters>
					<parameter name="for_objects" type="gboolean"/>
					<parameter name="signal_func" type="GdaAttributesManagerSignal"/>
					<parameter name="signal_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set" symbol="gda_attributes_manager_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="mgr" type="GdaAttributesManager*"/>
					<parameter name="ptr" type="gpointer"/>
					<parameter name="att_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_full" symbol="gda_attributes_manager_set_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="mgr" type="GdaAttributesManager*"/>
					<parameter name="ptr" type="gpointer"/>
					<parameter name="att_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
		</struct>
		<struct name="GdaDiff">
			<field name="type" type="GdaDiffType"/>
			<field name="old_row" type="gint"/>
			<field name="new_row" type="gint"/>
			<field name="values" type="GHashTable*"/>
		</struct>
		<struct name="GdaDsnInfo">
			<field name="name" type="gchar*"/>
			<field name="provider" type="gchar*"/>
			<field name="description" type="gchar*"/>
			<field name="cnc_string" type="gchar*"/>
			<field name="auth_string" type="gchar*"/>
			<field name="is_system" type="gboolean"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
			<field name="_gda_reserved3" type="gpointer"/>
			<field name="_gda_reserved4" type="gpointer"/>
		</struct>
		<struct name="GdaHandlerBinPriv">
		</struct>
		<struct name="GdaHandlerBooleanPriv">
		</struct>
		<struct name="GdaHandlerNumericalPriv">
		</struct>
		<struct name="GdaHandlerStringPriv">
		</struct>
		<struct name="GdaHandlerTimePriv">
		</struct>
		<struct name="GdaHandlerTypePriv">
		</struct>
		<struct name="GdaMetaContext">
			<field name="table_name" type="gchar*"/>
			<field name="size" type="gint"/>
			<field name="column_names" type="gchar**"/>
			<field name="column_values" type="GValue**"/>
		</struct>
		<struct name="GdaMetaDbObject">
			<field name="extra" type="gpointer"/>
			<field name="obj_type" type="GdaMetaDbObjectType"/>
			<field name="outdated" type="gboolean"/>
			<field name="obj_catalog" type="gchar*"/>
			<field name="obj_schema" type="gchar*"/>
			<field name="obj_name" type="gchar*"/>
			<field name="obj_short_name" type="gchar*"/>
			<field name="obj_full_name" type="gchar*"/>
			<field name="obj_owner" type="gchar*"/>
			<field name="depend_list" type="GSList*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
			<field name="_gda_reserved3" type="gpointer"/>
			<field name="_gda_reserved4" type="gpointer"/>
		</struct>
		<struct name="GdaMetaStoreChange">
			<field name="c_type" type="GdaMetaStoreChangeType"/>
			<field name="table_name" type="gchar*"/>
			<field name="keys" type="GHashTable*"/>
		</struct>
		<struct name="GdaMetaTable">
			<field name="columns" type="GSList*"/>
			<field name="pk_cols_array" type="gint*"/>
			<field name="pk_cols_nb" type="gint"/>
			<field name="reverse_fk_list" type="GSList*"/>
			<field name="fk_list" type="GSList*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
			<field name="_gda_reserved3" type="gpointer"/>
			<field name="_gda_reserved4" type="gpointer"/>
		</struct>
		<struct name="GdaMetaTableColumn">
			<method name="foreach_attribute" symbol="gda_meta_table_column_foreach_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="tcol" type="GdaMetaTableColumn*"/>
					<parameter name="func" type="GdaAttributesManagerFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_attribute" symbol="gda_meta_table_column_get_attribute">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="tcol" type="GdaMetaTableColumn*"/>
					<parameter name="attribute" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_attribute" symbol="gda_meta_table_column_set_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="tcol" type="GdaMetaTableColumn*"/>
					<parameter name="attribute" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<field name="column_name" type="gchar*"/>
			<field name="column_type" type="gchar*"/>
			<field name="gtype" type="GType"/>
			<field name="pkey" type="gboolean"/>
			<field name="nullok" type="gboolean"/>
			<field name="default_value" type="gchar*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
			<field name="_gda_reserved3" type="gpointer"/>
			<field name="_gda_reserved4" type="gpointer"/>
		</struct>
		<struct name="GdaMetaTableForeignKey">
			<field name="meta_table" type="GdaMetaDbObject*"/>
			<field name="depend_on" type="GdaMetaDbObject*"/>
			<field name="cols_nb" type="gint"/>
			<field name="fk_cols_array" type="gint*"/>
			<field name="fk_names_array" type="gchar**"/>
			<field name="ref_pk_cols_array" type="gint*"/>
			<field name="ref_pk_names_array" type="gchar**"/>
			<field name="on_update_policy" type="gpointer"/>
			<field name="on_delete_policy" type="gpointer"/>
			<field name="declared" type="gpointer"/>
			<field name="fk_name" type="gchar*"/>
		</struct>
		<struct name="GdaMetaView">
			<field name="table" type="GdaMetaTable"/>
			<field name="view_def" type="gchar*"/>
			<field name="is_updatable" type="gboolean"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
			<field name="_gda_reserved3" type="gpointer"/>
			<field name="_gda_reserved4" type="gpointer"/>
		</struct>
		<struct name="GdaMutex">
			<method name="free" symbol="gda_mutex_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="mutex" type="GdaMutex*"/>
				</parameters>
			</method>
			<method name="lock" symbol="gda_mutex_lock">
				<return-type type="void"/>
				<parameters>
					<parameter name="mutex" type="GdaMutex*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_mutex_new">
				<return-type type="GdaMutex*"/>
			</method>
			<method name="trylock" symbol="gda_mutex_trylock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mutex" type="GdaMutex*"/>
				</parameters>
			</method>
			<method name="unlock" symbol="gda_mutex_unlock">
				<return-type type="void"/>
				<parameters>
					<parameter name="mutex" type="GdaMutex*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GdaProviderInfo">
			<field name="id" type="gchar*"/>
			<field name="location" type="gchar*"/>
			<field name="description" type="gchar*"/>
			<field name="dsn_params" type="GdaSet*"/>
			<field name="auth_params" type="GdaSet*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
			<field name="_gda_reserved3" type="gpointer"/>
			<field name="_gda_reserved4" type="gpointer"/>
		</struct>
		<struct name="GdaServerOperationNode">
			<field name="type" type="GdaServerOperationNodeType"/>
			<field name="status" type="GdaServerOperationNodeStatus"/>
			<field name="plist" type="GdaSet*"/>
			<field name="model" type="GdaDataModel*"/>
			<field name="column" type="GdaColumn*"/>
			<field name="param" type="GdaHolder*"/>
			<field name="priv" type="gpointer"/>
		</struct>
		<struct name="GdaServerProviderHandlerInfo">
			<field name="cnc" type="GdaConnection*"/>
			<field name="g_type" type="GType"/>
			<field name="dbms_type" type="gchar*"/>
		</struct>
		<struct name="GdaServerProviderInfo">
		</struct>
		<struct name="GdaServerProviderMeta">
			<field name="_info" type="GCallback"/>
			<field name="_btypes" type="GCallback"/>
			<field name="_udt" type="GCallback"/>
			<field name="udt" type="GCallback"/>
			<field name="_udt_cols" type="GCallback"/>
			<field name="udt_cols" type="GCallback"/>
			<field name="_enums" type="GCallback"/>
			<field name="enums" type="GCallback"/>
			<field name="_domains" type="GCallback"/>
			<field name="domains" type="GCallback"/>
			<field name="_constraints_dom" type="GCallback"/>
			<field name="constraints_dom" type="GCallback"/>
			<field name="_el_types" type="GCallback"/>
			<field name="el_types" type="GCallback"/>
			<field name="_collations" type="GCallback"/>
			<field name="collations" type="GCallback"/>
			<field name="_character_sets" type="GCallback"/>
			<field name="character_sets" type="GCallback"/>
			<field name="_schemata" type="GCallback"/>
			<field name="schemata" type="GCallback"/>
			<field name="_tables_views" type="GCallback"/>
			<field name="tables_views" type="GCallback"/>
			<field name="_columns" type="GCallback"/>
			<field name="columns" type="GCallback"/>
			<field name="_view_cols" type="GCallback"/>
			<field name="view_cols" type="GCallback"/>
			<field name="_constraints_tab" type="GCallback"/>
			<field name="constraints_tab" type="GCallback"/>
			<field name="_constraints_ref" type="GCallback"/>
			<field name="constraints_ref" type="GCallback"/>
			<field name="_key_columns" type="GCallback"/>
			<field name="key_columns" type="GCallback"/>
			<field name="_check_columns" type="GCallback"/>
			<field name="check_columns" type="GCallback"/>
			<field name="_triggers" type="GCallback"/>
			<field name="triggers" type="GCallback"/>
			<field name="_routines" type="GCallback"/>
			<field name="routines" type="GCallback"/>
			<field name="_routine_col" type="GCallback"/>
			<field name="routine_col" type="GCallback"/>
			<field name="_routine_par" type="GCallback"/>
			<field name="routine_par" type="GCallback"/>
			<field name="_indexes_tab" type="GCallback"/>
			<field name="indexes_tab" type="GCallback"/>
			<field name="_index_cols" type="GCallback"/>
			<field name="index_cols" type="GCallback"/>
			<field name="_gda_reserved5" type="GCallback"/>
			<field name="_gda_reserved6" type="GCallback"/>
			<field name="_gda_reserved7" type="GCallback"/>
			<field name="_gda_reserved8" type="GCallback"/>
			<field name="_gda_reserved9" type="GCallback"/>
			<field name="_gda_reserved10" type="GCallback"/>
			<field name="_gda_reserved11" type="GCallback"/>
			<field name="_gda_reserved12" type="GCallback"/>
			<field name="_gda_reserved13" type="GCallback"/>
			<field name="_gda_reserved14" type="GCallback"/>
			<field name="_gda_reserved15" type="GCallback"/>
			<field name="_gda_reserved16" type="GCallback"/>
		</struct>
		<struct name="GdaServerProviderXa">
			<field name="xa_start" type="GCallback"/>
			<field name="xa_end" type="GCallback"/>
			<field name="xa_prepare" type="GCallback"/>
			<field name="xa_commit" type="GCallback"/>
			<field name="xa_rollback" type="GCallback"/>
			<field name="xa_recover" type="GCallback"/>
		</struct>
		<struct name="GdaSetGroup">
			<field name="nodes" type="GSList*"/>
			<field name="nodes_source" type="GdaSetSource*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSetNode">
			<field name="holder" type="GdaHolder*"/>
			<field name="source_model" type="GdaDataModel*"/>
			<field name="source_column" type="gint"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSetSource">
			<field name="data_model" type="GdaDataModel*"/>
			<field name="nodes" type="GSList*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
			<field name="_gda_reserved3" type="gpointer"/>
			<field name="_gda_reserved4" type="gpointer"/>
		</struct>
		<struct name="GdaSqlAnyPart">
			<method name="check_structure" symbol="gda_sql_any_part_check_structure">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="node" type="GdaSqlAnyPart*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="foreach" symbol="gda_sql_any_part_foreach">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="node" type="GdaSqlAnyPart*"/>
					<parameter name="func" type="GdaSqlForeachFunc"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<field name="type" type="GdaSqlAnyPartType"/>
			<field name="parent" type="GdaSqlAnyPart*"/>
		</struct>
		<struct name="GdaSqlBuilderId">
		</struct>
		<struct name="GdaSqlCase">
			<method name="copy" symbol="gda_sql_case_copy">
				<return-type type="GdaSqlCase*"/>
				<parameters>
					<parameter name="sc" type="GdaSqlCase*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_case_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="sc" type="GdaSqlCase*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_sql_case_new">
				<return-type type="GdaSqlCase*"/>
				<parameters>
					<parameter name="parent" type="GdaSqlAnyPart*"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_sql_case_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="sc" type="GdaSqlCase*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="base_expr" type="GdaSqlExpr*"/>
			<field name="when_expr_list" type="GSList*"/>
			<field name="then_expr_list" type="GSList*"/>
			<field name="else_expr" type="GdaSqlExpr*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlErrorType">
		</struct>
		<struct name="GdaSqlField">
			<method name="copy" symbol="gda_sql_field_copy">
				<return-type type="GdaSqlField*"/>
				<parameters>
					<parameter name="field" type="GdaSqlField*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_field_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="GdaSqlField*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_sql_field_new">
				<return-type type="GdaSqlField*"/>
				<parameters>
					<parameter name="parent" type="GdaSqlAnyPart*"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_sql_field_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="field" type="GdaSqlField*"/>
				</parameters>
			</method>
			<method name="take_name" symbol="gda_sql_field_take_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="GdaSqlField*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="field_name" type="gchar*"/>
			<field name="validity_meta_table_column" type="GdaMetaTableColumn*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlFunction">
			<method name="check_clean" symbol="gda_sql_function_check_clean">
				<return-type type="void"/>
				<parameters>
					<parameter name="function" type="GdaSqlFunction*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gda_sql_function_copy">
				<return-type type="GdaSqlFunction*"/>
				<parameters>
					<parameter name="function" type="GdaSqlFunction*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_function_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="function" type="GdaSqlFunction*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_sql_function_new">
				<return-type type="GdaSqlFunction*"/>
				<parameters>
					<parameter name="parent" type="GdaSqlAnyPart*"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_sql_function_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="function" type="GdaSqlFunction*"/>
				</parameters>
			</method>
			<method name="take_args_list" symbol="gda_sql_function_take_args_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="function" type="GdaSqlFunction*"/>
					<parameter name="args" type="GSList*"/>
				</parameters>
			</method>
			<method name="take_name" symbol="gda_sql_function_take_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="function" type="GdaSqlFunction*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="function_name" type="gchar*"/>
			<field name="args_list" type="GSList*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlOperation">
			<method name="copy" symbol="gda_sql_operation_copy">
				<return-type type="GdaSqlOperation*"/>
				<parameters>
					<parameter name="operation" type="GdaSqlOperation*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_operation_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="operation" type="GdaSqlOperation*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_sql_operation_new">
				<return-type type="GdaSqlOperation*"/>
				<parameters>
					<parameter name="parent" type="GdaSqlAnyPart*"/>
				</parameters>
			</method>
			<method name="operator_from_string" symbol="gda_sql_operation_operator_from_string">
				<return-type type="GdaSqlOperatorType"/>
				<parameters>
					<parameter name="op" type="gchar*"/>
				</parameters>
			</method>
			<method name="operator_to_string" symbol="gda_sql_operation_operator_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="op" type="GdaSqlOperatorType"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_sql_operation_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="operation" type="GdaSqlOperation*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="operator_type" type="GdaSqlOperatorType"/>
			<field name="operands" type="GSList*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlParamSpec">
			<method name="copy" symbol="gda_sql_param_spec_copy">
				<return-type type="GdaSqlParamSpec*"/>
				<parameters>
					<parameter name="pspec" type="GdaSqlParamSpec*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_param_spec_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="pspec" type="GdaSqlParamSpec*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_sql_param_spec_new">
				<return-type type="GdaSqlParamSpec*"/>
				<parameters>
					<parameter name="simple_spec" type="GValue*"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_sql_param_spec_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="pspec" type="GdaSqlParamSpec*"/>
				</parameters>
			</method>
			<method name="take_descr" symbol="gda_sql_param_spec_take_descr">
				<return-type type="void"/>
				<parameters>
					<parameter name="pspec" type="GdaSqlParamSpec*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="take_name" symbol="gda_sql_param_spec_take_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="pspec" type="GdaSqlParamSpec*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="take_nullok" symbol="gda_sql_param_spec_take_nullok">
				<return-type type="void"/>
				<parameters>
					<parameter name="pspec" type="GdaSqlParamSpec*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="take_type" symbol="gda_sql_param_spec_take_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="pspec" type="GdaSqlParamSpec*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<field name="name" type="gchar*"/>
			<field name="descr" type="gchar*"/>
			<field name="is_param" type="gboolean"/>
			<field name="nullok" type="gboolean"/>
			<field name="g_type" type="GType"/>
			<field name="validity_meta_dict" type="gpointer"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlRenderingContext">
			<field name="flags" type="GdaStatementSqlFlag"/>
			<field name="params" type="GdaSet*"/>
			<field name="params_used" type="GSList*"/>
			<field name="provider" type="GdaServerProvider*"/>
			<field name="cnc" type="GdaConnection*"/>
			<field name="render_value" type="GdaSqlRenderingValue"/>
			<field name="render_param_spec" type="GdaSqlRenderingPSpecFunc"/>
			<field name="render_expr" type="GdaSqlRenderingExpr"/>
			<field name="render_unknown" type="GdaSqlRenderingFunc"/>
			<field name="render_begin" type="GdaSqlRenderingFunc"/>
			<field name="render_rollback" type="GdaSqlRenderingFunc"/>
			<field name="render_commit" type="GdaSqlRenderingFunc"/>
			<field name="render_savepoint" type="GdaSqlRenderingFunc"/>
			<field name="render_rollback_savepoint" type="GdaSqlRenderingFunc"/>
			<field name="render_delete_savepoint" type="GdaSqlRenderingFunc"/>
			<field name="render_select" type="GdaSqlRenderingFunc"/>
			<field name="render_insert" type="GdaSqlRenderingFunc"/>
			<field name="render_delete" type="GdaSqlRenderingFunc"/>
			<field name="render_update" type="GdaSqlRenderingFunc"/>
			<field name="render_compound" type="GdaSqlRenderingFunc"/>
			<field name="render_field" type="GdaSqlRenderingFunc"/>
			<field name="render_table" type="GdaSqlRenderingFunc"/>
			<field name="render_function" type="GdaSqlRenderingFunc"/>
			<field name="render_operation" type="GdaSqlRenderingFunc"/>
			<field name="render_case" type="GdaSqlRenderingFunc"/>
			<field name="render_select_field" type="GdaSqlRenderingFunc"/>
			<field name="render_select_target" type="GdaSqlRenderingFunc"/>
			<field name="render_select_join" type="GdaSqlRenderingFunc"/>
			<field name="render_select_from" type="GdaSqlRenderingFunc"/>
			<field name="render_select_order" type="GdaSqlRenderingFunc"/>
			<field name="_gda_reserved1" type="GCallback"/>
			<field name="_gda_reserved2" type="GCallback"/>
			<field name="_gda_reserved3" type="GCallback"/>
			<field name="_gda_reserved4" type="GCallback"/>
			<field name="_gda_reserved5" type="GCallback"/>
			<field name="_gda_reserved6" type="GCallback"/>
			<field name="_gda_reserved7" type="GCallback"/>
			<field name="_gda_reserved8" type="GCallback"/>
		</struct>
		<struct name="GdaSqlSelectField">
			<method name="copy" symbol="gda_sql_select_field_copy">
				<return-type type="GdaSqlSelectField*"/>
				<parameters>
					<parameter name="field" type="GdaSqlSelectField*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_select_field_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="GdaSqlSelectField*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_sql_select_field_new">
				<return-type type="GdaSqlSelectField*"/>
				<parameters>
					<parameter name="parent" type="GdaSqlAnyPart*"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_sql_select_field_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="field" type="GdaSqlSelectField*"/>
				</parameters>
			</method>
			<method name="take_alias" symbol="gda_sql_select_field_take_alias">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="GdaSqlSelectField*"/>
					<parameter name="alias" type="GValue*"/>
				</parameters>
			</method>
			<method name="take_expr" symbol="gda_sql_select_field_take_expr">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="GdaSqlSelectField*"/>
					<parameter name="expr" type="GdaSqlExpr*"/>
				</parameters>
			</method>
			<method name="take_star_value" symbol="gda_sql_select_field_take_star_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="GdaSqlSelectField*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="expr" type="GdaSqlExpr*"/>
			<field name="field_name" type="gchar*"/>
			<field name="table_name" type="gchar*"/>
			<field name="as" type="gchar*"/>
			<field name="validity_meta_object" type="GdaMetaDbObject*"/>
			<field name="validity_meta_table_column" type="GdaMetaTableColumn*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlSelectFrom">
			<method name="copy" symbol="gda_sql_select_from_copy">
				<return-type type="GdaSqlSelectFrom*"/>
				<parameters>
					<parameter name="from" type="GdaSqlSelectFrom*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_select_from_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="from" type="GdaSqlSelectFrom*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_sql_select_from_new">
				<return-type type="GdaSqlSelectFrom*"/>
				<parameters>
					<parameter name="parent" type="GdaSqlAnyPart*"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_sql_select_from_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="from" type="GdaSqlSelectFrom*"/>
				</parameters>
			</method>
			<method name="take_new_join" symbol="gda_sql_select_from_take_new_join">
				<return-type type="void"/>
				<parameters>
					<parameter name="from" type="GdaSqlSelectFrom*"/>
					<parameter name="join" type="GdaSqlSelectJoin*"/>
				</parameters>
			</method>
			<method name="take_new_target" symbol="gda_sql_select_from_take_new_target">
				<return-type type="void"/>
				<parameters>
					<parameter name="from" type="GdaSqlSelectFrom*"/>
					<parameter name="target" type="GdaSqlSelectTarget*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="targets" type="GSList*"/>
			<field name="joins" type="GSList*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlSelectJoin">
			<method name="copy" symbol="gda_sql_select_join_copy">
				<return-type type="GdaSqlSelectJoin*"/>
				<parameters>
					<parameter name="join" type="GdaSqlSelectJoin*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_select_join_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="join" type="GdaSqlSelectJoin*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_sql_select_join_new">
				<return-type type="GdaSqlSelectJoin*"/>
				<parameters>
					<parameter name="parent" type="GdaSqlAnyPart*"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_sql_select_join_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="join" type="GdaSqlSelectJoin*"/>
				</parameters>
			</method>
			<method name="type_to_string" symbol="gda_sql_select_join_type_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="type" type="GdaSqlSelectJoinType"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="type" type="GdaSqlSelectJoinType"/>
			<field name="position" type="gint"/>
			<field name="expr" type="GdaSqlExpr*"/>
			<field name="use" type="GSList*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlSelectOrder">
			<method name="copy" symbol="gda_sql_select_order_copy">
				<return-type type="GdaSqlSelectOrder*"/>
				<parameters>
					<parameter name="order" type="GdaSqlSelectOrder*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_select_order_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="order" type="GdaSqlSelectOrder*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_sql_select_order_new">
				<return-type type="GdaSqlSelectOrder*"/>
				<parameters>
					<parameter name="parent" type="GdaSqlAnyPart*"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_sql_select_order_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="order" type="GdaSqlSelectOrder*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="expr" type="GdaSqlExpr*"/>
			<field name="asc" type="gboolean"/>
			<field name="collation_name" type="gchar*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlSelectTarget">
			<method name="copy" symbol="gda_sql_select_target_copy">
				<return-type type="GdaSqlSelectTarget*"/>
				<parameters>
					<parameter name="target" type="GdaSqlSelectTarget*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_select_target_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="target" type="GdaSqlSelectTarget*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_sql_select_target_new">
				<return-type type="GdaSqlSelectTarget*"/>
				<parameters>
					<parameter name="parent" type="GdaSqlAnyPart*"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_sql_select_target_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="target" type="GdaSqlSelectTarget*"/>
				</parameters>
			</method>
			<method name="take_alias" symbol="gda_sql_select_target_take_alias">
				<return-type type="void"/>
				<parameters>
					<parameter name="target" type="GdaSqlSelectTarget*"/>
					<parameter name="alias" type="GValue*"/>
				</parameters>
			</method>
			<method name="take_select" symbol="gda_sql_select_target_take_select">
				<return-type type="void"/>
				<parameters>
					<parameter name="target" type="GdaSqlSelectTarget*"/>
					<parameter name="stmt" type="GdaSqlStatement*"/>
				</parameters>
			</method>
			<method name="take_table_name" symbol="gda_sql_select_target_take_table_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="target" type="GdaSqlSelectTarget*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="expr" type="GdaSqlExpr*"/>
			<field name="table_name" type="gchar*"/>
			<field name="as" type="gchar*"/>
			<field name="validity_meta_object" type="GdaMetaDbObject*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlStatementCheckValidityData">
			<field name="cnc" type="GdaConnection*"/>
			<field name="store" type="GdaMetaStore*"/>
			<field name="mstruct" type="GdaMetaStruct*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
			<field name="_gda_reserved3" type="gpointer"/>
			<field name="_gda_reserved4" type="gpointer"/>
		</struct>
		<struct name="GdaSqlStatementCompound">
			<method name="set_type" symbol="gda_sql_statement_compound_set_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="type" type="GdaSqlStatementCompoundType"/>
				</parameters>
			</method>
			<method name="take_stmt" symbol="gda_sql_statement_compound_take_stmt">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="s" type="GdaSqlStatement*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="compound_type" type="GdaSqlStatementCompoundType"/>
			<field name="stmt_list" type="GSList*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlStatementContentsInfo">
			<field name="type" type="GdaSqlStatementType"/>
			<field name="name" type="gchar*"/>
			<field name="construct" type="GCallback"/>
			<field name="free" type="GCallback"/>
			<field name="copy" type="GCallback"/>
			<field name="serialize" type="GCallback"/>
			<field name="check_structure_func" type="GdaSqlForeachFunc"/>
			<field name="check_validity_func" type="GdaSqlForeachFunc"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
			<field name="_gda_reserved3" type="gpointer"/>
			<field name="_gda_reserved4" type="gpointer"/>
		</struct>
		<struct name="GdaSqlStatementDelete">
			<method name="take_condition" symbol="gda_sql_statement_delete_take_condition">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="cond" type="GdaSqlExpr*"/>
				</parameters>
			</method>
			<method name="take_table_name" symbol="gda_sql_statement_delete_take_table_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="table" type="GdaSqlTable*"/>
			<field name="cond" type="GdaSqlExpr*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlStatementInsert">
			<method name="take_1_values_list" symbol="gda_sql_statement_insert_take_1_values_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="list" type="GSList*"/>
				</parameters>
			</method>
			<method name="take_extra_values_list" symbol="gda_sql_statement_insert_take_extra_values_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="list" type="GSList*"/>
				</parameters>
			</method>
			<method name="take_fields_list" symbol="gda_sql_statement_insert_take_fields_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="list" type="GSList*"/>
				</parameters>
			</method>
			<method name="take_on_conflict" symbol="gda_sql_statement_insert_take_on_conflict">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="take_select" symbol="gda_sql_statement_insert_take_select">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="select" type="GdaSqlStatement*"/>
				</parameters>
			</method>
			<method name="take_table_name" symbol="gda_sql_statement_insert_take_table_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="on_conflict" type="gchar*"/>
			<field name="table" type="GdaSqlTable*"/>
			<field name="fields_list" type="GSList*"/>
			<field name="values_list" type="GSList*"/>
			<field name="select" type="GdaSqlAnyPart*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlStatementSelect">
			<method name="take_distinct" symbol="gda_sql_statement_select_take_distinct">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="distinct" type="gboolean"/>
					<parameter name="distinct_expr" type="GdaSqlExpr*"/>
				</parameters>
			</method>
			<method name="take_expr_list" symbol="gda_sql_statement_select_take_expr_list">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="expr_list" type="GSList*"/>
				</parameters>
			</method>
			<method name="take_from" symbol="gda_sql_statement_select_take_from">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="from" type="GdaSqlSelectFrom*"/>
				</parameters>
			</method>
			<method name="take_group_by" symbol="gda_sql_statement_select_take_group_by">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="group_by" type="GSList*"/>
				</parameters>
			</method>
			<method name="take_having_cond" symbol="gda_sql_statement_select_take_having_cond">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="expr" type="GdaSqlExpr*"/>
				</parameters>
			</method>
			<method name="take_limits" symbol="gda_sql_statement_select_take_limits">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="count" type="GdaSqlExpr*"/>
					<parameter name="offset" type="GdaSqlExpr*"/>
				</parameters>
			</method>
			<method name="take_order_by" symbol="gda_sql_statement_select_take_order_by">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="order_by" type="GSList*"/>
				</parameters>
			</method>
			<method name="take_where_cond" symbol="gda_sql_statement_select_take_where_cond">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="expr" type="GdaSqlExpr*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="distinct" type="gboolean"/>
			<field name="distinct_expr" type="GdaSqlExpr*"/>
			<field name="expr_list" type="GSList*"/>
			<field name="from" type="GdaSqlSelectFrom*"/>
			<field name="where_cond" type="GdaSqlExpr*"/>
			<field name="group_by" type="GSList*"/>
			<field name="having_cond" type="GdaSqlExpr*"/>
			<field name="order_by" type="GSList*"/>
			<field name="limit_count" type="GdaSqlExpr*"/>
			<field name="limit_offset" type="GdaSqlExpr*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlStatementTransaction">
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="isolation_level" type="GdaTransactionIsolation"/>
			<field name="trans_mode" type="gchar*"/>
			<field name="trans_name" type="gchar*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlStatementUnknown">
			<method name="take_expressions" symbol="gda_sql_statement_unknown_take_expressions">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="expressions" type="GSList*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="expressions" type="GSList*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlStatementUpdate">
			<method name="take_condition" symbol="gda_sql_statement_update_take_condition">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="cond" type="GdaSqlExpr*"/>
				</parameters>
			</method>
			<method name="take_on_conflict" symbol="gda_sql_statement_update_take_on_conflict">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="take_set_value" symbol="gda_sql_statement_update_take_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="fname" type="GValue*"/>
					<parameter name="expr" type="GdaSqlExpr*"/>
				</parameters>
			</method>
			<method name="take_table_name" symbol="gda_sql_statement_update_take_table_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="on_conflict" type="gchar*"/>
			<field name="table" type="GdaSqlTable*"/>
			<field name="fields_list" type="GSList*"/>
			<field name="expr_list" type="GSList*"/>
			<field name="cond" type="GdaSqlExpr*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaSqlTable">
			<method name="copy" symbol="gda_sql_table_copy">
				<return-type type="GdaSqlTable*"/>
				<parameters>
					<parameter name="table" type="GdaSqlTable*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_table_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="GdaSqlTable*"/>
				</parameters>
			</method>
			<method name="new" symbol="gda_sql_table_new">
				<return-type type="GdaSqlTable*"/>
				<parameters>
					<parameter name="parent" type="GdaSqlAnyPart*"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_sql_table_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="table" type="GdaSqlTable*"/>
				</parameters>
			</method>
			<method name="take_name" symbol="gda_sql_table_take_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="table" type="GdaSqlTable*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="table_name" type="gchar*"/>
			<field name="validity_meta_object" type="GdaMetaDbObject*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaTransactionStatusEvent">
			<field name="trans" type="GdaTransactionStatus*"/>
			<field name="type" type="GdaTransactionStatusEventType"/>
			<field name="pl" type="gpointer"/>
			<field name="conn_event" type="GdaConnectionEvent*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</struct>
		<struct name="GdaTreeMgrColumnsPriv">
		</struct>
		<struct name="GdaTreeMgrLabelPriv">
		</struct>
		<struct name="GdaTreeMgrSchemasPriv">
		</struct>
		<struct name="GdaTreeMgrSelectPriv">
		</struct>
		<struct name="GdaTreeMgrTablesPriv">
		</struct>
		<struct name="GdaValueList">
		</struct>
		<struct name="GdaVconnectionDataModelFilter">
			<field name="nConstraint" type="int"/>
			<field name="aConstraint" type="struct GdaVirtualConstraint*"/>
			<field name="nOrderBy" type="int"/>
			<field name="aOrderBy" type="struct GdaVirtualOrderby*"/>
			<field name="aConstraintUsage" type="struct GdaVirtualConstraintUsage*"/>
			<field name="idxNum" type="int"/>
			<field name="idxPointer" type="gpointer"/>
			<field name="orderByConsumed" type="gboolean"/>
			<field name="estimatedCost" type="double"/>
		</struct>
		<struct name="GdaVconnectionDataModelSpec">
			<field name="data_model" type="GdaDataModel*"/>
			<field name="create_columns_func" type="GdaVconnectionDataModelCreateColumnsFunc"/>
			<field name="create_model_func" type="GdaVconnectionDataModelCreateModelFunc"/>
			<field name="create_filter_func" type="GdaVconnectionDataModelParseFilterFunc"/>
			<field name="create_filtered_model_func" type="GdaVconnectionDataModelCreateFModelFunc"/>
		</struct>
		<struct name="GdaXaTransactionId">
			<method name="to_string" symbol="gda_xa_transaction_id_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="xid" type="GdaXaTransactionId*"/>
				</parameters>
			</method>
			<field name="format" type="guint32"/>
			<field name="gtrid_length" type="gushort"/>
			<field name="bqual_length" type="gushort"/>
			<field name="data" type="char[]"/>
		</struct>
		<boxed name="GdaBinary" type-name="GdaBinary" get-type="gda_binary_get_type">
			<method name="copy" symbol="gda_binary_copy">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="boxed" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_binary_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="boxed" type="gpointer"/>
				</parameters>
			</method>
			<method name="to_string" symbol="gda_binary_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="bin" type="GdaBinary*"/>
					<parameter name="maxlen" type="guint"/>
				</parameters>
			</method>
			<field name="data" type="guchar*"/>
			<field name="binary_length" type="glong"/>
		</boxed>
		<boxed name="GdaBlob" type-name="GdaBlob" get-type="gda_blob_get_type">
			<method name="copy" symbol="gda_blob_copy">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="boxed" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_blob_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="boxed" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_op" symbol="gda_blob_set_op">
				<return-type type="void"/>
				<parameters>
					<parameter name="blob" type="GdaBlob*"/>
					<parameter name="op" type="GdaBlobOp*"/>
				</parameters>
			</method>
			<method name="to_string" symbol="gda_blob_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="blob" type="GdaBlob*"/>
					<parameter name="maxlen" type="guint"/>
				</parameters>
			</method>
			<field name="data" type="GdaBinary"/>
			<field name="op" type="GdaBlobOp*"/>
		</boxed>
		<boxed name="GdaGeometricPoint" type-name="GdaGeometricPoint" get-type="gda_geometricpoint_get_type">
			<method name="copy" symbol="gda_geometricpoint_copy">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="boxed" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_geometricpoint_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="boxed" type="gpointer"/>
				</parameters>
			</method>
			<field name="x" type="gdouble"/>
			<field name="y" type="gdouble"/>
		</boxed>
		<boxed name="GdaNumeric" type-name="GdaNumeric" get-type="gda_numeric_get_type">
			<method name="copy" symbol="gda_numeric_copy">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="boxed" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_numeric_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="boxed" type="gpointer"/>
				</parameters>
			</method>
			<field name="number" type="gchar*"/>
			<field name="precision" type="glong"/>
			<field name="width" type="glong"/>
			<field name="reserved" type="gpointer"/>
		</boxed>
		<boxed name="GdaQuarkList" type-name="GdaQuarkList" get-type="gda_quark_list_get_type">
			<method name="add_from_string" symbol="gda_quark_list_add_from_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="qlist" type="GdaQuarkList*"/>
					<parameter name="string" type="gchar*"/>
					<parameter name="cleanup" type="gboolean"/>
				</parameters>
			</method>
			<method name="clear" symbol="gda_quark_list_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="qlist" type="GdaQuarkList*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gda_quark_list_copy">
				<return-type type="GdaQuarkList*"/>
				<parameters>
					<parameter name="qlist" type="GdaQuarkList*"/>
				</parameters>
			</method>
			<method name="find" symbol="gda_quark_list_find">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="qlist" type="GdaQuarkList*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="foreach" symbol="gda_quark_list_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="qlist" type="GdaQuarkList*"/>
					<parameter name="func" type="GHFunc"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_quark_list_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="qlist" type="GdaQuarkList*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_quark_list_new">
				<return-type type="GdaQuarkList*"/>
			</constructor>
			<constructor name="new_from_string" symbol="gda_quark_list_new_from_string">
				<return-type type="GdaQuarkList*"/>
				<parameters>
					<parameter name="string" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="remove" symbol="gda_quark_list_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="qlist" type="GdaQuarkList*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="GdaSqlExpr" type-name="GdaSqlExpr" get-type="gda_sql_expr_get_type">
			<method name="copy" symbol="gda_sql_expr_copy">
				<return-type type="GdaSqlExpr*"/>
				<parameters>
					<parameter name="expr" type="GdaSqlExpr*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_expr_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="expr" type="GdaSqlExpr*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_sql_expr_new">
				<return-type type="GdaSqlExpr*"/>
				<parameters>
					<parameter name="parent" type="GdaSqlAnyPart*"/>
				</parameters>
			</constructor>
			<method name="serialize" symbol="gda_sql_expr_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="expr" type="GdaSqlExpr*"/>
				</parameters>
			</method>
			<method name="take_select" symbol="gda_sql_expr_take_select">
				<return-type type="void"/>
				<parameters>
					<parameter name="expr" type="GdaSqlExpr*"/>
					<parameter name="stmt" type="GdaSqlStatement*"/>
				</parameters>
			</method>
			<field name="any" type="GdaSqlAnyPart"/>
			<field name="value" type="GValue*"/>
			<field name="param_spec" type="GdaSqlParamSpec*"/>
			<field name="func" type="GdaSqlFunction*"/>
			<field name="cond" type="GdaSqlOperation*"/>
			<field name="select" type="GdaSqlAnyPart*"/>
			<field name="case_s" type="GdaSqlCase*"/>
			<field name="cast_as" type="gchar*"/>
			<field name="value_is_ident" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</boxed>
		<boxed name="GdaSqlStatement" type-name="GdaSqlStatement" get-type="gda_sql_statement_get_type">
			<method name="check_clean" symbol="gda_sql_statement_check_clean">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
				</parameters>
			</method>
			<method name="check_structure" symbol="gda_sql_statement_check_structure">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="check_validity" symbol="gda_sql_statement_check_validity">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="check_validity_m" symbol="gda_sql_statement_check_validity_m">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="copy" symbol="gda_sql_statement_copy">
				<return-type type="GdaSqlStatement*"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_sql_statement_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
				</parameters>
			</method>
			<method name="get_contents_infos" symbol="gda_sql_statement_get_contents_infos">
				<return-type type="GdaSqlStatementContentsInfo*"/>
				<parameters>
					<parameter name="type" type="GdaSqlStatementType"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_sql_statement_new">
				<return-type type="GdaSqlStatement*"/>
				<parameters>
					<parameter name="type" type="GdaSqlStatementType"/>
				</parameters>
			</constructor>
			<method name="normalize" symbol="gda_sql_statement_normalize">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_sql_statement_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
				</parameters>
			</method>
			<method name="string_to_type" symbol="gda_sql_statement_string_to_type">
				<return-type type="GdaSqlStatementType"/>
				<parameters>
					<parameter name="type" type="gchar*"/>
				</parameters>
			</method>
			<method name="trans_set_isol_level" symbol="gda_sql_statement_trans_set_isol_level">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="level" type="GdaTransactionIsolation"/>
				</parameters>
			</method>
			<method name="trans_take_mode" symbol="gda_sql_statement_trans_take_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="trans_take_name" symbol="gda_sql_statement_trans_take_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaSqlStatement*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="type_to_string" symbol="gda_sql_statement_type_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="type" type="GdaSqlStatementType"/>
				</parameters>
			</method>
			<field name="sql" type="gchar*"/>
			<field name="stmt_type" type="GdaSqlStatementType"/>
			<field name="contents" type="gpointer"/>
			<field name="validity_meta_struct" type="GdaMetaStruct*"/>
			<field name="_gda_reserved1" type="gpointer"/>
			<field name="_gda_reserved2" type="gpointer"/>
		</boxed>
		<boxed name="GdaTime" type-name="GdaTime" get-type="gda_time_get_type">
			<method name="copy" symbol="gda_time_copy">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="boxed" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_time_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="boxed" type="gpointer"/>
				</parameters>
			</method>
			<method name="valid" symbol="gda_time_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="time" type="GdaTime*"/>
				</parameters>
			</method>
			<field name="hour" type="gushort"/>
			<field name="minute" type="gushort"/>
			<field name="second" type="gushort"/>
			<field name="fraction" type="gulong"/>
			<field name="timezone" type="glong"/>
		</boxed>
		<boxed name="GdaTimestamp" type-name="GdaTimestamp" get-type="gda_timestamp_get_type">
			<method name="copy" symbol="gda_timestamp_copy">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="boxed" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="gda_timestamp_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="boxed" type="gpointer"/>
				</parameters>
			</method>
			<method name="valid" symbol="gda_timestamp_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="timestamp" type="GdaTimestamp*"/>
				</parameters>
			</method>
			<field name="year" type="gshort"/>
			<field name="month" type="gushort"/>
			<field name="day" type="gushort"/>
			<field name="hour" type="gushort"/>
			<field name="minute" type="gushort"/>
			<field name="second" type="gushort"/>
			<field name="fraction" type="gulong"/>
			<field name="timezone" type="glong"/>
		</boxed>
		<boxed name="GdaValueList" type-name="GdaValueList" get-type="gda_value_list_get_type">
		</boxed>
		<enum name="GdaBatchError" type-name="GdaBatchError" get-type="gda_batch_error_get_type">
			<member name="GDA_BATCH_CONFLICTING_PARAMETER_ERROR" value="0"/>
		</enum>
		<enum name="GdaConfigError" type-name="GdaConfigError" get-type="gda_config_error_get_type">
			<member name="GDA_CONFIG_DSN_NOT_FOUND_ERROR" value="0"/>
			<member name="GDA_CONFIG_PERMISSION_ERROR" value="1"/>
			<member name="GDA_CONFIG_PROVIDER_NOT_FOUND_ERROR" value="2"/>
			<member name="GDA_CONFIG_PROVIDER_CREATION_ERROR" value="3"/>
		</enum>
		<enum name="GdaConnectionError" type-name="GdaConnectionError" get-type="gda_connection_error_get_type">
			<member name="GDA_CONNECTION_DSN_NOT_FOUND_ERROR" value="0"/>
			<member name="GDA_CONNECTION_PROVIDER_NOT_FOUND_ERROR" value="1"/>
			<member name="GDA_CONNECTION_PROVIDER_ERROR" value="2"/>
			<member name="GDA_CONNECTION_NO_CNC_SPEC_ERROR" value="3"/>
			<member name="GDA_CONNECTION_NO_PROVIDER_SPEC_ERROR" value="4"/>
			<member name="GDA_CONNECTION_OPEN_ERROR" value="5"/>
			<member name="GDA_CONNECTION_STATEMENT_TYPE_ERROR" value="6"/>
			<member name="GDA_CONNECTION_CANT_LOCK_ERROR" value="7"/>
			<member name="GDA_CONNECTION_TASK_NOT_FOUND_ERROR" value="8"/>
			<member name="GDA_CONNECTION_UNSUPPORTED_THREADS_ERROR" value="9"/>
			<member name="GDA_CONNECTION_CLOSED_ERROR" value="10"/>
		</enum>
		<enum name="GdaConnectionEventCode" type-name="GdaConnectionEventCode" get-type="gda_connection_event_code_get_type">
			<member name="GDA_CONNECTION_EVENT_CODE_CONSTRAINT_VIOLATION" value="0"/>
			<member name="GDA_CONNECTION_EVENT_CODE_RESTRICT_VIOLATION" value="1"/>
			<member name="GDA_CONNECTION_EVENT_CODE_NOT_NULL_VIOLATION" value="2"/>
			<member name="GDA_CONNECTION_EVENT_CODE_FOREIGN_KEY_VIOLATION" value="3"/>
			<member name="GDA_CONNECTION_EVENT_CODE_UNIQUE_VIOLATION" value="4"/>
			<member name="GDA_CONNECTION_EVENT_CODE_CHECK_VIOLATION" value="5"/>
			<member name="GDA_CONNECTION_EVENT_CODE_INSUFFICIENT_PRIVILEGES" value="6"/>
			<member name="GDA_CONNECTION_EVENT_CODE_UNDEFINED_COLUMN" value="7"/>
			<member name="GDA_CONNECTION_EVENT_CODE_UNDEFINED_FUNCTION" value="8"/>
			<member name="GDA_CONNECTION_EVENT_CODE_UNDEFINED_TABLE" value="9"/>
			<member name="GDA_CONNECTION_EVENT_CODE_DUPLICATE_COLUMN" value="10"/>
			<member name="GDA_CONNECTION_EVENT_CODE_DUPLICATE_DATABASE" value="11"/>
			<member name="GDA_CONNECTION_EVENT_CODE_DUPLICATE_FUNCTION" value="12"/>
			<member name="GDA_CONNECTION_EVENT_CODE_DUPLICATE_SCHEMA" value="13"/>
			<member name="GDA_CONNECTION_EVENT_CODE_DUPLICATE_TABLE" value="14"/>
			<member name="GDA_CONNECTION_EVENT_CODE_DUPLICATE_ALIAS" value="15"/>
			<member name="GDA_CONNECTION_EVENT_CODE_DUPLICATE_OBJECT" value="16"/>
			<member name="GDA_CONNECTION_EVENT_CODE_SYNTAX_ERROR" value="17"/>
			<member name="GDA_CONNECTION_EVENT_CODE_UNKNOWN" value="18"/>
		</enum>
		<enum name="GdaConnectionEventType" type-name="GdaConnectionEventType" get-type="gda_connection_event_type_get_type">
			<member name="GDA_CONNECTION_EVENT_NOTICE" value="0"/>
			<member name="GDA_CONNECTION_EVENT_WARNING" value="1"/>
			<member name="GDA_CONNECTION_EVENT_ERROR" value="2"/>
			<member name="GDA_CONNECTION_EVENT_COMMAND" value="3"/>
		</enum>
		<enum name="GdaConnectionFeature" type-name="GdaConnectionFeature" get-type="gda_connection_feature_get_type">
			<member name="GDA_CONNECTION_FEATURE_AGGREGATES" value="0"/>
			<member name="GDA_CONNECTION_FEATURE_BLOBS" value="1"/>
			<member name="GDA_CONNECTION_FEATURE_INDEXES" value="2"/>
			<member name="GDA_CONNECTION_FEATURE_INHERITANCE" value="3"/>
			<member name="GDA_CONNECTION_FEATURE_NAMESPACES" value="4"/>
			<member name="GDA_CONNECTION_FEATURE_PROCEDURES" value="5"/>
			<member name="GDA_CONNECTION_FEATURE_SEQUENCES" value="6"/>
			<member name="GDA_CONNECTION_FEATURE_SQL" value="7"/>
			<member name="GDA_CONNECTION_FEATURE_TRANSACTIONS" value="8"/>
			<member name="GDA_CONNECTION_FEATURE_SAVEPOINTS" value="9"/>
			<member name="GDA_CONNECTION_FEATURE_SAVEPOINTS_REMOVE" value="10"/>
			<member name="GDA_CONNECTION_FEATURE_TRIGGERS" value="11"/>
			<member name="GDA_CONNECTION_FEATURE_UPDATABLE_CURSOR" value="12"/>
			<member name="GDA_CONNECTION_FEATURE_USERS" value="13"/>
			<member name="GDA_CONNECTION_FEATURE_VIEWS" value="14"/>
			<member name="GDA_CONNECTION_FEATURE_XA_TRANSACTIONS" value="15"/>
			<member name="GDA_CONNECTION_FEATURE_MULTI_THREADING" value="16"/>
			<member name="GDA_CONNECTION_FEATURE_LAST" value="17"/>
		</enum>
		<enum name="GdaConnectionMetaType" type-name="GdaConnectionMetaType" get-type="gda_connection_meta_type_get_type">
			<member name="GDA_CONNECTION_META_NAMESPACES" value="0"/>
			<member name="GDA_CONNECTION_META_TYPES" value="1"/>
			<member name="GDA_CONNECTION_META_TABLES" value="2"/>
			<member name="GDA_CONNECTION_META_VIEWS" value="3"/>
			<member name="GDA_CONNECTION_META_FIELDS" value="4"/>
			<member name="GDA_CONNECTION_META_INDEXES" value="5"/>
		</enum>
		<enum name="GdaConnectionSchema" type-name="GdaConnectionSchema" get-type="gda_connection_schema_get_type">
			<member name="GDA_CONNECTION_SCHEMA_AGGREGATES" value="0"/>
			<member name="GDA_CONNECTION_SCHEMA_DATABASES" value="1"/>
			<member name="GDA_CONNECTION_SCHEMA_FIELDS" value="2"/>
			<member name="GDA_CONNECTION_SCHEMA_INDEXES" value="3"/>
			<member name="GDA_CONNECTION_SCHEMA_LANGUAGES" value="4"/>
			<member name="GDA_CONNECTION_SCHEMA_NAMESPACES" value="5"/>
			<member name="GDA_CONNECTION_SCHEMA_PARENT_TABLES" value="6"/>
			<member name="GDA_CONNECTION_SCHEMA_PROCEDURES" value="7"/>
			<member name="GDA_CONNECTION_SCHEMA_SEQUENCES" value="8"/>
			<member name="GDA_CONNECTION_SCHEMA_TABLES" value="9"/>
			<member name="GDA_CONNECTION_SCHEMA_TRIGGERS" value="10"/>
			<member name="GDA_CONNECTION_SCHEMA_TYPES" value="11"/>
			<member name="GDA_CONNECTION_SCHEMA_USERS" value="12"/>
			<member name="GDA_CONNECTION_SCHEMA_VIEWS" value="13"/>
			<member name="GDA_CONNECTION_SCHEMA_CONSTRAINTS" value="14"/>
			<member name="GDA_CONNECTION_SCHEMA_TABLE_CONTENTS" value="15"/>
		</enum>
		<enum name="GdaDataComparatorError" type-name="GdaDataComparatorError" get-type="gda_data_comparator_error_get_type">
			<member name="GDA_DATA_COMPARATOR_MISSING_DATA_MODEL_ERROR" value="0"/>
			<member name="GDA_DATA_COMPARATOR_COLUMN_TYPES_MISMATCH_ERROR" value="1"/>
			<member name="GDA_DATA_COMPARATOR_MODEL_ACCESS_ERROR" value="2"/>
			<member name="GDA_DATA_COMPARATOR_USER_CANCELLED_ERROR" value="3"/>
		</enum>
		<enum name="GdaDataModelError" type-name="GdaDataModelError" get-type="gda_data_model_error_get_type">
			<member name="GDA_DATA_MODEL_ROW_OUT_OF_RANGE_ERROR" value="0"/>
			<member name="GDA_DATA_MODEL_COLUMN_OUT_OF_RANGE_ERROR" value="1"/>
			<member name="GDA_DATA_MODEL_VALUES_LIST_ERROR" value="2"/>
			<member name="GDA_DATA_MODEL_VALUE_TYPE_ERROR" value="3"/>
			<member name="GDA_DATA_MODEL_ROW_NOT_FOUND_ERROR" value="4"/>
			<member name="GDA_DATA_MODEL_ACCESS_ERROR" value="5"/>
			<member name="GDA_DATA_MODEL_FEATURE_NON_SUPPORTED_ERROR" value="6"/>
			<member name="GDA_DATA_MODEL_FILE_EXIST_ERROR" value="7"/>
			<member name="GDA_DATA_MODEL_XML_FORMAT_ERROR" value="8"/>
		</enum>
		<enum name="GdaDataModelHint" type-name="GdaDataModelHint" get-type="gda_data_model_hint_get_type">
			<member name="GDA_DATA_MODEL_HINT_START_BATCH_UPDATE" value="0"/>
			<member name="GDA_DATA_MODEL_HINT_END_BATCH_UPDATE" value="1"/>
			<member name="GDA_DATA_MODEL_HINT_REFRESH" value="2"/>
		</enum>
		<enum name="GdaDataModelIOFormat" type-name="GdaDataModelIOFormat" get-type="gda_data_model_io_format_get_type">
			<member name="GDA_DATA_MODEL_IO_DATA_ARRAY_XML" value="0"/>
			<member name="GDA_DATA_MODEL_IO_TEXT_SEPARATED" value="1"/>
		</enum>
		<enum name="GdaDataModelIterError" type-name="GdaDataModelIterError" get-type="gda_data_model_iter_error_get_type">
			<member name="GDA_DATA_MODEL_ITER_COLUMN_OUT_OF_RANGE_ERROR" value="0"/>
		</enum>
		<enum name="GdaDataProxyError" type-name="GdaDataProxyError" get-type="gda_data_proxy_error_get_type">
			<member name="GDA_DATA_PROXY_COMMIT_ERROR" value="0"/>
			<member name="GDA_DATA_PROXY_COMMIT_CANCELLED" value="1"/>
			<member name="GDA_DATA_PROXY_READ_ONLY_VALUE" value="2"/>
			<member name="GDA_DATA_PROXY_READ_ONLY_ROW" value="3"/>
			<member name="GDA_DATA_PROXY_FILTER_ERROR" value="4"/>
		</enum>
		<enum name="GdaDataSelectError" type-name="GdaDataSelectError" get-type="gda_data_select_error_get_type">
			<member name="GDA_DATA_SELECT_MODIFICATION_STATEMENT_ERROR" value="0"/>
			<member name="GDA_DATA_SELECT_MISSING_MODIFICATION_STATEMENT_ERROR" value="1"/>
			<member name="GDA_DATA_SELECT_CONNECTION_ERROR" value="2"/>
			<member name="GDA_DATA_SELECT_ACCESS_ERROR" value="3"/>
			<member name="GDA_DATA_SELECT_SQL_ERROR" value="4"/>
			<member name="GDA_DATA_SELECT_SAFETY_LOCKED_ERROR" value="5"/>
		</enum>
		<enum name="GdaDiffType" type-name="GdaDiffType" get-type="gda_diff_type_get_type">
			<member name="GDA_DIFF_ADD_ROW" value="0"/>
			<member name="GDA_DIFF_REMOVE_ROW" value="1"/>
			<member name="GDA_DIFF_MODIFY_ROW" value="2"/>
		</enum>
		<enum name="GdaEasyCreateTableFlag" type-name="GdaEasyCreateTableFlag" get-type="gda_easy_create_table_flag_get_type">
			<member name="GDA_EASY_CREATE_TABLE_NOTHING_FLAG" value="1"/>
			<member name="GDA_EASY_CREATE_TABLE_PKEY_FLAG" value="2"/>
			<member name="GDA_EASY_CREATE_TABLE_NOT_NULL_FLAG" value="4"/>
			<member name="GDA_EASY_CREATE_TABLE_UNIQUE_FLAG" value="8"/>
			<member name="GDA_EASY_CREATE_TABLE_AUTOINC_FLAG" value="16"/>
			<member name="GDA_EASY_CREATE_TABLE_FKEY_FLAG" value="32"/>
			<member name="GDA_EASY_CREATE_TABLE_PKEY_AUTOINC_FLAG" value="18"/>
		</enum>
		<enum name="GdaEasyError" type-name="GdaEasyError" get-type="gda_easy_error_get_type">
			<member name="GDA_EASY_OBJECT_NAME_ERROR" value="0"/>
			<member name="GDA_EASY_INCORRECT_VALUE_ERROR" value="1"/>
			<member name="GDA_EASY_OPERATION_ERROR" value="2"/>
		</enum>
		<enum name="GdaHolderError" type-name="GdaHolderError" get-type="gda_holder_error_get_type">
			<member name="GDA_HOLDER_STRING_CONVERSION_ERROR" value="0"/>
			<member name="GDA_HOLDER_VALUE_TYPE_ERROR" value="1"/>
			<member name="GDA_HOLDER_VALUE_NULL_ERROR" value="2"/>
		</enum>
		<enum name="GdaMetaDbObjectType" type-name="GdaMetaDbObjectType" get-type="gda_meta_db_object_type_get_type">
			<member name="GDA_META_DB_UNKNOWN" value="0"/>
			<member name="GDA_META_DB_TABLE" value="1"/>
			<member name="GDA_META_DB_VIEW" value="2"/>
		</enum>
		<enum name="GdaMetaForeignKeyPolicy" type-name="GdaMetaForeignKeyPolicy" get-type="gda_meta_foreign_key_policy_get_type">
			<member name="GDA_META_FOREIGN_KEY_UNKNOWN" value="0"/>
			<member name="GDA_META_FOREIGN_KEY_NONE" value="1"/>
			<member name="GDA_META_FOREIGN_KEY_NO_ACTION" value="2"/>
			<member name="GDA_META_FOREIGN_KEY_RESTRICT" value="3"/>
			<member name="GDA_META_FOREIGN_KEY_CASCADE" value="4"/>
			<member name="GDA_META_FOREIGN_KEY_SET_NULL" value="5"/>
			<member name="GDA_META_FOREIGN_KEY_SET_DEFAULT" value="6"/>
		</enum>
		<enum name="GdaMetaSortType" type-name="GdaMetaSortType" get-type="gda_meta_sort_type_get_type">
			<member name="GDA_META_SORT_ALHAPETICAL" value="0"/>
			<member name="GDA_META_SORT_DEPENDENCIES" value="1"/>
		</enum>
		<enum name="GdaMetaStoreChangeType" type-name="GdaMetaStoreChangeType" get-type="gda_meta_store_change_type_get_type">
			<member name="GDA_META_STORE_ADD" value="0"/>
			<member name="GDA_META_STORE_REMOVE" value="1"/>
			<member name="GDA_META_STORE_MODIFY" value="2"/>
		</enum>
		<enum name="GdaMetaStoreError" type-name="GdaMetaStoreError" get-type="gda_meta_store_error_get_type">
			<member name="GDA_META_STORE_INCORRECT_SCHEMA_ERROR" value="0"/>
			<member name="GDA_META_STORE_UNSUPPORTED_PROVIDER_ERROR" value="1"/>
			<member name="GDA_META_STORE_INTERNAL_ERROR" value="2"/>
			<member name="GDA_META_STORE_META_CONTEXT_ERROR" value="3"/>
			<member name="GDA_META_STORE_MODIFY_CONTENTS_ERROR" value="4"/>
			<member name="GDA_META_STORE_EXTRACT_SQL_ERROR" value="5"/>
			<member name="GDA_META_STORE_ATTRIBUTE_NOT_FOUND_ERROR" value="6"/>
			<member name="GDA_META_STORE_ATTRIBUTE_ERROR" value="7"/>
			<member name="GDA_META_STORE_SCHEMA_OBJECT_NOT_FOUND_ERROR" value="8"/>
			<member name="GDA_META_STORE_SCHEMA_OBJECT_CONFLICT_ERROR" value="9"/>
			<member name="GDA_META_STORE_SCHEMA_OBJECT_DESCR_ERROR" value="10"/>
			<member name="GDA_META_STORE_TRANSACTION_ALREADY_STARTED_ERROR" value="11"/>
		</enum>
		<enum name="GdaMetaStructError" type-name="GdaMetaStructError" get-type="gda_meta_struct_error_get_type">
			<member name="GDA_META_STRUCT_UNKNOWN_OBJECT_ERROR" value="0"/>
			<member name="GDA_META_STRUCT_DUPLICATE_OBJECT_ERROR" value="1"/>
			<member name="GDA_META_STRUCT_INCOHERENCE_ERROR" value="2"/>
		</enum>
		<enum name="GdaPrefixDir">
			<member name="GDA_NO_DIR" value="0"/>
			<member name="GDA_BIN_DIR" value="1"/>
			<member name="GDA_SBIN_DIR" value="2"/>
			<member name="GDA_DATA_DIR" value="3"/>
			<member name="GDA_LOCALE_DIR" value="4"/>
			<member name="GDA_LIB_DIR" value="5"/>
			<member name="GDA_LIBEXEC_DIR" value="6"/>
			<member name="GDA_ETC_DIR" value="7"/>
		</enum>
		<enum name="GdaServerOperationError" type-name="GdaServerOperationError" get-type="gda_server_operation_error_get_type">
			<member name="GDA_SERVER_OPERATION_OBJECT_NAME_ERROR" value="0"/>
			<member name="GDA_SERVER_OPERATION_INCORRECT_VALUE_ERROR" value="1"/>
		</enum>
		<enum name="GdaServerOperationNodeStatus" type-name="GdaServerOperationNodeStatus" get-type="gda_server_operation_node_status_get_type">
			<member name="GDA_SERVER_OPERATION_STATUS_OPTIONAL" value="0"/>
			<member name="GDA_SERVER_OPERATION_STATUS_REQUIRED" value="1"/>
			<member name="GDA_SERVER_OPERATION_STATUS_UNKNOWN" value="2"/>
		</enum>
		<enum name="GdaServerOperationNodeType" type-name="GdaServerOperationNodeType" get-type="gda_server_operation_node_type_get_type">
			<member name="GDA_SERVER_OPERATION_NODE_PARAMLIST" value="0"/>
			<member name="GDA_SERVER_OPERATION_NODE_DATA_MODEL" value="1"/>
			<member name="GDA_SERVER_OPERATION_NODE_PARAM" value="2"/>
			<member name="GDA_SERVER_OPERATION_NODE_SEQUENCE" value="3"/>
			<member name="GDA_SERVER_OPERATION_NODE_SEQUENCE_ITEM" value="4"/>
			<member name="GDA_SERVER_OPERATION_NODE_DATA_MODEL_COLUMN" value="5"/>
			<member name="GDA_SERVER_OPERATION_NODE_UNKNOWN" value="6"/>
		</enum>
		<enum name="GdaServerOperationType" type-name="GdaServerOperationType" get-type="gda_server_operation_type_get_type">
			<member name="GDA_SERVER_OPERATION_CREATE_DB" value="0"/>
			<member name="GDA_SERVER_OPERATION_DROP_DB" value="1"/>
			<member name="GDA_SERVER_OPERATION_CREATE_TABLE" value="2"/>
			<member name="GDA_SERVER_OPERATION_DROP_TABLE" value="3"/>
			<member name="GDA_SERVER_OPERATION_RENAME_TABLE" value="4"/>
			<member name="GDA_SERVER_OPERATION_ADD_COLUMN" value="5"/>
			<member name="GDA_SERVER_OPERATION_DROP_COLUMN" value="6"/>
			<member name="GDA_SERVER_OPERATION_CREATE_INDEX" value="7"/>
			<member name="GDA_SERVER_OPERATION_DROP_INDEX" value="8"/>
			<member name="GDA_SERVER_OPERATION_CREATE_VIEW" value="9"/>
			<member name="GDA_SERVER_OPERATION_DROP_VIEW" value="10"/>
			<member name="GDA_SERVER_OPERATION_COMMENT_TABLE" value="11"/>
			<member name="GDA_SERVER_OPERATION_COMMENT_COLUMN" value="12"/>
			<member name="GDA_SERVER_OPERATION_CREATE_USER" value="13"/>
			<member name="GDA_SERVER_OPERATION_ALTER_USER" value="14"/>
			<member name="GDA_SERVER_OPERATION_DROP_USER" value="15"/>
			<member name="GDA_SERVER_OPERATION_LAST" value="16"/>
		</enum>
		<enum name="GdaServerProviderError" type-name="GdaServerProviderError" get-type="gda_server_provider_error_get_type">
			<member name="GDA_SERVER_PROVIDER_METHOD_NON_IMPLEMENTED_ERROR" value="0"/>
			<member name="GDA_SERVER_PROVIDER_PREPARE_STMT_ERROR" value="1"/>
			<member name="GDA_SERVER_PROVIDER_EMPTY_STMT_ERROR" value="2"/>
			<member name="GDA_SERVER_PROVIDER_MISSING_PARAM_ERROR" value="3"/>
			<member name="GDA_SERVER_PROVIDER_STATEMENT_EXEC_ERROR" value="4"/>
			<member name="GDA_SERVER_PROVIDER_OPERATION_ERROR" value="5"/>
			<member name="GDA_SERVER_PROVIDER_INTERNAL_ERROR" value="6"/>
			<member name="GDA_SERVER_PROVIDER_BUSY_ERROR" value="7"/>
			<member name="GDA_SERVER_PROVIDER_NON_SUPPORTED_ERROR" value="8"/>
			<member name="GDA_SERVER_PROVIDER_SERVER_VERSION_ERROR" value="9"/>
			<member name="GDA_SERVER_PROVIDER_DATA_ERROR" value="10"/>
			<member name="GDA_SERVER_PROVIDER_DEFAULT_VALUE_HANDLING_ERROR" value="11"/>
		</enum>
		<enum name="GdaSetError" type-name="GdaSetError" get-type="gda_set_error_get_type">
			<member name="GDA_SET_XML_SPEC_ERROR" value="0"/>
			<member name="GDA_SET_HOLDER_NOT_FOUND_ERROR" value="1"/>
			<member name="GDA_SET_INVALID_ERROR" value="2"/>
			<member name="GDA_SET_READ_ONLY_ERROR" value="3"/>
		</enum>
		<enum name="GdaSqlAnyPartType" type-name="GdaSqlAnyPartType" get-type="gda_sql_any_part_type_get_type">
			<member name="GDA_SQL_ANY_STMT_SELECT" value="0"/>
			<member name="GDA_SQL_ANY_STMT_INSERT" value="1"/>
			<member name="GDA_SQL_ANY_STMT_UPDATE" value="2"/>
			<member name="GDA_SQL_ANY_STMT_DELETE" value="3"/>
			<member name="GDA_SQL_ANY_STMT_COMPOUND" value="4"/>
			<member name="GDA_SQL_ANY_STMT_BEGIN" value="5"/>
			<member name="GDA_SQL_ANY_STMT_ROLLBACK" value="6"/>
			<member name="GDA_SQL_ANY_STMT_COMMIT" value="7"/>
			<member name="GDA_SQL_ANY_STMT_SAVEPOINT" value="8"/>
			<member name="GDA_SQL_ANY_STMT_ROLLBACK_SAVEPOINT" value="9"/>
			<member name="GDA_SQL_ANY_STMT_DELETE_SAVEPOINT" value="10"/>
			<member name="GDA_SQL_ANY_STMT_UNKNOWN" value="11"/>
			<member name="GDA_SQL_ANY_EXPR" value="500"/>
			<member name="GDA_SQL_ANY_SQL_FIELD" value="501"/>
			<member name="GDA_SQL_ANY_SQL_TABLE" value="502"/>
			<member name="GDA_SQL_ANY_SQL_FUNCTION" value="503"/>
			<member name="GDA_SQL_ANY_SQL_OPERATION" value="504"/>
			<member name="GDA_SQL_ANY_SQL_CASE" value="505"/>
			<member name="GDA_SQL_ANY_SQL_SELECT_FIELD" value="506"/>
			<member name="GDA_SQL_ANY_SQL_SELECT_TARGET" value="507"/>
			<member name="GDA_SQL_ANY_SQL_SELECT_JOIN" value="508"/>
			<member name="GDA_SQL_ANY_SQL_SELECT_FROM" value="509"/>
			<member name="GDA_SQL_ANY_SQL_SELECT_ORDER" value="510"/>
		</enum>
		<enum name="GdaSqlBuilderError" type-name="GdaSqlBuilderError" get-type="gda_sql_builder_error_get_type">
			<member name="GDA_SQL_BUILDER_WRONG_TYPE_ERROR" value="0"/>
			<member name="GDA_SQL_BUILDER_MISUSE_ERROR" value="1"/>
		</enum>
		<enum name="GdaSqlError" type-name="GdaSqlError" get-type="gda_sql_error_type_get_type">
			<member name="GDA_SQL_STRUCTURE_CONTENTS_ERROR" value="0"/>
			<member name="GDA_SQL_MALFORMED_IDENTIFIER_ERROR" value="1"/>
			<member name="GDA_SQL_MISSING_IDENTIFIER_ERROR" value="2"/>
			<member name="GDA_SQL_VALIDATION_ERROR" value="3"/>
		</enum>
		<enum name="GdaSqlError" type-name="GdaSqlError" get-type="gda_sql_error_get_type">
			<member name="GDA_SQL_STRUCTURE_CONTENTS_ERROR" value="0"/>
			<member name="GDA_SQL_MALFORMED_IDENTIFIER_ERROR" value="1"/>
			<member name="GDA_SQL_MISSING_IDENTIFIER_ERROR" value="2"/>
			<member name="GDA_SQL_VALIDATION_ERROR" value="3"/>
		</enum>
		<enum name="GdaSqlOperatorType" type-name="GdaSqlOperatorType" get-type="gda_sql_operator_type_get_type">
			<member name="GDA_SQL_OPERATOR_TYPE_AND" value="0"/>
			<member name="GDA_SQL_OPERATOR_TYPE_OR" value="1"/>
			<member name="GDA_SQL_OPERATOR_TYPE_EQ" value="2"/>
			<member name="GDA_SQL_OPERATOR_TYPE_IS" value="3"/>
			<member name="GDA_SQL_OPERATOR_TYPE_LIKE" value="4"/>
			<member name="GDA_SQL_OPERATOR_TYPE_BETWEEN" value="5"/>
			<member name="GDA_SQL_OPERATOR_TYPE_GT" value="6"/>
			<member name="GDA_SQL_OPERATOR_TYPE_LT" value="7"/>
			<member name="GDA_SQL_OPERATOR_TYPE_GEQ" value="8"/>
			<member name="GDA_SQL_OPERATOR_TYPE_LEQ" value="9"/>
			<member name="GDA_SQL_OPERATOR_TYPE_DIFF" value="10"/>
			<member name="GDA_SQL_OPERATOR_TYPE_REGEXP" value="11"/>
			<member name="GDA_SQL_OPERATOR_TYPE_REGEXP_CI" value="12"/>
			<member name="GDA_SQL_OPERATOR_TYPE_NOT_REGEXP" value="13"/>
			<member name="GDA_SQL_OPERATOR_TYPE_NOT_REGEXP_CI" value="14"/>
			<member name="GDA_SQL_OPERATOR_TYPE_SIMILAR" value="15"/>
			<member name="GDA_SQL_OPERATOR_TYPE_ISNULL" value="16"/>
			<member name="GDA_SQL_OPERATOR_TYPE_ISNOTNULL" value="17"/>
			<member name="GDA_SQL_OPERATOR_TYPE_NOT" value="18"/>
			<member name="GDA_SQL_OPERATOR_TYPE_IN" value="19"/>
			<member name="GDA_SQL_OPERATOR_TYPE_NOTIN" value="20"/>
			<member name="GDA_SQL_OPERATOR_TYPE_CONCAT" value="21"/>
			<member name="GDA_SQL_OPERATOR_TYPE_PLUS" value="22"/>
			<member name="GDA_SQL_OPERATOR_TYPE_MINUS" value="23"/>
			<member name="GDA_SQL_OPERATOR_TYPE_STAR" value="24"/>
			<member name="GDA_SQL_OPERATOR_TYPE_DIV" value="25"/>
			<member name="GDA_SQL_OPERATOR_TYPE_REM" value="26"/>
			<member name="GDA_SQL_OPERATOR_TYPE_BITAND" value="27"/>
			<member name="GDA_SQL_OPERATOR_TYPE_BITOR" value="28"/>
			<member name="GDA_SQL_OPERATOR_TYPE_BITNOT" value="29"/>
		</enum>
		<enum name="GdaSqlParserError" type-name="GdaSqlParserError" get-type="gda_sql_parser_error_get_type">
			<member name="GDA_SQL_PARSER_SYNTAX_ERROR" value="0"/>
			<member name="GDA_SQL_PARSER_OVERFLOW_ERROR" value="1"/>
			<member name="GDA_SQL_PARSER_EMPTY_SQL_ERROR" value="2"/>
		</enum>
		<enum name="GdaSqlParserFlavour" type-name="GdaSqlParserFlavour" get-type="gda_sql_parser_flavour_get_type">
			<member name="GDA_SQL_PARSER_FLAVOUR_STANDARD" value="0"/>
			<member name="GDA_SQL_PARSER_FLAVOUR_SQLITE" value="1"/>
			<member name="GDA_SQL_PARSER_FLAVOUR_MYSQL" value="2"/>
			<member name="GDA_SQL_PARSER_FLAVOUR_ORACLE" value="3"/>
			<member name="GDA_SQL_PARSER_FLAVOUR_POSTGRESQL" value="4"/>
		</enum>
		<enum name="GdaSqlParserMode" type-name="GdaSqlParserMode" get-type="gda_sql_parser_mode_get_type">
			<member name="GDA_SQL_PARSER_MODE_PARSE" value="0"/>
			<member name="GDA_SQL_PARSER_MODE_DELIMIT" value="1"/>
		</enum>
		<enum name="GdaSqlSelectJoinType" type-name="GdaSqlSelectJoinType" get-type="gda_sql_select_join_type_get_type">
			<member name="GDA_SQL_SELECT_JOIN_CROSS" value="0"/>
			<member name="GDA_SQL_SELECT_JOIN_NATURAL" value="1"/>
			<member name="GDA_SQL_SELECT_JOIN_INNER" value="2"/>
			<member name="GDA_SQL_SELECT_JOIN_LEFT" value="3"/>
			<member name="GDA_SQL_SELECT_JOIN_RIGHT" value="4"/>
			<member name="GDA_SQL_SELECT_JOIN_FULL" value="5"/>
		</enum>
		<enum name="GdaSqlStatementCompoundType" type-name="GdaSqlStatementCompoundType" get-type="gda_sql_statement_compound_type_get_type">
			<member name="GDA_SQL_STATEMENT_COMPOUND_UNION" value="0"/>
			<member name="GDA_SQL_STATEMENT_COMPOUND_UNION_ALL" value="1"/>
			<member name="GDA_SQL_STATEMENT_COMPOUND_INTERSECT" value="2"/>
			<member name="GDA_SQL_STATEMENT_COMPOUND_INTERSECT_ALL" value="3"/>
			<member name="GDA_SQL_STATEMENT_COMPOUND_EXCEPT" value="4"/>
			<member name="GDA_SQL_STATEMENT_COMPOUND_EXCEPT_ALL" value="5"/>
		</enum>
		<enum name="GdaSqlStatementType" type-name="GdaSqlStatementType" get-type="gda_sql_statement_type_get_type">
			<member name="GDA_SQL_STATEMENT_SELECT" value="0"/>
			<member name="GDA_SQL_STATEMENT_INSERT" value="1"/>
			<member name="GDA_SQL_STATEMENT_UPDATE" value="2"/>
			<member name="GDA_SQL_STATEMENT_DELETE" value="3"/>
			<member name="GDA_SQL_STATEMENT_COMPOUND" value="4"/>
			<member name="GDA_SQL_STATEMENT_BEGIN" value="5"/>
			<member name="GDA_SQL_STATEMENT_ROLLBACK" value="6"/>
			<member name="GDA_SQL_STATEMENT_COMMIT" value="7"/>
			<member name="GDA_SQL_STATEMENT_SAVEPOINT" value="8"/>
			<member name="GDA_SQL_STATEMENT_ROLLBACK_SAVEPOINT" value="9"/>
			<member name="GDA_SQL_STATEMENT_DELETE_SAVEPOINT" value="10"/>
			<member name="GDA_SQL_STATEMENT_UNKNOWN" value="11"/>
			<member name="GDA_SQL_STATEMENT_NONE" value="12"/>
		</enum>
		<enum name="GdaStatementError" type-name="GdaStatementError" get-type="gda_statement_error_get_type">
			<member name="GDA_STATEMENT_PARSE_ERROR" value="0"/>
			<member name="GDA_STATEMENT_SYNTAX_ERROR" value="1"/>
			<member name="GDA_STATEMENT_NO_CNC_ERROR" value="2"/>
			<member name="GDA_STATEMENT_CNC_CLOSED_ERROR" value="3"/>
			<member name="GDA_STATEMENT_EXEC_ERROR" value="4"/>
			<member name="GDA_STATEMENT_PARAM_TYPE_ERROR" value="5"/>
			<member name="GDA_STATEMENT_PARAM_ERROR" value="6"/>
		</enum>
		<enum name="GdaThreadWrapperError">
			<member name="GDA_THREAD_WRAPPER_UNKNOWN_ERROR" value="0"/>
		</enum>
		<enum name="GdaTransactionIsolation" type-name="GdaTransactionIsolation" get-type="gda_transaction_isolation_get_type">
			<member name="GDA_TRANSACTION_ISOLATION_UNKNOWN" value="0"/>
			<member name="GDA_TRANSACTION_ISOLATION_READ_COMMITTED" value="1"/>
			<member name="GDA_TRANSACTION_ISOLATION_READ_UNCOMMITTED" value="2"/>
			<member name="GDA_TRANSACTION_ISOLATION_REPEATABLE_READ" value="3"/>
			<member name="GDA_TRANSACTION_ISOLATION_SERIALIZABLE" value="4"/>
		</enum>
		<enum name="GdaTransactionStatusEventType" type-name="GdaTransactionStatusEventType" get-type="gda_transaction_status_event_type_get_type">
			<member name="GDA_TRANSACTION_STATUS_EVENT_SAVEPOINT" value="0"/>
			<member name="GDA_TRANSACTION_STATUS_EVENT_SQL" value="1"/>
			<member name="GDA_TRANSACTION_STATUS_EVENT_SUB_TRANSACTION" value="2"/>
		</enum>
		<enum name="GdaTransactionStatusState" type-name="GdaTransactionStatusState" get-type="gda_transaction_status_state_get_type">
			<member name="GDA_TRANSACTION_STATUS_STATE_OK" value="0"/>
			<member name="GDA_TRANSACTION_STATUS_STATE_FAILED" value="1"/>
		</enum>
		<enum name="GdaTreeError" type-name="GdaTreeError" get-type="gda_tree_error_get_type">
			<member name="GDA_TREE_UNKNOWN_ERROR" value="0"/>
		</enum>
		<enum name="GdaTreeManagerError" type-name="GdaTreeManagerError" get-type="gda_tree_manager_error_get_type">
			<member name="GDA_TREE_MANAGER_UNKNOWN_ERROR" value="0"/>
		</enum>
		<enum name="GdaTreeNodeError" type-name="GdaTreeNodeError" get-type="gda_tree_node_error_get_type">
			<member name="GDA_TREE_NODE_UNKNOWN_ERROR" value="0"/>
		</enum>
		<enum name="GdaXaTransactionError" type-name="GdaXaTransactionError" get-type="gda_xa_transaction_error_get_type">
			<member name="GDA_XA_TRANSACTION_ALREADY_REGISTERED_ERROR" value="0"/>
			<member name="GDA_XA_TRANSACTION_DTP_NOT_SUPPORTED_ERROR" value="1"/>
			<member name="GDA_XA_TRANSACTION_CONNECTION_BRANCH_LENGTH_ERROR" value="2"/>
		</enum>
		<flags name="GdaConnectionOptions" type-name="GdaConnectionOptions" get-type="gda_connection_options_get_type">
			<member name="GDA_CONNECTION_OPTIONS_NONE" value="0"/>
			<member name="GDA_CONNECTION_OPTIONS_READ_ONLY" value="1"/>
			<member name="GDA_CONNECTION_OPTIONS_SQL_IDENTIFIERS_CASE_SENSITIVE" value="2"/>
			<member name="GDA_CONNECTION_OPTIONS_THREAD_SAFE" value="4"/>
			<member name="GDA_CONNECTION_OPTIONS_THREAD_ISOLATED" value="8"/>
			<member name="GDA_CONNECTION_OPTIONS_AUTO_META_DATA" value="16"/>
		</flags>
		<flags name="GdaDataModelAccessFlags" type-name="GdaDataModelAccessFlags" get-type="gda_data_model_access_flags_get_type">
			<member name="GDA_DATA_MODEL_ACCESS_RANDOM" value="1"/>
			<member name="GDA_DATA_MODEL_ACCESS_CURSOR_FORWARD" value="2"/>
			<member name="GDA_DATA_MODEL_ACCESS_CURSOR_BACKWARD" value="4"/>
			<member name="GDA_DATA_MODEL_ACCESS_CURSOR" value="6"/>
			<member name="GDA_DATA_MODEL_ACCESS_INSERT" value="8"/>
			<member name="GDA_DATA_MODEL_ACCESS_UPDATE" value="16"/>
			<member name="GDA_DATA_MODEL_ACCESS_DELETE" value="32"/>
			<member name="GDA_DATA_MODEL_ACCESS_WRITE" value="56"/>
			<member name="GDA_DATA_MODEL_ACCESS_DELETE" value="32"/>
		</flags>
		<flags name="GdaMetaGraphInfo" type-name="GdaMetaGraphInfo" get-type="gda_meta_graph_info_get_type">
			<member name="GDA_META_GRAPH_COLUMNS" value="1"/>
		</flags>
		<flags name="GdaMetaStructFeature" type-name="GdaMetaStructFeature" get-type="gda_meta_struct_feature_get_type">
			<member name="GDA_META_STRUCT_FEATURE_NONE" value="0"/>
			<member name="GDA_META_STRUCT_FEATURE_FOREIGN_KEYS" value="1"/>
			<member name="GDA_META_STRUCT_FEATURE_VIEW_DEPENDENCIES" value="2"/>
			<member name="GDA_META_STRUCT_FEATURE_ALL" value="3"/>
			<member name="GDA_META_STRUCT_FEATURE_VIEW_DEPENDENCIES" value="2"/>
		</flags>
		<flags name="GdaServerOperationCreateTableFlag" type-name="GdaServerOperationCreateTableFlag" get-type="gda_server_operation_create_table_flag_get_type">
			<member name="GDA_SERVER_OPERATION_CREATE_TABLE_NOTHING_FLAG" value="1"/>
			<member name="GDA_SERVER_OPERATION_CREATE_TABLE_PKEY_FLAG" value="2"/>
			<member name="GDA_SERVER_OPERATION_CREATE_TABLE_NOT_NULL_FLAG" value="4"/>
			<member name="GDA_SERVER_OPERATION_CREATE_TABLE_UNIQUE_FLAG" value="8"/>
			<member name="GDA_SERVER_OPERATION_CREATE_TABLE_AUTOINC_FLAG" value="16"/>
			<member name="GDA_SERVER_OPERATION_CREATE_TABLE_FKEY_FLAG" value="32"/>
			<member name="GDA_SERVER_OPERATION_CREATE_TABLE_PKEY_AUTOINC_FLAG" value="18"/>
		</flags>
		<flags name="GdaSqlIdentifierStyle" type-name="GdaSqlIdentifierStyle" get-type="gda_sql_identifier_style_get_type">
			<member name="GDA_SQL_IDENTIFIERS_LOWER_CASE" value="1"/>
			<member name="GDA_SQL_IDENTIFIERS_UPPER_CASE" value="2"/>
		</flags>
		<flags name="GdaStatementModelUsage" type-name="GdaStatementModelUsage" get-type="gda_statement_model_usage_get_type">
			<member name="GDA_STATEMENT_MODEL_RANDOM_ACCESS" value="1"/>
			<member name="GDA_STATEMENT_MODEL_CURSOR_FORWARD" value="2"/>
			<member name="GDA_STATEMENT_MODEL_CURSOR_BACKWARD" value="4"/>
			<member name="GDA_STATEMENT_MODEL_CURSOR" value="6"/>
			<member name="GDA_STATEMENT_MODEL_ALLOW_NOPARAM" value="8"/>
		</flags>
		<flags name="GdaStatementSqlFlag" type-name="GdaStatementSqlFlag" get-type="gda_statement_sql_flag_get_type">
			<member name="GDA_STATEMENT_SQL_PARAMS_AS_VALUES" value="0"/>
			<member name="GDA_STATEMENT_SQL_PRETTY" value="1"/>
			<member name="GDA_STATEMENT_SQL_PARAMS_LONG" value="2"/>
			<member name="GDA_STATEMENT_SQL_PARAMS_SHORT" value="4"/>
			<member name="GDA_STATEMENT_SQL_PARAMS_AS_COLON" value="8"/>
			<member name="GDA_STATEMENT_SQL_PARAMS_AS_DOLLAR" value="16"/>
			<member name="GDA_STATEMENT_SQL_PARAMS_AS_QMARK" value="32"/>
			<member name="GDA_STATEMENT_SQL_PARAMS_AS_UQMARK" value="64"/>
		</flags>
		<flags name="GdaValueAttribute" type-name="GdaValueAttribute" get-type="gda_value_attribute_get_type">
			<member name="GDA_VALUE_ATTR_NONE" value="0"/>
			<member name="GDA_VALUE_ATTR_IS_NULL" value="1"/>
			<member name="GDA_VALUE_ATTR_CAN_BE_NULL" value="2"/>
			<member name="GDA_VALUE_ATTR_IS_DEFAULT" value="4"/>
			<member name="GDA_VALUE_ATTR_CAN_BE_DEFAULT" value="8"/>
			<member name="GDA_VALUE_ATTR_IS_UNCHANGED" value="16"/>
			<member name="GDA_VALUE_ATTR_ACTIONS_SHOWN" value="32"/>
			<member name="GDA_VALUE_ATTR_DATA_NON_VALID" value="64"/>
			<member name="GDA_VALUE_ATTR_HAS_VALUE_ORIG" value="128"/>
			<member name="GDA_VALUE_ATTR_NO_MODIF" value="256"/>
			<member name="GDA_VALUE_ATTR_UNUSED" value="512"/>
		</flags>
		<object name="GdaBatch" parent="GObject" type-name="GdaBatch" get-type="gda_batch_get_type">
			<method name="add_statement" symbol="gda_batch_add_statement">
				<return-type type="void"/>
				<parameters>
					<parameter name="batch" type="GdaBatch*"/>
					<parameter name="stmt" type="GdaStatement*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gda_batch_copy">
				<return-type type="GdaBatch*"/>
				<parameters>
					<parameter name="orig" type="GdaBatch*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_batch_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_parameters" symbol="gda_batch_get_parameters">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="batch" type="GdaBatch*"/>
					<parameter name="out_params" type="GdaSet**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_statements" symbol="gda_batch_get_statements">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="batch" type="GdaBatch*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_batch_new">
				<return-type type="GdaBatch*"/>
			</constructor>
			<method name="remove_statement" symbol="gda_batch_remove_statement">
				<return-type type="void"/>
				<parameters>
					<parameter name="batch" type="GdaBatch*"/>
					<parameter name="stmt" type="GdaStatement*"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_batch_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="batch" type="GdaBatch*"/>
				</parameters>
			</method>
			<signal name="changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="batch" type="GdaBatch*"/>
					<parameter name="changed_stmt" type="GObject*"/>
				</parameters>
			</signal>
		</object>
		<object name="GdaBlobOp" parent="GObject" type-name="GdaBlobOp" get-type="gda_blob_op_get_type">
			<method name="get_length" symbol="gda_blob_op_get_length">
				<return-type type="glong"/>
				<parameters>
					<parameter name="op" type="GdaBlobOp*"/>
				</parameters>
			</method>
			<method name="read" symbol="gda_blob_op_read">
				<return-type type="glong"/>
				<parameters>
					<parameter name="op" type="GdaBlobOp*"/>
					<parameter name="blob" type="GdaBlob*"/>
					<parameter name="offset" type="glong"/>
					<parameter name="size" type="glong"/>
				</parameters>
			</method>
			<method name="read_all" symbol="gda_blob_op_read_all">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GdaBlobOp*"/>
					<parameter name="blob" type="GdaBlob*"/>
				</parameters>
			</method>
			<method name="write" symbol="gda_blob_op_write">
				<return-type type="glong"/>
				<parameters>
					<parameter name="op" type="GdaBlobOp*"/>
					<parameter name="blob" type="GdaBlob*"/>
					<parameter name="offset" type="glong"/>
				</parameters>
			</method>
			<method name="write_all" symbol="gda_blob_op_write_all">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GdaBlobOp*"/>
					<parameter name="blob" type="GdaBlob*"/>
				</parameters>
			</method>
			<vfunc name="get_length">
				<return-type type="glong"/>
				<parameters>
					<parameter name="op" type="GdaBlobOp*"/>
				</parameters>
			</vfunc>
			<vfunc name="read">
				<return-type type="glong"/>
				<parameters>
					<parameter name="op" type="GdaBlobOp*"/>
					<parameter name="blob" type="GdaBlob*"/>
					<parameter name="offset" type="glong"/>
					<parameter name="size" type="glong"/>
				</parameters>
			</vfunc>
			<vfunc name="write">
				<return-type type="glong"/>
				<parameters>
					<parameter name="op" type="GdaBlobOp*"/>
					<parameter name="blob" type="GdaBlob*"/>
					<parameter name="offset" type="glong"/>
				</parameters>
			</vfunc>
			<vfunc name="write_all">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GdaBlobOp*"/>
					<parameter name="blob" type="GdaBlob*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GdaColumn" parent="GObject" type-name="GdaColumn" get-type="gda_column_get_type">
			<method name="copy" symbol="gda_column_copy">
				<return-type type="GdaColumn*"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
				</parameters>
			</method>
			<method name="get_allow_null" symbol="gda_column_get_allow_null">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
				</parameters>
			</method>
			<method name="get_attribute" symbol="gda_column_get_attribute">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
					<parameter name="attribute" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_auto_increment" symbol="gda_column_get_auto_increment">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
				</parameters>
			</method>
			<method name="get_dbms_type" symbol="gda_column_get_dbms_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
				</parameters>
			</method>
			<method name="get_default_value" symbol="gda_column_get_default_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="gda_column_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
				</parameters>
			</method>
			<method name="get_g_type" symbol="gda_column_get_g_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gda_column_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
				</parameters>
			</method>
			<method name="get_position" symbol="gda_column_get_position">
				<return-type type="gint"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_column_new">
				<return-type type="GdaColumn*"/>
			</constructor>
			<method name="set_allow_null" symbol="gda_column_set_allow_null">
				<return-type type="void"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
					<parameter name="allow" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_attribute" symbol="gda_column_set_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
					<parameter name="attribute" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_auto_increment" symbol="gda_column_set_auto_increment">
				<return-type type="void"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
					<parameter name="is_auto" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_dbms_type" symbol="gda_column_set_dbms_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
					<parameter name="dbms_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_default_value" symbol="gda_column_set_default_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
					<parameter name="default_value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_description" symbol="gda_column_set_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_g_type" symbol="gda_column_set_g_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="set_name" symbol="gda_column_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_position" symbol="gda_column_set_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</method>
			<property name="id" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="g-type-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
					<parameter name="old_type" type="GType"/>
					<parameter name="new_type" type="GType"/>
				</parameters>
			</signal>
			<signal name="name-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="column" type="GdaColumn*"/>
					<parameter name="old_name" type="char*"/>
				</parameters>
			</signal>
		</object>
		<object name="GdaConfig" parent="GObject" type-name="GdaConfig" get-type="gda_config_get_type">
			<method name="can_modify_system_config" symbol="gda_config_can_modify_system_config">
				<return-type type="gboolean"/>
			</method>
			<method name="define_dsn" symbol="gda_config_define_dsn">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GdaDsnInfo*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="dsn_needs_authentication" symbol="gda_config_dsn_needs_authentication">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dsn_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_config_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get" symbol="gda_config_get">
				<return-type type="GdaConfig*"/>
			</method>
			<method name="get_dsn_info" symbol="gda_config_get_dsn_info">
				<return-type type="GdaDsnInfo*"/>
				<parameters>
					<parameter name="dsn_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_dsn_info_at_index" symbol="gda_config_get_dsn_info_at_index">
				<return-type type="GdaDsnInfo*"/>
				<parameters>
					<parameter name="index" type="gint"/>
				</parameters>
			</method>
			<method name="get_dsn_info_index" symbol="gda_config_get_dsn_info_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="dsn_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_nb_dsn" symbol="gda_config_get_nb_dsn">
				<return-type type="gint"/>
			</method>
			<method name="get_provider" symbol="gda_config_get_provider">
				<return-type type="GdaServerProvider*"/>
				<parameters>
					<parameter name="provider_name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_provider_info" symbol="gda_config_get_provider_info">
				<return-type type="GdaProviderInfo*"/>
				<parameters>
					<parameter name="provider_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="list_dsn" symbol="gda_config_list_dsn">
				<return-type type="GdaDataModel*"/>
			</method>
			<method name="list_providers" symbol="gda_config_list_providers">
				<return-type type="GdaDataModel*"/>
			</method>
			<method name="remove_dsn" symbol="gda_config_remove_dsn">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dsn_name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="system-filename" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="user-filename" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="dsn-added" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="conf" type="GdaConfig*"/>
					<parameter name="new_dsn" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="dsn-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="conf" type="GdaConfig*"/>
					<parameter name="dsn" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="dsn-removed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="conf" type="GdaConfig*"/>
					<parameter name="old_dsn" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="dsn-to-be-removed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="conf" type="GdaConfig*"/>
					<parameter name="old_dsn" type="gpointer"/>
				</parameters>
			</signal>
		</object>
		<object name="GdaConnection" parent="GObject" type-name="GdaConnection" get-type="gda_connection_get_type">
			<implements>
				<interface name="GdaLockable"/>
			</implements>
			<method name="add_savepoint" symbol="gda_connection_add_savepoint">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="async_cancel" symbol="gda_connection_async_cancel">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="task_id" type="guint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="async_fetch_result" symbol="gda_connection_async_fetch_result">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="task_id" type="guint"/>
					<parameter name="last_insert_row" type="GdaSet**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="async_statement_execute" symbol="gda_connection_async_statement_execute">
				<return-type type="guint"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="model_usage" type="GdaStatementModelUsage"/>
					<parameter name="col_types" type="GType*"/>
					<parameter name="need_last_insert_row" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="batch_execute" symbol="gda_connection_batch_execute">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="batch" type="GdaBatch*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="model_usage" type="GdaStatementModelUsage"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="begin_transaction" symbol="gda_connection_begin_transaction">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="level" type="GdaTransactionIsolation"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="close" symbol="gda_connection_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="close_no_warning" symbol="gda_connection_close_no_warning">
				<return-type type="void"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="commit_transaction" symbol="gda_connection_commit_transaction">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_operation" symbol="gda_connection_create_operation">
				<return-type type="GdaServerOperation*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="type" type="GdaServerOperationType"/>
					<parameter name="options" type="GdaSet*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_parser" symbol="gda_connection_create_parser">
				<return-type type="GdaSqlParser*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="delete_row_from_table" symbol="gda_connection_delete_row_from_table">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="table" type="gchar*"/>
					<parameter name="condition_column_name" type="gchar*"/>
					<parameter name="condition_value" type="GValue*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="delete_savepoint" symbol="gda_connection_delete_savepoint">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_connection_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="execute_non_select_command" symbol="gda_connection_execute_non_select_command">
				<return-type type="gint"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="sql" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="execute_select_command" symbol="gda_connection_execute_select_command">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="sql" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_authentication" symbol="gda_connection_get_authentication">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="get_cnc_string" symbol="gda_connection_get_cnc_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="get_dsn" symbol="gda_connection_get_dsn">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="get_events" symbol="gda_connection_get_events">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="get_meta_store" symbol="gda_connection_get_meta_store">
				<return-type type="GdaMetaStore*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="get_meta_store_data" symbol="gda_connection_get_meta_store_data">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="meta_type" type="GdaConnectionMetaType"/>
					<parameter name="error" type="GError**"/>
					<parameter name="nb_filters" type="gint"/>
				</parameters>
			</method>
			<method name="get_meta_store_data_v" symbol="gda_connection_get_meta_store_data_v">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="meta_type" type="GdaConnectionMetaType"/>
					<parameter name="filters" type="GList*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_options" symbol="gda_connection_get_options">
				<return-type type="GdaConnectionOptions"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="get_provider" symbol="gda_connection_get_provider">
				<return-type type="GdaServerProvider*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="get_provider_name" symbol="gda_connection_get_provider_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="get_transaction_status" symbol="gda_connection_get_transaction_status">
				<return-type type="GdaTransactionStatus*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="insert_row_into_table" symbol="gda_connection_insert_row_into_table">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="table" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="insert_row_into_table_v" symbol="gda_connection_insert_row_into_table_v">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="table" type="gchar*"/>
					<parameter name="col_names" type="GSList*"/>
					<parameter name="values" type="GSList*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="is_opened" symbol="gda_connection_is_opened">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="open" symbol="gda_connection_open">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="open_from_dsn" symbol="gda_connection_open_from_dsn">
				<return-type type="GdaConnection*"/>
				<parameters>
					<parameter name="dsn" type="gchar*"/>
					<parameter name="auth_string" type="gchar*"/>
					<parameter name="options" type="GdaConnectionOptions"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="open_from_string" symbol="gda_connection_open_from_string">
				<return-type type="GdaConnection*"/>
				<parameters>
					<parameter name="provider_name" type="gchar*"/>
					<parameter name="cnc_string" type="gchar*"/>
					<parameter name="auth_string" type="gchar*"/>
					<parameter name="options" type="GdaConnectionOptions"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="parse_sql_string" symbol="gda_connection_parse_sql_string">
				<return-type type="GdaStatement*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="sql" type="gchar*"/>
					<parameter name="params" type="GdaSet**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="perform_operation" symbol="gda_connection_perform_operation">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="quote_sql_identifier" symbol="gda_connection_quote_sql_identifier">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="repetitive_statement_execute" symbol="gda_connection_repetitive_statement_execute">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="rstmt" type="GdaRepetitiveStatement*"/>
					<parameter name="model_usage" type="GdaStatementModelUsage"/>
					<parameter name="col_types" type="GType*"/>
					<parameter name="stop_on_error" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="rollback_savepoint" symbol="gda_connection_rollback_savepoint">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="rollback_transaction" symbol="gda_connection_rollback_transaction">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="statement_execute" symbol="gda_connection_statement_execute">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="model_usage" type="GdaStatementModelUsage"/>
					<parameter name="last_insert_row" type="GdaSet**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="statement_execute_non_select" symbol="gda_connection_statement_execute_non_select">
				<return-type type="gint"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="last_insert_row" type="GdaSet**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="statement_execute_select" symbol="gda_connection_statement_execute_select">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="statement_execute_select_full" symbol="gda_connection_statement_execute_select_full">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="model_usage" type="GdaStatementModelUsage"/>
					<parameter name="col_types" type="GType*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="statement_execute_select_fullv" symbol="gda_connection_statement_execute_select_fullv">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="model_usage" type="GdaStatementModelUsage"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="statement_prepare" symbol="gda_connection_statement_prepare">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="statement_to_sql" symbol="gda_connection_statement_to_sql">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="flags" type="GdaStatementSqlFlag"/>
					<parameter name="params_used" type="GSList**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="string_split" symbol="gda_connection_string_split">
				<return-type type="void"/>
				<parameters>
					<parameter name="string" type="gchar*"/>
					<parameter name="out_cnc_params" type="gchar**"/>
					<parameter name="out_provider" type="gchar**"/>
					<parameter name="out_username" type="gchar**"/>
					<parameter name="out_password" type="gchar**"/>
				</parameters>
			</method>
			<method name="supports_feature" symbol="gda_connection_supports_feature">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="feature" type="GdaConnectionFeature"/>
				</parameters>
			</method>
			<method name="update_meta_store" symbol="gda_connection_update_meta_store">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="context" type="GdaMetaContext*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="update_row_in_table" symbol="gda_connection_update_row_in_table">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="table" type="gchar*"/>
					<parameter name="condition_column_name" type="gchar*"/>
					<parameter name="condition_value" type="GValue*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="update_row_in_table_v" symbol="gda_connection_update_row_in_table_v">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="table" type="gchar*"/>
					<parameter name="condition_column_name" type="gchar*"/>
					<parameter name="condition_value" type="GValue*"/>
					<parameter name="col_names" type="GSList*"/>
					<parameter name="values" type="GSList*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="value_to_sql_string" symbol="gda_connection_value_to_sql_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="from" type="GValue*"/>
				</parameters>
			</method>
			<property name="auth-string" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="cnc-string" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="dsn" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="events-history-size" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-wrapper" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="meta-store" type="GdaMetaStore*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="monitor-wrapped-in-mainloop" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="options" type="GdaConnectionOptions" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="provider" type="GdaServerProvider*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="thread-owner" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="conn-closed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="GdaConnection*"/>
				</parameters>
			</signal>
			<signal name="conn-opened" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="GdaConnection*"/>
				</parameters>
			</signal>
			<signal name="conn-to-close" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="GdaConnection*"/>
				</parameters>
			</signal>
			<signal name="dsn-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="GdaConnection*"/>
				</parameters>
			</signal>
			<signal name="error" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="error" type="GdaConnectionEvent*"/>
				</parameters>
			</signal>
			<signal name="transaction-status-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="obj" type="GdaConnection*"/>
				</parameters>
			</signal>
		</object>
		<object name="GdaConnectionEvent" parent="GObject" type-name="GdaConnectionEvent" get-type="gda_connection_event_get_type">
			<method name="get_code" symbol="gda_connection_event_get_code">
				<return-type type="glong"/>
				<parameters>
					<parameter name="event" type="GdaConnectionEvent*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="gda_connection_event_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="event" type="GdaConnectionEvent*"/>
				</parameters>
			</method>
			<method name="get_event_type" symbol="gda_connection_event_get_event_type">
				<return-type type="GdaConnectionEventType"/>
				<parameters>
					<parameter name="event" type="GdaConnectionEvent*"/>
				</parameters>
			</method>
			<method name="get_gda_code" symbol="gda_connection_event_get_gda_code">
				<return-type type="GdaConnectionEventCode"/>
				<parameters>
					<parameter name="event" type="GdaConnectionEvent*"/>
				</parameters>
			</method>
			<method name="get_source" symbol="gda_connection_event_get_source">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="event" type="GdaConnectionEvent*"/>
				</parameters>
			</method>
			<method name="get_sqlstate" symbol="gda_connection_event_get_sqlstate">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="event" type="GdaConnectionEvent*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_connection_event_new">
				<return-type type="GdaConnectionEvent*"/>
				<parameters>
					<parameter name="type" type="GdaConnectionEventType"/>
				</parameters>
			</constructor>
			<method name="set_code" symbol="gda_connection_event_set_code">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdaConnectionEvent*"/>
					<parameter name="code" type="glong"/>
				</parameters>
			</method>
			<method name="set_description" symbol="gda_connection_event_set_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdaConnectionEvent*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_event_type" symbol="gda_connection_event_set_event_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdaConnectionEvent*"/>
					<parameter name="type" type="GdaConnectionEventType"/>
				</parameters>
			</method>
			<method name="set_gda_code" symbol="gda_connection_event_set_gda_code">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdaConnectionEvent*"/>
					<parameter name="code" type="GdaConnectionEventCode"/>
				</parameters>
			</method>
			<method name="set_source" symbol="gda_connection_event_set_source">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdaConnectionEvent*"/>
					<parameter name="source" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_sqlstate" symbol="gda_connection_event_set_sqlstate">
				<return-type type="void"/>
				<parameters>
					<parameter name="event" type="GdaConnectionEvent*"/>
					<parameter name="sqlstate" type="gchar*"/>
				</parameters>
			</method>
			<property name="type" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GdaDataAccessWrapper" parent="GObject" type-name="GdaDataAccessWrapper" get-type="gda_data_access_wrapper_get_type">
			<implements>
				<interface name="GdaDataModel"/>
			</implements>
			<constructor name="new" symbol="gda_data_access_wrapper_new">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</constructor>
			<property name="model" type="GdaDataModel*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdaDataComparator" parent="GObject" type-name="GdaDataComparator" get-type="gda_data_comparator_get_type">
			<method name="compute_diff" symbol="gda_data_comparator_compute_diff">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="comp" type="GdaDataComparator*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_data_comparator_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_diff" symbol="gda_data_comparator_get_diff">
				<return-type type="GdaDiff*"/>
				<parameters>
					<parameter name="comp" type="GdaDataComparator*"/>
					<parameter name="pos" type="gint"/>
				</parameters>
			</method>
			<method name="get_n_diffs" symbol="gda_data_comparator_get_n_diffs">
				<return-type type="gint"/>
				<parameters>
					<parameter name="comp" type="GdaDataComparator*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_data_comparator_new">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="old_model" type="GdaDataModel*"/>
					<parameter name="new_model" type="GdaDataModel*"/>
				</parameters>
			</constructor>
			<method name="set_key_columns" symbol="gda_data_comparator_set_key_columns">
				<return-type type="void"/>
				<parameters>
					<parameter name="comp" type="GdaDataComparator*"/>
					<parameter name="col_numbers" type="gint*"/>
					<parameter name="nb_cols" type="gint"/>
				</parameters>
			</method>
			<property name="new-model" type="GdaDataModel*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="old-model" type="GdaDataModel*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="diff-computed" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="comp" type="GdaDataComparator*"/>
					<parameter name="diff" type="gpointer"/>
				</parameters>
			</signal>
		</object>
		<object name="GdaDataModelArray" parent="GObject" type-name="GdaDataModelArray" get-type="gda_data_model_array_get_type">
			<implements>
				<interface name="GdaDataModel"/>
			</implements>
			<method name="clear" symbol="gda_data_model_array_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModelArray*"/>
				</parameters>
			</method>
			<method name="copy_model" symbol="gda_data_model_array_copy_model">
				<return-type type="GdaDataModelArray*"/>
				<parameters>
					<parameter name="src" type="GdaDataModel*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_row" symbol="gda_data_model_array_get_row">
				<return-type type="GdaRow*"/>
				<parameters>
					<parameter name="model" type="GdaDataModelArray*"/>
					<parameter name="row" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_data_model_array_new">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="cols" type="gint"/>
				</parameters>
			</constructor>
			<constructor name="new_with_g_types" symbol="gda_data_model_array_new_with_g_types">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="cols" type="gint"/>
				</parameters>
			</constructor>
			<method name="set_n_columns" symbol="gda_data_model_array_set_n_columns">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModelArray*"/>
					<parameter name="cols" type="gint"/>
				</parameters>
			</method>
			<property name="n-columns" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="read-only" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GdaDataModelDir" parent="GObject" type-name="GdaDataModelDir" get-type="gda_data_model_dir_get_type">
			<implements>
				<interface name="GdaDataModel"/>
			</implements>
			<method name="clean_errors" symbol="gda_data_model_dir_clean_errors">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModelDir*"/>
				</parameters>
			</method>
			<method name="get_errors" symbol="gda_data_model_dir_get_errors">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="model" type="GdaDataModelDir*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_data_model_dir_new">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="basedir" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="basedir" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdaDataModelImport" parent="GObject" type-name="GdaDataModelImport" get-type="gda_data_model_import_get_type">
			<implements>
				<interface name="GdaDataModel"/>
			</implements>
			<method name="clean_errors" symbol="gda_data_model_import_clean_errors">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModelImport*"/>
				</parameters>
			</method>
			<method name="from_file" symbol="gda_data_model_import_from_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="file" type="gchar*"/>
					<parameter name="cols_trans" type="GHashTable*"/>
					<parameter name="options" type="GdaSet*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="from_model" symbol="gda_data_model_import_from_model">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="to" type="GdaDataModel*"/>
					<parameter name="from" type="GdaDataModel*"/>
					<parameter name="overwrite" type="gboolean"/>
					<parameter name="cols_trans" type="GHashTable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="from_string" symbol="gda_data_model_import_from_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="string" type="gchar*"/>
					<parameter name="cols_trans" type="GHashTable*"/>
					<parameter name="options" type="GdaSet*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_errors" symbol="gda_data_model_import_get_errors">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="model" type="GdaDataModelImport*"/>
				</parameters>
			</method>
			<constructor name="new_file" symbol="gda_data_model_import_new_file">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="filename" type="gchar*"/>
					<parameter name="random_access" type="gboolean"/>
					<parameter name="options" type="GdaSet*"/>
				</parameters>
			</constructor>
			<constructor name="new_mem" symbol="gda_data_model_import_new_mem">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="data" type="gchar*"/>
					<parameter name="random_access" type="gboolean"/>
					<parameter name="options" type="GdaSet*"/>
				</parameters>
			</constructor>
			<constructor name="new_xml_node" symbol="gda_data_model_import_new_xml_node">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="node" type="xmlNodePtr"/>
				</parameters>
			</constructor>
			<property name="data-string" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="filename" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="options" type="GdaSet*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="random-access" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="strict" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="xml-node" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdaDataModelIter" parent="GdaSet" type-name="GdaDataModelIter" get-type="gda_data_model_iter_get_type">
			<method name="error_quark" symbol="gda_data_model_iter_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_holder_for_field" symbol="gda_data_model_iter_get_holder_for_field">
				<return-type type="GdaHolder*"/>
				<parameters>
					<parameter name="iter" type="GdaDataModelIter*"/>
					<parameter name="col" type="gint"/>
				</parameters>
			</method>
			<method name="get_row" symbol="gda_data_model_iter_get_row">
				<return-type type="gint"/>
				<parameters>
					<parameter name="iter" type="GdaDataModelIter*"/>
				</parameters>
			</method>
			<method name="get_value_at" symbol="gda_data_model_iter_get_value_at">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="iter" type="GdaDataModelIter*"/>
					<parameter name="col" type="gint"/>
				</parameters>
			</method>
			<method name="get_value_for_field" symbol="gda_data_model_iter_get_value_for_field">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="iter" type="GdaDataModelIter*"/>
					<parameter name="field_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="invalidate_contents" symbol="gda_data_model_iter_invalidate_contents">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="GdaDataModelIter*"/>
				</parameters>
			</method>
			<method name="is_valid" symbol="gda_data_model_iter_is_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="GdaDataModelIter*"/>
				</parameters>
			</method>
			<method name="move_next" symbol="gda_data_model_iter_move_next">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="GdaDataModelIter*"/>
				</parameters>
			</method>
			<method name="move_next_default" symbol="gda_data_model_iter_move_next_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="iter" type="GdaDataModelIter*"/>
				</parameters>
			</method>
			<method name="move_prev" symbol="gda_data_model_iter_move_prev">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="GdaDataModelIter*"/>
				</parameters>
			</method>
			<method name="move_prev_default" symbol="gda_data_model_iter_move_prev_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="iter" type="GdaDataModelIter*"/>
				</parameters>
			</method>
			<method name="move_to_row" symbol="gda_data_model_iter_move_to_row">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="GdaDataModelIter*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</method>
			<method name="move_to_row_default" symbol="gda_data_model_iter_move_to_row_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="iter" type="GdaDataModelIter*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</method>
			<method name="set_value_at" symbol="gda_data_model_iter_set_value_at">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="GdaDataModelIter*"/>
					<parameter name="col" type="gint"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="current-row" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="data-model" type="GdaDataModel*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="forced-model" type="GdaDataModel*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="update-model" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="end-of-data" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="GdaDataModelIter*"/>
				</parameters>
			</signal>
			<signal name="row-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="GdaDataModelIter*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</signal>
		</object>
		<object name="GdaDataProxy" parent="GObject" type-name="GdaDataProxy" get-type="gda_data_proxy_get_type">
			<implements>
				<interface name="GdaDataModel"/>
			</implements>
			<method name="alter_value_attributes" symbol="gda_data_proxy_alter_value_attributes">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="proxy_row" type="gint"/>
					<parameter name="col" type="gint"/>
					<parameter name="alter_flags" type="GdaValueAttribute"/>
				</parameters>
			</method>
			<method name="apply_all_changes" symbol="gda_data_proxy_apply_all_changes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="apply_row_changes" symbol="gda_data_proxy_apply_row_changes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="proxy_row" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="cancel_all_changes" symbol="gda_data_proxy_cancel_all_changes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<method name="cancel_row_changes" symbol="gda_data_proxy_cancel_row_changes">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="proxy_row" type="gint"/>
					<parameter name="col" type="gint"/>
				</parameters>
			</method>
			<method name="delete" symbol="gda_data_proxy_delete">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="proxy_row" type="gint"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_data_proxy_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_filter_expr" symbol="gda_data_proxy_get_filter_expr">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<method name="get_filtered_n_rows" symbol="gda_data_proxy_get_filtered_n_rows">
				<return-type type="gint"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<method name="get_n_modified_rows" symbol="gda_data_proxy_get_n_modified_rows">
				<return-type type="gint"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<method name="get_n_new_rows" symbol="gda_data_proxy_get_n_new_rows">
				<return-type type="gint"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<method name="get_proxied_model" symbol="gda_data_proxy_get_proxied_model">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<method name="get_proxied_model_n_cols" symbol="gda_data_proxy_get_proxied_model_n_cols">
				<return-type type="gint"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<method name="get_proxied_model_n_rows" symbol="gda_data_proxy_get_proxied_model_n_rows">
				<return-type type="gint"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<method name="get_proxied_model_row" symbol="gda_data_proxy_get_proxied_model_row">
				<return-type type="gint"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="proxy_row" type="gint"/>
				</parameters>
			</method>
			<method name="get_sample_end" symbol="gda_data_proxy_get_sample_end">
				<return-type type="gint"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<method name="get_sample_size" symbol="gda_data_proxy_get_sample_size">
				<return-type type="gint"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<method name="get_sample_start" symbol="gda_data_proxy_get_sample_start">
				<return-type type="gint"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<method name="get_value_attributes" symbol="gda_data_proxy_get_value_attributes">
				<return-type type="GdaValueAttribute"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="proxy_row" type="gint"/>
					<parameter name="col" type="gint"/>
				</parameters>
			</method>
			<method name="get_values" symbol="gda_data_proxy_get_values">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="proxy_row" type="gint"/>
					<parameter name="cols_index" type="gint*"/>
					<parameter name="n_cols" type="gint"/>
				</parameters>
			</method>
			<method name="has_changed" symbol="gda_data_proxy_has_changed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<method name="is_read_only" symbol="gda_data_proxy_is_read_only">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_data_proxy_new">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</constructor>
			<method name="row_has_changed" symbol="gda_data_proxy_row_has_changed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="proxy_row" type="gint"/>
				</parameters>
			</method>
			<method name="row_is_deleted" symbol="gda_data_proxy_row_is_deleted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="proxy_row" type="gint"/>
				</parameters>
			</method>
			<method name="row_is_inserted" symbol="gda_data_proxy_row_is_inserted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="proxy_row" type="gint"/>
				</parameters>
			</method>
			<method name="set_filter_expr" symbol="gda_data_proxy_set_filter_expr">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="filter_expr" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_ordering_column" symbol="gda_data_proxy_set_ordering_column">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="col" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_sample_size" symbol="gda_data_proxy_set_sample_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="sample_size" type="gint"/>
				</parameters>
			</method>
			<method name="set_sample_start" symbol="gda_data_proxy_set_sample_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="sample_start" type="gint"/>
				</parameters>
			</method>
			<method name="undelete" symbol="gda_data_proxy_undelete">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="proxy_row" type="gint"/>
				</parameters>
			</method>
			<property name="defer-sync" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="model" type="GdaDataModel*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="prepend-null-entry" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sample-size" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<signal name="filter-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
				</parameters>
			</signal>
			<signal name="row-changes-applied" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="row" type="gint"/>
					<parameter name="proxied_row" type="gint"/>
				</parameters>
			</signal>
			<signal name="row-delete-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="row" type="gint"/>
					<parameter name="to_be_deleted" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="sample-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="sample_start" type="gint"/>
					<parameter name="sample_end" type="gint"/>
				</parameters>
			</signal>
			<signal name="sample-size-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="sample_size" type="gint"/>
				</parameters>
			</signal>
			<signal name="validate-row-changes" when="LAST">
				<return-type type="GdaError*"/>
				<parameters>
					<parameter name="proxy" type="GdaDataProxy*"/>
					<parameter name="row" type="gint"/>
					<parameter name="proxied_row" type="gint"/>
				</parameters>
			</signal>
		</object>
		<object name="GdaDataSelect" parent="GObject" type-name="GdaDataSelect" get-type="gda_data_select_get_type">
			<implements>
				<interface name="GdaDataModel"/>
			</implements>
			<method name="compute_columns_attributes" symbol="gda_data_select_compute_columns_attributes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="compute_modification_statements" symbol="gda_data_select_compute_modification_statements">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="compute_row_selection_condition" symbol="gda_data_select_compute_row_selection_condition">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_data_select_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_connection" symbol="gda_data_select_get_connection">
				<return-type type="GdaConnection*"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
				</parameters>
			</method>
			<method name="get_stored_row" symbol="gda_data_select_get_stored_row">
				<return-type type="GdaRow*"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="rownum" type="gint"/>
				</parameters>
			</method>
			<method name="rerun" symbol="gda_data_select_rerun">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_columns" symbol="gda_data_select_set_columns">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="columns" type="GSList*"/>
				</parameters>
			</method>
			<method name="set_modification_statement" symbol="gda_data_select_set_modification_statement">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="mod_stmt" type="GdaStatement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_modification_statement_sql" symbol="gda_data_select_set_modification_statement_sql">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="sql" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_row_selection_condition" symbol="gda_data_select_set_row_selection_condition">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="expr" type="GdaSqlExpr*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_row_selection_condition_sql" symbol="gda_data_select_set_row_selection_condition_sql">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="sql_where" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="take_row" symbol="gda_data_select_take_row">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="row" type="GdaRow*"/>
					<parameter name="rownum" type="gint"/>
				</parameters>
			</method>
			<property name="auto-reset" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="connection" type="GdaConnection*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="delete-stmt" type="GdaStatement*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="exec-params" type="GdaSet*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="insert-stmt" type="GdaStatement*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="model-usage" type="guint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="prepared-stmt" type="GdaPStmt*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="select-stmt" type="GdaStatement*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="store-all-rows" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="update-stmt" type="GdaStatement*" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="fetch_at">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="prow" type="GdaRow**"/>
					<parameter name="rownum" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="fetch_nb_rows">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
				</parameters>
			</vfunc>
			<vfunc name="fetch_next">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="prow" type="GdaRow**"/>
					<parameter name="rownum" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="fetch_prev">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="prow" type="GdaRow**"/>
					<parameter name="rownum" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="fetch_random">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="prow" type="GdaRow**"/>
					<parameter name="rownum" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="store_all">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataSelect*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<field name="prep_stmt" type="GdaPStmt*"/>
			<field name="nb_stored_rows" type="gint"/>
			<field name="advertized_nrows" type="gint"/>
		</object>
		<object name="GdaHandlerBin" parent="GObject" type-name="GdaHandlerBin" get-type="gda_handler_bin_get_type">
			<implements>
				<interface name="GdaDataHandler"/>
			</implements>
			<constructor name="new" symbol="gda_handler_bin_new">
				<return-type type="GdaDataHandler*"/>
			</constructor>
		</object>
		<object name="GdaHandlerBoolean" parent="GObject" type-name="GdaHandlerBoolean" get-type="gda_handler_boolean_get_type">
			<implements>
				<interface name="GdaDataHandler"/>
			</implements>
			<constructor name="new" symbol="gda_handler_boolean_new">
				<return-type type="GdaDataHandler*"/>
			</constructor>
		</object>
		<object name="GdaHandlerNumerical" parent="GObject" type-name="GdaHandlerNumerical" get-type="gda_handler_numerical_get_type">
			<implements>
				<interface name="GdaDataHandler"/>
			</implements>
			<constructor name="new" symbol="gda_handler_numerical_new">
				<return-type type="GdaDataHandler*"/>
			</constructor>
		</object>
		<object name="GdaHandlerString" parent="GObject" type-name="GdaHandlerString" get-type="gda_handler_string_get_type">
			<implements>
				<interface name="GdaDataHandler"/>
			</implements>
			<constructor name="new" symbol="gda_handler_string_new">
				<return-type type="GdaDataHandler*"/>
			</constructor>
			<constructor name="new_with_provider" symbol="gda_handler_string_new_with_provider">
				<return-type type="GdaDataHandler*"/>
				<parameters>
					<parameter name="prov" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</constructor>
		</object>
		<object name="GdaHandlerTime" parent="GObject" type-name="GdaHandlerTime" get-type="gda_handler_time_get_type">
			<implements>
				<interface name="GdaDataHandler"/>
			</implements>
			<method name="get_format" symbol="gda_handler_time_get_format">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dh" type="GdaHandlerTime*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="get_no_locale_str_from_value" symbol="gda_handler_time_get_no_locale_str_from_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dh" type="GdaHandlerTime*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_handler_time_new">
				<return-type type="GdaDataHandler*"/>
			</constructor>
			<constructor name="new_no_locale" symbol="gda_handler_time_new_no_locale">
				<return-type type="GdaDataHandler*"/>
			</constructor>
			<method name="set_sql_spec" symbol="gda_handler_time_set_sql_spec">
				<return-type type="void"/>
				<parameters>
					<parameter name="dh" type="GdaHandlerTime*"/>
					<parameter name="first" type="GDateDMY"/>
					<parameter name="sec" type="GDateDMY"/>
					<parameter name="third" type="GDateDMY"/>
					<parameter name="separator" type="gchar"/>
					<parameter name="twodigits_years" type="gboolean"/>
				</parameters>
			</method>
		</object>
		<object name="GdaHandlerType" parent="GObject" type-name="GdaHandlerType" get-type="gda_handler_type_get_type">
			<implements>
				<interface name="GdaDataHandler"/>
			</implements>
			<constructor name="new" symbol="gda_handler_type_new">
				<return-type type="GdaDataHandler*"/>
			</constructor>
		</object>
		<object name="GdaHolder" parent="GObject" type-name="GdaHolder" get-type="gda_holder_get_type">
			<method name="copy" symbol="gda_holder_copy">
				<return-type type="GdaHolder*"/>
				<parameters>
					<parameter name="orig" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_holder_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="force_invalid" symbol="gda_holder_force_invalid">
				<return-type type="void"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="get_attribute" symbol="gda_holder_get_attribute">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="attribute" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_bind" symbol="gda_holder_get_bind">
				<return-type type="GdaHolder*"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="get_default_value" symbol="gda_holder_get_default_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="get_g_type" symbol="gda_holder_get_g_type">
				<return-type type="GType"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gda_holder_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="get_not_null" symbol="gda_holder_get_not_null">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="get_source_model" symbol="gda_holder_get_source_model">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="col" type="gint*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="gda_holder_get_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="get_value_str" symbol="gda_holder_get_value_str">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="dh" type="GdaDataHandler*"/>
				</parameters>
			</method>
			<method name="is_valid" symbol="gda_holder_is_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_holder_new">
				<return-type type="GdaHolder*"/>
				<parameters>
					<parameter name="type" type="GType"/>
				</parameters>
			</constructor>
			<constructor name="new_inline" symbol="gda_holder_new_inline">
				<return-type type="GdaHolder*"/>
				<parameters>
					<parameter name="type" type="GType"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_attribute" symbol="gda_holder_set_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="attribute" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_bind" symbol="gda_holder_set_bind">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="bind_to" type="GdaHolder*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_default_value" symbol="gda_holder_set_default_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_not_null" symbol="gda_holder_set_not_null">
				<return-type type="void"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="not_null" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_source_model" symbol="gda_holder_set_source_model">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_value" symbol="gda_holder_set_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_value_str" symbol="gda_holder_set_value_str">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_value_to_default" symbol="gda_holder_set_value_to_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="take_static_value" symbol="gda_holder_take_static_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="value_changed" type="gboolean*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="take_value" symbol="gda_holder_take_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="value_is_default" symbol="gda_holder_value_is_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<property name="description" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="full-bind" type="GdaHolder*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="g-type" type="GType" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="id" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="not-null" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="simple-bind" type="GdaHolder*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="source-column" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="source-model" type="GdaDataModel*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="attribute-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdaHolder*"/>
					<parameter name="p0" type="char*"/>
					<parameter name="p1" type="GValue*"/>
				</parameters>
			</signal>
			<signal name="changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</signal>
			<signal name="source-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</signal>
			<signal name="validate-change" when="LAST">
				<return-type type="GdaError*"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="new_value" type="GValue*"/>
				</parameters>
			</signal>
			<vfunc name="att_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="att_name" type="gchar*"/>
					<parameter name="att_value" type="GValue*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GdaMetaStore" parent="GObject" type-name="GdaMetaStore" get-type="gda_meta_store_get_type">
			<method name="create_modify_data_model" symbol="gda_meta_store_create_modify_data_model">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="table_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="declare_foreign_key" symbol="gda_meta_store_declare_foreign_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
					<parameter name="fk_name" type="gchar*"/>
					<parameter name="catalog" type="gchar*"/>
					<parameter name="schema" type="gchar*"/>
					<parameter name="table" type="gchar*"/>
					<parameter name="ref_catalog" type="gchar*"/>
					<parameter name="ref_schema" type="gchar*"/>
					<parameter name="ref_table" type="gchar*"/>
					<parameter name="nb_cols" type="guint"/>
					<parameter name="colnames" type="gchar**"/>
					<parameter name="ref_colnames" type="gchar**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_meta_store_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="extract" symbol="gda_meta_store_extract">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="select_sql" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_attribute_value" symbol="gda_meta_store_get_attribute_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="att_name" type="gchar*"/>
					<parameter name="att_value" type="gchar**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_internal_connection" symbol="gda_meta_store_get_internal_connection">
				<return-type type="GdaConnection*"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
				</parameters>
			</method>
			<method name="get_version" symbol="gda_meta_store_get_version">
				<return-type type="gint"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
				</parameters>
			</method>
			<method name="modify" symbol="gda_meta_store_modify">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="table_name" type="gchar*"/>
					<parameter name="new_data" type="GdaDataModel*"/>
					<parameter name="condition" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="modify_with_context" symbol="gda_meta_store_modify_with_context">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="context" type="GdaMetaContext*"/>
					<parameter name="new_data" type="GdaDataModel*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_meta_store_new">
				<return-type type="GdaMetaStore*"/>
				<parameters>
					<parameter name="cnc_string" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_file" symbol="gda_meta_store_new_with_file">
				<return-type type="GdaMetaStore*"/>
				<parameters>
					<parameter name="file_name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="schema_add_custom_object" symbol="gda_meta_store_schema_add_custom_object">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="xml_description" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="schema_get_all_tables" symbol="gda_meta_store_schema_get_all_tables">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
				</parameters>
			</method>
			<method name="schema_get_depend_tables" symbol="gda_meta_store_schema_get_depend_tables">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="table_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="schema_get_structure" symbol="gda_meta_store_schema_get_structure">
				<return-type type="GdaMetaStruct*"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="schema_remove_custom_object" symbol="gda_meta_store_schema_remove_custom_object">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="obj_name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_value" symbol="gda_meta_store_set_attribute_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="att_name" type="gchar*"/>
					<parameter name="att_value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_identifiers_style" symbol="gda_meta_store_set_identifiers_style">
				<return-type type="void"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="style" type="GdaSqlIdentifierStyle"/>
				</parameters>
			</method>
			<method name="set_reserved_keywords_func" symbol="gda_meta_store_set_reserved_keywords_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="func" type="GdaSqlReservedKeywordsFunc"/>
				</parameters>
			</method>
			<method name="sql_identifier_quote" symbol="gda_meta_store_sql_identifier_quote">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="undeclare_foreign_key" symbol="gda_meta_store_undeclare_foreign_key">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
					<parameter name="fk_name" type="gchar*"/>
					<parameter name="catalog" type="gchar*"/>
					<parameter name="schema" type="gchar*"/>
					<parameter name="table" type="gchar*"/>
					<parameter name="ref_catalog" type="gchar*"/>
					<parameter name="ref_schema" type="gchar*"/>
					<parameter name="ref_table" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="catalog" type="char*" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="cnc" type="GdaConnection*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="cnc-string" type="char*" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="schema" type="char*" readable="0" writable="1" construct="0" construct-only="1"/>
			<signal name="meta-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="changes" type="GdaSList"/>
				</parameters>
			</signal>
			<signal name="meta-reset" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
				</parameters>
			</signal>
			<signal name="suggest-update" when="LAST">
				<return-type type="GdaError*"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="suggest" type="GdaMetaContext"/>
				</parameters>
			</signal>
		</object>
		<object name="GdaMetaStruct" parent="GObject" type-name="GdaMetaStruct" get-type="gda_meta_struct_get_type">
			<method name="complement" symbol="gda_meta_struct_complement">
				<return-type type="GdaMetaDbObject*"/>
				<parameters>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
					<parameter name="type" type="GdaMetaDbObjectType"/>
					<parameter name="catalog" type="GValue*"/>
					<parameter name="schema" type="GValue*"/>
					<parameter name="name" type="GValue*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="complement_all" symbol="gda_meta_struct_complement_all">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="complement_default" symbol="gda_meta_struct_complement_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="complement_depend" symbol="gda_meta_struct_complement_depend">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
					<parameter name="dbo" type="GdaMetaDbObject*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="complement_schema" symbol="gda_meta_struct_complement_schema">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
					<parameter name="catalog" type="GValue*"/>
					<parameter name="schema" type="GValue*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="dump_as_graph" symbol="gda_meta_struct_dump_as_graph">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
					<parameter name="info" type="GdaMetaGraphInfo"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_meta_struct_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_all_db_objects" symbol="gda_meta_struct_get_all_db_objects">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
				</parameters>
			</method>
			<method name="get_db_object" symbol="gda_meta_struct_get_db_object">
				<return-type type="GdaMetaDbObject*"/>
				<parameters>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
					<parameter name="catalog" type="GValue*"/>
					<parameter name="schema" type="GValue*"/>
					<parameter name="name" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_table_column" symbol="gda_meta_struct_get_table_column">
				<return-type type="GdaMetaTableColumn*"/>
				<parameters>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
					<parameter name="table" type="GdaMetaTable*"/>
					<parameter name="col_name" type="GValue*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_meta_struct_new">
				<return-type type="GdaMetaStruct*"/>
				<parameters>
					<parameter name="store" type="GdaMetaStore*"/>
					<parameter name="features" type="GdaMetaStructFeature"/>
				</parameters>
			</constructor>
			<method name="sort_db_objects" symbol="gda_meta_struct_sort_db_objects">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="mstruct" type="GdaMetaStruct*"/>
					<parameter name="sort_type" type="GdaMetaSortType"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="features" type="guint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="meta-store" type="GdaMetaStore*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdaPStmt" parent="GObject" type-name="GdaPStmt" get-type="gda_pstmt_get_type">
			<method name="copy_contents" symbol="gda_pstmt_copy_contents">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GdaPStmt*"/>
					<parameter name="dest" type="GdaPStmt*"/>
				</parameters>
			</method>
			<method name="get_gda_statement" symbol="gda_pstmt_get_gda_statement">
				<return-type type="GdaStatement*"/>
				<parameters>
					<parameter name="pstmt" type="GdaPStmt*"/>
				</parameters>
			</method>
			<method name="set_gda_statement" symbol="gda_pstmt_set_gda_statement">
				<return-type type="void"/>
				<parameters>
					<parameter name="pstmt" type="GdaPStmt*"/>
					<parameter name="stmt" type="GdaStatement*"/>
				</parameters>
			</method>
			<field name="sql" type="gchar*"/>
			<field name="param_ids" type="GSList*"/>
			<field name="ncols" type="gint"/>
			<field name="types" type="GType*"/>
			<field name="tmpl_columns" type="GSList*"/>
		</object>
		<object name="GdaRepetitiveStatement" parent="GObject" type-name="GdaRepetitiveStatement" get-type="gda_repetitive_statement_get_type">
			<method name="append_set" symbol="gda_repetitive_statement_append_set">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="rstmt" type="GdaRepetitiveStatement*"/>
					<parameter name="values" type="GdaSet*"/>
					<parameter name="make_copy" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_all_sets" symbol="gda_repetitive_statement_get_all_sets">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="rstmt" type="GdaRepetitiveStatement*"/>
				</parameters>
			</method>
			<method name="get_template_set" symbol="gda_repetitive_statement_get_template_set">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="rstmt" type="GdaRepetitiveStatement*"/>
					<parameter name="set" type="GdaSet**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_repetitive_statement_new">
				<return-type type="GdaRepetitiveStatement*"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
				</parameters>
			</constructor>
			<property name="statement" type="GdaStatement*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdaRow" parent="GObject" type-name="GdaRow" get-type="gda_row_get_type">
			<method name="get_length" symbol="gda_row_get_length">
				<return-type type="gint"/>
				<parameters>
					<parameter name="row" type="GdaRow*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="gda_row_get_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="row" type="GdaRow*"/>
					<parameter name="num" type="gint"/>
				</parameters>
			</method>
			<method name="invalidate_value" symbol="gda_row_invalidate_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="row" type="GdaRow*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_row_new">
				<return-type type="GdaRow*"/>
				<parameters>
					<parameter name="count" type="gint"/>
				</parameters>
			</constructor>
			<method name="value_is_valid" symbol="gda_row_value_is_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="row" type="GdaRow*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<property name="nb-values" type="gint" readable="0" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GdaServerOperation" parent="GObject" type-name="GdaServerOperation" get-type="gda_server_operation_get_type">
			<method name="add_item_to_sequence" symbol="gda_server_operation_add_item_to_sequence">
				<return-type type="guint"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="seq_path" type="gchar*"/>
				</parameters>
			</method>
			<method name="del_item_from_sequence" symbol="gda_server_operation_del_item_from_sequence">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="item_path" type="gchar*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_server_operation_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_node_info" symbol="gda_server_operation_get_node_info">
				<return-type type="GdaServerOperationNode*"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="path_format" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_node_parent" symbol="gda_server_operation_get_node_parent">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_node_path_portion" symbol="gda_server_operation_get_node_path_portion">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_node_type" symbol="gda_server_operation_get_node_type">
				<return-type type="GdaServerOperationNodeType"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="path" type="gchar*"/>
					<parameter name="status" type="GdaServerOperationNodeStatus*"/>
				</parameters>
			</method>
			<method name="get_op_type" symbol="gda_server_operation_get_op_type">
				<return-type type="GdaServerOperationType"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
				</parameters>
			</method>
			<method name="get_root_nodes" symbol="gda_server_operation_get_root_nodes">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
				</parameters>
			</method>
			<method name="get_sequence_item_names" symbol="gda_server_operation_get_sequence_item_names">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_sequence_max_size" symbol="gda_server_operation_get_sequence_max_size">
				<return-type type="guint"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_sequence_min_size" symbol="gda_server_operation_get_sequence_min_size">
				<return-type type="guint"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_sequence_name" symbol="gda_server_operation_get_sequence_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_sequence_size" symbol="gda_server_operation_get_sequence_size">
				<return-type type="guint"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_sql_identifier_at" symbol="gda_server_operation_get_sql_identifier_at">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="prov" type="GdaServerProvider*"/>
					<parameter name="path_format" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_value_at" symbol="gda_server_operation_get_value_at">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="path_format" type="gchar*"/>
				</parameters>
			</method>
			<method name="is_valid" symbol="gda_server_operation_is_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="xml_file" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="load_data_from_xml" symbol="gda_server_operation_load_data_from_xml">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="node" type="xmlNodePtr"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_server_operation_new">
				<return-type type="GdaServerOperation*"/>
				<parameters>
					<parameter name="op_type" type="GdaServerOperationType"/>
					<parameter name="xml_file" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="op_type_to_string" symbol="gda_server_operation_op_type_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="type" type="GdaServerOperationType"/>
				</parameters>
			</method>
			<method name="perform_create_database" symbol="gda_server_operation_perform_create_database">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="provider" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="perform_create_table" symbol="gda_server_operation_perform_create_table">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="perform_drop_database" symbol="gda_server_operation_perform_drop_database">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="provider" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="perform_drop_table" symbol="gda_server_operation_perform_drop_table">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="prepare_create_database" symbol="gda_server_operation_prepare_create_database">
				<return-type type="GdaServerOperation*"/>
				<parameters>
					<parameter name="provider" type="gchar*"/>
					<parameter name="db_name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="prepare_create_table" symbol="gda_server_operation_prepare_create_table">
				<return-type type="GdaServerOperation*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="table_name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="prepare_drop_database" symbol="gda_server_operation_prepare_drop_database">
				<return-type type="GdaServerOperation*"/>
				<parameters>
					<parameter name="provider" type="gchar*"/>
					<parameter name="db_name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="prepare_drop_table" symbol="gda_server_operation_prepare_drop_table">
				<return-type type="GdaServerOperation*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="table_name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="save_data_to_xml" symbol="gda_server_operation_save_data_to_xml">
				<return-type type="xmlNodePtr"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_value_at" symbol="gda_server_operation_set_value_at">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="value" type="gchar*"/>
					<parameter name="error" type="GError**"/>
					<parameter name="path_format" type="gchar*"/>
				</parameters>
			</method>
			<method name="string_to_op_type" symbol="gda_server_operation_string_to_op_type">
				<return-type type="GdaServerOperationType"/>
				<parameters>
					<parameter name="str" type="gchar*"/>
				</parameters>
			</method>
			<property name="connection" type="GdaConnection*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="op-type" type="gint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="provider" type="GdaServerProvider*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="spec-filename" type="char*" readable="0" writable="1" construct="0" construct-only="1"/>
			<signal name="sequence-item-added" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdaServerOperation*"/>
					<parameter name="p0" type="char*"/>
					<parameter name="p1" type="gint"/>
				</parameters>
			</signal>
			<signal name="sequence-item-remove" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="GdaServerOperation*"/>
					<parameter name="p0" type="char*"/>
					<parameter name="p1" type="gint"/>
				</parameters>
			</signal>
			<vfunc name="seq_item_added">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="seq_path" type="gchar*"/>
					<parameter name="item_index" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="seq_item_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="seq_path" type="gchar*"/>
					<parameter name="item_index" type="gint"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GdaServerProvider" parent="GObject" type-name="GdaServerProvider" get-type="gda_server_provider_get_type">
			<method name="create_operation" symbol="gda_server_provider_create_operation">
				<return-type type="GdaServerOperation*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="type" type="GdaServerOperationType"/>
					<parameter name="options" type="GdaSet*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_parser" symbol="gda_server_provider_create_parser">
				<return-type type="GdaSqlParser*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_server_provider_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="escape_string" symbol="gda_server_provider_escape_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="str" type="gchar*"/>
				</parameters>
			</method>
			<method name="find_file" symbol="gda_server_provider_find_file">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="prov" type="GdaServerProvider*"/>
					<parameter name="inst_dir" type="gchar*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_data_handler_dbms" symbol="gda_server_provider_get_data_handler_dbms">
				<return-type type="GdaDataHandler*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="for_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_data_handler_default" symbol="gda_server_provider_get_data_handler_default">
				<return-type type="GdaDataHandler*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="type" type="GType"/>
					<parameter name="dbms_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_data_handler_g_type" symbol="gda_server_provider_get_data_handler_g_type">
				<return-type type="GdaDataHandler*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="for_type" type="GType"/>
				</parameters>
			</method>
			<method name="get_default_dbms_type" symbol="gda_server_provider_get_default_dbms_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gda_server_provider_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
				</parameters>
			</method>
			<method name="get_schema_nb_columns" symbol="gda_server_provider_get_schema_nb_columns">
				<return-type type="gint"/>
				<parameters>
					<parameter name="schema" type="GdaConnectionSchema"/>
				</parameters>
			</method>
			<method name="get_server_version" symbol="gda_server_provider_get_server_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<method name="get_version" symbol="gda_server_provider_get_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
				</parameters>
			</method>
			<method name="handler_declare" symbol="gda_server_provider_handler_declare">
				<return-type type="void"/>
				<parameters>
					<parameter name="prov" type="GdaServerProvider*"/>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="g_type" type="GType"/>
					<parameter name="dbms_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="handler_find" symbol="gda_server_provider_handler_find">
				<return-type type="GdaDataHandler*"/>
				<parameters>
					<parameter name="prov" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="g_type" type="GType"/>
					<parameter name="dbms_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="init_schema_model" symbol="gda_server_provider_init_schema_model">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="schema" type="GdaConnectionSchema"/>
				</parameters>
			</method>
			<method name="internal_get_parser" symbol="gda_server_provider_internal_get_parser">
				<return-type type="GdaSqlParser*"/>
				<parameters>
					<parameter name="prov" type="GdaServerProvider*"/>
				</parameters>
			</method>
			<method name="load_file_contents" symbol="gda_server_provider_load_file_contents">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="inst_dir" type="gchar*"/>
					<parameter name="data_dir" type="gchar*"/>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</method>
			<method name="perform_operation" symbol="gda_server_provider_perform_operation">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="perform_operation_default" symbol="gda_server_provider_perform_operation_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="render_operation" symbol="gda_server_provider_render_operation">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="string_to_value" symbol="gda_server_provider_string_to_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="string" type="gchar*"/>
					<parameter name="preferred_type" type="GType"/>
					<parameter name="dbms_type" type="gchar**"/>
				</parameters>
			</method>
			<method name="supports_feature" symbol="gda_server_provider_supports_feature">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="feature" type="GdaConnectionFeature"/>
				</parameters>
			</method>
			<method name="supports_operation" symbol="gda_server_provider_supports_operation">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="type" type="GdaServerOperationType"/>
					<parameter name="options" type="GdaSet*"/>
				</parameters>
			</method>
			<method name="test_schema_model" symbol="gda_server_provider_test_schema_model">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="schema" type="GdaConnectionSchema"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="unescape_string" symbol="gda_server_provider_unescape_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="str" type="gchar*"/>
				</parameters>
			</method>
			<method name="value_to_sql_string" symbol="gda_server_provider_value_to_sql_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="from" type="GValue*"/>
				</parameters>
			</method>
			<vfunc name="add_savepoint">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="begin_transaction">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="level" type="GdaTransactionIsolation"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="cancel">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="task_id" type="guint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="close_connection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</vfunc>
			<vfunc name="commit_transaction">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="create_connection">
				<return-type type="GdaConnection*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
				</parameters>
			</vfunc>
			<vfunc name="create_operation">
				<return-type type="GdaServerOperation*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="type" type="GdaServerOperationType"/>
					<parameter name="options" type="GdaSet*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="create_parser">
				<return-type type="GdaSqlParser*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</vfunc>
			<vfunc name="delete_savepoint">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="escape_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="str" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_data_handler">
				<return-type type="GdaDataHandler*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="g_type" type="GType"/>
					<parameter name="dbms_type" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_database">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_def_dbms_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="g_type" type="GType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_server_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
				</parameters>
			</vfunc>
			<vfunc name="handle_async">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="identifier_quote">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="id" type="gchar*"/>
					<parameter name="for_meta_store" type="gboolean"/>
					<parameter name="force_quotes" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="is_busy">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="open_connection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="params" type="GdaQuarkList*"/>
					<parameter name="auth" type="GdaQuarkList*"/>
					<parameter name="task_id" type="guint*"/>
					<parameter name="async_cb" type="GdaServerProviderAsyncCallback"/>
					<parameter name="cb_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="perform_operation">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="task_id" type="guint*"/>
					<parameter name="async_cb" type="GdaServerProviderAsyncCallback"/>
					<parameter name="cb_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="render_operation">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="op" type="GdaServerOperation*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="rollback_savepoint">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="rollback_transaction">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="statement_execute">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="model_usage" type="GdaStatementModelUsage"/>
					<parameter name="col_types" type="GType*"/>
					<parameter name="last_inserted_row" type="GdaSet**"/>
					<parameter name="task_id" type="guint*"/>
					<parameter name="exec_cb" type="GdaServerProviderExecCallback"/>
					<parameter name="cb_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="statement_prepare">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="statement_rewrite">
				<return-type type="GdaSqlStatement*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="statement_to_sql">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="flags" type="GdaStatementSqlFlag"/>
					<parameter name="params_used" type="GSList**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="supports_feature">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="feature" type="GdaConnectionFeature"/>
				</parameters>
			</vfunc>
			<vfunc name="supports_operation">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="type" type="GdaServerOperationType"/>
					<parameter name="options" type="GdaSet*"/>
				</parameters>
			</vfunc>
			<vfunc name="unescape_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="provider" type="GdaServerProvider*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="str" type="gchar*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GdaSet" parent="GObject" type-name="GdaSet" get-type="gda_set_get_type">
			<method name="add_holder" symbol="gda_set_add_holder">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="copy" symbol="gda_set_copy">
				<return-type type="GdaSet*"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_set_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_group" symbol="gda_set_get_group">
				<return-type type="GdaSetGroup*"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="get_holder" symbol="gda_set_get_holder">
				<return-type type="GdaHolder*"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="holder_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_holder_value" symbol="gda_set_get_holder_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="holder_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_node" symbol="gda_set_get_node">
				<return-type type="GdaSetNode*"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="get_nth_holder" symbol="gda_set_get_nth_holder">
				<return-type type="GdaHolder*"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="pos" type="gint"/>
				</parameters>
			</method>
			<method name="get_source" symbol="gda_set_get_source">
				<return-type type="GdaSetSource*"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="get_source_for_model" symbol="gda_set_get_source_for_model">
				<return-type type="GdaSetSource*"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</method>
			<method name="is_valid" symbol="gda_set_is_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="merge_with_set" symbol="gda_set_merge_with_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="set_to_merge" type="GdaSet*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_set_new">
				<return-type type="GdaSet*"/>
				<parameters>
					<parameter name="holders" type="GSList*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_spec_node" symbol="gda_set_new_from_spec_node">
				<return-type type="GdaSet*"/>
				<parameters>
					<parameter name="xml_spec" type="xmlNodePtr"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_spec_string" symbol="gda_set_new_from_spec_string">
				<return-type type="GdaSet*"/>
				<parameters>
					<parameter name="xml_spec" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_inline" symbol="gda_set_new_inline">
				<return-type type="GdaSet*"/>
				<parameters>
					<parameter name="nb" type="gint"/>
				</parameters>
			</constructor>
			<constructor name="new_read_only" symbol="gda_set_new_read_only">
				<return-type type="GdaSet*"/>
				<parameters>
					<parameter name="holders" type="GSList*"/>
				</parameters>
			</constructor>
			<method name="remove_holder" symbol="gda_set_remove_holder">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</method>
			<method name="replace_source_model" symbol="gda_set_replace_source_model">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="source" type="GdaSetSource*"/>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</method>
			<method name="set_holder_value" symbol="gda_set_set_holder_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="error" type="GError**"/>
					<parameter name="holder_id" type="gchar*"/>
				</parameters>
			</method>
			<property name="description" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="holders" type="gpointer" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="id" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="holder-attr-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="attr_name" type="char*"/>
					<parameter name="attr_value" type="GValue*"/>
				</parameters>
			</signal>
			<signal name="holder-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</signal>
			<signal name="holder-type-set" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="holder" type="GdaHolder*"/>
				</parameters>
			</signal>
			<signal name="public-data-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
				</parameters>
			</signal>
			<signal name="source-model-changed" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="source" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="validate-holder-change" when="LAST">
				<return-type type="GdaError*"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
					<parameter name="holder" type="GdaHolder*"/>
					<parameter name="new_value" type="GValue*"/>
				</parameters>
			</signal>
			<signal name="validate-set" when="LAST">
				<return-type type="GdaError*"/>
				<parameters>
					<parameter name="set" type="GdaSet*"/>
				</parameters>
			</signal>
			<field name="holders" type="GSList*"/>
			<field name="nodes_list" type="GSList*"/>
			<field name="sources_list" type="GSList*"/>
			<field name="groups_list" type="GSList*"/>
		</object>
		<object name="GdaSqlBuilder" parent="GObject" type-name="GdaSqlBuilder" get-type="gda_sql_builder_get_type">
			<method name="add_case" symbol="gda_sql_builder_add_case">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="test_expr" type="GdaSqlBuilderId"/>
					<parameter name="else_expr" type="GdaSqlBuilderId"/>
				</parameters>
			</method>
			<method name="add_case_v" symbol="gda_sql_builder_add_case_v">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="test_expr" type="GdaSqlBuilderId"/>
					<parameter name="else_expr" type="GdaSqlBuilderId"/>
					<parameter name="when_array" type="GdaSqlBuilderId*"/>
					<parameter name="then_array" type="GdaSqlBuilderId*"/>
					<parameter name="args_size" type="gint"/>
				</parameters>
			</method>
			<method name="add_cond" symbol="gda_sql_builder_add_cond">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="op" type="GdaSqlOperatorType"/>
					<parameter name="op1" type="GdaSqlBuilderId"/>
					<parameter name="op2" type="GdaSqlBuilderId"/>
					<parameter name="op3" type="GdaSqlBuilderId"/>
				</parameters>
			</method>
			<method name="add_cond_v" symbol="gda_sql_builder_add_cond_v">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="op" type="GdaSqlOperatorType"/>
					<parameter name="op_ids" type="GdaSqlBuilderId*"/>
					<parameter name="op_ids_size" type="gint"/>
				</parameters>
			</method>
			<method name="add_expr" symbol="gda_sql_builder_add_expr">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="add_expr_value" symbol="gda_sql_builder_add_expr_value">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="add_field_id" symbol="gda_sql_builder_add_field_id">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="field_name" type="gchar*"/>
					<parameter name="table_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_field_value" symbol="gda_sql_builder_add_field_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="field_name" type="gchar*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="add_field_value_as_gvalue" symbol="gda_sql_builder_add_field_value_as_gvalue">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="field_name" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="add_field_value_id" symbol="gda_sql_builder_add_field_value_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="field_id" type="GdaSqlBuilderId"/>
					<parameter name="value_id" type="GdaSqlBuilderId"/>
				</parameters>
			</method>
			<method name="add_function" symbol="gda_sql_builder_add_function">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="func_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_function_v" symbol="gda_sql_builder_add_function_v">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="func_name" type="gchar*"/>
					<parameter name="args" type="GdaSqlBuilderId*"/>
					<parameter name="args_size" type="gint"/>
				</parameters>
			</method>
			<method name="add_id" symbol="gda_sql_builder_add_id">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="string" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_param" symbol="gda_sql_builder_add_param">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="param_name" type="gchar*"/>
					<parameter name="type" type="GType"/>
					<parameter name="nullok" type="gboolean"/>
				</parameters>
			</method>
			<method name="add_sub_select" symbol="gda_sql_builder_add_sub_select">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="sqlst" type="GdaSqlStatement*"/>
				</parameters>
			</method>
			<method name="compound_add_sub_select" symbol="gda_sql_builder_compound_add_sub_select">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="sqlst" type="GdaSqlStatement*"/>
				</parameters>
			</method>
			<method name="compound_set_type" symbol="gda_sql_builder_compound_set_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="compound_type" type="GdaSqlStatementCompoundType"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_sql_builder_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="export_expression" symbol="gda_sql_builder_export_expression">
				<return-type type="GdaSqlExpr*"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="id" type="GdaSqlBuilderId"/>
				</parameters>
			</method>
			<method name="get_sql_statement" symbol="gda_sql_builder_get_sql_statement">
				<return-type type="GdaSqlStatement*"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
				</parameters>
			</method>
			<method name="get_statement" symbol="gda_sql_builder_get_statement">
				<return-type type="GdaStatement*"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="import_expression" symbol="gda_sql_builder_import_expression">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="expr" type="GdaSqlExpr*"/>
				</parameters>
			</method>
			<method name="join_add_field" symbol="gda_sql_builder_join_add_field">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="join_id" type="GdaSqlBuilderId"/>
					<parameter name="field_name" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_sql_builder_new">
				<return-type type="GdaSqlBuilder*"/>
				<parameters>
					<parameter name="stmt_type" type="GdaSqlStatementType"/>
				</parameters>
			</constructor>
			<method name="select_add_field" symbol="gda_sql_builder_select_add_field">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="field_name" type="gchar*"/>
					<parameter name="table_name" type="gchar*"/>
					<parameter name="alias" type="gchar*"/>
				</parameters>
			</method>
			<method name="select_add_target" symbol="gda_sql_builder_select_add_target">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="table_name" type="gchar*"/>
					<parameter name="alias" type="gchar*"/>
				</parameters>
			</method>
			<method name="select_add_target_id" symbol="gda_sql_builder_select_add_target_id">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="table_id" type="GdaSqlBuilderId"/>
					<parameter name="alias" type="gchar*"/>
				</parameters>
			</method>
			<method name="select_group_by" symbol="gda_sql_builder_select_group_by">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="expr_id" type="GdaSqlBuilderId"/>
				</parameters>
			</method>
			<method name="select_join_targets" symbol="gda_sql_builder_select_join_targets">
				<return-type type="GdaSqlBuilderId"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="left_target_id" type="GdaSqlBuilderId"/>
					<parameter name="right_target_id" type="GdaSqlBuilderId"/>
					<parameter name="join_type" type="GdaSqlSelectJoinType"/>
					<parameter name="join_expr" type="GdaSqlBuilderId"/>
				</parameters>
			</method>
			<method name="select_order_by" symbol="gda_sql_builder_select_order_by">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="expr_id" type="GdaSqlBuilderId"/>
					<parameter name="asc" type="gboolean"/>
					<parameter name="collation_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="select_set_distinct" symbol="gda_sql_builder_select_set_distinct">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="distinct" type="gboolean"/>
					<parameter name="expr_id" type="GdaSqlBuilderId"/>
				</parameters>
			</method>
			<method name="select_set_having" symbol="gda_sql_builder_select_set_having">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="cond_id" type="GdaSqlBuilderId"/>
				</parameters>
			</method>
			<method name="select_set_limit" symbol="gda_sql_builder_select_set_limit">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="limit_count_expr_id" type="GdaSqlBuilderId"/>
					<parameter name="limit_offset_expr_id" type="GdaSqlBuilderId"/>
				</parameters>
			</method>
			<method name="set_table" symbol="gda_sql_builder_set_table">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="table_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_where" symbol="gda_sql_builder_set_where">
				<return-type type="void"/>
				<parameters>
					<parameter name="builder" type="GdaSqlBuilder*"/>
					<parameter name="cond_id" type="GdaSqlBuilderId"/>
				</parameters>
			</method>
			<property name="stmt-type" type="GdaSqlStatementType" readable="0" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdaSqlParser" parent="GObject" type-name="GdaSqlParser" get-type="gda_sql_parser_get_type">
			<implements>
				<interface name="GdaLockable"/>
			</implements>
			<method name="error_quark" symbol="gda_sql_parser_error_quark">
				<return-type type="GQuark"/>
			</method>
			<constructor name="new" symbol="gda_sql_parser_new">
				<return-type type="GdaSqlParser*"/>
			</constructor>
			<method name="parse_file_as_batch" symbol="gda_sql_parser_parse_file_as_batch">
				<return-type type="GdaBatch*"/>
				<parameters>
					<parameter name="parser" type="GdaSqlParser*"/>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="parse_string" symbol="gda_sql_parser_parse_string">
				<return-type type="GdaStatement*"/>
				<parameters>
					<parameter name="parser" type="GdaSqlParser*"/>
					<parameter name="sql" type="gchar*"/>
					<parameter name="remain" type="gchar**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="parse_string_as_batch" symbol="gda_sql_parser_parse_string_as_batch">
				<return-type type="GdaBatch*"/>
				<parameters>
					<parameter name="parser" type="GdaSqlParser*"/>
					<parameter name="sql" type="gchar*"/>
					<parameter name="remain" type="gchar**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_overflow_error" symbol="gda_sql_parser_set_overflow_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="GdaSqlParser*"/>
				</parameters>
			</method>
			<method name="set_syntax_error" symbol="gda_sql_parser_set_syntax_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="GdaSqlParser*"/>
				</parameters>
			</method>
			<property name="column-error" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="line-error" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="mode" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="tokenizer-flavour" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="delim_alloc">
				<return-type type="void*"/>
				<parameters>
					<parameter name="p1" type="GCallback"/>
				</parameters>
			</vfunc>
			<vfunc name="delim_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="p1" type="void*"/>
					<parameter name="p2" type="GCallback"/>
				</parameters>
			</vfunc>
			<vfunc name="delim_parse">
				<return-type type="void"/>
				<parameters>
					<parameter name="p1" type="void*"/>
					<parameter name="p2" type="int"/>
					<parameter name="p3" type="GValue*"/>
					<parameter name="p4" type="GdaSqlParserIface*"/>
				</parameters>
			</vfunc>
			<vfunc name="delim_trace">
				<return-type type="void"/>
				<parameters>
					<parameter name="p1" type="void*"/>
					<parameter name="p2" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="parser_alloc">
				<return-type type="void*"/>
				<parameters>
					<parameter name="p1" type="GCallback"/>
				</parameters>
			</vfunc>
			<vfunc name="parser_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="p1" type="void*"/>
					<parameter name="p2" type="GCallback"/>
				</parameters>
			</vfunc>
			<vfunc name="parser_parse">
				<return-type type="void"/>
				<parameters>
					<parameter name="p1" type="void*"/>
					<parameter name="p2" type="int"/>
					<parameter name="p3" type="GValue*"/>
					<parameter name="p4" type="GdaSqlParserIface*"/>
				</parameters>
			</vfunc>
			<vfunc name="parser_trace">
				<return-type type="void"/>
				<parameters>
					<parameter name="p1" type="void*"/>
					<parameter name="p2" type="char*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GdaSqliteProvider" parent="GdaServerProvider" type-name="GdaSqliteProvider" get-type="gda_sqlite_provider_get_type">
		</object>
		<object name="GdaStatement" parent="GObject" type-name="GdaStatement" get-type="gda_statement_get_type">
			<method name="check_structure" symbol="gda_statement_check_structure">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="check_validity" symbol="gda_statement_check_validity">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="copy" symbol="gda_statement_copy">
				<return-type type="GdaStatement*"/>
				<parameters>
					<parameter name="orig" type="GdaStatement*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_statement_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_parameters" symbol="gda_statement_get_parameters">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="out_params" type="GdaSet**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_statement_type" symbol="gda_statement_get_statement_type">
				<return-type type="GdaSqlStatementType"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
				</parameters>
			</method>
			<method name="is_useless" symbol="gda_statement_is_useless">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_statement_new">
				<return-type type="GdaStatement*"/>
			</constructor>
			<method name="normalize" symbol="gda_statement_normalize">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="rewrite_for_default_values" symbol="gda_statement_rewrite_for_default_values">
				<return-type type="GdaSqlStatement*"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="remove" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="serialize" symbol="gda_statement_serialize">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
				</parameters>
			</method>
			<method name="to_sql_extended" symbol="gda_statement_to_sql_extended">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="params" type="GdaSet*"/>
					<parameter name="flags" type="GdaStatementSqlFlag"/>
					<parameter name="params_used" type="GSList**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="to_sql_real" symbol="gda_statement_to_sql_real">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="context" type="GdaSqlRenderingContext*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="structure" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="checked" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="checked" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="reset" when="FIRST">
				<return-type type="void"/>
				<parameters>
					<parameter name="stmt" type="GdaStatement*"/>
				</parameters>
			</signal>
		</object>
		<object name="GdaThreadWrapper" parent="GObject" type-name="GdaThreadWrapper" get-type="gda_thread_wrapper_get_type">
			<method name="cancel" symbol="gda_thread_wrapper_cancel">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="wrapper" type="GdaThreadWrapper*"/>
					<parameter name="id" type="guint"/>
				</parameters>
			</method>
			<method name="connect_raw" symbol="gda_thread_wrapper_connect_raw">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="wrapper" type="GdaThreadWrapper*"/>
					<parameter name="instance" type="gpointer"/>
					<parameter name="sig_name" type="gchar*"/>
					<parameter name="private_thread" type="gboolean"/>
					<parameter name="private_job" type="gboolean"/>
					<parameter name="callback" type="GdaThreadWrapperCallback"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="disconnect" symbol="gda_thread_wrapper_disconnect">
				<return-type type="void"/>
				<parameters>
					<parameter name="wrapper" type="GdaThreadWrapper*"/>
					<parameter name="id" type="gulong"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_thread_wrapper_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="execute" symbol="gda_thread_wrapper_execute">
				<return-type type="guint"/>
				<parameters>
					<parameter name="wrapper" type="GdaThreadWrapper*"/>
					<parameter name="func" type="GdaThreadWrapperFunc"/>
					<parameter name="arg" type="gpointer"/>
					<parameter name="arg_destroy_func" type="GDestroyNotify"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="execute_void" symbol="gda_thread_wrapper_execute_void">
				<return-type type="guint"/>
				<parameters>
					<parameter name="wrapper" type="GdaThreadWrapper*"/>
					<parameter name="func" type="GdaThreadWrapperVoidFunc"/>
					<parameter name="arg" type="gpointer"/>
					<parameter name="arg_destroy_func" type="GDestroyNotify"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="fetch_result" symbol="gda_thread_wrapper_fetch_result">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="wrapper" type="GdaThreadWrapper*"/>
					<parameter name="may_lock" type="gboolean"/>
					<parameter name="exp_id" type="guint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_waiting_size" symbol="gda_thread_wrapper_get_waiting_size">
				<return-type type="gint"/>
				<parameters>
					<parameter name="wrapper" type="GdaThreadWrapper*"/>
				</parameters>
			</method>
			<method name="iterate" symbol="gda_thread_wrapper_iterate">
				<return-type type="void"/>
				<parameters>
					<parameter name="wrapper" type="GdaThreadWrapper*"/>
					<parameter name="may_block" type="gboolean"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_thread_wrapper_new">
				<return-type type="GdaThreadWrapper*"/>
			</constructor>
			<method name="steal_signal" symbol="gda_thread_wrapper_steal_signal">
				<return-type type="void"/>
				<parameters>
					<parameter name="wrapper" type="GdaThreadWrapper*"/>
					<parameter name="id" type="gulong"/>
				</parameters>
			</method>
		</object>
		<object name="GdaTransactionStatus" parent="GObject" type-name="GdaTransactionStatus" get-type="gda_transaction_status_get_type">
			<constructor name="new" symbol="gda_transaction_status_new">
				<return-type type="GdaTransactionStatus*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<field name="name" type="gchar*"/>
			<field name="isolation_level" type="GdaTransactionIsolation"/>
			<field name="state" type="GdaTransactionStatusState"/>
			<field name="events" type="GList*"/>
		</object>
		<object name="GdaTree" parent="GObject" type-name="GdaTree" get-type="gda_tree_get_type">
			<method name="add_manager" symbol="gda_tree_add_manager">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="manager" type="GdaTreeManager*"/>
				</parameters>
			</method>
			<method name="clean" symbol="gda_tree_clean">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
				</parameters>
			</method>
			<method name="dump" symbol="gda_tree_dump">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="node" type="GdaTreeNode*"/>
					<parameter name="stream" type="FILE*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_tree_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_node" symbol="gda_tree_get_node">
				<return-type type="GdaTreeNode*"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="tree_path" type="gchar*"/>
					<parameter name="use_names" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_node_manager" symbol="gda_tree_get_node_manager">
				<return-type type="GdaTreeManager*"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="node" type="GdaTreeNode*"/>
				</parameters>
			</method>
			<method name="get_node_path" symbol="gda_tree_get_node_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="node" type="GdaTreeNode*"/>
				</parameters>
			</method>
			<method name="get_nodes_in_path" symbol="gda_tree_get_nodes_in_path">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="tree_path" type="gchar*"/>
					<parameter name="use_names" type="gboolean"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_tree_new">
				<return-type type="GdaTree*"/>
			</constructor>
			<method name="set_attribute" symbol="gda_tree_set_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="attribute" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="update_all" symbol="gda_tree_update_all">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="update_part" symbol="gda_tree_update_part">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="node" type="GdaTreeNode*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="is-list" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="node-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="node" type="GdaTreeNode*"/>
				</parameters>
			</signal>
			<signal name="node-deleted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="node_path" type="char*"/>
				</parameters>
			</signal>
			<signal name="node-has-child-toggled" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="node" type="GdaTreeNode*"/>
				</parameters>
			</signal>
			<signal name="node-inserted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="tree" type="GdaTree*"/>
					<parameter name="node" type="GdaTreeNode*"/>
				</parameters>
			</signal>
		</object>
		<object name="GdaTreeManager" parent="GObject" type-name="GdaTreeManager" get-type="gda_tree_manager_get_type">
			<method name="add_manager" symbol="gda_tree_manager_add_manager">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GdaTreeManager*"/>
					<parameter name="sub" type="GdaTreeManager*"/>
				</parameters>
			</method>
			<method name="add_new_node_attribute" symbol="gda_tree_manager_add_new_node_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GdaTreeManager*"/>
					<parameter name="attribute" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="create_node" symbol="gda_tree_manager_create_node">
				<return-type type="GdaTreeNode*"/>
				<parameters>
					<parameter name="manager" type="GdaTreeManager*"/>
					<parameter name="parent" type="GdaTreeNode*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_tree_manager_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_managers" symbol="gda_tree_manager_get_managers">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="manager" type="GdaTreeManager*"/>
				</parameters>
			</method>
			<method name="get_node_create_func" symbol="gda_tree_manager_get_node_create_func">
				<return-type type="GdaTreeManagerNodeFunc"/>
				<parameters>
					<parameter name="manager" type="GdaTreeManager*"/>
				</parameters>
			</method>
			<constructor name="new_with_func" symbol="gda_tree_manager_new_with_func">
				<return-type type="GdaTreeManager*"/>
				<parameters>
					<parameter name="update_func" type="GdaTreeManagerNodesFunc"/>
				</parameters>
			</constructor>
			<method name="set_node_create_func" symbol="gda_tree_manager_set_node_create_func">
				<return-type type="void"/>
				<parameters>
					<parameter name="manager" type="GdaTreeManager*"/>
					<parameter name="func" type="GdaTreeManagerNodeFunc"/>
				</parameters>
			</method>
			<property name="func" type="gpointer" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="recursive" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<vfunc name="update_children">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="manager" type="GdaTreeManager*"/>
					<parameter name="node" type="GdaTreeNode*"/>
					<parameter name="children_nodes" type="GSList*"/>
					<parameter name="out_error" type="gboolean*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GdaTreeMgrColumns" parent="GdaTreeManager" type-name="GdaTreeMgrColumns" get-type="gda_tree_mgr_columns_get_type">
			<constructor name="new" symbol="gda_tree_mgr_columns_new">
				<return-type type="GdaTreeManager*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="schema" type="gchar*"/>
					<parameter name="table_name" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="connection" type="GdaConnection*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="meta-store" type="GdaMetaStore*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="schema" type="char*" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="table-name" type="char*" readable="0" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdaTreeMgrLabel" parent="GdaTreeManager" type-name="GdaTreeMgrLabel" get-type="gda_tree_mgr_label_get_type">
			<constructor name="new" symbol="gda_tree_mgr_label_new">
				<return-type type="GdaTreeManager*"/>
				<parameters>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="label" type="char*" readable="0" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdaTreeMgrSchemas" parent="GdaTreeManager" type-name="GdaTreeMgrSchemas" get-type="gda_tree_mgr_schemas_get_type">
			<constructor name="new" symbol="gda_tree_mgr_schemas_new">
				<return-type type="GdaTreeManager*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</constructor>
			<property name="connection" type="GdaConnection*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="meta-store" type="GdaMetaStore*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdaTreeMgrSelect" parent="GdaTreeManager" type-name="GdaTreeMgrSelect" get-type="gda_tree_mgr_select_get_type">
			<constructor name="new" symbol="gda_tree_mgr_select_new">
				<return-type type="GdaTreeManager*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="stmt" type="GdaStatement*"/>
					<parameter name="params" type="GdaSet*"/>
				</parameters>
			</constructor>
			<property name="connection" type="GdaConnection*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="params" type="GdaSet*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="statement" type="GdaStatement*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdaTreeMgrTables" parent="GdaTreeManager" type-name="GdaTreeMgrTables" get-type="gda_tree_mgr_tables_get_type">
			<constructor name="new" symbol="gda_tree_mgr_tables_new">
				<return-type type="GdaTreeManager*"/>
				<parameters>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="schema" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="connection" type="GdaConnection*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="meta-store" type="GdaMetaStore*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="schema" type="char*" readable="0" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GdaTreeNode" parent="GObject" type-name="GdaTreeNode" get-type="gda_tree_node_get_type">
			<method name="error_quark" symbol="gda_tree_node_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="fetch_attribute" symbol="gda_tree_node_fetch_attribute">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="node" type="GdaTreeNode*"/>
					<parameter name="attribute" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_child_index" symbol="gda_tree_node_get_child_index">
				<return-type type="GdaTreeNode*"/>
				<parameters>
					<parameter name="node" type="GdaTreeNode*"/>
					<parameter name="index" type="gint"/>
				</parameters>
			</method>
			<method name="get_child_name" symbol="gda_tree_node_get_child_name">
				<return-type type="GdaTreeNode*"/>
				<parameters>
					<parameter name="node" type="GdaTreeNode*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_children" symbol="gda_tree_node_get_children">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="node" type="GdaTreeNode*"/>
				</parameters>
			</method>
			<method name="get_node_attribute" symbol="gda_tree_node_get_node_attribute">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="node" type="GdaTreeNode*"/>
					<parameter name="attribute" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="gda_tree_node_get_parent">
				<return-type type="GdaTreeNode*"/>
				<parameters>
					<parameter name="node" type="GdaTreeNode*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gda_tree_node_new">
				<return-type type="GdaTreeNode*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_node_attribute" symbol="gda_tree_node_set_node_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="GdaTreeNode*"/>
					<parameter name="attribute" type="gchar*"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="destroy" type="GDestroyNotify"/>
				</parameters>
			</method>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="node-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="reporting" type="GdaTreeNode*"/>
					<parameter name="node" type="GdaTreeNode*"/>
				</parameters>
			</signal>
			<signal name="node-deleted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="reporting" type="GdaTreeNode*"/>
					<parameter name="relative_path" type="char*"/>
				</parameters>
			</signal>
			<signal name="node-has-child-toggled" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="reporting" type="GdaTreeNode*"/>
					<parameter name="node" type="GdaTreeNode*"/>
				</parameters>
			</signal>
			<signal name="node-inserted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="reporting" type="GdaTreeNode*"/>
					<parameter name="node" type="GdaTreeNode*"/>
				</parameters>
			</signal>
			<vfunc name="dump_children">
				<return-type type="void"/>
				<parameters>
					<parameter name="node" type="GdaTreeNode*"/>
					<parameter name="prefix" type="gchar*"/>
					<parameter name="in_string" type="GString*"/>
				</parameters>
			</vfunc>
			<vfunc name="dump_header">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="node" type="GdaTreeNode*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GdaVconnectionDataModel" parent="GdaVirtualConnection" type-name="GdaVconnectionDataModel" get-type="gda_vconnection_data_model_get_type">
			<implements>
				<interface name="GdaLockable"/>
			</implements>
			<method name="add" symbol="gda_vconnection_data_model_add">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaVconnectionDataModel*"/>
					<parameter name="spec" type="GdaVconnectionDataModelSpec*"/>
					<parameter name="spec_free_func" type="GDestroyNotify"/>
					<parameter name="table_name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="add_model" symbol="gda_vconnection_data_model_add_model">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaVconnectionDataModel*"/>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="table_name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="foreach" symbol="gda_vconnection_data_model_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="cnc" type="GdaVconnectionDataModel*"/>
					<parameter name="func" type="GdaVconnectionDataModelFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_model" symbol="gda_vconnection_data_model_get_model">
				<return-type type="GdaDataModel*"/>
				<parameters>
					<parameter name="cnc" type="GdaVconnectionDataModel*"/>
					<parameter name="table_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_table_name" symbol="gda_vconnection_data_model_get_table_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="cnc" type="GdaVconnectionDataModel*"/>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</method>
			<method name="remove" symbol="gda_vconnection_data_model_remove">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cnc" type="GdaVconnectionDataModel*"/>
					<parameter name="table_name" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</object>
		<object name="GdaVconnectionHub" parent="GdaVconnectionDataModel" type-name="GdaVconnectionHub" get-type="gda_vconnection_hub_get_type">
			<implements>
				<interface name="GdaLockable"/>
			</implements>
			<method name="add" symbol="gda_vconnection_hub_add">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="hub" type="GdaVconnectionHub*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="ns" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="foreach" symbol="gda_vconnection_hub_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="hub" type="GdaVconnectionHub*"/>
					<parameter name="func" type="GdaVConnectionHubFunc"/>
					<parameter name="data" type="gpointer"/>
				</parameters>
			</method>
			<method name="get_connection" symbol="gda_vconnection_hub_get_connection">
				<return-type type="GdaConnection*"/>
				<parameters>
					<parameter name="hub" type="GdaVconnectionHub*"/>
					<parameter name="ns" type="gchar*"/>
				</parameters>
			</method>
			<method name="remove" symbol="gda_vconnection_hub_remove">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="hub" type="GdaVconnectionHub*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</object>
		<object name="GdaVirtualConnection" parent="GdaConnection" type-name="GdaVirtualConnection" get-type="gda_virtual_connection_get_type">
			<implements>
				<interface name="GdaLockable"/>
			</implements>
			<method name="internal_get_provider_data" symbol="gda_virtual_connection_internal_get_provider_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="vcnc" type="GdaVirtualConnection*"/>
				</parameters>
			</method>
			<method name="internal_set_provider_data" symbol="gda_virtual_connection_internal_set_provider_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="vcnc" type="GdaVirtualConnection*"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="destroy_func" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="open" symbol="gda_virtual_connection_open">
				<return-type type="GdaConnection*"/>
				<parameters>
					<parameter name="virtual_provider" type="GdaVirtualProvider*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="open_extended" symbol="gda_virtual_connection_open_extended">
				<return-type type="GdaConnection*"/>
				<parameters>
					<parameter name="virtual_provider" type="GdaVirtualProvider*"/>
					<parameter name="options" type="GdaConnectionOptions"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</object>
		<object name="GdaVirtualProvider" parent="GdaSqliteProvider" type-name="GdaVirtualProvider" get-type="gda_virtual_provider_get_type">
		</object>
		<object name="GdaVproviderDataModel" parent="GdaVirtualProvider" type-name="GdaVproviderDataModel" get-type="gda_vprovider_data_model_get_type">
			<constructor name="new" symbol="gda_vprovider_data_model_new">
				<return-type type="GdaVirtualProvider*"/>
			</constructor>
		</object>
		<object name="GdaVproviderHub" parent="GdaVproviderDataModel" type-name="GdaVproviderHub" get-type="gda_vprovider_hub_get_type">
			<constructor name="new" symbol="gda_vprovider_hub_new">
				<return-type type="GdaVirtualProvider*"/>
			</constructor>
		</object>
		<object name="GdaXaTransaction" parent="GObject" type-name="GdaXaTransaction" get-type="gda_xa_transaction_get_type">
			<method name="begin" symbol="gda_xa_transaction_begin">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="xa_trans" type="GdaXaTransaction*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="commit" symbol="gda_xa_transaction_commit">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="xa_trans" type="GdaXaTransaction*"/>
					<parameter name="cnc_to_recover" type="GSList**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="commit_recovered" symbol="gda_xa_transaction_commit_recovered">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="xa_trans" type="GdaXaTransaction*"/>
					<parameter name="cnc_to_recover" type="GSList**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_xa_transaction_error_quark">
				<return-type type="GQuark"/>
			</method>
			<constructor name="new" symbol="gda_xa_transaction_new">
				<return-type type="GdaXaTransaction*"/>
				<parameters>
					<parameter name="format" type="guint32"/>
					<parameter name="global_transaction_id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="register_connection" symbol="gda_xa_transaction_register_connection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="xa_trans" type="GdaXaTransaction*"/>
					<parameter name="cnc" type="GdaConnection*"/>
					<parameter name="branch" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="rollback" symbol="gda_xa_transaction_rollback">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="xa_trans" type="GdaXaTransaction*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="string_to_id" symbol="gda_xa_transaction_string_to_id">
				<return-type type="GdaXaTransactionId*"/>
				<parameters>
					<parameter name="str" type="gchar*"/>
				</parameters>
			</method>
			<method name="unregister_connection" symbol="gda_xa_transaction_unregister_connection">
				<return-type type="void"/>
				<parameters>
					<parameter name="xa_trans" type="GdaXaTransaction*"/>
					<parameter name="cnc" type="GdaConnection*"/>
				</parameters>
			</method>
			<property name="format-id" type="guint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="transaction-id" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<interface name="GdaDataHandler" type-name="GdaDataHandler" get-type="gda_data_handler_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="accepts_g_type" symbol="gda_data_handler_accepts_g_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="get_default" symbol="gda_data_handler_get_default">
				<return-type type="GdaDataHandler*"/>
				<parameters>
					<parameter name="for_type" type="GType"/>
				</parameters>
			</method>
			<method name="get_descr" symbol="gda_data_handler_get_descr">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
				</parameters>
			</method>
			<method name="get_sane_init_value" symbol="gda_data_handler_get_sane_init_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="get_sql_from_value" symbol="gda_data_handler_get_sql_from_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_str_from_value" symbol="gda_data_handler_get_str_from_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</method>
			<method name="get_value_from_sql" symbol="gda_data_handler_get_value_from_sql">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="sql" type="gchar*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<method name="get_value_from_str" symbol="gda_data_handler_get_value_from_str">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="str" type="gchar*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</method>
			<vfunc name="accepts_g_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_descr">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_sane_init_value">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_sql_from_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_str_from_value">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="value" type="GValue*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_value_from_sql">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="sql" type="gchar*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</vfunc>
			<vfunc name="get_value_from_str">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="dh" type="GdaDataHandler*"/>
					<parameter name="str" type="gchar*"/>
					<parameter name="type" type="GType"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GdaDataModel" type-name="GdaDataModel" get-type="gda_data_model_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="append_row" symbol="gda_data_model_append_row">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="append_values" symbol="gda_data_model_append_values">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="values" type="GList*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_iter" symbol="gda_data_model_create_iter">
				<return-type type="GdaDataModelIter*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</method>
			<method name="describe_column" symbol="gda_data_model_describe_column">
				<return-type type="GdaColumn*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
				</parameters>
			</method>
			<method name="dump" symbol="gda_data_model_dump">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="to_stream" type="FILE*"/>
				</parameters>
			</method>
			<method name="dump_as_string" symbol="gda_data_model_dump_as_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gda_data_model_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="export_to_file" symbol="gda_data_model_export_to_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="format" type="GdaDataModelIOFormat"/>
					<parameter name="file" type="gchar*"/>
					<parameter name="cols" type="gint*"/>
					<parameter name="nb_cols" type="gint"/>
					<parameter name="rows" type="gint*"/>
					<parameter name="nb_rows" type="gint"/>
					<parameter name="options" type="GdaSet*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="export_to_string" symbol="gda_data_model_export_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="format" type="GdaDataModelIOFormat"/>
					<parameter name="cols" type="gint*"/>
					<parameter name="nb_cols" type="gint"/>
					<parameter name="rows" type="gint*"/>
					<parameter name="nb_rows" type="gint"/>
					<parameter name="options" type="GdaSet*"/>
				</parameters>
			</method>
			<method name="freeze" symbol="gda_data_model_freeze">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</method>
			<method name="get_access_flags" symbol="gda_data_model_get_access_flags">
				<return-type type="GdaDataModelAccessFlags"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</method>
			<method name="get_attributes_at" symbol="gda_data_model_get_attributes_at">
				<return-type type="GdaValueAttribute"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</method>
			<method name="get_column_index" symbol="gda_data_model_get_column_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_column_name" symbol="gda_data_model_get_column_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
				</parameters>
			</method>
			<method name="get_column_title" symbol="gda_data_model_get_column_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
				</parameters>
			</method>
			<method name="get_n_columns" symbol="gda_data_model_get_n_columns">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</method>
			<method name="get_n_rows" symbol="gda_data_model_get_n_rows">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</method>
			<method name="get_row_from_values" symbol="gda_data_model_get_row_from_values">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="values" type="GSList*"/>
					<parameter name="cols_index" type="gint*"/>
				</parameters>
			</method>
			<method name="get_typed_value_at" symbol="gda_data_model_get_typed_value_at">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
					<parameter name="row" type="gint"/>
					<parameter name="expected_type" type="GType"/>
					<parameter name="nullok" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_value_at" symbol="gda_data_model_get_value_at">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
					<parameter name="row" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="remove_row" symbol="gda_data_model_remove_row">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="row" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="send_hint" symbol="gda_data_model_send_hint">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="hint" type="GdaDataModelHint"/>
					<parameter name="hint_value" type="GValue*"/>
				</parameters>
			</method>
			<method name="set_column_name" symbol="gda_data_model_set_column_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_column_title" symbol="gda_data_model_set_column_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_value_at" symbol="gda_data_model_set_value_at">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
					<parameter name="row" type="gint"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_values" symbol="gda_data_model_set_values">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="row" type="gint"/>
					<parameter name="values" type="GList*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="thaw" symbol="gda_data_model_thaw">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</signal>
			<signal name="reset" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</signal>
			<signal name="row-inserted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</signal>
			<signal name="row-removed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</signal>
			<signal name="row-updated" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</signal>
			<vfunc name="i_append_row">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="i_append_values">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="values" type="GList*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="i_create_iter">
				<return-type type="GdaDataModelIter*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</vfunc>
			<vfunc name="i_describe_column">
				<return-type type="GdaColumn*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="i_find_row">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="values" type="GSList*"/>
					<parameter name="cols_index" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="i_get_access_flags">
				<return-type type="GdaDataModelAccessFlags"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</vfunc>
			<vfunc name="i_get_attributes_at">
				<return-type type="GdaValueAttribute"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="i_get_n_columns">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</vfunc>
			<vfunc name="i_get_n_rows">
				<return-type type="gint"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</vfunc>
			<vfunc name="i_get_notify">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
				</parameters>
			</vfunc>
			<vfunc name="i_get_value_at">
				<return-type type="GValue*"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
					<parameter name="row" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="i_iter_at_row">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="iter" type="GdaDataModelIter*"/>
					<parameter name="row" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="i_iter_next">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="iter" type="GdaDataModelIter*"/>
				</parameters>
			</vfunc>
			<vfunc name="i_iter_prev">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="iter" type="GdaDataModelIter*"/>
				</parameters>
			</vfunc>
			<vfunc name="i_iter_set_value">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="iter" type="GdaDataModelIter*"/>
					<parameter name="col" type="gint"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="i_remove_row">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="row" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="i_send_hint">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="hint" type="GdaDataModelHint"/>
					<parameter name="hint_value" type="GValue*"/>
				</parameters>
			</vfunc>
			<vfunc name="i_set_notify">
				<return-type type="void"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="do_notify_changes" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="i_set_value_at">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="col" type="gint"/>
					<parameter name="row" type="gint"/>
					<parameter name="value" type="GValue*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="i_set_values">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="model" type="GdaDataModel*"/>
					<parameter name="row" type="gint"/>
					<parameter name="values" type="GList*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GdaLockable" type-name="GdaLockable" get-type="gda_lockable_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="lock" symbol="gda_lockable_lock">
				<return-type type="void"/>
				<parameters>
					<parameter name="lockable" type="GdaLockable*"/>
				</parameters>
			</method>
			<method name="trylock" symbol="gda_lockable_trylock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="lockable" type="GdaLockable*"/>
				</parameters>
			</method>
			<method name="unlock" symbol="gda_lockable_unlock">
				<return-type type="void"/>
				<parameters>
					<parameter name="lockable" type="GdaLockable*"/>
				</parameters>
			</method>
			<vfunc name="i_lock">
				<return-type type="void"/>
				<parameters>
					<parameter name="lock" type="GdaLockable*"/>
				</parameters>
			</vfunc>
			<vfunc name="i_trylock">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="lock" type="GdaLockable*"/>
				</parameters>
			</vfunc>
			<vfunc name="i_unlock">
				<return-type type="void"/>
				<parameters>
					<parameter name="lock" type="GdaLockable*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="GDA_ATTRIBUTE_AUTO_INCREMENT" type="char*" value="__gda_attr_autoinc"/>
		<constant name="GDA_ATTRIBUTE_DESCRIPTION" type="char*" value="__gda_attr_descr"/>
		<constant name="GDA_ATTRIBUTE_IS_DEFAULT" type="char*" value="__gda_attr_is_default"/>
		<constant name="GDA_ATTRIBUTE_NAME" type="char*" value="__gda_attr_name"/>
		<constant name="GDA_ATTRIBUTE_NUMERIC_PRECISION" type="char*" value="__gda_attr_numeric_precision"/>
		<constant name="GDA_ATTRIBUTE_NUMERIC_SCALE" type="char*" value="__gda_attr_numeric_scale"/>
		<constant name="GDA_EXTRA_AUTO_INCREMENT" type="char*" value="AUTO_INCREMENT"/>
		<constant name="GDA_SQLSTATE_GENERAL_ERROR" type="char*" value="HY000"/>
		<constant name="GDA_SQLSTATE_NO_ERROR" type="char*" value="00000"/>
		<constant name="GDA_TIMEZONE_INVALID" type="int" value="86400"/>
		<constant name="GDA_TYPE_NULL" type="int" value="0"/>
	</namespace>
</api>
