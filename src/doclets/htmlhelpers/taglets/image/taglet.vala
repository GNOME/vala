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


namespace Valadoc.Html {
	public class ImageDocElement : Valadoc.ImageDocElement {
		private ImageDocElementPosition position;
		private static uint counter = 0;

		private string htmlpath;
		private string npath;
		private string path;

		public override bool parse ( Settings settings, Tree tree, DocumentedElement me, string# path, ImageDocElementPosition pos ) {
			if ( GLib.FileUtils.test ( path, GLib.FileTest.EXISTS | GLib.FileTest.IS_REGULAR ) == false )
				return false;

			weak string? dotpos = path.rchr ( -1, '.' ); 
			this.htmlpath = GLib.Path.build_filename ( "img", "%u%s".printf ( this.counter++, (dotpos == null)? "" : dotpos.ndup ( dotpos.size() ) ) );
			this.npath = realpath ( GLib.Path.build_filename ( settings.path, me.package.name, this.htmlpath ) );
			this.path = realpath ( path );

			this.position = pos;
			return true;
		}

		public override bool write ( void* res, int max, int index ) {
			bool tmp = copy_file ( this.path, this.npath );
			if ( tmp == false )
				return false;

			switch ( this.position ) {
			case ImageDocElementPosition.NEUTRAL:
				((GLib.FileStream)res).printf ( "<img src=\"%s\" />", this.htmlpath );
				break;
			case ImageDocElementPosition.MIDDLE:
				((GLib.FileStream)res).printf ( "<img src=\"%s\" align=\"middle\"/>", this.htmlpath );
				break;
			case ImageDocElementPosition.RIGHT:
				((GLib.FileStream)res).printf ( "<img src=\"%s\" align=\"right\"/>", this.htmlpath );
				break;
			case ImageDocElementPosition.LEFT:
				((GLib.FileStream)res).printf ( "<img src=\"%s\" align=\"left\" />", this.htmlpath );
				break;
			}
			return true;
		}
	}
}


[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
	return typeof ( Valadoc.Html.ImageDocElement );
}

