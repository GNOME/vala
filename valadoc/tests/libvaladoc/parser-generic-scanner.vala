/* helpers.vala
 *
 * Copyright (C) 2012       Florian Brosch
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
 * 	Florian Brosch <flo.brosch@gmail.com>
 */

using Valadoc;


public class TestScanner : Object, Valadoc.Scanner {
	Valadoc.Parser parser;

	Valadoc.TokenType[] seq = {};
	bool _stop = false;
	int pos = 0;

	public void set_pattern (Valadoc.TokenType[] seq) {
		this.seq = seq;
	}

	private void emit_token (Valadoc.TokenType type) throws Valadoc.ParserError {
		Vala.SourceLocation loc = Vala.SourceLocation (null, pos, pos);
		parser.accept_token (new Token.from_type (type, loc, loc));
	}

	public void set_parser (Valadoc.Parser parser) {
		this.parser = parser;
	}

	public void reset () {
		_stop = false;
		pos = 0;
	}

	public void scan (string content) throws Valadoc.ParserError {
		while (!_stop && pos < seq.length) {
			emit_token (seq[pos]);
			pos++;
		}
	}

	public void end () throws Valadoc.ParserError {
		emit_token (Valadoc.TokenType.EOF);
	}

	public void stop () {
		_stop = true;
	}

	public string get_line_content () {
		return "";
	}
}

