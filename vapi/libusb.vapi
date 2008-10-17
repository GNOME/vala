[CCode (cprefix = "usb_", cheader_filename = "usb.h")]
namespace USB {
	[CCode (cprefix = "USB_CLASS_", cheader_filename = "usb.h")]
	public enum Class {
		PER_INTERFACE,
		AUDIO,
		COMM,
		HID,
		PRINTER,
		PTP,
		MASS_STORAGE,
		HUB,
		DATA,
		VENDOR_SPEC
	}

	[CCode (cprefix = "USB_DT_", cheader_filename = "usb.h")]
	public enum DescriptorType {
		DEVICE,
		CONFIG,
		STRING,
		INTERFACE,
		ENDPOINT,
		HID,
		REPORT,
		PHYSICAL,
		HUB
	}

	[CCode (cprefix = "USB_DT_", cheader_filename = "usb.h")]
	public enum DescriptorSize {
		[CCode (cname = "USB_DT_DEVICE_SIZE")]
		DEVICE,
		[CCode (cname = "USB_DT_CONFIG_SIZE")]
		CONFIG,
		[CCode (cname = "USB_DT_INTERFACE_SIZE")]
		INTERFACE,
		[CCode (cname = "USB_DT_ENDPOINT_SIZE")]
		ENDPOINT,
		[CCode (cname = "USB_DT_ENDPOINT_AUDIO_SIZE")]
		ENDPOINT_AUDIO,
		[CCode (cname = "USB_DT_HUB_NONVAR_SIZE")]
		HUB_NONVAR
	}

	[CCode (cprefix = "USB_ENDPOINT_", cheader_filename = "usb.h")]
	public enum EndpointAttribute {
		ADDRESS_MASK,
		IN,
		OUT,
		TYPE_MASK,
		TYPE_CONTROL,
		TYPE_ISOCHRONOUS,
		TYPE_BULK,
		TYPE_INTERRUPT,
	}

	[CCode (cprefix = "USB_ENDPOINT_", cheader_filename = "usb.h")]
	public enum EndpointAddress {
		ADDRESS_MASK,
		DIR_MASK,
		IN,
		OUT
	}

	[CCode (cprefix = "USB_REQ_", cheader_filename = "usb.h")]
	public enum Request {
		GET_STATUS,
		CLEAR_FEATURE,
		SET_FEATURE,
		SET_ADDRESS,
		GET_DESCRIPTOR,
		SET_DESCRIPTOR,
		GET_CONFIGURATION,
		SET_CONFIGURATION,
		GET_INTERFACE,
		SET_INTERFACE,
		SYNCH_FRAME
	}

	[CCode (cprefix = "USB_TYPE_", cheader_filename = "usb.h")]
	public enum Type {
		STANDARD,
		CLASS,
		VENDOR,
		RESERVED
	}

	[CCode (cname = "struct usb_endpoint_descriptor", cheader_filename = "usb.h")]
	public struct EndpointDescriptor {
		public uint8 bLength;
		public uint8 bDescriptorType;
		public uint8 bEndpointAddress;
		public uint8 bmAttributes;
		public uint16 wMaxPacketSize;
		public uint8 bInterval;
		public uint8 bRefresh;
		public uint8 bSynchAddress;

		public uchar[] extra;
		public int extralen;
	}

	[CCode (cname = "struct usb_interface_descriptor", cheader_filename = "usb.h")]
	public struct InterfaceDescriptor {
		public uint8 bLength;
		public uint8 bDescriptorType;
		public uint8 bInterfaceNumber;
		public uint8 bAlternateSetting;
		public uint8 bNumEndpoints;
		public uint8 bInterfaceClass;
		public uint8 bInterfaceSubClass;
		public uint8 bInterfaceProtocol;
		public uint8 iInterface;

		public EndpointDescriptor[] endpoint;

		public uchar[] extra;
		public int extralen;
	}

	[CCode (cname = "struct usb_interface", cheader_filename = "usb.h")]
	public struct Interface {
		public InterfaceDescriptor[] altsetting;
		public int num_altsetting;
	}

	[CCode (cname = "struct usd_config_descriptor")]
	public struct ConfigDescriptor {
		public uint8 bLength;
		public uint8 bDescriptorType;
		public uint16 wTotalLength;
		public uint8 bNumInterfaces;
		public uint8 bConfigurationValue;
		public uint8 iConfiguration;
		public uint8 bmAttributes;
		public uint8 MaxPower;

		[NoArrayLength]
		public Interface[] @interface;

		public uchar[] extra;
		public int extralen;
	}

	[CCode (cname = "struct usb_device_descriptor", cheader_filename = "usb.h")]
	public struct DeviceDescriptor {
		public uint8 bLength;
		public uint8 bDescriptorType;
		public uint16 bcdUSB;
		public uint8 bDeviceClass;
		public uint8 bDeviceSubClass;
		public uint8 bDeviceProtocol;
		public uint8 bMaxPacketSize0;
		public uint16 idVendor;
		public uint16 idProduct;
		public uint16 bcdDevice;
		public uint8 iManufacturer;
		public uint8 iProduct;
		public uint8 iSerialNumber;
		public uint8 bNumConfigurations;
	}

	[CCode (cname = "struct usb_device", cprefix = "usb_", cheader_filename = "usb.h")]
	public struct Device {
		public Device * next;
		public Device * prev;
		public string filename;
		public Bus * bus;
		public DeviceDescriptor descriptor;
		[NoArrayLength]
		public ConfigDescriptor[] config;
		public void * dev;
		public uint8 devnum;
		public uchar num_children;
		public Device ** children;
	}

	[CCode (cname = "struct usb_bus", cheader_filename = "usb.h")]
	public struct Bus {
		public Bus * next;
		public Bus * prev;
		public string dirname;
		public Device * devices;
		public uint32 location;
		public Device * root_dev;
	}

	[Compact]
	[CCode (cname = "usb_dev_handle", cprefix = "usb_", cheader_filename = "usb.h", free_function = "usb_close")]
	public class DeviceHandle {
		[CCode (cname = "usb_open")]
		public DeviceHandle (Device * dev);
		[NoArrayLength]
		public int get_string (int index, int langid, char[] buf, size_t buflen);
		[NoArrayLength]
		public int get_string_simple (int index, char[] buf, size_t buflen);

		public int get_descriptor_by_endpoint (int ep, uchar type, uchar index, void * buf, int size);
		public int get_descriptor (uchar type, uchar index, void * buf, int size);
		[NoArrayLength]
		public int bulk_write (int ep, char[] bytes, int size, int timeout);
		[NoArrayLength]
		public int bulk_read (int ep, char[] bytes, int size, int timeout);
		[NoArrayLength]
		public int interrupt_write (int ep, char[] bytes, int size, int timeout);
		[NoArrayLength]
		public int interrupt_read (int ep, char[] bytes, int size, int timeout);
		public int control_msg (int requesttype, int request, int value, int index, char[] bytes, int size, int timeout);
		public int set_configuration (int configuration);
		public int claim_interface (int @interface);
		public int release_interface (int @interface);
		public int set_altinterface (int alternate);
		public int resetep (uint ep);
		public int clear_halt (uint ep);
		public int reset ();
		public Device * device ();
	}

	[NoArrayLength]
	public static weak char[] strerror ();
	public static void init ();
	public static void set_debug (int level);
	public static int find_busses ();
	public static int find_devices ();
	public static Bus * get_busses ();
	[CCode (cname = "USB_LE16_TO_CPU")]
	public static uint16 le16_to_cpu (uint16 x);
}
