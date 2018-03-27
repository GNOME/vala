/* gtkdocindexsgmlreader.vala
 *
 * Copyright (C) 2014  Florian Brosch
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


using Valadoc;

public class Valadoc.Importer.InternalIdRegistrar {
	private Vala.HashMap<string, Api.Node> symbol_map;
	private Vala.HashMap<string, string> map;


	public InternalIdRegistrar () {
		map = new Vala.HashMap<string, string> (str_hash, str_equal);
		symbol_map = new Vala.HashMap<string, Api.Node> (str_hash, str_equal);
	}


	public void register_symbol (string id, Api.Node symbol) {
		this.symbol_map.set (id, symbol);
	}

	public string? map_url_id (string id) {
		return map.get (id);
	}

	public Api.Node? map_symbol_id (string id) {
		return symbol_map.get (id);
	}


	public void read_index_sgml_file (string filename, string? index_sgml_online, ErrorReporter reporter) {
		Vala.SourceLocation begin;
		Vala.SourceLocation end;
		Vala.MarkupTokenType token;

		string base_path = index_sgml_online ?? Vala.CodeContext.realpath (filename);
		var reader = new Vala.MarkupReader (filename);

		while ((token = reader.read_token (out begin, out end)) != Vala.MarkupTokenType.EOF) {
			if (token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "ONLINE") {
				if (index_sgml_online == null) {
					base_path = reader.get_attribute ("href");
					if (base_path == null) {
						//reporter.error (filename, begin.line, begin.column, end.column, reader.get_line_content (begin.line), "missing attribute `href' in <ONLINE>");
						Vala.Report.error (null, "missing attribute `href' in <ONLINE>");
					}
				}
			} else if (token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "ANCHOR") {
				string id = reader.get_attribute ("id");
				if (id == null) {
					//reporter.error (filename, begin.line, begin.column, end.column, reader.get_line_content (begin.line), "missing attribute `id' in <ANCHOR>");
					Vala.Report.error (null, "missing attribute `id' in <ANCHOR>");
				}

				string href = reader.get_attribute ("href");
				if (href == null) {
					//reporter.error (filename, begin.line, begin.column, end.column, reader.get_line_content (begin.line), "missing attribute `href' in <ANCHOR>");
					Vala.Report.error (null, "missing attribute `href' in <ANCHOR>");
				} else if (index_sgml_online != null) {
					href = Path.get_basename (href);
				}

				map.set (id, Path.build_path ("/", base_path, href));
			} else {
				//reporter.error (filename, begin.line, begin.column, end.column, reader.get_line_content (begin.line), "expected element of <ONLINE> or <ANCHOR>");
				Vala.Report.error (null, "expected element of <ONLINE> or <ANCHOR>");
			}
		}
	}
}


