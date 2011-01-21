/* gstreamer-0.10-custom.vala
 *
 * Copyright (C) 2011 Collabora Multimedia
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
 * 	Arun Raghavan <arun.raghavan@collabora.co.uk>
 */

namespace Gst {
	[CCode (ref_function = "gst_encoding_profile_ref", unref_function = "gst_encoding_profile_unref")]
	public class EncodingProfile : Gst.MiniObject {
		public unowned EncodingProfile @ref ();
		public void unref ();
	}
	[CCode (ref_function = "gst_encoding_target_ref", unref_function = "gst_encoding_target_unref")]
	public class EncodingTarget : Gst.MiniObject {
		public unowned EncodingTarget @ref ();
		public void unref ();
	}
}
