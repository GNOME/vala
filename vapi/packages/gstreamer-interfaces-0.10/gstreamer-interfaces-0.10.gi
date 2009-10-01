<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<function name="colour_tone_mode_get_type" symbol="gst_colour_tone_mode_get_type">
			<return-type type="GType"/>
		</function>
		<function name="flash_mode_get_type" symbol="gst_flash_mode_get_type">
			<return-type type="GType"/>
		</function>
		<function name="focus_status_get_type" symbol="gst_focus_status_get_type">
			<return-type type="GType"/>
		</function>
		<function name="photo_caps_get_type" symbol="gst_photo_caps_get_type">
			<return-type type="GType"/>
		</function>
		<function name="photo_shake_risk_get_type" symbol="gst_photo_shake_risk_get_type">
			<return-type type="GType"/>
		</function>
		<function name="scene_mode_get_type" symbol="gst_scene_mode_get_type">
			<return-type type="GType"/>
		</function>
		<function name="white_balance_mode_get_type" symbol="gst_white_balance_mode_get_type">
			<return-type type="GType"/>
		</function>
		<callback name="GstPhotoCapturePrepared">
			<return-type type="void"/>
			<parameters>
				<parameter name="data" type="gpointer"/>
				<parameter name="configured_caps" type="GstCaps*"/>
			</parameters>
		</callback>
		<struct name="GstPhotoSettings">
			<field name="wb_mode" type="GstWhiteBalanceMode"/>
			<field name="tone_mode" type="GstColourToneMode"/>
			<field name="scene_mode" type="GstSceneMode"/>
			<field name="flash_mode" type="GstFlashMode"/>
			<field name="exposure" type="guint32"/>
			<field name="aperture" type="guint"/>
			<field name="ev_compensation" type="gfloat"/>
			<field name="iso_speed" type="guint"/>
			<field name="zoom" type="gfloat"/>
		</struct>
		<struct name="GstPhotography">
			<method name="get_aperture" symbol="gst_photography_get_aperture">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="aperture" type="guint*"/>
				</parameters>
			</method>
			<method name="get_capabilities" symbol="gst_photography_get_capabilities">
				<return-type type="GstPhotoCaps"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
				</parameters>
			</method>
			<method name="get_colour_tone_mode" symbol="gst_photography_get_colour_tone_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="tone_mode" type="GstColourToneMode*"/>
				</parameters>
			</method>
			<method name="get_config" symbol="gst_photography_get_config">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="config" type="GstPhotoSettings*"/>
				</parameters>
			</method>
			<method name="get_ev_compensation" symbol="gst_photography_get_ev_compensation">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="ev_comp" type="gfloat*"/>
				</parameters>
			</method>
			<method name="get_exposure" symbol="gst_photography_get_exposure">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="exposure" type="guint32*"/>
				</parameters>
			</method>
			<method name="get_flash_mode" symbol="gst_photography_get_flash_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="flash_mode" type="GstFlashMode*"/>
				</parameters>
			</method>
			<method name="get_iso_speed" symbol="gst_photography_get_iso_speed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="iso_speed" type="guint*"/>
				</parameters>
			</method>
			<method name="get_scene_mode" symbol="gst_photography_get_scene_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="scene_mode" type="GstSceneMode*"/>
				</parameters>
			</method>
			<method name="get_white_balance_mode" symbol="gst_photography_get_white_balance_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="wb_mode" type="GstWhiteBalanceMode*"/>
				</parameters>
			</method>
			<method name="get_zoom" symbol="gst_photography_get_zoom">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="zoom" type="gfloat*"/>
				</parameters>
			</method>
			<method name="prepare_for_capture" symbol="gst_photography_prepare_for_capture">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="func" type="GstPhotoCapturePrepared"/>
					<parameter name="capture_caps" type="GstCaps*"/>
					<parameter name="user_data" type="gpointer"/>
				</parameters>
			</method>
			<method name="set_aperture" symbol="gst_photography_set_aperture">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="aperture" type="guint"/>
				</parameters>
			</method>
			<method name="set_autofocus" symbol="gst_photography_set_autofocus">
				<return-type type="void"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="on" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_colour_tone_mode" symbol="gst_photography_set_colour_tone_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="tone_mode" type="GstColourToneMode"/>
				</parameters>
			</method>
			<method name="set_config" symbol="gst_photography_set_config">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="config" type="GstPhotoSettings*"/>
				</parameters>
			</method>
			<method name="set_ev_compensation" symbol="gst_photography_set_ev_compensation">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="ev_comp" type="gfloat"/>
				</parameters>
			</method>
			<method name="set_exposure" symbol="gst_photography_set_exposure">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="exposure" type="guint"/>
				</parameters>
			</method>
			<method name="set_flash_mode" symbol="gst_photography_set_flash_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="flash_mode" type="GstFlashMode"/>
				</parameters>
			</method>
			<method name="set_iso_speed" symbol="gst_photography_set_iso_speed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="iso_speed" type="guint"/>
				</parameters>
			</method>
			<method name="set_scene_mode" symbol="gst_photography_set_scene_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="scene_mode" type="GstSceneMode"/>
				</parameters>
			</method>
			<method name="set_white_balance_mode" symbol="gst_photography_set_white_balance_mode">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="wb_mode" type="GstWhiteBalanceMode"/>
				</parameters>
			</method>
			<method name="set_zoom" symbol="gst_photography_set_zoom">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="photo" type="GstPhotography*"/>
					<parameter name="zoom" type="gfloat"/>
				</parameters>
			</method>
		</struct>
		<struct name="GstPhotographyInterface">
			<field name="parent" type="GTypeInterface"/>
			<field name="get_ev_compensation" type="GCallback"/>
			<field name="get_iso_speed" type="GCallback"/>
			<field name="get_aperture" type="GCallback"/>
			<field name="get_exposure" type="GCallback"/>
			<field name="get_white_balance_mode" type="GCallback"/>
			<field name="get_colour_tone_mode" type="GCallback"/>
			<field name="get_scene_mode" type="GCallback"/>
			<field name="get_flash_mode" type="GCallback"/>
			<field name="get_zoom" type="GCallback"/>
			<field name="set_ev_compensation" type="GCallback"/>
			<field name="set_iso_speed" type="GCallback"/>
			<field name="set_aperture" type="GCallback"/>
			<field name="set_exposure" type="GCallback"/>
			<field name="set_white_balance_mode" type="GCallback"/>
			<field name="set_colour_tone_mode" type="GCallback"/>
			<field name="set_scene_mode" type="GCallback"/>
			<field name="set_flash_mode" type="GCallback"/>
			<field name="set_zoom" type="GCallback"/>
			<field name="get_capabilities" type="GCallback"/>
			<field name="prepare_for_capture" type="GCallback"/>
			<field name="set_autofocus" type="GCallback"/>
			<field name="set_config" type="GCallback"/>
			<field name="get_config" type="GCallback"/>
			<field name="_gst_reserved" type="gpointer[]"/>
		</struct>
		<enum name="GstColorBalanceType" type-name="GstColorBalanceType" get-type="gst_color_balance_type_get_type">
			<member name="GST_COLOR_BALANCE_HARDWARE" value="0"/>
			<member name="GST_COLOR_BALANCE_SOFTWARE" value="1"/>
		</enum>
		<enum name="GstColourToneMode">
			<member name="GST_PHOTOGRAPHY_COLOUR_TONE_MODE_NORMAL" value="0"/>
			<member name="GST_PHOTOGRAPHY_COLOUR_TONE_MODE_SEPIA" value="1"/>
			<member name="GST_PHOTOGRAPHY_COLOUR_TONE_MODE_NEGATIVE" value="2"/>
			<member name="GST_PHOTOGRAPHY_COLOUR_TONE_MODE_GRAYSCALE" value="3"/>
			<member name="GST_PHOTOGRAPHY_COLOUR_TONE_MODE_NATURAL" value="4"/>
			<member name="GST_PHOTOGRAPHY_COLOUR_TONE_MODE_VIVID" value="5"/>
			<member name="GST_PHOTOGRAPHY_COLOUR_TONE_MODE_COLORSWAP" value="6"/>
			<member name="GST_PHOTOGRAPHY_COLOUR_TONE_MODE_SOLARIZE" value="7"/>
			<member name="GST_PHOTOGRAPHY_COLOUR_TONE_MODE_OUT_OF_FOCUS" value="8"/>
		</enum>
		<enum name="GstFlashMode">
			<member name="GST_PHOTOGRAPHY_FLASH_MODE_AUTO" value="0"/>
			<member name="GST_PHOTOGRAPHY_FLASH_MODE_OFF" value="1"/>
			<member name="GST_PHOTOGRAPHY_FLASH_MODE_ON" value="2"/>
			<member name="GST_PHOTOGRAPHY_FLASH_MODE_FILL_IN" value="3"/>
			<member name="GST_PHOTOGRAPHY_FLASH_MODE_RED_EYE" value="4"/>
		</enum>
		<enum name="GstFocusStatus">
			<member name="GST_PHOTOGRAPHY_FOCUS_STATUS_NONE" value="0"/>
			<member name="GST_PHOTOGRAPHY_FOCUS_STATUS_RUNNING" value="1"/>
			<member name="GST_PHOTOGRAPHY_FOCUS_STATUS_FAIL" value="2"/>
			<member name="GST_PHOTOGRAPHY_FOCUS_STATUS_SUCCESS" value="3"/>
		</enum>
		<enum name="GstMixerMessageType" type-name="GstMixerMessageType" get-type="gst_mixer_message_type_get_type">
			<member name="GST_MIXER_MESSAGE_INVALID" value="0"/>
			<member name="GST_MIXER_MESSAGE_MUTE_TOGGLED" value="1"/>
			<member name="GST_MIXER_MESSAGE_RECORD_TOGGLED" value="2"/>
			<member name="GST_MIXER_MESSAGE_VOLUME_CHANGED" value="3"/>
			<member name="GST_MIXER_MESSAGE_OPTION_CHANGED" value="4"/>
			<member name="GST_MIXER_MESSAGE_OPTIONS_LIST_CHANGED" value="5"/>
			<member name="GST_MIXER_MESSAGE_MIXER_CHANGED" value="6"/>
		</enum>
		<enum name="GstMixerType" type-name="GstMixerType" get-type="gst_mixer_type_get_type">
			<member name="GST_MIXER_HARDWARE" value="0"/>
			<member name="GST_MIXER_SOFTWARE" value="1"/>
		</enum>
		<enum name="GstNavigationCommand" type-name="GstNavigationCommand" get-type="gst_navigation_command_get_type">
			<member name="GST_NAVIGATION_COMMAND_INVALID" value="0"/>
			<member name="GST_NAVIGATION_COMMAND_MENU1" value="1"/>
			<member name="GST_NAVIGATION_COMMAND_MENU2" value="2"/>
			<member name="GST_NAVIGATION_COMMAND_MENU3" value="3"/>
			<member name="GST_NAVIGATION_COMMAND_MENU4" value="4"/>
			<member name="GST_NAVIGATION_COMMAND_MENU5" value="5"/>
			<member name="GST_NAVIGATION_COMMAND_MENU6" value="6"/>
			<member name="GST_NAVIGATION_COMMAND_MENU7" value="7"/>
			<member name="GST_NAVIGATION_COMMAND_LEFT" value="20"/>
			<member name="GST_NAVIGATION_COMMAND_RIGHT" value="21"/>
			<member name="GST_NAVIGATION_COMMAND_UP" value="22"/>
			<member name="GST_NAVIGATION_COMMAND_DOWN" value="23"/>
			<member name="GST_NAVIGATION_COMMAND_ACTIVATE" value="24"/>
			<member name="GST_NAVIGATION_COMMAND_PREV_ANGLE" value="30"/>
			<member name="GST_NAVIGATION_COMMAND_NEXT_ANGLE" value="31"/>
		</enum>
		<enum name="GstNavigationEventType" type-name="GstNavigationEventType" get-type="gst_navigation_event_type_get_type">
			<member name="GST_NAVIGATION_EVENT_INVALID" value="0"/>
			<member name="GST_NAVIGATION_EVENT_KEY_PRESS" value="1"/>
			<member name="GST_NAVIGATION_EVENT_KEY_RELEASE" value="2"/>
			<member name="GST_NAVIGATION_EVENT_MOUSE_BUTTON_PRESS" value="3"/>
			<member name="GST_NAVIGATION_EVENT_MOUSE_BUTTON_RELEASE" value="4"/>
			<member name="GST_NAVIGATION_EVENT_MOUSE_MOVE" value="5"/>
			<member name="GST_NAVIGATION_EVENT_COMMAND" value="6"/>
		</enum>
		<enum name="GstNavigationMessageType" type-name="GstNavigationMessageType" get-type="gst_navigation_message_type_get_type">
			<member name="GST_NAVIGATION_MESSAGE_INVALID" value="0"/>
			<member name="GST_NAVIGATION_MESSAGE_MOUSE_OVER" value="1"/>
			<member name="GST_NAVIGATION_MESSAGE_COMMANDS_CHANGED" value="2"/>
			<member name="GST_NAVIGATION_MESSAGE_ANGLES_CHANGED" value="3"/>
		</enum>
		<enum name="GstNavigationQueryType" type-name="GstNavigationQueryType" get-type="gst_navigation_query_type_get_type">
			<member name="GST_NAVIGATION_QUERY_INVALID" value="0"/>
			<member name="GST_NAVIGATION_QUERY_COMMANDS" value="1"/>
			<member name="GST_NAVIGATION_QUERY_ANGLES" value="2"/>
		</enum>
		<enum name="GstPhotoCaps">
			<member name="GST_PHOTOGRAPHY_CAPS_NONE" value="0"/>
			<member name="GST_PHOTOGRAPHY_CAPS_EV_COMP" value="1"/>
			<member name="GST_PHOTOGRAPHY_CAPS_ISO_SPEED" value="2"/>
			<member name="GST_PHOTOGRAPHY_CAPS_WB_MODE" value="4"/>
			<member name="GST_PHOTOGRAPHY_CAPS_TONE" value="8"/>
			<member name="GST_PHOTOGRAPHY_CAPS_SCENE" value="16"/>
			<member name="GST_PHOTOGRAPHY_CAPS_FLASH" value="32"/>
			<member name="GST_PHOTOGRAPHY_CAPS_ZOOM" value="64"/>
			<member name="GST_PHOTOGRAPHY_CAPS_FOCUS" value="128"/>
			<member name="GST_PHOTOGRAPHY_CAPS_APERTURE" value="256"/>
			<member name="GST_PHOTOGRAPHY_CAPS_EXPOSURE" value="512"/>
			<member name="GST_PHOTOGRAPHY_CAPS_SHAKE" value="1024"/>
		</enum>
		<enum name="GstPhotoShakeRisk">
			<member name="GST_PHOTOGRAPHY_SHAKE_RISK_LOW" value="0"/>
			<member name="GST_PHOTOGRAPHY_SHAKE_RISK_MEDIUM" value="1"/>
			<member name="GST_PHOTOGRAPHY_SHAKE_RISK_HIGH" value="2"/>
		</enum>
		<enum name="GstSceneMode">
			<member name="GST_PHOTOGRAPHY_SCENE_MODE_MANUAL" value="0"/>
			<member name="GST_PHOTOGRAPHY_SCENE_MODE_CLOSEUP" value="1"/>
			<member name="GST_PHOTOGRAPHY_SCENE_MODE_PORTRAIT" value="2"/>
			<member name="GST_PHOTOGRAPHY_SCENE_MODE_LANDSCAPE" value="3"/>
			<member name="GST_PHOTOGRAPHY_SCENE_MODE_SPORT" value="4"/>
			<member name="GST_PHOTOGRAPHY_SCENE_MODE_NIGHT" value="5"/>
			<member name="GST_PHOTOGRAPHY_SCENE_MODE_AUTO" value="6"/>
		</enum>
		<enum name="GstWhiteBalanceMode">
			<member name="GST_PHOTOGRAPHY_WB_MODE_AUTO" value="0"/>
			<member name="GST_PHOTOGRAPHY_WB_MODE_DAYLIGHT" value="1"/>
			<member name="GST_PHOTOGRAPHY_WB_MODE_CLOUDY" value="2"/>
			<member name="GST_PHOTOGRAPHY_WB_MODE_SUNSET" value="3"/>
			<member name="GST_PHOTOGRAPHY_WB_MODE_TUNGSTEN" value="4"/>
			<member name="GST_PHOTOGRAPHY_WB_MODE_FLUORESCENT" value="5"/>
		</enum>
		<flags name="GstMixerFlags" type-name="GstMixerFlags" get-type="gst_mixer_flags_get_type">
			<member name="GST_MIXER_FLAG_NONE" value="0"/>
			<member name="GST_MIXER_FLAG_AUTO_NOTIFICATIONS" value="1"/>
			<member name="GST_MIXER_FLAG_HAS_WHITELIST" value="2"/>
			<member name="GST_MIXER_FLAG_GROUPING" value="4"/>
		</flags>
		<flags name="GstMixerTrackFlags" type-name="GstMixerTrackFlags" get-type="gst_mixer_track_flags_get_type">
			<member name="GST_MIXER_TRACK_INPUT" value="1"/>
			<member name="GST_MIXER_TRACK_OUTPUT" value="2"/>
			<member name="GST_MIXER_TRACK_MUTE" value="4"/>
			<member name="GST_MIXER_TRACK_RECORD" value="8"/>
			<member name="GST_MIXER_TRACK_MASTER" value="16"/>
			<member name="GST_MIXER_TRACK_SOFTWARE" value="32"/>
			<member name="GST_MIXER_TRACK_NO_RECORD" value="64"/>
			<member name="GST_MIXER_TRACK_NO_MUTE" value="128"/>
			<member name="GST_MIXER_TRACK_WHITELIST" value="256"/>
		</flags>
		<flags name="GstTunerChannelFlags" type-name="GstTunerChannelFlags" get-type="gst_tuner_channel_flags_get_type">
			<member name="GST_TUNER_CHANNEL_INPUT" value="1"/>
			<member name="GST_TUNER_CHANNEL_OUTPUT" value="2"/>
			<member name="GST_TUNER_CHANNEL_FREQUENCY" value="4"/>
			<member name="GST_TUNER_CHANNEL_AUDIO" value="8"/>
		</flags>
		<object name="GstColorBalanceChannel" parent="GObject" type-name="GstColorBalanceChannel" get-type="gst_color_balance_channel_get_type">
			<signal name="value-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="channel" type="GstColorBalanceChannel*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</signal>
			<field name="label" type="gchar*"/>
			<field name="min_value" type="gint"/>
			<field name="max_value" type="gint"/>
		</object>
		<object name="GstMixerOptions" parent="GstMixerTrack" type-name="GstMixerOptions" get-type="gst_mixer_options_get_type">
			<method name="get_values" symbol="gst_mixer_options_get_values">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="mixer_options" type="GstMixerOptions*"/>
				</parameters>
			</method>
			<method name="list_changed" symbol="gst_mixer_options_list_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="opts" type="GstMixerOptions*"/>
				</parameters>
			</method>
			<vfunc name="get_values">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="opts" type="GstMixerOptions*"/>
				</parameters>
			</vfunc>
			<field name="values" type="GList*"/>
		</object>
		<object name="GstMixerTrack" parent="GObject" type-name="GstMixerTrack" get-type="gst_mixer_track_get_type">
			<property name="flags" type="guint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="index" type="guint" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="label" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="max-volume" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="min-volume" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="num-channels" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="untranslated-label" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<field name="label" type="gchar*"/>
			<field name="flags" type="GstMixerTrackFlags"/>
			<field name="num_channels" type="gint"/>
			<field name="min_volume" type="gint"/>
			<field name="max_volume" type="gint"/>
		</object>
		<object name="GstTunerChannel" parent="GObject" type-name="GstTunerChannel" get-type="gst_tuner_channel_get_type">
			<method name="changed" symbol="gst_tuner_channel_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
				</parameters>
			</method>
			<signal name="frequency-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="channel" type="GstTunerChannel*"/>
					<parameter name="frequency" type="gulong"/>
				</parameters>
			</signal>
			<signal name="signal-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="channel" type="GstTunerChannel*"/>
					<parameter name="signal" type="gint"/>
				</parameters>
			</signal>
			<field name="label" type="gchar*"/>
			<field name="flags" type="GstTunerChannelFlags"/>
			<field name="freq_multiplicator" type="gfloat"/>
			<field name="min_frequency" type="gulong"/>
			<field name="max_frequency" type="gulong"/>
			<field name="min_signal" type="gint"/>
			<field name="max_signal" type="gint"/>
		</object>
		<object name="GstTunerNorm" parent="GObject" type-name="GstTunerNorm" get-type="gst_tuner_norm_get_type">
			<method name="changed" symbol="gst_tuner_norm_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="norm" type="GstTunerNorm*"/>
				</parameters>
			</method>
			<field name="label" type="gchar*"/>
			<field name="framerate" type="GValue"/>
		</object>
		<interface name="GstColorBalance" type-name="GstColorBalance" get-type="gst_color_balance_get_type">
			<requires>
				<interface name="GstImplementsInterface"/>
				<interface name="GstElement"/>
			</requires>
			<method name="get_balance_type" symbol="gst_color_balance_get_balance_type">
				<return-type type="GstColorBalanceType"/>
				<parameters>
					<parameter name="balance" type="GstColorBalance*"/>
				</parameters>
			</method>
			<method name="get_value" symbol="gst_color_balance_get_value">
				<return-type type="gint"/>
				<parameters>
					<parameter name="balance" type="GstColorBalance*"/>
					<parameter name="channel" type="GstColorBalanceChannel*"/>
				</parameters>
			</method>
			<method name="list_channels" symbol="gst_color_balance_list_channels">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="balance" type="GstColorBalance*"/>
				</parameters>
			</method>
			<method name="set_value" symbol="gst_color_balance_set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="balance" type="GstColorBalance*"/>
					<parameter name="channel" type="GstColorBalanceChannel*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<method name="value_changed" symbol="gst_color_balance_value_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="balance" type="GstColorBalance*"/>
					<parameter name="channel" type="GstColorBalanceChannel*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</method>
			<signal name="value-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="balance" type="GstColorBalance*"/>
					<parameter name="channel" type="GstColorBalanceChannel*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</signal>
			<vfunc name="get_value">
				<return-type type="gint"/>
				<parameters>
					<parameter name="balance" type="GstColorBalance*"/>
					<parameter name="channel" type="GstColorBalanceChannel*"/>
				</parameters>
			</vfunc>
			<vfunc name="list_channels">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="balance" type="GstColorBalance*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_value">
				<return-type type="void"/>
				<parameters>
					<parameter name="balance" type="GstColorBalance*"/>
					<parameter name="channel" type="GstColorBalanceChannel*"/>
					<parameter name="value" type="gint"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GstMixer" type-name="GstMixer" get-type="gst_mixer_get_type">
			<requires>
				<interface name="GstImplementsInterface"/>
				<interface name="GstElement"/>
			</requires>
			<method name="get_mixer_flags" symbol="gst_mixer_get_mixer_flags">
				<return-type type="GstMixerFlags"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
				</parameters>
			</method>
			<method name="get_mixer_type" symbol="gst_mixer_get_mixer_type">
				<return-type type="GstMixerType"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
				</parameters>
			</method>
			<method name="get_option" symbol="gst_mixer_get_option">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="opts" type="GstMixerOptions*"/>
				</parameters>
			</method>
			<method name="get_volume" symbol="gst_mixer_get_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="track" type="GstMixerTrack*"/>
					<parameter name="volumes" type="gint*"/>
				</parameters>
			</method>
			<method name="list_tracks" symbol="gst_mixer_list_tracks">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
				</parameters>
			</method>
			<method name="message_get_type" symbol="gst_mixer_message_get_type">
				<return-type type="GstMixerMessageType"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
				</parameters>
			</method>
			<method name="message_parse_mute_toggled" symbol="gst_mixer_message_parse_mute_toggled">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="track" type="GstMixerTrack**"/>
					<parameter name="mute" type="gboolean*"/>
				</parameters>
			</method>
			<method name="message_parse_option_changed" symbol="gst_mixer_message_parse_option_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="options" type="GstMixerOptions**"/>
					<parameter name="value" type="gchar**"/>
				</parameters>
			</method>
			<method name="message_parse_options_list_changed" symbol="gst_mixer_message_parse_options_list_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="options" type="GstMixerOptions**"/>
				</parameters>
			</method>
			<method name="message_parse_record_toggled" symbol="gst_mixer_message_parse_record_toggled">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="track" type="GstMixerTrack**"/>
					<parameter name="record" type="gboolean*"/>
				</parameters>
			</method>
			<method name="message_parse_volume_changed" symbol="gst_mixer_message_parse_volume_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="track" type="GstMixerTrack**"/>
					<parameter name="volumes" type="gint**"/>
					<parameter name="num_channels" type="gint*"/>
				</parameters>
			</method>
			<method name="mixer_changed" symbol="gst_mixer_mixer_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
				</parameters>
			</method>
			<method name="mute_toggled" symbol="gst_mixer_mute_toggled">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="track" type="GstMixerTrack*"/>
					<parameter name="mute" type="gboolean"/>
				</parameters>
			</method>
			<method name="option_changed" symbol="gst_mixer_option_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="opts" type="GstMixerOptions*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="record_toggled" symbol="gst_mixer_record_toggled">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="track" type="GstMixerTrack*"/>
					<parameter name="record" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_mute" symbol="gst_mixer_set_mute">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="track" type="GstMixerTrack*"/>
					<parameter name="mute" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_option" symbol="gst_mixer_set_option">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="opts" type="GstMixerOptions*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</method>
			<method name="set_record" symbol="gst_mixer_set_record">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="track" type="GstMixerTrack*"/>
					<parameter name="record" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_volume" symbol="gst_mixer_set_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="track" type="GstMixerTrack*"/>
					<parameter name="volumes" type="gint*"/>
				</parameters>
			</method>
			<method name="volume_changed" symbol="gst_mixer_volume_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="track" type="GstMixerTrack*"/>
					<parameter name="volumes" type="gint*"/>
				</parameters>
			</method>
			<signal name="mute-toggled" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="channel" type="GstMixerTrack*"/>
					<parameter name="mute" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="option-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="opts" type="GstMixerOptions*"/>
					<parameter name="option" type="char*"/>
				</parameters>
			</signal>
			<signal name="record-toggled" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="channel" type="GstMixerTrack*"/>
					<parameter name="record" type="gboolean"/>
				</parameters>
			</signal>
			<signal name="volume-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="channel" type="GstMixerTrack*"/>
					<parameter name="volumes" type="gpointer"/>
				</parameters>
			</signal>
			<vfunc name="get_mixer_flags">
				<return-type type="GstMixerFlags"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_option">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="opts" type="GstMixerOptions*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="track" type="GstMixerTrack*"/>
					<parameter name="volumes" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="list_tracks">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_mute">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="track" type="GstMixerTrack*"/>
					<parameter name="mute" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="set_option">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="opts" type="GstMixerOptions*"/>
					<parameter name="value" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_record">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="track" type="GstMixerTrack*"/>
					<parameter name="record" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="set_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="track" type="GstMixerTrack*"/>
					<parameter name="volumes" type="gint*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GstNavigation" type-name="GstNavigation" get-type="gst_navigation_get_type">
			<method name="event_get_type" symbol="gst_navigation_event_get_type">
				<return-type type="GstNavigationEventType"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
				</parameters>
			</method>
			<method name="event_parse_command" symbol="gst_navigation_event_parse_command">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
					<parameter name="command" type="GstNavigationCommand*"/>
				</parameters>
			</method>
			<method name="event_parse_key_event" symbol="gst_navigation_event_parse_key_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
					<parameter name="key" type="gchar**"/>
				</parameters>
			</method>
			<method name="event_parse_mouse_button_event" symbol="gst_navigation_event_parse_mouse_button_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
					<parameter name="button" type="gint*"/>
					<parameter name="x" type="gdouble*"/>
					<parameter name="y" type="gdouble*"/>
				</parameters>
			</method>
			<method name="event_parse_mouse_move_event" symbol="gst_navigation_event_parse_mouse_move_event">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="event" type="GstEvent*"/>
					<parameter name="x" type="gdouble*"/>
					<parameter name="y" type="gdouble*"/>
				</parameters>
			</method>
			<method name="message_get_type" symbol="gst_navigation_message_get_type">
				<return-type type="GstNavigationMessageType"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
				</parameters>
			</method>
			<method name="message_new_angles_changed" symbol="gst_navigation_message_new_angles_changed">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="cur_angle" type="guint"/>
					<parameter name="n_angles" type="guint"/>
				</parameters>
			</method>
			<method name="message_new_commands_changed" symbol="gst_navigation_message_new_commands_changed">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
				</parameters>
			</method>
			<method name="message_new_mouse_over" symbol="gst_navigation_message_new_mouse_over">
				<return-type type="GstMessage*"/>
				<parameters>
					<parameter name="src" type="GstObject*"/>
					<parameter name="active" type="gboolean"/>
				</parameters>
			</method>
			<method name="message_parse_angles_changed" symbol="gst_navigation_message_parse_angles_changed">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="cur_angle" type="guint*"/>
					<parameter name="n_angles" type="guint*"/>
				</parameters>
			</method>
			<method name="message_parse_mouse_over" symbol="gst_navigation_message_parse_mouse_over">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="message" type="GstMessage*"/>
					<parameter name="active" type="gboolean*"/>
				</parameters>
			</method>
			<method name="query_get_type" symbol="gst_navigation_query_get_type">
				<return-type type="GstNavigationQueryType"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
				</parameters>
			</method>
			<method name="query_new_angles" symbol="gst_navigation_query_new_angles">
				<return-type type="GstQuery*"/>
			</method>
			<method name="query_new_commands" symbol="gst_navigation_query_new_commands">
				<return-type type="GstQuery*"/>
			</method>
			<method name="query_parse_angles" symbol="gst_navigation_query_parse_angles">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="cur_angle" type="guint*"/>
					<parameter name="n_angles" type="guint*"/>
				</parameters>
			</method>
			<method name="query_parse_commands_length" symbol="gst_navigation_query_parse_commands_length">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="n_cmds" type="guint*"/>
				</parameters>
			</method>
			<method name="query_parse_commands_nth" symbol="gst_navigation_query_parse_commands_nth">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="nth" type="guint"/>
					<parameter name="cmd" type="GstNavigationCommand*"/>
				</parameters>
			</method>
			<method name="query_set_angles" symbol="gst_navigation_query_set_angles">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="cur_angle" type="guint"/>
					<parameter name="n_angles" type="guint"/>
				</parameters>
			</method>
			<method name="query_set_commands" symbol="gst_navigation_query_set_commands">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="n_cmds" type="gint"/>
				</parameters>
			</method>
			<method name="query_set_commandsv" symbol="gst_navigation_query_set_commandsv">
				<return-type type="void"/>
				<parameters>
					<parameter name="query" type="GstQuery*"/>
					<parameter name="n_cmds" type="gint"/>
					<parameter name="cmds" type="GstNavigationCommand*"/>
				</parameters>
			</method>
			<method name="send_command" symbol="gst_navigation_send_command">
				<return-type type="void"/>
				<parameters>
					<parameter name="navigation" type="GstNavigation*"/>
					<parameter name="command" type="GstNavigationCommand"/>
				</parameters>
			</method>
			<method name="send_event" symbol="gst_navigation_send_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="navigation" type="GstNavigation*"/>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</method>
			<method name="send_key_event" symbol="gst_navigation_send_key_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="navigation" type="GstNavigation*"/>
					<parameter name="event" type="char*"/>
					<parameter name="key" type="char*"/>
				</parameters>
			</method>
			<method name="send_mouse_event" symbol="gst_navigation_send_mouse_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="navigation" type="GstNavigation*"/>
					<parameter name="event" type="char*"/>
					<parameter name="button" type="int"/>
					<parameter name="x" type="double"/>
					<parameter name="y" type="double"/>
				</parameters>
			</method>
			<vfunc name="send_event">
				<return-type type="void"/>
				<parameters>
					<parameter name="navigation" type="GstNavigation*"/>
					<parameter name="structure" type="GstStructure*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GstPropertyProbe" type-name="GstPropertyProbe" get-type="gst_property_probe_get_type">
			<method name="get_properties" symbol="gst_property_probe_get_properties">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
				</parameters>
			</method>
			<method name="get_property" symbol="gst_property_probe_get_property">
				<return-type type="GParamSpec*"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="get_values" symbol="gst_property_probe_get_values">
				<return-type type="GValueArray*"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</method>
			<method name="get_values_name" symbol="gst_property_probe_get_values_name">
				<return-type type="GValueArray*"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="needs_probe" symbol="gst_property_probe_needs_probe">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</method>
			<method name="needs_probe_name" symbol="gst_property_probe_needs_probe_name">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="probe_and_get_values" symbol="gst_property_probe_probe_and_get_values">
				<return-type type="GValueArray*"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</method>
			<method name="probe_and_get_values_name" symbol="gst_property_probe_probe_and_get_values_name">
				<return-type type="GValueArray*"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<method name="probe_property" symbol="gst_property_probe_probe_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</method>
			<method name="probe_property_name" symbol="gst_property_probe_probe_property_name">
				<return-type type="void"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="name" type="gchar*"/>
				</parameters>
			</method>
			<signal name="probe-needed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="pspec" type="gpointer"/>
				</parameters>
			</signal>
			<vfunc name="get_properties">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_values">
				<return-type type="GValueArray*"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="prop_id" type="guint"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</vfunc>
			<vfunc name="needs_probe">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="prop_id" type="guint"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</vfunc>
			<vfunc name="probe_property">
				<return-type type="void"/>
				<parameters>
					<parameter name="probe" type="GstPropertyProbe*"/>
					<parameter name="prop_id" type="guint"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GstTuner" type-name="GstTuner" get-type="gst_tuner_get_type">
			<requires>
				<interface name="GstImplementsInterface"/>
				<interface name="GstElement"/>
			</requires>
			<method name="find_channel_by_name" symbol="gst_tuner_find_channel_by_name">
				<return-type type="GstTunerChannel*"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="gchar*"/>
				</parameters>
			</method>
			<method name="find_norm_by_name" symbol="gst_tuner_find_norm_by_name">
				<return-type type="GstTunerNorm*"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="norm" type="gchar*"/>
				</parameters>
			</method>
			<method name="frequency_changed" symbol="gst_tuner_frequency_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
					<parameter name="frequency" type="gulong"/>
				</parameters>
			</method>
			<method name="get_channel" symbol="gst_tuner_get_channel">
				<return-type type="GstTunerChannel*"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
				</parameters>
			</method>
			<method name="get_frequency" symbol="gst_tuner_get_frequency">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
				</parameters>
			</method>
			<method name="get_norm" symbol="gst_tuner_get_norm">
				<return-type type="GstTunerNorm*"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
				</parameters>
			</method>
			<method name="list_channels" symbol="gst_tuner_list_channels">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
				</parameters>
			</method>
			<method name="list_norms" symbol="gst_tuner_list_norms">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
				</parameters>
			</method>
			<method name="set_channel" symbol="gst_tuner_set_channel">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
				</parameters>
			</method>
			<method name="set_frequency" symbol="gst_tuner_set_frequency">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
					<parameter name="frequency" type="gulong"/>
				</parameters>
			</method>
			<method name="set_norm" symbol="gst_tuner_set_norm">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="norm" type="GstTunerNorm*"/>
				</parameters>
			</method>
			<method name="signal_changed" symbol="gst_tuner_signal_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
					<parameter name="signal" type="gint"/>
				</parameters>
			</method>
			<method name="signal_strength" symbol="gst_tuner_signal_strength">
				<return-type type="gint"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
				</parameters>
			</method>
			<signal name="channel-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
				</parameters>
			</signal>
			<signal name="frequency-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
					<parameter name="frequency" type="gulong"/>
				</parameters>
			</signal>
			<signal name="norm-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="norm" type="GstTunerNorm*"/>
				</parameters>
			</signal>
			<signal name="signal-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
					<parameter name="signal" type="gint"/>
				</parameters>
			</signal>
			<vfunc name="get_channel">
				<return-type type="GstTunerChannel*"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_frequency">
				<return-type type="gulong"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_norm">
				<return-type type="GstTunerNorm*"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
				</parameters>
			</vfunc>
			<vfunc name="list_channels">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
				</parameters>
			</vfunc>
			<vfunc name="list_norms">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_channel">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_frequency">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
					<parameter name="frequency" type="gulong"/>
				</parameters>
			</vfunc>
			<vfunc name="set_norm">
				<return-type type="void"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="norm" type="GstTunerNorm*"/>
				</parameters>
			</vfunc>
			<vfunc name="signal_strength">
				<return-type type="gint"/>
				<parameters>
					<parameter name="tuner" type="GstTuner*"/>
					<parameter name="channel" type="GstTunerChannel*"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GstVideoOrientation" type-name="GstVideoOrientation" get-type="gst_video_orientation_get_type">
			<requires>
				<interface name="GstImplementsInterface"/>
				<interface name="GstElement"/>
			</requires>
			<method name="get_hcenter" symbol="gst_video_orientation_get_hcenter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="center" type="gint*"/>
				</parameters>
			</method>
			<method name="get_hflip" symbol="gst_video_orientation_get_hflip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="flip" type="gboolean*"/>
				</parameters>
			</method>
			<method name="get_vcenter" symbol="gst_video_orientation_get_vcenter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="center" type="gint*"/>
				</parameters>
			</method>
			<method name="get_vflip" symbol="gst_video_orientation_get_vflip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="flip" type="gboolean*"/>
				</parameters>
			</method>
			<method name="set_hcenter" symbol="gst_video_orientation_set_hcenter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="center" type="gint"/>
				</parameters>
			</method>
			<method name="set_hflip" symbol="gst_video_orientation_set_hflip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="flip" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_vcenter" symbol="gst_video_orientation_set_vcenter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="center" type="gint"/>
				</parameters>
			</method>
			<method name="set_vflip" symbol="gst_video_orientation_set_vflip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="flip" type="gboolean"/>
				</parameters>
			</method>
			<vfunc name="get_hcenter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="center" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_hflip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="flip" type="gboolean*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_vcenter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="center" type="gint*"/>
				</parameters>
			</vfunc>
			<vfunc name="get_vflip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="flip" type="gboolean*"/>
				</parameters>
			</vfunc>
			<vfunc name="set_hcenter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="center" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_hflip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="flip" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="set_vcenter">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="center" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_vflip">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="video_orientation" type="GstVideoOrientation*"/>
					<parameter name="flip" type="gboolean"/>
				</parameters>
			</vfunc>
		</interface>
		<interface name="GstXOverlay" type-name="GstXOverlay" get-type="gst_x_overlay_get_type">
			<requires>
				<interface name="GstImplementsInterface"/>
				<interface name="GstElement"/>
			</requires>
			<method name="expose" symbol="gst_x_overlay_expose">
				<return-type type="void"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
				</parameters>
			</method>
			<method name="got_xwindow_id" symbol="gst_x_overlay_got_xwindow_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
					<parameter name="xwindow_id" type="gulong"/>
				</parameters>
			</method>
			<method name="handle_events" symbol="gst_x_overlay_handle_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
					<parameter name="handle_events" type="gboolean"/>
				</parameters>
			</method>
			<method name="prepare_xwindow_id" symbol="gst_x_overlay_prepare_xwindow_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
				</parameters>
			</method>
			<method name="set_xwindow_id" symbol="gst_x_overlay_set_xwindow_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
					<parameter name="xwindow_id" type="gulong"/>
				</parameters>
			</method>
			<vfunc name="expose">
				<return-type type="void"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
				</parameters>
			</vfunc>
			<vfunc name="handle_events">
				<return-type type="void"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
					<parameter name="handle_events" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="set_xwindow_id">
				<return-type type="void"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
					<parameter name="xwindow_id" type="gulong"/>
				</parameters>
			</vfunc>
		</interface>
		<constant name="GST_PHOTOGRAPHY_AUTOFOCUS_DONE" type="char*" value="autofocus-done"/>
		<constant name="GST_PHOTOGRAPHY_SHAKE_RISK" type="char*" value="shake-risk"/>
	</namespace>
</api>
