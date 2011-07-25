<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gst">
		<enum name="GstColorBalanceType" type-name="GstColorBalanceType" get-type="gst_color_balance_type_get_type">
			<member name="GST_COLOR_BALANCE_HARDWARE" value="0"/>
			<member name="GST_COLOR_BALANCE_SOFTWARE" value="1"/>
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
		<enum name="GstStreamVolumeFormat" type-name="GstStreamVolumeFormat" get-type="gst_stream_volume_format_get_type">
			<member name="GST_STREAM_VOLUME_FORMAT_LINEAR" value="0"/>
			<member name="GST_STREAM_VOLUME_FORMAT_CUBIC" value="1"/>
			<member name="GST_STREAM_VOLUME_FORMAT_DB" value="2"/>
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
			<member name="GST_MIXER_TRACK_READONLY" value="512"/>
			<member name="GST_MIXER_TRACK_WRITEONLY" value="1024"/>
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
			<vfunc name="mute_toggled">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="channel" type="GstMixerTrack*"/>
					<parameter name="mute" type="gboolean"/>
				</parameters>
			</vfunc>
			<vfunc name="option_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="opts" type="GstMixerOptions*"/>
					<parameter name="option" type="gchar*"/>
				</parameters>
			</vfunc>
			<vfunc name="record_toggled">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="channel" type="GstMixerTrack*"/>
					<parameter name="record" type="gboolean"/>
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
			<vfunc name="volume_changed">
				<return-type type="void"/>
				<parameters>
					<parameter name="mixer" type="GstMixer*"/>
					<parameter name="channel" type="GstMixerTrack*"/>
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
		<interface name="GstStreamVolume" type-name="GstStreamVolume" get-type="gst_stream_volume_get_type">
			<requires>
				<interface name="GObject"/>
			</requires>
			<method name="convert_volume" symbol="gst_stream_volume_convert_volume">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="from" type="GstStreamVolumeFormat"/>
					<parameter name="to" type="GstStreamVolumeFormat"/>
					<parameter name="val" type="gdouble"/>
				</parameters>
			</method>
			<method name="get_mute" symbol="gst_stream_volume_get_mute">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="volume" type="GstStreamVolume*"/>
				</parameters>
			</method>
			<method name="get_volume" symbol="gst_stream_volume_get_volume">
				<return-type type="gdouble"/>
				<parameters>
					<parameter name="volume" type="GstStreamVolume*"/>
					<parameter name="format" type="GstStreamVolumeFormat"/>
				</parameters>
			</method>
			<method name="set_mute" symbol="gst_stream_volume_set_mute">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GstStreamVolume*"/>
					<parameter name="mute" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_volume" symbol="gst_stream_volume_set_volume">
				<return-type type="void"/>
				<parameters>
					<parameter name="volume" type="GstStreamVolume*"/>
					<parameter name="format" type="GstStreamVolumeFormat"/>
					<parameter name="val" type="gdouble"/>
				</parameters>
			</method>
			<property name="mute" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="volume" type="gdouble" readable="1" writable="1" construct="0" construct-only="0"/>
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
			<method name="got_window_handle" symbol="gst_x_overlay_got_window_handle">
				<return-type type="void"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
					<parameter name="handle" type="guintptr"/>
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
			<method name="set_render_rectangle" symbol="gst_x_overlay_set_render_rectangle">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</method>
			<method name="set_window_handle" symbol="gst_x_overlay_set_window_handle">
				<return-type type="void"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
					<parameter name="handle" type="guintptr"/>
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
			<vfunc name="set_render_rectangle">
				<return-type type="void"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
					<parameter name="x" type="gint"/>
					<parameter name="y" type="gint"/>
					<parameter name="width" type="gint"/>
					<parameter name="height" type="gint"/>
				</parameters>
			</vfunc>
			<vfunc name="set_window_handle">
				<return-type type="void"/>
				<parameters>
					<parameter name="overlay" type="GstXOverlay*"/>
					<parameter name="handle" type="guintptr"/>
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
	</namespace>
</api>
