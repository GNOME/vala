/* gstreamer-interfaces-0.10-custom.vala
 *
 * Copyright (C) 2009  Matias De la Puente
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
 * 	Matias De la Puente <mfpuente.ar@gmail.com>
 */

namespace Gst {
	[CCode (cheader_filename = "gst/interfaces/mixer.h")]
	public class MixerOptions {
		public unowned GLib.List<string> get_values ();
	}

	[CCode (cheader_filename = "gst/interfaces/colorbalance.h")]
	public interface ColorBalance : Gst.ImplementsInterface, Gst.Element {
		public abstract unowned GLib.List<Gst.ColorBalanceChannel> list_channels ();
	}

	[CCode (cheader_filename = "gst/interfaces/mixer.h")]
	public interface Mixer : Gst.ImplementsInterface, Gst.Element {
		public abstract unowned GLib.List<Gst.MixerTrack> list_tracks ();
	}

	[CCode (cheader_filename = "gst/interfaces/propertyprobe.h")]
	public interface PropertyProbe {
		public abstract unowned GLib.List<string> get_properties ();
	}

	[CCode (cheader_filename = "gst/interfaces/tuner.h")]
	public interface Tuner : Gst.ImplementsInterface, Gst.Element {
		public abstract unowned GLib.List<Gst.TunerChannel> list_channels ();
		public abstract unowned GLib.List<Gst.TunerNorm> list_norms ();
	}

	[CCode (cheader_filename = "gst/interfaces/navigation.h")]
	public interface Navigation : Gst.Element {
	}
}
