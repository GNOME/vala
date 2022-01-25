/* linux-media.vapi
 *
 * Copyright (C) 2021-2022 Nikola Hadžić
 *
 * This library is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * Author:
 *  Nikola Hadžić <nikola.hadzic.000@protonmail.com>
 */

[CCode (cheader_filename = "linux/media.h", cprefix = "", lower_case_cprefix = "")]
namespace MediaController
{
	[CCode (cprefix = "MEDIA_ENT_")]
	public uint32 ID_FLAG_NEXT;

	[CCode (cname = "uint32", cprefix = "MEDIA_ENT_F_", has_type_id = false)]
	public enum EntityFunction
	{
		UNKNOWN,
		V4L2_SUBDEV_UNKNOWN,
		IO_V4L,
		IO_VBI,
		IO_SWRADIO,
		IO_DTV,
		DTV_DEMOD,
		TS_DEMUX,
		DTV_CA,
		DTV_NET_DECAP,
		CAM_SENSOR,
		FLASH,
		LENS,
		ATV_DECODER,
		TUNER,
		IF_VID_DECODER,
		IF_AUD_DECODER,
		AUDIO_CAPTURE,
		AUDIO_PLAYBACK,
		AUDIO_MIXER,
		PROC_VIDEO_COMPOSER,
		PROC_VIDEO_PIXEL_FORMATTER,
		PROC_VIDEO_PIXEL_ENC_CONV,
		PROC_VIDEO_LUT,
		PROC_VIDEO_SCALER,
		PROC_VIDEO_STATISTICS,
		PROC_VIDEO_ENCODER,
		PROC_VIDEO_DECODER,
		PROC_VIDEO_ISP,
		VID_MUX,
		VID_IF_BRIDGE,
		DV_DECODER,
		DV_ENCODER
	}

	[Flags]
	[CCode (cname = "uint32", cprefix = "MEDIA_ENT_FL_", has_type_id = false)]
	public enum EntityFlag
	{
		DEFAULT,
		CONNECTOR
	}

	[CCode (cname = "uint32", cprefix = "MEDIA_INTF_T_", has_type_id = false)]
	public enum InterfaceType
	{
		DVB_FE,
		DVB_DEMUX,
		DVB_DVR,
		DVB_CA,
		DVB_NET,
		V4L_VIDEO,
		V4L_VBI,
		V4L_RADIO,
		V4L_SUBDEV,
		V4L_SWRADIO,
		V4L_TOUCH,
		ALSA_PCM_CAPTURE,
		ALSA_PCM_PLAYBACK,
		ALSA_CONTROL,
		ALSA_COMPRESS,
		ALSA_RAWMIDI,
		ALSA_HWDEP,
		ALSA_SEQUENCER,
		ALSA_TIMER
	}

	[Flags]
	[CCode (cname = "uint32", cprefix = "MEDIA_PAD_FL_", has_type_id = false)]
	public enum PadFlag
	{
		SINK,
		SOURCE,
		MUST_CONNECT
	}

	[Flags]
	[CCode (cname = "uint32", cprefix = "MEDIA_LNK_FL_", has_type_id = false)]
	public enum LinkFlag
	{
		ENABLED,
		IMMUTABLE,
		DYNAMIC,
		LINK_TYPE,
		DATA_LINK,
		INTERFACE_LINK
	}

	[CCode (cname = "int", cprefix = "MEDIA_IOC_", has_type_id = false)]
	public enum IOC
	{
		DEVICE_INFO,
		G_TOPOLOGY,
		ENUM_ENTITIES,
		ENUM_LINKS,
		SETUP_LINK,
		REQUEST_ALLOC
	}

	[CCode (cname = "int", cprefix = "MEDIA_REQUEST_IOC_", has_type_id = false)]
	public enum RequestIOC
	{
		QUEUE,
		REINIT
	}

	[SimpleType]
	[CCode (cname = "struct media_device_info", has_type_id = false)]
	public struct DeviceInfo
	{
		public unowned string driver;
		public unowned string model;
		public unowned string serial;
		public unowned string bus_info;
		public uint32 media_version;
		public uint32 hw_revision;
		public uint32 driver_version;
	}

	[SimpleType]
	[CCode (cname = "struct media_v2_topology", has_type_id = false)]
	public struct V2_Topology
	{
		public uint64 topology_version;
		public uint32 num_entities;
		public uint64 ptr_entities;
		public uint32 num_interfaces;
		public uint64 ptr_interfaces;
		public uint32 num_pads;
		public uint64 ptr_pads;
		public uint32 num_links;
		public uint64 ptr_links;
	}

	[SimpleType]
	[CCode (cname = "struct media_v2_entity", has_type_id = false)]
	public struct V2_Entity
	{
		public uint32 id;
		public unowned string name;
		public uint32 function;
		public uint32 flags;
	}

	[SimpleType]
	[CCode (cname = "struct media_v2_intf_devnode", has_type_id = false)]
	public struct V2_IntfDevnode
	{
		public uint32 major;
		public uint32 minor;
	}

	[SimpleType]
	[CCode (cname = "struct media_v2_interface", has_type_id = false)]
	public struct V2_Interface
	{
		public uint32 id;
		public uint32 intf_type;
		public uint32 flags;
		public V2_IntfDevnode devnode;
	}

	[SimpleType]
	[CCode (cname = "struct media_v2_pad", has_type_id = false)]
	public struct V2_Pad
	{
		public uint32 id;
		public uint32 entity_id;
		public uint32 flags;
		public uint32 index;
	}

	[SimpleType]
	[CCode (cname = "struct media_v2_link", has_type_id = false)]
	public struct V2_Link
	{
		public uint32 id;
		public uint32 source_id;
		public uint32 sink_id;
		public uint32 flags;
	}

	[SimpleType]
	[CCode (cname = "struct media_entity_desc", has_type_id = false)]
	public struct EntityDesc
	{
		public uint32 id;
		public unowned string name;
		public uint32 type;
		public uint32 revision;
		public uint32 flags;
		public uint32 group_id;
		public uint16 pads;
		public uint16 links;

		[CCode (cname = "dev.major")]
		public uint32 dev_major;
		[CCode (cname = "dev.minor")]
		public uint32 dev_minor;

		[CCode (cname = "alsa.card")]
		public uint32 alsa_card;
		[CCode (cname = "alsa.device")]
		public uint32 alsa_device;
		[CCode (cname = "alsa.subdevice")]
		public uint32 alsa_subdevice;

		[CCode (cname = "v4l.major")]
		public uint32 v4l_major;
		[CCode (cname = "v4l.minor")]
		public uint32 v4l_minor;

		[CCode (cname = "fb.major")]
		public uint32 fb_major;
		[CCode (cname = "fb.minor")]
		public uint32 fb_minor;

		public int dvb;
	}

	[SimpleType]
	[CCode (cname = "struct media_pad_desc", has_type_id = false)]
	public struct PadDesc
	{
		public uint32 entity;
		public uint16 index;
		public uint32 flags;
	}

	[SimpleType]
	[CCode (cname = "struct media_link_desc", has_type_id = false)]
	public struct LinkDesc
	{
		public PadDesc source;
		public PadDesc sink;
		public uint32 flags;
	}

	[SimpleType]
	[CCode (cname = "struct media_links_enum", has_type_id = false)]
	public struct LinksEnum
	{
		public uint32 entity;
		public PadDesc *pads;
		public LinkDesc *links;
	}
}

