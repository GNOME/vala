<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Vte">
		<struct name="VteCharAttributes">
			<field name="row" type="long"/>
			<field name="column" type="long"/>
			<field name="fore" type="GdkColor"/>
			<field name="back" type="GdkColor"/>
			<field name="underline" type="guint"/>
			<field name="strikethrough" type="guint"/>
		</struct>
		<enum name="VteTerminalAntiAlias">
			<member name="VTE_ANTI_ALIAS_USE_DEFAULT" value="0"/>
			<member name="VTE_ANTI_ALIAS_FORCE_ENABLE" value="1"/>
			<member name="VTE_ANTI_ALIAS_FORCE_DISABLE" value="2"/>
		</enum>
		<enum name="VteTerminalEraseBinding">
			<member name="VTE_ERASE_AUTO" value="0"/>
			<member name="VTE_ERASE_ASCII_BACKSPACE" value="1"/>
			<member name="VTE_ERASE_ASCII_DELETE" value="2"/>
			<member name="VTE_ERASE_DELETE_SEQUENCE" value="3"/>
		</enum>
		<object name="VteReaper" parent="GObject" type-name="VteReaper" get-type="vte_reaper_get_type">
			<method name="add_child" symbol="vte_reaper_add_child">
				<return-type type="int"/>
				<parameters>
					<parameter name="pid" type="GPid"/>
				</parameters>
			</method>
			<method name="get" symbol="vte_reaper_get">
				<return-type type="VteReaper*"/>
			</method>
			<signal name="child-exited" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="VteReaper*"/>
					<parameter name="p0" type="gint"/>
					<parameter name="p1" type="gint"/>
				</parameters>
			</signal>
			<field name="channel" type="GIOChannel*"/>
			<field name="iopipe" type="int[]"/>
		</object>
		<object name="VteTerminal" parent="GtkWidget" type-name="VteTerminal" get-type="vte_terminal_get_type">
			<implements>
				<interface name="AtkImplementor"/>
				<interface name="GtkBuildable"/>
			</implements>
			<method name="copy_clipboard" symbol="vte_terminal_copy_clipboard">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="copy_primary" symbol="vte_terminal_copy_primary">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="feed" symbol="vte_terminal_feed">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="data" type="char*"/>
					<parameter name="length" type="glong"/>
				</parameters>
			</method>
			<method name="feed_child" symbol="vte_terminal_feed_child">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="text" type="char*"/>
					<parameter name="length" type="glong"/>
				</parameters>
			</method>
			<method name="feed_child_binary" symbol="vte_terminal_feed_child_binary">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="data" type="char*"/>
					<parameter name="length" type="glong"/>
				</parameters>
			</method>
			<method name="fork_command" symbol="vte_terminal_fork_command">
				<return-type type="pid_t"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="command" type="char*"/>
					<parameter name="argv" type="char**"/>
					<parameter name="envv" type="char**"/>
					<parameter name="directory" type="char*"/>
					<parameter name="lastlog" type="gboolean"/>
					<parameter name="utmp" type="gboolean"/>
					<parameter name="wtmp" type="gboolean"/>
				</parameters>
			</method>
			<method name="forkpty" symbol="vte_terminal_forkpty">
				<return-type type="pid_t"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="envv" type="char**"/>
					<parameter name="directory" type="char*"/>
					<parameter name="lastlog" type="gboolean"/>
					<parameter name="utmp" type="gboolean"/>
					<parameter name="wtmp" type="gboolean"/>
				</parameters>
			</method>
			<method name="get_adjustment" symbol="vte_terminal_get_adjustment">
				<return-type type="GtkAdjustment*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_allow_bold" symbol="vte_terminal_get_allow_bold">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_audible_bell" symbol="vte_terminal_get_audible_bell">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_char_ascent" symbol="vte_terminal_get_char_ascent">
				<return-type type="glong"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_char_descent" symbol="vte_terminal_get_char_descent">
				<return-type type="glong"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_char_height" symbol="vte_terminal_get_char_height">
				<return-type type="glong"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_char_width" symbol="vte_terminal_get_char_width">
				<return-type type="glong"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_column_count" symbol="vte_terminal_get_column_count">
				<return-type type="glong"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_cursor_position" symbol="vte_terminal_get_cursor_position">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="column" type="glong*"/>
					<parameter name="row" type="glong*"/>
				</parameters>
			</method>
			<method name="get_default_emulation" symbol="vte_terminal_get_default_emulation">
				<return-type type="char*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_emulation" symbol="vte_terminal_get_emulation">
				<return-type type="char*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_encoding" symbol="vte_terminal_get_encoding">
				<return-type type="char*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_font" symbol="vte_terminal_get_font">
				<return-type type="PangoFontDescription*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_has_selection" symbol="vte_terminal_get_has_selection">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_icon_title" symbol="vte_terminal_get_icon_title">
				<return-type type="char*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_mouse_autohide" symbol="vte_terminal_get_mouse_autohide">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_padding" symbol="vte_terminal_get_padding">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="xpad" type="int*"/>
					<parameter name="ypad" type="int*"/>
				</parameters>
			</method>
			<method name="get_row_count" symbol="vte_terminal_get_row_count">
				<return-type type="glong"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_status_line" symbol="vte_terminal_get_status_line">
				<return-type type="char*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_text" symbol="vte_terminal_get_text">
				<return-type type="char*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="is_selected" type="GCallback"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="attributes" type="GArray*"/>
				</parameters>
			</method>
			<method name="get_text_include_trailing_spaces" symbol="vte_terminal_get_text_include_trailing_spaces">
				<return-type type="char*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="is_selected" type="GCallback"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="attributes" type="GArray*"/>
				</parameters>
			</method>
			<method name="get_text_range" symbol="vte_terminal_get_text_range">
				<return-type type="char*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="start_row" type="glong"/>
					<parameter name="start_col" type="glong"/>
					<parameter name="end_row" type="glong"/>
					<parameter name="end_col" type="glong"/>
					<parameter name="is_selected" type="GCallback"/>
					<parameter name="data" type="gpointer"/>
					<parameter name="attributes" type="GArray*"/>
				</parameters>
			</method>
			<method name="get_using_xft" symbol="vte_terminal_get_using_xft">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_visible_bell" symbol="vte_terminal_get_visible_bell">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="get_window_title" symbol="vte_terminal_get_window_title">
				<return-type type="char*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="im_append_menuitems" symbol="vte_terminal_im_append_menuitems">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="menushell" type="GtkMenuShell*"/>
				</parameters>
			</method>
			<method name="is_word_char" symbol="vte_terminal_is_word_char">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="c" type="gunichar"/>
				</parameters>
			</method>
			<method name="match_add" symbol="vte_terminal_match_add">
				<return-type type="int"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="match" type="char*"/>
				</parameters>
			</method>
			<method name="match_check" symbol="vte_terminal_match_check">
				<return-type type="char*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="column" type="glong"/>
					<parameter name="row" type="glong"/>
					<parameter name="tag" type="int*"/>
				</parameters>
			</method>
			<method name="match_clear_all" symbol="vte_terminal_match_clear_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="match_remove" symbol="vte_terminal_match_remove">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="tag" type="int"/>
				</parameters>
			</method>
			<method name="match_set_cursor" symbol="vte_terminal_match_set_cursor">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="tag" type="int"/>
					<parameter name="cursor" type="GdkCursor*"/>
				</parameters>
			</method>
			<method name="match_set_cursor_type" symbol="vte_terminal_match_set_cursor_type">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="tag" type="int"/>
					<parameter name="cursor_type" type="GdkCursorType"/>
				</parameters>
			</method>
			<constructor name="new" symbol="vte_terminal_new">
				<return-type type="GtkWidget*"/>
			</constructor>
			<method name="paste_clipboard" symbol="vte_terminal_paste_clipboard">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="paste_primary" symbol="vte_terminal_paste_primary">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="reset" symbol="vte_terminal_reset">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="full" type="gboolean"/>
					<parameter name="clear_history" type="gboolean"/>
				</parameters>
			</method>
			<method name="select_all" symbol="vte_terminal_select_all">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="select_none" symbol="vte_terminal_select_none">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="set_allow_bold" symbol="vte_terminal_set_allow_bold">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="allow_bold" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_audible_bell" symbol="vte_terminal_set_audible_bell">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="is_audible" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_background_image" symbol="vte_terminal_set_background_image">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="image" type="GdkPixbuf*"/>
				</parameters>
			</method>
			<method name="set_background_image_file" symbol="vte_terminal_set_background_image_file">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="path" type="char*"/>
				</parameters>
			</method>
			<method name="set_background_saturation" symbol="vte_terminal_set_background_saturation">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="saturation" type="double"/>
				</parameters>
			</method>
			<method name="set_background_tint_color" symbol="vte_terminal_set_background_tint_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="color" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_background_transparent" symbol="vte_terminal_set_background_transparent">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="transparent" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_backspace_binding" symbol="vte_terminal_set_backspace_binding">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="binding" type="VteTerminalEraseBinding"/>
				</parameters>
			</method>
			<method name="set_color_background" symbol="vte_terminal_set_color_background">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="background" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_color_bold" symbol="vte_terminal_set_color_bold">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="bold" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_color_cursor" symbol="vte_terminal_set_color_cursor">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="cursor_background" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_color_dim" symbol="vte_terminal_set_color_dim">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="dim" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_color_foreground" symbol="vte_terminal_set_color_foreground">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="foreground" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_color_highlight" symbol="vte_terminal_set_color_highlight">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="highlight_background" type="GdkColor*"/>
				</parameters>
			</method>
			<method name="set_colors" symbol="vte_terminal_set_colors">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="foreground" type="GdkColor*"/>
					<parameter name="background" type="GdkColor*"/>
					<parameter name="palette" type="GdkColor*"/>
					<parameter name="palette_size" type="glong"/>
				</parameters>
			</method>
			<method name="set_cursor_blinks" symbol="vte_terminal_set_cursor_blinks">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="blink" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_default_colors" symbol="vte_terminal_set_default_colors">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</method>
			<method name="set_delete_binding" symbol="vte_terminal_set_delete_binding">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="binding" type="VteTerminalEraseBinding"/>
				</parameters>
			</method>
			<method name="set_emulation" symbol="vte_terminal_set_emulation">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="emulation" type="char*"/>
				</parameters>
			</method>
			<method name="set_encoding" symbol="vte_terminal_set_encoding">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="codeset" type="char*"/>
				</parameters>
			</method>
			<method name="set_font" symbol="vte_terminal_set_font">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="font_desc" type="PangoFontDescription*"/>
				</parameters>
			</method>
			<method name="set_font_from_string" symbol="vte_terminal_set_font_from_string">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="name" type="char*"/>
				</parameters>
			</method>
			<method name="set_font_from_string_full" symbol="vte_terminal_set_font_from_string_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="name" type="char*"/>
					<parameter name="antialias" type="VteTerminalAntiAlias"/>
				</parameters>
			</method>
			<method name="set_font_full" symbol="vte_terminal_set_font_full">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="font_desc" type="PangoFontDescription*"/>
					<parameter name="antialias" type="VteTerminalAntiAlias"/>
				</parameters>
			</method>
			<method name="set_mouse_autohide" symbol="vte_terminal_set_mouse_autohide">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="setting" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_opacity" symbol="vte_terminal_set_opacity">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="opacity" type="guint16"/>
				</parameters>
			</method>
			<method name="set_pty" symbol="vte_terminal_set_pty">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="pty_master" type="int"/>
				</parameters>
			</method>
			<method name="set_scroll_background" symbol="vte_terminal_set_scroll_background">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="scroll" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_scroll_on_keystroke" symbol="vte_terminal_set_scroll_on_keystroke">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="scroll" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_scroll_on_output" symbol="vte_terminal_set_scroll_on_output">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="scroll" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_scrollback_lines" symbol="vte_terminal_set_scrollback_lines">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="lines" type="glong"/>
				</parameters>
			</method>
			<method name="set_size" symbol="vte_terminal_set_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="columns" type="glong"/>
					<parameter name="rows" type="glong"/>
				</parameters>
			</method>
			<method name="set_visible_bell" symbol="vte_terminal_set_visible_bell">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="is_visible" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_word_chars" symbol="vte_terminal_set_word_chars">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="spec" type="char*"/>
				</parameters>
			</method>
			<signal name="char-size-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="char_width" type="guint"/>
					<parameter name="char_height" type="guint"/>
				</parameters>
			</signal>
			<signal name="child-exited" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="commit" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="text" type="char*"/>
					<parameter name="size" type="guint"/>
				</parameters>
			</signal>
			<signal name="contents-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="copy-clipboard" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="cursor-moved" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="decrease-font-size" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="deiconify-window" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="emulation-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="encoding-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="eof" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="icon-title-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="iconify-window" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="increase-font-size" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="lower-window" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="maximize-window" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="move-window" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="x" type="guint"/>
					<parameter name="y" type="guint"/>
				</parameters>
			</signal>
			<signal name="paste-clipboard" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="raise-window" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="refresh-window" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="resize-window" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="width" type="guint"/>
					<parameter name="height" type="guint"/>
				</parameters>
			</signal>
			<signal name="restore-window" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="selection-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="status-line-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="text-deleted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="text-inserted" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="text-modified" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<signal name="text-scrolled" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
					<parameter name="delta" type="gint"/>
				</parameters>
			</signal>
			<signal name="window-title-changed" when="LAST">
				<return-type type="void"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</signal>
			<vfunc name="vte_reserved1">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="vte_reserved2">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="vte_reserved3">
				<return-type type="void"/>
			</vfunc>
			<vfunc name="vte_reserved4">
				<return-type type="void"/>
			</vfunc>
			<field name="adjustment" type="GtkAdjustment*"/>
			<field name="char_width" type="glong"/>
			<field name="char_height" type="glong"/>
			<field name="char_ascent" type="glong"/>
			<field name="char_descent" type="glong"/>
			<field name="row_count" type="glong"/>
			<field name="column_count" type="glong"/>
			<field name="window_title" type="char*"/>
			<field name="icon_title" type="char*"/>
			<field name="pvt" type="VteTerminalPrivate*"/>
		</object>
		<object name="VteTerminalAccessible" parent="GtkAccessible" type-name="VteTerminalAccessible" get-type="vte_terminal_accessible_get_type">
			<implements>
				<interface name="AtkComponent"/>
				<interface name="AtkAction"/>
				<interface name="AtkText"/>
			</implements>
			<constructor name="new" symbol="vte_terminal_accessible_new">
				<return-type type="AtkObject*"/>
				<parameters>
					<parameter name="terminal" type="VteTerminal*"/>
				</parameters>
			</constructor>
		</object>
		<object name="VteTerminalAccessibleFactory" parent="AtkObjectFactory" type-name="VteTerminalAccessibleFactory" get-type="vte_terminal_accessible_factory_get_type">
			<constructor name="new" symbol="vte_terminal_accessible_factory_new">
				<return-type type="AtkObjectFactory*"/>
			</constructor>
		</object>
	</namespace>
</api>
