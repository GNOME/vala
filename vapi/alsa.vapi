/* asound.vapi
 *
 * Copyright (C) 2009 Michael 'Mickey' Lauer <mlauer@vanille-media.de>
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
 */

[CCode (lower_case_cprefix = "snd_", cheader_filename = "alsa/asoundlib.h")]
namespace Alsa {

    public weak string strerror (int error);

    [CCode (cname = "snd_aes_iec958_t", destroy_function = "")]
    public struct AesIec958
    {
        public uchar[] status;
        public uchar[] subcode;
        public uchar pad;
        public uchar[] dig_subframe;
    }

    [CCode (cprefix = "SND_CTL_", cheader_filename = "alsa/control.h")]
    public enum CardOpenType
    {
        NONBLOCK,
        ASYNC,
        READONLY
    }

    [Compact]
    [CCode (cprefix = "snd_ctl_card_info_", cname = "snd_ctl_card_info_t", free_function = "snd_ctl_card_info_free")]
    public class CardInfo
    {
        [CCode (cname = "snd_ctl_card_info_malloc")]
        public static int alloc (out CardInfo info);

        public weak string get_id();
        public weak string get_longname();

        public weak string get_mixername();
        public weak string get_components();
    }

    [Compact]
    [CCode (cprefix = "snd_ctl_", cname = "snd_ctl_t", free_function = "snd_ctl_close")]
    public class Card
    {
        public static int open (out Card card, string name = "default", CardOpenType t = 0);

        public int card_info (CardInfo info);
        public int elem_list (ElemList list);
        public int elem_info (ElemInfo info);
        public int elem_read (ElemValue value);
        public int elem_write (ElemValue value);
    }

    [Compact]
    [CCode (cprefix = "snd_ctl_elem_id_", cname = "snd_ctl_elem_id_t", free_function = "snd_ctl_elem_id_free")]
    public class ElemId
    {
        [CCode (cname = "snd_ctl_elem_id_malloc")]
        public static int alloc (out ElemId eid);

        public weak string get_name();
        public uint get_numid();
        public uint get_index();
        public uint get_device();
        public uint get_subdevice();
    }

    [Compact]
    [CCode (cprefix = "snd_ctl_elem_info_", cname = "snd_ctl_elem_info_t", free_function = "snd_ctl_elem_info_free")]
    public class ElemInfo
    {
        [CCode (cname = "snd_ctl_elem_info_malloc")]
        public static int alloc (out ElemInfo t);

        public void set_id (ElemId eid);
        public void set_numid (uint n);

        public uint get_count ();
        public ElemType get_type ();
    }

    [CCode (cprefix = "SND_CTL_ELEM_IFACE_", cname = "snd_ctl_elem_iface_t")]
    public enum ElemInterface
    {
        CARD,
        HWDEP,
        MIXER,
        PCM,
        RAWMIDI,
        TIMER,
        SEQUENCER
    }

    [CCode (cprefix = "SND_CTL_ELEM_TYPE_", cname = "snd_ctl_elem_type_t")]
    public enum ElemType
    {
        NONE,
        BOOLEAN,
        INTEGER,
        ENUMERATED,
        BYTES,
        IEC958,
        INTEGER64,
    }

    [Compact]
    [CCode (cprefix = "snd_ctl_elem_value_", cname = "snd_ctl_elem_value_t", free_function = "snd_ctl_elem_value_free")]
    public class ElemValue
    {
        [CCode (cname = "snd_ctl_elem_value_malloc")]
        public static int alloc (out ElemValue t);

        public void set_id (ElemId eid);

        public bool get_boolean (uint idx);
        public long get_integer (uint idx);
        public int64 get_integer64 (uint idx);
        public uint get_enumerated (uint idx);
        public uchar get_byte (uint idx);
        public void get_iec958 (AesIec958 val);

        public void set_boolean (uint idx, bool b);
        public void set_integer (uint idx, long l);
        public void set_integer64 (uint idx, int64 i);
        public void set_enumerated (uint idx, uint val);
        public void set_byte (uint idx, uchar val);
        public void set_iec958 (AesIec958 val);
    }

    [Compact] 
    [CCode (cprefix = "snd_ctl_elem_list_", cname = "snd_ctl_elem_list_t", free_function = "snd_ctl_elem_list_free")]
    public class ElemList
    {
        [CCode (cname = "snd_ctl_elem_list_malloc")]
        public static int alloc (out ElemList list);
        public int alloc_space (uint entries);
        public uint get_count();
        public uint get_used();
        public void free_space ();
        public void set_offset (uint offset);

        public void get_id (uint n, ElemId eid);
    }

    [Compact]
    [CCode (cprefix = "snd_mixer_", cname = "snd_mixer_t", free_function = "snd_mixer_close")]
    public class Mixer
    {
        public static int open (out Mixer mixer, int t = 0 /* MixerOpenType t = 0 */ );
        public int attach (string card = "default");
        public int detach (string card = "default");
        public uint get_count ();
        public int load ();
        public int selem_register (int options = 0, void* classp = null );

        public MixerElement first_elem ();
        public MixerElement last_elem ();
    }

    [Compact]
    [CCode (cprefix = "snd_mixer_elem_", cname = "snd_mixer_elem_t", free_function = "")]
    public class MixerElement
    {
        public MixerElement next ();
        public MixerElement prev ();
        [CCode (cname = "snd_mixer_selem_get_id")]
        public void get_id (SimpleElementId eid);
    }

    [Compact]
    [CCode (cprefix = "snd_mixer_selem_id_", cname = "snd_mixer_selem_id_t", free_function = "")]
    public class SimpleElementId
    {
        [CCode (cname = "snd_mixer_selem_id_malloc")]
        public static int alloc (out SimpleElementId eid);

        public weak string get_name();
        public uint get_index();
    }

}
