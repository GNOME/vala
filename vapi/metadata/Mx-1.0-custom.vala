namespace Mx {
	[CCode (cheader_filename = "mx/mx.h", type_id = "mx_box_layout_child_get_type ()")]
	public class BoxLayoutChild : Clutter.ChildMeta {
		[Deprecated (since = "vala-0.14", replacement = "BoxLayout.child_get_expand")]
		public static bool get_expand (Mx.BoxLayout box_layout, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "BoxLayout.child_get_x_align")]
		public static Mx.Align get_x_align (Mx.BoxLayout box_layout, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "BoxLayout.child_get_x_fill")]
		public static bool get_x_fill (Mx.BoxLayout box_layout, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "BoxLayout.child_get_y_align")]
		public static Mx.Align get_y_align (Mx.BoxLayout box_layout, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "BoxLayout.child_get_y_fill")]
		public static bool get_y_fill (Mx.BoxLayout box_layout, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "BoxLayout.child_set_expand")]
		public static void set_expand (Mx.BoxLayout box_layout, Clutter.Actor child, bool expand);
		[Deprecated (since = "vala-0.14", replacement = "BoxLayout.child_set_x_align")]
		public static void set_x_align (Mx.BoxLayout box_layout, Clutter.Actor child, Mx.Align x_align);
		[Deprecated (since = "vala-0.14", replacement = "BoxLayout.child_set_x_fill")]
		public static void set_x_fill (Mx.BoxLayout box_layout, Clutter.Actor child, bool x_fill);
		[Deprecated (since = "vala-0.14", replacement = "BoxLayout.child_set_y_align")]
		public static void set_y_align (Mx.BoxLayout box_layout, Clutter.Actor child, Mx.Align y_align);
		[Deprecated (since = "vala-0.14", replacement = "BoxLayout.child_set_y_fill")]
		public static void set_y_fill (Mx.BoxLayout box_layout, Clutter.Actor child, bool y_fill);
	}

	[CCode (cheader_filename = "mx/mx.h", type_id = "mx_floating_widget_get_type ()")]
	public abstract class FloatingWidget : Mx.Widget {
		[NoWrapper]
		public virtual void floating_paint (Clutter.Actor actor);
		[NoWrapper]
		public virtual void floating_pick (Clutter.Actor actor, Clutter.Color color);
	}

	[CCode (cheader_filename = "mx/mx.h", cprefix = "MX_STYLE_ERROR_INVALID_")]
	public enum StyleError {
		[Deprecated (since = "vala-0.14", replacement = "StyleError.INVALID_FILE")]
		FILE
	}

	[CCode (cheader_filename = "mx/mx.h", type_id = "mx_table_child_get_type ()")]
	public class TableChild : Clutter.ChildMeta {
		[Deprecated (since = "vala-0.14", replacement = "Table.child_get_column")]
		public static int get_column (Mx.Table table, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_get_column_span")]
		public static int get_column_span (Mx.Table table, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_get_row")]
		public static int get_row (Mx.Table table, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_get_row_span")]
		public static int get_row_span (Mx.Table table, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_get_x_align")]
		public static Mx.Align get_x_align (Mx.Table table, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_get_x_expand")]
		public static bool get_x_expand (Mx.Table table, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_get_x_fill")]
		public static bool get_x_fill (Mx.Table table, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_get_y_align")]
		public static Mx.Align get_y_align (Mx.Table table, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_get_y_expand")]
		public static bool get_y_expand (Mx.Table table, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_get_y_fill")]
		public static bool get_y_fill (Mx.Table table, Clutter.Actor child);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_set_column")]
		public static void set_column (Mx.Table table, Clutter.Actor child, int col);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_set_column_span")]
		public static void set_column_span (Mx.Table table, Clutter.Actor child, int span);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_set_row")]
		public static void set_row (Mx.Table table, Clutter.Actor child, int row);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_set_row_span")]
		public static void set_row_span (Mx.Table table, Clutter.Actor child, int span);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_set_x_align")]
		public static void set_x_align (Mx.Table table, Clutter.Actor child, Mx.Align align);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_set_x_expand")]
		public static void set_x_expand (Mx.Table table, Clutter.Actor child, bool expand);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_set_x_fill")]
		public static void set_x_fill (Mx.Table table, Clutter.Actor child, bool fill);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_set_y_align")]
		public static void set_y_align (Mx.Table table, Clutter.Actor child, Mx.Align align);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_set_y_expand")]
		public static void set_y_expand (Mx.Table table, Clutter.Actor child, bool expand);
		[Deprecated (since = "vala-0.14", replacement = "Table.child_set_y_fill")]
		public static void set_y_fill (Mx.Table table, Clutter.Actor child, bool fill);
	}


	[Deprecated (since = "vala-0.14", replacement = "FontWeight.set_from_string")]
	public static void font_weight_set_from_string (GLib.Value value, string str);
}
