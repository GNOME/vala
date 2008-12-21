/* gstreamer-base-0.10-custom.vala
 *
 * Copyright (C) 2008  Ali Sabil
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
 * 	Ali Sabil <ali.sabil@gmail.com>
 */

namespace Gst {
	[CCode (cheader_filename = "gst/base/gstbasesrc.h")]
	public class BaseSrc {
		[NoWrapper]
		public virtual bool newsegment ();
	}
	[CCode (cheader_filename = "gst/base/gstbasetransform.h")]
	public class BaseTransform {
		[CCode (cname = "GST_BASE_TRANSFORM_SINK_NAME")]
		public const string SINK_NAME;
		[CCode (cname = "GST_BASE_TRANSFORM_SRC_NAME")]
		public const string SRC_NAME;
	}
}
