<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Poppler">
		<function name="date_parse" symbol="poppler_date_parse">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="date" type="gchar*"/>
				<parameter name="timet" type="time_t*"/>
			</parameters>
		</function>
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
		<boxed name="PopplerAnnotCalloutLine" type-name="PopplerAnnotCalloutLine" get-type="poppler_annot_callout_line_get_type">
			<method name="copy" symbol="poppler_annot_callout_line_copy">
				<return-type type="PopplerAnnotCalloutLine*"/>
				<parameters>
					<parameter name="callout" type="PopplerAnnotCalloutLine*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_annot_callout_line_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="callout" type="PopplerAnnotCalloutLine*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="poppler_annot_callout_line_new">
				<return-type type="PopplerAnnotCalloutLine*"/>
			</constructor>
			<field name="multiline" type="gboolean"/>
			<field name="x1" type="gdouble"/>
			<field name="y1" type="gdouble"/>
			<field name="x2" type="gdouble"/>
			<field name="y2" type="gdouble"/>
			<field name="x3" type="gdouble"/>
			<field name="y3" type="gdouble"/>
		</boxed>
		<boxed name="PopplerAnnotMapping" type-name="PopplerAnnotMapping" get-type="poppler_annot_mapping_get_type">
			<method name="copy" symbol="poppler_annot_mapping_copy">
				<return-type type="PopplerAnnotMapping*"/>
				<parameters>
					<parameter name="mapping" type="PopplerAnnotMapping*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_annot_mapping_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="mapping" type="PopplerAnnotMapping*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="poppler_annot_mapping_new">
				<return-type type="PopplerAnnotMapping*"/>
			</constructor>
			<field name="area" type="PopplerRectangle"/>
			<field name="annot" type="PopplerAnnot*"/>
		</boxed>
		<boxed name="PopplerColor" type-name="PopplerColor" get-type="poppler_color_get_type">
			<method name="copy" symbol="poppler_color_copy">
				<return-type type="PopplerColor*"/>
				<parameters>
					<parameter name="color" type="PopplerColor*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_color_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="PopplerColor*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="poppler_color_new">
				<return-type type="PopplerColor*"/>
			</constructor>
			<field name="red" type="guint16"/>
			<field name="green" type="guint16"/>
			<field name="blue" type="guint16"/>
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
			<field name="image_id" type="gint"/>
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
		<boxed name="PopplerLayersIter" type-name="PopplerLayersIter" get-type="poppler_layers_iter_get_type">
			<method name="copy" symbol="poppler_layers_iter_copy">
				<return-type type="PopplerLayersIter*"/>
				<parameters>
					<parameter name="iter" type="PopplerLayersIter*"/>
				</parameters>
			</method>
			<method name="free" symbol="poppler_layers_iter_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="iter" type="PopplerLayersIter*"/>
				</parameters>
			</method>
			<method name="get_child" symbol="poppler_layers_iter_get_child">
				<return-type type="PopplerLayersIter*"/>
				<parameters>
					<parameter name="parent" type="PopplerLayersIter*"/>
				</parameters>
			</method>
			<method name="get_layer" symbol="poppler_layers_iter_get_layer">
				<return-type type="PopplerLayer*"/>
				<parameters>
					<parameter name="iter" type="PopplerLayersIter*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="poppler_layers_iter_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="iter" type="PopplerLayersIter*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="poppler_layers_iter_new">
				<return-type type="PopplerLayersIter*"/>
				<parameters>
					<parameter name="document" type="PopplerDocument*"/>
				</parameters>
			</constructor>
			<method name="next" symbol="poppler_layers_iter_next">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="iter" type="PopplerLayersIter*"/>
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
		<enum name="PopplerActionType" type-name="PopplerActionType" get-type="poppler_action_type_get_type">
			<member name="POPPLER_ACTION_UNKNOWN" value="0"/>
			<member name="POPPLER_ACTION_NONE" value="1"/>
			<member name="POPPLER_ACTION_GOTO_DEST" value="2"/>
			<member name="POPPLER_ACTION_GOTO_REMOTE" value="3"/>
			<member name="POPPLER_ACTION_LAUNCH" value="4"/>
			<member name="POPPLER_ACTION_URI" value="5"/>
			<member name="POPPLER_ACTION_NAMED" value="6"/>
			<member name="POPPLER_ACTION_MOVIE" value="7"/>
		</enum>
		<enum name="PopplerAnnotExternalDataType" type-name="PopplerAnnotExternalDataType" get-type="poppler_annot_external_data_type_get_type">
			<member name="POPPLER_ANNOT_EXTERNAL_DATA_MARKUP_3D" value="0"/>
			<member name="POPPLER_ANNOT_EXTERNAL_DATA_MARKUP_UNKNOWN" value="1"/>
		</enum>
		<enum name="PopplerAnnotFreeTextQuadding" type-name="PopplerAnnotFreeTextQuadding" get-type="poppler_annot_free_text_quadding_get_type">
			<member name="POPPLER_ANNOT_FREE_TEXT_QUADDING_LEFT_JUSTIFIED" value="0"/>
			<member name="POPPLER_ANNOT_FREE_TEXT_QUADDING_CENTERED" value="1"/>
			<member name="POPPLER_ANNOT_FREE_TEXT_QUADDING_RIGHT_JUSTIFIED" value="2"/>
		</enum>
		<enum name="PopplerAnnotMarkupReplyType" type-name="PopplerAnnotMarkupReplyType" get-type="poppler_annot_markup_reply_type_get_type">
			<member name="POPPLER_ANNOT_MARKUP_REPLY_TYPE_R" value="0"/>
			<member name="POPPLER_ANNOT_MARKUP_REPLY_TYPE_GROUP" value="1"/>
		</enum>
		<enum name="PopplerAnnotTextState" type-name="PopplerAnnotTextState" get-type="poppler_annot_text_state_get_type">
			<member name="POPPLER_ANNOT_TEXT_STATE_MARKED" value="0"/>
			<member name="POPPLER_ANNOT_TEXT_STATE_UNMARKED" value="1"/>
			<member name="POPPLER_ANNOT_TEXT_STATE_ACCEPTED" value="2"/>
			<member name="POPPLER_ANNOT_TEXT_STATE_REJECTED" value="3"/>
			<member name="POPPLER_ANNOT_TEXT_STATE_CANCELLED" value="4"/>
			<member name="POPPLER_ANNOT_TEXT_STATE_COMPLETED" value="5"/>
			<member name="POPPLER_ANNOT_TEXT_STATE_NONE" value="6"/>
			<member name="POPPLER_ANNOT_TEXT_STATE_UNKNOWN" value="7"/>
		</enum>
		<enum name="PopplerAnnotType" type-name="PopplerAnnotType" get-type="poppler_annot_type_get_type">
			<member name="POPPLER_ANNOT_UNKNOWN" value="0"/>
			<member name="POPPLER_ANNOT_TEXT" value="1"/>
			<member name="POPPLER_ANNOT_LINK" value="2"/>
			<member name="POPPLER_ANNOT_FREE_TEXT" value="3"/>
			<member name="POPPLER_ANNOT_LINE" value="4"/>
			<member name="POPPLER_ANNOT_SQUARE" value="5"/>
			<member name="POPPLER_ANNOT_CIRCLE" value="6"/>
			<member name="POPPLER_ANNOT_POLYGON" value="7"/>
			<member name="POPPLER_ANNOT_POLY_LINE" value="8"/>
			<member name="POPPLER_ANNOT_HIGHLIGHT" value="9"/>
			<member name="POPPLER_ANNOT_UNDERLINE" value="10"/>
			<member name="POPPLER_ANNOT_SQUIGGLY" value="11"/>
			<member name="POPPLER_ANNOT_STRIKE_OUT" value="12"/>
			<member name="POPPLER_ANNOT_STAMP" value="13"/>
			<member name="POPPLER_ANNOT_CARET" value="14"/>
			<member name="POPPLER_ANNOT_INK" value="15"/>
			<member name="POPPLER_ANNOT_POPUP" value="16"/>
			<member name="POPPLER_ANNOT_FILE_ATTACHMENT" value="17"/>
			<member name="POPPLER_ANNOT_SOUND" value="18"/>
			<member name="POPPLER_ANNOT_MOVIE" value="19"/>
			<member name="POPPLER_ANNOT_WIDGET" value="20"/>
			<member name="POPPLER_ANNOT_SCREEN" value="21"/>
			<member name="POPPLER_ANNOT_PRINTER_MARK" value="22"/>
			<member name="POPPLER_ANNOT_TRAP_NET" value="23"/>
			<member name="POPPLER_ANNOT_WATERMARK" value="24"/>
			<member name="POPPLER_ANNOT_3D" value="25"/>
		</enum>
		<enum name="PopplerBackend" type-name="PopplerBackend" get-type="poppler_backend_get_type">
			<member name="POPPLER_BACKEND_UNKNOWN" value="0"/>
			<member name="POPPLER_BACKEND_SPLASH" value="1"/>
			<member name="POPPLER_BACKEND_CAIRO" value="2"/>
		</enum>
		<enum name="PopplerDestType" type-name="PopplerDestType" get-type="poppler_dest_type_get_type">
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
		<enum name="PopplerError" type-name="PopplerError" get-type="poppler_error_get_type">
			<member name="POPPLER_ERROR_INVALID" value="0"/>
			<member name="POPPLER_ERROR_ENCRYPTED" value="1"/>
			<member name="POPPLER_ERROR_OPEN_FILE" value="2"/>
			<member name="POPPLER_ERROR_BAD_CATALOG" value="3"/>
			<member name="POPPLER_ERROR_DAMAGED" value="4"/>
		</enum>
		<enum name="PopplerFontType" type-name="PopplerFontType" get-type="poppler_font_type_get_type">
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
		<enum name="PopplerFormButtonType" type-name="PopplerFormButtonType" get-type="poppler_form_button_type_get_type">
			<member name="POPPLER_FORM_BUTTON_PUSH" value="0"/>
			<member name="POPPLER_FORM_BUTTON_CHECK" value="1"/>
			<member name="POPPLER_FORM_BUTTON_RADIO" value="2"/>
		</enum>
		<enum name="PopplerFormChoiceType" type-name="PopplerFormChoiceType" get-type="poppler_form_choice_type_get_type">
			<member name="POPPLER_FORM_CHOICE_COMBO" value="0"/>
			<member name="POPPLER_FORM_CHOICE_LIST" value="1"/>
		</enum>
		<enum name="PopplerFormFieldType" type-name="PopplerFormFieldType" get-type="poppler_form_field_type_get_type">
			<member name="POPPLER_FORM_FIELD_UNKNOWN" value="0"/>
			<member name="POPPLER_FORM_FIELD_BUTTON" value="1"/>
			<member name="POPPLER_FORM_FIELD_TEXT" value="2"/>
			<member name="POPPLER_FORM_FIELD_CHOICE" value="3"/>
			<member name="POPPLER_FORM_FIELD_SIGNATURE" value="4"/>
		</enum>
		<enum name="PopplerFormTextType" type-name="PopplerFormTextType" get-type="poppler_form_text_type_get_type">
			<member name="POPPLER_FORM_TEXT_NORMAL" value="0"/>
			<member name="POPPLER_FORM_TEXT_MULTILINE" value="1"/>
			<member name="POPPLER_FORM_TEXT_FILE_SELECT" value="2"/>
		</enum>
		<enum name="PopplerOrientation" type-name="PopplerOrientation" get-type="poppler_orientation_get_type">
			<member name="POPPLER_ORIENTATION_PORTRAIT" value="0"/>
			<member name="POPPLER_ORIENTATION_LANDSCAPE" value="1"/>
			<member name="POPPLER_ORIENTATION_UPSIDEDOWN" value="2"/>
			<member name="POPPLER_ORIENTATION_SEASCAPE" value="3"/>
		</enum>
		<enum name="PopplerPageLayout" type-name="PopplerPageLayout" get-type="poppler_page_layout_get_type">
			<member name="POPPLER_PAGE_LAYOUT_UNSET" value="0"/>
			<member name="POPPLER_PAGE_LAYOUT_SINGLE_PAGE" value="1"/>
			<member name="POPPLER_PAGE_LAYOUT_ONE_COLUMN" value="2"/>
			<member name="POPPLER_PAGE_LAYOUT_TWO_COLUMN_LEFT" value="3"/>
			<member name="POPPLER_PAGE_LAYOUT_TWO_COLUMN_RIGHT" value="4"/>
			<member name="POPPLER_PAGE_LAYOUT_TWO_PAGE_LEFT" value="5"/>
			<member name="POPPLER_PAGE_LAYOUT_TWO_PAGE_RIGHT" value="6"/>
		</enum>
		<enum name="PopplerPageMode" type-name="PopplerPageMode" get-type="poppler_page_mode_get_type">
			<member name="POPPLER_PAGE_MODE_UNSET" value="0"/>
			<member name="POPPLER_PAGE_MODE_NONE" value="1"/>
			<member name="POPPLER_PAGE_MODE_USE_OUTLINES" value="2"/>
			<member name="POPPLER_PAGE_MODE_USE_THUMBS" value="3"/>
			<member name="POPPLER_PAGE_MODE_FULL_SCREEN" value="4"/>
			<member name="POPPLER_PAGE_MODE_USE_OC" value="5"/>
			<member name="POPPLER_PAGE_MODE_USE_ATTACHMENTS" value="6"/>
		</enum>
		<enum name="PopplerPageTransitionAlignment" type-name="PopplerPageTransitionAlignment" get-type="poppler_page_transition_alignment_get_type">
			<member name="POPPLER_PAGE_TRANSITION_HORIZONTAL" value="0"/>
			<member name="POPPLER_PAGE_TRANSITION_VERTICAL" value="1"/>
		</enum>
		<enum name="PopplerPageTransitionDirection" type-name="PopplerPageTransitionDirection" get-type="poppler_page_transition_direction_get_type">
			<member name="POPPLER_PAGE_TRANSITION_INWARD" value="0"/>
			<member name="POPPLER_PAGE_TRANSITION_OUTWARD" value="1"/>
		</enum>
		<enum name="PopplerPageTransitionType" type-name="PopplerPageTransitionType" get-type="poppler_page_transition_type_get_type">
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
		<enum name="PopplerSelectionStyle" type-name="PopplerSelectionStyle" get-type="poppler_selection_style_get_type">
			<member name="POPPLER_SELECTION_GLYPH" value="0"/>
			<member name="POPPLER_SELECTION_WORD" value="1"/>
			<member name="POPPLER_SELECTION_LINE" value="2"/>
		</enum>
		<flags name="PopplerAnnotFlag" type-name="PopplerAnnotFlag" get-type="poppler_annot_flag_get_type">
			<member name="POPPLER_ANNOT_FLAG_UNKNOWN" value="0"/>
			<member name="POPPLER_ANNOT_FLAG_INVISIBLE" value="1"/>
			<member name="POPPLER_ANNOT_FLAG_HIDDEN" value="2"/>
			<member name="POPPLER_ANNOT_FLAG_PRINT" value="4"/>
			<member name="POPPLER_ANNOT_FLAG_NO_ZOOM" value="8"/>
			<member name="POPPLER_ANNOT_FLAG_NO_ROTATE" value="16"/>
			<member name="POPPLER_ANNOT_FLAG_NO_VIEW" value="32"/>
			<member name="POPPLER_ANNOT_FLAG_READ_ONLY" value="64"/>
			<member name="POPPLER_ANNOT_FLAG_LOCKED" value="128"/>
			<member name="POPPLER_ANNOT_FLAG_TOGGLE_NO_VIEW" value="256"/>
			<member name="POPPLER_ANNOT_FLAG_LOCKED_CONTENTS" value="512"/>
		</flags>
		<flags name="PopplerPermissions" type-name="PopplerPermissions" get-type="poppler_permissions_get_type">
			<member name="POPPLER_PERMISSIONS_OK_TO_PRINT" value="1"/>
			<member name="POPPLER_PERMISSIONS_OK_TO_MODIFY" value="2"/>
			<member name="POPPLER_PERMISSIONS_OK_TO_COPY" value="4"/>
			<member name="POPPLER_PERMISSIONS_OK_TO_ADD_NOTES" value="8"/>
			<member name="POPPLER_PERMISSIONS_OK_TO_FILL_FORM" value="16"/>
			<member name="POPPLER_PERMISSIONS_FULL" value="31"/>
		</flags>
		<flags name="PopplerViewerPreferences" type-name="PopplerViewerPreferences" get-type="poppler_viewer_preferences_get_type">
			<member name="POPPLER_VIEWER_PREFERENCES_UNSET" value="0"/>
			<member name="POPPLER_VIEWER_PREFERENCES_HIDE_TOOLBAR" value="1"/>
			<member name="POPPLER_VIEWER_PREFERENCES_HIDE_MENUBAR" value="2"/>
			<member name="POPPLER_VIEWER_PREFERENCES_HIDE_WINDOWUI" value="4"/>
			<member name="POPPLER_VIEWER_PREFERENCES_FIT_WINDOW" value="8"/>
			<member name="POPPLER_VIEWER_PREFERENCES_CENTER_WINDOW" value="16"/>
			<member name="POPPLER_VIEWER_PREFERENCES_DISPLAY_DOC_TITLE" value="32"/>
			<member name="POPPLER_VIEWER_PREFERENCES_DIRECTION_RTL" value="64"/>
		</flags>
		<object name="PopplerAnnot" parent="GObject" type-name="PopplerAnnot" get-type="poppler_annot_get_type">
			<method name="get_annot_type" symbol="poppler_annot_get_annot_type">
				<return-type type="PopplerAnnotType"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnot*"/>
				</parameters>
			</method>
			<method name="get_color" symbol="poppler_annot_get_color">
				<return-type type="PopplerColor*"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnot*"/>
				</parameters>
			</method>
			<method name="get_contents" symbol="poppler_annot_get_contents">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnot*"/>
				</parameters>
			</method>
			<method name="get_flags" symbol="poppler_annot_get_flags">
				<return-type type="PopplerAnnotFlag"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnot*"/>
				</parameters>
			</method>
			<method name="get_modified" symbol="poppler_annot_get_modified">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnot*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="poppler_annot_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnot*"/>
				</parameters>
			</method>
			<method name="set_contents" symbol="poppler_annot_set_contents">
				<return-type type="void"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnot*"/>
					<parameter name="contents" type="gchar*"/>
				</parameters>
			</method>
		</object>
		<object name="PopplerAnnotFreeText" parent="PopplerAnnotMarkup" type-name="PopplerAnnotFreeText" get-type="poppler_annot_free_text_get_type">
			<method name="get_callout_line" symbol="poppler_annot_free_text_get_callout_line">
				<return-type type="PopplerAnnotCalloutLine*"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotFreeText*"/>
				</parameters>
			</method>
			<method name="get_quadding" symbol="poppler_annot_free_text_get_quadding">
				<return-type type="PopplerAnnotFreeTextQuadding"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotFreeText*"/>
				</parameters>
			</method>
		</object>
		<object name="PopplerAnnotMarkup" parent="PopplerAnnot" type-name="PopplerAnnotMarkup" get-type="poppler_annot_markup_get_type">
			<method name="get_date" symbol="poppler_annot_markup_get_date">
				<return-type type="GDate*"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotMarkup*"/>
				</parameters>
			</method>
			<method name="get_external_data" symbol="poppler_annot_markup_get_external_data">
				<return-type type="PopplerAnnotExternalDataType"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotMarkup*"/>
				</parameters>
			</method>
			<method name="get_label" symbol="poppler_annot_markup_get_label">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotMarkup*"/>
				</parameters>
			</method>
			<method name="get_opacity" symbol="poppler_annot_markup_get_opacity">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotMarkup*"/>
				</parameters>
			</method>
			<method name="get_popup_is_open" symbol="poppler_annot_markup_get_popup_is_open">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotMarkup*"/>
				</parameters>
			</method>
			<method name="get_popup_rectangle" symbol="poppler_annot_markup_get_popup_rectangle">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotMarkup*"/>
					<parameter name="poppler_rect" type="PopplerRectangle*"/>
				</parameters>
			</method>
			<method name="get_reply_to" symbol="poppler_annot_markup_get_reply_to">
				<return-type type="PopplerAnnotMarkupReplyType"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotMarkup*"/>
				</parameters>
			</method>
			<method name="get_subject" symbol="poppler_annot_markup_get_subject">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotMarkup*"/>
				</parameters>
			</method>
			<method name="has_popup" symbol="poppler_annot_markup_has_popup">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotMarkup*"/>
				</parameters>
			</method>
		</object>
		<object name="PopplerAnnotText" parent="PopplerAnnotMarkup" type-name="PopplerAnnotText" get-type="poppler_annot_text_get_type">
			<method name="get_icon" symbol="poppler_annot_text_get_icon">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotText*"/>
				</parameters>
			</method>
			<method name="get_is_open" symbol="poppler_annot_text_get_is_open">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotText*"/>
				</parameters>
			</method>
			<method name="get_state" symbol="poppler_annot_text_get_state">
				<return-type type="PopplerAnnotTextState"/>
				<parameters>
					<parameter name="poppler_annot" type="PopplerAnnotText*"/>
				</parameters>
			</method>
		</object>
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
			<method name="save_a_copy" symbol="poppler_document_save_a_copy">
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
			<property name="format-major" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="format-minor" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
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
		<object name="PopplerLayer" parent="GObject" type-name="PopplerLayer" get-type="poppler_layer_get_type">
			<method name="get_radio_button_group_id" symbol="poppler_layer_get_radio_button_group_id">
				<return-type type="gint"/>
				<parameters>
					<parameter name="layer" type="PopplerLayer*"/>
				</parameters>
			</method>
			<method name="get_title" symbol="poppler_layer_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="layer" type="PopplerLayer*"/>
				</parameters>
			</method>
			<method name="hide" symbol="poppler_layer_hide">
				<return-type type="void"/>
				<parameters>
					<parameter name="layer" type="PopplerLayer*"/>
				</parameters>
			</method>
			<method name="is_parent" symbol="poppler_layer_is_parent">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layer" type="PopplerLayer*"/>
				</parameters>
			</method>
			<method name="is_visible" symbol="poppler_layer_is_visible">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="layer" type="PopplerLayer*"/>
				</parameters>
			</method>
			<method name="show" symbol="poppler_layer_show">
				<return-type type="void"/>
				<parameters>
					<parameter name="layer" type="PopplerLayer*"/>
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
			<method name="free_annot_mapping" symbol="poppler_page_free_annot_mapping">
				<return-type type="void"/>
				<parameters>
					<parameter name="list" type="GList*"/>
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
			<method name="get_annot_mapping" symbol="poppler_page_get_annot_mapping">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
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
			<method name="get_image" symbol="poppler_page_get_image">
				<return-type type="cairo_surface_t*"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
					<parameter name="image_id" type="gint"/>
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
				<return-type type="GList*"/>
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
				<return-type type="cairo_surface_t*"/>
				<parameters>
					<parameter name="page" type="PopplerPage*"/>
				</parameters>
			</method>
			<method name="get_thumbnail_pixbuf" symbol="poppler_page_get_thumbnail_pixbuf">
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
			<method name="render_for_printing" symbol="poppler_page_render_for_printing">
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
					<parameter name="glyph_color" type="PopplerColor*"/>
					<parameter name="background_color" type="PopplerColor*"/>
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
			<method name="render_to_pixbuf_for_printing" symbol="poppler_page_render_to_pixbuf_for_printing">
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
			<method name="selection_region_free" symbol="poppler_page_selection_region_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="region" type="GList*"/>
				</parameters>
			</method>
			<property name="label" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
		</object>
		<constant name="POPPLER_HAS_CAIRO" type="int" value="1"/>
		<constant name="POPPLER_MAJOR_VERSION" type="int" value="0"/>
		<constant name="POPPLER_MICRO_VERSION" type="int" value="4"/>
		<constant name="POPPLER_MINOR_VERSION" type="int" value="12"/>
		<constant name="POPPLER_WITH_GDK" type="int" value="1"/>
	</namespace>
</api>
