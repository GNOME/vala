/* gstreamer-rtsp-0.10-custom.vala
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
	[Compact]
	[CCode (cheader_filename = "gst/rtsp/gstrtspmessage.h", free_function = "gst_rtsp_message_free")]
	public class RTSPMessage {
		public static Gst.RTSPResult @new (out Gst.RTSPMessage msg);
		public static Gst.RTSPResult new_data (out Gst.RTSPMessage msg, uchar channel);
		public static Gst.RTSPResult new_request (out Gst.RTSPMessage msg, Gst.RTSPMethod method, string uri);
		public static Gst.RTSPResult new_response (out Gst.RTSPMessage msg, Gst.RTSPStatusCode code, string reason, Gst.RTSPMessage request);
	}

	[Compact]
	[CCode (cheader_filename = "gst/rtsp/gstrtsptransport.h", free_function = "gst_rtsp_transport_free")]
	public class RTSPTransport {
		public static Gst.RTSPResult @new (out Gst.RTSPTransport transport);
	}
}
