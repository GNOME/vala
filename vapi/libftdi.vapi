[CCode (cprefix = "ftdi_", lower_case_prefix = "ftdi_", cheader_filename = "ftdi.h,usb.h")]
namespace FTDI {
	[CCode (cprefix = "TYPE_")]
	enum ChipType {
		AM,
		BM,
		2232C
	}

	[CCode (cprefix = "")]
	enum ParityType {
		NONE,
		ODD,
		EVEN,
		MARK,
		SPACE
	}

	[CCode (cprefix = "STOP_")]
	enum StopBitsType {
		BIT_1,
		BIT_15,
		BIT_2
	}

	[CCode (cprefix = "")]
	enum BitsType {
		BITS_7,
		BITS_8
	}

	[CCode (cprefix = "BITMODE_", cname = "ftdi_mpsse_mode")]
	enum MPSSEMode {
		RESET,
		BITBANG,
		MPSSE,
		SYNCBB,
		MCU,
		OPTO,
		CBUS
	}

	[CCode (cprefix = "INTERFACE_")]
	enum Interface {
		ANY,
		A,
		B
	}

	[CCode (cprefix = "SIO_")]
	enum FlowControlType {
		DISABLE_FLOW_CTRL,
		RTS_CTS_HS,
		DTR_DSR_HS,
		XON_XOFF_HS
	}

	[CCode (cname = "struct ftdi_device_list", cheader_filename = "usb.h", free_function = "ftdi_list_free2")]
	public class DeviceList {
		public DeviceList next;
		public USB.Device * dev;
	}

	[CCode (cname = "struct ftdi_eeprom")]
	struct EEPROM {
		public int vendor_id;
		public int product_id;
		public int self_powered;
		public int remote_wakeup;
		public int BM_type_chip;
		public int in_is_isochronous;
		public int out_is_isochronous;
		public int suspend_pull_downs;
		public int use_serial;
		public int change_usb_version;
		public int usb_version;
		public int max_power;
		public string manufacturer;
		public string product;
		public string serial;
	}

	[CCode (cname = "struct ftdi_context", free_function = "ftdi_free", cprefix = "ftdi_")]
	public class Context {
		[CCode (cname = "ftdi_new")]
		public Context ();
		public int init ();
		public void deinit ();
		public int set_interface (Interface iface);
		public void set_usbdev (USB.Device * usbdev);
		public int usb_find_all (out DeviceList devlist, int vendor, int product);
		[NoArrayLength]
		public int usb_get_strings (USB.Device * usbdev, char[] manufacturer, int manufacturer_len, char[] description, int description_len, char[] serial, int serial_len);
		public int usb_open_dev (USB.Device * usbdev);
		public int usb_open (int vendor, int product);
		public int usb_open_desc (int vendor, int product, string description, string serial);
		public int usb_reset ();
		public int usb_purge_buffers ();
		public int usb_close ();
		public int set_baudrate (int baudrate);
		public int set_line_property (BitsType bits, StopBitsType sbit, ParityType parity);
		[NoArrayLength]
		public int write_data (uchar[] buf, int size);
		public int write_data_set_chunksize (int chunksize);
		public int write_data_get_chunksize (out int chunksize);
		[NoArrayLength]
		public int read_data (uchar[] buf, uint size);
		public int read_data_set_chunksize (int chunksize);
		public int read_data_get_chunksize (out int chunksize);
		public int enable_bitbang (uchar bitmask);
		public int disable_bitbang ();
		public int set_bitmode (uchar bitmask, uchar mode);
		public int read_pins (out uchar pins);
		public int set_latency_timer (uchar latency);
		public int get_latency_timer (out uchar latency);
		public void eeprom_initdefaults (out EEPROM eeprom);
		public weak string get_error_string ();
		public int setflowctrl (FlowControlType flowctrl);
		public int setdtr (int state);
		public int setrts (int state);

		public USB.DeviceHandle usb_dev;
		public int usb_read_timeout;
		public int usb_write_timeout;
		public ChipType type;
		public int baudrate;
		public uchar bitbang_enabled;
		[NoArrayLength]
		public uchar[] readbuffer;
		public uint readbuffer_offset;
		public uint readbuffer_remaining;
		public uint readbuffer_chunksize;
		public uint writebuffer_chunksize;
		public int @interface;
		public int index;
		public int in_ep;
		public int out_ep;
		public uchar bitbang_mode;
		[NoArrayLength]
		public string error_str;
	}
}
