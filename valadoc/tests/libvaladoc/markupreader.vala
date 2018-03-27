/* markupreader.vala
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


public static void positive_1 () {
	var reporter = new ErrorReporter ();

	string content =
"""<?xml version="1.0" ?>
<root-element>
	<subelement level="1" nested="true">my text</subelement>
	<simpletag1 level="2" nested="false" />
	<simpletag2 level="3"/>
	<simpletag3/>
</root-element>""";


	var reader = new Vala.MarkupReader.from_string ("testfile", content);
	assert (reader.filename == "testfile");

	Vala.SourceLocation begin;
	Vala.SourceLocation end;
	Vala.MarkupTokenType token;


	token = reader.read_token (out begin, out end);
	token = reader.read_token (out begin, out end);


	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.START_ELEMENT);
	assert (reader.name == "root-element");
	assert (reader.content == null);
	assert (reader.get_attributes ().size == 0);
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 2);
	assert (end.line == 2);

	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.START_ELEMENT);
	assert (reader.name == "subelement");
	assert (reader.content == null);
	assert (reader.get_attributes ().size == 2);
	assert (reader.get_attribute ("nested") == "true");
	assert (reader.get_attribute ("level") == "1");
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 3);
	assert (end.line == 3);

	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.TEXT);
	assert (reader.name == null);
	assert (reader.content == "my text");
	assert (reader.get_attributes ().size == 0);
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 3);
	assert (end.line == 3);

	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.END_ELEMENT);
	assert (reader.name == "subelement");
	assert (reader.content == null);
	assert (reader.get_attributes ().size == 0);
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 3);
	assert (end.line == 3);

	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.START_ELEMENT);
	assert (reader.name == "simpletag1");
	assert (reader.content == null);
	assert (reader.get_attributes ().size == 2);
	assert (reader.get_attribute ("nested") == "false");
	assert (reader.get_attribute ("level") == "2");
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 4);
	assert (end.line == 4);

	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.END_ELEMENT);
	assert (reader.name == "simpletag1");
	assert (reader.content == null);
	assert (reader.get_attributes ().size == 0);
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 4);
	assert (end.line == 4);

	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.START_ELEMENT);
	assert (reader.name == "simpletag2");
	assert (reader.content == null);
	assert (reader.get_attributes ().size == 1);
	assert (reader.get_attribute ("level") == "3");
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 5);
	assert (end.line == 5);

	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.END_ELEMENT);
	assert (reader.name == "simpletag2");
	assert (reader.content == null);
	assert (reader.get_attributes ().size == 0);
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 5);
	assert (end.line == 5);

	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.START_ELEMENT);
	assert (reader.name == "simpletag3");
	assert (reader.content == null);
	assert (reader.get_attributes ().size == 0);
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 6);
	assert (end.line == 6);

	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.END_ELEMENT);
	assert (reader.name == "simpletag3");
	assert (reader.content == null);
	assert (reader.get_attributes ().size == 0);
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 6);
	assert (end.line == 6);

	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.END_ELEMENT);
	assert (reader.name == "root-element");
	assert (reader.content == null);
	assert (reader.get_attributes ().size == 0);
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 7);
	assert (end.line == 7);

	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.EOF);
	assert (reader.name == null);
	assert (reader.content == null);
	assert (reader.get_attributes ().size == 0);
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 7);
	assert (end.line == 7);
}


public static void positive_2 () {
	var reporter = new ErrorReporter ();

	string content = "AA BB &amp; &quot;&apos; &lt; &gt; &percnt;";

	var reader = new Vala.MarkupReader.from_string ("testfile", content);
	assert (reader.filename == "testfile");

	Vala.SourceLocation begin;
	Vala.SourceLocation end;
	Vala.MarkupTokenType token;

	token = reader.read_token (out begin, out end);
	assert (token == Vala.MarkupTokenType.TEXT);
	assert (reader.content == "AA BB & \"' < > %");
	assert (reader.name == null);
	assert (reader.get_attributes ().size == 0);
	assert (reporter.warnings == 0);
	assert (reporter.errors == 0);
	assert (begin.line == 1);
	assert (end.line == 1);

}


public static void main () {
	positive_1 ();
	positive_2 ();
}

