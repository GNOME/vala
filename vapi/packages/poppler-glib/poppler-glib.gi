<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Poppler">
		<function name="error_quark" symbol="poppler_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="get_backend" symbol="poppler_get_backend">
			<return-type type="PopplerBackend"/>
		</function>
		<function name="get_version" symbol="poppler_get_version">
			<return-type type="char*"/>
		</function>
		<callback name="PopplerAttachmentSaveFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="buf" type="gchar*"/>
				<parameter name="count" type="gsize"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</callback>
		<struct name="PopplerActionAny">
			<field name="type" type="PopplerActionType"/>
			<field name="title" type="gchar*"/>
		</struct>
		<struct name="PopplerActionGotoDest">
			<field name="type" type="PopplerActionType"/>
			<field name="title" type="gchar*"/>
			<field name="dest" type="PopplerDest*"/>
		</struct>
		<struct name="PopplerActionGotoRemote">
			<field name="type" type="PopplerActionType"/>
			<field name="title" type="gchar*"/>
			<field name="file_name" type="gchar*"/>
			<field name="dest" type="PopplerDest*"/>
		</struct>
		<struct name="PopplerActionLaunch">
			<field name="type" type="PopplerActionType"/>
			<field name="title" type="gchar*"/>
			<field name="file_name" type="gchar*"/>
			<field name="params" type="gchar*"/>
		</struct>
		<struct name="PopplerActionMovie">
			<field name="type" type="PopplerActionType"/>
			<field name="title" type="gchar*"/>
		</struct>
		<struct name="PopplerActionNamed">
			<field name="type" type="PopplerActionType"/>
			<field name="title" type="gchar*"/>
			<field name="named_dest" type="gchar*"/>
		</struct>
		<struct name="PopplerActionUri">
			<field name="type" type="PopplerActionType"/>
			<field name="title" type="gchar*"/>
			<field name="uri" type="char*"/>
		</struct>
		<boxed name="PopplerAction" type-name="PopplerAction" get-type="poppler_action_get_type">
			<method name="copy" symbol="poppler_action_copy">
				<return-type type="PopplerAction*"/>
				<parameters>
					<parameter name="action" type="PopplerAction*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_action_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="action" type="PopplerAction*"/>
				</parameters>
			</method>
			<field name="type" type="PopplerActionType"/>
			<field name="any" type="PopplerActionAny"/>
			<field name="goto_dest" type="PopplerActionGotoDest"/>
			<field name="goto_remote" type="PopplerActionGotoRemote"/>
			<field name="launch" type="PopplerActionLaunch"/>
			<field name="uri" type="PopplerActionUri"/>
			<field name="named" type="PopplerActionNamed"/>
			<field name="movie" type="PopplerActionMovie"/>
		</boxed>
		<boxed name="PopplerDest" type-name="PopplerDest" get-type="poppler_dest_get_type">
			<method name="copy" symbol="poppler_dest_copy">
				<return-type type="PopplerDest*"/>
				<parameters>
					<parameter name="dest" type="PopplerDest*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_dest_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="dest" type="PopplerDest*"/>
				</parameters>
			</method>
			<field name="type" type="PopplerDestType"/>
			<field name="page_num" type="int"/>
			<field name="left" type="double"/>
			<field name="bottom" type="double"/>
			<field name="right" type="double"/>
			<field name="top" type="double"/>
			<field name="zoom" type="double"/>
			<field name="named_dest" type="gchar*"/>
			<field name="change_left" type="guint"/>
			<field name="change_top" type="guint"/>
			<field name="change_zoom" type="guint"/>
		</boxed>
		<boxed name="PopplerFontsIter" type-name="PopplerFontsIter" get-type="poppler_fonts_iter_get_type">
			<method name="copy" symbol="poppler_fonts_iter_copy">
				<return-type type="PopplerFontsIter*"/>
				<parameters>
					<parameter name="iter" type="PopplerFontsIter*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_fonts_iter_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PopplerFontsIter*"/>
				</parameters>
			</method>
			<method name="get_file_name" symbol="poppler_fonts_iter_get_file_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="iter" type="PopplerFontsIter*"/>
				</parameters>
			</method>
			<method name="get_font_type" symbol="poppler_fonts_iter_get_font_type">
				<return-type type="PopplerFontType"/>
				<parameters>
					<parameter name="iter" type="PopplerFontsIter*"/>
				</parameters>
			</method>
			<method name="get_full_name" symbol="poppler_fonts_iter_get_full_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="iter" type="PopplerFontsIter*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="poppler_fonts_iter_get_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="iter" type="PopplerFontsIter*"/>
				</parameters>
			</method>
			<method name="is_embedded" symbol="poppler_fonts_iter_is_embedded">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PopplerFontsIter*"/>
				</parameters>
			</method>
			<method name="is_subset" symbol="poppler_fonts_iter_is_subset">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PopplerFontsIter*"/>
				</parameters>
			</method>
			<method name="next" symbol="poppler_fonts_iter_next">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PopplerFontsIter*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="PopplerFormFieldMapping" type-name="PopplerFormFieldMapping" get-type="poppler_form_field_mapping_get_type">
			<method name="copy" symbol="poppler_form_field_mapping_copy">
				<return-type type="PopplerFormFieldMapping*"/>
				<parameters>
					<parameter name="mapping" type="PopplerFormFieldMapping*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_form_field_mapping_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="mapping" type="PopplerFormFieldMapping*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="poppler_form_field_mapping_new">
				<return-type type="PopplerFormFieldMapping*"/>
			</constructor>
			<field name="area" type="PopplerRectangle"/>
			<field name="field" type="PopplerFormField*"/>
		</boxed>
		<boxed name="PopplerImageMapping" type-name="PopplerImageMapping" get-type="poppler_image_mapping_get_type">
			<method name="copy" symbol="poppler_image_mapping_copy">
				<return-type type="PopplerImageMapping*"/>
				<parameters>
					<parameter name="mapping" type="PopplerImageMapping*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_image_mapping_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="mapping" type="PopplerImageMapping*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="poppler_image_mapping_new">
				<return-type type="PopplerImageMapping*"/>
			</constructor>
			<field name="area" type="PopplerRectangle"/>
			<field name="image" type="GdkPixbuf*"/>
		</boxed>
		<boxed name="PopplerIndexIter" type-name="PopplerIndexIter" get-type="poppler_index_iter_get_type">
			<method name="copy" symbol="poppler_index_iter_copy">
				<return-type type="PopplerIndexIter*"/>
				<parameters>
					<parameter name="iter" type="PopplerIndexIter*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_index_iter_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PopplerIndexIter*"/>
				</parameters>
			</method>
			<method name="get_action" symbol="poppler_index_iter_get_action">
				<return-type type="PopplerAction*"/>
				<parameters>
					<parameter name="iter" type="PopplerIndexIter*"/>
				</parameters>
			</method>
			<method name="get_child" symbol="poppler_index_iter_get_child">
				<return-type type="PopplerIndexIter*"/>
				<parameters>
					<parameter name="parent" type="PopplerIndexIter*"/>
				</parameters>
			</method>
			<method name="is_open" symbol="poppler_index_iter_is_open">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PopplerIndexIter*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="poppler_index_iter_new">
				<return-type type="PopplerIndexIter*"/>
				<parameters>
					<parameter name="document" type="PopplerDocument*"/>
				</parameters>
			</constructor>
			<method name="next" symbol="poppler_index_iter_next">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PopplerIndexIter*"/>
				</parameters>
			</method>
		</boxed>
		<boxed name="PopplerLinkMapping" type-name="PopplerLinkMapping" get-type="poppler_link_mapping_get_type">
			<method name="copy" symbol="poppler_link_mapping_copy">
				<return-type type="PopplerLinkMapping*"/>
				<parameters>
					<parameter name="mapping" type="PopplerLinkMapping*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_link_mapping_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="mapping" type="PopplerLinkMapping*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="poppler_link_mapping_new">
				<return-type type="PopplerLinkMapping*"/>
			</constructor>
			<field name="area" type="PopplerRectangle"/>
			<field name="action" type="PopplerAction*"/>
		</boxed>
		<boxed name="PopplerPageTransition" type-name="PopplerPageTransition" get-type="poppler_page_transition_get_type">
			<method name="copy" symbol="poppler_page_transition_copy">
				<return-type type="PopplerPageTransition*"/>
				<parameters>
					<parameter name="transition" type="PopplerPageTransition*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_page_transition_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="transition" type="PopplerPageTransition*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="poppler_page_transition_new">
				<return-type type="PopplerPageTransition*"/>
			</constructor>
			<field name="type" type="PopplerPageTransitionType"/>
			<field name="alignment" type="PopplerPageTransitionAlignment"/>
			<field name="direction" type="PopplerPageTransitionDirection"/>
			<field name="duration" type="gint"/>
			<field name="angle" type="gint"/>
			<field name="scale" type="gdouble"/>
			<field name="rectangular" type="gboolean"/>
		</boxed>
		<boxed name="PopplerRectangle" type-name="PopplerRectangle" get-type="poppler_rectangle_get_type">
			<method name="copy" symbol="poppler_rectangle_copy">
				<return-type type="PopplerRectangle*"/>
				<parameters>
					<parameter name="rectangle" type="PopplerRectangle*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_rectangle_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="rectangle" type="PopplerRectangle*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="poppler_rectangle_new">
				<return-type type="PopplerRectangle*"/>
			</constructor>
			<field name="x1" type="gdouble"/>
			<field name="y1" type="gdouble"/>
			<field name="x2" type="gdouble"/>
			<field name="y2" type="gdouble"/>
		</boxed>
		<enum name="PopplerActionType">
			<member name="POPPLER_ACTION_UNKNOWN" value="0"/>
			<member name="POPPLER_ACTION_GOTO_DEST" value="1"/>
			<member name="POPPLER_ACTION_GOTO_REMOTE" value="2"/>
			<member name="POPPLER_ACTION_LAUNCH" value="3"/>
			<member name="POPPLER_ACTION_URI" value="4"/>
			<member name="POPPLER_ACTION_NAMED" value="5"/>
			<member name="POPPLER_ACTION_MOVIE" value="6"/>
		</enum>
		<enum name="PopplerBackend">
			<member name="POPPLER_BACKEND_UNKNOWN" value="0"/>
			<member name="POPPLER_BACKEND_SPLASH" value="1"/>
			<member name="POPPLER_BACKEND_CAIRO" value="2"/>
		</enum>
		<enum name="PopplerDestType">
			<member name="POPPLER_DEST_UNKNOWN" value="0"/>
			<member name="POPPLER_DEST_XYZ" value="1"/>
			<member name="POPPLER_DEST_FIT" value="2"/>
			<member name="POPPLER_DEST_FITH" value="3"/>
			<member name="POPPLER_DEST_FITV" value="4"/>
			<member name="POPPLER_DEST_FITR" value="5"/>
			<member name="POPPLER_DEST_FITB" value="6"/>
			<member name="POPPLER_DEST_FITBH" value="7"/>
			<member name="POPPLER_DEST_FITBV" value="8"/>
			<member name="POPPLER_DEST_NAMED" value="9"/>
		</enum>
		<enum name="PopplerError">
			<member name="POPPLER_ERROR_INVALID" value="0"/>
			<member name="POPPLER_ERROR_ENCRYPTED" value="1"/>
		</enum>
		<enum name="PopplerFontType">
			<member name="POPPLER_FONT_TYPE_UNKNOWN" value="0"/>
			<member name="POPPLER_FONT_TYPE_TYPE1" value="1"/>
			<member name="POPPLER_FONT_TYPE_TYPE1C" value="2"/>
			<member name="POPPLER_FONT_TYPE_TYPE1COT" value="3"/>
			<member name="POPPLER_FONT_TYPE_TYPE3" value="4"/>
			<member name="POPPLER_FONT_TYPE_TRUETYPE" value="5"/>
			<member name="POPPLER_FONT_TYPE_TRUETYPEOT" value="6"/>
			<member name="POPPLER_FONT_TYPE_CID_TYPE0" value="7"/>
			<member name="POPPLER_FONT_TYPE_CID_TYPE0C" value="8"/>
			<member name="POPPLER_FONT_TYPE_CID_TYPE0COT" value="9"/>
			<member name="POPPLER_FONT_TYPE_CID_TYPE2" value="10"/>
			<member name="POPPLER_FONT_TYPE_CID_TYPE2OT" value="11"/>
		</enum>
		<enum name="PopplerFormButtonType">
			<member name="POPPLER_FORM_BUTTON_PUSH" value="0"/>
			<member name="POPPLER_FORM_BUTTON_CHECK" value="1"/>
			<member name="POPPLER_FORM_BUTTON_RADIO" value="2"/>
		</enum>
		<enum name="PopplerFormChoiceType">
			<member name="POPPLER_FORM_CHOICE_COMBO" value="0"/>
			<member name="POPPLER_FORM_CHOICE_LIST" value="1"/>
		</enum>
		<enum name="PopplerFormFieldType">
			<member name="POPPLER_FORM_FIELD_UNKNOWN" value="0"/>
			<member name="POPPLER_FORM_FIELD_BUTTON" value="1"/>
			<member name="POPPLER_FORM_FIELD_TEXT" value="2"/>
			<member name="POPPLER_FORM_FIELD_CHOICE" value="3"/>
			<member name="POPPLER_FORM_FIELD_SIGNATURE" value="4"/>
		</enum>
		<enum name="PopplerFormTextType">
			<member name="POPPLER_FORM_TEXT_NORMAL" value="0"/>
			<member name="POPPLER_FORM_TEXT_MULTILINE" value="1"/>
			<member name="POPPLER_FORM_TEXT_FILE_SELECT" value="2"/>
		</enum>
		<enum name="PopplerOrientation">
			<member name="POPPLER_ORIENTATION_PORTRAIT" value="0"/>
			<member name="POPPLER_ORIENTATION_LANDSCAPE" value="1"/>
			<member name="POPPLER_ORIENTATION_UPSIDEDOWN" value="2"/>
			<member name="POPPLER_ORIENTATION_SEASCAPE" value="3"/>
		</enum>
		<enum name="PopplerPageLayout">
			<member name="POPPLER_PAGE_LAYOUT_UNSET" value="0"/>
			<member name="POPPLER_PAGE_LAYOUT_SINGLE_PAGE" value="1"/>
			<member name="POPPLER_PAGE_LAYOUT_ONE_COLUMN" value="2"/>
			<member name="POPPLER_PAGE_LAYOUT_TWO_COLUMN_LEFT" value="3"/>
			<member name="POPPLER_PAGE_LAYOUT_TWO_COLUMN_RIGHT" value="4"/>
			<member name="POPPLER_PAGE_LAYOUT_TWO_PAGE_LEFT" value="5"/>
			<member name="POPPLER_PAGE_LAYOUT_TWO_PAGE_RIGHT" value="6"/>
		</enum>
		<enum name="PopplerPageMode">
			<member name="POPPLER_PAGE_MODE_UNSET" value="0"/>
			<member name="POPPLER_PAGE_MODE_NONE" value="1"/>
			<member name="POPPLER_PAGE_MODE_USE_OUTLINES" value="2"/>
			<member name="POPPLER_PAGE_MODE_USE_THUMBS" value="3"/>
			<member name="POPPLER_PAGE_MODE_FULL_SCREEN" value="4"/>
			<member name="POPPLER_PAGE_MODE_USE_OC" value="5"/>
			<member name="POPPLER_PAGE_MODE_USE_ATTACHMENTS" value="6"/>
		</enum>
		<enum name="PopplerPageTransitionAlignment">
			<member name="POPPLER_PAGE_TRANSITION_HORIZONTAL" value="0"/>
			<member name="POPPLER_PAGE_TRANSITION_VERTICAL" value="1"/>
		</enum>
		<enum name="PopplerPageTransitionDirection">
			<member name="POPPLER_PAGE_TRANSITION_INWARD" value="0"/>
			<member name="POPPLER_PAGE_TRANSITION_OUTWARD" value="1"/>
		</enum>
		<enum name="PopplerPageTransitionType">
			<member name="POPPLER_PAGE_TRANSITION_REPLACE" value="0"/>
			<member name="POPPLER_PAGE_TRANSITION_SPLIT" value="1"/>
			<member name="POPPLER_PAGE_TRANSITION_BLINDS" value="2"/>
			<member name="POPPLER_PAGE_TRANSITION_BOX" value="3"/>
			<member name="POPPLER_PAGE_TRANSITION_WIPE" value="4"/>
			<member name="POPPLER_PAGE_TRANSITION_DISSOLVE" value="5"/>
			<member name="POPPLER_PAGE_TRANSITION_GLITTER" value="6"/>
			<member name="POPPLER_PAGE_TRANSITION_FLY" value="7"/>
			<member name="POPPLER_PAGE_TRANSITION_PUSH" value="8"/>
			<member name="POPPLER_PAGE_TRANSITION_COVER" value="9"/>
			<member name="POPPLER_PAGE_TRANSITION_UNCOVER" value="10"/>
			<member name="POPPLER_PAGE_TRANSITION_FADE" value="11"/>
		</enum>
		<enum name="PopplerSelectionStyle">
			<member name="POPPLER_SELECTION_GLYPH" value="0"/>
			<member name="POPPLER_SELECTION_WORD" value="1"/>
			<member name="POPPLER_SELECTION_LINE" value="2"/>
		</enum>
		<flags name="PopplerPermissions">
			<member name="POPPLER_PERMISSIONS_OK_TO_PRINT" value="1"/>
			<member name="POPPLER_PERMISSIONS_OK_TO_MODIFY" value="2"/>
			<member name="POPPLER_PERMISSIONS_OK_TO_COPY" value="4"/>
			<member name="POPPLER_PERMISSIONS_OK_TO_ADD_NOTES" value="8"/>
			<member name="POPPLER_PERMISSIONS_FULL" value="15"/>
		</flags>
		<flags name="PopplerViewerPreferences">
			<member name="POPPLER_VIEWER_PREFERENCES_UNSET" value="0"/>
			<member name="POPPLER_VIEWER_PREFERENCES_HIDE_TOOLBAR" value="1"/>
			<member name="POPPLER_VIEWER_PREFERENCES_HIDE_MENUBAR" value="2"/>
			<member name="POPPLER_VIEWER_PREFERENCES_HIDE_WINDOWUI" value="4"/>
			<member name="POPPLER_VIEWER_PREFERENCES_FIT_WINDOW" value="8"/>
			<member name="POPPLER_VIEWER_PREFERENCES_CENTER_WINDOW" value="16"/>
			<member name="POPPLER_VIEWER_PREFERENCES_DISPLAY_DOC_TITLE" value="32"/>
			<member name="POPPLER_VIEWER_PREFERENCES_DIRECTION_RTL" value="64"/>
		</flags>
		<object name="PopplerAttachment" parent="GObject" type-name="PopplerAttachment" get-type="poppler_attachment_get_type">
			<method name="save" symbol="poppler_attachment_save">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="attachment" type="PopplerAttachment*"/>
					<parameter name="filename" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="save_to_callback" symbol="poppler_attachment_save_to_callback">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="attachment" type="PopplerAttachment*"/>
					<parameter name="save_func" type="PopplerAttachmentSaveFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<field name="name" type="gchar*"/>
			<field name="description" type="gchar*"/>
			<field name="size" type="gsize"/>
			<field name="mtime" type="GTime"/>
			<field name="ctime" type="GTime"/>
			<field name="checksum" type="GString*"/>
		</object>
		<object name="PopplerDocument" parent="GObject" type-name="PopplerDocument" get-type="poppler_document_get_type">
			<method name="find_dest" symbol="poppler_document_find_dest">
				<return-type type="PopplerDest*"/>
				<parameters>
					<parameter name="document" type="PopplerDocument*"/>
					<parameter name="link_name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_attachments" symbol="poppler_document_get_attachments">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="document" type="PopplerDocument*"/>
				</parameters>
			</method>
			<method name="get_form_field" symbol="poppler_document_get_form_field">
				<return-type type="PopplerFormField*"/>
				<parameters>
					<parameter name="document" type="PopplerDocument*"/>
					<parameter name="id" type="gint"/>
				</parameters>
			</method>
			<method name="get_n_pages" symbol="poppler_document_get_n_pages">
				<return-type type="int"/>
				<parameters>
					<parameter name="document" type="PopplerDocument*"/>
				</parameters>
			</method>
			<method name="get_page" symbol="poppler_document_get_page">
				<return-type type="PopplerPage*"/>
				<parameters>
					<parameter name="document" type="PopplerDocument*"/>
					<parameter name="index" type="int"/>
				</parameters>
			</method>
			<method name="get_page_by_label" symbol="poppler_document_get_page_by_label">
				<return-type type="PopplerPage*"/>
				<parameters>
					<parameter name="document" type="PopplerDocument*"/>
					<parameter name="label" type="char*"/>
				</parameters>
			</method>
			<method name="has_attachments" symbol="poppler_document_has_attachments">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="document" type="PopplerDocument*"/>
				</parameters>
			</method>
			<constructor name="new_from_data" symbol="poppler_document_new_from_data">
				<return-type type="PopplerDocument*"/>
				<parameters>
					<parameter name="data" type="char*"/>
					<parameter name="length" type="int"/>
					<parameter name="password" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<constructor name="new_from_file" symbol="poppler_document_new_from_file">
				<return-type type="PopplerDocument*"/>
				<parameters>
					<parameter name="uri" type="char*"/>
					<parameter name="password" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</constructor>
			<method name="save" symbol="poppler_document_save">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="document" type="PopplerDocument*"/>
					<parameter name="uri" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<property name="author" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="creation-date" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="creator" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="format" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="keywords" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="linearized" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="metadata" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="mod-date" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="page-layout" type="PopplerPageLayout" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="page-mode" type="PopplerPageMode" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="permissions" type="PopplerPermissions" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="producer" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="subject" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="title" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="viewer-preferences" type="PopplerViewerPreferences" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<object name="PopplerFontInfo" parent="GObject" type-name="PopplerFontInfo" get-type="poppler_font_info_get_type">
			<method name="free" symbol="poppler_font_info_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="font_info" type="PopplerFontInfo*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="poppler_font_info_new">
				<return-type type="PopplerFontInfo*"/>
				<parameters>
					<parameter name="document" type="PopplerDocument*"/>
				</parameters>
			</constructor>
			<method name="scan" symbol="poppler_font_info_scan">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="font_info" type="PopplerFontInfo*"/>
					<parameter name="n_pages" type="int"/>
					<parameter name="iter" type="PopplerFontsIter**"/>
				</parameters>
			</method>
		</object>
		<object name="PopplerFormField" parent="GObject" type-name="PopplerFormField" get-type="poppler_form_field_get_type">
			<method name="button_get_button_type" symbol="poppler_form_field_button_get_button_type">
				<return-type type="PopplerFormButtonType"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="button_get_state" symbol="poppler_form_field_button_get_state">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="button_set_state" symbol="poppler_form_field_button_set_state">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
					<parameter name="state" type="gboolean"/>
				</parameters>
			</method>
			<method name="choice_can_select_multiple" symbol="poppler_form_field_choice_can_select_multiple">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="choice_commit_on_change" symbol="poppler_form_field_choice_commit_on_change">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="choice_do_spell_check" symbol="poppler_form_field_choice_do_spell_check">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="choice_get_choice_type" symbol="poppler_form_field_choice_get_choice_type">
				<return-type type="PopplerFormChoiceType"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="choice_get_item" symbol="poppler_form_field_choice_get_item">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
					<parameter name="index" type="gint"/>
				</parameters>
			</method>
			<method name="choice_get_n_items" symbol="poppler_form_field_choice_get_n_items">
				<return-type type="gint"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="choice_get_text" symbol="poppler_form_field_choice_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="choice_is_editable" symbol="poppler_form_field_choice_is_editable">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="choice_is_item_selected" symbol="poppler_form_field_choice_is_item_selected">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
					<parameter name="index" type="gint"/>
				</parameters>
			</method>
			<method name="choice_select_item" symbol="poppler_form_field_choice_select_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
					<parameter name="index" type="gint"/>
				</parameters>
			</method>
			<method name="choice_set_text" symbol="poppler_form_field_choice_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
			<method name="choice_toggle_item" symbol="poppler_form_field_choice_toggle_item">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
					<parameter name="index" type="gint"/>
				</parameters>
			</method>
			<method name="choice_unselect_all" symbol="poppler_form_field_choice_unselect_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="get_field_type" symbol="poppler_form_field_get_field_type">
				<return-type type="PopplerFormFieldType"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="get_font_size" symbol="poppler_form_field_get_font_size">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="get_id" symbol="poppler_form_field_get_id">
				<return-type type="gint"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="is_read_only" symbol="poppler_form_field_is_read_only">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="text_do_scroll" symbol="poppler_form_field_text_do_scroll">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="text_do_spell_check" symbol="poppler_form_field_text_do_spell_check">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="text_get_max_len" symbol="poppler_form_field_text_get_max_len">
				<return-type type="gint"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="text_get_text" symbol="poppler_form_field_text_get_text">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="text_get_text_type" symbol="poppler_form_field_text_get_text_type">
				<return-type type="PopplerFormTextType"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="text_is_password" symbol="poppler_form_field_text_is_password">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="text_is_rich_text" symbol="poppler_form_field_text_is_rich_text">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
				</parameters>
			</method>
			<method name="text_set_text" symbol="poppler_form_field_text_set_text">
				<return-type type="void"/>
				<parameters>
					<parameter name="field" type="PopplerFormField*"/>
					<parameter name="text" type="gchar*"/>
				</parameters>
			</method>
		</object>
		<object name="PopplerPSFile" parent="GObject" type-name="PopplerPSFile" get-type="poppler_ps_file_get_type">
			<method name="free" symbol="poppler_ps_file_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="ps_file" type="PopplerPSFile*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="poppler_ps_file_new">
				<return-type type="PopplerPSFile*"/>
				<parameters>
					<parameter name="document" type="PopplerDocument*"/>
					<parameter name="filename" type="char*"/>
					<parameter name="first_page" type="int"/>
					<parameter name="n_pages" type="int"/>
				</parameters>
			</constructor>
			<method name="set_duplex" symbol="poppler_ps_file_set_duplex">
				<return-type type="void"/>
				<parameters>
					<parameter name="ps_file" type="PopplerPSFile*"/>
					<parameter name="duplex" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_paper_size" symbol="poppler_ps_file_set_paper_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="ps_file" type="PopplerPSFile*"/>
					<parameter name="width" type="double"/>
					<parameter name="height" type="double"/>
				</parameters>
			</method>
		</object>
		<object name="PopplerPage" parent="GObject" type-name="PopplerPage" get-type="poppler_page_get_type">
			<method name="find_text" symbol="poppler_page_find_text">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
					<parameter name="text" type="char*"/>
				</parameters>
			</method>
			<method name="free_form_field_mapping" symbol="poppler_page_free_form_field_mapping">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="free_image_mapping" symbol="poppler_page_free_image_mapping">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="free_link_mapping" symbol="poppler_page_free_link_mapping">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GList*"/>
				</parameters>
			</method>
			<method name="get_crop_box" symbol="poppler_page_get_crop_box">
				<return-type type="void"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
					<parameter name="rect" type="PopplerRectangle*"/>
				</parameters>
			</method>
			<method name="get_duration" symbol="poppler_page_get_duration">
				<return-type type="double"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
				</parameters>
			</method>
			<method name="get_form_field_mapping" symbol="poppler_page_get_form_field_mapping">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
				</parameters>
			</method>
			<method name="get_image_mapping" symbol="poppler_page_get_image_mapping">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
				</parameters>
			</method>
			<method name="get_index" symbol="poppler_page_get_index">
				<return-type type="int"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
				</parameters>
			</method>
			<method name="get_link_mapping" symbol="poppler_page_get_link_mapping">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
				</parameters>
			</method>
			<method name="get_selection_region" symbol="poppler_page_get_selection_region">
				<return-type type="GdkRegion*"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
					<parameter name="scale" type="gdouble"/>
					<parameter name="style" type="PopplerSelectionStyle"/>
					<parameter name="selection" type="PopplerRectangle*"/>
				</parameters>
			</method>
			<method name="get_size" symbol="poppler_page_get_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
					<parameter name="width" type="double*"/>
					<parameter name="height" type="double*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="poppler_page_get_text">
				<return-type type="char*"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
					<parameter name="style" type="PopplerSelectionStyle"/>
					<parameter name="rect" type="PopplerRectangle*"/>
				</parameters>
			</method>
			<method name="get_thumbnail" symbol="poppler_page_get_thumbnail">
				<return-type type="GdkPixbuf*"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
				</parameters>
			</method>
			<method name="get_thumbnail_size" symbol="poppler_page_get_thumbnail_size">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
					<parameter name="width" type="int*"/>
					<parameter name="height" type="int*"/>
				</parameters>
			</method>
			<method name="get_transition" symbol="poppler_page_get_transition">
				<return-type type="PopplerPageTransition*"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
				</parameters>
			</method>
			<method name="render" symbol="poppler_page_render">
				<return-type type="void"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
					<parameter name="cairo" type="cairo_t*"/>
				</parameters>
			</method>
			<method name="render_selection" symbol="poppler_page_render_selection">
				<return-type type="void"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
					<parameter name="cairo" type="cairo_t*"/>
					<parameter name="selection" type="PopplerRectangle*"/>
					<parameter name="old_selection" type="PopplerRectangle*"/>
					<parameter name="style" type="PopplerSelectionStyle"/>
					<parameter name="glyph_color" type="GdkColor*"/>
					<parameter name="background_color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="render_selection_to_pixbuf" symbol="poppler_page_render_selection_to_pixbuf">
				<return-type type="void"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
					<parameter name="scale" type="gdouble"/>
					<parameter name="rotation" type="int"/>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
					<parameter name="selection" type="PopplerRectangle*"/>
					<parameter name="old_selection" type="PopplerRectangle*"/>
					<parameter name="style" type="PopplerSelectionStyle"/>
					<parameter name="glyph_color" type="GdkColor*"/>
					<parameter name="background_color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="render_to_pixbuf" symbol="poppler_page_render_to_pixbuf">
				<return-type type="void"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
					<parameter name="src_x" type="int"/>
					<parameter name="src_y" type="int"/>
					<parameter name="src_width" type="int"/>
					<parameter name="src_height" type="int"/>
					<parameter name="scale" type="double"/>
					<parameter name="rotation" type="int"/>
					<parameter name="pixbuf" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="render_to_ps" symbol="poppler_page_render_to_ps">
				<return-type type="void"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
					<parameter name="ps_file" type="PopplerPSFile*"/>
				</parameters>
			</method>
			<property name="label" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<constant name="POPPLER_HAS_CAIRO" type="int" value="1"/>
	</namespace>
</api>
