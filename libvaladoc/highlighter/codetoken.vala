/* codetoken.vala
 *
 * Copyright (C) 2015       Florian Brosch
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


public class Valadoc.Highlighter.CodeToken {
	public CodeTokenType token_type { get; private set; }
	public string content { get; private set;}

	public CodeToken (CodeTokenType type, string content) {
		this.token_type = type;
		this.content = content;
	}
}


public enum Valadoc.Highlighter.CodeTokenType {
	XML_ESCAPE,
	XML_ELEMENT,
	XML_ATTRIBUTE,
	XML_ATTRIBUTE_VALUE,
	XML_COMMENT,
	XML_CDATA,

	PREPROCESSOR,
	COMMENT,
	KEYWORD,
	LITERAL,
	ESCAPE,
	PLAIN,
	TYPE,
	EOF;

	public unowned string to_string () {
        EnumClass enumc = (EnumClass) typeof (CodeTokenType).class_ref ();
        unowned EnumValue? eval = enumc.get_value (this);
        return_val_if_fail (eval != null, null);
        return eval.value_nick;
	}
}
