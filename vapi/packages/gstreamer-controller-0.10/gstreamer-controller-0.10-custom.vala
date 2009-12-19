[CCode (cprefix = "Gst", lower_case_cprefix = "gst_")]
namespace Gst {
	[CCode (cheader_filename = "gst/controller/gstlfocontrolsource.h")]
	public enum LFOWaveform {
		SINE,
		SQUARE,
		SAW,
		REVERSE,
		TRIANGLE
	}
}