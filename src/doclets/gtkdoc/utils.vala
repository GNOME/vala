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

	private string? get_reference (Api.Node symbol) {
		if (symbol is Api.Method) {
			return "%s()".printf (((Api.Method)symbol).get_cname ());
		} else if (symbol is Api.FormalParameter) {
			return "@%s".printf (((Api.FormalParameter)symbol).name);
		} else if (symbol is Api.Constant) {
			return "%%%s".printf (((Api.Constant)symbol).get_cname ());
		} else if (symbol is Api.Signal) {
			return "::%s".printf (((Api.Signal)symbol).get_cname ());
		} else if (symbol is Api.Class) {
			return "#%s".printf (((Api.Class)symbol).get_cname ());
		} else if (symbol is Api.Struct) {
			return "#%s".printf (((Api.Struct)symbol).get_cname ());
		} else if (symbol is Api.Interface) {
			return "#%s".printf (((Api.Interface)symbol).get_cname ());
		} else if (symbol is Api.ErrorDomain) {
			return "#%s".printf (((Api.ErrorDomain)symbol).get_cname ());
		} else if (symbol is Api.ErrorCode) {
			return "#%s".printf (((Api.ErrorCode)symbol).get_cname ());
		} else if (symbol is Api.Delegate) {
			return "#%s".printf (((Api.Delegate)symbol).get_cname ());
		} else if (symbol is Api.Enum) {
			return "#%s".printf (((Api.Enum)symbol).get_cname ());
		}
		return null;
	}
}


public class Gtkdoc.TextWriter {
	public string filename;

	private FileStream? stream;

	public TextWriter (string filename) {
		this.filename = filename;
	}

	public bool open () {
		stream = FileStream.open (filename, "a");
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

