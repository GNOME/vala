/* moduleloader.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Brosch Florian <flo.brosch@gmail.com>
 */

using GLib.Path;
using Gee;


[CCode (has_target = false)]
public delegate  void Valadoc.TagletRegisterFunction (ModuleLoader loader);


public class Valadoc.ModuleLoader : Object {
	public Doclet doclet;

	public HashMap<string, GLib.Type> taglets = new HashMap<string, Type> (GLib.str_hash, GLib.str_equal);

	private Module docletmodule;
	private Type doclettype;

	public bool load (string path) {
		bool tmp = this.load_doclet (path);
		if (tmp == false) {
			return false;
		}
		return true;
	}

	public Content.Taglet? create_taglet (string keyword) {
		return (taglets.has_key (keyword))? (Content.Taglet) GLib.Object.new (taglets.get (keyword)) : null;
	}

	private bool load_doclet (string path) {
		void* function;

		docletmodule = Module.open ( build_filename(path, "libdoclet.so"), ModuleFlags.BIND_LAZY);
		if (docletmodule == null) {
			return false;
		}

		docletmodule.symbol("register_plugin", out function);
		if (function == null) {
			return false;
		}

		Valadoc.DocletRegisterFunction doclet_register_function = (Valadoc.DocletRegisterFunction) function;
		doclettype = doclet_register_function ();
		this.doclet = (Doclet)GLib.Object.new (doclettype);
		return true;
	}
}

