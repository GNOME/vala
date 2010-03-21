/* gstreamer-video-0.10-custom.vala
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
	[CCode (cheader_filename = "gst/video/video.h")]
	namespace VideoMask32 {
		[CCode (cname = "GST_VIDEO_BYTE1_MASK_32")]
		public const string BYTE1;
		[CCode (cname = "GST_VIDEO_BYTE2_MASK_32")]
		public const string BYTE2;
		[CCode (cname = "GST_VIDEO_BYTE3_MASK_32")]
		public const string BYTE3;
		[CCode (cname = "GST_VIDEO_BYTE4_MASK_32")]
		public const string BYTE4;

		[CCode (cname = "GST_VIDEO_BYTE1_MASK_32_INT")]
		public const int BYTE1_INT;
		[CCode (cname = "GST_VIDEO_BYTE2_MASK_32_INT")]
		public const int BYTE2_INT;
		[CCode (cname = "GST_VIDEO_BYTE3_MASK_32_INT")]
		public const int BYTE3_INT;
		[CCode (cname = "GST_VIDEO_BYTE4_MASK_32_INT")]
		public const int BYTE4_INT;
	}
	[CCode (cheader_filename = "gst/video/video.h")]
	namespace VideoMask24 {
		[CCode (cname = "GST_VIDEO_BYTE1_MASK_24")]
		public const string BYTE1;
		[CCode (cname = "GST_VIDEO_BYTE2_MASK_24")]
		public const string BYTE2;
		[CCode (cname = "GST_VIDEO_BYTE3_MASK_24")]
		public const string BYTE3;

		[CCode (cname = "GST_VIDEO_BYTE1_MASK_24_INT")]
		public const int BYTE1_INT;
		[CCode (cname = "GST_VIDEO_BYTE2_MASK_24_INT")]
		public const int BYTE2_INT;
		[CCode (cname = "GST_VIDEO_BYTE3_MASK_24_INT")]
		public const int BYTE3_INT;
	}

	[CCode (cheader_filename = "gst/video/video.h")]
	namespace VideoMask16 {
		[CCode (cname = "GST_VIDEO_RED_MASK_16")]
		public const string RED;
		[CCode (cname = "GST_VIDEO_GREEN_MASK_16")]
		public const string GREEN;
		[CCode (cname = "GST_VIDEO_BLUE_MASK_16")]
		public const string BLUE;

		[CCode (cname = "GST_VIDEO_RED_MASK_16_INT")]
		public const int RED_INT;
		[CCode (cname = "GST_VIDEO_GREEN_MASK_16_INT")]
		public const int GREEN_INT;
		[CCode (cname = "GST_VIDEO_BLUE_MASK_16_INT")]
		public const int BLUE_INT;
	}

	[CCode (cheader_filename = "gst/video/video.h")]
	namespace VideoMask15 {
		[CCode (cname = "GST_VIDEO_RED_MASK_15")]
		public const string RED;
		[CCode (cname = "GST_VIDEO_GREEN_MASK_15")]
		public const string GREEN;
		[CCode (cname = "GST_VIDEO_BLUE_MASK_15")]
		public const string BLUE;

		[CCode (cname = "GST_VIDEO_RED_MASK_15_INT")]
		public const int RED_INT;
		[CCode (cname = "GST_VIDEO_GREEN_MASK_15_INT")]
		public const int GREEN_INT;
		[CCode (cname = "GST_VIDEO_BLUE_MASK_15_INT")]
		public const int BLUE_INT;
	}

	[CCode (cheader_filename = "gst/video/video.h")]
	namespace VideoRange {
		[CCode (cname = "GST_VIDEO_SIZE_RANGE")]
		public const string SIZE;
		[CCode (cname = "GST_VIDEO_FPS_RANGE")]
		public const string FPS;
	}

	[CCode (cprefix = "GST_VIDEO_CAPS_", cheader_filename = "gst/video/video.h")]
	namespace VideoCaps {
		public const string RGB;
		public const string BGR;

		public const string RGBx;
		public const string xRGB;
		public const string BGRx;
		public const string xBGR;

		public const string RGBA;
		public const string ARGB;
		public const string BGRA;
		public const string ABGR;

		public const string xRGB_HOST_ENDIAN;
		public const string BGRx_HOST_ENDIAN;

		public const string RGB_16;
		public const string RGB_15;

		[CCode (cname = "GST_VIDEO_CAPS_YUV")]
		public unowned string YUV (string fourcc);
	}
}
