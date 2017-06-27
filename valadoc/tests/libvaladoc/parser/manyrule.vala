/* manyrule.vala
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


public static void main () {
	var settings = new Valadoc.Settings ();
	var scanner = new TestScanner ();
	var reporter = new ErrorReporter ();
	var parser = new Parser (settings, scanner, reporter);
	scanner.set_parser (parser);

	Rule rule = Rule.many ({
			Valadoc.TokenType.EQUAL_1
		});



	// positive test:
	try {
		parser.set_root_rule (rule);

		scanner.set_pattern ({
				Valadoc.TokenType.EQUAL_1,
				Valadoc.TokenType.EQUAL_1,
				Valadoc.TokenType.EQUAL_1,
				Valadoc.TokenType.EQUAL_1
			});

		parser.parse ("", "", 0, 0);
	} catch (Error e) {
		assert_not_reached ();
	}


	// positive test:
	try {
		parser.set_root_rule (rule);

		scanner.set_pattern ({
				Valadoc.TokenType.EQUAL_1
			});

		parser.parse ("", "", 0, 0);
	} catch (Error e) {
		assert_not_reached ();
	}


	// negative test:
	bool reached = false;
	try {
		parser.set_root_rule (rule);
		reached = false;

		scanner.set_pattern ({
				Valadoc.TokenType.EQUAL_1,
				Valadoc.TokenType.EQUAL_1,
				Valadoc.TokenType.EQUAL_2
			});

		parser.parse ("", "", 0, 0);
	} catch (Error e) {
		reached = true;
	}

	assert (reached);
}


