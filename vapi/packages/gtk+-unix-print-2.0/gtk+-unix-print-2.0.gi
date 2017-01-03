<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Gtk">
		<function name="enumerate_printers" symbol="gtk_enumerate_printers">
			<return-type type="void"/>
			<parameters>
				<parameter name="func" type="GtkPrinterFunc"/>
				<parameter name="data" type="gpointer"/>
				<parameter name="destroy" type="GDestroyNotify"/>
				<parameter name="wait" type="gboolean"/>
			</parameters>
		</function>
		<callback name="GtkPrintJobCompleteFunc">
			<return-type type="void"/>
			<parameters>
				<parameter name="print_job" type="GtkPrintJob*"/>
				<parameter name="user_data" type="gpointer"/>
				<parameter name="error" type="GError*"/>
			</parameters>
		</callback>
		<callback name="GtkPrinterFunc">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="printer" type="GtkPrinter*"/>
				<parameter name="data" type="gpointer"/>
			</parameters>
		</callback>
		<struct name="GtkPrintBackend">
		</struct>
		<flags name="GtkPrintCapabilities" type-name="GtkPrintCapabilities" get-type="gtk_print_capabilities_get_type">
			<member name="GTK_PRINT_CAPABILITY_PAGE_SET" value="1"/>
			<member name="GTK_PRINT_CAPABILITY_COPIES" value="2"/>
			<member name="GTK_PRINT_CAPABILITY_COLLATE" value="4"/>
			<member name="GTK_PRINT_CAPABILITY_REVERSE" value="8"/>
			<member name="GTK_PRINT_CAPABILITY_SCALE" value="16"/>
			<member name="GTK_PRINT_CAPABILITY_GENERATE_PDF" value="32"/>
			<member name="GTK_PRINT_CAPABILITY_GENERATE_PS" value="64"/>
			<member name="GTK_PRINT_CAPABILITY_PREVIEW" value="128"/>
			<member name="GTK_PRINT_CAPABILITY_NUMBER_UP" value="256"/>
			<member name="GTK_PRINT_CAPABILITY_NUMBER_UP_LAYOUT" value="512"/>
		</flags>
		<object name="GtkPageSetupUnixDialog" parent="GtkDialog" type-name="GtkPageSetupUnixDialog" get-type="gtk_page_setup_unix_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="get_page_setup" symbol="gtk_page_setup_unix_dialog_get_page_setup">
				<return-type type="GtkPageSetup*"/>
				<parameters>
					<parameter name="dialog" type="GtkPageSetupUnixDialog*"/>
				</parameters>
			</method>
			<method name="get_print_settings" symbol="gtk_page_setup_unix_dialog_get_print_settings">
				<return-type type="GtkPrintSettings*"/>
				<parameters>
					<parameter name="dialog" type="GtkPageSetupUnixDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_page_setup_unix_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="title" type="gchar*"/>
					<parameter name="parent" type="GtkWindow*"/>
				</parameters>
			</constructor>
			<method name="set_page_setup" symbol="gtk_page_setup_unix_dialog_set_page_setup">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GtkPageSetupUnixDialog*"/>
					<parameter name="page_setup" type="GtkPageSetup*"/>
				</parameters>
			</method>
			<method name="set_print_settings" symbol="gtk_page_setup_unix_dialog_set_print_settings">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GtkPageSetupUnixDialog*"/>
					<parameter name="print_settings" type="GtkPrintSettings*"/>
				</parameters>
			</method>
		</object>
		<object name="GtkPrintJob" parent="GObject" type-name="GtkPrintJob" get-type="gtk_print_job_get_type">
			<method name="get_printer" symbol="gtk_print_job_get_printer">
				<return-type type="GtkPrinter*"/>
				<parameters>
					<parameter name="job" type="GtkPrintJob*"/>
				</parameters>
			</method>
			<method name="get_settings" symbol="gtk_print_job_get_settings">
				<return-type type="GtkPrintSettings*"/>
				<parameters>
					<parameter name="job" type="GtkPrintJob*"/>
				</parameters>
			</method>
			<method name="get_status" symbol="gtk_print_job_get_status">
				<return-type type="GtkPrintStatus"/>
				<parameters>
					<parameter name="job" type="GtkPrintJob*"/>
				</parameters>
			</method>
			<method name="get_surface" symbol="gtk_print_job_get_surface">
				<return-type type="cairo_surface_t*"/>
				<parameters>
					<parameter name="job" type="GtkPrintJob*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="get_title" symbol="gtk_print_job_get_title">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="job" type="GtkPrintJob*"/>
				</parameters>
			</method>
			<method name="get_track_print_status" symbol="gtk_print_job_get_track_print_status">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="job" type="GtkPrintJob*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_print_job_new">
				<return-type type="GtkPrintJob*"/>
				<parameters>
					<parameter name="title" type="gchar*"/>
					<parameter name="printer" type="GtkPrinter*"/>
					<parameter name="settings" type="GtkPrintSettings*"/>
					<parameter name="page_setup" type="GtkPageSetup*"/>
				</parameters>
			</constructor>
			<method name="send" symbol="gtk_print_job_send">
				<return-type type="void"/>
				<parameters>
					<parameter name="job" type="GtkPrintJob*"/>
					<parameter name="callback" type="GtkPrintJobCompleteFunc"/>
					<parameter name="user_data" type="gpointer"/>
					<parameter name="dnotify" type="GDestroyNotify"/>
				</parameters>
			</method>
			<method name="set_source_file" symbol="gtk_print_job_set_source_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="job" type="GtkPrintJob*"/>
					<parameter name="filename" type="gchar*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_track_print_status" symbol="gtk_print_job_set_track_print_status">
				<return-type type="void"/>
				<parameters>
					<parameter name="job" type="GtkPrintJob*"/>
					<parameter name="track_status" type="gboolean"/>
				</parameters>
			</method>
			<property name="page-setup" type="GtkPageSetup*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="printer" type="GtkPrinter*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="settings" type="GtkPrintSettings*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="title" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="track-print-status" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<signal name="status-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="job" type="GtkPrintJob*"/>
				</parameters>
			</signal>
		</object>
		<object name="GtkPrintUnixDialog" parent="GtkDialog" type-name="GtkPrintUnixDialog" get-type="gtk_print_unix_dialog_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="add_custom_tab" symbol="gtk_print_unix_dialog_add_custom_tab">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
					<parameter name="child" type="GtkWidget*"/>
					<parameter name="tab_label" type="GtkWidget*"/>
				</parameters>
			</method>
			<method name="get_current_page" symbol="gtk_print_unix_dialog_get_current_page">
				<return-type type="gint"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
				</parameters>
			</method>
			<method name="get_embed_page_setup" symbol="gtk_print_unix_dialog_get_embed_page_setup">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
				</parameters>
			</method>
			<method name="get_has_selection" symbol="gtk_print_unix_dialog_get_has_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
				</parameters>
			</method>
			<method name="get_manual_capabilities" symbol="gtk_print_unix_dialog_get_manual_capabilities">
				<return-type type="GtkPrintCapabilities"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
				</parameters>
			</method>
			<method name="get_page_setup" symbol="gtk_print_unix_dialog_get_page_setup">
				<return-type type="GtkPageSetup*"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
				</parameters>
			</method>
			<method name="get_page_setup_set" symbol="gtk_print_unix_dialog_get_page_setup_set">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
				</parameters>
			</method>
			<method name="get_selected_printer" symbol="gtk_print_unix_dialog_get_selected_printer">
				<return-type type="GtkPrinter*"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
				</parameters>
			</method>
			<method name="get_settings" symbol="gtk_print_unix_dialog_get_settings">
				<return-type type="GtkPrintSettings*"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
				</parameters>
			</method>
			<method name="get_support_selection" symbol="gtk_print_unix_dialog_get_support_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_print_unix_dialog_new">
				<return-type type="GtkWidget*"/>
				<parameters>
					<parameter name="title" type="gchar*"/>
					<parameter name="parent" type="GtkWindow*"/>
				</parameters>
			</constructor>
			<method name="set_current_page" symbol="gtk_print_unix_dialog_set_current_page">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
					<parameter name="current_page" type="gint"/>
				</parameters>
			</method>
			<method name="set_embed_page_setup" symbol="gtk_print_unix_dialog_set_embed_page_setup">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
					<parameter name="embed" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_has_selection" symbol="gtk_print_unix_dialog_set_has_selection">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
					<parameter name="has_selection" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_manual_capabilities" symbol="gtk_print_unix_dialog_set_manual_capabilities">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
					<parameter name="capabilities" type="GtkPrintCapabilities"/>
				</parameters>
			</method>
			<method name="set_page_setup" symbol="gtk_print_unix_dialog_set_page_setup">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
					<parameter name="page_setup" type="GtkPageSetup*"/>
				</parameters>
			</method>
			<method name="set_settings" symbol="gtk_print_unix_dialog_set_settings">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
					<parameter name="settings" type="GtkPrintSettings*"/>
				</parameters>
			</method>
			<method name="set_support_selection" symbol="gtk_print_unix_dialog_set_support_selection">
				<return-type type="void"/>
				<parameters>
					<parameter name="dialog" type="GtkPrintUnixDialog*"/>
					<parameter name="support_selection" type="gboolean"/>
				</parameters>
			</method>
			<property name="current-page" type="gint" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="embed-page-setup" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="has-selection" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="manual-capabilities" type="GtkPrintCapabilities" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="page-setup" type="GtkPageSetup*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="print-settings" type="GtkPrintSettings*" readable="1" writable="1" construct="0" construct-only="0"/>
			<property name="selected-printer" type="GtkPrinter*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="support-selection" type="gboolean" readable="1" writable="1" construct="0" construct-only="0"/>
		</object>
		<object name="GtkPrinter" parent="GObject" type-name="GtkPrinter" get-type="gtk_printer_get_type">
			<method name="accepts_pdf" symbol="gtk_printer_accepts_pdf">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="accepts_ps" symbol="gtk_printer_accepts_ps">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="compare" symbol="gtk_printer_compare">
				<return-type type="gint"/>
				<parameters>
					<parameter name="a" type="GtkPrinter*"/>
					<parameter name="b" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="get_backend" symbol="gtk_printer_get_backend">
				<return-type type="GtkPrintBackend*"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="get_capabilities" symbol="gtk_printer_get_capabilities">
				<return-type type="GtkPrintCapabilities"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="get_default_page_size" symbol="gtk_printer_get_default_page_size">
				<return-type type="GtkPageSetup*"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="get_description" symbol="gtk_printer_get_description">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="get_hard_margins" symbol="gtk_printer_get_hard_margins">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
					<parameter name="top" type="gdouble*"/>
					<parameter name="bottom" type="gdouble*"/>
					<parameter name="left" type="gdouble*"/>
					<parameter name="right" type="gdouble*"/>
				</parameters>
			</method>
			<method name="get_icon_name" symbol="gtk_printer_get_icon_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="get_job_count" symbol="gtk_printer_get_job_count">
				<return-type type="gint"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="get_location" symbol="gtk_printer_get_location">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="get_name" symbol="gtk_printer_get_name">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="get_state_message" symbol="gtk_printer_get_state_message">
				<return-type type="gchar*"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="has_details" symbol="gtk_printer_has_details">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="is_accepting_jobs" symbol="gtk_printer_is_accepting_jobs">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="is_active" symbol="gtk_printer_is_active">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="is_default" symbol="gtk_printer_is_default">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="is_paused" symbol="gtk_printer_is_paused">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="is_virtual" symbol="gtk_printer_is_virtual">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<method name="list_papers" symbol="gtk_printer_list_papers">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<constructor name="new" symbol="gtk_printer_new">
				<return-type type="GtkPrinter*"/>
				<parameters>
					<parameter name="name" type="gchar*"/>
					<parameter name="backend" type="GtkPrintBackend*"/>
					<parameter name="virtual_" type="gboolean"/>
				</parameters>
			</constructor>
			<method name="request_details" symbol="gtk_printer_request_details">
				<return-type type="void"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
				</parameters>
			</method>
			<property name="accepting-jobs" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="accepts-pdf" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="accepts-ps" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="backend" type="GtkPrintBackend*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="icon-name" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="is-virtual" type="gboolean" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="job-count" type="gint" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="location" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="name" type="char*" readable="1" writable="1" construct="0" construct-only="1"/>
			<property name="paused" type="gboolean" readable="1" writable="0" construct="0" construct-only="0"/>
			<property name="state-message" type="char*" readable="1" writable="0" construct="0" construct-only="0"/>
			<signal name="details-acquired" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="printer" type="GtkPrinter*"/>
					<parameter name="success" type="gboolean"/>
				</parameters>
			</signal>
		</object>
	</namespace>
</api>
