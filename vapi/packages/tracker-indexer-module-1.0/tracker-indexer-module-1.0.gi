<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Tracker">
		<function name="date_format" symbol="tracker_date_format">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="time_string" type="gchar*"/>
			</parameters>
		</function>
		<function name="date_to_string" symbol="tracker_date_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="date_time" type="time_t"/>
			</parameters>
		</function>
		<function name="date_to_time_string" symbol="tracker_date_to_time_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="date_string" type="gchar*"/>
			</parameters>
		</function>
		<function name="env_check_xdg_dirs" symbol="tracker_env_check_xdg_dirs">
			<return-type type="gboolean"/>
		</function>
		<function name="escape_string" symbol="tracker_escape_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="in" type="gchar*"/>
			</parameters>
		</function>
		<function name="gint32_to_string" symbol="tracker_gint32_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="i" type="gint32"/>
			</parameters>
		</function>
		<function name="gint_to_string" symbol="tracker_gint_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="i" type="gint"/>
			</parameters>
		</function>
		<function name="glong_to_string" symbol="tracker_glong_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="i" type="glong"/>
			</parameters>
		</function>
		<function name="gslist_copy_with_string_data" symbol="tracker_gslist_copy_with_string_data">
			<return-type type="GSList*"/>
			<parameters>
				<parameter name="list" type="GSList*"/>
			</parameters>
		</function>
		<function name="gslist_to_string_list" symbol="tracker_gslist_to_string_list">
			<return-type type="gchar**"/>
			<parameters>
				<parameter name="list" type="GSList*"/>
			</parameters>
		</function>
		<function name="guint32_to_string" symbol="tracker_guint32_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="i" type="guint32"/>
			</parameters>
		</function>
		<function name="guint_to_string" symbol="tracker_guint_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="i" type="guint"/>
			</parameters>
		</function>
		<function name="is_empty_string" symbol="tracker_is_empty_string">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="str" type="char*"/>
			</parameters>
		</function>
		<function name="module_config_get_description" symbol="tracker_module_config_get_description">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_config_get_enabled" symbol="tracker_module_config_get_enabled">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_config_get_ignored_directories" symbol="tracker_module_config_get_ignored_directories">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_config_get_ignored_directory_patterns" symbol="tracker_module_config_get_ignored_directory_patterns">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_config_get_ignored_file_patterns" symbol="tracker_module_config_get_ignored_file_patterns">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_config_get_ignored_files" symbol="tracker_module_config_get_ignored_files">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_config_get_index_file_patterns" symbol="tracker_module_config_get_index_file_patterns">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_config_get_index_files" symbol="tracker_module_config_get_index_files">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_config_get_index_mime_types" symbol="tracker_module_config_get_index_mime_types">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_config_get_index_service" symbol="tracker_module_config_get_index_service">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_config_get_modules" symbol="tracker_module_config_get_modules">
			<return-type type="GList*"/>
		</function>
		<function name="module_config_get_monitor_directories" symbol="tracker_module_config_get_monitor_directories">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_config_get_monitor_recurse_directories" symbol="tracker_module_config_get_monitor_recurse_directories">
			<return-type type="GList*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_config_init" symbol="tracker_module_config_init">
			<return-type type="gboolean"/>
		</function>
		<function name="module_config_shutdown" symbol="tracker_module_config_shutdown">
			<return-type type="void"/>
		</function>
		<function name="module_file_free_data" symbol="tracker_module_file_free_data">
			<return-type type="void"/>
			<parameters>
				<parameter name="file_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="module_file_get_data" symbol="tracker_module_file_get_data">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="path" type="gchar*"/>
			</parameters>
		</function>
		<function name="module_file_get_metadata" symbol="tracker_module_file_get_metadata">
			<return-type type="TrackerMetadata*"/>
			<parameters>
				<parameter name="file" type="TrackerFile*"/>
			</parameters>
		</function>
		<function name="module_file_get_service_type" symbol="tracker_module_file_get_service_type">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="file" type="TrackerFile*"/>
			</parameters>
		</function>
		<function name="module_file_get_text" symbol="tracker_module_file_get_text">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="file" type="TrackerFile*"/>
			</parameters>
		</function>
		<function name="module_file_get_uri" symbol="tracker_module_file_get_uri">
			<return-type type="void"/>
			<parameters>
				<parameter name="file" type="TrackerFile*"/>
				<parameter name="dirname" type="gchar**"/>
				<parameter name="basename" type="gchar**"/>
			</parameters>
		</function>
		<function name="module_file_iter_contents" symbol="tracker_module_file_iter_contents">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="file" type="TrackerFile*"/>
			</parameters>
		</function>
		<function name="module_get_name" symbol="tracker_module_get_name">
			<return-type type="gchar*"/>
		</function>
		<function name="module_init" symbol="tracker_module_init">
			<return-type type="void"/>
		</function>
		<function name="module_shutdown" symbol="tracker_module_shutdown">
			<return-type type="void"/>
		</function>
		<function name="ontology_field_add" symbol="tracker_ontology_field_add">
			<return-type type="void"/>
			<parameters>
				<parameter name="field" type="TrackerField*"/>
			</parameters>
		</function>
		<function name="ontology_field_get_display_name" symbol="tracker_ontology_field_get_display_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="field" type="TrackerField*"/>
			</parameters>
		</function>
		<function name="ontology_field_get_id" symbol="tracker_ontology_field_get_id">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_field_is_child_of" symbol="tracker_ontology_field_is_child_of">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="child" type="gchar*"/>
				<parameter name="parent" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_get_field_by_id" symbol="tracker_ontology_get_field_by_id">
			<return-type type="TrackerField*"/>
			<parameters>
				<parameter name="id" type="gint"/>
			</parameters>
		</function>
		<function name="ontology_get_field_by_name" symbol="tracker_ontology_get_field_by_name">
			<return-type type="TrackerField*"/>
			<parameters>
				<parameter name="name" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_get_field_name_by_service_name" symbol="tracker_ontology_get_field_name_by_service_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="field" type="TrackerField*"/>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_get_field_names_registered" symbol="tracker_ontology_get_field_names_registered">
			<return-type type="GSList*"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_get_service_by_id" symbol="tracker_ontology_get_service_by_id">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="id" type="gint"/>
			</parameters>
		</function>
		<function name="ontology_get_service_by_mime" symbol="tracker_ontology_get_service_by_mime">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="mime" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_get_service_by_name" symbol="tracker_ontology_get_service_by_name">
			<return-type type="TrackerService*"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_get_service_db_by_name" symbol="tracker_ontology_get_service_db_by_name">
			<return-type type="TrackerDBType"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_get_service_id_by_name" symbol="tracker_ontology_get_service_id_by_name">
			<return-type type="gint"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_get_service_names_registered" symbol="tracker_ontology_get_service_names_registered">
			<return-type type="GSList*"/>
		</function>
		<function name="ontology_get_service_parent" symbol="tracker_ontology_get_service_parent">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_get_service_parent_by_id" symbol="tracker_ontology_get_service_parent_by_id">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="id" type="gint"/>
			</parameters>
		</function>
		<function name="ontology_get_service_parent_id_by_id" symbol="tracker_ontology_get_service_parent_id_by_id">
			<return-type type="gint"/>
			<parameters>
				<parameter name="id" type="gint"/>
			</parameters>
		</function>
		<function name="ontology_init" symbol="tracker_ontology_init">
			<return-type type="void"/>
		</function>
		<function name="ontology_service_add" symbol="tracker_ontology_service_add">
			<return-type type="void"/>
			<parameters>
				<parameter name="service" type="TrackerService*"/>
				<parameter name="mimes" type="GSList*"/>
				<parameter name="mime_prefixes" type="GSList*"/>
			</parameters>
		</function>
		<function name="ontology_service_get_key_metadata" symbol="tracker_ontology_service_get_key_metadata">
			<return-type type="gint"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
				<parameter name="meta_name" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_service_get_show_directories" symbol="tracker_ontology_service_get_show_directories">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_service_get_show_files" symbol="tracker_ontology_service_get_show_files">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_service_has_embedded" symbol="tracker_ontology_service_has_embedded">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_service_has_metadata" symbol="tracker_ontology_service_has_metadata">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_service_has_text" symbol="tracker_ontology_service_has_text">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_service_has_thumbnails" symbol="tracker_ontology_service_has_thumbnails">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_service_is_valid" symbol="tracker_ontology_service_is_valid">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="service_str" type="gchar*"/>
			</parameters>
		</function>
		<function name="ontology_shutdown" symbol="tracker_ontology_shutdown">
			<return-type type="void"/>
		</function>
		<function name="path_evaluate_name" symbol="tracker_path_evaluate_name">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="uri" type="gchar*"/>
			</parameters>
		</function>
		<function name="path_hash_table_filter_duplicates" symbol="tracker_path_hash_table_filter_duplicates">
			<return-type type="void"/>
			<parameters>
				<parameter name="roots" type="GHashTable*"/>
			</parameters>
		</function>
		<function name="path_is_in_path" symbol="tracker_path_is_in_path">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="path" type="gchar*"/>
				<parameter name="in_path" type="gchar*"/>
			</parameters>
		</function>
		<function name="path_list_filter_duplicates" symbol="tracker_path_list_filter_duplicates">
			<return-type type="GSList*"/>
			<parameters>
				<parameter name="roots" type="GSList*"/>
			</parameters>
		</function>
		<function name="path_remove" symbol="tracker_path_remove">
			<return-type type="void"/>
			<parameters>
				<parameter name="uri" type="gchar*"/>
			</parameters>
		</function>
		<function name="seconds_estimate_to_string" symbol="tracker_seconds_estimate_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="seconds_elapsed" type="gdouble"/>
				<parameter name="short_string" type="gboolean"/>
				<parameter name="items_done" type="guint"/>
				<parameter name="items_remaining" type="guint"/>
			</parameters>
		</function>
		<function name="seconds_to_string" symbol="tracker_seconds_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="seconds_elapsed" type="gdouble"/>
				<parameter name="short_string" type="gboolean"/>
			</parameters>
		</function>
		<function name="string_boolean_to_string_gint" symbol="tracker_string_boolean_to_string_gint">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="value" type="gchar*"/>
			</parameters>
		</function>
		<function name="string_in_string_list" symbol="tracker_string_in_string_list">
			<return-type type="gint"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
				<parameter name="strv" type="gchar**"/>
			</parameters>
		</function>
		<function name="string_list_to_gslist" symbol="tracker_string_list_to_gslist">
			<return-type type="GSList*"/>
			<parameters>
				<parameter name="strv" type="gchar**"/>
				<parameter name="length" type="gsize"/>
			</parameters>
		</function>
		<function name="string_list_to_string" symbol="tracker_string_list_to_string">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="strv" type="gchar**"/>
				<parameter name="length" type="gsize"/>
				<parameter name="sep" type="gchar"/>
			</parameters>
		</function>
		<function name="string_remove" symbol="tracker_string_remove">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="haystack" type="gchar*"/>
				<parameter name="needle" type="gchar*"/>
			</parameters>
		</function>
		<function name="string_replace" symbol="tracker_string_replace">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="haystack" type="gchar*"/>
				<parameter name="needle" type="gchar*"/>
				<parameter name="replacement" type="gchar*"/>
			</parameters>
		</function>
		<function name="string_to_date" symbol="tracker_string_to_date">
			<return-type type="time_t"/>
			<parameters>
				<parameter name="time_string" type="gchar*"/>
			</parameters>
		</function>
		<function name="string_to_string_list" symbol="tracker_string_to_string_list">
			<return-type type="gchar**"/>
			<parameters>
				<parameter name="str" type="gchar*"/>
			</parameters>
		</function>
		<function name="string_to_uint" symbol="tracker_string_to_uint">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="s" type="gchar*"/>
				<parameter name="ret" type="guint*"/>
			</parameters>
		</function>
		<function name="throttle" symbol="tracker_throttle">
			<return-type type="void"/>
			<parameters>
				<parameter name="config" type="TrackerConfig*"/>
				<parameter name="multiplier" type="gint"/>
			</parameters>
		</function>
		<callback name="TrackerMetadataForeach">
			<return-type type="void"/>
			<parameters>
				<parameter name="field" type="TrackerField*"/>
				<parameter name="value" type="gpointer"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="TrackerModuleFileFreeDataFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="TrackerModuleFileGetDataFunc">
			<return-type type="gpointer"/>
			<parameters>
				<parameter name="path" type="gchar*"/>
			</parameters>
		</callback>
		<callback name="TrackerModuleFileGetMetadataFunc">
			<return-type type="TrackerMetadata*"/>
			<parameters>
				<parameter name="file" type="TrackerFile*"/>
			</parameters>
		</callback>
		<callback name="TrackerModuleFileGetServiceTypeFunc">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="file" type="TrackerFile*"/>
			</parameters>
		</callback>
		<callback name="TrackerModuleFileGetText">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="path" type="TrackerFile*"/>
			</parameters>
		</callback>
		<callback name="TrackerModuleFileGetUriFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="file" type="TrackerFile*"/>
				<parameter name="dirname" type="gchar**"/>
				<parameter name="basename" type="gchar**"/>
			</parameters>
		</callback>
		<callback name="TrackerModuleFileIterContents">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="path" type="TrackerFile*"/>
			</parameters>
		</callback>
		<callback name="TrackerModuleGetDirectoriesFunc">
			<return-type type="gchar**"/>
		</callback>
		<callback name="TrackerModuleGetNameFunc">
			<return-type type="gchar*"/>
		</callback>
		<callback name="TrackerModuleInit">
			<return-type type="void"/>
		</callback>
		<callback name="TrackerModuleShutdown">
			<return-type type="void"/>
		</callback>
		<struct name="TrackerFile">
			<method name="close" symbol="tracker_file_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="fd" type="gint"/>
					<parameter name="no_longer_needed" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_mime_type" symbol="tracker_file_get_mime_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_mtime" symbol="tracker_file_get_mtime">
				<return-type type="gint32"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_path_and_name" symbol="tracker_file_get_path_and_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
					<parameter name="path" type="gchar**"/>
					<parameter name="name" type="gchar**"/>
				</parameters>
			</method>
			<method name="get_size" symbol="tracker_file_get_size">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="is_directory" symbol="tracker_file_is_directory">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="is_indexable" symbol="tracker_file_is_indexable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="is_valid" symbol="tracker_file_is_valid">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="open" symbol="tracker_file_open">
				<return-type type="gint"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
					<parameter name="readahead" type="gboolean"/>
				</parameters>
			</method>
			<method name="unlink" symbol="tracker_file_unlink">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<field name="path" type="gchar*"/>
			<field name="data" type="gpointer"/>
		</struct>
		<struct name="TrackerMetadata">
			<method name="foreach" symbol="tracker_metadata_foreach">
				<return-type type="void"/>
				<parameters>
					<parameter name="metadata" type="TrackerMetadata*"/>
					<parameter name="func" type="TrackerMetadataForeach"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="tracker_metadata_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="metadata" type="TrackerMetadata*"/>
				</parameters>
			</method>
			<method name="insert" symbol="tracker_metadata_insert">
				<return-type type="void"/>
				<parameters>
					<parameter name="metadata" type="TrackerMetadata*"/>
					<parameter name="field_name" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="insert_multiple_values" symbol="tracker_metadata_insert_multiple_values">
				<return-type type="void"/>
				<parameters>
					<parameter name="metadata" type="TrackerMetadata*"/>
					<parameter name="field_name" type="gchar*"/>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="lookup" symbol="tracker_metadata_lookup">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="metadata" type="TrackerMetadata*"/>
					<parameter name="field_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="lookup_multiple_values" symbol="tracker_metadata_lookup_multiple_values">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="metadata" type="TrackerMetadata*"/>
					<parameter name="field_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="new" symbol="tracker_metadata_new">
				<return-type type="TrackerMetadata*"/>
			</method>
			<method name="utils_get_data" symbol="tracker_metadata_utils_get_data">
				<return-type type="TrackerMetadata*"/>
				<parameters>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
			<method name="utils_get_text" symbol="tracker_metadata_utils_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="path" type="gchar*"/>
				</parameters>
			</method>
		</struct>
		<struct name="TrackerParser">
			<method name="free" symbol="tracker_parser_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="TrackerParser*"/>
				</parameters>
			</method>
			<method name="is_stop_word" symbol="tracker_parser_is_stop_word">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parser" type="TrackerParser*"/>
					<parameter name="word" type="gchar*"/>
				</parameters>
			</method>
			<method name="new" symbol="tracker_parser_new">
				<return-type type="TrackerParser*"/>
				<parameters>
					<parameter name="language" type="TrackerLanguage*"/>
					<parameter name="max_word_length" type="gint"/>
					<parameter name="min_word_length" type="gint"/>
				</parameters>
			</method>
			<method name="next" symbol="tracker_parser_next">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="parser" type="TrackerParser*"/>
					<parameter name="position" type="gint*"/>
					<parameter name="byte_offset_start" type="gint*"/>
					<parameter name="byte_offset_end" type="gint*"/>
					<parameter name="new_paragraph" type="gboolean*"/>
					<parameter name="stop_word" type="gboolean*"/>
					<parameter name="word_length" type="gint*"/>
				</parameters>
			</method>
			<method name="process_word" symbol="tracker_parser_process_word">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="parser" type="TrackerParser*"/>
					<parameter name="word" type="char*"/>
					<parameter name="length" type="gint"/>
					<parameter name="do_strip" type="gboolean"/>
				</parameters>
			</method>
			<method name="reset" symbol="tracker_parser_reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="TrackerParser*"/>
					<parameter name="txt" type="gchar*"/>
					<parameter name="txt_size" type="gint"/>
					<parameter name="delimit_words" type="gboolean"/>
					<parameter name="enable_stemmer" type="gboolean"/>
					<parameter name="enable_stop_words" type="gboolean"/>
					<parameter name="parse_reserved_words" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_posititon" symbol="tracker_parser_set_posititon">
				<return-type type="void"/>
				<parameters>
					<parameter name="parser" type="TrackerParser*"/>
					<parameter name="position" type="gint"/>
				</parameters>
			</method>
			<method name="text" symbol="tracker_parser_text">
				<return-type type="GHashTable*"/>
				<parameters>
					<parameter name="word_table" type="GHashTable*"/>
					<parameter name="txt" type="gchar*"/>
					<parameter name="weight" type="gint"/>
					<parameter name="language" type="TrackerLanguage*"/>
					<parameter name="max_words_to_index" type="gint"/>
					<parameter name="max_word_length" type="gint"/>
					<parameter name="min_word_length" type="gint"/>
					<parameter name="filter_words" type="gboolean"/>
					<parameter name="delimit_words" type="gboolean"/>
				</parameters>
			</method>
			<method name="text_fast" symbol="tracker_parser_text_fast">
				<return-type type="GHashTable*"/>
				<parameters>
					<parameter name="word_table" type="GHashTable*"/>
					<parameter name="txt" type="char*"/>
					<parameter name="weight" type="gint"/>
				</parameters>
			</method>
			<method name="text_into_array" symbol="tracker_parser_text_into_array">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="text" type="gchar*"/>
					<parameter name="language" type="TrackerLanguage*"/>
					<parameter name="max_word_length" type="gint"/>
					<parameter name="min_word_length" type="gint"/>
				</parameters>
			</method>
			<method name="text_to_string" symbol="tracker_parser_text_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="txt" type="gchar*"/>
					<parameter name="language" type="TrackerLanguage*"/>
					<parameter name="max_word_length" type="gint"/>
					<parameter name="min_word_length" type="gint"/>
					<parameter name="filter_words" type="gboolean"/>
					<parameter name="filter_numbers" type="gboolean"/>
					<parameter name="delimit" type="gboolean"/>
				</parameters>
			</method>
		</struct>
		<enum name="TrackerDBType" type-name="TrackerDBType" get-type="tracker_db_type_get_type">
			<member name="TRACKER_DB_TYPE_UNKNOWN" value="0"/>
			<member name="TRACKER_DB_TYPE_DATA" value="1"/>
			<member name="TRACKER_DB_TYPE_INDEX" value="2"/>
			<member name="TRACKER_DB_TYPE_COMMON" value="3"/>
			<member name="TRACKER_DB_TYPE_CONTENT" value="4"/>
			<member name="TRACKER_DB_TYPE_EMAIL" value="5"/>
			<member name="TRACKER_DB_TYPE_FILES" value="6"/>
			<member name="TRACKER_DB_TYPE_XESAM" value="7"/>
			<member name="TRACKER_DB_TYPE_CACHE" value="8"/>
			<member name="TRACKER_DB_TYPE_USER" value="9"/>
		</enum>
		<enum name="TrackerFieldType" type-name="TrackerFieldType" get-type="tracker_field_type_get_type">
			<member name="TRACKER_FIELD_TYPE_KEYWORD" value="0"/>
			<member name="TRACKER_FIELD_TYPE_INDEX" value="1"/>
			<member name="TRACKER_FIELD_TYPE_FULLTEXT" value="2"/>
			<member name="TRACKER_FIELD_TYPE_STRING" value="3"/>
			<member name="TRACKER_FIELD_TYPE_INTEGER" value="4"/>
			<member name="TRACKER_FIELD_TYPE_DOUBLE" value="5"/>
			<member name="TRACKER_FIELD_TYPE_DATE" value="6"/>
			<member name="TRACKER_FIELD_TYPE_BLOB" value="7"/>
			<member name="TRACKER_FIELD_TYPE_STRUCT" value="8"/>
			<member name="TRACKER_FIELD_TYPE_LINK" value="9"/>
		</enum>
		<object name="TrackerConfig" parent="GObject" type-name="TrackerConfig" get-type="tracker_config_get_type">
			<method name="add_crawl_directory_roots" symbol="tracker_config_add_crawl_directory_roots">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="roots" type="gchar**"/>
				</parameters>
			</method>
			<method name="add_disabled_modules" symbol="tracker_config_add_disabled_modules">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="modules" type="gchar**"/>
				</parameters>
			</method>
			<method name="add_no_watch_directory_roots" symbol="tracker_config_add_no_watch_directory_roots">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="roots" type="gchar**"/>
				</parameters>
			</method>
			<method name="add_watch_directory_roots" symbol="tracker_config_add_watch_directory_roots">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="roots" type="gchar**"/>
				</parameters>
			</method>
			<method name="get_crawl_directory_roots" symbol="tracker_config_get_crawl_directory_roots">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_disable_indexing_on_battery" symbol="tracker_config_get_disable_indexing_on_battery">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_disable_indexing_on_battery_init" symbol="tracker_config_get_disable_indexing_on_battery_init">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_disabled_modules" symbol="tracker_config_get_disabled_modules">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_enable_content_indexing" symbol="tracker_config_get_enable_content_indexing">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_enable_indexing" symbol="tracker_config_get_enable_indexing">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_enable_stemmer" symbol="tracker_config_get_enable_stemmer">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_enable_thumbnails" symbol="tracker_config_get_enable_thumbnails">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_enable_watches" symbol="tracker_config_get_enable_watches">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_enable_xesam" symbol="tracker_config_get_enable_xesam">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_fast_merges" symbol="tracker_config_get_fast_merges">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_index_mounted_directories" symbol="tracker_config_get_index_mounted_directories">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_index_removable_devices" symbol="tracker_config_get_index_removable_devices">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_initial_sleep" symbol="tracker_config_get_initial_sleep">
				<return-type type="gint"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_language" symbol="tracker_config_get_language">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_low_disk_space_limit" symbol="tracker_config_get_low_disk_space_limit">
				<return-type type="gint"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_low_memory_mode" symbol="tracker_config_get_low_memory_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_max_bucket_count" symbol="tracker_config_get_max_bucket_count">
				<return-type type="gint"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_max_text_to_index" symbol="tracker_config_get_max_text_to_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_max_word_length" symbol="tracker_config_get_max_word_length">
				<return-type type="gint"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_max_words_to_index" symbol="tracker_config_get_max_words_to_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_min_bucket_count" symbol="tracker_config_get_min_bucket_count">
				<return-type type="gint"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_min_word_length" symbol="tracker_config_get_min_word_length">
				<return-type type="gint"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_nfs_locking" symbol="tracker_config_get_nfs_locking">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_no_index_file_types" symbol="tracker_config_get_no_index_file_types">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_no_watch_directory_roots" symbol="tracker_config_get_no_watch_directory_roots">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_throttle" symbol="tracker_config_get_throttle">
				<return-type type="gint"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_verbosity" symbol="tracker_config_get_verbosity">
				<return-type type="gint"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="get_watch_directory_roots" symbol="tracker_config_get_watch_directory_roots">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="tracker_config_new">
				<return-type type="TrackerConfig*"/>
			</constructor>
			<method name="remove_disabled_modules" symbol="tracker_config_remove_disabled_modules">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="module" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_disable_indexing_on_battery" symbol="tracker_config_set_disable_indexing_on_battery">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_disable_indexing_on_battery_init" symbol="tracker_config_set_disable_indexing_on_battery_init">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_enable_content_indexing" symbol="tracker_config_set_enable_content_indexing">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_enable_indexing" symbol="tracker_config_set_enable_indexing">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_enable_stemmer" symbol="tracker_config_set_enable_stemmer">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_enable_thumbnails" symbol="tracker_config_set_enable_thumbnails">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_enable_watches" symbol="tracker_config_set_enable_watches">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_enable_xesam" symbol="tracker_config_set_enable_xesam">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_fast_merges" symbol="tracker_config_set_fast_merges">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_index_mounted_directories" symbol="tracker_config_set_index_mounted_directories">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_index_removable_devices" symbol="tracker_config_set_index_removable_devices">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_initial_sleep" symbol="tracker_config_set_initial_sleep">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_language" symbol="tracker_config_set_language">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_low_disk_space_limit" symbol="tracker_config_set_low_disk_space_limit">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_low_memory_mode" symbol="tracker_config_set_low_memory_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_max_bucket_count" symbol="tracker_config_set_max_bucket_count">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_max_text_to_index" symbol="tracker_config_set_max_text_to_index">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_max_word_length" symbol="tracker_config_set_max_word_length">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_max_words_to_index" symbol="tracker_config_set_max_words_to_index">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_min_bucket_count" symbol="tracker_config_set_min_bucket_count">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_min_word_length" symbol="tracker_config_set_min_word_length">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_nfs_locking" symbol="tracker_config_set_nfs_locking">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_throttle" symbol="tracker_config_set_throttle">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_verbosity" symbol="tracker_config_set_verbosity">
				<return-type type="void"/>
				<parameters>
					<parameter name="config" type="TrackerConfig*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<property name="crawl-directory-roots" type="gpointer" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="disable-indexing-on-battery" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="disable-indexing-on-battery-init" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="disabled-modules" type="gpointer" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="enable-content-indexing" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-indexing" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-stemmer" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-thumbnails" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-watches" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="enable-xesam" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="fast-merges" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="index-mounted-directories" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="index-removable-devices" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="initial-sleep" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="language" type="char*" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="low-disk-space-limit" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="low-memory-mode" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="max-bucket-count" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="max-text-to-index" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="max-word-length" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="max-words-to-index" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="min-bucket-count" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="min-word-length" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="nfs-locking" type="gboolean" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="no-index-file-types" type="gpointer" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="no-watch-directory-roots" type="gpointer" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="throttle" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="verbosity" type="gint" readable="1" writable="1" construct="1" construct-only="0"/>
			<property name="watch-directory-roots" type="gpointer" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="TrackerField" parent="GObject" type-name="TrackerField" get-type="tracker_field_get_type">
			<method name="append_child_id" symbol="tracker_field_append_child_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_child_ids" symbol="tracker_field_get_child_ids">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
				</parameters>
			</method>
			<method name="get_data_type" symbol="tracker_field_get_data_type">
				<return-type type="TrackerFieldType"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
				</parameters>
			</method>
			<method name="get_delimited" symbol="tracker_field_get_delimited">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
				</parameters>
			</method>
			<method name="get_embedded" symbol="tracker_field_get_embedded">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
				</parameters>
			</method>
			<method name="get_field_name" symbol="tracker_field_get_field_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
				</parameters>
			</method>
			<method name="get_filtered" symbol="tracker_field_get_filtered">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="tracker_field_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
				</parameters>
			</method>
			<method name="get_multiple_values" symbol="tracker_field_get_multiple_values">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="tracker_field_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
				</parameters>
			</method>
			<method name="get_store_metadata" symbol="tracker_field_get_store_metadata">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
				</parameters>
			</method>
			<method name="get_weight" symbol="tracker_field_get_weight">
				<return-type type="gint"/>
				<parameters>
					<parameter name="service" type="TrackerField*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="tracker_field_new">
				<return-type type="TrackerField*"/>
			</constructor>
			<method name="set_child_ids" symbol="tracker_field_set_child_ids">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
					<parameter name="value" type="GSList*"/>
				</parameters>
			</method>
			<method name="set_data_type" symbol="tracker_field_set_data_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
					<parameter name="value" type="TrackerFieldType"/>
				</parameters>
			</method>
			<method name="set_delimited" symbol="tracker_field_set_delimited">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_embedded" symbol="tracker_field_set_embedded">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_field_name" symbol="tracker_field_set_field_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_filtered" symbol="tracker_field_set_filtered">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_id" symbol="tracker_field_set_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_multiple_values" symbol="tracker_field_set_multiple_values">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_name" symbol="tracker_field_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_store_metadata" symbol="tracker_field_set_store_metadata">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_weight" symbol="tracker_field_set_weight">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="TrackerField*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="type_to_string" symbol="tracker_field_type_to_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="fieldtype" type="TrackerFieldType"/>
				</parameters>
			</method>
			<property name="child-ids" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="data-type" type="TrackerFieldType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="delimited" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="embedded" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="field-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="filtered" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="id" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="multiple-values" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="store-metadata" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="weight" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="TrackerLanguage" parent="GObject" type-name="TrackerLanguage" get-type="tracker_language_get_type">
			<method name="check_exists" symbol="tracker_language_check_exists">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="language_code" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_config" symbol="tracker_language_get_config">
				<return-type type="TrackerConfig*"/>
				<parameters>
					<parameter name="language" type="TrackerLanguage*"/>
				</parameters>
			</method>
			<method name="get_default_code" symbol="tracker_language_get_default_code">
				<return-type type="gchar*"/>
			</method>
			<method name="get_stop_words" symbol="tracker_language_get_stop_words">
				<return-type type="GHashTable*"/>
				<parameters>
					<parameter name="language" type="TrackerLanguage*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="tracker_language_new">
				<return-type type="TrackerLanguage*"/>
				<parameters>
					<parameter name="language" type="TrackerConfig*"/>
				</parameters>
			</constructor>
			<method name="set_config" symbol="tracker_language_set_config">
				<return-type type="void"/>
				<parameters>
					<parameter name="language" type="TrackerLanguage*"/>
					<parameter name="config" type="TrackerConfig*"/>
				</parameters>
			</method>
			<method name="stem_word" symbol="tracker_language_stem_word">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="language" type="TrackerLanguage*"/>
					<parameter name="word" type="gchar*"/>
					<parameter name="word_length" type="gint"/>
				</parameters>
			</method>
			<property name="config" type="TrackerConfig*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="stop-words" type="GHashTable*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="TrackerService" parent="GObject" type-name="TrackerService" get-type="tracker_service_get_type">
			<method name="get_content_metadata" symbol="tracker_service_get_content_metadata">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_db_type" symbol="tracker_service_get_db_type">
				<return-type type="TrackerDBType"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_embedded" symbol="tracker_service_get_embedded">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_enabled" symbol="tracker_service_get_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_has_full_text" symbol="tracker_service_get_has_full_text">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_has_metadata" symbol="tracker_service_get_has_metadata">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_has_thumbs" symbol="tracker_service_get_has_thumbs">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="tracker_service_get_id">
				<return-type type="gint"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_key_metadata" symbol="tracker_service_get_key_metadata">
				<return-type type="GSList*"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="tracker_service_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="tracker_service_get_parent">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_property_prefix" symbol="tracker_service_get_property_prefix">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_show_service_directories" symbol="tracker_service_get_show_service_directories">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<method name="get_show_service_files" symbol="tracker_service_get_show_service_files">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="tracker_service_new">
				<return-type type="TrackerService*"/>
			</constructor>
			<method name="set_content_metadata" symbol="tracker_service_set_content_metadata">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_db_type" symbol="tracker_service_set_db_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="TrackerDBType"/>
				</parameters>
			</method>
			<method name="set_embedded" symbol="tracker_service_set_embedded">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_enabled" symbol="tracker_service_set_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_has_full_text" symbol="tracker_service_set_has_full_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_has_metadata" symbol="tracker_service_set_has_metadata">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_has_thumbs" symbol="tracker_service_set_has_thumbs">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_id" symbol="tracker_service_set_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="set_key_metadata" symbol="tracker_service_set_key_metadata">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="GSList*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="tracker_service_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_parent" symbol="tracker_service_set_parent">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_property_prefix" symbol="tracker_service_set_property_prefix">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_show_service_directories" symbol="tracker_service_set_show_service_directories">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_show_service_files" symbol="tracker_service_set_show_service_files">
				<return-type type="void"/>
				<parameters>
					<parameter name="service" type="TrackerService*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<property name="content-metadata" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="db-type" type="TrackerDBType" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="embedded" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="enabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="has-full-text" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="has-metadata" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="has-thumbs" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="id" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="key-metadata" type="gpointer" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="parent" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="property-prefix" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-service-directories" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-service-files" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
	</namespace>
</api>
