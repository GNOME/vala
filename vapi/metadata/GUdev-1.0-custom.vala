namespace GUdev {
	[CCode (cheader_filename = "gudev/gudev.h")]
	[SimpleType]
	public struct DeviceNumber : Posix.dev_t {
	}
}
