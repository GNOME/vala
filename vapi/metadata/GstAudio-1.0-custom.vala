namespace Gst.Audio {
	public class Sink : Gst.Audio.BaseSink {
		public class SinkClassExtension? extension;
		[CCode (vfunc_name = "extension->clear_all")]
		[NoWrapper]
		public virtual void clear_all ();
	}
}
