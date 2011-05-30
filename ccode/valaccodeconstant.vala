/* valaccodeconstant.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * A constant C expression.
 */
public class Vala.CCodeConstant : CCodeExpression {
	/**
	 * The name of this constant.
	 */
	public string name { get; set; }

	public CCodeConstant (string _name) {
		name = _name;
	}

	const int LINE_LENGTH = 70;

	public CCodeConstant.string (string _name) {
		assert (_name[0] == '\"');

		if (_name.length <= LINE_LENGTH) {
			name = _name;
			return;
		}

		var builder = new StringBuilder ("\"");

		char* p = _name;
		char* end = p + _name.length;

		// remove quotes
		p++;
		end--;

		int col = 0;
		while (p < end) {
			if (col >= LINE_LENGTH) {
				builder.append ("\" \\\n\"");
				col = 0;
			}
			if (*p == '\\') {
				char* begin_of_char = p;

				builder.append_c (p[0]);
				builder.append_c (p[1]);
				p += 2;
				switch (p[-1]) {
				case 'x':
					// hexadecimal character
					while (p < end && p->isxdigit ()) {
						builder.append_c (*p);
						p++;
					}
					break;
				case '0':
				case '1':
				case '2':
				case '3':
				case '4':
				case '5':
				case '6':
				case '7':
					// octal character
					while (p < end && p - begin_of_char <= 3 && *p >= '0' && *p <= '7') {
						builder.append_c (*p);
						p++;
					}
					break;
				case 'n':
					// break line at \n
					col = LINE_LENGTH;
					break;
				}
				col += (int) (p - begin_of_char);
			} else {
				builder.append_unichar (((string) p).get_char ());
				p += ((char*) ((string) p).next_char () - p);
				col++;
			}
		}

		builder.append_c ('"');

		this.name = builder.str;
	}

	public override void write (CCodeWriter writer) {
		writer.write_string (name);
	}
}
