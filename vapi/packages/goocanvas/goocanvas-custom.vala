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
 * 	Matias De la Puente <mfpuente.ar@gmail.com>
 */

namespace Goo
{
	public class CanvasEllipse
	{
		[CCode (cname="goo_canvas_ellipse_new", type="GooCanvasItem*")]
		public static weak CanvasEllipse create (Goo.CanvasItem? parent, double center_x, double center_y, double radius_x, double radius_y, ...);
	}

	public class CanvasEllipseModel
	{
		[CCode (cname="goo_canvas_ellipse_model_new", type="GooCanvasItemModel*")]
		public static weak CanvasEllipseModel create (Goo.CanvasItemModel? parent, double center_x, double center_y, double radius_x, double radius_y, ...);
	}

	public class CanvasGroup
	{
		[CCode (cname="goo_canvas_group_new", type="GooCanvasItem*")]
		public static weak CanvasGroup create (Goo.CanvasItem? parent, ...);
	}

	public class CanvasGroupModel
	{
		[CCode (cname="goo_canvas_group_model_new", type="GooCanvasItemModel*")]
		public static weak CanvasGroupModel create (Goo.CanvasItemModel? parent, ...);
	}

	public class CanvasImage
	{
		[CCode (cname="goo_image_group_new", type="GooCanvasItem*")]
		public static weak CanvasImage create (Goo.CanvasItem? parent, Gdk.Pixbuf pixbuf, double x, double y, ...);
	}

	public class CanvasImageModel
	{
		[CCode (cname="goo_canvas_image_model_new", type="GooCanvasItemModel*")]
		public static weak CanvasImageModel create (Goo.CanvasItemModel? parent, Gdk.Pixbuf pixbuf, double x, double y, ...);
	}

	public class CanvasPath
	{
		[CCode (cname="goo_canvas_path_new", type="GooCanvasItem*")]
		public static weak CanvasPath create (Goo.CanvasItem? parent, string path_data, ...);
	}

	public class CanvasPathModel
	{
		[CCode (cname="goo_canvas_path_model_new", type="GooCanvasItemModel*")]
		public static weak CanvasPathModel create (Goo.CanvasItemModel? parent, string path_data, ...);
	}

	public class CanvasPolyline
	{
		[CCode (cname="goo_canvas_polyline_new", type="GooCanvasItem*")]
		public static weak CanvasPolyline create (Goo.CanvasItem? parent, bool close_path, int num_points, ...);
		[CCode (cname="goo_canvas_polyline_new_line", type="GooCanvasItem*")]
		public static weak CanvasPolyline create_line (Goo.CanvasItem? parent, double x1, double y1, double x2, double y2, ...);
	}

	public class CanvasPolylineModel
	{
		[CCode (cname="goo_canvas_polyline_model_new", type="GooCanvasItemModel*")]
		public static weak CanvasPolylineModel create (Goo.CanvasItemModel? parent, bool close_path, int num_points, ...);
		[CCode (cname="goo_canvas_polyline_model_new_line", type="GooCanvasItemModel*")]
		public static weak CanvasPolylineModel create_line (Goo.CanvasItemModel? parent, double x1, double y1, double x2, double y2, ...);
	}
	
	public class CanvasRect
	{
		[CCode (cname = "goo_canvas_rect_new", type="GooCanvasItem*")]
		public static weak CanvasRect create (Goo.CanvasItem? parent, double x, double y, double width, double height, ...);
	}
	
	public class CanvasRectModel
	{
		[CCode (cname = "goo_canvas_rect_model_new", type="GooCanvasItemModel*")]
		public static weak CanvasRectModel create (Goo.CanvasItemModel? parent, double x, double y, double width, double height, ...);
	}
	
	public class CanvasTable
	{
		[CCode (cname="goo_canvas_table_new", type="GooCanvasItem*")]
		public static weak CanvasTable create (Goo.CanvasItem? parent, ...);
	}
	
	public class CanvasTableModel
	{
		[CCode (cname="goo_canvas_table_model_new", type="GooCanvasItemModel*")]
		public static weak CanvasTableModel create (Goo.CanvasItemModel? parent, ...);
	}
	
	public class CanvasText
	{
		[CCode (cname="goo_canvas_text_new", type="GooCanvasItem*")]
		public static weak CanvasText create (Goo.CanvasItem? parent, string str, double x, double y, double width, Gtk.AnchorType anchor, ...);
	}
	
	public class CanvasTextModel
	{
		[CCode (cname="goo_canvas_text_model_new", type="GooCanvasItemModel*")]
		public static weak CanvasTextModel create (Goo.CanvasItemModel? parent, string str, double x, double y, double width, Gtk.AnchorType anchor, ...);
	}
	
	public class CanvasWidget
	{
		[CCode (cname="goo_canvas_widget_new", type="GooCanvasItem*")]
		public static weak CanvasWidget create (Goo.CanvasItem? parent, Gtk.Widget widget, double x, double y, double width, double height, ...);
	}
	
	public interface CanvasItem : GLib.Object
	{
		public void get_simple_transform (out double x, out double y, out double scale, out double rotation);
	}
	
	public interface CanvasItemModel : GLib.Object
	{
		public void get_simple_transform (out double x, out double y, out double scale, out double rotation);
	}
}

