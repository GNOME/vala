/* utils.vala
 *
 * Copyright (C) 2010 Luca Bruno
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

	public string? get_creference (Api.Item item) {
		if (item is Api.Method) {
			return "%s()".printf (((Api.Method)item).get_cname ());
		} else if (item is Api.FormalParameter) {
			return "@%s".printf (((Api.FormalParameter)item).name);
		} else if (item is Api.Constant) {
			return "%%%s".printf (((Api.Constant)item).get_cname ());
		} else if (item is Api.Signal) {
			var name = ((Api.Signal)item).get_cname ();
			name = name.replace ("_", "-");
			return "#%s::%s".printf (get_cname (item.parent), name);
		} else {
			var cname = get_cname (item);
			if (cname != null) {
				return "#%s".printf (cname);
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

