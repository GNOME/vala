/* utils.vala
 *
 * Copyright (C) 2010 Luca Bruno
 * Copyright (C) 2007-2009  Jürg Billeter
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
 * 	Luca Bruno <lethalman88@gmail.com>
 */

using Valadoc;
using Valadoc.Api;
using Valadoc.Content;

namespace Gtkdoc {
	public string get_section (string filename) {
		long dot = filename.pointer_to_offset (filename.rchr (-1, '.'));
		return Path.get_basename (filename.substring (0, dot));
	}

	public string commentize (string comment) {
		return string.joinv ("\n * ", comment.split ("\n"));
	}

	public string? get_cname (Api.Item item)
	{
		if (item is Api.Method) {
			return ((Api.Method)item).get_cname ();
		} else if (item is Api.FormalParameter) {
			return ((Api.FormalParameter)item).name;
		} else if (item is Api.Constant) {
			return ((Api.Constant)item).get_cname ();
		} else if (item is Api.Property) {
			return ((Api.Property)item).get_cname ();
		} else if (item is Api.Signal) {
			var name = ((Api.Signal)item).get_cname ();
			return name.replace ("_", "-");
		} else if (item is Api.Class) {
			return ((Api.Class)item).get_cname ();
		} else if (item is Api.Struct) {
			return ((Api.Struct)item).get_cname ();
		} else if (item is Api.Interface) {
			return ((Api.Interface)item).get_cname ();
		} else if (item is Api.ErrorDomain) {
			return ((Api.ErrorDomain)item).get_cname ();
		} else if (item is Api.ErrorCode) {
			return ((Api.ErrorCode)item).get_cname ();
		} else if (item is Api.Delegate) {
			return ((Api.Delegate)item).get_cname ();
		} else if (item is Api.Enum) {
			return ((Api.Enum)item).get_cname ();
		}
		return null;
	}

	public string? get_dbus_interface (Api.Item item) {
		if (item is Api.Class) {
			return ((Api.Class)item).get_dbus_name ();
		} else if (item is Api.Interface) {
			return ((Api.Interface)item).get_dbus_name ();
		}
		return null;
	}

	public string? get_docbook_link (Api.Item item, bool is_dbus = false, bool is_async_finish = false) {
		if (item is Api.Method) {
			string name;
			string parent;
			if (is_dbus) {
				name = ((Api.Method)item).get_dbus_name ();
				parent = "%s-".printf (get_dbus_interface (item.parent));
			} else {
				if (!is_async_finish) {
					name = ((Api.Method)item).get_cname ();
				} else {
					name = ((Api.Method)item).get_finish_function_cname ();
				}
				parent = "";
			}
			return """<link linkend="%s%s"><function>%s()</function></link>""".printf (to_docbook_id (parent), to_docbook_id (name), name);
		} else if (item is Api.FormalParameter) {
			return "<parameter>%s</parameter>".printf (((Api.FormalParameter)item).name);
		} else if (item is Api.Constant) {
			var cname = ((Api.Constant)item).get_cname ();
			return """<link linkend="%s:CAPS"><literal>%s</literal></link>""".printf (to_docbook_id (cname), cname);
		} else if (item is Api.Property) {
			string name;
			string parent;
			if (is_dbus) {
				name = ((Api.Property)item).get_dbus_name ();
				parent = get_dbus_interface (item.parent);
			} else {
				name = ((Api.Property)item).get_cname ();
				parent = get_cname (item.parent);
			}
			return """<link linkend="%s--%s"><type>"%s"</type></link>""".printf (to_docbook_id (parent), to_docbook_id (name), name);
		} else if (item is Api.Signal) {
			string name;
			string parent;
			if (is_dbus) {
				name = ((Api.Signal)item).get_dbus_name ();
				parent = get_dbus_interface (item.parent);
			} else {
				name = ((Api.Signal)item).get_cname ();
				name = name.replace ("_", "-");
				parent = get_cname (item.parent);
			}
			return """<link linkend="%s-%s"><type>"%s"</type></link>""".printf (to_docbook_id (parent), to_docbook_id (name), name);
		} else {
			var cname = get_cname (item);
			if (cname != null) {
				return """<link linkend="%s"><type>%s</type></link>""".printf (to_docbook_id (cname), cname);
			}
		}
		return null;
	}

	public string to_lower_case (string camel) {
		var builder = new StringBuilder ();
		bool last_upper = true;
		for (int i=0; i < camel.length; i++) {
			if (camel[i].isupper ()) {
				if (!last_upper) {
					builder.append_c ('_');
				}
				builder.append_unichar (camel[i].tolower ());
				last_upper = true;
			} else {
				builder.append_unichar (camel[i]);
				last_upper = false;
			}
		}
		return builder.str;
	}

	public string to_docbook_id (string name) {
		return name.replace(".", "-").replace("_", "-");
	}

	public bool package_exists (string package_name) {
		// copied from vala/codegen/valaccodecompiler.vala
		string pc = "pkg-config --exists " + package_name;
		int exit_status;

		try {
			Process.spawn_command_line_sync (pc, null, null, out exit_status);
			return (0 == exit_status);
		} catch (SpawnError e) {
			warning ("GtkDoc: Error pkg-config --exists %s: %s", package_name, e.message);
			return false;
		}
	}
}


public class Gtkdoc.TextWriter {
	public string filename;
	public string mode;

	private FileStream? stream;

	public TextWriter (string filename, string mode) {
		this.filename = filename;
		this.mode = mode;
	}

	public bool open () {
		stream = FileStream.open (filename, mode);
		return stream != null;
	}

	public void close () {
		stream = null;
	}
	
	public void write_line (string line) {
		stream.puts (line);
		stream.putc ('\n');
	}
}
