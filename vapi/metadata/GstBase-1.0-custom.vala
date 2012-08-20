namespace Gst {
	namespace Base {
		[CCode (cheader_filename = "gst/base/gstadapter.h,gst/base/gstbaseparse.h,gst/base/gstbasesink.h,gst/base/gstbasesrc.h,gst/base/gstbasetransform.h,gst/base/gstbitreader.h,gst/base/gstbytereader.h,gst/base/gstbytewriter.h,gst/base/gstcollectpads.h,gst/base/gstpushsrc.h,gst/base/gsttypefindhelper.h", cname = "GstBitReader")]
		[Compact]
		public class BitReader {
			public BitReader ([CCode (array_length_type = "guint")] uint8[] data);
		}
		[CCode (cheader_filename = "gst/base/gstadapter.h,gst/base/gstbaseparse.h,gst/base/gstbasesink.h,gst/base/gstbasesrc.h,gst/base/gstbasetransform.h,gst/base/gstbitreader.h,gst/base/gstbytereader.h,gst/base/gstbytewriter.h,gst/base/gstcollectpads.h,gst/base/gstpushsrc.h,gst/base/gsttypefindhelper.h", cname = "GstBitReader")]
		[Compact]
		public class ByteReader {
			public ByteReader ([CCode (array_length_type = "guint")] uint8[] data);
		}
		[CCode (cheader_filename = "gst/base/gstadapter.h,gst/base/gstbaseparse.h,gst/base/gstbasesink.h,gst/base/gstbasesrc.h,gst/base/gstbasetransform.h,gst/base/gstbitreader.h,gst/base/gstbytereader.h,gst/base/gstbytewriter.h,gst/base/gstcollectpads.h,gst/base/gstpushsrc.h,gst/base/gsttypefindhelper.h", cname = "GstBitReader")]
		[Compact]
		public class ByteWriter {
			public ByteWriter ();
public ByteWriter.with_size (uint size, bool fixed);
public ByteWriter.with_data ([CCode (array_length_type = "guint")] uint8[] data, uint size, bool initialized);
		}
	}
}