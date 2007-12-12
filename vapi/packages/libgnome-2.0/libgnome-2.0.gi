<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gnome">
		<function name="bonobo_module_info_get" symbol="gnome_bonobo_module_info_get">
			<return-type type="GnomeModuleInfo*"/>
		</function>
		<function name="clearenv" symbol="gnome_clearenv">
			<return-type type="void"/>
		</function>
		<function name="execute_async" symbol="gnome_execute_async">
			<return-type type="int"/>
			<parameters>
				<parameter name="dir" type="char*"/>
				<parameter name="argc" type="int"/>
				<parameter name="argv" type="char*[]"/>
			</parameters>
		</function>
		<function name="execute_async_fds" symbol="gnome_execute_async_fds">
			<return-type type="int"/>
			<parameters>
				<parameter name="dir" type="char*"/>
				<parameter name="argc" type="int"/>
				<parameter name="argv" type="char*[]"/>
				<parameter name="close_fds" type="gboolean"/>
			</parameters>
		</function>
		<function name="execute_async_with_env" symbol="gnome_execute_async_with_env">
			<return-type type="int"/>
			<parameters>
				<parameter name="dir" type="char*"/>
				<parameter name="argc" type="int"/>
				<parameter name="argv" type="char*[]"/>
				<parameter name="envc" type="int"/>
				<parameter name="envv" type="char*[]"/>
			</parameters>
		</function>
		<function name="execute_async_with_env_fds" symbol="gnome_execute_async_with_env_fds">
			<return-type type="int"/>
			<parameters>
				<parameter name="dir" type="char*"/>
				<parameter name="argc" type="int"/>
				<parameter name="argv" type="char*[]"/>
				<parameter name="envc" type="int"/>
				<parameter name="envv" type="char*[]"/>
				<parameter name="close_fds" type="gboolean"/>
			</parameters>
		</function>
		<function name="execute_shell" symbol="gnome_execute_shell">
			<return-type type="int"/>
			<parameters>
				<parameter name="dir" type="char*"/>
				<parameter name="commandline" type="char*"/>
			</parameters>
		</function>
		<function name="execute_shell_fds" symbol="gnome_execute_shell_fds">
			<return-type type="int"/>
			<parameters>
				<parameter name="dir" type="char*"/>
				<parameter name="commandline" type="char*"/>
				<parameter name="close_fds" type="gboolean"/>
			</parameters>
		</function>
		<function name="execute_terminal_shell" symbol="gnome_execute_terminal_shell">
			<return-type type="int"/>
			<parameters>
				<parameter name="dir" type="char*"/>
				<parameter name="commandline" type="char*"/>
			</parameters>
		</function>
		<function name="execute_terminal_shell_fds" symbol="gnome_execute_terminal_shell_fds">
			<return-type type="int"/>
			<parameters>
				<parameter name="dir" type="char*"/>
				<parameter name="commandline" type="char*"/>
				<parameter name="close_fds" type="gboolean"/>
			</parameters>
		</function>
		<function name="g_extension_pointer" symbol="g_extension_pointer">
			<return-type type="char*"/>
			<parameters>
				<parameter name="path" type="char*"/>
			</parameters>
		</function>
		<function name="gconf_get_app_settings_relative" symbol="gnome_gconf_get_app_settings_relative">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="program" type="GnomeProgram*"/>
				<parameter name="subkey" type="gchar*"/>
			</parameters>
		</function>
		<function name="gconf_get_gnome_libs_settings_relative" symbol="gnome_gconf_get_gnome_libs_settings_relative">
			<return-type type="gchar*"/>
			<parameters>
				<parameter name="subkey" type="gchar*"/>
			</parameters>
		</function>
		<function name="help_display" symbol="gnome_help_display">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="file_name" type="char*"/>
				<parameter name="link_id" type="char*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="help_display_desktop" symbol="gnome_help_display_desktop">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="program" type="GnomeProgram*"/>
				<parameter name="doc_id" type="char*"/>
				<parameter name="file_name" type="char*"/>
				<parameter name="link_id" type="char*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="help_display_desktop_with_env" symbol="gnome_help_display_desktop_with_env">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="program" type="GnomeProgram*"/>
				<parameter name="doc_id" type="char*"/>
				<parameter name="file_name" type="char*"/>
				<parameter name="link_id" type="char*"/>
				<parameter name="envp" type="char**"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="help_display_uri" symbol="gnome_help_display_uri">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="help_uri" type="char*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="help_display_uri_with_env" symbol="gnome_help_display_uri_with_env">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="help_uri" type="char*"/>
				<parameter name="envp" type="char**"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="help_display_with_doc_id" symbol="gnome_help_display_with_doc_id">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="program" type="GnomeProgram*"/>
				<parameter name="doc_id" type="char*"/>
				<parameter name="file_name" type="char*"/>
				<parameter name="link_id" type="char*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="help_display_with_doc_id_and_env" symbol="gnome_help_display_with_doc_id_and_env">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="program" type="GnomeProgram*"/>
				<parameter name="doc_id" type="char*"/>
				<parameter name="file_name" type="char*"/>
				<parameter name="link_id" type="char*"/>
				<parameter name="envp" type="char**"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="help_error_quark" symbol="gnome_help_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="libgnome_module_info_get" symbol="libgnome_module_info_get">
			<return-type type="GnomeModuleInfo*"/>
		</function>
		<function name="prepend_terminal_to_vector" symbol="gnome_prepend_terminal_to_vector">
			<return-type type="void"/>
			<parameters>
				<parameter name="argc" type="int*"/>
				<parameter name="argv" type="char***"/>
			</parameters>
		</function>
		<function name="setenv" symbol="gnome_setenv">
			<return-type type="int"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="value" type="char*"/>
				<parameter name="overwrite" type="gboolean"/>
			</parameters>
		</function>
		<function name="sound_connection_get" symbol="gnome_sound_connection_get">
			<return-type type="int"/>
		</function>
		<function name="sound_init" symbol="gnome_sound_init">
			<return-type type="void"/>
			<parameters>
				<parameter name="hostname" type="char*"/>
			</parameters>
		</function>
		<function name="sound_play" symbol="gnome_sound_play">
			<return-type type="void"/>
			<parameters>
				<parameter name="filename" type="char*"/>
			</parameters>
		</function>
		<function name="sound_sample_load" symbol="gnome_sound_sample_load">
			<return-type type="int"/>
			<parameters>
				<parameter name="sample_name" type="char*"/>
				<parameter name="filename" type="char*"/>
			</parameters>
		</function>
		<function name="sound_shutdown" symbol="gnome_sound_shutdown">
			<return-type type="void"/>
		</function>
		<function name="triggers_add_trigger" symbol="gnome_triggers_add_trigger">
			<return-type type="void"/>
			<parameters>
				<parameter name="nt" type="GnomeTrigger*"/>
			</parameters>
		</function>
		<function name="triggers_do" symbol="gnome_triggers_do">
			<return-type type="void"/>
			<parameters>
				<parameter name="msg" type="char*"/>
				<parameter name="level" type="char*"/>
			</parameters>
		</function>
		<function name="triggers_vadd_trigger" symbol="gnome_triggers_vadd_trigger">
			<return-type type="void"/>
			<parameters>
				<parameter name="nt" type="GnomeTrigger*"/>
				<parameter name="supinfo" type="char*[]"/>
			</parameters>
		</function>
		<function name="triggers_vdo" symbol="gnome_triggers_vdo">
			<return-type type="void"/>
			<parameters>
				<parameter name="msg" type="char*"/>
				<parameter name="level" type="char*"/>
				<parameter name="supinfo" type="char*[]"/>
			</parameters>
		</function>
		<function name="unsetenv" symbol="gnome_unsetenv">
			<return-type type="void"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="url_error_quark" symbol="gnome_url_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="url_show" symbol="gnome_url_show">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="url" type="char*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="url_show_with_env" symbol="gnome_url_show_with_env">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="url" type="char*"/>
				<parameter name="envp" type="char**"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="user_accels_dir_get" symbol="gnome_user_accels_dir_get">
			<return-type type="char*"/>
		</function>
		<function name="user_dir_get" symbol="gnome_user_dir_get">
			<return-type type="char*"/>
		</function>
		<function name="user_private_dir_get" symbol="gnome_user_private_dir_get">
			<return-type type="char*"/>
		</function>
		<function name="util_user_shell" symbol="gnome_util_user_shell">
			<return-type type="char*"/>
		</function>
		<callback name="GnomeModuleClassInitHook">
			<return-type type="void"/>
			<parameters>
				<parameter name="klass" type="GnomeProgramClass*"/>
				<parameter name="mod_info" type="GnomeModuleInfo*"/>
			</parameters>
		</callback>
		<callback name="GnomeModuleGetGOptionGroupFunc">
			<return-type type="GOptionGroup*"/>
		</callback>
		<callback name="GnomeModuleHook">
			<return-type type="void"/>
			<parameters>
				<parameter name="program" type="GnomeProgram*"/>
				<parameter name="mod_info" type="GnomeModuleInfo*"/>
			</parameters>
		</callback>
		<callback name="GnomeModuleInitHook">
			<return-type type="void"/>
			<parameters>
				<parameter name="mod_info" type="GnomeModuleInfo*"/>
			</parameters>
		</callback>
		<callback name="GnomeTriggerActionFunction">
			<return-type type="void"/>
			<parameters>
				<parameter name="msg" type="char*"/>
				<parameter name="level" type="char*"/>
				<parameter name="supinfo" type="char*[]"/>
			</parameters>
		</callback>
		<struct name="GnomeModuleRequirement">
			<field name="required_version" type="char*"/>
			<field name="module_info" type="GnomeModuleInfo*"/>
		</struct>
		<struct name="GnomeTrigger">
			<field name="type" type="GnomeTriggerType"/>
			<field name="u" type="gpointer"/>
			<field name="level" type="gchar*"/>
		</struct>
		<boxed name="GnomeModuleInfo" type-name="GnomeModuleInfo" get-type="gnome_module_info_get_type">
			<field name="name" type="char*"/>
			<field name="version" type="char*"/>
			<field name="description" type="char*"/>
			<field name="requirements" type="GnomeModuleRequirement*"/>
			<field name="instance_init" type="GnomeModuleHook"/>
			<field name="pre_args_parse" type="GnomeModuleHook"/>
			<field name="post_args_parse" type="GnomeModuleHook"/>
			<field name="_options" type="void*"/>
			<field name="init_pass" type="GnomeModuleInitHook"/>
			<field name="class_init" type="GnomeModuleClassInitHook"/>
			<field name="opt_prefix" type="char*"/>
			<field name="get_goption_group_func" type="GnomeModuleGetGOptionGroupFunc"/>
		</boxed>
		<enum name="GnomeFileDomain">
			<member name="GNOME_FILE_DOMAIN_UNKNOWN" value="0"/>
			<member name="GNOME_FILE_DOMAIN_LIBDIR" value="1"/>
			<member name="GNOME_FILE_DOMAIN_DATADIR" value="2"/>
			<member name="GNOME_FILE_DOMAIN_SOUND" value="3"/>
			<member name="GNOME_FILE_DOMAIN_PIXMAP" value="4"/>
			<member name="GNOME_FILE_DOMAIN_CONFIG" value="5"/>
			<member name="GNOME_FILE_DOMAIN_HELP" value="6"/>
			<member name="GNOME_FILE_DOMAIN_APP_LIBDIR" value="7"/>
			<member name="GNOME_FILE_DOMAIN_APP_DATADIR" value="8"/>
			<member name="GNOME_FILE_DOMAIN_APP_SOUND" value="9"/>
			<member name="GNOME_FILE_DOMAIN_APP_PIXMAP" value="10"/>
			<member name="GNOME_FILE_DOMAIN_APP_CONFIG" value="11"/>
			<member name="GNOME_FILE_DOMAIN_APP_HELP" value="12"/>
		</enum>
		<enum name="GnomeHelpError">
			<member name="GNOME_HELP_ERROR_INTERNAL" value="0"/>
			<member name="GNOME_HELP_ERROR_NOT_FOUND" value="1"/>
		</enum>
		<enum name="GnomeTriggerType">
			<member name="GTRIG_NONE" value="0"/>
			<member name="GTRIG_FUNCTION" value="1"/>
			<member name="GTRIG_COMMAND" value="2"/>
			<member name="GTRIG_MEDIAPLAY" value="3"/>
		</enum>
		<enum name="GnomeURLError">
			<member name="GNOME_URL_ERROR_PARSE" value="0"/>
			<member name="GNOME_URL_ERROR_LAUNCH" value="1"/>
			<member name="GNOME_URL_ERROR_URL" value="2"/>
			<member name="GNOME_URL_ERROR_NO_DEFAULT" value="3"/>
			<member name="GNOME_URL_ERROR_NOT_SUPPORTED" value="4"/>
			<member name="GNOME_URL_ERROR_VFS" value="5"/>
			<member name="GNOME_URL_ERROR_CANCELLED" value="6"/>
		</enum>
		<object name="GnomeProgram" parent="GObject" type-name="GnomeProgram" get-type="gnome_program_get_type">
			<method name="get" symbol="gnome_program_get">
				<return-type type="GnomeProgram*"/>
			</method>
			<method name="get_app_id" symbol="gnome_program_get_app_id">
				<return-type type="char*"/>
				<parameters>
					<parameter name="program" type="GnomeProgram*"/>
				</parameters>
			</method>
			<method name="get_app_version" symbol="gnome_program_get_app_version">
				<return-type type="char*"/>
				<parameters>
					<parameter name="program" type="GnomeProgram*"/>
				</parameters>
			</method>
			<method name="get_human_readable_name" symbol="gnome_program_get_human_readable_name">
				<return-type type="char*"/>
				<parameters>
					<parameter name="program" type="GnomeProgram*"/>
				</parameters>
			</method>
			<method name="init" symbol="gnome_program_init">
				<return-type type="GnomeProgram*"/>
				<parameters>
					<parameter name="app_id" type="char*"/>
					<parameter name="app_version" type="char*"/>
					<parameter name="module_info" type="GnomeModuleInfo*"/>
					<parameter name="argc" type="int"/>
					<parameter name="argv" type="char**"/>
					<parameter name="first_property_name" type="char*"/>
				</parameters>
			</method>
			<method name="init_paramv" symbol="gnome_program_init_paramv">
				<return-type type="GnomeProgram*"/>
				<parameters>
					<parameter name="type" type="GType"/>
					<parameter name="app_id" type="char*"/>
					<parameter name="app_version" type="char*"/>
					<parameter name="module_info" type="GnomeModuleInfo*"/>
					<parameter name="argc" type="int"/>
					<parameter name="argv" type="char**"/>
					<parameter name="nparams" type="guint"/>
					<parameter name="params" type="GParameter*"/>
				</parameters>
			</method>
			<method name="initv" symbol="gnome_program_initv">
				<return-type type="GnomeProgram*"/>
				<parameters>
					<parameter name="type" type="GType"/>
					<parameter name="app_id" type="char*"/>
					<parameter name="app_version" type="char*"/>
					<parameter name="module_info" type="GnomeModuleInfo*"/>
					<parameter name="argc" type="int"/>
					<parameter name="argv" type="char**"/>
					<parameter name="first_property_name" type="char*"/>
					<parameter name="args" type="va_list"/>
				</parameters>
			</method>
			<method name="install_property" symbol="gnome_program_install_property">
				<return-type type="guint"/>
				<parameters>
					<parameter name="pclass" type="GnomeProgramClass*"/>
					<parameter name="get_fn" type="GObjectGetPropertyFunc"/>
					<parameter name="set_fn" type="GObjectSetPropertyFunc"/>
					<parameter name="pspec" type="GParamSpec*"/>
				</parameters>
			</method>
			<method name="locate_file" symbol="gnome_program_locate_file">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="program" type="GnomeProgram*"/>
					<parameter name="domain" type="GnomeFileDomain"/>
					<parameter name="file_name" type="gchar*"/>
					<parameter name="only_if_exists" type="gboolean"/>
					<parameter name="ret_locations" type="GSList**"/>
				</parameters>
			</method>
			<method name="module_load" symbol="gnome_program_module_load">
				<return-type type="GnomeModuleInfo*"/>
				<parameters>
					<parameter name="mod_name" type="char*"/>
				</parameters>
			</method>
			<method name="module_register" symbol="gnome_program_module_register">
				<return-type type="void"/>
				<parameters>
					<parameter name="module_info" type="GnomeModuleInfo*"/>
				</parameters>
			</method>
			<method name="module_registered" symbol="gnome_program_module_registered">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="module_info" type="GnomeModuleInfo*"/>
				</parameters>
			</method>
			<property name="app-datadir" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="app-id" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="app-libdir" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="app-prefix" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="app-sysconfdir" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="app-version" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="create-directories" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="enable-sound" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="espeaker" type="char*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="gnome-datadir" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="gnome-libdir" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="gnome-path" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="gnome-prefix" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="gnome-sysconfdir" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="goption-context" type="gpointer" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="human-readable-name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="popt-context" type="gpointer" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="popt-flags" type="gint" readable="0" writable="1" construct="0" construct-only="1"/>
			<property name="popt-table" type="gpointer" readable="0" writable="1" construct="0" construct-only="1"/>
		</object>
		<constant name="GNOME_DOT_GNOME" type="char*" value=".gnome2/"/>
		<constant name="GNOME_DOT_GNOME_PRIVATE" type="char*" value=".gnome2_private/"/>
		<constant name="GNOME_PARAM_APP_DATADIR" type="char*" value="app-datadir"/>
		<constant name="GNOME_PARAM_APP_ID" type="char*" value="app-id"/>
		<constant name="GNOME_PARAM_APP_LIBDIR" type="char*" value="app-libdir"/>
		<constant name="GNOME_PARAM_APP_PREFIX" type="char*" value="app-prefix"/>
		<constant name="GNOME_PARAM_APP_SYSCONFDIR" type="char*" value="app-sysconfdir"/>
		<constant name="GNOME_PARAM_APP_VERSION" type="char*" value="app-version"/>
		<constant name="GNOME_PARAM_CREATE_DIRECTORIES" type="char*" value="create-directories"/>
		<constant name="GNOME_PARAM_ENABLE_SOUND" type="char*" value="enable-sound"/>
		<constant name="GNOME_PARAM_ESPEAKER" type="char*" value="espeaker"/>
		<constant name="GNOME_PARAM_GNOME_DATADIR" type="char*" value="gnome-datadir"/>
		<constant name="GNOME_PARAM_GNOME_LIBDIR" type="char*" value="gnome-libdir"/>
		<constant name="GNOME_PARAM_GNOME_PATH" type="char*" value="gnome-path"/>
		<constant name="GNOME_PARAM_GNOME_PREFIX" type="char*" value="gnome-prefix"/>
		<constant name="GNOME_PARAM_GNOME_SYSCONFDIR" type="char*" value="gnome-sysconfdir"/>
		<constant name="GNOME_PARAM_GOPTION_CONTEXT" type="char*" value="goption-context"/>
		<constant name="GNOME_PARAM_HUMAN_READABLE_NAME" type="char*" value="human-readable-name"/>
		<constant name="GNOME_PARAM_POPT_CONTEXT" type="char*" value="popt-context"/>
		<constant name="GNOME_PARAM_POPT_FLAGS" type="char*" value="popt-flags"/>
		<constant name="GNOME_PARAM_POPT_TABLE" type="char*" value="popt-table"/>
	</namespace>
</api>
