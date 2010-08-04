/* goocanvas-custom.vala
 *
 * Copyright (C) 2008  Matias De la Puente
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Eric ALBER <eric.alber@gmail.com>
 * 	Matias De la Puente <mfpuente.ar@gmail.com>
 */

/* Written for GooCanvas v0.15 */

namespace Goo
{
	[Compact]
	[CCode (type_id = "GOO_TYPE_CAIRO_MATRIX")]
	public class CairoMatrix
	{
		public double xx;
		public double yx;
		public double xy;
		public double yy;
		public double x0;
		public double y0;
	}

	public class Canvas
	{
		[CCode (has_construct_function = false)]
		public Canvas();
		public static void create_path(GLib.Array<CanvasPathCommand> commands, Cairo.Context cr);
		public static GLib.Array<CanvasPathCommand> parse_path_data (string path_data);
		public GLib.List<unowned CanvasItem>? get_items_at (double x, double y, bool is_pointer_event);
		public GLib.List<unowned CanvasItem>? get_items_in_area (Goo.CanvasBounds area, bool inside_area, bool allow_overlaps, bool include_containers);
	}

	public class CanvasEllipse
	{
		[CCode (cname="goo_canvas_ellipse_new", type="GooCanvasItem*")]
		public static unowned CanvasEllipse create (Goo.CanvasItem? parent, double center_x, double center_y, double radius_x, double radius_y, ...);
	}

	public class CanvasEllipseModel
	{
		[CCode (cname="goo_canvas_ellipse_model_new", type="GooCanvasItemModel*")]
		public static unowned CanvasEllipseModel create (Goo.CanvasItemModel? parent, double center_x, double center_y, double radius_x, double radius_y, ...);
	}

	public class CanvasGrid
	{
		[CCode (cname="goo_canvas_grid_new", type="GooCanvasItemModel*")]
		public static unowned CanvasGrid create(Goo.CanvasItem? parent, double x, double y, double width, double height, double x_step, double y_step, double x_offset, double y_offset, ...);
	}

	public class CanvasGridModel
	{
		[CCode (cname="goo_canvas_grid_model_new", type="GooCanvasItemModel*")]
		public static unowned CanvasGridModel create(CanvasItemModel? parent, double x, double y, double width, double height, double x_step, double y_step, double x_offset, double y_offset, ...);
	}

	public class CanvasGroup
	{
		[CCode (cname="goo_canvas_group_new", type="GooCanvasItem*")]
		public static unowned CanvasGroup create (Goo.CanvasItem? parent, ...);
	}

	public class CanvasGroupModel
	{
		[CCode (cname="goo_canvas_group_model_new", type="GooCanvasItemModel*")]
		public static unowned CanvasGroupModel create (Goo.CanvasItemModel? parent, ...);
	}

	public class CanvasImage
	{
		[CCode (cname="goo_canvas_image_new", type="GooCanvasItem*")]
		public static unowned CanvasImage create (Goo.CanvasItem? parent, Gdk.Pixbuf pixbuf, double x, double y, ...);
	}

	public class CanvasImageModel
	{
		[CCode (cname="goo_canvas_image_model_new", type="GooCanvasItemModel*")]
		public static unowned CanvasImageModel create (Goo.CanvasItemModel? parent, Gdk.Pixbuf pixbuf, double x, double y, ...);
	}

	[Compact]
	[CCode (type_id = "GOO_TYPE_CANVAS_LINE_DASH")]
	public class CanvasLineDash {
		public double* dashes;
		[CCode (has_construct_function = false)]
		public CanvasLineDash.newv (int num_dashes, double* dashes);
	}

	public class CanvasPath
	{
		[CCode (cname="goo_canvas_path_new", type="GooCanvasItem*")]
		public static unowned CanvasPath create (Goo.CanvasItem? parent, string path_data, ...);
	}

	public class CanvasPathModel
	{
		[CCode (cname="goo_canvas_path_model_new", type="GooCanvasItemModel*")]
		public static unowned CanvasPathModel create (Goo.CanvasItemModel? parent, string path_data, ...);
	}

	[Compact]
	[CCode (type_id = "GOO_TYPE_CANVAS_POINTS")]
	public class CanvasPoints {
		public double* coords;
	}

	public class CanvasPolyline
	{
		[CCode (cname="goo_canvas_polyline_new", type="GooCanvasItem*")]
		public static unowned CanvasPolyline create (Goo.CanvasItem? parent, bool close_path, int num_points, ...);
		[CCode (cname="goo_canvas_polyline_new_line", type="GooCanvasItem*")]
		public static unowned CanvasPolyline create_line (Goo.CanvasItem? parent, double x1, double y1, double x2, double y2, ...);
	}

	public class CanvasPolylineModel
	{
		[CCode (cname="goo_canvas_polyline_model_new", type="GooCanvasItemModel*")]
		public static unowned CanvasPolylineModel create (Goo.CanvasItemModel? parent, bool close_path, int num_points, ...);
		[CCode (cname="goo_canvas_polyline_model_new_line", type="GooCanvasItemModel*")]
		public static unowned CanvasPolylineModel create_line (Goo.CanvasItemModel? parent, double x1, double y1, double x2, double y2, ...);
	}

	public class CanvasRect
	{
		[CCode (cname = "goo_canvas_rect_new", type="GooCanvasItem*")]
		public static unowned CanvasRect create (Goo.CanvasItem? parent, double x, double y, double width, double height, ...);
	}

	public class CanvasRectModel
	{
		[CCode (cname = "goo_canvas_rect_model_new", type="GooCanvasItemModel*")]
		public static unowned CanvasRectModel create (Goo.CanvasItemModel? parent, double x, double y, double width, double height, ...);
	}

	public class CanvasStyle
	{
		public unowned Goo.CanvasStyle? parent;
		public unowned GLib.Array<CanvasStyleProperty> properties;
	}

	public class CanvasTable
	{
		[CCode (cname="goo_canvas_table_new", type="GooCanvasItem*")]
		public static unowned CanvasTable create (Goo.CanvasItem? parent, ...);
	}

	public class CanvasTableModel
	{
		[CCode (cname="goo_canvas_table_model_new", type="GooCanvasItemModel*")]
		public static unowned CanvasTableModel create (Goo.CanvasItemModel? parent, ...);
	}

	public class CanvasText
	{
		[CCode (cname="goo_canvas_text_new", type="GooCanvasItem*")]
		public static unowned CanvasText create (Goo.CanvasItem? parent, string str, double x, double y, double width, Gtk.AnchorType anchor, ...);
	}

	public class CanvasTextModel
	{
		[CCode (cname="goo_canvas_text_model_new", type="GooCanvasItemModel*")]
		public static unowned CanvasTextModel create (Goo.CanvasItemModel? parent, string str, double x, double y, double width, Gtk.AnchorType anchor, ...);
	}

	public class CanvasWidget
	{
		[CCode (cname="goo_canvas_widget_new", type="GooCanvasItem*")]
		public static unowned CanvasWidget create (Goo.CanvasItem? parent, Gtk.Widget widget, double x, double y, double width, double height, ...);
	}

	public interface CanvasItem : GLib.Object
	{
		public static GLib.ParamSpec[] class_list_child_properties (GLib.ObjectClass iclass, out uint n_properties);
		public void get_child_properties (Goo.CanvasItem child, ...);
		public void set_child_properties (Goo.CanvasItem child, ...);
		public abstract unowned GLib.List<CanvasItem> get_items_at (double x, double y, Cairo.Context cr, bool is_pointer_event, bool parent_is_visible, GLib.List<CanvasItem> found_items);
	}

	public interface CanvasItemModel : GLib.Object
	{
		public static GLib.ParamSpec[] class_list_child_properties (GLib.ObjectClass iclass, out uint n_properties);
		public void get_child_properties (Goo.CanvasItem child, ...);
		public void set_child_properties (Goo.CanvasItem child, ...);
	}

	public struct CanvasItemSimpleData
	{
		public Cairo.Matrix? transform;
		public weak GLib.Array<CanvasPathCommand> clip_path_commands;
	}

	/* Trying to describe a C union with dummy structs */
	public struct CanvasPathCommandSimple
	{
		uint type;
		uint relative;
		double x;
		double y;
	}
	public struct CanvasPathCommandCurve
	{
		uint type;
		uint relative;
		double x;
		double y;
		double x1;
		double y1;
		double x2;
		double y2;
	}
	public struct CanvasPathCommandArc
	{
		uint type;
		uint relative;
		uint large_arc_flag;
		uint sweep_flag;
		double rx;
		double ry;
		double x_axis_rotation;
		double x;
		double y;
	}
	[CCode (type_id = "GOO_TYPE_CANVAS_PATH_COMMAND", cheader_filename = "goocanvas.h")]
	public struct CanvasPathCommand {
		public CanvasPathCommandSimple simple;
		public CanvasPathCommandCurve curve;
		public CanvasPathCommandArc arc;
	}
}
