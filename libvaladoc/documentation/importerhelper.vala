/* importhelper.vala
 *
 * Copyright (C) 2014 Florian Brosch
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
 *  Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc.Content;

namespace Valadoc.ImporterHelper {

	//
	// resolve-parameter-ctype:
	//

	internal string? resolve_parameter_ctype (Api.Tree tree, Api.Node element, string parameter_name,
		out string? param_name, out string? param_array_name, out bool is_return_type_len)
	{
		string[]? parts = split_type_name (parameter_name);
		is_return_type_len = false;
		param_array_name = null;

		Api.Parameter? param = null; // type parameter or formal parameter
		foreach (Api.Node node in element.get_children_by_type (Api.NodeType.FORMAL_PARAMETER, false)) {
			if (node.name == parts[0]) {
				param = node as Api.Parameter;
				break;
			}

			if (((Api.Parameter) node).implicit_array_length_cparameter_name == parts[0]) {
				param_array_name = ((Api.Parameter) node).name;
				break;
			}
		}

		if (element is Api.Callable
			&& ((Api.Callable) element).implicit_array_length_cparameter_name == parts[0])
		{
			is_return_type_len = true;
		}

		if (parts.length == 1) {
			param_name = parameter_name;
			return null;
		}


		Api.Item? inner = null;

		if (param_array_name != null || is_return_type_len) {
			inner = tree.search_symbol_str (null, "int");
		} else if (param != null) {
			inner = param.parameter_type;
		}

		while (inner != null) {
			if (inner is Api.TypeReference) {
				inner = ((Api.TypeReference) inner).data_type;
			} else if (inner is Api.Pointer) {
				inner = ((Api.Pointer) inner).data_type;
			} else if (inner is Api.Array) {
				inner = ((Api.Array) inner).data_type;
			} else {
				break ;
			}
		}


		if (inner == null) {
			param_name = parameter_name;
			return null;
		}

		string? cname = null;
		if (inner is Api.ErrorDomain) {
			cname = ((Api.ErrorDomain) inner).get_cname ();
		} else if (inner is Api.Struct) {
			cname = ((Api.Struct) inner).get_cname ();
		} else if (inner is Api.Class) {
			cname = ((Api.Class) inner).get_cname ();
		} else if (inner is Api.Enum) {
			cname = ((Api.Enum) inner).get_cname ();
		} else {
			assert_not_reached ();
		}

		param_name = (owned) parts[0];
		return "c::" + cname + parts[1] + parts[2];
	}


	private string[]? split_type_name (string id) {
		unichar c;

		for (unowned string pos = id; (c = pos.get_char ()) != '\0'; pos = pos.next_char ()) {
			switch (c) {
			case '-': // ->
				return {id.substring (0, (long) (((char*) pos) - ((char*) id))), "->", (string) (((char*) pos) + 2)};

			case ':': // : or ::
				string sep = (pos.next_char ().get_char () == ':')? "::" : ":";
				return {id.substring (0, (long) (((char*) pos) - ((char*) id))), sep, (string) (((char*) pos) + sep.length)};

			case '.':
				return {id.substring (0, (long) (((char*) pos) - ((char*) id))), ".", (string) (((char*) pos) + 1)};
			}
		}

		return {id};
	}



	//
	// extract-short-desc:
	//

	internal void extract_short_desc (Comment comment, ContentFactory factory) {
		if (comment.content.size == 0) {
			return ;
		}

		Paragraph? first_paragraph = comment.content[0] as Paragraph;
		if (first_paragraph == null) {
			// add empty paragraph to avoid non-text as short descriptions
			comment.content.insert (1, factory.create_paragraph ());
			return ;
		}


		// avoid fancy stuff in short descriptions:
		first_paragraph.horizontal_align = HorizontalAlign.NONE;
		first_paragraph.vertical_align = VerticalAlign.NONE;
		first_paragraph.style = null;


		Paragraph? second_paragraph = split_paragraph (first_paragraph, factory);
		if (second_paragraph == null) {
			return ;
		}

		if (second_paragraph.is_empty () == false) {
			comment.content.insert (1, second_paragraph);
		}
	}

	private inline Text? split_text (Text text, ContentFactory factory) {
		int offset = 0;
		while ((offset = text.content.index_of_char ('.', offset)) >= 0) {
			if (offset >= 2) {
				// ignore "e.g."
				unowned string cmp4 = ((string) (((char*) text.content) + offset - 2));
				if (cmp4.has_prefix (" e.g.") || cmp4.has_prefix ("(e.g.")) {
					offset = offset + 3;
					continue;
				}

				// ignore "i.e."
				if (cmp4.has_prefix (" i.e.") || cmp4.has_prefix ("(i.e.")) {
					offset = offset + 3;
					continue;
				}
			}

			unowned string cmp0 = ((string) (((char*) text.content) + offset));

			// ignore ... (varargs)
			if (cmp0.has_prefix ("...")) {
				offset = offset + 3;
				continue;
			}

			// ignore numbers
			if (cmp0.get (1).isdigit ()) {
				offset = offset + 2;
				continue;
			}


			Text sec = factory.create_text (text.content.substring (offset+1, -1));
			text.content = text.content.substring (0, offset+1);
			return sec;
		}

		return null;
	}

	private inline Run? split_run (Run run, ContentFactory factory) {
		if (run.style != Run.Style.NONE) {
			return null;
		}

		Run? sec = null;


		Vala.Iterator<Inline> iter = run.content.iterator ();
		for (bool has_next = iter.next (); has_next; has_next = iter.next ()) {
			Inline item = iter.get ();
			if (sec == null) {
				Inline? tmp = split_inline (item, factory);
				if (tmp != null) {
					sec = factory.create_run (run.style);
					sec.content.add (tmp);
				}
			} else {
				sec.content.add (item);
				iter.remove ();
			}
		}

		return sec;
	}

	private inline Inline? split_inline (Inline item, ContentFactory factory) {
		if (item is Text) {
			return split_text ((Text) item, factory);
		} else if (item is Run) {
			return split_run ((Run) item, factory);
		}

		return null;
	}

	private inline Paragraph? split_paragraph (Paragraph p, ContentFactory factory) {
		Paragraph? sec = null;

		Vala.Iterator<Inline> iter = p.content.iterator ();
		for (bool has_next = iter.next (); has_next; has_next = iter.next ()) {
			Inline item = iter.get ();
			if (sec == null) {
				Inline? tmp = split_inline (item, factory);
				if (tmp != null) {
					sec = factory.create_paragraph ();
					sec.horizontal_align = p.horizontal_align;
					sec.vertical_align = p.vertical_align;
					sec.style = p.style;
					sec.content.add (tmp);
				}
			} else {
				sec.content.add (item);
				iter.remove ();
			}
		}

		return sec;
	}

}
