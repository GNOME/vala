/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */


using GLib;
using Gee;
using Gdk;


namespace Valadoc.Html {
	public class ImageDocElement : Valadoc.ImageDocElement {
		private static uint counter = 0;

		private string htmlpath;
		private string npath;
		private string path;
		private string alt;

		public override bool parse ( Settings settings, Documentation pos, owned string path, owned string alt ) {
			if ( GLib.FileUtils.test ( path, GLib.FileTest.EXISTS | GLib.FileTest.IS_REGULAR ) == false ) {
				return false;
			}

			weak string? dotpos = path.rchr ( -1, '.' ); 
			string filename = "img0%u%s".printf(this.counter++, dotpos.ndup(dotpos.size()));

			this.path = realpath ( path );

			if ( pos == null || (pos is WikiPage)? ((WikiPage)pos).name=="index.valadoc": false ) {
				this.htmlpath = Path.build_filename("content", "img", filename);
				this.npath = Path.build_filename(settings.path, this.htmlpath);
				this.alt = alt;
			}
			else if ( pos is DocumentedElement ) {
				this.htmlpath = Path.build_filename("img", filename);
				this.npath = Path.build_filename(settings.path, ((DocumentedElement)pos).package.name, this.htmlpath);
				this.alt = alt;
			}
			else {
				this.htmlpath = Path.build_filename("img", filename);
				this.npath = Path.build_filename(settings.path, "content", this.htmlpath);
				this.alt = alt;
			}
			return true;
		}

		private string? create_thumb (string filename, string destinationpath) {
			int height;
			int width;

			weak PixbufFormat format = Pixbuf.get_file_info (filename, out width, out height);
			if ( width == 0 || height == 0 ) {
				return null;
			}

			if ( width > 700 ) {
				try {
					Pixbuf img = new Pixbuf.from_file (filename);

					int dest_height = (height*700)/width;
					int dest_width = 700;


					if (dest_height == 0) {
						dest_height++;
					}

					Pixbuf dest = new Pixbuf (img.get_colorspace(), img.get_has_alpha(), img.get_bits_per_sample(), dest_width, dest_height);
					img.scale (dest, 0, 0, dest_width, dest_height, 0, 0, (double)dest_width/img.get_width(), (double)dest_height/img.get_height(), Gdk.InterpType.BILINEAR);

					string newfilename = GLib.Path.build_filename(destinationpath, "tmb_"+Path.get_basename (filename));
					dest.save (newfilename, format.get_name());
					return newfilename;
				}
				catch (Error err) {
					return null;
				}
			}

			return filename;
		}

		public override bool write ( void* res, int max, int index ) {
			bool tmp = copy_file ( this.path, this.npath );
			if ( tmp == false )
				return false;

			string thumbpath = create_thumb (this.npath, Path.get_dirname(this.npath));
			if ( thumbpath == null ) {
				return false;
			}

			((GLib.FileStream)res).printf ( "<a href=\"%s\"><img src=\"%s\" alt=\"%s\" /></a>", this.htmlpath, thumbpath, this.alt );
			return true;
		}
	}
}


[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
	return typeof ( Valadoc.Html.ImageDocElement );
}

