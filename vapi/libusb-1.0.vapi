[CCode (cprefix = "libusb_", cheader_filename = "libusb.h")]
namespace LibUSB {
	[CCode (cname = "enum libusb_class_code", cprefix = "LIBUSB_CLASS_", has_type_id = false)]
	public enum ClassCode {
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

	[CCode (cname = "enum libusb_descriptor_type", cprefix = "LIBUSB_DT_", has_type_id = false)]
	public enum DescriptorType {
		DEVICE,
		CONFIG,
		STRING,
		INTERFACE,
		ENDPOINT,
		BOS,
		DEVICE_CAPABILITY,
		HID,
		REPORT,
		PHYSICAL,
		HUB,
		SUPERSPEED_HUB,
		SS_ENDPOINT_COMPANION
	}

	namespace DescriptorTypeSize {
		[CCode (cname = "LIBUSB_DT_DEVICE_SIZE")]
		public const int DEVICE_SIZE;
		[CCode (cname = "LIBUSB_DT_CONFIG_SIZE")]
		public const int CONFIG_SIZE;
		[CCode (cname = "LIBUSB_DT_INTERFACE_SIZE")]
		public const int INTERFACE_SIZE;
		[CCode (cname = "LIBUSB_DT_ENDPOINT_SIZE")]
		public const int ENDPOINT_SIZE;
		[CCode (cname = "LIBUSB_DT_ENDPOINT_AUDIO_SIZE")]
		public const int ENDPOINT_AUDIO_SIZE;
		[CCode (cname = "LIBUSB_DT_HUB_NONVAR_SIZE")]
		public const int HUB_NONVAR_SIZE;
		[CCode (cname = "LIBUSB_DT_SS_ENDPOINT_COMPANION_SIZE")]
		public const int SS_ENDPOINT_COMPANION_SIZE;
		[CCode (cname = "LIBUSB_DT_BOS_SIZE")]
		public const int BOS_SIZE;
		[CCode (cname = "LIBUSB_DT_DEVICE_CAPABILITY_SIZE")]
		public const int DEVICE_CAPABILITY_SIZE;
		[CCode (cname = "LIBUSB_BT_USB_2_0_EXTENSION_SIZE")]
		public const int USB_2_0_EXTENSION_SIZE;
		[CCode (cname = "LIBUSB_BT_SS_USB_DEVICE_CAPABILITY_SIZE")]
		public const int SS_USB_DEVICE_CAPABILITY_SIZE;
		[CCode (cname = "LIBUSB_BT_CONTAINER_ID_SIZE")]
		public const int CONTAINER_ID_SIZE;
		[CCode (cname = "LIBUSB_DT_BOS_MAX_SIZE")]
		public const int BOS_MAX_SIZE;
	}

	namespace EndpointMask {
		[CCode (cname = "LIBUSB_ENDPOINT_ADDRESS_MASK")]
		public const int ADDRESS;
		[CCode (cname = "LIBUSB_ENDPOINT_DIR_MASK")]
		public const int DIR;
		[CCode (cname = "LIBUSB_ENDPOINT_DIR_MASK")]
		public const int DIRECTION;
	}

	[CCode (cname = "enum libusb_endpoint_direction", cprefix = "LIBUSB_ENDPOINT_", has_type_id = false)]
	public enum EndpointDirection {
		IN,
		OUT,
		[CCode (cname = "LIBUSB_ENDPOINT_DIR_MASK")]
		MASK
	}

	[CCode (cname = "enum libusb_transfer_type", cprefix = "LIBUSB_TRANSFER_TYPE_", has_type_id = false)]
	public enum TransferType {
		CONTROL,
		ISOCHRONOUS,
		BULK,
		INTERRUPT,
		BULK_STREAM
	}

	[CCode (cname = "enum libusb_standard_request", cprefix = "LIBUSB_REQUEST_", has_type_id = false)]
	public enum StandardRequest {
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
		SYNCH_FRAME,
		SET_SEL,
		[CCode (cname = "LIBUSB_SET_ISOCH_DELAY")]
		SET_ISOCH_DELAY
	}

	[CCode (cname = "enum libusb_request_type", cprefix = "LIBUSB_REQUEST_TYPE_", has_type_id = false)]
	public enum RequestType {
		STANDARD,
		CLASS,
		VENDOR,
		RESERVED
	}

	[CCode (cname = "enum libusb_request_recipient", cprefix = "LIBUSB_RECIPIENT_", has_type_id = false)]
	public enum RequestRecipient {
		DEVICE,
		INTERFACE,
		ENDPOINT,
		OTHER
	}

	[CCode (cname =	"enum libusb_iso_sync_type", cprefix = "LIBUSB_ISO_SYNC_TYPE_", has_type_id = false)]
	public enum IsoSyncType {
		NONE,
		ASYNC,
		ADAPTIVE,
		SYNC,
		MASK
	}

	[CCode (cname = "enum libusb_iso_usage_type", cprefix = "LIBUSB_ISO_USAGE_TYPE_", has_type_id = false)]
	public enum IsoUsageType {
		DATA,
		FEEDBACK,
		IMPLICIT,
		MASK
	}

	[CCode (cname = "enum libusb_error", cprefix = "LIBUSB_ERROR_", has_type_id = false)]
	public enum Error {
		[CCode (cname = "LIBUSB_SUCCESS")]
		SUCCESS,
		IO,
		INVALID_PARAM,
		ACCESS,
		NO_DEVICE,
		NOT_FOUND,
		BUSY,
		TIMEOUT,
		OVERFLOW,
		PIPE,
		INTERRUPTED,
		NO_MEM,
		NOT_SUPPORTED,
		OTHER;
		[CCode (cname = "libusb_strerror")]
		public unowned string get_description ();
		[CCode (cname = "libusb_error_name")]
		public unowned string get_name ();
	}

	[CCode (cname = "enum libusb_transfer_flags", cprefix = "LIBUSB_TRANSFER_", has_type_id = false)]
	public enum TransferFlags {
		SHORT_NOT_OK,
		FREE_BUFFER,
		FREE_TRANSFER,
		ADD_ZERO_PACKET
	}

	[CCode (cname = "enum libusb_speed", cprefix = "LIBUSB_SPEED_", has_type_id = false)]
	public enum Speed {
		UNKNOWN,
		LOW,
		FULL,
		HIGH,
		SUPER
	}

	[Flags]
	[CCode (cname = "enum libusb_supported_speed", has_type_id = false)]
	public enum SupportedSpeed {
		[CCode (cname = "LIBUSB_LOW_SPEED_OPERATION")]
		LOW,
		[CCode (cname = "LIBUSB_FULL_SPEED_OPERATION")]
		FULL,
		[CCode (cname = "LIBUSB_HIGH_SPEED_OPERATION")]
		HIGH,
		[CCode (cname = "LIBUSB_SUPER_SPEED_OPERATION")]
		SUPER
	}

	[Flags]
	[CCode (cname = "enum libusb_usb_2_0_extension_attributes", has_type_id = false)]
	public enum USB_2_0_ExtensionAttributes {
		[CCode (cname = "LIBUSB_BM_LPM_SUPPORT")]
		LPM_SUPPORT
	}

	[Flags]
	[CCode (cname = "enum libusb_ss_usb_device_capability_attributes", has_type_id = false)]
	public enum SSUsbDeviceCapabilityAttributes {
		[CCode (cname = "LIBUSB_BM_LTM_SUPPORT")]
		LTM_SUPPORT
	}

	[CCode (cname = "enum libusb_bos_type", cprefix = "LIBUSB_BT_", has_type_id = false)]
	public enum BosType {
		WIRELESS_USB_DEVICE_CAPABILITY,
		USB_2_0_EXTENSION,
		SS_USB_DEVICE_CAPABILITY,
		CONTAINER_ID
	}

	[CCode (cname = "struct libusb_device_descriptor", has_type_id = false)]
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

		[CCode (cname = "libusb_get_device_descriptor", instance_pos = -1)]
		public DeviceDescriptor (Device device);
	}

	[CCode (cname = "struct libusb_endpoint_descriptor", cprefix = "libusb_", has_type_id = false)]
	public struct EndpointDescriptor {
		public uint8 bLength;
		public uint8 bDescriptorType;
		public uint8 bEndpointAddress;
		public uint8 bmAttributes;
		public uint16 wMaxPacketSize;
		public uint8 bInterval;
		public uint8 bRefresh;
		public uint8 bSynchAddress;
		[CCode (array_length_cname = "extra_length")]
		public unowned uint8[] extra;
	}

	[CCode (cname = "struct libusb_interface_descriptor", has_type_id = false)]
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
		[CCode (array_length_cname = "bNumEndpoints", array_length_type = "uint8_t")]
		public unowned EndpointDescriptor[] endpoint;
		[CCode (array_length_cname = "extra_length")]
		public unowned uint8[] extra;
	}

	[CCode (cname = "struct libusb_interface", has_type_id = false)]
	public struct Interface {
		[CCode (array_length_cname = "num_altsetting")]
		public unowned InterfaceDescriptor[] altsetting;
	}

	[CCode (cname = "struct libusb_config_descriptor", free_function = "libusb_free_config_descriptor")]
	[Compact]
	public class ConfigDescriptor {
		public uint8 bLength;
		public uint8 bDescriptorType;
		public uint16 wTotalLength;
		public uint8 bNumInterfaces;
		public uint8 bConfigurationValue;
		public uint8 iConfiguration;
		public uint8 bmAttributes;
		public uint8 MaxPower;
		[CCode (array_length_cname = "bNumInterfaces")]
		public Interface[] @interface;
		[CCode (array_length_cname = "extra_length")]
		public uint8[] extra;
	}

	[CCode (cname = "struct libusb_ss_endpoint_companion_descriptor", free_function = "libusb_free_ss_endpoint_companion_descriptor")]
	[Compact]
	public class SSEndpointCompanionDescriptor {
		public uint8 bLength;
		public uint8 bDescriptorType;
		public uint8 bMaxBurst;
		public uint8 bmAttributes;
		public uint16 wBytesPerInterval;
	}

	[CCode (cname = "struct libusb_bos_dev_capability_descriptor", has_type_id = false)]
	public struct BosDevCapabilityDescriptor {
		public uint8 bLength;
		public uint8 bDescriptorType;
		public uint8 bDevCapabilityType;
		public uint8 dev_capability_data[0];
	}

	[CCode (cname = "struct libusb_bos_descriptor", free_function = "libusb_free_bos_descriptor")]
	[Compact]
	public class BosDescriptor {
		public uint8 bLength;
		public uint8 bDescriptorType;
		public uint16 wTotalLength;
		public uint8 bNumDeviceCaps;
		public BosDevCapabilityDescriptor dev_capability[0];
	}

	[CCode (cname = "struct libusb_usb_2_0_extension_descriptor", free_function = "libusb_free_usb_2_0_extension_descriptor")]
	[Compact]
	public class USB_2_0_ExtensionDescriptor {
		public uint8 bLength;
		public uint8 bDescriptorType;
		public uint8 bDevCapabilityType;
		public uint32 bmAttributes;
	}

	[CCode (cname = "struct libusb_ss_usb_device_capability_descriptor", free_function = "libusb_free_ss_usb_device_capability_descriptor")]
	[Compact]
	public class SSUsbDeviceCapabilityDescriptor {
		public uint8 bLength;
		public uint8 bDescriptorType;
		public uint8 bDevCapabilityType;
		public uint8 bmAttributes;
		public uint16 wSpeedSupported;
		public uint8 bFunctionalitySupport;
		public uint8 bU1DevExitLat;
		public uint8 bU2DevExitLat;
	}

	[CCode (cname = "struct libusb_container_id_descriptor", free_function = "libusb_free_container_id_descriptor")]
	[Compact]
	public class ContainerIdDescriptor {
		public uint8 bLength;
		public uint8 bDescriptorType;
		public uint8 bDevCapabilityType;
		public uint8 bReserved;
		public uint8 ContainerID[16];
	}

	[CCode (cname = "libusb_device_handle", cprefix = "libusb_", free_function = "libusb_close")]
	[Compact]
	public class DeviceHandle {
		[CCode (cname = "_vala_libusb_device_handle_from_device")]
		public DeviceHandle from_device (Device device) {
			DeviceHandle handle;
			device.open (out handle);
			return handle;
		}

		[CCode (cname = "libusb_open_device_with_vid_pid")]
		public DeviceHandle.from_vid_pid (Context? context, uint16 vendor_id, uint16 product_id);
		public unowned Device get_device ();
		public LibUSB.Error get_configuration (out int config);
		public LibUSB.Error set_configuration (int configuration);
		public LibUSB.Error claim_interface (int interface_number);
		public LibUSB.Error release_interface (int interface_number);
		public LibUSB.Error set_interface_alt_setting (int interface_number, int alternate_setting);
		public LibUSB.Error clear_halt (uchar endpoint);
		[CCode (cname = "libusb_reset_device")]
		public LibUSB.Error reset ();
		public LibUSB.Error kernel_driver_active (int @interface);
		public LibUSB.Error detach_kernel_driver (int @interface);
		public LibUSB.Error attach_kernel_driver (int @interface);
		public LibUSB.Error set_auto_detach_kernel_driver (bool enable);

		public LibUSB.Error get_string_descriptor_ascii (uint8 desc_index, uint8[] data);
		public LibUSB.Error get_descriptor (uint8 desc_type, uint8 desc_index, uint8[] data);
		public LibUSB.Error get_string_descriptor (uint desc_index, uint16 langid, uint8[] data);
		public LibUSB.Error get_bos_descriptor (out BosDescriptor bos);

		public LibUSB.Error control_transfer (uint8 bmRequestType, uint8 bRequest, uint16 wValue, uint16 wIndex, [CCode (array_length = false)] uint8[] data, uint16 wLength, uint timeout);
		public LibUSB.Error bulk_transfer (uint8 endpoint, uint8[] data, out int transferred, uint timeout);
		public LibUSB.Error interrupt_transfer (uint8 endpoint, uint8[] data, out int transferred, uint timeout);
	}

	[CCode (cname = "libusb_device", cprefix = "libusb_", ref_function = "libusb_ref_device", unref_function = "libusb_unref_device")]
	[Compact]
	public class Device {
		public uint8 get_bus_number ();
		public uint8 get_port_number ();
		public int get_port_numbers (uint8[] port_numbers);
		public uint8 get_device_address ();
		public int get_max_packet_size (uint8 endpoint);
		public int get_max_iso_packet_size (uint8 endpoint);
		public Speed get_device_speed ();
		public LibUSB.Error open (out DeviceHandle handle);

		public LibUSB.Error get_active_config_descriptor (out ConfigDescriptor config);
		public LibUSB.Error get_config_descriptor (uint8 config_index, out ConfigDescriptor config);
		public LibUSB.Error get_config_descriptor_by_value (uint8 ConfigurationValue, out ConfigDescriptor config);
		public LibUSB.Error get_device_descriptor (out DeviceDescriptor desc);
		public unowned Device get_parent ();
	}

	[CCode (cname = "enum libusb_log_level", cprefix = "LIBUSB_LOG_LEVEL_", has_type_id = false)]
	public enum LogLevel {
		NONE,
		ERROR,
		WARNING,
		INFO,
		DEBUG
	}

	[CCode (cname = "libusb_context", cprefix = "libusb_", free_function = "libusb_exit")]
	[Compact]
	public class Context {
		protected Context ();
		public static LibUSB.Error init (out Context context);
		public void set_debug (LogLevel level);
		[CCode (cname = "libusb_get_device_list")]
		public ssize_t _get_device_list ([CCode (array_length = false, array_null_terminated = true)] out Device[] list);
		[CCode (cname = "_vala_libusb_get_device_list")]
		public Device[] get_device_list () {
			Device[] result;
			var result_length = _get_device_list (out result);
			result.length = (int) result_length;
			return (owned) result;
		}
		public DeviceHandle open_device_with_vid_pid (uint16 vendor_id, uint16 product_id);

		public LibUSB.Error try_lock_events ();
		public void lock_events ();
		public void unlock_events ();
		public LibUSB.Error event_handling_ok ();
		public LibUSB.Error event_handler_active ();
		public void interrupt_event_handler ();
		public void lock_event_waiters ();
		public void unlock_event_waiters ();
		public LibUSB.Error wait_for_event (Posix.timeval tv);
		public LibUSB.Error handle_events_timeout (Posix.timeval tv);
		public LibUSB.Error handle_events_timeout_completed (Posix.timeval tv, out int completed);
		public LibUSB.Error handle_events ();
		public LibUSB.Error handle_events_completed (out int completed);
		public LibUSB.Error handle_events_locked (Posix.timeval tv);
		public LibUSB.Error pollfds_handle_timeouts ();
		public LibUSB.Error get_next_timeout (out Posix.timeval tv);
		public void set_pollfd_notifiers (pollfd_added_cb added_cb, pollfd_removed_cb removed_cb, void* user_data);
		[CCode (array_length = false, array_null_terminated = true)]
		public PollFD[] get_pollfds ();

		public LibUSB.Error get_ss_endpoint_companion_descriptor (EndpointDescriptor config, out SSEndpointCompanionDescriptor ep_comp);
		public LibUSB.Error get_usb_2_0_extension_descriptor (BosDevCapabilityDescriptor dev_cap, out USB_2_0_ExtensionDescriptor usb_2_0_extension);
		public LibUSB.Error get_ss_usb_device_capability_descriptor (BosDevCapabilityDescriptor dev_cap, out SSUsbDeviceCapabilityDescriptor usb_2_0_extension);
		public LibUSB.Error get_container_id_descriptor (BosDevCapabilityDescriptor dev_cap, out ContainerIdDescriptor container_id);
		public LibUSB.Error hotplug_register_callback (HotPlugEvent events, HotPlugFlags flags, int vendor_id, int product_id, int dev_class, HotPlugCb cb_fn, out HotCallbackHandle callback_handle);
		public LibUSB.Error hotplug_deregister_callback (HotCallbackHandle callback_handle);
	}

	[CCode (cname = "libusb_le16_to_cpu")]
	public static uint16 le16_to_cpu (uint16 n);
	[CCode (cname = "libusb_cpu_to_le16")]
	public static uint16 cpu_to_le16 (uint16 n);

	[CCode (cname = "struct libusb_control_setup")]
	[Compact]
	public class ControlSetup {
		public uint8 bmRequestType;
		public int8 bRequest;
		public uint16 wValue;
		public uint16 wIndex;
		public uint16 wLength;
	}

	[CCode (cname = "enum libusb_capability", cprefix = "LIBUSB_CAP_", has_type_id = false)]
	public enum Capability {
		HAS_CAPABILITY,
		HAS_HOTPLUG,
		HAS_HID_ACCESS,
		SUPPORTS_DETACH_KERNEL_DRIVER
	}

	[CCode (cname = "enum libusb_transfer_status", cprefix = "LIBUSB_TRANSFER_", has_type_id = false)]
	public enum TransferStatus {
		COMPLETED,
		ERROR,
		TIMED_OUT,
		CANCELLED,
		STALL,
		NO_DEVICE,
		OVERFLOW
	}

	[CCode (cname = "libusb_hotplug_event", cprefix = "LIBUSB_HOTPLUG_EVENT_", has_type_id = false)]
	public enum HotPlugEvent {
		DEVICE_ARRIVED,
		DEVICE_LEFT,
		[CCode (cname = "LIBUSB_HOTPLUG_MATCH_ANY")]
		MATCH_ANY
	}

	[CCode (cname = "libusb_hotplug_flag", cprefix = "LIBUSB_HOTPLUG_", has_type_id = false)]
	public enum HotPlugFlags {
		NO_FLAGS,
		ENUMERATE
	}

	[CCode (cname = "libusb_hotplug_callback_handle", has_type_id = false)]
	[SimpleType]
	public struct HotCallbackHandle : int {
	}

	[CCode (cname = "struct libusb_iso_packet_descriptor", has_type_id = false)]
	public struct IsoPacketDescriptor {
		public uint length;
		public uint actual_length;
		public TransferStatus status;
	}

	[CCode (cname = "libusb_transfer_cb_fn")]
	public delegate void TransferCb (Transfer transfer);

	[CCode (cname = "struct libusb_transfer", cprefix = "libusb_", free_function = "libusb_free_transfer")]
	[Compact]
	public class Transfer {
		public DeviceHandle dev_handle;
		public uint8 flags;
		public uint8 endpoint;
		public uint8 type;
		public uint timeout;
		public TransferStatus status;
		public int length;
		public int actual_length;
		[CCode (delegate_target_cname = "user_data")]
		public TransferCb @callback;
		[CCode (array_length_cname = "length")]
		public uint8[] buffer;
		public int num_iso_packets;
		[CCode (array_length = false)]
		public IsoPacketDescriptor[] iso_packet_desc;

		[CCode (cname = "libusb_alloc_transfer")]
		public Transfer (int iso_packets = 0);
		[CCode (cname = "libusb_submit_transfer")]
		public LibUSB.Error submit ();
		[CCode (cname = "libusb_cancel_transfer")]
		public LibUSB.Error cancel ();
		[CCode (cname = "libusb_control_transfer_get_data", array_length = false)]
		public unowned char[] control_get_data ();
		[CCode (cname = "libusb_control_transfer_get_setup")]
		public unowned ControlSetup control_get_setup ();

		public static void fill_control_setup ([CCode (array_length = false)] uint8[] buffer, uint8 bmRequestType, uint8 bRequest, uint16 wValue, uint16 wIndex, uint16 wLength);
		public void fill_control_transfer (DeviceHandle dev_handle, [CCode (array_length = false)] uint8[] buffer, TransferCb @callback, uint timeout);
		public void fill_bulk_transfer (DeviceHandle dev_handle, uint8 endpoint, uint8[] buffer, TransferCb @callback, uint timeout);
		public void fill_interrupt_transfer (DeviceHandle dev_handle, uint8 endpoint, uint8[] buffer, TransferCb @callback, uint timeout);
		public void fill_iso_transfer (DeviceHandle dev_handle, uint8 endpoint, uint8[] buffer, int num_iso_packets, TransferCb @callback, uint timeout);
		public void set_iso_packet_lengths (uint length);
		[CCode (array_length = false)]
		public unowned uint8[] get_iso_packet_buffer (uint packet);
		[CCode (array_length = false)]
		public unowned uint8[] get_iso_packet_buffer_simple (int packet);
	}

	[CCode (has_target = false)]
	public delegate void pollfd_added_cb (int fd, short events, void* user_data);
	[CCode (has_target = false)]
	public delegate void pollfd_removed_cb (int fd, void* user_data);

	[CCode (cname = "libusb_hotplug_callback_fn")]
	public delegate void HotPlugCb (Context ctx, Device device, HotPlugEvent event);

	[CCode (cname = "struct libusb_pollfd")]
	[Compact]
	public class PollFD {
		public int fd;
		public short events;
	}

	[CCode (cname = "libusb_has_capability")]
	public static int has_capability (Capability capability);
}
