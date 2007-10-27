<?xml version="1.0"?>
<api version="1.0">
	<namespace name="GLib">
		<function name="g_cancel_all_io_jobs" symbol="g_cancel_all_io_jobs">
			<return-type type="void"/>
		</function>
		<function name="g_content_type_can_be_executable" symbol="g_content_type_can_be_executable">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="type" type="char*"/>
			</parameters>
		</function>
		<function name="g_content_type_equals" symbol="g_content_type_equals">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="type1" type="char*"/>
				<parameter name="type2" type="char*"/>
			</parameters>
		</function>
		<function name="g_content_type_get_description" symbol="g_content_type_get_description">
			<return-type type="char*"/>
			<parameters>
				<parameter name="type" type="char*"/>
			</parameters>
		</function>
		<function name="g_content_type_get_icon" symbol="g_content_type_get_icon">
			<return-type type="GIcon*"/>
			<parameters>
				<parameter name="type" type="char*"/>
			</parameters>
		</function>
		<function name="g_content_type_get_mime_type" symbol="g_content_type_get_mime_type">
			<return-type type="char*"/>
			<parameters>
				<parameter name="type" type="char*"/>
			</parameters>
		</function>
		<function name="g_content_type_guess" symbol="g_content_type_guess">
			<return-type type="char*"/>
			<parameters>
				<parameter name="filename" type="char*"/>
				<parameter name="data" type="guchar*"/>
				<parameter name="data_size" type="gsize"/>
				<parameter name="result_uncertain" type="gboolean*"/>
			</parameters>
		</function>
		<function name="g_content_type_is_a" symbol="g_content_type_is_a">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="type" type="char*"/>
				<parameter name="supertype" type="char*"/>
			</parameters>
		</function>
		<function name="g_content_type_is_unknown" symbol="g_content_type_is_unknown">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="type" type="char*"/>
			</parameters>
		</function>
		<function name="g_content_types_get_registered" symbol="g_content_types_get_registered">
			<return-type type="GList*"/>
		</function>
		<function name="g_format_file_size_for_display" symbol="g_format_file_size_for_display">
			<return-type type="char*"/>
			<parameters>
				<parameter name="size" type="goffset"/>
			</parameters>
		</function>
		<function name="g_io_error_from_errno" symbol="g_io_error_from_errno">
			<return-type type="GIOErrorEnum"/>
			<parameters>
				<parameter name="err_no" type="gint"/>
			</parameters>
		</function>
		<function name="g_io_error_quark" symbol="g_io_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="g_io_modules_ensure_loaded" symbol="g_io_modules_ensure_loaded">
			<return-type type="void"/>
			<parameters>
				<parameter name="directory" type="char*"/>
			</parameters>
		</function>
		<function name="g_mount_for_location" symbol="g_mount_for_location">
			<return-type type="void"/>
			<parameters>
				<parameter name="location" type="GFile*"/>
				<parameter name="mount_operation" type="GMountOperation*"/>
				<parameter name="cancellable" type="GCancellable*"/>
				<parameter name="callback" type="GAsyncReadyCallback"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</function>
		<function name="g_mount_for_location_finish" symbol="g_mount_for_location_finish">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="location" type="GFile*"/>
				<parameter name="result" type="GAsyncResult*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="g_pop_current_cancellable" symbol="g_pop_current_cancellable">
			<return-type type="void"/>
			<parameters>
				<parameter name="cancellable" type="GCancellable*"/>
			</parameters>
		</function>
		<function name="g_push_current_cancellable" symbol="g_push_current_cancellable">
			<return-type type="void"/>
			<parameters>
				<parameter name="cancellable" type="GCancellable*"/>
			</parameters>
		</function>
		<function name="g_schedule_io_job" symbol="g_schedule_io_job">
			<return-type type="void"/>
			<parameters>
				<parameter name="job_func" type="GIOJobFunc"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="notify" type="GDestroyNotify"/>
				<parameter name="io_priority" type="gint"/>
				<parameter name="cancellable" type="GCancellable*"/>
			</parameters>
		</function>
		<function name="g_simple_async_report_error_in_idle" symbol="g_simple_async_report_error_in_idle">
			<return-type type="void"/>
			<parameters>
				<parameter name="object" type="GObject*"/>
				<parameter name="callback" type="GAsyncReadyCallback"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="domain" type="GQuark"/>
				<parameter name="code" type="gint"/>
				<parameter name="format" type="char*"/>
			</parameters>
		</function>
		<function name="g_string_append_uri_escaped" symbol="g_string_append_uri_escaped">
			<return-type type="GString*"/>
			<parameters>
				<parameter name="string" type="GString*"/>
				<parameter name="unescaped" type="char*"/>
				<parameter name="reserved_chars_allowed" type="char*"/>
				<parameter name="allow_utf8" type="gboolean"/>
			</parameters>
		</function>
		<function name="g_uri_escape_string" symbol="g_uri_escape_string">
			<return-type type="char*"/>
			<parameters>
				<parameter name="unescaped" type="char*"/>
				<parameter name="reserved_chars_allowed" type="char*"/>
				<parameter name="allow_utf8" type="gboolean"/>
			</parameters>
		</function>
		<function name="g_uri_get_scheme" symbol="g_uri_get_scheme">
			<return-type type="char*"/>
			<parameters>
				<parameter name="uri" type="char*"/>
			</parameters>
		</function>
		<function name="g_uri_unescape_segment" symbol="g_uri_unescape_segment">
			<return-type type="char*"/>
			<parameters>
				<parameter name="escaped_string_start" type="char*"/>
				<parameter name="escaped_string_end" type="char*"/>
				<parameter name="illegal_characters" type="char*"/>
			</parameters>
		</function>
		<function name="g_uri_unescape_string" symbol="g_uri_unescape_string">
			<return-type type="char*"/>
			<parameters>
				<parameter name="escaped_string" type="char*"/>
				<parameter name="illegal_characters" type="char*"/>
			</parameters>
		</function>
		<callback name="GAsyncReadyCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="source_object" type="GObject*"/>
				<parameter name="res" type="GAsyncResult*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GFileProgressCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="current_num_bytes" type="goffset"/>
				<parameter name="total_num_bytes" type="goffset"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GFileReadMoreCallback">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="file_contents" type="char*"/>
				<parameter name="file_size" type="goffset"/>
				<parameter name="callback_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GIODataFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GIOJobFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="job" type="GIOJob*"/>
				<parameter name="cancellable" type="GCancellable*"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<callback name="GSimpleAsyncThreadFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="res" type="GSimpleAsyncResult*"/>
				<parameter name="object" type="GObject*"/>
				<parameter name="cancellable" type="GCancellable*"/>
			</parameters>
		</callback>
		<struct name="GFileAttributeInfo">
			<field name="name" type="char*"/>
			<field name="type" type="GFileAttributeType"/>
			<field name="flags" type="GFileAttributeFlags"/>
		</struct>
		<struct name="GFileAttributeInfoList">
			<method name="add" symbol="g_file_attribute_info_list_add">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GFileAttributeInfoList*"/>
					<parameter name="name" type="char*"/>
					<parameter name="type" type="GFileAttributeType"/>
					<parameter name="flags" type="GFileAttributeFlags"/>
				</parameters>
			</method>
			<method name="dup" symbol="g_file_attribute_info_list_dup">
				<return-type type="GFileAttributeInfoList*"/>
				<parameters>
					<parameter name="list" type="GFileAttributeInfoList*"/>
				</parameters>
			</method>
			<method name="lookup" symbol="g_file_attribute_info_list_lookup">
				<return-type type="GFileAttributeInfo*"/>
				<parameters>
					<parameter name="list" type="GFileAttributeInfoList*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="new" symbol="g_file_attribute_info_list_new">
				<return-type type="GFileAttributeInfoList*"/>
			</method>
			<method name="ref" symbol="g_file_attribute_info_list_ref">
				<return-type type="GFileAttributeInfoList*"/>
				<parameters>
					<parameter name="list" type="GFileAttributeInfoList*"/>
				</parameters>
			</method>
			<method name="unref" symbol="g_file_attribute_info_list_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GFileAttributeInfoList*"/>
				</parameters>
			</method>
			<field name="infos" type="GFileAttributeInfo*"/>
			<field name="n_infos" type="int"/>
		</struct>
		<struct name="GFileAttributeMatcher">
			<method name="enumerate_namespace" symbol="g_file_attribute_matcher_enumerate_namespace">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="matcher" type="GFileAttributeMatcher*"/>
					<parameter name="ns" type="char*"/>
				</parameters>
			</method>
			<method name="enumerate_next" symbol="g_file_attribute_matcher_enumerate_next">
				<return-type type="char*"/>
				<parameters>
					<parameter name="matcher" type="GFileAttributeMatcher*"/>
				</parameters>
			</method>
			<method name="matches" symbol="g_file_attribute_matcher_matches">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="matcher" type="GFileAttributeMatcher*"/>
					<parameter name="full_name" type="char*"/>
				</parameters>
			</method>
			<method name="matches_only" symbol="g_file_attribute_matcher_matches_only">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="matcher" type="GFileAttributeMatcher*"/>
					<parameter name="full_name" type="char*"/>
				</parameters>
			</method>
			<method name="new" symbol="g_file_attribute_matcher_new">
				<return-type type="GFileAttributeMatcher*"/>
				<parameters>
					<parameter name="attributes" type="char*"/>
				</parameters>
			</method>
			<method name="ref" symbol="g_file_attribute_matcher_ref">
				<return-type type="GFileAttributeMatcher*"/>
				<parameters>
					<parameter name="matcher" type="GFileAttributeMatcher*"/>
				</parameters>
			</method>
			<method name="unref" symbol="g_file_attribute_matcher_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="matcher" type="GFileAttributeMatcher*"/>
				</parameters>
			</method>
		</struct>
		<struct name="GFileAttributeValue">
			<method name="as_string" symbol="g_file_attribute_value_as_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="clear" symbol="g_file_attribute_value_clear">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="dup" symbol="g_file_attribute_value_dup">
				<return-type type="GFileAttributeValue*"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="free" symbol="g_file_attribute_value_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="get_boolean" symbol="g_file_attribute_value_get_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="get_byte_string" symbol="g_file_attribute_value_get_byte_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="get_int32" symbol="g_file_attribute_value_get_int32">
				<return-type type="gint32"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="get_int64" symbol="g_file_attribute_value_get_int64">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="get_object" symbol="g_file_attribute_value_get_object">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="get_string" symbol="g_file_attribute_value_get_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="get_uint32" symbol="g_file_attribute_value_get_uint32">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="get_uint64" symbol="g_file_attribute_value_get_uint64">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="new" symbol="g_file_attribute_value_new">
				<return-type type="GFileAttributeValue*"/>
			</method>
			<method name="set" symbol="g_file_attribute_value_set">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
					<parameter name="new_value" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="set_boolean" symbol="g_file_attribute_value_set_boolean">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_byte_string" symbol="g_file_attribute_value_set_byte_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_int32" symbol="g_file_attribute_value_set_int32">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
					<parameter name="value" type="gint32"/>
				</parameters>
			</method>
			<method name="set_int64" symbol="g_file_attribute_value_set_int64">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
					<parameter name="value" type="gint64"/>
				</parameters>
			</method>
			<method name="set_object" symbol="g_file_attribute_value_set_object">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
					<parameter name="obj" type="GObject*"/>
				</parameters>
			</method>
			<method name="set_string" symbol="g_file_attribute_value_set_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_uint32" symbol="g_file_attribute_value_set_uint32">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
					<parameter name="value" type="guint32"/>
				</parameters>
			</method>
			<method name="set_uint64" symbol="g_file_attribute_value_set_uint64">
				<return-type type="void"/>
				<parameters>
					<parameter name="attr" type="GFileAttributeValue*"/>
					<parameter name="value" type="guint64"/>
				</parameters>
			</method>
			<field name="type" type="GFileAttributeType"/>
			<field name="status" type="GFileAttributeStatus"/>
			<field name="u" type="gpointer"/>
		</struct>
		<struct name="GIOJob">
			<method name="send_to_mainloop" symbol="g_io_job_send_to_mainloop">
				<return-type type="void"/>
				<parameters>
					<parameter name="job" type="GIOJob*"/>
					<parameter name="func" type="GIODataFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="notify" type="GDestroyNotify"/>
					<parameter name="block" type="gboolean"/>
				</parameters>
			</method>
		</struct>
		<struct name="GIOModuleClass">
		</struct>
		<enum name="GAppInfoCreateFlags">
			<member name="G_APP_INFO_CREATE_FLAGS_NONE" value="0"/>
			<member name="G_APP_INFO_CREATE_NEEDS_TERMINAL" value="1"/>
		</enum>
		<enum name="GDataStreamByteOrder">
			<member name="G_DATA_STREAM_BYTE_ORDER_BIG_ENDIAN" value="0"/>
			<member name="G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN" value="1"/>
			<member name="G_DATA_STREAM_BYTE_ORDER_HOST_ENDIAN" value="2"/>
		</enum>
		<enum name="GDataStreamNewlineType">
			<member name="G_DATA_STREAM_NEWLINE_TYPE_LF" value="0"/>
			<member name="G_DATA_STREAM_NEWLINE_TYPE_CR" value="1"/>
			<member name="G_DATA_STREAM_NEWLINE_TYPE_CR_LF" value="2"/>
			<member name="G_DATA_STREAM_NEWLINE_TYPE_ANY" value="3"/>
		</enum>
		<enum name="GFileAttributeFlags">
			<member name="G_FILE_ATTRIBUTE_FLAGS_NONE" value="0"/>
			<member name="G_FILE_ATTRIBUTE_FLAGS_COPY_WITH_FILE" value="1"/>
			<member name="G_FILE_ATTRIBUTE_FLAGS_COPY_WHEN_MOVED" value="2"/>
		</enum>
		<enum name="GFileAttributeStatus">
			<member name="G_FILE_ATTRIBUTE_STATUS_UNSET" value="0"/>
			<member name="G_FILE_ATTRIBUTE_STATUS_SET" value="1"/>
			<member name="G_FILE_ATTRIBUTE_STATUS_ERROR_SETTING" value="2"/>
		</enum>
		<enum name="GFileAttributeType">
			<member name="G_FILE_ATTRIBUTE_TYPE_INVALID" value="0"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_STRING" value="1"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_BYTE_STRING" value="2"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_BOOLEAN" value="3"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_UINT32" value="4"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_INT32" value="5"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_UINT64" value="6"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_INT64" value="7"/>
			<member name="G_FILE_ATTRIBUTE_TYPE_OBJECT" value="8"/>
		</enum>
		<enum name="GFileCopyFlags">
			<member name="G_FILE_COPY_OVERWRITE" value="1"/>
			<member name="G_FILE_COPY_BACKUP" value="2"/>
			<member name="G_FILE_COPY_NOFOLLOW_SYMLINKS" value="4"/>
			<member name="G_FILE_COPY_ALL_METADATA" value="8"/>
		</enum>
		<enum name="GFileCreateFlags">
			<member name="G_FILE_CREATE_FLAGS_NONE" value="0"/>
			<member name="G_FILE_CREATE_FLAGS_PRIVATE" value="1"/>
		</enum>
		<enum name="GFileMonitorEvent">
			<member name="G_FILE_MONITOR_EVENT_CHANGED" value="0"/>
			<member name="G_FILE_MONITOR_EVENT_CHANGES_DONE_HINT" value="1"/>
			<member name="G_FILE_MONITOR_EVENT_DELETED" value="2"/>
			<member name="G_FILE_MONITOR_EVENT_CREATED" value="3"/>
			<member name="G_FILE_MONITOR_EVENT_ATTRIBUTE_CHANGED" value="4"/>
			<member name="G_FILE_MONITOR_EVENT_PRE_UNMOUNT" value="5"/>
			<member name="G_FILE_MONITOR_EVENT_UNMOUNTED" value="6"/>
		</enum>
		<enum name="GFileMonitorFlags">
			<member name="G_FILE_MONITOR_FLAGS_NONE" value="0"/>
			<member name="G_FILE_MONITOR_FLAGS_MONITOR_MOUNTS" value="1"/>
		</enum>
		<enum name="GFileQueryInfoFlags">
			<member name="G_FILE_QUERY_INFO_NOFOLLOW_SYMLINKS" value="1"/>
		</enum>
		<enum name="GFileType">
			<member name="G_FILE_TYPE_UNKNOWN" value="0"/>
			<member name="G_FILE_TYPE_REGULAR" value="1"/>
			<member name="G_FILE_TYPE_DIRECTORY" value="2"/>
			<member name="G_FILE_TYPE_SYMBOLIC_LINK" value="3"/>
			<member name="G_FILE_TYPE_SPECIAL" value="4"/>
			<member name="G_FILE_TYPE_SHORTCUT" value="5"/>
			<member name="G_FILE_TYPE_MOUNTABLE" value="6"/>
		</enum>
		<enum name="GIOErrorEnum">
			<member name="G_IO_ERROR_FAILED" value="0"/>
			<member name="G_IO_ERROR_NOT_FOUND" value="1"/>
			<member name="G_IO_ERROR_EXISTS" value="2"/>
			<member name="G_IO_ERROR_IS_DIRECTORY" value="3"/>
			<member name="G_IO_ERROR_NOT_DIRECTORY" value="4"/>
			<member name="G_IO_ERROR_NOT_EMPTY" value="5"/>
			<member name="G_IO_ERROR_NOT_REGULAR_FILE" value="6"/>
			<member name="G_IO_ERROR_NOT_SYMBOLIC_LINK" value="7"/>
			<member name="G_IO_ERROR_NOT_MOUNTABLE_FILE" value="8"/>
			<member name="G_IO_ERROR_FILENAME_TOO_LONG" value="9"/>
			<member name="G_IO_ERROR_INVALID_FILENAME" value="10"/>
			<member name="G_IO_ERROR_TOO_MANY_LINKS" value="11"/>
			<member name="G_IO_ERROR_NO_SPACE" value="12"/>
			<member name="G_IO_ERROR_INVALID_ARGUMENT" value="13"/>
			<member name="G_IO_ERROR_PERMISSION_DENIED" value="14"/>
			<member name="G_IO_ERROR_NOT_SUPPORTED" value="15"/>
			<member name="G_IO_ERROR_NOT_MOUNTED" value="16"/>
			<member name="G_IO_ERROR_ALREADY_MOUNTED" value="17"/>
			<member name="G_IO_ERROR_CLOSED" value="18"/>
			<member name="G_IO_ERROR_CANCELLED" value="19"/>
			<member name="G_IO_ERROR_PENDING" value="20"/>
			<member name="G_IO_ERROR_READ_ONLY" value="21"/>
			<member name="G_IO_ERROR_CANT_CREATE_BACKUP" value="22"/>
			<member name="G_IO_ERROR_WRONG_ETAG" value="23"/>
			<member name="G_IO_ERROR_TIMED_OUT" value="24"/>
			<member name="G_IO_ERROR_WOULD_RECURSE" value="25"/>
			<member name="G_IO_ERROR_BUSY" value="26"/>
			<member name="G_IO_ERROR_WOULD_BLOCK" value="27"/>
			<member name="G_IO_ERROR_HOST_NOT_FOUND" value="28"/>
		</enum>
		<enum name="GPasswordFlags">
			<member name="G_PASSWORD_FLAGS_NEED_PASSWORD" value="1"/>
			<member name="G_PASSWORD_FLAGS_NEED_USERNAME" value="2"/>
			<member name="G_PASSWORD_FLAGS_NEED_DOMAIN" value="4"/>
			<member name="G_PASSWORD_FLAGS_SAVING_SUPPORTED" value="16"/>
			<member name="G_PASSWORD_FLAGS_ANON_SUPPORTED" value="32"/>
		</enum>
		<enum name="GPasswordSave">
			<member name="G_PASSWORD_SAVE_NEVER" value="0"/>
			<member name="G_PASSWORD_SAVE_FOR_SESSION" value="1"/>
			<member name="G_PASSWORD_SAVE_PERMANENTLY" value="2"/>
		</enum>
		<object name="GBufferedInputStream" parent="GFilterInputStream" type-name="GBufferedInputStream" get-type="g_buffered_input_stream_get_type">
			<method name="fill" symbol="g_buffered_input_stream_fill">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="count" type="gssize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="fill_async" symbol="g_buffered_input_stream_fill_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="count" type="gssize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="fill_finish" symbol="g_buffered_input_stream_fill_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_availible" symbol="g_buffered_input_stream_get_availible">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
				</parameters>
			</method>
			<method name="get_buffer_size" symbol="g_buffered_input_stream_get_buffer_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_buffered_input_stream_new">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GInputStream*"/>
				</parameters>
			</constructor>
			<constructor name="new_sized" symbol="g_buffered_input_stream_new_sized">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GInputStream*"/>
					<parameter name="size" type="gsize"/>
				</parameters>
			</constructor>
			<method name="peek" symbol="g_buffered_input_stream_peek">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="offset" type="gsize"/>
					<parameter name="count" type="gsize"/>
				</parameters>
			</method>
			<method name="set_buffer_size" symbol="g_buffered_input_stream_set_buffer_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="size" type="gsize"/>
				</parameters>
			</method>
			<property name="buffer-size" type="guint"/>
			<vfunc name="fill">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="count" type="gssize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="fill_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="count" type="gssize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="fill_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GBufferedInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GBufferedOutputStream" parent="GFilterOutputStream" type-name="GBufferedOutputStream" get-type="g_buffered_output_stream_get_type">
			<method name="get_auto_grow" symbol="g_buffered_output_stream_get_auto_grow">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GBufferedOutputStream*"/>
				</parameters>
			</method>
			<method name="get_buffer_size" symbol="g_buffered_output_stream_get_buffer_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="stream" type="GBufferedOutputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_buffered_output_stream_new">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GOutputStream*"/>
				</parameters>
			</constructor>
			<constructor name="new_sized" symbol="g_buffered_output_stream_new_sized">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GOutputStream*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</constructor>
			<method name="set_auto_grow" symbol="g_buffered_output_stream_set_auto_grow">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GBufferedOutputStream*"/>
					<parameter name="auto_grow" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_buffer_size" symbol="g_buffered_output_stream_set_buffer_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GBufferedOutputStream*"/>
					<parameter name="size" type="gsize"/>
				</parameters>
			</method>
			<property name="buffer-size" type="guint"/>
		</object>
		<object name="GCancellable" parent="GObject" type-name="GCancellable" get-type="g_cancellable_get_type">
			<method name="cancel" symbol="g_cancellable_cancel">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="get_current" symbol="g_cancellable_get_current">
				<return-type type="GCancellable*"/>
			</method>
			<method name="get_fd" symbol="g_cancellable_get_fd">
				<return-type type="int"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="is_cancelled" symbol="g_cancellable_is_cancelled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_cancellable_new">
				<return-type type="GCancellable*"/>
			</constructor>
			<method name="reset" symbol="g_cancellable_reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="set_error_if_cancelled" symbol="g_cancellable_set_error_if_cancelled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<signal name="cancelled" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</signal>
		</object>
		<object name="GDataInputStream" parent="GBufferedInputStream" type-name="GDataInputStream" get-type="g_data_input_stream_get_type">
			<method name="get_byte_order" symbol="g_data_input_stream_get_byte_order">
				<return-type type="GDataStreamByteOrder"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
				</parameters>
			</method>
			<method name="get_newline_type" symbol="g_data_input_stream_get_newline_type">
				<return-type type="GDataStreamNewlineType"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_data_input_stream_new">
				<return-type type="GDataInputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GInputStream*"/>
				</parameters>
			</constructor>
			<method name="read_byte" symbol="g_data_input_stream_read_byte">
				<return-type type="guchar"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_int16" symbol="g_data_input_stream_read_int16">
				<return-type type="gint16"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_int32" symbol="g_data_input_stream_read_int32">
				<return-type type="gint32"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_int64" symbol="g_data_input_stream_read_int64">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_line" symbol="g_data_input_stream_read_line">
				<return-type type="char*"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_uint16" symbol="g_data_input_stream_read_uint16">
				<return-type type="guint16"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_uint32" symbol="g_data_input_stream_read_uint32">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_uint64" symbol="g_data_input_stream_read_uint64">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_until" symbol="g_data_input_stream_read_until">
				<return-type type="char*"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
					<parameter name="stop_char" type="gchar"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_byte_order" symbol="g_data_input_stream_set_byte_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
					<parameter name="order" type="GDataStreamByteOrder"/>
				</parameters>
			</method>
			<method name="set_newline_type" symbol="g_data_input_stream_set_newline_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="data_stream" type="GDataInputStream*"/>
					<parameter name="type" type="GDataStreamNewlineType"/>
				</parameters>
			</method>
		</object>
		<object name="GDataOutputStream" parent="GFilterOutputStream" type-name="GDataOutputStream" get-type="g_data_output_stream_get_type">
			<method name="get_byte_order" symbol="g_data_output_stream_get_byte_order">
				<return-type type="GDataStreamByteOrder"/>
				<parameters>
					<parameter name="data_stream" type="GDataOutputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_data_output_stream_new">
				<return-type type="GDataOutputStream*"/>
				<parameters>
					<parameter name="base_stream" type="GOutputStream*"/>
				</parameters>
			</constructor>
			<method name="put_byte" symbol="g_data_output_stream_put_byte">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="data_stream" type="GDataOutputStream*"/>
					<parameter name="data" type="guchar"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_int16" symbol="g_data_output_stream_put_int16">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="data_stream" type="GDataOutputStream*"/>
					<parameter name="data" type="gint16"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_int32" symbol="g_data_output_stream_put_int32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="data_stream" type="GDataOutputStream*"/>
					<parameter name="data" type="gint32"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_int64" symbol="g_data_output_stream_put_int64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="data_stream" type="GDataOutputStream*"/>
					<parameter name="data" type="gint64"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_string" symbol="g_data_output_stream_put_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="data_stream" type="GDataOutputStream*"/>
					<parameter name="str" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_uint16" symbol="g_data_output_stream_put_uint16">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="data_stream" type="GDataOutputStream*"/>
					<parameter name="data" type="guint16"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_uint32" symbol="g_data_output_stream_put_uint32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="data_stream" type="GDataOutputStream*"/>
					<parameter name="data" type="guint32"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="put_uint64" symbol="g_data_output_stream_put_uint64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="data_stream" type="GDataOutputStream*"/>
					<parameter name="data" type="guint64"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_byte_order" symbol="g_data_output_stream_set_byte_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="data_stream" type="GDataOutputStream*"/>
					<parameter name="order" type="GDataStreamByteOrder"/>
				</parameters>
			</method>
			<method name="set_expand_buffer" symbol="g_data_output_stream_set_expand_buffer">
				<return-type type="void"/>
				<parameters>
					<parameter name="data_stream" type="GDataOutputStream*"/>
					<parameter name="expand_buffer" type="gboolean"/>
				</parameters>
			</method>
		</object>
		<object name="GDirectoryMonitor" parent="GObject" type-name="GDirectoryMonitor" get-type="g_directory_monitor_get_type">
			<method name="cancel" symbol="g_directory_monitor_cancel">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="monitor" type="GDirectoryMonitor*"/>
				</parameters>
			</method>
			<method name="emit_event" symbol="g_directory_monitor_emit_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="GDirectoryMonitor*"/>
					<parameter name="child" type="GFile*"/>
					<parameter name="other_file" type="GFile*"/>
					<parameter name="event_type" type="GFileMonitorEvent"/>
				</parameters>
			</method>
			<method name="is_cancelled" symbol="g_directory_monitor_is_cancelled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="monitor" type="GDirectoryMonitor*"/>
				</parameters>
			</method>
			<method name="set_rate_limit" symbol="g_directory_monitor_set_rate_limit">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="GDirectoryMonitor*"/>
					<parameter name="limit_msecs" type="int"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="GDirectoryMonitor*"/>
					<parameter name="child" type="GFile*"/>
					<parameter name="other_file" type="GFile*"/>
					<parameter name="event_type" type="gint"/>
				</parameters>
			</signal>
			<vfunc name="cancel">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="monitor" type="GDirectoryMonitor*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GDummyFile" parent="GObject" type-name="GDummyFile" get-type="g_dummy_file_get_type">
			<implements>
				<interface name="GFile"/>
			</implements>
			<constructor name="new" symbol="g_dummy_file_new">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="uri" type="char*"/>
				</parameters>
			</constructor>
		</object>
		<object name="GFileEnumerator" parent="GObject" type-name="GFileEnumerator" get-type="g_file_enumerator_get_type">
			<method name="close" symbol="g_file_enumerator_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="close_async" symbol="g_file_enumerator_close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="close_finish" symbol="g_file_enumerator_close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="has_pending" symbol="g_file_enumerator_has_pending">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
				</parameters>
			</method>
			<method name="is_closed" symbol="g_file_enumerator_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
				</parameters>
			</method>
			<method name="next_file" symbol="g_file_enumerator_next_file">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="next_files_async" symbol="g_file_enumerator_next_files_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="num_files" type="int"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="next_files_finish" symbol="g_file_enumerator_next_files_finish">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_pending" symbol="g_file_enumerator_set_pending">
				<return-type type="void"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="pending" type="gboolean"/>
				</parameters>
			</method>
			<vfunc name="close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="next_file">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="next_files_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="num_files" type="int"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="next_files_finish">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="enumerator" type="GFileEnumerator*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GFileIcon" parent="GObject" type-name="GFileIcon" get-type="g_file_icon_get_type">
			<implements>
				<interface name="GIcon"/>
				<interface name="GLoadableIcon"/>
			</implements>
			<method name="get_file" symbol="g_file_icon_get_file">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="icon" type="GFileIcon*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_file_icon_new">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</constructor>
		</object>
		<object name="GFileInfo" parent="GObject" type-name="GFileInfo" get-type="g_file_info_get_type">
			<method name="clear_status" symbol="g_file_info_clear_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="copy_into" symbol="g_file_info_copy_into">
				<return-type type="void"/>
				<parameters>
					<parameter name="src" type="GFileInfo*"/>
					<parameter name="dest" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="dup" symbol="g_file_info_dup">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_attribute" symbol="g_file_info_get_attribute">
				<return-type type="GFileAttributeValue*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_boolean" symbol="g_file_info_get_attribute_boolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_byte_string" symbol="g_file_info_get_attribute_byte_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_int32" symbol="g_file_info_get_attribute_int32">
				<return-type type="gint32"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_int64" symbol="g_file_info_get_attribute_int64">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_object" symbol="g_file_info_get_attribute_object">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_string" symbol="g_file_info_get_attribute_string">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_type" symbol="g_file_info_get_attribute_type">
				<return-type type="GFileAttributeType"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_uint32" symbol="g_file_info_get_attribute_uint32">
				<return-type type="guint32"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_attribute_uint64" symbol="g_file_info_get_attribute_uint64">
				<return-type type="guint64"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="get_content_type" symbol="g_file_info_get_content_type">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_display_name" symbol="g_file_info_get_display_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_edit_name" symbol="g_file_info_get_edit_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_etag" symbol="g_file_info_get_etag">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_file_type" symbol="g_file_info_get_file_type">
				<return-type type="GFileType"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="g_file_info_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_is_backup" symbol="g_file_info_get_is_backup">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_is_hidden" symbol="g_file_info_get_is_hidden">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_is_symlink" symbol="g_file_info_get_is_symlink">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_modification_time" symbol="g_file_info_get_modification_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="result" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="g_file_info_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="g_file_info_get_size">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_sort_order" symbol="g_file_info_get_sort_order">
				<return-type type="gint32"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="get_symlink_target" symbol="g_file_info_get_symlink_target">
				<return-type type="char*"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
			<method name="has_attribute" symbol="g_file_info_has_attribute">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="list_attributes" symbol="g_file_info_list_attributes">
				<return-type type="char**"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="name_space" type="char*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_file_info_new">
				<return-type type="GFileInfo*"/>
			</constructor>
			<method name="remove_attribute" symbol="g_file_info_remove_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
				</parameters>
			</method>
			<method name="set_attribute" symbol="g_file_info_set_attribute">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="GFileAttributeValue*"/>
				</parameters>
			</method>
			<method name="set_attribute_boolean" symbol="g_file_info_set_attribute_boolean">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_attribute_byte_string" symbol="g_file_info_set_attribute_byte_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_attribute_int32" symbol="g_file_info_set_attribute_int32">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="gint32"/>
				</parameters>
			</method>
			<method name="set_attribute_int64" symbol="g_file_info_set_attribute_int64">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="gint64"/>
				</parameters>
			</method>
			<method name="set_attribute_mask" symbol="g_file_info_set_attribute_mask">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="mask" type="GFileAttributeMatcher*"/>
				</parameters>
			</method>
			<method name="set_attribute_object" symbol="g_file_info_set_attribute_object">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="GObject*"/>
				</parameters>
			</method>
			<method name="set_attribute_string" symbol="g_file_info_set_attribute_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="char*"/>
				</parameters>
			</method>
			<method name="set_attribute_uint32" symbol="g_file_info_set_attribute_uint32">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="guint32"/>
				</parameters>
			</method>
			<method name="set_attribute_uint64" symbol="g_file_info_set_attribute_uint64">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="guint64"/>
				</parameters>
			</method>
			<method name="set_content_type" symbol="g_file_info_set_content_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="content_type" type="char*"/>
				</parameters>
			</method>
			<method name="set_display_name" symbol="g_file_info_set_display_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="display_name" type="char*"/>
				</parameters>
			</method>
			<method name="set_edit_name" symbol="g_file_info_set_edit_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="edit_name" type="char*"/>
				</parameters>
			</method>
			<method name="set_file_type" symbol="g_file_info_set_file_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="type" type="GFileType"/>
				</parameters>
			</method>
			<method name="set_icon" symbol="g_file_info_set_icon">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="icon" type="GIcon*"/>
				</parameters>
			</method>
			<method name="set_is_hidden" symbol="g_file_info_set_is_hidden">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="is_hidden" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_is_symlink" symbol="g_file_info_set_is_symlink">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="is_symlink" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_modification_time" symbol="g_file_info_set_modification_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="mtime" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="g_file_info_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_size" symbol="g_file_info_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="size" type="goffset"/>
				</parameters>
			</method>
			<method name="set_sort_order" symbol="g_file_info_set_sort_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="sort_order" type="gint32"/>
				</parameters>
			</method>
			<method name="set_symlink_target" symbol="g_file_info_set_symlink_target">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="symlink_target" type="char*"/>
				</parameters>
			</method>
			<method name="unset_attribute_mask" symbol="g_file_info_unset_attribute_mask">
				<return-type type="void"/>
				<parameters>
					<parameter name="info" type="GFileInfo*"/>
				</parameters>
			</method>
		</object>
		<object name="GFileInputStream" parent="GInputStream" type-name="GFileInputStream" get-type="g_file_input_stream_get_type">
			<implements>
				<interface name="GSeekable"/>
			</implements>
			<method name="can_seek" symbol="g_file_input_stream_can_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
				</parameters>
			</method>
			<method name="query_info" symbol="g_file_input_stream_query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_info_async" symbol="g_file_input_stream_query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_info_finish" symbol="g_file_input_stream_query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="seek" symbol="g_file_input_stream_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="type" type="GSeekType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="tell" symbol="g_file_input_stream_tell">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
				</parameters>
			</method>
			<vfunc name="can_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="type" type="GSeekType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="tell">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="stream" type="GFileInputStream*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GFileMonitor" parent="GObject" type-name="GFileMonitor" get-type="g_file_monitor_get_type">
			<method name="cancel" symbol="g_file_monitor_cancel">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="monitor" type="GFileMonitor*"/>
				</parameters>
			</method>
			<method name="directory" symbol="g_file_monitor_directory">
				<return-type type="GDirectoryMonitor*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileMonitorFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="emit_event" symbol="g_file_monitor_emit_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="GFileMonitor*"/>
					<parameter name="file" type="GFile*"/>
					<parameter name="other_file" type="GFile*"/>
					<parameter name="event_type" type="GFileMonitorEvent"/>
				</parameters>
			</method>
			<method name="file" symbol="g_file_monitor_file">
				<return-type type="GFileMonitor*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileMonitorFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="is_cancelled" symbol="g_file_monitor_is_cancelled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="monitor" type="GFileMonitor*"/>
				</parameters>
			</method>
			<method name="set_rate_limit" symbol="g_file_monitor_set_rate_limit">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="GFileMonitor*"/>
					<parameter name="limit_msecs" type="int"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="monitor" type="GFileMonitor*"/>
					<parameter name="file" type="GFile*"/>
					<parameter name="other_file" type="GFile*"/>
					<parameter name="event_type" type="gint"/>
				</parameters>
			</signal>
			<vfunc name="cancel">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="monitor" type="GFileMonitor*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GFileOutputStream" parent="GOutputStream" type-name="GFileOutputStream" get-type="g_file_output_stream_get_type">
			<implements>
				<interface name="GSeekable"/>
			</implements>
			<method name="can_seek" symbol="g_file_output_stream_can_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</method>
			<method name="can_truncate" symbol="g_file_output_stream_can_truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</method>
			<method name="get_etag" symbol="g_file_output_stream_get_etag">
				<return-type type="char*"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</method>
			<method name="query_info" symbol="g_file_output_stream_query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_info_async" symbol="g_file_output_stream_query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_info_finish" symbol="g_file_output_stream_query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="seek" symbol="g_file_output_stream_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="type" type="GSeekType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="tell" symbol="g_file_output_stream_tell">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</method>
			<method name="truncate" symbol="g_file_output_stream_truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="size" type="goffset"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="can_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_etag">
				<return-type type="char*"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="type" type="GSeekType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="tell">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
				</parameters>
			</vfunc>
			<vfunc name="truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GFileOutputStream*"/>
					<parameter name="size" type="goffset"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GFilenameCompleter" parent="GObject" type-name="GFilenameCompleter" get-type="g_filename_completer_get_type">
			<method name="get_completion_suffix" symbol="g_filename_completer_get_completion_suffix">
				<return-type type="char*"/>
				<parameters>
					<parameter name="completer" type="GFilenameCompleter*"/>
					<parameter name="initial_text" type="char*"/>
				</parameters>
			</method>
			<method name="get_completions" symbol="g_filename_completer_get_completions">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="completer" type="GFilenameCompleter*"/>
					<parameter name="initial_text" type="char*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_filename_completer_new">
				<return-type type="GFilenameCompleter*"/>
			</constructor>
			<method name="set_dirs_only" symbol="g_filename_completer_set_dirs_only">
				<return-type type="void"/>
				<parameters>
					<parameter name="completer" type="GFilenameCompleter*"/>
					<parameter name="dirs_only" type="gboolean"/>
				</parameters>
			</method>
			<signal name="got-completion-data" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="filename_completer" type="GFilenameCompleter*"/>
				</parameters>
			</signal>
		</object>
		<object name="GFilterInputStream" parent="GInputStream" type-name="GFilterInputStream" get-type="g_filter_input_stream_get_type">
			<method name="get_base_stream" symbol="g_filter_input_stream_get_base_stream">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="stream" type="GFilterInputStream*"/>
				</parameters>
			</method>
			<property name="base-stream" type="GInputStream*"/>
			<field name="base_stream" type="GInputStream*"/>
		</object>
		<object name="GFilterOutputStream" parent="GOutputStream" type-name="GFilterOutputStream" get-type="g_filter_output_stream_get_type">
			<method name="get_base_stream" symbol="g_filter_output_stream_get_base_stream">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="stream" type="GFilterOutputStream*"/>
				</parameters>
			</method>
			<property name="base-stream" type="GOutputStream*"/>
			<field name="base_stream" type="GOutputStream*"/>
		</object>
		<object name="GIOModule" parent="GTypeModule" type-name="GIOModule" get-type="g_io_module_get_type">
			<implements>
				<interface name="GTypePlugin"/>
			</implements>
			<method name="load" symbol="g_io_module_load">
				<return-type type="void"/>
				<parameters>
					<parameter name="module" type="GIOModule*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_io_module_new">
				<return-type type="GIOModule*"/>
				<parameters>
					<parameter name="filename" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="unload" symbol="g_io_module_unload">
				<return-type type="void"/>
				<parameters>
					<parameter name="module" type="GIOModule*"/>
				</parameters>
			</method>
		</object>
		<object name="GInputStream" parent="GObject" type-name="GInputStream" get-type="g_input_stream_get_type">
			<method name="close" symbol="g_input_stream_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="close_async" symbol="g_input_stream_close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="close_finish" symbol="g_input_stream_close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="has_pending" symbol="g_input_stream_has_pending">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
				</parameters>
			</method>
			<method name="is_closed" symbol="g_input_stream_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
				</parameters>
			</method>
			<method name="read" symbol="g_input_stream_read">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_all" symbol="g_input_stream_read_all">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="bytes_read" type="gsize*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_async" symbol="g_input_stream_read_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="read_finish" symbol="g_input_stream_read_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_pending" symbol="g_input_stream_set_pending">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="pending" type="gboolean"/>
				</parameters>
			</method>
			<method name="skip" symbol="g_input_stream_skip">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="skip_async" symbol="g_input_stream_skip_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="skip_finish" symbol="g_input_stream_skip_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="read">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="read_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="read_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="skip">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="skip_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="skip_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GInputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GMemoryInputStream" parent="GInputStream" type-name="GMemoryInputStream" get-type="g_memory_input_stream_get_type">
			<implements>
				<interface name="GSeekable"/>
			</implements>
			<method name="from_data" symbol="g_memory_input_stream_from_data">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="data" type="void*"/>
					<parameter name="len" type="gssize"/>
				</parameters>
			</method>
			<method name="get_data" symbol="g_memory_input_stream_get_data">
				<return-type type="void*"/>
				<parameters>
					<parameter name="stream" type="GMemoryInputStream*"/>
				</parameters>
			</method>
			<method name="get_data_size" symbol="g_memory_input_stream_get_data_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="stream" type="GMemoryInputStream*"/>
				</parameters>
			</method>
			<method name="set_free_data" symbol="g_memory_input_stream_set_free_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GMemoryInputStream*"/>
					<parameter name="free_data" type="gboolean"/>
				</parameters>
			</method>
		</object>
		<object name="GMemoryOutputStream" parent="GOutputStream" type-name="GMemoryOutputStream" get-type="g_memory_output_stream_get_type">
			<implements>
				<interface name="GSeekable"/>
			</implements>
			<method name="get_data" symbol="g_memory_output_stream_get_data">
				<return-type type="GByteArray*"/>
				<parameters>
					<parameter name="ostream" type="GMemoryOutputStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_memory_output_stream_new">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="data" type="GByteArray*"/>
				</parameters>
			</constructor>
			<method name="set_free_on_close" symbol="g_memory_output_stream_set_free_on_close">
				<return-type type="void"/>
				<parameters>
					<parameter name="ostream" type="GMemoryOutputStream*"/>
					<parameter name="free_on_close" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_max_size" symbol="g_memory_output_stream_set_max_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="ostream" type="GMemoryOutputStream*"/>
					<parameter name="max_size" type="guint"/>
				</parameters>
			</method>
			<property name="data" type="gpointer"/>
			<property name="free-array" type="gboolean"/>
			<property name="size-limit" type="guint"/>
		</object>
		<object name="GMountOperation" parent="GObject" type-name="GMountOperation" get-type="g_mount_operation_get_type">
			<method name="get_anonymous" symbol="g_mount_operation_get_anonymous">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</method>
			<method name="get_choice" symbol="g_mount_operation_get_choice">
				<return-type type="int"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</method>
			<method name="get_domain" symbol="g_mount_operation_get_domain">
				<return-type type="char*"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</method>
			<method name="get_password" symbol="g_mount_operation_get_password">
				<return-type type="char*"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</method>
			<method name="get_password_save" symbol="g_mount_operation_get_password_save">
				<return-type type="GPasswordSave"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</method>
			<method name="get_username" symbol="g_mount_operation_get_username">
				<return-type type="char*"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_mount_operation_new">
				<return-type type="GMountOperation*"/>
			</constructor>
			<method name="reply" symbol="g_mount_operation_reply">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="abort" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_anonymous" symbol="g_mount_operation_set_anonymous">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="anonymous" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_choice" symbol="g_mount_operation_set_choice">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="choice" type="int"/>
				</parameters>
			</method>
			<method name="set_domain" symbol="g_mount_operation_set_domain">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="domain" type="char*"/>
				</parameters>
			</method>
			<method name="set_password" symbol="g_mount_operation_set_password">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="password" type="char*"/>
				</parameters>
			</method>
			<method name="set_password_save" symbol="g_mount_operation_set_password_save">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="save" type="GPasswordSave"/>
				</parameters>
			</method>
			<method name="set_username" symbol="g_mount_operation_set_username">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="username" type="char*"/>
				</parameters>
			</method>
			<signal name="ask-password" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="message" type="char*"/>
					<parameter name="default_user" type="char*"/>
					<parameter name="default_domain" type="char*"/>
					<parameter name="flags" type="guint"/>
				</parameters>
			</signal>
			<signal name="ask-question" when="LAST">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="message" type="char*"/>
					<parameter name="choices" type="gpointer"/>
				</parameters>
			</signal>
			<signal name="reply" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="op" type="GMountOperation*"/>
					<parameter name="abort" type="gboolean"/>
				</parameters>
			</signal>
		</object>
		<object name="GOutputStream" parent="GObject" type-name="GOutputStream" get-type="g_output_stream_get_type">
			<method name="close" symbol="g_output_stream_close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="close_async" symbol="g_output_stream_close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="close_finish" symbol="g_output_stream_close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="flush" symbol="g_output_stream_flush">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="flush_async" symbol="g_output_stream_flush_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="flush_finish" symbol="g_output_stream_flush_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="has_pending" symbol="g_output_stream_has_pending">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
				</parameters>
			</method>
			<method name="is_closed" symbol="g_output_stream_is_closed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
				</parameters>
			</method>
			<method name="set_pending" symbol="g_output_stream_set_pending">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="pending" type="gboolean"/>
				</parameters>
			</method>
			<method name="write" symbol="g_output_stream_write">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="write_all" symbol="g_output_stream_write_all">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="bytes_written" type="gsize*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="write_async" symbol="g_output_stream_write_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="write_finish" symbol="g_output_stream_write_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="close">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="close_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="close_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="flush">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="flush_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="flush_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="write">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="write_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="buffer" type="void*"/>
					<parameter name="count" type="gsize"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="write_finish">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="stream" type="GOutputStream*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GSimpleAsyncResult" parent="GObject" type-name="GSimpleAsyncResult" get-type="g_simple_async_result_get_type">
			<implements>
				<interface name="GAsyncResult"/>
			</implements>
			<method name="complete" symbol="g_simple_async_result_complete">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
				</parameters>
			</method>
			<method name="complete_in_idle" symbol="g_simple_async_result_complete_in_idle">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
				</parameters>
			</method>
			<method name="get_op_res_gboolean" symbol="g_simple_async_result_get_op_res_gboolean">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
				</parameters>
			</method>
			<method name="get_op_res_gpointer" symbol="g_simple_async_result_get_op_res_gpointer">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
				</parameters>
			</method>
			<method name="get_op_res_gssize" symbol="g_simple_async_result_get_op_res_gssize">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
				</parameters>
			</method>
			<method name="get_source_tag" symbol="g_simple_async_result_get_source_tag">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_simple_async_result_new">
				<return-type type="GSimpleAsyncResult*"/>
				<parameters>
					<parameter name="source_object" type="GObject*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="source_tag" type="gpointer"/>
				</parameters>
			</constructor>
			<constructor name="new_error" symbol="g_simple_async_result_new_error">
				<return-type type="GSimpleAsyncResult*"/>
				<parameters>
					<parameter name="source_object" type="GObject*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="domain" type="GQuark"/>
					<parameter name="code" type="gint"/>
					<parameter name="format" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_error" symbol="g_simple_async_result_new_from_error">
				<return-type type="GSimpleAsyncResult*"/>
				<parameters>
					<parameter name="source_object" type="GObject*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</constructor>
			<method name="propagate_error" symbol="g_simple_async_result_propagate_error">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="dest" type="GError**"/>
				</parameters>
			</method>
			<method name="run_in_thread" symbol="g_simple_async_result_run_in_thread">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="func" type="GSimpleAsyncThreadFunc"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</method>
			<method name="set_error" symbol="g_simple_async_result_set_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="domain" type="GQuark"/>
					<parameter name="code" type="gint"/>
					<parameter name="format" type="char*"/>
				</parameters>
			</method>
			<method name="set_error_va" symbol="g_simple_async_result_set_error_va">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="domain" type="GQuark"/>
					<parameter name="code" type="gint"/>
					<parameter name="format" type="char*"/>
					<parameter name="args" type="va_list"/>
				</parameters>
			</method>
			<method name="set_from_error" symbol="g_simple_async_result_set_from_error">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="error" type="GError*"/>
				</parameters>
			</method>
			<method name="set_handle_cancellation" symbol="g_simple_async_result_set_handle_cancellation">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="handle_cancellation" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_op_res_gboolean" symbol="g_simple_async_result_set_op_res_gboolean">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="op_res" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_op_res_gpointer" symbol="g_simple_async_result_set_op_res_gpointer">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="op_res" type="gpointer"/>
					<parameter name="destroy_op_res" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_op_res_gssize" symbol="g_simple_async_result_set_op_res_gssize">
				<return-type type="void"/>
				<parameters>
					<parameter name="simple" type="GSimpleAsyncResult*"/>
					<parameter name="op_res" type="gssize"/>
				</parameters>
			</method>
		</object>
		<object name="GSocketInputStream" parent="GInputStream" type-name="GSocketInputStream" get-type="g_socket_input_stream_get_type">
			<constructor name="new" symbol="g_socket_input_stream_new">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="fd" type="int"/>
					<parameter name="close_fd_at_close" type="gboolean"/>
				</parameters>
			</constructor>
		</object>
		<object name="GSocketOutputStream" parent="GOutputStream" type-name="GSocketOutputStream" get-type="g_socket_output_stream_get_type">
			<constructor name="new" symbol="g_socket_output_stream_new">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="fd" type="int"/>
					<parameter name="close_fd_at_close" type="gboolean"/>
				</parameters>
			</constructor>
		</object>
		<object name="GThemedIcon" parent="GObject" type-name="GThemedIcon" get-type="g_themed_icon_get_type">
			<implements>
				<interface name="GIcon"/>
			</implements>
			<method name="get_names" symbol="g_themed_icon_get_names">
				<return-type type="char**"/>
				<parameters>
					<parameter name="icon" type="GThemedIcon*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="g_themed_icon_new">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="iconname" type="char*"/>
				</parameters>
			</constructor>
			<constructor name="new_from_names" symbol="g_themed_icon_new_from_names">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="iconnames" type="char**"/>
					<parameter name="len" type="int"/>
				</parameters>
			</constructor>
		</object>
		<object name="GVfs" parent="GObject" type-name="GVfs" get-type="g_vfs_get_type">
			<method name="get_default" symbol="g_vfs_get_default">
				<return-type type="GVfs*"/>
			</method>
			<method name="get_file_for_path" symbol="g_vfs_get_file_for_path">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="get_file_for_uri" symbol="g_vfs_get_file_for_uri">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="uri" type="char*"/>
				</parameters>
			</method>
			<method name="get_local" symbol="g_vfs_get_local">
				<return-type type="GVfs*"/>
			</method>
			<method name="get_name" symbol="g_vfs_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
				</parameters>
			</method>
			<method name="get_priority" symbol="g_vfs_get_priority">
				<return-type type="int"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
				</parameters>
			</method>
			<method name="get_supported_uri_schemes" symbol="g_vfs_get_supported_uri_schemes">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
				</parameters>
			</method>
			<method name="parse_name" symbol="g_vfs_parse_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="parse_name" type="char*"/>
				</parameters>
			</method>
			<vfunc name="get_file_for_path">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_file_for_uri">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="uri" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_priority">
				<return-type type="int"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_supported_uri_schemes">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
				</parameters>
			</vfunc>
			<vfunc name="parse_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="vfs" type="GVfs*"/>
					<parameter name="parse_name" type="char*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GVolumeMonitor" parent="GObject" type-name="GVolumeMonitor" get-type="g_volume_monitor_get_type">
			<method name="get" symbol="g_volume_monitor_get">
				<return-type type="GVolumeMonitor*"/>
			</method>
			<method name="get_connected_drives" symbol="g_volume_monitor_get_connected_drives">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
				</parameters>
			</method>
			<method name="get_mounted_volumes" symbol="g_volume_monitor_get_mounted_volumes">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
				</parameters>
			</method>
			<signal name="drive-connected" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</signal>
			<signal name="drive-disconnected" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</signal>
			<signal name="volume-mounted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</signal>
			<signal name="volume-pre-unmount" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</signal>
			<signal name="volume-unmounted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</signal>
			<vfunc name="get_connected_drives">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_mounted_volumes">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="volume_monitor" type="GVolumeMonitor*"/>
				</parameters>
			</vfunc>
		</object>
		<interface name="GAppInfo" type-name="GAppInfo" get-type="g_app_info_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="add_supports_type" symbol="g_app_info_add_supports_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="can_remove_supports_type" symbol="g_app_info_can_remove_supports_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="create_from_commandline" symbol="g_app_info_create_from_commandline">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="commandline" type="char*"/>
					<parameter name="application_name" type="char*"/>
					<parameter name="flags" type="GAppInfoCreateFlags"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="dup" symbol="g_app_info_dup">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="equal" symbol="g_app_info_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo1" type="GAppInfo*"/>
					<parameter name="appinfo2" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="get_all" symbol="g_app_info_get_all">
				<return-type type="GList*"/>
			</method>
			<method name="get_all_for_type" symbol="g_app_info_get_all_for_type">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="content_type" type="char*"/>
				</parameters>
			</method>
			<method name="get_default_for_type" symbol="g_app_info_get_default_for_type">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="content_type" type="char*"/>
					<parameter name="must_support_uris" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_description" symbol="g_app_info_get_description">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="get_executable" symbol="g_app_info_get_executable">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="g_app_info_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="g_app_info_get_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="g_app_info_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="launch" symbol="g_app_info_launch">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="files" type="GList*"/>
					<parameter name="envp" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="launch_uris" symbol="g_app_info_launch_uris">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="uris" type="GList*"/>
					<parameter name="envp" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="remove_supports_type" symbol="g_app_info_remove_supports_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_as_default_for_extension" symbol="g_app_info_set_as_default_for_extension">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="extension" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_as_default_for_type" symbol="g_app_info_set_as_default_for_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="should_show" symbol="g_app_info_should_show">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="desktop_env" type="char*"/>
				</parameters>
			</method>
			<method name="supports_uris" symbol="g_app_info_supports_uris">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<method name="supports_xdg_startup_notify" symbol="g_app_info_supports_xdg_startup_notify">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</method>
			<vfunc name="add_supports_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="can_remove_supports_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="dup">
				<return-type type="GAppInfo*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo1" type="GAppInfo*"/>
					<parameter name="appinfo2" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_description">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_executable">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="launch">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="filenames" type="GList*"/>
					<parameter name="envp" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="launch_uris">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="uris" type="GList*"/>
					<parameter name="envp" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="remove_supports_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_as_default_for_extension">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="extension" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_as_default_for_type">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="content_type" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="should_show">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
					<parameter name="desktop_env" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="supports_uris">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
			<vfunc name="supports_xdg_startup_notify">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="appinfo" type="GAppInfo*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GAsyncResult" type-name="GAsyncResult" get-type="g_async_result_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="get_source_object" symbol="g_async_result_get_source_object">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="res" type="GAsyncResult*"/>
				</parameters>
			</method>
			<method name="get_user_data" symbol="g_async_result_get_user_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="res" type="GAsyncResult*"/>
				</parameters>
			</method>
			<vfunc name="get_source_object">
				<return-type type="GObject*"/>
				<parameters>
					<parameter name="async_result" type="GAsyncResult*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_user_data">
				<return-type type="gpointer"/>
				<parameters>
					<parameter name="async_result" type="GAsyncResult*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GDrive" type-name="GDrive" get-type="g_drive_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="can_eject" symbol="g_drive_can_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="can_mount" symbol="g_drive_can_mount">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="eject" symbol="g_drive_eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="eject_finish" symbol="g_drive_eject_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="g_drive_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="g_drive_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="get_volumes" symbol="g_drive_get_volumes">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="has_volumes" symbol="g_drive_has_volumes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="is_automounted" symbol="g_drive_is_automounted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</method>
			<method name="mount" symbol="g_drive_mount">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="mount_finish" symbol="g_drive_mount_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GDrive*"/>
				</parameters>
			</signal>
			<vfunc name="can_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_mount">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_volumes">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="has_volumes">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_automounted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
				</parameters>
			</vfunc>
			<vfunc name="mount">
				<return-type type="void"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="mount_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="drive" type="GDrive*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GFile" type-name="GFile" get-type="g_file_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="append_to" symbol="g_file_append_to">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="append_to_async" symbol="g_file_append_to_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="append_to_finish" symbol="g_file_append_to_finish">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="contains_file" symbol="g_file_contains_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parent" type="GFile*"/>
					<parameter name="descendant" type="GFile*"/>
				</parameters>
			</method>
			<method name="copy" symbol="g_file_copy">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="source" type="GFile*"/>
					<parameter name="destination" type="GFile*"/>
					<parameter name="flags" type="GFileCopyFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GFileProgressCallback"/>
					<parameter name="progress_callback_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create" symbol="g_file_create">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="create_async" symbol="g_file_create_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="create_finish" symbol="g_file_create_finish">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="delete" symbol="g_file_delete">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="dup" symbol="g_file_dup">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="eject_mountable" symbol="g_file_eject_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="eject_mountable_finish" symbol="g_file_eject_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="enumerate_children" symbol="g_file_enumerate_children">
				<return-type type="GFileEnumerator*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="enumerate_children_async" symbol="g_file_enumerate_children_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="enumerate_children_finish" symbol="g_file_enumerate_children_finish">
				<return-type type="GFileEnumerator*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="equal" symbol="g_file_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file1" type="GFile*"/>
					<parameter name="file2" type="GFile*"/>
				</parameters>
			</method>
			<method name="get_basename" symbol="g_file_get_basename">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="get_child" symbol="g_file_get_child">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="get_child_for_display_name" symbol="g_file_get_child_for_display_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="display_name" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_parent" symbol="g_file_get_parent">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="get_parse_name" symbol="g_file_get_parse_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="get_path" symbol="g_file_get_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="get_relative_path" symbol="g_file_get_relative_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="parent" type="GFile*"/>
					<parameter name="descendant" type="GFile*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="g_file_get_uri">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="has_uri_scheme" symbol="g_file_has_uri_scheme">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="uri_scheme" type="char*"/>
				</parameters>
			</method>
			<method name="hash" symbol="g_file_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="file" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="is_native" symbol="g_file_is_native">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</method>
			<method name="load_contents" symbol="g_file_load_contents">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="contents" type="char**"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="etag_out" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="load_contents_async" symbol="g_file_load_contents_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="load_contents_finish" symbol="g_file_load_contents_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="contents" type="char**"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="etag_out" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="load_partial_contents_async" symbol="g_file_load_partial_contents_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="read_more_callback" type="GFileReadMoreCallback"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="load_partial_contents_finish" symbol="g_file_load_partial_contents_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="contents" type="char**"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="etag_out" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="make_directory" symbol="g_file_make_directory">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="make_symbolic_link" symbol="g_file_make_symbolic_link">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="symlink_value" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="mount_mountable" symbol="g_file_mount_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="mount_mountable_finish" symbol="g_file_mount_mountable_finish">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="move" symbol="g_file_move">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="source" type="GFile*"/>
					<parameter name="destination" type="GFile*"/>
					<parameter name="flags" type="GFileCopyFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GFileProgressCallback"/>
					<parameter name="progress_callback_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="new_for_commandline_arg" symbol="g_file_new_for_commandline_arg">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="arg" type="char*"/>
				</parameters>
			</method>
			<method name="new_for_path" symbol="g_file_new_for_path">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="new_for_uri" symbol="g_file_new_for_uri">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="uri" type="char*"/>
				</parameters>
			</method>
			<method name="parse_name" symbol="g_file_parse_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="parse_name" type="char*"/>
				</parameters>
			</method>
			<method name="query_filesystem_info" symbol="g_file_query_filesystem_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_info" symbol="g_file_query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_info_async" symbol="g_file_query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_info_finish" symbol="g_file_query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_settable_attributes" symbol="g_file_query_settable_attributes">
				<return-type type="GFileAttributeInfoList*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_writable_namespaces" symbol="g_file_query_writable_namespaces">
				<return-type type="GFileAttributeInfoList*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read" symbol="g_file_read">
				<return-type type="GFileInputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="read_async" symbol="g_file_read_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="read_finish" symbol="g_file_read_finish">
				<return-type type="GFileInputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="replace" symbol="g_file_replace">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="replace_async" symbol="g_file_replace_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="replace_contents" symbol="g_file_replace_contents">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="contents" type="char*"/>
					<parameter name="length" type="gsize"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="new_etag" type="char**"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="replace_contents_async" symbol="g_file_replace_contents_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="contents" type="char*"/>
					<parameter name="length" type="gsize"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="replace_contents_finish" symbol="g_file_replace_contents_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="new_etag" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="replace_finish" symbol="g_file_replace_finish">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="resolve_relative_path" symbol="g_file_resolve_relative_path">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="relative_path" type="char*"/>
				</parameters>
			</method>
			<method name="set_attribute" symbol="g_file_set_attribute">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="GFileAttributeValue*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_byte_string" symbol="g_file_set_attribute_byte_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_int32" symbol="g_file_set_attribute_int32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="gint32"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_int64" symbol="g_file_set_attribute_int64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="gint64"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_string" symbol="g_file_set_attribute_string">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_uint32" symbol="g_file_set_attribute_uint32">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="guint32"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attribute_uint64" symbol="g_file_set_attribute_uint64">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="guint64"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attributes_async" symbol="g_file_set_attributes_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_attributes_finish" symbol="g_file_set_attributes_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="info" type="GFileInfo**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_attributes_from_info" symbol="g_file_set_attributes_from_info">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_display_name" symbol="g_file_set_display_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="display_name" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_display_name_async" symbol="g_file_set_display_name_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="display_name" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_display_name_finish" symbol="g_file_set_display_name_finish">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="trash" symbol="g_file_trash">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="unmount_mountable" symbol="g_file_unmount_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="unmount_mountable_finish" symbol="g_file_unmount_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="append_to">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="append_to_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="append_to_finish">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="contains_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parent" type="GFile*"/>
					<parameter name="descendant" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="copy">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="source" type="GFile*"/>
					<parameter name="destination" type="GFile*"/>
					<parameter name="flags" type="GFileCopyFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GFileProgressCallback"/>
					<parameter name="progress_callback_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="create">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="create_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="create_finish">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="delete_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="dup">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="enumerate_children">
				<return-type type="GFileEnumerator*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="enumerate_children_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="enumerate_children_finish">
				<return-type type="GFileEnumerator*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file1" type="GFile*"/>
					<parameter name="file2" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_basename">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_child_for_display_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="display_name" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="get_parent">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_parse_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_relative_path">
				<return-type type="char*"/>
				<parameters>
					<parameter name="parent" type="GFile*"/>
					<parameter name="descendant" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_uri">
				<return-type type="char*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="has_uri_scheme">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="uri_scheme" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="is_native">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
				</parameters>
			</vfunc>
			<vfunc name="make_directory">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="make_symbolic_link">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="symlink_value" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="monitor_dir">
				<return-type type="GDirectoryMonitor*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileMonitorFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</vfunc>
			<vfunc name="monitor_file">
				<return-type type="GFileMonitor*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="flags" type="GFileMonitorFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
				</parameters>
			</vfunc>
			<vfunc name="mount_for_location">
				<return-type type="void"/>
				<parameters>
					<parameter name="location" type="GFile*"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="mount_for_location_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="location" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="mount_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="mount_operation" type="GMountOperation*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="mount_mountable_finish">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="move">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="source" type="GFile*"/>
					<parameter name="destination" type="GFile*"/>
					<parameter name="flags" type="GFileCopyFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GFileProgressCallback"/>
					<parameter name="progress_callback_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_filesystem_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attributes" type="char*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="query_info_finish">
				<return-type type="GFileInfo*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_settable_attributes">
				<return-type type="GFileAttributeInfoList*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="query_writable_namespaces">
				<return-type type="GFileAttributeInfoList*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="read">
				<return-type type="GFileInputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="read_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="read_finish">
				<return-type type="GFileInputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="replace">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="replace_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="etag" type="char*"/>
					<parameter name="make_backup" type="gboolean"/>
					<parameter name="flags" type="GFileCreateFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="replace_finish">
				<return-type type="GFileOutputStream*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="resolve_relative_path">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="relative_path" type="char*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_attribute">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="attribute" type="char*"/>
					<parameter name="value" type="GFileAttributeValue*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_attributes_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="set_attributes_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="info" type="GFileInfo**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_attributes_from_info">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="info" type="GFileInfo*"/>
					<parameter name="flags" type="GFileQueryInfoFlags"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_display_name">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="display_name" type="char*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="set_display_name_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="display_name" type="char*"/>
					<parameter name="io_priority" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="set_display_name_finish">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="trash">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="unmount_mountable">
				<return-type type="void"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="unmount_mountable_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="file" type="GFile*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GIcon" type-name="GIcon" get-type="g_icon_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="equal" symbol="g_icon_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="icon1" type="GIcon*"/>
					<parameter name="icon2" type="GIcon*"/>
				</parameters>
			</method>
			<method name="hash" symbol="g_icon_hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="icon" type="gconstpointer"/>
				</parameters>
			</method>
			<vfunc name="equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="icon1" type="GIcon*"/>
					<parameter name="icon2" type="GIcon*"/>
				</parameters>
			</vfunc>
			<vfunc name="hash">
				<return-type type="guint"/>
				<parameters>
					<parameter name="icon" type="GIcon*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GLoadableIcon" type-name="GLoadableIcon" get-type="g_loadable_icon_get_type">
			<requires>
				<interface name="GIcon"/>
				<interface name="GObject"/>
			</requires>
			<method name="load" symbol="g_loadable_icon_load">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="icon" type="GLoadableIcon*"/>
					<parameter name="size" type="int"/>
					<parameter name="type" type="char**"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="load_async" symbol="g_loadable_icon_load_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon" type="GLoadableIcon*"/>
					<parameter name="size" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="load_finish" symbol="g_loadable_icon_load_finish">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="icon" type="GLoadableIcon*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="type" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="load">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="icon" type="GLoadableIcon*"/>
					<parameter name="size" type="int"/>
					<parameter name="type" type="char**"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="load_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="icon" type="GLoadableIcon*"/>
					<parameter name="size" type="int"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="load_finish">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="icon" type="GLoadableIcon*"/>
					<parameter name="res" type="GAsyncResult*"/>
					<parameter name="type" type="char**"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GSeekable" type-name="GSeekable" get-type="g_seekable_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="can_seek" symbol="g_seekable_can_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
				</parameters>
			</method>
			<method name="can_truncate" symbol="g_seekable_can_truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
				</parameters>
			</method>
			<method name="seek" symbol="g_seekable_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="type" type="GSeekType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<method name="tell" symbol="g_seekable_tell">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
				</parameters>
			</method>
			<method name="truncate" symbol="g_seekable_truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="err" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="can_seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
				</parameters>
			</vfunc>
			<vfunc name="seek">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="type" type="GSeekType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="tell">
				<return-type type="goffset"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
				</parameters>
			</vfunc>
			<vfunc name="truncate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="seekable" type="GSeekable*"/>
					<parameter name="offset" type="goffset"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GVolume" type-name="GVolume" get-type="g_volume_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="can_eject" symbol="g_volume_can_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="can_unmount" symbol="g_volume_can_unmount">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="eject" symbol="g_volume_eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="eject_finish" symbol="g_volume_eject_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_drive" symbol="g_volume_get_drive">
				<return-type type="GDrive*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="g_volume_get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="g_volume_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="get_root" symbol="g_volume_get_root">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</method>
			<method name="unmount" symbol="g_volume_unmount">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="unmount_finish" symbol="g_volume_unmount_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<signal name="changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</signal>
			<vfunc name="can_eject">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="can_unmount">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="eject">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="eject_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="get_drive">
				<return-type type="GDrive*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_icon">
				<return-type type="GIcon*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_platform_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_root">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
				</parameters>
			</vfunc>
			<vfunc name="unmount">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</vfunc>
			<vfunc name="unmount_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GVolume*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="G_FILE_ATTRIBUTE_ACCESS_CAN_DELETE" type="char*" value="access:can_delete"/>
		<constant name="G_FILE_ATTRIBUTE_ACCESS_CAN_EXECUTE" type="char*" value="access:can_execute"/>
		<constant name="G_FILE_ATTRIBUTE_ACCESS_CAN_READ" type="char*" value="access:can_read"/>
		<constant name="G_FILE_ATTRIBUTE_ACCESS_CAN_RENAME" type="char*" value="access:can_rename"/>
		<constant name="G_FILE_ATTRIBUTE_ACCESS_CAN_TRASH" type="char*" value="access:can_trash"/>
		<constant name="G_FILE_ATTRIBUTE_ACCESS_CAN_WRITE" type="char*" value="access:can_write"/>
		<constant name="G_FILE_ATTRIBUTE_DOS_IS_ARCHIVE" type="char*" value="dos:is_archive"/>
		<constant name="G_FILE_ATTRIBUTE_DOS_IS_SYSTEM" type="char*" value="dos:is_system"/>
		<constant name="G_FILE_ATTRIBUTE_ETAG_VALUE" type="char*" value="etag:value"/>
		<constant name="G_FILE_ATTRIBUTE_FS_FREE" type="char*" value="fs:free"/>
		<constant name="G_FILE_ATTRIBUTE_FS_SIZE" type="char*" value="fs:size"/>
		<constant name="G_FILE_ATTRIBUTE_FS_TYPE" type="char*" value="fs:type"/>
		<constant name="G_FILE_ATTRIBUTE_GVFS_BACKEND" type="char*" value="gvfs:backend"/>
		<constant name="G_FILE_ATTRIBUTE_ID_VALUE" type="char*" value="id:value"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_CAN_EJECT" type="char*" value="mountable:can_eject"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_CAN_MOUNT" type="char*" value="mountable:can_mount"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_CAN_UNMOUNT" type="char*" value="mountable:can_unmount"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_HAL_UDI" type="char*" value="mountable:hal_udi"/>
		<constant name="G_FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE" type="char*" value="mountable:unix_device"/>
		<constant name="G_FILE_ATTRIBUTE_OWNER_GROUP" type="char*" value="owner:group"/>
		<constant name="G_FILE_ATTRIBUTE_OWNER_USER" type="char*" value="owner:user"/>
		<constant name="G_FILE_ATTRIBUTE_OWNER_USER_REAL" type="char*" value="owner:user_real"/>
		<constant name="G_FILE_ATTRIBUTE_STD_CONTENT_TYPE" type="char*" value="std:content_type"/>
		<constant name="G_FILE_ATTRIBUTE_STD_DISPLAY_NAME" type="char*" value="std:display_name"/>
		<constant name="G_FILE_ATTRIBUTE_STD_EDIT_NAME" type="char*" value="std:edit_name"/>
		<constant name="G_FILE_ATTRIBUTE_STD_FAST_CONTENT_TYPE" type="char*" value="std:fast_content_type"/>
		<constant name="G_FILE_ATTRIBUTE_STD_ICON" type="char*" value="std:icon"/>
		<constant name="G_FILE_ATTRIBUTE_STD_IS_BACKUP" type="char*" value="std:is_backup"/>
		<constant name="G_FILE_ATTRIBUTE_STD_IS_HIDDEN" type="char*" value="std:is_hidden"/>
		<constant name="G_FILE_ATTRIBUTE_STD_IS_SYMLINK" type="char*" value="std:is_symlink"/>
		<constant name="G_FILE_ATTRIBUTE_STD_IS_VIRTUAL" type="char*" value="std:is_virtual"/>
		<constant name="G_FILE_ATTRIBUTE_STD_NAME" type="char*" value="std:name"/>
		<constant name="G_FILE_ATTRIBUTE_STD_SIZE" type="char*" value="std:size"/>
		<constant name="G_FILE_ATTRIBUTE_STD_SORT_ORDER" type="char*" value="std:sort_order"/>
		<constant name="G_FILE_ATTRIBUTE_STD_SYMLINK_TARGET" type="char*" value="std:symlink_target"/>
		<constant name="G_FILE_ATTRIBUTE_STD_TARGET_URI" type="char*" value="std:target_uri"/>
		<constant name="G_FILE_ATTRIBUTE_STD_TYPE" type="char*" value="std:type"/>
		<constant name="G_FILE_ATTRIBUTE_THUMBNAILING_FAILED" type="char*" value="thumbnail:failed"/>
		<constant name="G_FILE_ATTRIBUTE_THUMBNAIL_PATH" type="char*" value="thumbnail:path"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_ACCESS" type="char*" value="time:access"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_ACCESS_USEC" type="char*" value="time:access_usec"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_CHANGED" type="char*" value="time:changed"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_CHANGED_USEC" type="char*" value="time:changed_usec"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_CREATED" type="char*" value="time:created"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_CREATED_USEC" type="char*" value="time:created_usec"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_MODIFIED" type="char*" value="time:modified"/>
		<constant name="G_FILE_ATTRIBUTE_TIME_MODIFIED_USEC" type="char*" value="time:modified_usec"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_BLOCKS" type="char*" value="unix:blocks"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_BLOCK_SIZE" type="char*" value="unix:block_size"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_DEVICE" type="char*" value="unix:device"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_GID" type="char*" value="unix:gid"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_INODE" type="char*" value="unix:inode"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_IS_MOUNTPOINT" type="char*" value="unix:is_mountpoint"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_MODE" type="char*" value="unix:mode"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_NLINK" type="char*" value="unix:nlink"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_RDEV" type="char*" value="unix:rdev"/>
		<constant name="G_FILE_ATTRIBUTE_UNIX_UID" type="char*" value="unix:uid"/>
		<constant name="G_URI_RESERVED_CHARS_GENERIC_DELIMITERS" type="char*" value=":/?#[]@"/>
		<constant name="G_URI_RESERVED_CHARS_SUBCOMPONENT_DELIMITERS" type="char*" value="!$&amp;&apos;()*+,;="/>
	</namespace>
</api>
