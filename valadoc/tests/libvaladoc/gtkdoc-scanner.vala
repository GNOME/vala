/* gtkdoc-scanner.vala
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


void main () {
	var scanner = new Gtkdoc.Scanner ();
	scanner.reset ("""<element1>
<element2 a="a-val" b="b-val">
</element3>
<element4 />
<element5 a="a-val" b="b-val"/>
<!---->
<!--
AAAA
-->
foo_bar ()
%aaa
@param
#TypeName
myword      

|[]|
::my-signal
:my-property
""");

	var token = scanner.next ();

	assert (token.type == Gtkdoc.TokenType.XML_OPEN);
	assert (token.content == "element1");
	assert (((Vala.Map) token.attributes).size == 0);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.XML_OPEN);
	assert (token.content == "element2");
	assert (token.attributes.get ("a") == "a-val");
	assert (token.attributes.get ("b") == "b-val");
	assert (((Vala.Map) token.attributes).size == 2);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.XML_CLOSE);
	assert (token.content == "element3");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.XML_OPEN);
	assert (token.content == "element4");
	assert (((Vala.Map) token.attributes).size == 0);

	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.XML_CLOSE);
	assert (token.content == "element4");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.XML_OPEN);
	assert (token.content == "element5");
	assert (token.attributes.get ("a") == "a-val");
	assert (token.attributes.get ("b") == "b-val");
	assert (((Vala.Map) token.attributes).size == 2);

	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.XML_CLOSE);
	assert (token.content == "element5");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.XML_COMMENT);
	assert (token.content == "");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.XML_COMMENT);
	assert (token.content == "");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.GTKDOC_FUNCTION);
	assert (token.content == "foo_bar");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.GTKDOC_CONST);
	assert (token.content == "aaa");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.GTKDOC_PARAM);
	assert (token.content == "param");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.GTKDOC_TYPE);
	assert (token.content == "TypeName");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.WORD);
	assert (token.content == "myword");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.SPACE);
	assert (token.content == "      ");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.GTKDOC_PARAGRAPH);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.GTKDOC_SOURCE_OPEN);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.GTKDOC_SOURCE_CLOSE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.GTKDOC_SIGNAL);
	assert (token.content == "my-signal");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.GTKDOC_PROPERTY);
	assert (token.content == "my-property");
	assert (token.attributes == null);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.NEWLINE);


	token = scanner.next ();
	assert (token.type == Gtkdoc.TokenType.EOF);

}
