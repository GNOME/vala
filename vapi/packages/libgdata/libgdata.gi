<?xml version="1.0"?>
<api version="1.0">
	<namespace name="GData">
		<function name="authentication_error_quark" symbol="gdata_authentication_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="parser_error_quark" symbol="gdata_parser_error_quark">
			<return-type type="GQuark"/>
		</function>
		<callback name="GDataQueryProgressCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="entry" type="GDataEntry*"/>
				<parameter name="entry_key" type="guint"/>
				<parameter name="entry_count" type="guint"/>
				<parameter name="user_data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GDataGDFeedLink">
			<method name="compare" symbol="gdata_gd_feed_link_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGDFeedLink*"/>
					<parameter name="b" type="GDataGDFeedLink*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_gd_feed_link_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDFeedLink*"/>
				</parameters>
			</method>
			<method name="new" symbol="gdata_gd_feed_link_new">
				<return-type type="GDataGDFeedLink*"/>
				<parameters>
					<parameter name="href" type="gchar*"/>
					<parameter name="rel" type="gchar*"/>
					<parameter name="count_hint" type="guint"/>
					<parameter name="read_only" type="gboolean"/>
				</parameters>
			</method>
			<field name="rel" type="gchar*"/>
			<field name="href" type="gchar*"/>
			<field name="count_hint" type="guint"/>
			<field name="read_only" type="gboolean"/>
		</struct>
		<struct name="GDataGDRating">
			<method name="compare" symbol="gdata_gd_rating_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGDRating*"/>
					<parameter name="b" type="GDataGDRating*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_gd_rating_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDRating*"/>
				</parameters>
			</method>
			<method name="new" symbol="gdata_gd_rating_new">
				<return-type type="GDataGDRating*"/>
				<parameters>
					<parameter name="min" type="guint"/>
					<parameter name="max" type="guint"/>
					<parameter name="num_raters" type="guint"/>
					<parameter name="average" type="gdouble"/>
				</parameters>
			</method>
			<field name="min" type="guint"/>
			<field name="max" type="guint"/>
			<field name="num_raters" type="guint"/>
			<field name="average" type="gdouble"/>
		</struct>
		<struct name="GDataMediaRating">
			<method name="free" symbol="gdata_media_rating_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataMediaRating*"/>
				</parameters>
			</method>
			<method name="new" symbol="gdata_media_rating_new">
				<return-type type="GDataMediaRating*"/>
				<parameters>
					<parameter name="scheme" type="gchar*"/>
					<parameter name="country" type="gchar*"/>
				</parameters>
			</method>
			<field name="country" type="gchar*"/>
			<field name="scheme" type="gchar*"/>
		</struct>
		<struct name="GDataMediaRestriction">
			<method name="free" symbol="gdata_media_restriction_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataMediaRestriction*"/>
				</parameters>
			</method>
			<method name="new" symbol="gdata_media_restriction_new">
				<return-type type="GDataMediaRestriction*"/>
				<parameters>
					<parameter name="countries" type="gchar*"/>
					<parameter name="relationship" type="gboolean"/>
				</parameters>
			</method>
			<field name="countries" type="gchar*"/>
			<field name="relationship" type="gboolean"/>
		</struct>
		<boxed name="GDataColor" type-name="GDataColor" get-type="gdata_color_get_type">
			<method name="from_hexadecimal" symbol="gdata_color_from_hexadecimal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="hexadecimal" type="gchar*"/>
					<parameter name="color" type="GDataColor*"/>
				</parameters>
			</method>
			<method name="to_hexadecimal" symbol="gdata_color_to_hexadecimal">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="color" type="GDataColor*"/>
				</parameters>
			</method>
			<field name="red" type="guint16"/>
			<field name="green" type="guint16"/>
			<field name="blue" type="guint16"/>
		</boxed>
		<boxed name="GTimeVal" type-name="GTimeVal" get-type="gdata_g_time_val_get_type">
		</boxed>
		<enum name="GDataAuthenticationError" type-name="GDataAuthenticationError" get-type="gdata_authentication_error_get_type">
			<member name="GDATA_AUTHENTICATION_ERROR_BAD_AUTHENTICATION" value="1"/>
			<member name="GDATA_AUTHENTICATION_ERROR_NOT_VERIFIED" value="2"/>
			<member name="GDATA_AUTHENTICATION_ERROR_TERMS_NOT_AGREED" value="3"/>
			<member name="GDATA_AUTHENTICATION_ERROR_CAPTCHA_REQUIRED" value="4"/>
			<member name="GDATA_AUTHENTICATION_ERROR_ACCOUNT_DELETED" value="5"/>
			<member name="GDATA_AUTHENTICATION_ERROR_ACCOUNT_DISABLED" value="6"/>
			<member name="GDATA_AUTHENTICATION_ERROR_SERVICE_DISABLED" value="7"/>
		</enum>
		<enum name="GDataDocumentsPresentationFormat" type-name="GDataDocumentsPresentationFormat" get-type="gdata_documents_presentation_format_get_type">
			<member name="GDATA_DOCUMENTS_PRESENTATION_PDF" value="0"/>
			<member name="GDATA_DOCUMENTS_PRESENTATION_PNG" value="1"/>
			<member name="GDATA_DOCUMENTS_PRESENTATION_PPT" value="2"/>
			<member name="GDATA_DOCUMENTS_PRESENTATION_SWF" value="3"/>
			<member name="GDATA_DOCUMENTS_PRESENTATION_TXT" value="4"/>
		</enum>
		<enum name="GDataDocumentsServiceError" type-name="GDataDocumentsServiceError" get-type="gdata_documents_service_error_get_type">
			<member name="GDATA_DOCUMENTS_SERVICE_ERROR_INVALID_CONTENT_TYPE" value="0"/>
		</enum>
		<enum name="GDataDocumentsSpreadsheetFormat" type-name="GDataDocumentsSpreadsheetFormat" get-type="gdata_documents_spreadsheet_format_get_type">
			<member name="GDATA_DOCUMENTS_SPREADSHEET_XLS" value="0"/>
			<member name="GDATA_DOCUMENTS_SPREADSHEET_CSV" value="1"/>
			<member name="GDATA_DOCUMENTS_SPREADSHEET_PDF" value="2"/>
			<member name="GDATA_DOCUMENTS_SPREADSHEET_ODS" value="3"/>
			<member name="GDATA_DOCUMENTS_SPREADSHEET_TSV" value="4"/>
			<member name="GDATA_DOCUMENTS_SPREADSHEET_HTML" value="5"/>
		</enum>
		<enum name="GDataDocumentsTextFormat" type-name="GDataDocumentsTextFormat" get-type="gdata_documents_text_format_get_type">
			<member name="GDATA_DOCUMENTS_TEXT_DOC" value="0"/>
			<member name="GDATA_DOCUMENTS_TEXT_HTML" value="1"/>
			<member name="GDATA_DOCUMENTS_TEXT_ODT" value="2"/>
			<member name="GDATA_DOCUMENTS_TEXT_PDF" value="3"/>
			<member name="GDATA_DOCUMENTS_TEXT_PNG" value="4"/>
			<member name="GDATA_DOCUMENTS_TEXT_RTF" value="5"/>
			<member name="GDATA_DOCUMENTS_TEXT_TXT" value="6"/>
			<member name="GDATA_DOCUMENTS_TEXT_ZIP" value="7"/>
		</enum>
		<enum name="GDataMediaExpression" type-name="GDataMediaExpression" get-type="gdata_media_expression_get_type">
			<member name="GDATA_MEDIA_EXPRESSION_SAMPLE" value="0"/>
			<member name="GDATA_MEDIA_EXPRESSION_FULL" value="1"/>
			<member name="GDATA_MEDIA_EXPRESSION_NONSTOP" value="2"/>
		</enum>
		<enum name="GDataMediaMedium" type-name="GDataMediaMedium" get-type="gdata_media_medium_get_type">
			<member name="GDATA_MEDIA_UNKNOWN" value="0"/>
			<member name="GDATA_MEDIA_IMAGE" value="1"/>
			<member name="GDATA_MEDIA_AUDIO" value="2"/>
			<member name="GDATA_MEDIA_VIDEO" value="3"/>
			<member name="GDATA_MEDIA_DOCUMENT" value="4"/>
			<member name="GDATA_MEDIA_EXECUTABLE" value="5"/>
		</enum>
		<enum name="GDataOperationType" type-name="GDataOperationType" get-type="gdata_operation_type_get_type">
			<member name="GDATA_OPERATION_QUERY" value="1"/>
			<member name="GDATA_OPERATION_INSERTION" value="2"/>
			<member name="GDATA_OPERATION_UPDATE" value="3"/>
			<member name="GDATA_OPERATION_DELETION" value="4"/>
			<member name="GDATA_OPERATION_DOWNLOAD" value="5"/>
			<member name="GDATA_OPERATION_UPLOAD" value="6"/>
			<member name="GDATA_OPERATION_AUTHENTICATION" value="7"/>
		</enum>
		<enum name="GDataParserError" type-name="GDataParserError" get-type="gdata_parser_error_get_type">
			<member name="GDATA_PARSER_ERROR_PARSING_STRING" value="1"/>
			<member name="GDATA_PARSER_ERROR_EMPTY_DOCUMENT" value="2"/>
		</enum>
		<enum name="GDataPicasaWebVisibility" type-name="GDataPicasaWebVisibility" get-type="gdata_picasaweb_visibility_get_type">
			<member name="GDATA_PICASAWEB_PUBLIC" value="1"/>
			<member name="GDATA_PICASAWEB_PRIVATE" value="2"/>
		</enum>
		<enum name="GDataServiceError" type-name="GDataServiceError" get-type="gdata_service_error_get_type">
			<member name="GDATA_SERVICE_ERROR_UNAVAILABLE" value="1"/>
			<member name="GDATA_SERVICE_ERROR_PROTOCOL_ERROR" value="2"/>
			<member name="GDATA_SERVICE_ERROR_ENTRY_ALREADY_INSERTED" value="3"/>
			<member name="GDATA_SERVICE_ERROR_AUTHENTICATION_REQUIRED" value="4"/>
			<member name="GDATA_SERVICE_ERROR_NOT_FOUND" value="5"/>
			<member name="GDATA_SERVICE_ERROR_CONFLICT" value="6"/>
			<member name="GDATA_SERVICE_ERROR_FORBIDDEN" value="7"/>
			<member name="GDATA_SERVICE_ERROR_BAD_QUERY_PARAMETER" value="8"/>
			<member name="GDATA_SERVICE_ERROR_NETWORK_ERROR" value="9"/>
			<member name="GDATA_SERVICE_ERROR_PROXY_ERROR" value="10"/>
		</enum>
		<enum name="GDataYouTubeAge" type-name="GDataYouTubeAge" get-type="gdata_youtube_age_get_type">
			<member name="GDATA_YOUTUBE_AGE_ALL_TIME" value="0"/>
			<member name="GDATA_YOUTUBE_AGE_TODAY" value="1"/>
			<member name="GDATA_YOUTUBE_AGE_THIS_WEEK" value="2"/>
			<member name="GDATA_YOUTUBE_AGE_THIS_MONTH" value="3"/>
		</enum>
		<enum name="GDataYouTubeFormat" type-name="GDataYouTubeFormat" get-type="gdata_youtube_format_get_type">
			<member name="GDATA_YOUTUBE_FORMAT_UNKNOWN" value="0"/>
			<member name="GDATA_YOUTUBE_FORMAT_RTSP_H263_AMR" value="1"/>
			<member name="GDATA_YOUTUBE_FORMAT_HTTP_SWF" value="5"/>
			<member name="GDATA_YOUTUBE_FORMAT_RTSP_MPEG4_AAC" value="6"/>
		</enum>
		<enum name="GDataYouTubePermission" type-name="GDataYouTubePermission" get-type="gdata_youtube_permission_get_type">
			<member name="GDATA_YOUTUBE_PERMISSION_ALLOWED" value="0"/>
			<member name="GDATA_YOUTUBE_PERMISSION_DENIED" value="1"/>
			<member name="GDATA_YOUTUBE_PERMISSION_MODERATED" value="2"/>
		</enum>
		<enum name="GDataYouTubeSafeSearch" type-name="GDataYouTubeSafeSearch" get-type="gdata_youtube_safe_search_get_type">
			<member name="GDATA_YOUTUBE_SAFE_SEARCH_NONE" value="0"/>
			<member name="GDATA_YOUTUBE_SAFE_SEARCH_MODERATE" value="1"/>
			<member name="GDATA_YOUTUBE_SAFE_SEARCH_STRICT" value="2"/>
		</enum>
		<enum name="GDataYouTubeServiceError" type-name="GDataYouTubeServiceError" get-type="gdata_youtube_service_error_get_type">
			<member name="GDATA_YOUTUBE_SERVICE_ERROR_API_QUOTA_EXCEEDED" value="0"/>
			<member name="GDATA_YOUTUBE_SERVICE_ERROR_ENTRY_QUOTA_EXCEEDED" value="1"/>
		</enum>
		<enum name="GDataYouTubeSortOrder" type-name="GDataYouTubeSortOrder" get-type="gdata_youtube_sort_order_get_type">
			<member name="GDATA_YOUTUBE_SORT_NONE" value="0"/>
			<member name="GDATA_YOUTUBE_SORT_ASCENDING" value="1"/>
			<member name="GDATA_YOUTUBE_SORT_DESCENDING" value="2"/>
		</enum>
		<enum name="GDataYouTubeStandardFeedType" type-name="GDataYouTubeStandardFeedType" get-type="gdata_youtube_standard_feed_type_get_type">
			<member name="GDATA_YOUTUBE_TOP_RATED_FEED" value="0"/>
			<member name="GDATA_YOUTUBE_TOP_FAVORITES_FEED" value="1"/>
			<member name="GDATA_YOUTUBE_MOST_VIEWED_FEED" value="2"/>
			<member name="GDATA_YOUTUBE_MOST_POPULAR_FEED" value="3"/>
			<member name="GDATA_YOUTUBE_MOST_RECENT_FEED" value="4"/>
			<member name="GDATA_YOUTUBE_MOST_DISCUSSED_FEED" value="5"/>
			<member name="GDATA_YOUTUBE_MOST_LINKED_FEED" value="6"/>
			<member name="GDATA_YOUTUBE_MOST_RESPONDED_FEED" value="7"/>
			<member name="GDATA_YOUTUBE_RECENTLY_FEATURED_FEED" value="8"/>
			<member name="GDATA_YOUTUBE_WATCH_ON_MOBILE_FEED" value="9"/>
		</enum>
		<enum name="GDataYouTubeUploader" type-name="GDataYouTubeUploader" get-type="gdata_youtube_uploader_get_type">
			<member name="GDATA_YOUTUBE_UPLOADER_ALL" value="0"/>
			<member name="GDATA_YOUTUBE_UPLOADER_PARTNER" value="1"/>
		</enum>
		<object name="GDataAccessRule" parent="GDataEntry" type-name="GDataAccessRule" get-type="gdata_access_rule_get_type">
			<method name="get_edited" symbol="gdata_access_rule_get_edited">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataAccessRule*"/>
					<parameter name="edited" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_role" symbol="gdata_access_rule_get_role">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataAccessRule*"/>
				</parameters>
			</method>
			<method name="get_scope" symbol="gdata_access_rule_get_scope">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataAccessRule*"/>
					<parameter name="type" type="gchar**"/>
					<parameter name="value" type="gchar**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_access_rule_new">
				<return-type type="GDataAccessRule*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_role" symbol="gdata_access_rule_set_role">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataAccessRule*"/>
					<parameter name="role" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_scope" symbol="gdata_access_rule_set_scope">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataAccessRule*"/>
					<parameter name="type" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<property name="edited" type="GTimeVal*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="role" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scope-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scope-value" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataAuthor" parent="GDataParsable" type-name="GDataAuthor" get-type="gdata_author_get_type">
			<method name="compare" symbol="gdata_author_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataAuthor*"/>
					<parameter name="b" type="GDataAuthor*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_author_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataAuthor*"/>
				</parameters>
			</method>
			<method name="get_email_address" symbol="gdata_author_get_email_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataAuthor*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdata_author_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataAuthor*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="gdata_author_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataAuthor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_author_new">
				<return-type type="GDataAuthor*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="uri" type="gchar*"/>
					<parameter name="email_address" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_email_address" symbol="gdata_author_set_email_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataAuthor*"/>
					<parameter name="email_address" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="gdata_author_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataAuthor*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_uri" symbol="gdata_author_set_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataAuthor*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<property name="email-address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataCalendarCalendar" parent="GDataEntry" type-name="GDataCalendarCalendar" get-type="gdata_calendar_calendar_get_type">
			<implements>
				<interface name="GDataAccessHandler"/>
			</implements>
			<method name="get_access_level" symbol="gdata_calendar_calendar_get_access_level">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarCalendar*"/>
				</parameters>
			</method>
			<method name="get_color" symbol="gdata_calendar_calendar_get_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarCalendar*"/>
					<parameter name="color" type="GDataColor*"/>
				</parameters>
			</method>
			<method name="get_edited" symbol="gdata_calendar_calendar_get_edited">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarCalendar*"/>
					<parameter name="edited" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_times_cleaned" symbol="gdata_calendar_calendar_get_times_cleaned">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataCalendarCalendar*"/>
				</parameters>
			</method>
			<method name="get_timezone" symbol="gdata_calendar_calendar_get_timezone">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarCalendar*"/>
				</parameters>
			</method>
			<method name="is_hidden" symbol="gdata_calendar_calendar_is_hidden">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataCalendarCalendar*"/>
				</parameters>
			</method>
			<method name="is_selected" symbol="gdata_calendar_calendar_is_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataCalendarCalendar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_calendar_calendar_new">
				<return-type type="GDataCalendarCalendar*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_color" symbol="gdata_calendar_calendar_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarCalendar*"/>
					<parameter name="color" type="GDataColor*"/>
				</parameters>
			</method>
			<method name="set_is_hidden" symbol="gdata_calendar_calendar_set_is_hidden">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarCalendar*"/>
					<parameter name="is_hidden" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_is_selected" symbol="gdata_calendar_calendar_set_is_selected">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarCalendar*"/>
					<parameter name="is_selected" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_timezone" symbol="gdata_calendar_calendar_set_timezone">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarCalendar*"/>
					<parameter name="_timezone" type="gchar*"/>
				</parameters>
			</method>
			<property name="access-level" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="color" type="GDataColor*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="edited" type="GTimeVal*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-hidden" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-selected" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="times-cleaned" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="timezone" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataCalendarEvent" parent="GDataEntry" type-name="GDataCalendarEvent" get-type="gdata_calendar_event_get_type">
			<method name="add_person" symbol="gdata_calendar_event_add_person">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="who" type="GDataGDWho*"/>
				</parameters>
			</method>
			<method name="add_place" symbol="gdata_calendar_event_add_place">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="where" type="GDataGDWhere*"/>
				</parameters>
			</method>
			<method name="add_time" symbol="gdata_calendar_event_add_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="when" type="GDataGDWhen*"/>
				</parameters>
			</method>
			<method name="get_anyone_can_add_self" symbol="gdata_calendar_event_get_anyone_can_add_self">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="get_edited" symbol="gdata_calendar_event_get_edited">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="edited" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_guests_can_invite_others" symbol="gdata_calendar_event_get_guests_can_invite_others">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="get_guests_can_modify" symbol="gdata_calendar_event_get_guests_can_modify">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="get_guests_can_see_guests" symbol="gdata_calendar_event_get_guests_can_see_guests">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="get_original_event_details" symbol="gdata_calendar_event_get_original_event_details">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="event_id" type="gchar**"/>
					<parameter name="event_uri" type="gchar**"/>
				</parameters>
			</method>
			<method name="get_people" symbol="gdata_calendar_event_get_people">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="get_places" symbol="gdata_calendar_event_get_places">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="get_primary_time" symbol="gdata_calendar_event_get_primary_time">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="start_time" type="GTimeVal*"/>
					<parameter name="end_time" type="GTimeVal*"/>
					<parameter name="when" type="GDataGDWhen**"/>
				</parameters>
			</method>
			<method name="get_recurrence" symbol="gdata_calendar_event_get_recurrence">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="get_sequence" symbol="gdata_calendar_event_get_sequence">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="get_status" symbol="gdata_calendar_event_get_status">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="get_times" symbol="gdata_calendar_event_get_times">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="get_transparency" symbol="gdata_calendar_event_get_transparency">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="get_uid" symbol="gdata_calendar_event_get_uid">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="get_visibility" symbol="gdata_calendar_event_get_visibility">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<method name="is_exception" symbol="gdata_calendar_event_is_exception">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_calendar_event_new">
				<return-type type="GDataCalendarEvent*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_anyone_can_add_self" symbol="gdata_calendar_event_set_anyone_can_add_self">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="anyone_can_add_self" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_guests_can_invite_others" symbol="gdata_calendar_event_set_guests_can_invite_others">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="guests_can_invite_others" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_guests_can_modify" symbol="gdata_calendar_event_set_guests_can_modify">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="guests_can_modify" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_guests_can_see_guests" symbol="gdata_calendar_event_set_guests_can_see_guests">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="guests_can_see_guests" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_recurrence" symbol="gdata_calendar_event_set_recurrence">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="recurrence" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_sequence" symbol="gdata_calendar_event_set_sequence">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="sequence" type="guint"/>
				</parameters>
			</method>
			<method name="set_status" symbol="gdata_calendar_event_set_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="status" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_transparency" symbol="gdata_calendar_event_set_transparency">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="transparency" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_uid" symbol="gdata_calendar_event_set_uid">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="uid" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_visibility" symbol="gdata_calendar_event_set_visibility">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarEvent*"/>
					<parameter name="visibility" type="gchar*"/>
				</parameters>
			</method>
			<property name="anyone-can-add-self" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="edited" type="GTimeVal*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="guests-can-invite-others" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="guests-can-modify" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="guests-can-see-guests" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="original-event-id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="original-event-uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="recurrence" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sequence" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="status" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="transparency" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="uid" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="visibility" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataCalendarFeed" parent="GDataFeed" type-name="GDataCalendarFeed" get-type="gdata_calendar_feed_get_type">
			<method name="get_times_cleaned" symbol="gdata_calendar_feed_get_times_cleaned">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataCalendarFeed*"/>
				</parameters>
			</method>
			<method name="get_timezone" symbol="gdata_calendar_feed_get_timezone">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarFeed*"/>
				</parameters>
			</method>
			<property name="times-cleaned" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="timezone" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataCalendarQuery" parent="GDataQuery" type-name="GDataCalendarQuery" get-type="gdata_calendar_query_get_type">
			<method name="get_future_events" symbol="gdata_calendar_query_get_future_events">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
				</parameters>
			</method>
			<method name="get_order_by" symbol="gdata_calendar_query_get_order_by">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
				</parameters>
			</method>
			<method name="get_recurrence_expansion_end" symbol="gdata_calendar_query_get_recurrence_expansion_end">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="end" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_recurrence_expansion_start" symbol="gdata_calendar_query_get_recurrence_expansion_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="start" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_single_events" symbol="gdata_calendar_query_get_single_events">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
				</parameters>
			</method>
			<method name="get_sort_order" symbol="gdata_calendar_query_get_sort_order">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
				</parameters>
			</method>
			<method name="get_start_max" symbol="gdata_calendar_query_get_start_max">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="start_max" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_start_min" symbol="gdata_calendar_query_get_start_min">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="start_min" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_timezone" symbol="gdata_calendar_query_get_timezone">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_calendar_query_new">
				<return-type type="GDataCalendarQuery*"/>
				<parameters>
					<parameter name="q" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_limits" symbol="gdata_calendar_query_new_with_limits">
				<return-type type="GDataCalendarQuery*"/>
				<parameters>
					<parameter name="q" type="gchar*"/>
					<parameter name="start_min" type="GTimeVal*"/>
					<parameter name="start_max" type="GTimeVal*"/>
				</parameters>
			</constructor>
			<method name="set_future_events" symbol="gdata_calendar_query_set_future_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="future_events" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_order_by" symbol="gdata_calendar_query_set_order_by">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="order_by" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_recurrence_expansion_end" symbol="gdata_calendar_query_set_recurrence_expansion_end">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="end" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_recurrence_expansion_start" symbol="gdata_calendar_query_set_recurrence_expansion_start">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="start" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_single_events" symbol="gdata_calendar_query_set_single_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="single_events" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_sort_order" symbol="gdata_calendar_query_set_sort_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="sort_order" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_start_max" symbol="gdata_calendar_query_set_start_max">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="start_max" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_start_min" symbol="gdata_calendar_query_set_start_min">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="start_min" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_timezone" symbol="gdata_calendar_query_set_timezone">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarQuery*"/>
					<parameter name="_timezone" type="gchar*"/>
				</parameters>
			</method>
			<property name="future-events" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="order-by" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="recurrence-expansion-end" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="recurrence-expansion-start" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="single-events" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sort-order" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="start-max" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="start-min" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="timezone" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataCalendarService" parent="GDataService" type-name="GDataCalendarService" get-type="gdata_calendar_service_get_type">
			<method name="insert_event" symbol="gdata_calendar_service_insert_event">
				<return-type type="GDataCalendarEvent*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarService*"/>
					<parameter name="event" type="GDataCalendarEvent*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_calendar_service_new">
				<return-type type="GDataCalendarService*"/>
				<parameters>
					<parameter name="client_id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="query_all_calendars" symbol="gdata_calendar_service_query_all_calendars">
				<return-type type="GDataFeed*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarService*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_all_calendars_async" symbol="gdata_calendar_service_query_all_calendars_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarService*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_events" symbol="gdata_calendar_service_query_events">
				<return-type type="GDataFeed*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarService*"/>
					<parameter name="calendar" type="GDataCalendarCalendar*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_own_calendars" symbol="gdata_calendar_service_query_own_calendars">
				<return-type type="GDataFeed*"/>
				<parameters>
					<parameter name="self" type="GDataCalendarService*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_own_calendars_async" symbol="gdata_calendar_service_query_own_calendars_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCalendarService*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
		</object>
		<object name="GDataCategory" parent="GDataParsable" type-name="GDataCategory" get-type="gdata_category_get_type">
			<method name="compare" symbol="gdata_category_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataCategory*"/>
					<parameter name="b" type="GDataCategory*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_category_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCategory*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="gdata_category_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCategory*"/>
				</parameters>
			</method>
			<method name="get_scheme" symbol="gdata_category_get_scheme">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCategory*"/>
				</parameters>
			</method>
			<method name="get_term" symbol="gdata_category_get_term">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataCategory*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_category_new">
				<return-type type="GDataCategory*"/>
				<parameters>
					<parameter name="term" type="gchar*"/>
					<parameter name="scheme" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_label" symbol="gdata_category_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCategory*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_scheme" symbol="gdata_category_set_scheme">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCategory*"/>
					<parameter name="scheme" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_term" symbol="gdata_category_set_term">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataCategory*"/>
					<parameter name="term" type="gchar*"/>
				</parameters>
			</method>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scheme" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="term" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataContactsContact" parent="GDataEntry" type-name="GDataContactsContact" get-type="gdata_contacts_contact_get_type">
			<method name="add_calendar" symbol="gdata_contacts_contact_add_calendar">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="calendar" type="GDataGContactCalendar*"/>
				</parameters>
			</method>
			<method name="add_email_address" symbol="gdata_contacts_contact_add_email_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="email_address" type="GDataGDEmailAddress*"/>
				</parameters>
			</method>
			<method name="add_event" symbol="gdata_contacts_contact_add_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="event" type="GDataGContactEvent*"/>
				</parameters>
			</method>
			<method name="add_group" symbol="gdata_contacts_contact_add_group">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="href" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_im_address" symbol="gdata_contacts_contact_add_im_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="im_address" type="GDataGDIMAddress*"/>
				</parameters>
			</method>
			<method name="add_jot" symbol="gdata_contacts_contact_add_jot">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="jot" type="GDataGContactJot*"/>
				</parameters>
			</method>
			<method name="add_organization" symbol="gdata_contacts_contact_add_organization">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="organization" type="GDataGDOrganization*"/>
				</parameters>
			</method>
			<method name="add_phone_number" symbol="gdata_contacts_contact_add_phone_number">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="phone_number" type="GDataGDPhoneNumber*"/>
				</parameters>
			</method>
			<method name="add_postal_address" symbol="gdata_contacts_contact_add_postal_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="postal_address" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="add_relation" symbol="gdata_contacts_contact_add_relation">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="relation" type="GDataGContactRelation*"/>
				</parameters>
			</method>
			<method name="add_website" symbol="gdata_contacts_contact_add_website">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="website" type="GDataGContactWebsite*"/>
				</parameters>
			</method>
			<method name="get_birthday" symbol="gdata_contacts_contact_get_birthday">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="birthday" type="GDate*"/>
				</parameters>
			</method>
			<method name="get_calendars" symbol="gdata_contacts_contact_get_calendars">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_edited" symbol="gdata_contacts_contact_get_edited">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="edited" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_email_addresses" symbol="gdata_contacts_contact_get_email_addresses">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_events" symbol="gdata_contacts_contact_get_events">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_extended_properties" symbol="gdata_contacts_contact_get_extended_properties">
				<return-type type="GHashTable*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_extended_property" symbol="gdata_contacts_contact_get_extended_property">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_groups" symbol="gdata_contacts_contact_get_groups">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_im_addresses" symbol="gdata_contacts_contact_get_im_addresses">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_jots" symbol="gdata_contacts_contact_get_jots">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdata_contacts_contact_get_name">
				<return-type type="GDataGDName*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_nickname" symbol="gdata_contacts_contact_get_nickname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_organizations" symbol="gdata_contacts_contact_get_organizations">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_phone_numbers" symbol="gdata_contacts_contact_get_phone_numbers">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_photo" symbol="gdata_contacts_contact_get_photo">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="service" type="GDataContactsService*"/>
					<parameter name="length" type="gsize*"/>
					<parameter name="content_type" type="gchar**"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_postal_addresses" symbol="gdata_contacts_contact_get_postal_addresses">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_primary_calendar" symbol="gdata_contacts_contact_get_primary_calendar">
				<return-type type="GDataGContactCalendar*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_primary_email_address" symbol="gdata_contacts_contact_get_primary_email_address">
				<return-type type="GDataGDEmailAddress*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_primary_im_address" symbol="gdata_contacts_contact_get_primary_im_address">
				<return-type type="GDataGDIMAddress*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_primary_organization" symbol="gdata_contacts_contact_get_primary_organization">
				<return-type type="GDataGDOrganization*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_primary_phone_number" symbol="gdata_contacts_contact_get_primary_phone_number">
				<return-type type="GDataGDPhoneNumber*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_primary_postal_address" symbol="gdata_contacts_contact_get_primary_postal_address">
				<return-type type="GDataGDPostalAddress*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_primary_website" symbol="gdata_contacts_contact_get_primary_website">
				<return-type type="GDataGContactWebsite*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_relations" symbol="gdata_contacts_contact_get_relations">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="get_websites" symbol="gdata_contacts_contact_get_websites">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="has_photo" symbol="gdata_contacts_contact_has_photo">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="is_deleted" symbol="gdata_contacts_contact_is_deleted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="is_group_deleted" symbol="gdata_contacts_contact_is_group_deleted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="href" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_contacts_contact_new">
				<return-type type="GDataContactsContact*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="remove_all_calendars" symbol="gdata_contacts_contact_remove_all_calendars">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="remove_all_email_addresses" symbol="gdata_contacts_contact_remove_all_email_addresses">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="remove_all_events" symbol="gdata_contacts_contact_remove_all_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="remove_all_im_addresses" symbol="gdata_contacts_contact_remove_all_im_addresses">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="remove_all_jots" symbol="gdata_contacts_contact_remove_all_jots">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="remove_all_organizations" symbol="gdata_contacts_contact_remove_all_organizations">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="remove_all_phone_numbers" symbol="gdata_contacts_contact_remove_all_phone_numbers">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="remove_all_postal_addresses" symbol="gdata_contacts_contact_remove_all_postal_addresses">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="remove_all_relations" symbol="gdata_contacts_contact_remove_all_relations">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="remove_all_websites" symbol="gdata_contacts_contact_remove_all_websites">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
				</parameters>
			</method>
			<method name="remove_group" symbol="gdata_contacts_contact_remove_group">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="href" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_birthday" symbol="gdata_contacts_contact_set_birthday">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="birthday" type="GDate*"/>
					<parameter name="birthday_has_year" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_extended_property" symbol="gdata_contacts_contact_set_extended_property">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="name" type="gchar*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="gdata_contacts_contact_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="name" type="GDataGDName*"/>
				</parameters>
			</method>
			<method name="set_nickname" symbol="gdata_contacts_contact_set_nickname">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="nickname" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_photo" symbol="gdata_contacts_contact_set_photo">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataContactsContact*"/>
					<parameter name="service" type="GDataService*"/>
					<parameter name="data" type="gchar*"/>
					<parameter name="length" type="gsize"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="birthday" type="GDate*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="birthday-has-year" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="deleted" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="edited" type="GTimeVal*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="has-photo" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="GDataGDName*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="nickname" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataContactsQuery" parent="GDataQuery" type-name="GDataContactsQuery" get-type="gdata_contacts_query_get_type">
			<method name="get_group" symbol="gdata_contacts_query_get_group">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataContactsQuery*"/>
				</parameters>
			</method>
			<method name="get_order_by" symbol="gdata_contacts_query_get_order_by">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataContactsQuery*"/>
				</parameters>
			</method>
			<method name="get_sort_order" symbol="gdata_contacts_query_get_sort_order">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataContactsQuery*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_contacts_query_new">
				<return-type type="GDataContactsQuery*"/>
				<parameters>
					<parameter name="q" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_limits" symbol="gdata_contacts_query_new_with_limits">
				<return-type type="GDataContactsQuery*"/>
				<parameters>
					<parameter name="q" type="gchar*"/>
					<parameter name="start_index" type="gint"/>
					<parameter name="max_results" type="gint"/>
				</parameters>
			</constructor>
			<method name="set_group" symbol="gdata_contacts_query_set_group">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsQuery*"/>
					<parameter name="group" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_order_by" symbol="gdata_contacts_query_set_order_by">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsQuery*"/>
					<parameter name="order_by" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_show_deleted" symbol="gdata_contacts_query_set_show_deleted">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsQuery*"/>
					<parameter name="show_deleted" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_sort_order" symbol="gdata_contacts_query_set_sort_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsQuery*"/>
					<parameter name="sort_order" type="gchar*"/>
				</parameters>
			</method>
			<method name="show_deleted" symbol="gdata_contacts_query_show_deleted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataContactsQuery*"/>
				</parameters>
			</method>
			<property name="group" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="order-by" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-deleted" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sort-order" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataContactsService" parent="GDataService" type-name="GDataContactsService" get-type="gdata_contacts_service_get_type">
			<method name="insert_contact" symbol="gdata_contacts_service_insert_contact">
				<return-type type="GDataContactsContact*"/>
				<parameters>
					<parameter name="self" type="GDataContactsService*"/>
					<parameter name="contact" type="GDataContactsContact*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_contacts_service_new">
				<return-type type="GDataContactsService*"/>
				<parameters>
					<parameter name="client_id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="query_contacts" symbol="gdata_contacts_service_query_contacts">
				<return-type type="GDataFeed*"/>
				<parameters>
					<parameter name="self" type="GDataContactsService*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_contacts_async" symbol="gdata_contacts_service_query_contacts_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataContactsService*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="update_contact" symbol="gdata_contacts_service_update_contact">
				<return-type type="GDataContactsContact*"/>
				<parameters>
					<parameter name="self" type="GDataContactsService*"/>
					<parameter name="contact" type="GDataContactsContact*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</object>
		<object name="GDataDocumentsEntry" parent="GDataEntry" type-name="GDataDocumentsEntry" get-type="gdata_documents_entry_get_type">
			<implements>
				<interface name="GDataAccessHandler"/>
			</implements>
			<method name="get_document_id" symbol="gdata_documents_entry_get_document_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsEntry*"/>
				</parameters>
			</method>
			<method name="get_edited" symbol="gdata_documents_entry_get_edited">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsEntry*"/>
					<parameter name="edited" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_last_modified_by" symbol="gdata_documents_entry_get_last_modified_by">
				<return-type type="GDataAuthor*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsEntry*"/>
				</parameters>
			</method>
			<method name="get_last_viewed" symbol="gdata_documents_entry_get_last_viewed">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsEntry*"/>
					<parameter name="last_viewed" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_path" symbol="gdata_documents_entry_get_path">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsEntry*"/>
				</parameters>
			</method>
			<method name="is_deleted" symbol="gdata_documents_entry_is_deleted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsEntry*"/>
				</parameters>
			</method>
			<method name="set_writers_can_invite" symbol="gdata_documents_entry_set_writers_can_invite">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsEntry*"/>
					<parameter name="writers_can_invite" type="gboolean"/>
				</parameters>
			</method>
			<method name="writers_can_invite" symbol="gdata_documents_entry_writers_can_invite">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsEntry*"/>
				</parameters>
			</method>
			<property name="document-id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="edited" type="GTimeVal*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-deleted" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="last-modified-by" type="GDataAuthor*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="last-viewed" type="GTimeVal*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="writers-can-invite" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataDocumentsFeed" parent="GDataFeed" type-name="GDataDocumentsFeed" get-type="gdata_documents_feed_get_type">
		</object>
		<object name="GDataDocumentsFolder" parent="GDataDocumentsEntry" type-name="GDataDocumentsFolder" get-type="gdata_documents_folder_get_type">
			<implements>
				<interface name="GDataAccessHandler"/>
			</implements>
			<constructor name="new" symbol="gdata_documents_folder_new">
				<return-type type="GDataDocumentsFolder*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
		</object>
		<object name="GDataDocumentsPresentation" parent="GDataDocumentsEntry" type-name="GDataDocumentsPresentation" get-type="gdata_documents_presentation_get_type">
			<implements>
				<interface name="GDataAccessHandler"/>
			</implements>
			<method name="download_document" symbol="gdata_documents_presentation_download_document">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsPresentation*"/>
					<parameter name="service" type="GDataDocumentsService*"/>
					<parameter name="content_type" type="gchar**"/>
					<parameter name="export_format" type="GDataDocumentsPresentationFormat"/>
					<parameter name="destination_file" type="GFile*"/>
					<parameter name="replace_file_if_exists" type="gboolean"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_download_uri" symbol="gdata_documents_presentation_get_download_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsPresentation*"/>
					<parameter name="export_format" type="GDataDocumentsPresentationFormat"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_documents_presentation_new">
				<return-type type="GDataDocumentsPresentation*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
		</object>
		<object name="GDataDocumentsQuery" parent="GDataQuery" type-name="GDataDocumentsQuery" get-type="gdata_documents_query_get_type">
			<method name="add_collaborator" symbol="gdata_documents_query_add_collaborator">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
					<parameter name="email_address" type="gchar*"/>
				</parameters>
			</method>
			<method name="add_reader" symbol="gdata_documents_query_add_reader">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
					<parameter name="email_address" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_collaborator_addresses" symbol="gdata_documents_query_get_collaborator_addresses">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
				</parameters>
			</method>
			<method name="get_exact_title" symbol="gdata_documents_query_get_exact_title">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
				</parameters>
			</method>
			<method name="get_folder_id" symbol="gdata_documents_query_get_folder_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
				</parameters>
			</method>
			<method name="get_reader_addresses" symbol="gdata_documents_query_get_reader_addresses">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="gdata_documents_query_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_documents_query_new">
				<return-type type="GDataDocumentsQuery*"/>
				<parameters>
					<parameter name="q" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_limits" symbol="gdata_documents_query_new_with_limits">
				<return-type type="GDataDocumentsQuery*"/>
				<parameters>
					<parameter name="q" type="gchar*"/>
					<parameter name="start_index" type="gint"/>
					<parameter name="max_results" type="gint"/>
				</parameters>
			</constructor>
			<method name="set_folder_id" symbol="gdata_documents_query_set_folder_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
					<parameter name="folder_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_show_deleted" symbol="gdata_documents_query_set_show_deleted">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
					<parameter name="show_deleted" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_show_folders" symbol="gdata_documents_query_set_show_folders">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
					<parameter name="show_folders" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_title" symbol="gdata_documents_query_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
					<parameter name="title" type="gchar*"/>
					<parameter name="exact_title" type="gboolean"/>
				</parameters>
			</method>
			<method name="show_deleted" symbol="gdata_documents_query_show_deleted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
				</parameters>
			</method>
			<method name="show_folders" symbol="gdata_documents_query_show_folders">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsQuery*"/>
				</parameters>
			</method>
			<property name="exact-title" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="folder-id" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-deleted" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="show-folders" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataDocumentsService" parent="GDataService" type-name="GDataDocumentsService" get-type="gdata_documents_service_get_type">
			<method name="error_quark" symbol="gdata_documents_service_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_upload_uri" symbol="gdata_documents_service_get_upload_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="folder" type="GDataDocumentsFolder*"/>
				</parameters>
			</method>
			<method name="move_document_to_folder" symbol="gdata_documents_service_move_document_to_folder">
				<return-type type="GDataDocumentsEntry*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsService*"/>
					<parameter name="document" type="GDataDocumentsEntry*"/>
					<parameter name="folder" type="GDataDocumentsFolder*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_documents_service_new">
				<return-type type="GDataDocumentsService*"/>
				<parameters>
					<parameter name="client_id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="query_documents" symbol="gdata_documents_service_query_documents">
				<return-type type="GDataDocumentsFeed*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsService*"/>
					<parameter name="query" type="GDataDocumentsQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_documents_async" symbol="gdata_documents_service_query_documents_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsService*"/>
					<parameter name="query" type="GDataDocumentsQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="remove_document_from_folder" symbol="gdata_documents_service_remove_document_from_folder">
				<return-type type="GDataDocumentsEntry*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsService*"/>
					<parameter name="document" type="GDataDocumentsEntry*"/>
					<parameter name="folder" type="GDataDocumentsFolder*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="update_document" symbol="gdata_documents_service_update_document">
				<return-type type="GDataDocumentsEntry*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsService*"/>
					<parameter name="document" type="GDataDocumentsEntry*"/>
					<parameter name="document_file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="upload_document" symbol="gdata_documents_service_upload_document">
				<return-type type="GDataDocumentsEntry*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsService*"/>
					<parameter name="document" type="GDataDocumentsEntry*"/>
					<parameter name="document_file" type="GFile*"/>
					<parameter name="folder" type="GDataDocumentsFolder*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="spreadsheet-service" type="GDataService*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataDocumentsSpreadsheet" parent="GDataDocumentsEntry" type-name="GDataDocumentsSpreadsheet" get-type="gdata_documents_spreadsheet_get_type">
			<implements>
				<interface name="GDataAccessHandler"/>
			</implements>
			<method name="download_document" symbol="gdata_documents_spreadsheet_download_document">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsSpreadsheet*"/>
					<parameter name="service" type="GDataDocumentsService*"/>
					<parameter name="content_type" type="gchar**"/>
					<parameter name="export_format" type="GDataDocumentsSpreadsheetFormat"/>
					<parameter name="gid" type="gint"/>
					<parameter name="destination_file" type="GFile*"/>
					<parameter name="replace_file_if_exists" type="gboolean"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_download_uri" symbol="gdata_documents_spreadsheet_get_download_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsSpreadsheet*"/>
					<parameter name="export_format" type="GDataDocumentsSpreadsheetFormat"/>
					<parameter name="gid" type="gint"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_documents_spreadsheet_new">
				<return-type type="GDataDocumentsSpreadsheet*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
		</object>
		<object name="GDataDocumentsText" parent="GDataDocumentsEntry" type-name="GDataDocumentsText" get-type="gdata_documents_text_get_type">
			<implements>
				<interface name="GDataAccessHandler"/>
			</implements>
			<method name="download_document" symbol="gdata_documents_text_download_document">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsText*"/>
					<parameter name="service" type="GDataDocumentsService*"/>
					<parameter name="content_type" type="gchar**"/>
					<parameter name="export_format" type="GDataDocumentsTextFormat"/>
					<parameter name="destination_file" type="GFile*"/>
					<parameter name="replace_file_if_exists" type="gboolean"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_download_uri" symbol="gdata_documents_text_get_download_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataDocumentsText*"/>
					<parameter name="export_format" type="GDataDocumentsTextFormat"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_documents_text_new">
				<return-type type="GDataDocumentsText*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
		</object>
		<object name="GDataDownloadStream" parent="GInputStream" type-name="GDataDownloadStream" get-type="gdata_download_stream_get_type">
			<implements>
				<interface name="GSeekable"/>
			</implements>
			<method name="get_content_length" symbol="gdata_download_stream_get_content_length">
				<return-type type="gssize"/>
				<parameters>
					<parameter name="self" type="GDataDownloadStream*"/>
				</parameters>
			</method>
			<method name="get_content_type" symbol="gdata_download_stream_get_content_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataDownloadStream*"/>
				</parameters>
			</method>
			<method name="get_download_uri" symbol="gdata_download_stream_get_download_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataDownloadStream*"/>
				</parameters>
			</method>
			<method name="get_service" symbol="gdata_download_stream_get_service">
				<return-type type="GDataService*"/>
				<parameters>
					<parameter name="self" type="GDataDownloadStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_download_stream_new">
				<return-type type="GInputStream*"/>
				<parameters>
					<parameter name="service" type="GDataService*"/>
					<parameter name="download_uri" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="content-length" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="content-type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="download-uri" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="service" type="GDataService*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GDataEntry" parent="GDataParsable" type-name="GDataEntry" get-type="gdata_entry_get_type">
			<method name="add_author" symbol="gdata_entry_add_author">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
					<parameter name="author" type="GDataAuthor*"/>
				</parameters>
			</method>
			<method name="add_category" symbol="gdata_entry_add_category">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
					<parameter name="category" type="GDataCategory*"/>
				</parameters>
			</method>
			<method name="add_link" symbol="gdata_entry_add_link">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
					<parameter name="link" type="GDataLink*"/>
				</parameters>
			</method>
			<method name="get_categories" symbol="gdata_entry_get_categories">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
				</parameters>
			</method>
			<method name="get_content" symbol="gdata_entry_get_content">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
				</parameters>
			</method>
			<method name="get_etag" symbol="gdata_entry_get_etag">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gdata_entry_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
				</parameters>
			</method>
			<method name="get_published" symbol="gdata_entry_get_published">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
					<parameter name="published" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_rights" symbol="gdata_entry_get_rights">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
				</parameters>
			</method>
			<method name="get_summary" symbol="gdata_entry_get_summary">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="gdata_entry_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
				</parameters>
			</method>
			<method name="get_updated" symbol="gdata_entry_get_updated">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
					<parameter name="updated" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="is_inserted" symbol="gdata_entry_is_inserted">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
				</parameters>
			</method>
			<method name="look_up_link" symbol="gdata_entry_look_up_link">
				<return-type type="GDataLink*"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
					<parameter name="rel" type="gchar*"/>
				</parameters>
			</method>
			<method name="look_up_links" symbol="gdata_entry_look_up_links">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
					<parameter name="rel" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_entry_new">
				<return-type type="GDataEntry*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_content" symbol="gdata_entry_set_content">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
					<parameter name="content" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_rights" symbol="gdata_entry_set_rights">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
					<parameter name="rights" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_summary" symbol="gdata_entry_set_summary">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
					<parameter name="summary" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_title" symbol="gdata_entry_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataEntry*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<property name="content" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="etag" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="id" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="is-inserted" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="published" type="GTimeVal*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="rights" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="summary" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="updated" type="GTimeVal*" readable="1" writable="0" construct="0" construct-only="0"/>
			<vfunc name="get_entry_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GDataFeed" parent="GDataParsable" type-name="GDataFeed" get-type="gdata_feed_get_type">
			<method name="get_authors" symbol="gdata_feed_get_authors">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_categories" symbol="gdata_feed_get_categories">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_entries" symbol="gdata_feed_get_entries">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_etag" symbol="gdata_feed_get_etag">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_generator" symbol="gdata_feed_get_generator">
				<return-type type="GDataGenerator*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_icon" symbol="gdata_feed_get_icon">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gdata_feed_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_items_per_page" symbol="gdata_feed_get_items_per_page">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_links" symbol="gdata_feed_get_links">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_logo" symbol="gdata_feed_get_logo">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_start_index" symbol="gdata_feed_get_start_index">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_subtitle" symbol="gdata_feed_get_subtitle">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="gdata_feed_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_total_results" symbol="gdata_feed_get_total_results">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
				</parameters>
			</method>
			<method name="get_updated" symbol="gdata_feed_get_updated">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
					<parameter name="updated" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="look_up_entry" symbol="gdata_feed_look_up_entry">
				<return-type type="GDataEntry*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</method>
			<method name="look_up_link" symbol="gdata_feed_look_up_link">
				<return-type type="GDataLink*"/>
				<parameters>
					<parameter name="self" type="GDataFeed*"/>
					<parameter name="rel" type="gchar*"/>
				</parameters>
			</method>
			<property name="etag" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="generator" type="GDataGenerator*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="icon" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="items-per-page" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="logo" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="start-index" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="subtitle" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="total-results" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="updated" type="GTimeVal*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGContactCalendar" parent="GDataParsable" type-name="GDataGContactCalendar" get-type="gdata_gcontact_calendar_get_type">
			<method name="compare" symbol="gdata_gcontact_calendar_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGContactCalendar*"/>
					<parameter name="b" type="GDataGContactCalendar*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="gdata_gcontact_calendar_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactCalendar*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_gcontact_calendar_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactCalendar*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="gdata_gcontact_calendar_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactCalendar*"/>
				</parameters>
			</method>
			<method name="is_primary" symbol="gdata_gcontact_calendar_is_primary">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataGContactCalendar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gcontact_calendar_new">
				<return-type type="GDataGContactCalendar*"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
					<parameter name="relation_type" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_is_primary" symbol="gdata_gcontact_calendar_set_is_primary">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactCalendar*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_label" symbol="gdata_gcontact_calendar_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactCalendar*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_gcontact_calendar_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactCalendar*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_uri" symbol="gdata_gcontact_calendar_set_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactCalendar*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<property name="is-primary" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGContactEvent" parent="GDataParsable" type-name="GDataGContactEvent" get-type="gdata_gcontact_event_get_type">
			<method name="get_date" symbol="gdata_gcontact_event_get_date">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactEvent*"/>
					<parameter name="date" type="GDate*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="gdata_gcontact_event_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactEvent*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_gcontact_event_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactEvent*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gcontact_event_new">
				<return-type type="GDataGContactEvent*"/>
				<parameters>
					<parameter name="date" type="GDate*"/>
					<parameter name="relation_type" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_date" symbol="gdata_gcontact_event_set_date">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactEvent*"/>
					<parameter name="date" type="GDate*"/>
				</parameters>
			</method>
			<method name="set_label" symbol="gdata_gcontact_event_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactEvent*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_gcontact_event_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactEvent*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<property name="date" type="GDate*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGContactJot" parent="GDataParsable" type-name="GDataGContactJot" get-type="gdata_gcontact_jot_get_type">
			<method name="get_content" symbol="gdata_gcontact_jot_get_content">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactJot*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_gcontact_jot_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactJot*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gcontact_jot_new">
				<return-type type="GDataGContactJot*"/>
				<parameters>
					<parameter name="content" type="gchar*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_content" symbol="gdata_gcontact_jot_set_content">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactJot*"/>
					<parameter name="content" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_gcontact_jot_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactJot*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<property name="content" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGContactRelation" parent="GDataParsable" type-name="GDataGContactRelation" get-type="gdata_gcontact_relation_get_type">
			<method name="get_label" symbol="gdata_gcontact_relation_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactRelation*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdata_gcontact_relation_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactRelation*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_gcontact_relation_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactRelation*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gcontact_relation_new">
				<return-type type="GDataGContactRelation*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="relation_type" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_label" symbol="gdata_gcontact_relation_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactRelation*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="gdata_gcontact_relation_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactRelation*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_gcontact_relation_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactRelation*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGContactWebsite" parent="GDataParsable" type-name="GDataGContactWebsite" get-type="gdata_gcontact_website_get_type">
			<method name="compare" symbol="gdata_gcontact_website_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGContactWebsite*"/>
					<parameter name="b" type="GDataGContactWebsite*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="gdata_gcontact_website_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactWebsite*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_gcontact_website_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactWebsite*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="gdata_gcontact_website_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGContactWebsite*"/>
				</parameters>
			</method>
			<method name="is_primary" symbol="gdata_gcontact_website_is_primary">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataGContactWebsite*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gcontact_website_new">
				<return-type type="GDataGContactWebsite*"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
					<parameter name="relation_type" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_is_primary" symbol="gdata_gcontact_website_set_is_primary">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactWebsite*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_label" symbol="gdata_gcontact_website_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactWebsite*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_gcontact_website_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactWebsite*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_uri" symbol="gdata_gcontact_website_set_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGContactWebsite*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<property name="is-primary" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGDEmailAddress" parent="GDataParsable" type-name="GDataGDEmailAddress" get-type="gdata_gd_email_address_get_type">
			<method name="compare" symbol="gdata_gd_email_address_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGDEmailAddress*"/>
					<parameter name="b" type="GDataGDEmailAddress*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_gd_email_address_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDEmailAddress*"/>
				</parameters>
			</method>
			<method name="get_address" symbol="gdata_gd_email_address_get_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDEmailAddress*"/>
				</parameters>
			</method>
			<method name="get_display_name" symbol="gdata_gd_email_address_get_display_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDEmailAddress*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="gdata_gd_email_address_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDEmailAddress*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_gd_email_address_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDEmailAddress*"/>
				</parameters>
			</method>
			<method name="is_primary" symbol="gdata_gd_email_address_is_primary">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataGDEmailAddress*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gd_email_address_new">
				<return-type type="GDataGDEmailAddress*"/>
				<parameters>
					<parameter name="address" type="gchar*"/>
					<parameter name="relation_type" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_address" symbol="gdata_gd_email_address_set_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDEmailAddress*"/>
					<parameter name="address" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_display_name" symbol="gdata_gd_email_address_set_display_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDEmailAddress*"/>
					<parameter name="display_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_is_primary" symbol="gdata_gd_email_address_set_is_primary">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDEmailAddress*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_label" symbol="gdata_gd_email_address_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDEmailAddress*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_gd_email_address_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDEmailAddress*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<property name="address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="display-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-primary" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGDIMAddress" parent="GDataParsable" type-name="GDataGDIMAddress" get-type="gdata_gd_im_address_get_type">
			<method name="compare" symbol="gdata_gd_im_address_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGDIMAddress*"/>
					<parameter name="b" type="GDataGDIMAddress*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_gd_im_address_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDIMAddress*"/>
				</parameters>
			</method>
			<method name="get_address" symbol="gdata_gd_im_address_get_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDIMAddress*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="gdata_gd_im_address_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDIMAddress*"/>
				</parameters>
			</method>
			<method name="get_protocol" symbol="gdata_gd_im_address_get_protocol">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDIMAddress*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_gd_im_address_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDIMAddress*"/>
				</parameters>
			</method>
			<method name="is_primary" symbol="gdata_gd_im_address_is_primary">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataGDIMAddress*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gd_im_address_new">
				<return-type type="GDataGDIMAddress*"/>
				<parameters>
					<parameter name="address" type="gchar*"/>
					<parameter name="protocol" type="gchar*"/>
					<parameter name="relation_type" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_address" symbol="gdata_gd_im_address_set_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDIMAddress*"/>
					<parameter name="address" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_is_primary" symbol="gdata_gd_im_address_set_is_primary">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDIMAddress*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_label" symbol="gdata_gd_im_address_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDIMAddress*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_protocol" symbol="gdata_gd_im_address_set_protocol">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDIMAddress*"/>
					<parameter name="protocol" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_gd_im_address_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDIMAddress*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<property name="address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-primary" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="protocol" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGDName" parent="GDataParsable" type-name="GDataGDName" get-type="gdata_gd_name_get_type">
			<method name="compare" symbol="gdata_gd_name_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGDName*"/>
					<parameter name="b" type="GDataGDName*"/>
				</parameters>
			</method>
			<method name="get_additional_name" symbol="gdata_gd_name_get_additional_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDName*"/>
				</parameters>
			</method>
			<method name="get_family_name" symbol="gdata_gd_name_get_family_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDName*"/>
				</parameters>
			</method>
			<method name="get_full_name" symbol="gdata_gd_name_get_full_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDName*"/>
				</parameters>
			</method>
			<method name="get_given_name" symbol="gdata_gd_name_get_given_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDName*"/>
				</parameters>
			</method>
			<method name="get_prefix" symbol="gdata_gd_name_get_prefix">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDName*"/>
				</parameters>
			</method>
			<method name="get_suffix" symbol="gdata_gd_name_get_suffix">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDName*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gd_name_new">
				<return-type type="GDataGDName*"/>
				<parameters>
					<parameter name="given_name" type="gchar*"/>
					<parameter name="family_name" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_additional_name" symbol="gdata_gd_name_set_additional_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDName*"/>
					<parameter name="additional_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_family_name" symbol="gdata_gd_name_set_family_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDName*"/>
					<parameter name="family_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_full_name" symbol="gdata_gd_name_set_full_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDName*"/>
					<parameter name="full_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_given_name" symbol="gdata_gd_name_set_given_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDName*"/>
					<parameter name="given_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_prefix" symbol="gdata_gd_name_set_prefix">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDName*"/>
					<parameter name="prefix" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_suffix" symbol="gdata_gd_name_set_suffix">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDName*"/>
					<parameter name="suffix" type="gchar*"/>
				</parameters>
			</method>
			<property name="additional-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="family-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="full-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="given-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="prefix" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="suffix" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGDOrganization" parent="GDataParsable" type-name="GDataGDOrganization" get-type="gdata_gd_organization_get_type">
			<method name="compare" symbol="gdata_gd_organization_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGDOrganization*"/>
					<parameter name="b" type="GDataGDOrganization*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_gd_organization_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
				</parameters>
			</method>
			<method name="get_department" symbol="gdata_gd_organization_get_department">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
				</parameters>
			</method>
			<method name="get_job_description" symbol="gdata_gd_organization_get_job_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="gdata_gd_organization_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
				</parameters>
			</method>
			<method name="get_location" symbol="gdata_gd_organization_get_location">
				<return-type type="GDataGDWhere*"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdata_gd_organization_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_gd_organization_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
				</parameters>
			</method>
			<method name="get_symbol" symbol="gdata_gd_organization_get_symbol">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="gdata_gd_organization_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
				</parameters>
			</method>
			<method name="is_primary" symbol="gdata_gd_organization_is_primary">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gd_organization_new">
				<return-type type="GDataGDOrganization*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="title" type="gchar*"/>
					<parameter name="relation_type" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_department" symbol="gdata_gd_organization_set_department">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
					<parameter name="department" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_is_primary" symbol="gdata_gd_organization_set_is_primary">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_job_description" symbol="gdata_gd_organization_set_job_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
					<parameter name="job_description" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_label" symbol="gdata_gd_organization_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_location" symbol="gdata_gd_organization_set_location">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
					<parameter name="location" type="GDataGDWhere*"/>
				</parameters>
			</method>
			<method name="set_name" symbol="gdata_gd_organization_set_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_gd_organization_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_symbol" symbol="gdata_gd_organization_set_symbol">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
					<parameter name="symbol" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_title" symbol="gdata_gd_organization_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDOrganization*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<property name="department" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-primary" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="job-description" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="location" type="GDataGDWhere*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="symbol" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGDPhoneNumber" parent="GDataParsable" type-name="GDataGDPhoneNumber" get-type="gdata_gd_phone_number_get_type">
			<method name="compare" symbol="gdata_gd_phone_number_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGDPhoneNumber*"/>
					<parameter name="b" type="GDataGDPhoneNumber*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_gd_phone_number_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPhoneNumber*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="gdata_gd_phone_number_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPhoneNumber*"/>
				</parameters>
			</method>
			<method name="get_number" symbol="gdata_gd_phone_number_get_number">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPhoneNumber*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_gd_phone_number_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPhoneNumber*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="gdata_gd_phone_number_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPhoneNumber*"/>
				</parameters>
			</method>
			<method name="is_primary" symbol="gdata_gd_phone_number_is_primary">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataGDPhoneNumber*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gd_phone_number_new">
				<return-type type="GDataGDPhoneNumber*"/>
				<parameters>
					<parameter name="number" type="gchar*"/>
					<parameter name="relation_type" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
					<parameter name="uri" type="gchar*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_is_primary" symbol="gdata_gd_phone_number_set_is_primary">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPhoneNumber*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_label" symbol="gdata_gd_phone_number_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPhoneNumber*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_number" symbol="gdata_gd_phone_number_set_number">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPhoneNumber*"/>
					<parameter name="number" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_gd_phone_number_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPhoneNumber*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_uri" symbol="gdata_gd_phone_number_set_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPhoneNumber*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<property name="is-primary" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="number" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGDPostalAddress" parent="GDataParsable" type-name="GDataGDPostalAddress" get-type="gdata_gd_postal_address_get_type">
			<method name="compare" symbol="gdata_gd_postal_address_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGDPostalAddress*"/>
					<parameter name="b" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_gd_postal_address_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_address" symbol="gdata_gd_postal_address_get_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_agent" symbol="gdata_gd_postal_address_get_agent">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_city" symbol="gdata_gd_postal_address_get_city">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_country" symbol="gdata_gd_postal_address_get_country">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_country_code" symbol="gdata_gd_postal_address_get_country_code">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_house_name" symbol="gdata_gd_postal_address_get_house_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="gdata_gd_postal_address_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_mail_class" symbol="gdata_gd_postal_address_get_mail_class">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_neighborhood" symbol="gdata_gd_postal_address_get_neighborhood">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_po_box" symbol="gdata_gd_postal_address_get_po_box">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_postcode" symbol="gdata_gd_postal_address_get_postcode">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_region" symbol="gdata_gd_postal_address_get_region">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_gd_postal_address_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_street" symbol="gdata_gd_postal_address_get_street">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_subregion" symbol="gdata_gd_postal_address_get_subregion">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="get_usage" symbol="gdata_gd_postal_address_get_usage">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<method name="is_primary" symbol="gdata_gd_postal_address_is_primary">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gd_postal_address_new">
				<return-type type="GDataGDPostalAddress*"/>
				<parameters>
					<parameter name="relation_type" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_address" symbol="gdata_gd_postal_address_set_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="address" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_agent" symbol="gdata_gd_postal_address_set_agent">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="agent" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_city" symbol="gdata_gd_postal_address_set_city">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="city" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_country" symbol="gdata_gd_postal_address_set_country">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="country" type="gchar*"/>
					<parameter name="country_code" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_house_name" symbol="gdata_gd_postal_address_set_house_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="house_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_is_primary" symbol="gdata_gd_postal_address_set_is_primary">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="is_primary" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_label" symbol="gdata_gd_postal_address_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_mail_class" symbol="gdata_gd_postal_address_set_mail_class">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="mail_class" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_neighborhood" symbol="gdata_gd_postal_address_set_neighborhood">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="neighborhood" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_po_box" symbol="gdata_gd_postal_address_set_po_box">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="po_box" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_postcode" symbol="gdata_gd_postal_address_set_postcode">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="postcode" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_region" symbol="gdata_gd_postal_address_set_region">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="region" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_gd_postal_address_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_street" symbol="gdata_gd_postal_address_set_street">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="street" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_subregion" symbol="gdata_gd_postal_address_set_subregion">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="subregion" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_usage" symbol="gdata_gd_postal_address_set_usage">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDPostalAddress*"/>
					<parameter name="usage" type="gchar*"/>
				</parameters>
			</method>
			<property name="address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="agent" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="city" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="country" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="country-code" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="house-name" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-primary" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="mail-class" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="neighborhood" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="po-box" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="postcode" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="region" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="street" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="subregion" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="usage" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGDReminder" parent="GDataParsable" type-name="GDataGDReminder" get-type="gdata_gd_reminder_get_type">
			<method name="compare" symbol="gdata_gd_reminder_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGDReminder*"/>
					<parameter name="b" type="GDataGDReminder*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_gd_reminder_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDReminder*"/>
				</parameters>
			</method>
			<method name="get_absolute_time" symbol="gdata_gd_reminder_get_absolute_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDReminder*"/>
					<parameter name="absolute_time" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_method" symbol="gdata_gd_reminder_get_method">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDReminder*"/>
				</parameters>
			</method>
			<method name="get_relative_time" symbol="gdata_gd_reminder_get_relative_time">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="GDataGDReminder*"/>
				</parameters>
			</method>
			<method name="is_absolute_time" symbol="gdata_gd_reminder_is_absolute_time">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataGDReminder*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gd_reminder_new">
				<return-type type="GDataGDReminder*"/>
				<parameters>
					<parameter name="method" type="gchar*"/>
					<parameter name="absolute_time" type="GTimeVal*"/>
					<parameter name="relative_time" type="gint"/>
				</parameters>
			</constructor>
			<method name="set_absolute_time" symbol="gdata_gd_reminder_set_absolute_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDReminder*"/>
					<parameter name="absolute_time" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_method" symbol="gdata_gd_reminder_set_method">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDReminder*"/>
					<parameter name="method" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relative_time" symbol="gdata_gd_reminder_set_relative_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDReminder*"/>
					<parameter name="relative_time" type="gint"/>
				</parameters>
			</method>
			<property name="absolute-time" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-absolute-time" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="method" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relative-time" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGDWhen" parent="GDataParsable" type-name="GDataGDWhen" get-type="gdata_gd_when_get_type">
			<method name="add_reminder" symbol="gdata_gd_when_add_reminder">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWhen*"/>
					<parameter name="reminder" type="GDataGDReminder*"/>
				</parameters>
			</method>
			<method name="compare" symbol="gdata_gd_when_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGDWhen*"/>
					<parameter name="b" type="GDataGDWhen*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_gd_when_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWhen*"/>
				</parameters>
			</method>
			<method name="get_end_time" symbol="gdata_gd_when_get_end_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWhen*"/>
					<parameter name="end_time" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_reminders" symbol="gdata_gd_when_get_reminders">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataGDWhen*"/>
				</parameters>
			</method>
			<method name="get_start_time" symbol="gdata_gd_when_get_start_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWhen*"/>
					<parameter name="start_time" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_value_string" symbol="gdata_gd_when_get_value_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDWhen*"/>
				</parameters>
			</method>
			<method name="is_date" symbol="gdata_gd_when_is_date">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataGDWhen*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gd_when_new">
				<return-type type="GDataGDWhen*"/>
				<parameters>
					<parameter name="start_time" type="GTimeVal*"/>
					<parameter name="end_time" type="GTimeVal*"/>
					<parameter name="is_date" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="set_end_time" symbol="gdata_gd_when_set_end_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWhen*"/>
					<parameter name="end_time" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_is_date" symbol="gdata_gd_when_set_is_date">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWhen*"/>
					<parameter name="is_date" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_start_time" symbol="gdata_gd_when_set_start_time">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWhen*"/>
					<parameter name="start_time" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_value_string" symbol="gdata_gd_when_set_value_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWhen*"/>
					<parameter name="value_string" type="gchar*"/>
				</parameters>
			</method>
			<property name="end-time" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-date" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="start-time" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="value-string" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGDWhere" parent="GDataParsable" type-name="GDataGDWhere" get-type="gdata_gd_where_get_type">
			<method name="compare" symbol="gdata_gd_where_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGDWhere*"/>
					<parameter name="b" type="GDataGDWhere*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_gd_where_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWhere*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="gdata_gd_where_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDWhere*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_gd_where_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDWhere*"/>
				</parameters>
			</method>
			<method name="get_value_string" symbol="gdata_gd_where_get_value_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDWhere*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gd_where_new">
				<return-type type="GDataGDWhere*"/>
				<parameters>
					<parameter name="relation_type" type="gchar*"/>
					<parameter name="value_string" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_label" symbol="gdata_gd_where_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWhere*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_gd_where_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWhere*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_value_string" symbol="gdata_gd_where_set_value_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWhere*"/>
					<parameter name="value_string" type="gchar*"/>
				</parameters>
			</method>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="value-string" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGDWho" parent="GDataParsable" type-name="GDataGDWho" get-type="gdata_gd_who_get_type">
			<method name="compare" symbol="gdata_gd_who_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGDWho*"/>
					<parameter name="b" type="GDataGDWho*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_gd_who_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWho*"/>
				</parameters>
			</method>
			<method name="get_email_address" symbol="gdata_gd_who_get_email_address">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDWho*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_gd_who_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDWho*"/>
				</parameters>
			</method>
			<method name="get_value_string" symbol="gdata_gd_who_get_value_string">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGDWho*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_gd_who_new">
				<return-type type="GDataGDWho*"/>
				<parameters>
					<parameter name="relation_type" type="gchar*"/>
					<parameter name="value_string" type="gchar*"/>
					<parameter name="email_address" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_email_address" symbol="gdata_gd_who_set_email_address">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWho*"/>
					<parameter name="email_address" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_gd_who_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWho*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_value_string" symbol="gdata_gd_who_set_value_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGDWho*"/>
					<parameter name="value_string" type="gchar*"/>
				</parameters>
			</method>
			<property name="email-address" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="value-string" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataGenerator" parent="GDataParsable" type-name="GDataGenerator" get-type="gdata_generator_get_type">
			<method name="compare" symbol="gdata_generator_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataGenerator*"/>
					<parameter name="b" type="GDataGenerator*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_generator_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataGenerator*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdata_generator_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGenerator*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="gdata_generator_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGenerator*"/>
				</parameters>
			</method>
			<method name="get_version" symbol="gdata_generator_get_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataGenerator*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_generator_new">
				<return-type type="GDataGenerator*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="uri" type="gchar*"/>
					<parameter name="version" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="version" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataLink" parent="GDataParsable" type-name="GDataLink" get-type="gdata_link_get_type">
			<method name="compare" symbol="gdata_link_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GDataLink*"/>
					<parameter name="b" type="GDataLink*"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_link_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
				</parameters>
			</method>
			<method name="get_content_type" symbol="gdata_link_get_content_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
				</parameters>
			</method>
			<method name="get_language" symbol="gdata_link_get_language">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
				</parameters>
			</method>
			<method name="get_length" symbol="gdata_link_get_length">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
				</parameters>
			</method>
			<method name="get_relation_type" symbol="gdata_link_get_relation_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="gdata_link_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="gdata_link_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_link_new">
				<return-type type="GDataLink*"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_content_type" symbol="gdata_link_set_content_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
					<parameter name="content_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_language" symbol="gdata_link_set_language">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
					<parameter name="language" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_length" symbol="gdata_link_set_length">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
					<parameter name="length" type="gint"/>
				</parameters>
			</method>
			<method name="set_relation_type" symbol="gdata_link_set_relation_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
					<parameter name="relation_type" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_title" symbol="gdata_link_set_title">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
					<parameter name="title" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_uri" symbol="gdata_link_set_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataLink*"/>
					<parameter name="uri" type="gchar*"/>
				</parameters>
			</method>
			<property name="content-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="language" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="length" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="relation-type" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataMediaCategory" parent="GDataParsable" type-name="GDataMediaCategory" get-type="gdata_media_category_get_type">
			<method name="free" symbol="gdata_media_category_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataMediaCategory*"/>
				</parameters>
			</method>
			<method name="get_category" symbol="gdata_media_category_get_category">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataMediaCategory*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="gdata_media_category_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataMediaCategory*"/>
				</parameters>
			</method>
			<method name="get_scheme" symbol="gdata_media_category_get_scheme">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataMediaCategory*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_media_category_new">
				<return-type type="GDataMediaCategory*"/>
				<parameters>
					<parameter name="category" type="gchar*"/>
					<parameter name="scheme" type="gchar*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_category" symbol="gdata_media_category_set_category">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataMediaCategory*"/>
					<parameter name="category" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_label" symbol="gdata_media_category_set_label">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataMediaCategory*"/>
					<parameter name="label" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_scheme" symbol="gdata_media_category_set_scheme">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataMediaCategory*"/>
					<parameter name="scheme" type="gchar*"/>
				</parameters>
			</method>
			<property name="category" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="label" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="scheme" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataMediaContent" parent="GDataParsable" type-name="GDataMediaContent" get-type="gdata_media_content_get_type">
			<method name="download" symbol="gdata_media_content_download">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="self" type="GDataMediaContent*"/>
					<parameter name="service" type="GDataService*"/>
					<parameter name="default_filename" type="gchar*"/>
					<parameter name="target_dest_file" type="GFile*"/>
					<parameter name="replace_file_if_exists" type="gboolean"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_media_content_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataMediaContent*"/>
				</parameters>
			</method>
			<method name="get_content_type" symbol="gdata_media_content_get_content_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataMediaContent*"/>
				</parameters>
			</method>
			<method name="get_duration" symbol="gdata_media_content_get_duration">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="self" type="GDataMediaContent*"/>
				</parameters>
			</method>
			<method name="get_expression" symbol="gdata_media_content_get_expression">
				<return-type type="GDataMediaExpression"/>
				<parameters>
					<parameter name="self" type="GDataMediaContent*"/>
				</parameters>
			</method>
			<method name="get_filesize" symbol="gdata_media_content_get_filesize">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="self" type="GDataMediaContent*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="gdata_media_content_get_height">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataMediaContent*"/>
				</parameters>
			</method>
			<method name="get_medium" symbol="gdata_media_content_get_medium">
				<return-type type="GDataMediaMedium"/>
				<parameters>
					<parameter name="self" type="GDataMediaContent*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="gdata_media_content_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataMediaContent*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="gdata_media_content_get_width">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataMediaContent*"/>
				</parameters>
			</method>
			<method name="is_default" symbol="gdata_media_content_is_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataMediaContent*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_media_content_new">
				<return-type type="GDataMediaContent*"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
					<parameter name="type" type="gchar*"/>
					<parameter name="is_default" type="gboolean"/>
					<parameter name="expression" type="GDataMediaExpression"/>
					<parameter name="duration" type="gint"/>
					<parameter name="format" type="gint"/>
				</parameters>
			</constructor>
			<property name="content-type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="duration" type="gint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="expression" type="GDataMediaExpression" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="filesize" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="height" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-default" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="medium" type="GDataMediaMedium" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="width" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataMediaCredit" parent="GDataParsable" type-name="GDataMediaCredit" get-type="gdata_media_credit_get_type">
			<method name="free" symbol="gdata_media_credit_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataMediaCredit*"/>
				</parameters>
			</method>
			<method name="get_credit" symbol="gdata_media_credit_get_credit">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataMediaCredit*"/>
				</parameters>
			</method>
			<method name="get_role" symbol="gdata_media_credit_get_role">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataMediaCredit*"/>
				</parameters>
			</method>
			<method name="get_scheme" symbol="gdata_media_credit_get_scheme">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataMediaCredit*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_media_credit_new">
				<return-type type="GDataMediaCredit*"/>
				<parameters>
					<parameter name="credit" type="gchar*"/>
					<parameter name="partner" type="gboolean"/>
				</parameters>
			</constructor>
			<property name="credit" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="role" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="scheme" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataMediaThumbnail" parent="GDataParsable" type-name="GDataMediaThumbnail" get-type="gdata_media_thumbnail_get_type">
			<method name="build_time" symbol="gdata_media_thumbnail_build_time">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="_time" type="gint64"/>
				</parameters>
			</method>
			<method name="download" symbol="gdata_media_thumbnail_download">
				<return-type type="GFile*"/>
				<parameters>
					<parameter name="self" type="GDataMediaThumbnail*"/>
					<parameter name="service" type="GDataService*"/>
					<parameter name="default_filename" type="gchar*"/>
					<parameter name="target_dest_file" type="GFile*"/>
					<parameter name="replace_file_if_exists" type="gboolean"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="free" symbol="gdata_media_thumbnail_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataMediaThumbnail*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="gdata_media_thumbnail_get_height">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataMediaThumbnail*"/>
				</parameters>
			</method>
			<method name="get_time" symbol="gdata_media_thumbnail_get_time">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="self" type="GDataMediaThumbnail*"/>
				</parameters>
			</method>
			<method name="get_uri" symbol="gdata_media_thumbnail_get_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataMediaThumbnail*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="gdata_media_thumbnail_get_width">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataMediaThumbnail*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_media_thumbnail_new">
				<return-type type="GDataMediaThumbnail*"/>
				<parameters>
					<parameter name="uri" type="gchar*"/>
					<parameter name="width" type="guint"/>
					<parameter name="height" type="guint"/>
					<parameter name="_time" type="gint64"/>
				</parameters>
			</constructor>
			<method name="parse_time" symbol="gdata_media_thumbnail_parse_time">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="time_string" type="gchar*"/>
				</parameters>
			</method>
			<property name="height" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="time" type="gint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="width" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataParsable" parent="GObject" type-name="GDataParsable" get-type="gdata_parsable_get_type">
			<method name="get_xml" symbol="gdata_parsable_get_xml">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataParsable*"/>
				</parameters>
			</method>
			<constructor name="new_from_xml" symbol="gdata_parsable_new_from_xml">
				<return-type type="GDataParsable*"/>
				<parameters>
					<parameter name="parsable_type" type="GType"/>
					<parameter name="xml" type="gchar*"/>
					<parameter name="length" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<vfunc name="get_namespaces">
				<return-type type="void"/>
				<parameters>
					<parameter name="parsable" type="GDataParsable*"/>
					<parameter name="namespaces" type="GHashTable*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_xml">
				<return-type type="void"/>
				<parameters>
					<parameter name="parsable" type="GDataParsable*"/>
					<parameter name="xml_string" type="GString*"/>
				</parameters>
			</vfunc>
			<vfunc name="parse_xml">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parsable" type="GDataParsable*"/>
					<parameter name="doc" type="xmlDoc*"/>
					<parameter name="node" type="xmlNode*"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="post_parse_xml">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parsable" type="GDataParsable*"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="pre_get_xml">
				<return-type type="void"/>
				<parameters>
					<parameter name="parsable" type="GDataParsable*"/>
					<parameter name="xml_string" type="GString*"/>
				</parameters>
			</vfunc>
			<vfunc name="pre_parse_xml">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="parsable" type="GDataParsable*"/>
					<parameter name="doc" type="xmlDoc*"/>
					<parameter name="root_node" type="xmlNode*"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GDataPicasaWebAlbum" parent="GDataEntry" type-name="GDataPicasaWebAlbum" get-type="gdata_picasaweb_album_get_type">
			<method name="get_bytes_used" symbol="gdata_picasaweb_album_get_bytes_used">
				<return-type type="glong"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<method name="get_comment_count" symbol="gdata_picasaweb_album_get_comment_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<method name="get_contents" symbol="gdata_picasaweb_album_get_contents">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<method name="get_coordinates" symbol="gdata_picasaweb_album_get_coordinates">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
					<parameter name="latitude" type="gdouble*"/>
					<parameter name="longitude" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_edited" symbol="gdata_picasaweb_album_get_edited">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
					<parameter name="edited" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gdata_picasaweb_album_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<method name="get_location" symbol="gdata_picasaweb_album_get_location">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<method name="get_nickname" symbol="gdata_picasaweb_album_get_nickname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<method name="get_num_photos" symbol="gdata_picasaweb_album_get_num_photos">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<method name="get_num_photos_remaining" symbol="gdata_picasaweb_album_get_num_photos_remaining">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<method name="get_tags" symbol="gdata_picasaweb_album_get_tags">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<method name="get_thumbnails" symbol="gdata_picasaweb_album_get_thumbnails">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<method name="get_timestamp" symbol="gdata_picasaweb_album_get_timestamp">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
					<parameter name="timestamp" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_user" symbol="gdata_picasaweb_album_get_user">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<method name="get_visibility" symbol="gdata_picasaweb_album_get_visibility">
				<return-type type="GDataPicasaWebVisibility"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<method name="is_commenting_enabled" symbol="gdata_picasaweb_album_is_commenting_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_picasaweb_album_new">
				<return-type type="GDataPicasaWebAlbum*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_coordinates" symbol="gdata_picasaweb_album_set_coordinates">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
					<parameter name="latitude" type="gdouble"/>
					<parameter name="longitude" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_is_commenting_enabled" symbol="gdata_picasaweb_album_set_is_commenting_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
					<parameter name="is_commenting_enabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_location" symbol="gdata_picasaweb_album_set_location">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
					<parameter name="location" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_tags" symbol="gdata_picasaweb_album_set_tags">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
					<parameter name="tags" type="gchar**"/>
				</parameters>
			</method>
			<method name="set_timestamp" symbol="gdata_picasaweb_album_set_timestamp">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
					<parameter name="timestamp" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_visibility" symbol="gdata_picasaweb_album_set_visibility">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebAlbum*"/>
					<parameter name="visibility" type="GDataPicasaWebVisibility"/>
				</parameters>
			</method>
			<property name="album-id" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="bytes-used" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="comment-count" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="edited" type="GTimeVal*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-commenting-enabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="latitude" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="location" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="longitude" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="nickname" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="num-photos" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="num-photos-remaining" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="tags" type="GStrv*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="timestamp" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="user" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="visibility" type="GDataPicasaWebVisibility" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataPicasaWebFeed" parent="GDataFeed" type-name="GDataPicasaWebFeed" get-type="gdata_picasaweb_feed_get_type">
			<field name="padding1" type="gpointer"/>
		</object>
		<object name="GDataPicasaWebFile" parent="GDataEntry" type-name="GDataPicasaWebFile" get-type="gdata_picasaweb_file_get_type">
			<method name="get_album_id" symbol="gdata_picasaweb_file_get_album_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_caption" symbol="gdata_picasaweb_file_get_caption">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_checksum" symbol="gdata_picasaweb_file_get_checksum">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_client" symbol="gdata_picasaweb_file_get_client">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_comment_count" symbol="gdata_picasaweb_file_get_comment_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_contents" symbol="gdata_picasaweb_file_get_contents">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_coordinates" symbol="gdata_picasaweb_file_get_coordinates">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="latitude" type="gdouble*"/>
					<parameter name="longitude" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_credit" symbol="gdata_picasaweb_file_get_credit">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_distance" symbol="gdata_picasaweb_file_get_distance">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_edited" symbol="gdata_picasaweb_file_get_edited">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="edited" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_exposure" symbol="gdata_picasaweb_file_get_exposure">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_flash" symbol="gdata_picasaweb_file_get_flash">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_focal_length" symbol="gdata_picasaweb_file_get_focal_length">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_fstop" symbol="gdata_picasaweb_file_get_fstop">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_height" symbol="gdata_picasaweb_file_get_height">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="gdata_picasaweb_file_get_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_image_unique_id" symbol="gdata_picasaweb_file_get_image_unique_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_iso" symbol="gdata_picasaweb_file_get_iso">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_make" symbol="gdata_picasaweb_file_get_make">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_model" symbol="gdata_picasaweb_file_get_model">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_position" symbol="gdata_picasaweb_file_get_position">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_rotation" symbol="gdata_picasaweb_file_get_rotation">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="gdata_picasaweb_file_get_size">
				<return-type type="gsize"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_tags" symbol="gdata_picasaweb_file_get_tags">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_thumbnails" symbol="gdata_picasaweb_file_get_thumbnails">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_timestamp" symbol="gdata_picasaweb_file_get_timestamp">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="timestamp" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_version" symbol="gdata_picasaweb_file_get_version">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_video_status" symbol="gdata_picasaweb_file_get_video_status">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="get_width" symbol="gdata_picasaweb_file_get_width">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<method name="is_commenting_enabled" symbol="gdata_picasaweb_file_is_commenting_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_picasaweb_file_new">
				<return-type type="GDataPicasaWebFile*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_album_id" symbol="gdata_picasaweb_file_set_album_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="album_id" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_caption" symbol="gdata_picasaweb_file_set_caption">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="caption" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_checksum" symbol="gdata_picasaweb_file_set_checksum">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="checksum" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_client" symbol="gdata_picasaweb_file_set_client">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="client" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_coordinates" symbol="gdata_picasaweb_file_set_coordinates">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="latitude" type="gdouble"/>
					<parameter name="longitude" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_is_commenting_enabled" symbol="gdata_picasaweb_file_set_is_commenting_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="is_commenting_enabled" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_position" symbol="gdata_picasaweb_file_set_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="position" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_rotation" symbol="gdata_picasaweb_file_set_rotation">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="rotation" type="guint"/>
				</parameters>
			</method>
			<method name="set_tags" symbol="gdata_picasaweb_file_set_tags">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="tags" type="gchar**"/>
				</parameters>
			</method>
			<method name="set_timestamp" symbol="gdata_picasaweb_file_set_timestamp">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebFile*"/>
					<parameter name="timestamp" type="GTimeVal*"/>
				</parameters>
			</method>
			<property name="album-id" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="caption" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="checksum" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="client" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="comment-count" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="credit" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="distance" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="edited" type="GTimeVal*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="exposure" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="file-id" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="flash" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="focal-length" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="fstop" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="height" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="image-unique-id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-commenting-enabled" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="iso" type="glong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="latitude" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="longitude" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="make" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="model" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="position" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="rotation" type="guint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="size" type="gulong" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="tags" type="GStrv*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="timestamp" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="version" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="video-status" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="width" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataPicasaWebQuery" parent="GDataQuery" type-name="GDataPicasaWebQuery" get-type="gdata_picasaweb_query_get_type">
			<method name="get_bounding_box" symbol="gdata_picasaweb_query_get_bounding_box">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebQuery*"/>
					<parameter name="north" type="gdouble*"/>
					<parameter name="east" type="gdouble*"/>
					<parameter name="south" type="gdouble*"/>
					<parameter name="west" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_image_size" symbol="gdata_picasaweb_query_get_image_size">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebQuery*"/>
				</parameters>
			</method>
			<method name="get_location" symbol="gdata_picasaweb_query_get_location">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebQuery*"/>
				</parameters>
			</method>
			<method name="get_tag" symbol="gdata_picasaweb_query_get_tag">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebQuery*"/>
				</parameters>
			</method>
			<method name="get_thumbnail_size" symbol="gdata_picasaweb_query_get_thumbnail_size">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebQuery*"/>
				</parameters>
			</method>
			<method name="get_visibility" symbol="gdata_picasaweb_query_get_visibility">
				<return-type type="GDataPicasaWebVisibility"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebQuery*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_picasaweb_query_new">
				<return-type type="GDataPicasaWebQuery*"/>
				<parameters>
					<parameter name="q" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_limits" symbol="gdata_picasaweb_query_new_with_limits">
				<return-type type="GDataPicasaWebQuery*"/>
				<parameters>
					<parameter name="q" type="gchar*"/>
					<parameter name="start_index" type="gint"/>
					<parameter name="max_results" type="gint"/>
				</parameters>
			</constructor>
			<method name="set_bounding_box" symbol="gdata_picasaweb_query_set_bounding_box">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebQuery*"/>
					<parameter name="north" type="gdouble"/>
					<parameter name="east" type="gdouble"/>
					<parameter name="south" type="gdouble"/>
					<parameter name="west" type="gdouble"/>
				</parameters>
			</method>
			<method name="set_image_size" symbol="gdata_picasaweb_query_set_image_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebQuery*"/>
					<parameter name="image_size" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_location" symbol="gdata_picasaweb_query_set_location">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebQuery*"/>
					<parameter name="location" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_tag" symbol="gdata_picasaweb_query_set_tag">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebQuery*"/>
					<parameter name="tag" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_thumbnail_size" symbol="gdata_picasaweb_query_set_thumbnail_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebQuery*"/>
					<parameter name="thumbnail_size" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_visibility" symbol="gdata_picasaweb_query_set_visibility">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebQuery*"/>
					<parameter name="visibility" type="GDataPicasaWebVisibility"/>
				</parameters>
			</method>
			<property name="image-size" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="location" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="tag" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="thumbnail-size" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="visibility" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataPicasaWebService" parent="GDataService" type-name="GDataPicasaWebService" get-type="gdata_picasaweb_service_get_type">
			<method name="get_user" symbol="gdata_picasaweb_service_get_user">
				<return-type type="GDataPicasaWebUser*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebService*"/>
					<parameter name="username" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="insert_album" symbol="gdata_picasaweb_service_insert_album">
				<return-type type="GDataPicasaWebAlbum*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebService*"/>
					<parameter name="album" type="GDataPicasaWebAlbum*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_picasaweb_service_new">
				<return-type type="GDataPicasaWebService*"/>
				<parameters>
					<parameter name="client_id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="query_all_albums" symbol="gdata_picasaweb_service_query_all_albums">
				<return-type type="GDataFeed*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebService*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="username" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_all_albums_async" symbol="gdata_picasaweb_service_query_all_albums_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebService*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="username" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_files" symbol="gdata_picasaweb_service_query_files">
				<return-type type="GDataFeed*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebService*"/>
					<parameter name="album" type="GDataPicasaWebAlbum*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="upload_file" symbol="gdata_picasaweb_service_upload_file">
				<return-type type="GDataPicasaWebFile*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebService*"/>
					<parameter name="album" type="GDataPicasaWebAlbum*"/>
					<parameter name="file_entry" type="GDataPicasaWebFile*"/>
					<parameter name="file_data" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="upload_file_async" symbol="gdata_picasaweb_service_upload_file_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebService*"/>
					<parameter name="album" type="GDataPicasaWebAlbum*"/>
					<parameter name="file_entry" type="GDataPicasaWebFile*"/>
					<parameter name="file_data" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="upload_file_finish" symbol="gdata_picasaweb_service_upload_file_finish">
				<return-type type="GDataPicasaWebFile*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebService*"/>
					<parameter name="result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</object>
		<object name="GDataPicasaWebUser" parent="GDataEntry" type-name="GDataPicasaWebUser" get-type="gdata_picasaweb_user_get_type">
			<method name="get_max_photos_per_album" symbol="gdata_picasaweb_user_get_max_photos_per_album">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebUser*"/>
				</parameters>
			</method>
			<method name="get_nickname" symbol="gdata_picasaweb_user_get_nickname">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebUser*"/>
				</parameters>
			</method>
			<method name="get_quota_current" symbol="gdata_picasaweb_user_get_quota_current">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebUser*"/>
				</parameters>
			</method>
			<method name="get_quota_limit" symbol="gdata_picasaweb_user_get_quota_limit">
				<return-type type="gint64"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebUser*"/>
				</parameters>
			</method>
			<method name="get_thumbnail_uri" symbol="gdata_picasaweb_user_get_thumbnail_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebUser*"/>
				</parameters>
			</method>
			<method name="get_user" symbol="gdata_picasaweb_user_get_user">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataPicasaWebUser*"/>
				</parameters>
			</method>
			<property name="max-photos-per-album" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="nickname" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="quota-current" type="gint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="quota-limit" type="gint64" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="thumbnail-uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="user" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataQuery" parent="GObject" type-name="GDataQuery" get-type="gdata_query_get_type">
			<method name="get_author" symbol="gdata_query_get_author">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
				</parameters>
			</method>
			<method name="get_categories" symbol="gdata_query_get_categories">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
				</parameters>
			</method>
			<method name="get_etag" symbol="gdata_query_get_etag">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
				</parameters>
			</method>
			<method name="get_max_results" symbol="gdata_query_get_max_results">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
				</parameters>
			</method>
			<method name="get_published_max" symbol="gdata_query_get_published_max">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="published_max" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_published_min" symbol="gdata_query_get_published_min">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="published_min" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_q" symbol="gdata_query_get_q">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
				</parameters>
			</method>
			<method name="get_query_uri" symbol="gdata_query_get_query_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="feed_uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_start_index" symbol="gdata_query_get_start_index">
				<return-type type="gint"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
				</parameters>
			</method>
			<method name="get_updated_max" symbol="gdata_query_get_updated_max">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="updated_max" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_updated_min" symbol="gdata_query_get_updated_min">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="updated_min" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="is_strict" symbol="gdata_query_is_strict">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_query_new">
				<return-type type="GDataQuery*"/>
				<parameters>
					<parameter name="q" type="gchar*"/>
				</parameters>
			</constructor>
			<constructor name="new_with_limits" symbol="gdata_query_new_with_limits">
				<return-type type="GDataQuery*"/>
				<parameters>
					<parameter name="q" type="gchar*"/>
					<parameter name="start_index" type="gint"/>
					<parameter name="max_results" type="gint"/>
				</parameters>
			</constructor>
			<method name="next_page" symbol="gdata_query_next_page">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
				</parameters>
			</method>
			<method name="previous_page" symbol="gdata_query_previous_page">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
				</parameters>
			</method>
			<method name="set_author" symbol="gdata_query_set_author">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="author" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_categories" symbol="gdata_query_set_categories">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="categories" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_etag" symbol="gdata_query_set_etag">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="etag" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_is_strict" symbol="gdata_query_set_is_strict">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="is_strict" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_max_results" symbol="gdata_query_set_max_results">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="max_results" type="gint"/>
				</parameters>
			</method>
			<method name="set_published_max" symbol="gdata_query_set_published_max">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="published_max" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_published_min" symbol="gdata_query_set_published_min">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="published_min" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_q" symbol="gdata_query_set_q">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="q" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_start_index" symbol="gdata_query_set_start_index">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="start_index" type="gint"/>
				</parameters>
			</method>
			<method name="set_updated_max" symbol="gdata_query_set_updated_max">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="updated_max" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="set_updated_min" symbol="gdata_query_set_updated_min">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="updated_min" type="GTimeVal*"/>
				</parameters>
			</method>
			<property name="author" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="categories" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="etag" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-strict" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-results" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="published-max" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="published-min" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="q" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="start-index" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="updated-max" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="updated-min" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<vfunc name="get_query_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataQuery*"/>
					<parameter name="feed_uri" type="gchar*"/>
					<parameter name="query_uri" type="GString*"/>
					<parameter name="params_started" type="gboolean*"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GDataService" parent="GObject" type-name="GDataService" get-type="gdata_service_get_type">
			<method name="authenticate" symbol="gdata_service_authenticate">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="username" type="gchar*"/>
					<parameter name="password" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="authenticate_async" symbol="gdata_service_authenticate_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="username" type="gchar*"/>
					<parameter name="password" type="gchar*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="authenticate_finish" symbol="gdata_service_authenticate_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="async_result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="delete_entry" symbol="gdata_service_delete_entry">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="entry" type="GDataEntry*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="delete_entry_async" symbol="gdata_service_delete_entry_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="entry" type="GDataEntry*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="delete_entry_finish" symbol="gdata_service_delete_entry_finish">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="async_result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="error_quark" symbol="gdata_service_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_client_id" symbol="gdata_service_get_client_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
				</parameters>
			</method>
			<method name="get_password" symbol="gdata_service_get_password">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
				</parameters>
			</method>
			<method name="get_proxy_uri" symbol="gdata_service_get_proxy_uri">
				<return-type type="SoupURI*"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
				</parameters>
			</method>
			<method name="get_username" symbol="gdata_service_get_username">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
				</parameters>
			</method>
			<method name="insert_entry" symbol="gdata_service_insert_entry">
				<return-type type="GDataEntry*"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="upload_uri" type="gchar*"/>
					<parameter name="entry" type="GDataEntry*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="insert_entry_async" symbol="gdata_service_insert_entry_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="upload_uri" type="gchar*"/>
					<parameter name="entry" type="GDataEntry*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="insert_entry_finish" symbol="gdata_service_insert_entry_finish">
				<return-type type="GDataEntry*"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="async_result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="is_authenticated" symbol="gdata_service_is_authenticated">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
				</parameters>
			</method>
			<method name="query" symbol="gdata_service_query">
				<return-type type="GDataFeed*"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="feed_uri" type="gchar*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="entry_type" type="GType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_async" symbol="gdata_service_query_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="feed_uri" type="gchar*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="entry_type" type="GType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_finish" symbol="gdata_service_query_finish">
				<return-type type="GDataFeed*"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="async_result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_single_entry" symbol="gdata_service_query_single_entry">
				<return-type type="GDataEntry*"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="entry_id" type="gchar*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="entry_type" type="GType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_single_entry_async" symbol="gdata_service_query_single_entry_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="entry_id" type="gchar*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="entry_type" type="GType"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_single_entry_finish" symbol="gdata_service_query_single_entry_finish">
				<return-type type="GDataEntry*"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="async_result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_proxy_uri" symbol="gdata_service_set_proxy_uri">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="proxy_uri" type="SoupURI*"/>
				</parameters>
			</method>
			<method name="update_entry" symbol="gdata_service_update_entry">
				<return-type type="GDataEntry*"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="entry" type="GDataEntry*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="update_entry_async" symbol="gdata_service_update_entry_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="entry" type="GDataEntry*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="update_entry_finish" symbol="gdata_service_update_entry_finish">
				<return-type type="GDataEntry*"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="async_result" type="GAsyncResult*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="authenticated" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="client-id" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="password" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="proxy-uri" type="SoupURI*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="username" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="captcha-challenge" when="LAST">
				<return-type type="char*"/>
				<parameters>
					<parameter name="object" type="GDataService*"/>
					<parameter name="p0" type="char*"/>
				</parameters>
			</signal>
			<vfunc name="append_query_headers">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="message" type="SoupMessage*"/>
				</parameters>
			</vfunc>
			<vfunc name="parse_authentication_response">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="status" type="guint"/>
					<parameter name="response_body" type="gchar*"/>
					<parameter name="length" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
			<vfunc name="parse_error_response">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataService*"/>
					<parameter name="operation_type" type="GDataOperationType"/>
					<parameter name="status" type="guint"/>
					<parameter name="reason_phrase" type="gchar*"/>
					<parameter name="response_body" type="gchar*"/>
					<parameter name="length" type="gint"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</vfunc>
		</object>
		<object name="GDataUploadStream" parent="GOutputStream" type-name="GDataUploadStream" get-type="gdata_upload_stream_get_type">
			<method name="get_content_type" symbol="gdata_upload_stream_get_content_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataUploadStream*"/>
				</parameters>
			</method>
			<method name="get_entry" symbol="gdata_upload_stream_get_entry">
				<return-type type="GDataEntry*"/>
				<parameters>
					<parameter name="self" type="GDataUploadStream*"/>
				</parameters>
			</method>
			<method name="get_response" symbol="gdata_upload_stream_get_response">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataUploadStream*"/>
					<parameter name="length" type="gssize*"/>
				</parameters>
			</method>
			<method name="get_service" symbol="gdata_upload_stream_get_service">
				<return-type type="GDataService*"/>
				<parameters>
					<parameter name="self" type="GDataUploadStream*"/>
				</parameters>
			</method>
			<method name="get_slug" symbol="gdata_upload_stream_get_slug">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataUploadStream*"/>
				</parameters>
			</method>
			<method name="get_upload_uri" symbol="gdata_upload_stream_get_upload_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataUploadStream*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_upload_stream_new">
				<return-type type="GOutputStream*"/>
				<parameters>
					<parameter name="service" type="GDataService*"/>
					<parameter name="method" type="gchar*"/>
					<parameter name="upload_uri" type="gchar*"/>
					<parameter name="entry" type="GDataEntry*"/>
					<parameter name="slug" type="gchar*"/>
					<parameter name="content_type" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="content-type" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="entry" type="GDataEntry*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="service" type="GDataService*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="slug" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="upload-uri" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
		</object>
		<object name="GDataYouTubeContent" parent="GDataMediaContent" type-name="GDataYouTubeContent" get-type="gdata_youtube_content_get_type">
			<method name="get_format" symbol="gdata_youtube_content_get_format">
				<return-type type="GDataYouTubeFormat"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeContent*"/>
				</parameters>
			</method>
			<property name="format" type="GDataYouTubeFormat" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataYouTubeCredit" parent="GDataMediaCredit" type-name="GDataYouTubeCredit" get-type="gdata_youtube_credit_get_type">
			<method name="get_entity_type" symbol="gdata_youtube_credit_get_entity_type">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeCredit*"/>
				</parameters>
			</method>
			<property name="entity-type" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataYouTubeQuery" parent="GDataQuery" type-name="GDataYouTubeQuery" get-type="gdata_youtube_query_get_type">
			<method name="get_age" symbol="gdata_youtube_query_get_age">
				<return-type type="GDataYouTubeAge"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
				</parameters>
			</method>
			<method name="get_format" symbol="gdata_youtube_query_get_format">
				<return-type type="GDataYouTubeFormat"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
				</parameters>
			</method>
			<method name="get_language" symbol="gdata_youtube_query_get_language">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
				</parameters>
			</method>
			<method name="get_location" symbol="gdata_youtube_query_get_location">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
					<parameter name="latitude" type="gdouble*"/>
					<parameter name="longitude" type="gdouble*"/>
					<parameter name="radius" type="gdouble*"/>
					<parameter name="has_location" type="gboolean*"/>
				</parameters>
			</method>
			<method name="get_order_by" symbol="gdata_youtube_query_get_order_by">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
				</parameters>
			</method>
			<method name="get_restriction" symbol="gdata_youtube_query_get_restriction">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
				</parameters>
			</method>
			<method name="get_safe_search" symbol="gdata_youtube_query_get_safe_search">
				<return-type type="GDataYouTubeSafeSearch"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
				</parameters>
			</method>
			<method name="get_sort_order" symbol="gdata_youtube_query_get_sort_order">
				<return-type type="GDataYouTubeSortOrder"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
				</parameters>
			</method>
			<method name="get_uploader" symbol="gdata_youtube_query_get_uploader">
				<return-type type="GDataYouTubeUploader"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_youtube_query_new">
				<return-type type="GDataYouTubeQuery*"/>
				<parameters>
					<parameter name="q" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_age" symbol="gdata_youtube_query_set_age">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
					<parameter name="age" type="GDataYouTubeAge"/>
				</parameters>
			</method>
			<method name="set_format" symbol="gdata_youtube_query_set_format">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
					<parameter name="format" type="GDataYouTubeFormat"/>
				</parameters>
			</method>
			<method name="set_language" symbol="gdata_youtube_query_set_language">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
					<parameter name="language" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_location" symbol="gdata_youtube_query_set_location">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
					<parameter name="latitude" type="gdouble"/>
					<parameter name="longitude" type="gdouble"/>
					<parameter name="radius" type="gdouble"/>
					<parameter name="has_location" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_order_by" symbol="gdata_youtube_query_set_order_by">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
					<parameter name="order_by" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_restriction" symbol="gdata_youtube_query_set_restriction">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
					<parameter name="restriction" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_safe_search" symbol="gdata_youtube_query_set_safe_search">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
					<parameter name="safe_search" type="GDataYouTubeSafeSearch"/>
				</parameters>
			</method>
			<method name="set_sort_order" symbol="gdata_youtube_query_set_sort_order">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
					<parameter name="sort_order" type="GDataYouTubeSortOrder"/>
				</parameters>
			</method>
			<method name="set_uploader" symbol="gdata_youtube_query_set_uploader">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeQuery*"/>
					<parameter name="uploader" type="GDataYouTubeUploader"/>
				</parameters>
			</method>
			<property name="age" type="GDataYouTubeAge" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="format" type="GDataYouTubeFormat" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="has-location" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="language" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="latitude" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="location-radius" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="longitude" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="order-by" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="restriction" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="safe-search" type="GDataYouTubeSafeSearch" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="sort-order" type="GDataYouTubeSortOrder" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="uploader" type="GDataYouTubeUploader" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GDataYouTubeService" parent="GDataService" type-name="GDataYouTubeService" get-type="gdata_youtube_service_get_type">
			<method name="error_quark" symbol="gdata_youtube_service_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_developer_key" symbol="gdata_youtube_service_get_developer_key">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeService*"/>
				</parameters>
			</method>
			<method name="get_youtube_user" symbol="gdata_youtube_service_get_youtube_user">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeService*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_youtube_service_new">
				<return-type type="GDataYouTubeService*"/>
				<parameters>
					<parameter name="developer_key" type="gchar*"/>
					<parameter name="client_id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="query_related" symbol="gdata_youtube_service_query_related">
				<return-type type="GDataFeed*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeService*"/>
					<parameter name="video" type="GDataYouTubeVideo*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_related_async" symbol="gdata_youtube_service_query_related_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeService*"/>
					<parameter name="video" type="GDataYouTubeVideo*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_standard_feed" symbol="gdata_youtube_service_query_standard_feed">
				<return-type type="GDataFeed*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeService*"/>
					<parameter name="feed_type" type="GDataYouTubeStandardFeedType"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_standard_feed_async" symbol="gdata_youtube_service_query_standard_feed_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeService*"/>
					<parameter name="feed_type" type="GDataYouTubeStandardFeedType"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="query_videos" symbol="gdata_youtube_service_query_videos">
				<return-type type="GDataFeed*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeService*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="query_videos_async" symbol="gdata_youtube_service_query_videos_async">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeService*"/>
					<parameter name="query" type="GDataQuery*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="callback" type="GAsyncReadyCallback"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="upload_video" symbol="gdata_youtube_service_upload_video">
				<return-type type="GDataYouTubeVideo*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeService*"/>
					<parameter name="video" type="GDataYouTubeVideo*"/>
					<parameter name="video_file" type="GFile*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="developer-key" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="youtube-user" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataYouTubeState" parent="GDataParsable" type-name="GDataYouTubeState" get-type="gdata_youtube_state_get_type">
			<method name="free" symbol="gdata_youtube_state_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeState*"/>
				</parameters>
			</method>
			<method name="get_help_uri" symbol="gdata_youtube_state_get_help_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeState*"/>
				</parameters>
			</method>
			<method name="get_message" symbol="gdata_youtube_state_get_message">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeState*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gdata_youtube_state_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeState*"/>
				</parameters>
			</method>
			<method name="get_reason_code" symbol="gdata_youtube_state_get_reason_code">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeState*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_youtube_state_new">
				<return-type type="GDataYouTubeState*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="message" type="gchar*"/>
					<parameter name="reason_code" type="gchar*"/>
					<parameter name="help_uri" type="gchar*"/>
				</parameters>
			</constructor>
			<property name="help-uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="message" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="reason-code" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="GDataYouTubeVideo" parent="GDataEntry" type-name="GDataYouTubeVideo" get-type="gdata_youtube_video_get_type">
			<method name="get_access_control" symbol="gdata_youtube_video_get_access_control">
				<return-type type="GDataYouTubePermission"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="action" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_aspect_ratio" symbol="gdata_youtube_video_get_aspect_ratio">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="get_category" symbol="gdata_youtube_video_get_category">
				<return-type type="GDataMediaCategory*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="get_credit" symbol="gdata_youtube_video_get_credit">
				<return-type type="GDataYouTubeCredit*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="gdata_youtube_video_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="get_duration" symbol="gdata_youtube_video_get_duration">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="get_favorite_count" symbol="gdata_youtube_video_get_favorite_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="get_keywords" symbol="gdata_youtube_video_get_keywords">
				<return-type type="gchar**"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="get_location" symbol="gdata_youtube_video_get_location">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="get_player_uri" symbol="gdata_youtube_video_get_player_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="get_rating" symbol="gdata_youtube_video_get_rating">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="min" type="guint*"/>
					<parameter name="max" type="guint*"/>
					<parameter name="count" type="guint*"/>
					<parameter name="average" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_recorded" symbol="gdata_youtube_video_get_recorded">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="recorded" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="gdata_youtube_video_get_state">
				<return-type type="GDataYouTubeState*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="get_thumbnails" symbol="gdata_youtube_video_get_thumbnails">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="get_uploaded" symbol="gdata_youtube_video_get_uploaded">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="uploaded" type="GTimeVal*"/>
				</parameters>
			</method>
			<method name="get_video_id" symbol="gdata_youtube_video_get_video_id">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="get_video_id_from_uri" symbol="gdata_youtube_video_get_video_id_from_uri">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="video_uri" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_view_count" symbol="gdata_youtube_video_get_view_count">
				<return-type type="guint"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="is_draft" symbol="gdata_youtube_video_is_draft">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="is_private" symbol="gdata_youtube_video_is_private">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
				</parameters>
			</method>
			<method name="is_restricted_in_country" symbol="gdata_youtube_video_is_restricted_in_country">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="country" type="gchar*"/>
				</parameters>
			</method>
			<method name="look_up_content" symbol="gdata_youtube_video_look_up_content">
				<return-type type="GDataYouTubeContent*"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="type" type="gchar*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gdata_youtube_video_new">
				<return-type type="GDataYouTubeVideo*"/>
				<parameters>
					<parameter name="id" type="gchar*"/>
				</parameters>
			</constructor>
			<method name="set_access_control" symbol="gdata_youtube_video_set_access_control">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="action" type="gchar*"/>
					<parameter name="permission" type="GDataYouTubePermission"/>
				</parameters>
			</method>
			<method name="set_aspect_ratio" symbol="gdata_youtube_video_set_aspect_ratio">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="aspect_ratio" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_category" symbol="gdata_youtube_video_set_category">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="category" type="GDataMediaCategory*"/>
				</parameters>
			</method>
			<method name="set_description" symbol="gdata_youtube_video_set_description">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="description" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_is_draft" symbol="gdata_youtube_video_set_is_draft">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="is_draft" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_is_private" symbol="gdata_youtube_video_set_is_private">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="is_private" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_keywords" symbol="gdata_youtube_video_set_keywords">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="keywords" type="gchar**"/>
				</parameters>
			</method>
			<method name="set_location" symbol="gdata_youtube_video_set_location">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="location" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_recorded" symbol="gdata_youtube_video_set_recorded">
				<return-type type="void"/>
				<parameters>
					<parameter name="self" type="GDataYouTubeVideo*"/>
					<parameter name="recorded" type="GTimeVal*"/>
				</parameters>
			</method>
			<property name="aspect-ratio" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="average-rating" type="gdouble" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="category" type="GDataMediaCategory*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="credit" type="GDataYouTubeCredit*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="description" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="duration" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="favorite-count" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-draft" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="is-private" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="keywords" type="GStrv*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="location" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="max-rating" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="min-rating" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="player-uri" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="rating-count" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="recorded" type="GTimeVal*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="state" type="GDataYouTubeState*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="uploaded" type="GTimeVal*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="video-id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="view-count" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<interface name="GDataAccessHandler" type-name="GDataAccessHandler" get-type="gdata_access_handler_get_type">
			<requires>
				<interface name="GDataEntry"/>
			</requires>
			<method name="delete_rule" symbol="gdata_access_handler_delete_rule">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="self" type="GDataAccessHandler*"/>
					<parameter name="service" type="GDataService*"/>
					<parameter name="rule" type="GDataAccessRule*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_rules" symbol="gdata_access_handler_get_rules">
				<return-type type="GDataFeed*"/>
				<parameters>
					<parameter name="self" type="GDataAccessHandler*"/>
					<parameter name="service" type="GDataService*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="progress_callback" type="GDataQueryProgressCallback"/>
					<parameter name="progress_user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="insert_rule" symbol="gdata_access_handler_insert_rule">
				<return-type type="GDataAccessRule*"/>
				<parameters>
					<parameter name="self" type="GDataAccessHandler*"/>
					<parameter name="service" type="GDataService*"/>
					<parameter name="rule" type="GDataAccessRule*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="update_rule" symbol="gdata_access_handler_update_rule">
				<return-type type="GDataAccessRule*"/>
				<parameters>
					<parameter name="self" type="GDataAccessHandler*"/>
					<parameter name="service" type="GDataService*"/>
					<parameter name="rule" type="GDataAccessRule*"/>
					<parameter name="cancellable" type="GCancellable*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<vfunc name="is_owner_rule">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="rule" type="GDataAccessRule*"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="GDATA_ACCESS_ROLE_NONE" type="char*" value="none"/>
		<constant name="GDATA_ACCESS_SCOPE_DEFAULT" type="char*" value="default"/>
		<constant name="GDATA_ACCESS_SCOPE_DOMAIN" type="char*" value="domain"/>
		<constant name="GDATA_ACCESS_SCOPE_USER" type="char*" value="user"/>
		<constant name="GDATA_CALENDAR_ACCESS_ROLE_EDITOR" type="char*" value="http://schemas.google.com/gCal/2005#editor"/>
		<constant name="GDATA_CALENDAR_ACCESS_ROLE_FREE_BUSY" type="char*" value="http://schemas.google.com/gCal/2005#freebusy"/>
		<constant name="GDATA_CALENDAR_ACCESS_ROLE_OWNER" type="char*" value="http://schemas.google.com/gCal/2005#owner"/>
		<constant name="GDATA_CALENDAR_ACCESS_ROLE_READ" type="char*" value="http://schemas.google.com/gCal/2005#read"/>
		<constant name="GDATA_CALENDAR_ACCESS_ROLE_ROOT" type="char*" value="http://schemas.google.com/gCal/2005#root"/>
		<constant name="GDATA_DOCUMENTS_ACCESS_ROLE_OWNER" type="char*" value="owner"/>
		<constant name="GDATA_DOCUMENTS_ACCESS_ROLE_READER" type="char*" value="reader"/>
		<constant name="GDATA_DOCUMENTS_ACCESS_ROLE_WRITER" type="char*" value="writer"/>
		<constant name="GDATA_GCONTACT_CALENDAR_FREE_BUSY" type="char*" value="free-busy"/>
		<constant name="GDATA_GCONTACT_CALENDAR_HOME" type="char*" value="home"/>
		<constant name="GDATA_GCONTACT_CALENDAR_WORK" type="char*" value="work"/>
		<constant name="GDATA_GCONTACT_EVENT_ANNIVERSARY" type="char*" value="anniversary"/>
		<constant name="GDATA_GCONTACT_EVENT_OTHER" type="char*" value="other"/>
		<constant name="GDATA_GCONTACT_JOT_HOME" type="char*" value="home"/>
		<constant name="GDATA_GCONTACT_JOT_KEYWORDS" type="char*" value="keywords"/>
		<constant name="GDATA_GCONTACT_JOT_OTHER" type="char*" value="other"/>
		<constant name="GDATA_GCONTACT_JOT_USER" type="char*" value="user"/>
		<constant name="GDATA_GCONTACT_JOT_WORK" type="char*" value="work"/>
		<constant name="GDATA_GCONTACT_RELATION_ASSISTANT" type="char*" value="assistant"/>
		<constant name="GDATA_GCONTACT_RELATION_BROTHER" type="char*" value="brother"/>
		<constant name="GDATA_GCONTACT_RELATION_CHILD" type="char*" value="child"/>
		<constant name="GDATA_GCONTACT_RELATION_DOMESTIC_PARTNER" type="char*" value="domestic-partner"/>
		<constant name="GDATA_GCONTACT_RELATION_FATHER" type="char*" value="father"/>
		<constant name="GDATA_GCONTACT_RELATION_FRIEND" type="char*" value="friend"/>
		<constant name="GDATA_GCONTACT_RELATION_MANAGER" type="char*" value="manager"/>
		<constant name="GDATA_GCONTACT_RELATION_MOTHER" type="char*" value="mother"/>
		<constant name="GDATA_GCONTACT_RELATION_PARENT" type="char*" value="parent"/>
		<constant name="GDATA_GCONTACT_RELATION_PARTNER" type="char*" value="partner"/>
		<constant name="GDATA_GCONTACT_RELATION_REFERRER" type="char*" value="referred-by"/>
		<constant name="GDATA_GCONTACT_RELATION_RELATIVE" type="char*" value="relative"/>
		<constant name="GDATA_GCONTACT_RELATION_SISTER" type="char*" value="sister"/>
		<constant name="GDATA_GCONTACT_RELATION_SPOUSE" type="char*" value="spouse"/>
		<constant name="GDATA_GCONTACT_WEBSITE_BLOG" type="char*" value="blog"/>
		<constant name="GDATA_GCONTACT_WEBSITE_FTP" type="char*" value="ftp"/>
		<constant name="GDATA_GCONTACT_WEBSITE_HOME" type="char*" value="home"/>
		<constant name="GDATA_GCONTACT_WEBSITE_HOME_PAGE" type="char*" value="home-page"/>
		<constant name="GDATA_GCONTACT_WEBSITE_OTHER" type="char*" value="other"/>
		<constant name="GDATA_GCONTACT_WEBSITE_PROFILE" type="char*" value="profile"/>
		<constant name="GDATA_GCONTACT_WEBSITE_WORK" type="char*" value="work"/>
		<constant name="GDATA_GD_ADDRESS_USAGE_GENERAL" type="char*" value="http://schemas.google.com/g/2005#general"/>
		<constant name="GDATA_GD_ADDRESS_USAGE_LOCAL" type="char*" value="http://schemas.google.com/g/2005#local"/>
		<constant name="GDATA_GD_EMAIL_ADDRESS_HOME" type="char*" value="http://schemas.google.com/g/2005#home"/>
		<constant name="GDATA_GD_EMAIL_ADDRESS_OTHER" type="char*" value="http://schemas.google.com/g/2005#other"/>
		<constant name="GDATA_GD_EMAIL_ADDRESS_WORK" type="char*" value="http://schemas.google.com/g/2005#work"/>
		<constant name="GDATA_GD_EVENT_STATUS_CANCELED" type="char*" value="http://schemas.google.com/g/2005#event.canceled"/>
		<constant name="GDATA_GD_EVENT_STATUS_CONFIRMED" type="char*" value="http://schemas.google.com/g/2005#event.confirmed"/>
		<constant name="GDATA_GD_EVENT_STATUS_TENTATIVE" type="char*" value="http://schemas.google.com/g/2005#event.tentative"/>
		<constant name="GDATA_GD_EVENT_TRANSPARENCY_OPAQUE" type="char*" value="http://schemas.google.com/g/2005#event.opaque"/>
		<constant name="GDATA_GD_EVENT_TRANSPARENCY_TRANSPARENT" type="char*" value="http://schemas.google.com/g/2005#event.transparent"/>
		<constant name="GDATA_GD_EVENT_VISIBILITY_CONFIDENTIAL" type="char*" value="http://schemas.google.com/g/2005#event.confidential"/>
		<constant name="GDATA_GD_EVENT_VISIBILITY_DEFAULT" type="char*" value="http://schemas.google.com/g/2005#event.default"/>
		<constant name="GDATA_GD_EVENT_VISIBILITY_PRIVATE" type="char*" value="http://schemas.google.com/g/2005#event.private"/>
		<constant name="GDATA_GD_EVENT_VISIBILITY_PUBLIC" type="char*" value="http://schemas.google.com/g/2005#event.public"/>
		<constant name="GDATA_GD_IM_ADDRESS_HOME" type="char*" value="http://schemas.google.com/g/2005#home"/>
		<constant name="GDATA_GD_IM_ADDRESS_NETMEETING" type="char*" value="http://schemas.google.com/g/2005#netmeeting"/>
		<constant name="GDATA_GD_IM_ADDRESS_OTHER" type="char*" value="http://schemas.google.com/g/2005#other"/>
		<constant name="GDATA_GD_IM_ADDRESS_WORK" type="char*" value="http://schemas.google.com/g/2005#work"/>
		<constant name="GDATA_GD_IM_PROTOCOL_AIM" type="char*" value="http://schemas.google.com/g/2005#AIM"/>
		<constant name="GDATA_GD_IM_PROTOCOL_GOOGLE_TALK" type="char*" value="http://schemas.google.com/g/2005#GOOGLE_TALK"/>
		<constant name="GDATA_GD_IM_PROTOCOL_ICQ" type="char*" value="http://schemas.google.com/g/2005#ICQ"/>
		<constant name="GDATA_GD_IM_PROTOCOL_JABBER" type="char*" value="http://schemas.google.com/g/2005#JABBER"/>
		<constant name="GDATA_GD_IM_PROTOCOL_LIVE_MESSENGER" type="char*" value="http://schemas.google.com/g/2005#MSN"/>
		<constant name="GDATA_GD_IM_PROTOCOL_QQ" type="char*" value="http://schemas.google.com/g/2005#QQ"/>
		<constant name="GDATA_GD_IM_PROTOCOL_SKYPE" type="char*" value="http://schemas.google.com/g/2005#SKYPE"/>
		<constant name="GDATA_GD_IM_PROTOCOL_YAHOO_MESSENGER" type="char*" value="http://schemas.google.com/g/2005#YAHOO"/>
		<constant name="GDATA_GD_MAIL_CLASS_BOTH" type="char*" value="http://schemas.google.com/g/2005#both"/>
		<constant name="GDATA_GD_MAIL_CLASS_LETTERS" type="char*" value="http://schemas.google.com/g/2005#letters"/>
		<constant name="GDATA_GD_MAIL_CLASS_NEITHER" type="char*" value="http://schemas.google.com/g/2005#neither"/>
		<constant name="GDATA_GD_MAIL_CLASS_PARCELS" type="char*" value="http://schemas.google.com/g/2005#parcels"/>
		<constant name="GDATA_GD_ORGANIZATION_OTHER" type="char*" value="http://schemas.google.com/g/2005#other"/>
		<constant name="GDATA_GD_ORGANIZATION_WORK" type="char*" value="http://schemas.google.com/g/2005#work"/>
		<constant name="GDATA_GD_PHONE_NUMBER_ASSISTANT" type="char*" value="http://schemas.google.com/g/2005#assistant"/>
		<constant name="GDATA_GD_PHONE_NUMBER_CALLBACK" type="char*" value="http://schemas.google.com/g/2005#callback"/>
		<constant name="GDATA_GD_PHONE_NUMBER_CAR" type="char*" value="http://schemas.google.com/g/2005#car"/>
		<constant name="GDATA_GD_PHONE_NUMBER_COMPANY_MAIN" type="char*" value="http://schemas.google.com/g/2005#company_main"/>
		<constant name="GDATA_GD_PHONE_NUMBER_FAX" type="char*" value="http://schemas.google.com/g/2005#fax"/>
		<constant name="GDATA_GD_PHONE_NUMBER_HOME" type="char*" value="http://schemas.google.com/g/2005#home"/>
		<constant name="GDATA_GD_PHONE_NUMBER_HOME_FAX" type="char*" value="http://schemas.google.com/g/2005#home_fax"/>
		<constant name="GDATA_GD_PHONE_NUMBER_ISDN" type="char*" value="http://schemas.google.com/g/2005#isdn"/>
		<constant name="GDATA_GD_PHONE_NUMBER_MAIN" type="char*" value="http://schemas.google.com/g/2005#main"/>
		<constant name="GDATA_GD_PHONE_NUMBER_MOBILE" type="char*" value="http://schemas.google.com/g/2005#mobile"/>
		<constant name="GDATA_GD_PHONE_NUMBER_OTHER" type="char*" value="http://schemas.google.com/g/2005#other"/>
		<constant name="GDATA_GD_PHONE_NUMBER_OTHER_FAX" type="char*" value="http://schemas.google.com/g/2005#other_fax"/>
		<constant name="GDATA_GD_PHONE_NUMBER_PAGER" type="char*" value="http://schemas.google.com/g/2005#pager"/>
		<constant name="GDATA_GD_PHONE_NUMBER_RADIO" type="char*" value="http://schemas.google.com/g/2005#radio"/>
		<constant name="GDATA_GD_PHONE_NUMBER_TELEX" type="char*" value="http://schemas.google.com/g/2005#telex"/>
		<constant name="GDATA_GD_PHONE_NUMBER_TTY_TDD" type="char*" value="http://schemas.google.com/g/2005#tty_tdd"/>
		<constant name="GDATA_GD_PHONE_NUMBER_WORK" type="char*" value="http://schemas.google.com/g/2005#work"/>
		<constant name="GDATA_GD_PHONE_NUMBER_WORK_FAX" type="char*" value="http://schemas.google.com/g/2005#work_fax"/>
		<constant name="GDATA_GD_PHONE_NUMBER_WORK_MOBILE" type="char*" value="http://schemas.google.com/g/2005#work_mobile"/>
		<constant name="GDATA_GD_PHONE_NUMBER_WORK_PAGER" type="char*" value="http://schemas.google.com/g/2005#work_pager"/>
		<constant name="GDATA_GD_POSTAL_ADDRESS_HOME" type="char*" value="http://schemas.google.com/g/2005#home"/>
		<constant name="GDATA_GD_POSTAL_ADDRESS_OTHER" type="char*" value="http://schemas.google.com/g/2005#other"/>
		<constant name="GDATA_GD_POSTAL_ADDRESS_WORK" type="char*" value="http://schemas.google.com/g/2005#work"/>
		<constant name="GDATA_GD_REMINDER_ALERT" type="char*" value="alert"/>
		<constant name="GDATA_GD_REMINDER_EMAIL" type="char*" value="email"/>
		<constant name="GDATA_GD_REMINDER_SMS" type="char*" value="sms"/>
		<constant name="GDATA_GD_WHERE_EVENT" type="char*" value="http://schemas.google.com/g/2005#event"/>
		<constant name="GDATA_GD_WHERE_EVENT_ALTERNATE" type="char*" value="http://schemas.google.com/g/2005#event.alternate"/>
		<constant name="GDATA_GD_WHERE_EVENT_PARKING" type="char*" value="http://schemas.google.com/g/2005#event.parking"/>
		<constant name="GDATA_GD_WHO_EVENT_ATTENDEE" type="char*" value="http://schemas.google.com/g/2005#event.attendee"/>
		<constant name="GDATA_GD_WHO_EVENT_ORGANIZER" type="char*" value="http://schemas.google.com/g/2005#event.organizer"/>
		<constant name="GDATA_GD_WHO_EVENT_PERFORMER" type="char*" value="http://schemas.google.com/g/2005#event.performer"/>
		<constant name="GDATA_GD_WHO_EVENT_SPEAKER" type="char*" value="http://schemas.google.com/g/2005#event.speaker"/>
		<constant name="GDATA_LINK_ALTERNATE" type="char*" value="http://www.iana.org/assignments/relation/alternate"/>
		<constant name="GDATA_LINK_EDIT" type="char*" value="http://www.iana.org/assignments/relation/edit"/>
		<constant name="GDATA_LINK_EDIT_MEDIA" type="char*" value="http://www.iana.org/assignments/relation/edit-media"/>
		<constant name="GDATA_LINK_ENCLOSURE" type="char*" value="http://www.iana.org/assignments/relation/enclosure"/>
		<constant name="GDATA_LINK_RELATED" type="char*" value="http://www.iana.org/assignments/relation/related"/>
		<constant name="GDATA_LINK_SELF" type="char*" value="http://www.iana.org/assignments/relation/self"/>
		<constant name="GDATA_LINK_VIA" type="char*" value="http://www.iana.org/assignments/relation/via"/>
		<constant name="GDATA_PICASAWEB_VIDEO_STATUS_FAILED" type="char*" value="failed"/>
		<constant name="GDATA_PICASAWEB_VIDEO_STATUS_FINAL" type="char*" value="final"/>
		<constant name="GDATA_PICASAWEB_VIDEO_STATUS_PENDING" type="char*" value="pending"/>
		<constant name="GDATA_PICASAWEB_VIDEO_STATUS_READY" type="char*" value="ready"/>
		<constant name="GDATA_YOUTUBE_ACTION_COMMENT" type="char*" value="comment"/>
		<constant name="GDATA_YOUTUBE_ACTION_COMMENT_VOTE" type="char*" value="commentVote"/>
		<constant name="GDATA_YOUTUBE_ACTION_EMBED" type="char*" value="embed"/>
		<constant name="GDATA_YOUTUBE_ACTION_RATE" type="char*" value="rate"/>
		<constant name="GDATA_YOUTUBE_ACTION_SYNDICATE" type="char*" value="syndicate"/>
		<constant name="GDATA_YOUTUBE_ACTION_VIDEO_RESPOND" type="char*" value="videoRespond"/>
		<constant name="GDATA_YOUTUBE_ASPECT_RATIO_WIDESCREEN" type="char*" value="widescreen"/>
		<constant name="GDATA_YOUTUBE_CREDIT_ENTITY_PARTNER" type="char*" value="partner"/>
	</namespace>
</api>
