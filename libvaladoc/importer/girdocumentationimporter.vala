/* girdocumentationimporter.vala
 *
 * Copyright (C) 2008-2010  Jürg Billeter
 * Copyright (C) 2011       Luca Bruno
 * Copyright (C) 2011-2014  Florian Brosch
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
 * 	Jürg Billeter <j@bitron.ch>
 * 	Luca Bruno <lucabru@src.gnome.org>
 *  Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc;

public class Valadoc.Importer.GirDocumentationImporter : DocumentationImporter {
	public override string file_extension {
		get {
			return "gir";
		}
	}

	private Vala.MarkupTokenType current_token;
	private Vala.SourceLocation begin;
	private Vala.SourceLocation end;
	private Vala.MarkupReader reader;

	private DocumentationParser parser;
	private Api.SourceFile file;

	private string parent_c_identifier;

	private struct ImplicitParameterPos {
		public int parameter;
		public int position;

		public ImplicitParameterPos (int parameter, int position) {
			this.parameter = parameter;
			this.position = position;
		}
	}

	public GirDocumentationImporter (Api.Tree tree, DocumentationParser parser,
									 ModuleLoader modules, Settings settings,
									 ErrorReporter reporter)
	{
		base (tree, modules, settings);
		this.parser = parser;
	}

	public override void process (string source_file) {
		var data = new Vala.SourceFile (tree.context, Vala.SourceFileType.PACKAGE, Path.get_basename (source_file));
		this.file = new Api.SourceFile (new Api.Package (Path.get_basename (source_file), true, null),
										source_file, null, data);
		this.reader = new Vala.MarkupReader (source_file);

		// xml prolog
		do {
			next ();
			if (current_token == Vala.MarkupTokenType.EOF) {
				error ("unexpected end of file");
				return;
			}
		} while (current_token != Vala.MarkupTokenType.START_ELEMENT && reader.name != "repository");

		parse_repository ();

		reader = null;
		file = null;
	}

	private Api.Parameter? find_parameter (Api.Node node, string name) {
		Vala.List<Api.Node> parameters = node.get_children_by_type (Api.NodeType.FORMAL_PARAMETER, false);
		foreach (Api.Node param in parameters) {
			if (((Api.Parameter) param).name == name) {
				return (Api.Parameter) param;
			}
		}

		return null;
	}

	private inline string? get_cparameter_name (string[] param_names, int length_pos) {
		if (length_pos < 0 || param_names.length < length_pos) {
			return null;
		}

		return param_names[length_pos];
	}

	private void attach_comment (string cname,
								 Api.GirSourceComment? comment,
								 string[]? param_names = null,
								 ImplicitParameterPos[]? destroy_notifies = null,
								 ImplicitParameterPos[]? closures = null,
								 ImplicitParameterPos[]? array_lengths = null,
								 int array_length_ret = -1)
	{
		if (comment == null) {
			return ;
		}

		Api.Node? node = this.tree.search_symbol_cstr (null, cname);
		if (node == null) {
			return;
		}

		if (param_names != null) {
			foreach (ImplicitParameterPos pos in destroy_notifies) {
				Api.Parameter? param = find_parameter (node, param_names[pos.parameter]);
				if (param == null) {
					continue ;
				}

				param.implicit_destroy_cparameter_name
					= get_cparameter_name (param_names, pos.position);
			}

			foreach (ImplicitParameterPos pos in closures) {
				Api.Parameter? param = find_parameter (node, param_names[pos.parameter]);
				if (param == null) {
					continue ;
				}

				param.implicit_closure_cparameter_name
					= get_cparameter_name (param_names, pos.position);
			}

			foreach (ImplicitParameterPos pos in array_lengths) {
				Api.Parameter? param = find_parameter (node, param_names[pos.parameter]);
				if (param == null) {
					continue ;
				}

				param.implicit_array_length_cparameter_name
					= get_cparameter_name (param_names, pos.position);
			}

			if (node is Api.Callable) {
				((Api.Callable) node).implicit_array_length_cparameter_name
					= get_cparameter_name (param_names, array_length_ret);
			}
		}

		Content.Comment? content = this.parser.parse (node, comment);
		if (content == null) {
			return;
		}

		node.documentation = content;
	}

	private void warning (string message) {
		Vala.Report.warning (new Vala.SourceReference ((Vala.SourceFile) file.data, begin, end), message);
	}

	private void error (string message) {
		Vala.Report.error (new Vala.SourceReference ((Vala.SourceFile) file.data, begin, end), message);
	}

	private void next () {
		current_token = reader.read_token (out begin, out end);

		// Skip <annotation /> (only generated by valac)
		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "annotation") {
			next (); // MarkupTokenType.END_ELEMENT, annotation
			next ();
		}
	}

	private void start_element (string name) {
		if (current_token != Vala.MarkupTokenType.START_ELEMENT || reader.name != name) {
			// error
			error ("expected start element of `%s'".printf (name));
		}
	}

	private void end_element (string name) {
		if (current_token != Vala.MarkupTokenType.END_ELEMENT || reader.name != name) {
			// error
			error ("expected end element of `%s'".printf (name));
		}
		next ();
	}

	private const string GIR_VERSION = "1.2";

	private void parse_repository () {
		start_element ("repository");
		if (reader.get_attribute ("version") != GIR_VERSION) {
			error ("unsupported GIR version %s (supported: %s)"
				.printf (reader.get_attribute ("version"), GIR_VERSION));
			return;
		}
		next ();

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "namespace") {
				parse_namespace ();
			} else if (reader.name == "include") {
				parse_include ();
			} else if (reader.name == "package") {
				parse_package ();
			} else if (reader.name == "c:include") {
				parse_c_include ();
			} else {
				// error
				error ("unknown child element `%s' in `repository'".printf (reader.name));
				skip_element ();
			}
		}
		end_element ("repository");
	}

	private void parse_include () {
		start_element ("include");
		next ();

		end_element ("include");
	}

	private void parse_package () {
		start_element ("package");
		next ();

		end_element ("package");
	}

	private void parse_c_include () {
		start_element ("c:include");
		next ();

		end_element ("c:include");
	}

	private void skip_element () {
		next ();

		int level = 1;
		while (level > 0) {
			if (current_token == Vala.MarkupTokenType.START_ELEMENT) {
				level++;
			} else if (current_token == Vala.MarkupTokenType.END_ELEMENT) {
				level--;
			} else if (current_token == Vala.MarkupTokenType.EOF) {
				error ("unexpected end of file");
				break;
			}
			next ();
		}
	}

	private void parse_namespace () {
		start_element ("namespace");

		next ();
		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "alias") {
				parse_alias ();
			} else if (reader.name == "enumeration") {
				parse_enumeration ();
			} else if (reader.name == "bitfield") {
				parse_bitfield ();
			} else if (reader.name == "function") {
				parse_method ("function");
			} else if (reader.name == "function-macro") {
				skip_element ();
			} else if (reader.name == "callback") {
				parse_callback ();
			} else if (reader.name == "record") {
				parse_record ();
			} else if (reader.name == "class") {
				parse_class ();
			} else if (reader.name == "interface") {
				parse_interface ();
			} else if (reader.name == "glib:boxed") {
				parse_boxed ("glib:boxed");
			} else if (reader.name == "union") {
				parse_union ();
			} else if (reader.name == "constant") {
				parse_constant ();
			} else if (reader.name == "docsection") {
				// TODO Add docs to namespace
				skip_element ();
			} else {
				// error
				error ("unknown child element `%s' in `namespace'".printf (reader.name));
				skip_element ();
			}
		}

		end_element ("namespace");
	}

	private void parse_alias () {
		start_element ("alias");
		string c_identifier = reader.get_attribute ("c:type");
		next ();

		Api.GirSourceComment? comment = parse_symbol_doc ();
		attach_comment (c_identifier, comment);

		parse_type ();

		end_element ("alias");
	}

	private Api.GirSourceComment? parse_symbol_doc () {
		Api.GirSourceComment? comment = null;
		Api.SourceComment? doc_deprecated = null;
		Api.SourceComment? doc_version = null;
		Api.SourceComment? doc_stability = null;

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "doc") {
				start_element ("doc");
				next ();

				if (current_token == Vala.MarkupTokenType.TEXT) {
					comment = new Api.GirSourceComment (reader.content, file, begin.line,
														begin.column, end.line, end.column);
					next ();
				}

				end_element ("doc");
			} else if (reader.name == "doc-deprecated") {
				doc_deprecated = parse_doc ("doc-deprecated");
			} else if (reader.name == "doc-version") {
				doc_version = parse_doc ("doc-version");
			} else if (reader.name == "doc-stability") {
				doc_stability = parse_doc ("doc-stability");
			} else if (reader.name == "source-position") {
				skip_element ();
			} else if (reader.name == "attribute") {
				skip_element ();
			} else {
				break;
			}
		}

		if (comment != null) {
			comment.deprecated_comment = doc_deprecated;
			comment.version_comment = doc_version;
			comment.stability_comment = doc_stability;
		}

		return comment;
	}

	private Api.SourceComment? parse_doc (string element_name = "doc") {
		if (reader.name != element_name) {
			return null;
		}

		start_element (element_name);
		next ();

		Api.SourceComment? comment = null;

		if (current_token == Vala.MarkupTokenType.TEXT) {
			comment = new Api.SourceComment (reader.content, file, begin.line,
											 begin.column, end.line, end.column);
			next ();
		}

		end_element (element_name);
		return comment;
	}

	private void parse_enumeration (string element_name = "enumeration") {
		start_element (element_name);
		this.parent_c_identifier = reader.get_attribute ("c:type");
		next ();

		Api.GirSourceComment? comment = parse_symbol_doc ();
		attach_comment (this.parent_c_identifier, comment);

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "member") {
				parse_enumeration_member ();
			} else if (reader.name == "function") {
				skip_element ();
			} else {
				// error
				error ("unknown child element `%s' in `%s'".printf (reader.name, element_name));
				skip_element ();
			}
		}

		this.parent_c_identifier = null;
		end_element (element_name);
	}

	private void parse_bitfield () {
		parse_enumeration ("bitfield");
	}

	private void parse_enumeration_member () {
		start_element ("member");
		string c_identifier = reader.get_attribute ("c:identifier");
		next ();

		Api.GirSourceComment? comment = parse_symbol_doc ();
		attach_comment (c_identifier, comment);

		end_element ("member");
	}

	private void parse_return_value (out Api.SourceComment? comment, out int array_length_ret) {
		start_element ("return-value");
		next ();

		comment = parse_symbol_doc ();

		parse_type (out array_length_ret);

		end_element ("return-value");
	}

	private void parse_parameter (out Api.SourceComment? comment, out string param_name,
								  out int destroy_pos,
								  out int closure_pos, out int array_length_pos) {
		start_element ("parameter");
		param_name = reader.get_attribute ("name");
		array_length_pos = -1;
		destroy_pos = -1;
		closure_pos = -1;

		string? closure = reader.get_attribute ("closure");
		if (closure != null) {
			closure_pos = int.parse (closure);
			if (closure_pos < 0) {
				warning ("invalid closure position");
			}
		}

		string? destroy = reader.get_attribute ("destroy");
		if (destroy != null) {
			destroy_pos = int.parse (destroy);
			if (destroy_pos < 0) {
				warning ("invalid destroy position");
			}
		}
		next ();

		comment = parse_symbol_doc ();

		if (reader.name == "varargs") {
			start_element ("varargs");
			param_name = "...";
			next ();

			end_element ("varargs");
		} else {
			parse_type (out array_length_pos);
		}

		end_element ("parameter");
	}

	private void parse_type (out int array_length_pos = null) {
		array_length_pos = -1;

		if (reader.name == "array") {
			string? length = reader.get_attribute ("length");
			if (length != null) {
				array_length_pos = int.parse (length);
				if (array_length_pos < 0) {
					warning ("invalid array length position");
				}
			}

			skip_element ();
		} else {
			skip_element ();
		}
	}

	private void parse_record () {
		start_element ("record");
		this.parent_c_identifier = reader.get_attribute ("c:type");
		if (this.parent_c_identifier == null) {
			this.parent_c_identifier = reader.get_attribute ("glib:type-name");
		}
		if (this.parent_c_identifier.has_suffix ("Private")) {
			this.parent_c_identifier = null;
			skip_element ();
			return ;
		}

		bool is_type_struct = (reader.get_attribute ("glib:is-gtype-struct-for") != null);
		next ();

		Api.GirSourceComment? comment = parse_symbol_doc ();
		if (is_type_struct == false) {
			attach_comment (this.parent_c_identifier, comment);
		}

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				parse_method ("method");
			} else if (reader.name == "function") {
				skip_element ();
			} else if (reader.name == "union") {
				parse_union ();
			} else {
				// error
				error ("unknown child element `%s' in `record'".printf (reader.name));
				skip_element ();
			}
		}

		this.parent_c_identifier = null;
		end_element ("record");
	}

	private void parse_class () {
		start_element ("class");
		this.parent_c_identifier = reader.get_attribute ("c:type");
		if (this.parent_c_identifier == null) {
			this.parent_c_identifier = reader.get_attribute ("glib:type-name");
		}
		next ();

		Api.GirSourceComment? comment = parse_symbol_doc ();
		attach_comment (this.parent_c_identifier, comment);

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "implements") {
				skip_element ();
			} else if (reader.name == "constant") {
				parse_constant ();
			} else if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "property") {
				parse_property ();
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "function") {
				parse_method ("function");
			} else if (reader.name == "method") {
				parse_method ("method");
			} else if (reader.name == "virtual-method") {
				parse_method ("virtual-method");
			} else if (reader.name == "union") {
				parse_union ();
			} else if (reader.name == "glib:signal") {
				parse_signal ();
			} else {
				// error
				error ("unknown child element `%s' in `class'".printf (reader.name));
				skip_element ();
			}
		}

		this.parent_c_identifier = null;
		end_element ("class");
	}

	private void parse_interface () {
		start_element ("interface");
		this.parent_c_identifier = reader.get_attribute ("c:type");
		if (this.parent_c_identifier == null) {
			this.parent_c_identifier = reader.get_attribute ("glib:type-name");
		}
		next ();

		Api.GirSourceComment? comment = parse_symbol_doc ();
		attach_comment (this.parent_c_identifier, comment);

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "prerequisite") {
				skip_element ();
			} else if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "property") {
				parse_property ();
			} else if (reader.name == "virtual-method") {
				parse_method ("virtual-method");
			} else if (reader.name == "function") {
				parse_method ("function");
			} else if (reader.name == "method") {
				parse_method ("method");
			} else if (reader.name == "glib:signal") {
				parse_signal ();
			} else {
				// error
				error ("unknown child element `%s' in `interface'".printf (reader.name));
				skip_element ();
			}
		}

		this.parent_c_identifier = null;
		end_element ("interface");
	}

	private void parse_field () {
		start_element ("field");
		string c_identifier = reader.get_attribute ("name");
		if (this.parent_c_identifier != null) {
			c_identifier = this.parent_c_identifier + "." + c_identifier;
		}
		next ();

		parse_symbol_doc ();

		parse_type ();

		end_element ("field");
	}

	private void parse_property () {
		start_element ("property");
		string c_identifier = "%s:%s".printf (parent_c_identifier, reader.get_attribute ("name")
			.replace ("-", "_"));
		next ();

		Api.GirSourceComment? comment = parse_symbol_doc ();
		attach_comment (c_identifier, comment);

		parse_type ();

		end_element ("property");
	}

	private void parse_callback () {
		parse_function ("callback");
	}

	private void parse_constructor () {
		parse_function ("constructor");
	}

	private void parse_function (string element_name) {
		start_element (element_name);

		string? c_identifier = null;
		switch (element_name) {
		case "constructor":
		case "function":
		case "method":
			c_identifier = reader.get_attribute ("c:identifier");
			break;

		case "callback":
			c_identifier = reader.get_attribute ("c:type");
			if (c_identifier == null) {
				c_identifier = reader.get_attribute ("name");
			}
			break;

		case "virtual-method":
			c_identifier = "%s->%s".printf (this.parent_c_identifier, reader.get_attribute ("name")
				.replace ("-", "_"));
			break;

		case "glib:signal":
			c_identifier = "%s::%s".printf (this.parent_c_identifier, reader.get_attribute ("name")
				.replace ("-", "_"));
			break;

		default:
			skip_element ();
			return ;
		}

		next ();

		Api.GirSourceComment? comment = parse_symbol_doc ();

		ImplicitParameterPos[] destroy_notifies = new ImplicitParameterPos[0];
		ImplicitParameterPos[] array_lengths = new ImplicitParameterPos[0];
		ImplicitParameterPos[] closures = new ImplicitParameterPos[0];
		string[] param_names = new string[0];
		int array_length_ret = -1;

		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			Api.SourceComment? return_comment;
			parse_return_value (out return_comment, out array_length_ret);
			if (return_comment != null) {
				if (comment == null) {
					comment = new Api.GirSourceComment ("", file, begin.line, begin.column,
														end.line, end.column);
				}
				comment.return_comment = return_comment;
			}
		}


		if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();

			if (current_token == Vala.MarkupTokenType.START_ELEMENT && reader.name == "instance-parameter") {
				string instance_param_name = reader.get_attribute ("name");
				next ();

				Api.SourceComment? param_comment = parse_symbol_doc ();
				parse_type (null);
				end_element ("instance-parameter");

				if (param_comment != null) {
					if (comment == null) {
						comment = new Api.GirSourceComment ("", file, begin.line, begin.column,
															end.line, end.column);
					}

					comment.add_parameter_content (instance_param_name, param_comment);
					comment.instance_param_name = instance_param_name;
				}
			}

			for (int pcount = 0; current_token == Vala.MarkupTokenType.START_ELEMENT; pcount++) {
				Api.SourceComment? param_comment;
				int array_length_pos;
				int destroy_pos;
				int closure_pos;
				string? param_name;

				parse_parameter (out param_comment, out param_name, out destroy_pos,
								 out closure_pos, out array_length_pos);
				param_names += param_name;

				if (destroy_pos >= 0 && pcount != destroy_pos) {
					destroy_notifies += ImplicitParameterPos (pcount, destroy_pos);
				}

				if (closure_pos >= 0 && pcount != closure_pos) {
					closures += ImplicitParameterPos (pcount, closure_pos);
				}

				if (array_length_pos >= 0 && pcount != destroy_pos) {
					array_lengths += ImplicitParameterPos (pcount, array_length_pos);
				}

				if (param_comment != null) {
					if (comment == null) {
						comment = new Api.GirSourceComment ("", file, begin.line, begin.column,
															end.line, end.column);
					}

					comment.add_parameter_content (param_name, param_comment);
				}
			}
			end_element ("parameters");
		}

		attach_comment (c_identifier, comment, param_names, destroy_notifies, closures,
						array_lengths, array_length_ret);

		end_element (element_name);
	}

	private void parse_method (string element_name) {
		parse_function (element_name);
	}

	private void parse_signal () {
		parse_function ("glib:signal");
	}

	private void parse_boxed (string element_name) {
		start_element (element_name);

		this.parent_c_identifier = reader.get_attribute ("name");
		if (this.parent_c_identifier == null) {
			this.parent_c_identifier = reader.get_attribute ("glib:name");
		}

		next ();

		parse_symbol_doc ();

		// TODO: process comments

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				parse_method ("method");
			} else if (reader.name == "function") {
				skip_element ();
			} else if (reader.name == "union") {
				parse_union ();
			} else {
				// error
				error ("unknown child element `%s' in `class'".printf (reader.name));
				skip_element ();
			}
		}

		this.parent_c_identifier = null;
		end_element (element_name);
	}

	private void parse_union () {
		start_element ("union");
		this.parent_c_identifier = reader.get_attribute ("c:type");
		if (this.parent_c_identifier == null) {
			skip_element ();
			return ;
		}
		next ();

		Api.GirSourceComment? comment = parse_symbol_doc ();
		attach_comment (this.parent_c_identifier, comment);

		while (current_token == Vala.MarkupTokenType.START_ELEMENT) {
			if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				parse_method ("method");
			} else if (reader.name == "function") {
				skip_element ();
			} else if (reader.name == "record") {
				parse_record ();
			} else {
				// error
				error ("unknown child element `%s' in `union'".printf (reader.name));
				skip_element ();
			}
		}

		this.parent_c_identifier = null;
		end_element ("union");
	}

	private void parse_constant () {
		start_element ("constant");
		string c_identifier = reader.get_attribute ("c:identifier");
		if (c_identifier == null) {
			//TODO G-I seems to do this wrong
			c_identifier = reader.get_attribute ("c:type");
		}
		if (c_identifier == null) {
			skip_element ();
			return ;
		}
		next ();

		Api.GirSourceComment? comment = parse_symbol_doc ();
		attach_comment (c_identifier, comment);

		parse_type ();

		end_element ("constant");
	}
}

