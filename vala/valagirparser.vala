/* valagirparser.vala
 *
 * Copyright (C) 2008-2010  Jürg Billeter
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
 * Code visitor parsing all Vala source files.
 */
public class Vala.GirParser : CodeVisitor {
	enum MetadataType {
		GENERIC,
		PROPERTY,
		SIGNAL
	}

	enum ArgumentType {
		SKIP,
		HIDDEN,
		TYPE,
		TYPE_ARGUMENTS,
		CHEADER_FILENAME,
		NAME,
		OWNED,
		UNOWNED,
		PARENT,
		NULLABLE,
		DEPRECATED,
		REPLACEMENT,
		DEPRECATED_SINCE,
		ARRAY,
		ARRAY_LENGTH_POS,
		DEFAULT,
		OUT,
		REF;

		public static ArgumentType? from_string (string name) {
			var enum_class = (EnumClass) typeof(ArgumentType).class_ref ();
			var nick = name.replace ("_", "-");
			unowned GLib.EnumValue? enum_value = enum_class.get_value_by_nick (nick);
			if (enum_value != null) {
				ArgumentType value = (ArgumentType) enum_value.value;
				return value;
			}
			return null;
		}
	}

	class Argument {
		public Expression expression;
		public SourceReference source_reference;

		public bool used = false;

		public Argument (Expression expression, SourceReference? source_reference = null) {
			this.expression = expression;
			this.source_reference = source_reference;
		}
	}

	class MetadataSet : Metadata {
		public MetadataSet (MetadataType type) {
			base ("", type);
		}

		public void add_sibling (Metadata metadata) {
			foreach (var child in metadata.children) {
				add_child (child);
			}
			// merge arguments and take precedence
			foreach (var key in metadata.args.get_keys ()) {
				args[key] = metadata.args[key];
			}
		}
	}

	class Metadata {
		private static Metadata _empty = null;
		public static Metadata empty {
			get {
				if (_empty == null) {
					_empty = new Metadata ("");
				}
				return _empty;
			}
		}

		public string pattern;
		public PatternSpec pattern_spec;
		public MetadataType type;
		public SourceReference source_reference;

		public bool used = false;
		public Vala.Map<ArgumentType,Argument> args = new HashMap<ArgumentType,Argument> ();
		public ArrayList<Metadata> children = new ArrayList<Metadata> ();

		public Metadata (string pattern, MetadataType type = MetadataType.GENERIC, SourceReference? source_reference = null) {
			this.pattern = pattern;
			this.pattern_spec = new PatternSpec (pattern);
			this.type = type;
			this.source_reference = source_reference;
		}

		public void add_child (Metadata metadata) {
			children.add (metadata);
		}

		public Metadata? get_child (string pattern, MetadataType type = MetadataType.GENERIC) {
			foreach (var metadata in children) {
				if (metadata.type == type && metadata.pattern == pattern) {
					return metadata;
				}
			}
			return null;
		}

		public Metadata match_child (string name, MetadataType type = MetadataType.GENERIC) {
			var result = Metadata.empty;
			foreach (var metadata in children) {
				if (metadata.type == type && metadata.pattern_spec.match_string (name)) {
					metadata.used = true;
					if (result == Metadata.empty) {
						// first match
						result = metadata;
					} else {
						var ms = result as MetadataSet;
						if (ms == null) {
							// second match
							ms = new MetadataSet (type);
							ms.add_sibling (result);
						}
						ms.add_sibling (metadata);
						result = ms;
					}
				}
			}
			return result;
		}

		public void add_argument (ArgumentType key, Argument value) {
			args.set (key, value);
		}

		public bool has_argument (ArgumentType key) {
			return args.contains (key);
		}

		public Expression? get_expression (ArgumentType arg) {
			var val = args.get (arg);
			if (val != null) {
				val.used = true;
				return val.expression;
			}
			return null;
		}

		public string? get_string (ArgumentType arg) {
			var lit = get_expression (arg) as StringLiteral;
			if (lit != null) {
				return lit.eval ();
			}
			return null;
		}

		public int get_integer (ArgumentType arg) {
			var lit = get_expression (arg) as IntegerLiteral;
			if (lit != null) {
				return lit.value.to_int ();
			}

			return 0;
		}

		public double get_double (ArgumentType arg) {
			var expr = get_expression (arg);
			if (expr is RealLiteral) {
				var lit = (RealLiteral) expr;
				return lit.value.to_double ();
			} else if (expr is IntegerLiteral) {
				var lit = (IntegerLiteral) expr;
				return lit.value.to_int ();
			}
			return 0;
		}

		public bool get_bool (ArgumentType arg) {
			var lit = get_expression (arg) as BooleanLiteral;
			if (lit != null) {
				return lit.value;
			}
			return false;
		}

		public SourceReference? get_source_reference (ArgumentType arg) {
			var val = args.get (arg);
			if (val != null) {
				return val.source_reference;
			}
			return null;
		}
	}

	class MetadataParser {
		/**
		 * Grammar:
		 * metadata ::= [ rule [ '\n' relativerule ]* ]
		 * rule ::= pattern ' ' [ args ]
		 * relativerule ::= [ access ] rule
		 * pattern ::= identifier [ access identifier ]*
		 * access ::= '.' | ':' | '::'
		 */
		private Metadata tree = new Metadata ("");
		private Scanner scanner;
		private SourceLocation begin;
		private SourceLocation end;
		private SourceLocation old_end;
		private TokenType current;
		private Metadata parent_metadata;

		public MetadataParser () {
			tree.used = true;
		}

		SourceReference get_current_src () {
			return new SourceReference (scanner.source_file, begin.line, begin.column, end.line, end.column);
		}

		SourceReference get_src (SourceLocation begin) {
			return new SourceReference (scanner.source_file, begin.line, begin.column, end.line, end.column);
		}

		public Metadata parse_metadata (SourceFile metadata_file) {
			scanner = new Scanner (metadata_file);
			next ();
			while (current != TokenType.EOF) {
				if (!parse_rule ()) {
					return Metadata.empty;
				}
			}
			return tree;
		}

		TokenType next () {
			old_end = end;
			current = scanner.read_token (out begin, out end);
			return current;
		}

		bool has_space () {
			return old_end.pos != begin.pos;
		}

		bool has_newline () {
			return old_end.line != begin.line;
		}

		string get_string () {
			return ((string) begin.pos).ndup ((end.pos - begin.pos));
		}

		MetadataType? parse_metadata_access () {
			switch (current) {
			case TokenType.DOT:
				next ();
				return MetadataType.GENERIC;
			case TokenType.COLON:
				if (next () == TokenType.COLON) {
					next ();
					return MetadataType.SIGNAL;
				}
				return MetadataType.PROPERTY;
			default:
				return null;
			}
		}

		string? parse_identifier (out SourceReference source_reference, bool is_glob) {
			var begin = this.begin;
			var builder = new StringBuilder ();
			do {
				if (is_glob && current == TokenType.STAR) {
					builder.append_c ('*');
				} else {
					string str = null;
					switch (current) {
					case TokenType.IDENTIFIER:
					case TokenType.UNOWNED:
					case TokenType.OWNED:
					case TokenType.GET:
					case TokenType.NEW:
					case TokenType.DEFAULT:
					case TokenType.OUT:
					case TokenType.REF:
						str = get_string ();
						break;
					}
					if (str == null) {
						break;
					}
					builder.append (str);
				}
				source_reference = get_src (begin);
				next ();
			} while (!has_space ());

			if (builder.str == "") {
				if (is_glob) {
					Report.error (get_src (begin), "expected pattern");
				} else {
					Report.error (get_src (begin), "expected identifier");
				}
				return null;
			}
			return builder.str;
		}

		Metadata? parse_pattern () {
			Metadata metadata;
			bool is_relative = false;
			MetadataType? type = MetadataType.GENERIC;
			if (current == TokenType.IDENTIFIER || current == TokenType.STAR) {
				// absolute pattern
				parent_metadata = tree;
			} else {
				// relative pattern
				type = parse_metadata_access ();
				is_relative = true;
			}

			if (type == null) {
				Report.error (get_current_src (), "expected pattern, `.', `:' or `::'");
				return null;
			}

			if (parent_metadata == null) {
				Report.error (get_current_src (), "cannot determinate parent metadata");
				return null;
			}

			SourceReference src;
			var pattern = parse_identifier (out src, true);
			if (pattern == null) {
				return null;
			}
			metadata = parent_metadata.get_child (pattern, type);
			if (metadata == null) {
				metadata = new Metadata (pattern, type, src);
				parent_metadata.add_child (metadata);
			}

			while (current != TokenType.EOF && !has_space ()) {
				type = parse_metadata_access ();
				if (type == null) {
					Report.error (get_current_src (), "expected `.', `:' or `::'");
					return null;
				}

				pattern = parse_identifier (out src, true);
				if (pattern == null) {
					return null;
				}
				var child = metadata.get_child (pattern, type);
				if (child == null) {
					child = new Metadata (pattern, type, src);
					metadata.add_child (child);
				}
				metadata = child;
			}
			if (!is_relative) {
				parent_metadata = metadata;
			}

			return metadata;
		}

		Expression? parse_literal () {
			var src = get_current_src ();
			Expression expr = null;
			switch (current) {
			case TokenType.TRUE:
				expr = new BooleanLiteral (true, src);
				break;
			case TokenType.FALSE:
				expr = new BooleanLiteral (false, src);
				break;
			case TokenType.INTEGER_LITERAL:
				expr = new IntegerLiteral (get_string (), src);
				break;
			case TokenType.REAL_LITERAL:
				expr = new RealLiteral (get_string (), src);
				break;
			case TokenType.STRING_LITERAL:
				expr = new StringLiteral (get_string (), src);
				break;
			default:
				Report.error (src, "expected literal");
				break;
			}
			next ();
			return expr;
		}

		bool parse_args (Metadata metadata) {
			while (current != TokenType.EOF && has_space () && !has_newline ()) {
				SourceReference src;
				var id = parse_identifier (out src, false);
				if (id == null) {
					return false;
				}
				var arg_type = ArgumentType.from_string (id);
				if (arg_type == null) {
					Report.error (src, "unknown argument");
					return false;
				}

				if (current != TokenType.ASSIGN) {
					// threat as `true'
					metadata.add_argument (arg_type, new Argument (new BooleanLiteral (true, src), src));
					continue;
				}
				next ();

				Expression expr = parse_literal ();
				if (expr == null) {
					return false;
				}
				metadata.add_argument (arg_type, new Argument (expr, src));
			}

			return true;
		}

		bool parse_rule () {
			var old_end = end;
			var metadata = parse_pattern ();
			if (metadata == null) {
				return false;
			}

			if (current == TokenType.EOF || old_end.line != end.line) {
				// eof or new rule
				return true;
			}
			return parse_args (metadata);
		}
	}

	class CallbackScope {
		public Namespace parent_namespace;
		public UnresolvedSymbol gtype_struct_for;
	}

	MarkupReader reader;

	CodeContext context;
	Namespace glib_ns;

	SourceFile current_source_file;
	Namespace current_namespace;
	string current_gtype_struct_for;
	SourceLocation begin;
	SourceLocation end;
	MarkupTokenType current_token;

	string[] cheader_filenames;

	HashMap<UnresolvedSymbol,Symbol> unresolved_symbols_map = new HashMap<UnresolvedSymbol,Symbol> (unresolved_symbol_hash, unresolved_symbol_equal);
	HashMap<Symbol,Symbol> concrete_symbols_map = new HashMap<Symbol,Symbol> ();

	ArrayList<UnresolvedSymbol> unresolved_gir_symbols = new ArrayList<UnresolvedSymbol> ();

	HashMap<CallbackScope,ArrayList<Delegate>> gtype_callbacks = new HashMap<CallbackScope,ArrayList<Delegate>> (callback_scope_hash, callback_scope_equal);

	/**
	 * Parses all .gir source files in the specified code
	 * context and builds a code tree.
	 *
	 * @param context a code context
	 */
	public void parse (CodeContext context) {
		this.context = context;
		glib_ns = context.root.scope.lookup ("GLib") as Namespace;
		context.accept (this);

		resolve_gir_symbols ();

		postprocess_gtype_callbacks ();
	}

	public override void visit_source_file (SourceFile source_file) {
		// collect gir namespaces
		foreach (var node in source_file.get_nodes ()) {
			if (node is Namespace) {
				var ns = (Namespace) node;
				var gir_namespace = source_file.gir_namespace;
				if (gir_namespace == null) {
					var a = ns.get_attribute ("CCode");
					if (a != null && a.has_argument ("gir_namespace")) {
						gir_namespace = a.get_string ("gir_namespace");
					}
				}
				if (gir_namespace != null && gir_namespace != ns.name) {
					var map_from = new UnresolvedSymbol (null, gir_namespace);
					set_symbol_mapping (map_from, ns);
					break;
				}
			}
		}

		if (source_file.filename.has_suffix (".gir")) {
			parse_file (source_file);
		}
	}

	public void parse_file (SourceFile source_file) {
		this.current_source_file = source_file;
		reader = new MarkupReader (source_file.filename);

		// xml prolog
		next ();
		next ();

		next ();
		parse_repository ();

		var remove_queue = new ArrayList<CodeNode> ();

		foreach (CodeNode node in source_file.get_nodes ()) {
			if (node is Class) {
				var cl = (Class) node;
				var ns = cl.parent_symbol as Namespace;
				// remove Class records
				var class_struct = ns.scope.lookup (cl.name + "Class") as Struct;
				if (class_struct != null) {
					ns.remove_struct ((Struct) class_struct);
					remove_queue.add (class_struct);
				}
			} else if (node is Interface) {
				var iface = (Interface) node;
				var ns = iface.parent_symbol as Namespace;
				// remove Iface records
				var iface_struct = ns.scope.lookup (iface.name + "Iface") as Struct;
				if (iface_struct != null) {
					ns.remove_struct ((Struct) iface_struct);
					remove_queue.add (iface_struct);
				}
			}
		}

		foreach (CodeNode node in remove_queue) {
			source_file.remove_node (node);
		}

		reader = null;
		this.current_source_file = null;
	}

	void next () {
		current_token = reader.read_token (out begin, out end);

		// Skip *all* <doc> tags
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "doc")
			skip_element();
	}

	void start_element (string name) {
		if (current_token != MarkupTokenType.START_ELEMENT || reader.name != name) {
			// error
			Report.error (get_current_src (), "expected start element of `%s'".printf (name));
		}
	}

	void end_element (string name) {
		if (current_token != MarkupTokenType.END_ELEMENT || reader.name != name) {
			// error
			Report.error (get_current_src (), "expected end element of `%s'".printf (name));
		}
		next ();
	}

	SourceReference get_current_src () {
		return new SourceReference (this.current_source_file, begin.line, begin.column, end.line, end.column);
	}

	const string GIR_VERSION = "1.2";

	UnresolvedSymbol? parse_symbol_from_string (string symbol_string, SourceReference? source_reference = null) {
		UnresolvedSymbol? sym = null;
		foreach (unowned string s in symbol_string.split (".")) {
			sym = new UnresolvedSymbol (sym, s, source_reference);
		}
		if (sym == null) {
			Report.error (source_reference, "a symbol must be specified");
		}
		return sym;
	}

	UnresolvedSymbol get_unresolved_symbol (Symbol symbol) {
		if (symbol is UnresolvedSymbol) {
			return (UnresolvedSymbol) symbol;
		}
		var sym = new UnresolvedSymbol (null, symbol.name);
		var result = sym;
		var cur = symbol.parent_node as Symbol;
		while (cur != null && cur.name != null) {
			sym = new UnresolvedSymbol (sym, cur.name);
			cur = cur.parent_node as Symbol;
		}
		return result;
	}

	void set_symbol_mapping (Symbol map_from, Symbol map_to) {
		// last mapping is the most up-to-date
		if (map_from is UnresolvedSymbol) {
			unresolved_symbols_map[(UnresolvedSymbol) map_from] = map_to;
		} else {
			concrete_symbols_map[map_from] = map_to;
		}
	}

	void assume_parameter_names (Signal sig, Symbol sym) {
		Iterator<Parameter> iter;
		if (sym is Method) {
			iter = ((Method) sym).get_parameters ().iterator ();
		} else {
			iter = ((Delegate) sym).get_parameters ().iterator ();
		}
		foreach (var param in sig.get_parameters ()) {
			if (!iter.next ()) {
				// unreachable for valid GIR
				break;
			}
			param.name = iter.get ().name;
		}
	}

	void parse_repository () {
		start_element ("repository");
		if (reader.get_attribute ("version") != GIR_VERSION) {
			Report.error (get_current_src (), "unsupported GIR version %s (supported: %s)".printf (reader.get_attribute ("version"), GIR_VERSION));
			return;
		}
		next ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.name == "namespace") {
				var ns = parse_namespace ();
				if (ns != null) {
					context.root.add_namespace (ns);
				}
			} else if (reader.name == "include") {
				parse_include ();
			} else if (reader.name == "package") {
				var pkg = parse_package ();
				if (context.has_package (pkg)) {
					// package already provided elsewhere, stop parsing this GIR
					return;
				} else {
					context.add_package (pkg);
				}
			} else if (reader.name == "c:include") {
				parse_c_include ();
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `repository'".printf (reader.name));
				break;
			}
		}
		end_element ("repository");
	}

	void parse_include () {
		start_element ("include");
		var pkg = reader.get_attribute ("name");
		var version = reader.get_attribute ("version");
		if (version != null) {
			pkg = "%s-%s".printf (pkg, version);
		}
		// add the package to the queue
		context.add_external_package (pkg);
		next ();
		end_element ("include");
	}

	string parse_package () {
		start_element ("package");
		var pkg = reader.get_attribute ("name");
		next ();
		end_element ("package");
		return pkg;
	}

	void parse_c_include () {
		start_element ("c:include");
		cheader_filenames += reader.get_attribute ("name");
		next ();
		end_element ("c:include");
	}

	void skip_element () {
		next ();

		int level = 1;
		while (level > 0) {
			if (current_token == MarkupTokenType.START_ELEMENT) {
				level++;
			} else if (current_token == MarkupTokenType.END_ELEMENT) {
				level--;
			} else if (current_token == MarkupTokenType.EOF) {
				Report.error (get_current_src (), "unexpected end of file");
				break;
			}
			next ();
		}
	}

	Namespace? parse_namespace () {
		start_element ("namespace");

		bool new_namespace = false;
		string? cprefix = reader.get_attribute ("c:identifier-prefixes");
		string namespace_name = cprefix;
		string gir_namespace = reader.get_attribute ("name");
		string gir_version = reader.get_attribute ("version");
		if (namespace_name == null) {
			namespace_name = gir_namespace;
		}
		current_source_file.gir_namespace = gir_namespace;
		current_source_file.gir_version = gir_version;

		var ns = context.root.scope.lookup (namespace_name) as Namespace;
		if (ns == null) {
			ns = new Namespace (namespace_name, get_current_src ());
			new_namespace = true;
		} else {
			if (ns.external_package) {
				ns.attributes = null;
				ns.source_reference = get_current_src ();
			}
		}

		if (gir_namespace != ns.name) {
			set_symbol_mapping (new UnresolvedSymbol (null, gir_namespace), ns);
		}

		var old_namespace = current_namespace;
		current_namespace = ns;

		if (cprefix != null) {
			ns.add_cprefix (cprefix);
			ns.set_lower_case_cprefix (Symbol.camel_case_to_lower_case (cprefix) + "_");
		}

		foreach (string c_header in cheader_filenames) {
			ns.add_cheader_filename (c_header);
		}
		next ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			Symbol sym = null;
			if (reader.name == "alias") {
				sym = parse_alias ();
			} else if (reader.name == "enumeration") {
				if (reader.get_attribute ("glib:error-quark") != null) {
					sym = parse_error_domain ();
				} else {
					sym = parse_enumeration ();
				}
			} else if (reader.name == "bitfield") {
				sym = parse_bitfield ();
			} else if (reader.name == "function") {
				sym = parse_method ("function");
			} else if (reader.name == "callback") {
				sym = parse_callback ();
			} else if (reader.name == "record") {
				if (reader.get_attribute ("glib:get-type") != null) {
					sym = parse_boxed ();
				} else {
					sym = parse_record ();
				}
			} else if (reader.name == "class") {
				sym = parse_class ();
			} else if (reader.name == "interface") {
				sym = parse_interface ();
			} else if (reader.name == "glib:boxed") {
				sym = parse_boxed ();
			} else if (reader.name == "union") {
				sym = parse_union ();
			} else if (reader.name == "constant") {
				sym = parse_constant ();
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `namespace'".printf (reader.name));
				break;
			}

			if (sym is Class) {
				ns.add_class ((Class) sym);
			} else if (sym is Interface) {
				ns.add_interface ((Interface) sym);
			} else if (sym is Struct) {
				ns.add_struct ((Struct) sym);
			} else if (sym is Enum) {
				ns.add_enum ((Enum) sym);
			} else if (sym is ErrorDomain) {
				ns.add_error_domain ((ErrorDomain) sym);
			} else if (sym is Delegate) {
				ns.add_delegate ((Delegate) sym);
			} else if (sym is Method) {
				ns.add_method ((Method) sym);
			} else if (sym is Constant) {
				ns.add_constant ((Constant) sym);
			} else if (sym == null) {
				continue;
			}
		}
		end_element ("namespace");

		current_namespace = old_namespace;

		if (!new_namespace) {
			ns = null;
		}

		return ns;
	}

	Struct parse_alias () {
		start_element ("alias");
		var st = new Struct (reader.get_attribute ("name"), get_current_src ());
		st.access = SymbolAccessibility.PUBLIC;
		st.external = true;
		next ();

		st.base_type = parse_type (null, null, true);

		end_element ("alias");
		return st;
	}

	private void calculate_common_prefix (ref string common_prefix, string cname) {
		if (common_prefix == null) {
			common_prefix = cname;
			while (common_prefix.length > 0 && !common_prefix.has_suffix ("_")) {
				// FIXME: could easily be made faster
				common_prefix = common_prefix.ndup (common_prefix.length - 1);
			}
		} else {
			while (!cname.has_prefix (common_prefix)) {
				common_prefix = common_prefix.ndup (common_prefix.length - 1);
			}
		}
		while (common_prefix.length > 0 && (!common_prefix.has_suffix ("_") ||
		       (cname.offset (common_prefix.length).get_char ().isdigit ()) && (cname.length - common_prefix.length) <= 1)) {
			// enum values may not consist solely of digits
			common_prefix = common_prefix.ndup (common_prefix.length - 1);
		}
	}

	Enum parse_enumeration () {
		start_element ("enumeration");
		var en = new Enum (reader.get_attribute ("name"), get_current_src ());
		en.access = SymbolAccessibility.PUBLIC;

		string enum_cname = reader.get_attribute ("c:type");
		if (enum_cname != null) {
			en.set_cname (enum_cname);
		}

		next ();

		string common_prefix = null;
		
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "member") {
				var ev = parse_enumeration_member ();
				en.add_value (ev);
				calculate_common_prefix (ref common_prefix, ev.get_cname ());
			} else {
				// error
				break;
			}
		}

		en.set_cprefix (common_prefix);

		end_element ("enumeration");
		return en;
	}

	ErrorDomain parse_error_domain () {
		start_element ("enumeration");

		var ed = new ErrorDomain (reader.get_attribute ("name"), get_current_src ());
		ed.access = SymbolAccessibility.PUBLIC;

		string enum_cname = reader.get_attribute ("c:type");
		if (enum_cname != null) {
			ed.set_cname (enum_cname);
		}

		next ();

		string common_prefix = null;

		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "member") {
				ErrorCode ec = parse_error_member ();
				ed.add_code (ec);
				calculate_common_prefix (ref common_prefix, ec.get_cname ());
			} else {
				// error
				break;
			}
		}

		ed.set_cprefix (common_prefix);

		end_element ("enumeration");
		return ed;
	}

	Enum parse_bitfield () {
		start_element ("bitfield");
		var en = new Enum (reader.get_attribute ("name"), get_current_src ());
		en.access = SymbolAccessibility.PUBLIC;
		next ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "member") {
				en.add_value (parse_enumeration_member ());
			} else {
				// error
				break;
			}
		}
		end_element ("bitfield");
		return en;
	}

	EnumValue parse_enumeration_member () {
		start_element ("member");
		var ev = new EnumValue (string.joinv ("_", reader.get_attribute ("name").up ().split ("-")), null);
		ev.set_cname (reader.get_attribute ("c:identifier"));
		next ();
		end_element ("member");
		return ev;
	}

	ErrorCode parse_error_member () {
		start_element ("member");

		ErrorCode ec;
		string name = string.joinv ("_", reader.get_attribute ("name").up ().split ("-"));
		string value = reader.get_attribute ("value");
		if (value != null) {
			ec = new ErrorCode.with_value (name, new IntegerLiteral (value));
		} else {
			ec = new ErrorCode (name);
		}

		next ();
		end_element ("member");
		return ec;
	}

	DataType parse_return_value (out string? ctype = null) {
		start_element ("return-value");
		string transfer = reader.get_attribute ("transfer-ownership");
		string allow_none = reader.get_attribute ("allow-none");
		next ();
		var transfer_elements = transfer == "full";
		var type = &ctype != null ? parse_type(out ctype, null, transfer_elements) : parse_type (null, null, transfer_elements);
		if (transfer == "full" || transfer == "container") {
			type.value_owned = true;
		}
		if (allow_none == "1") {
			type.nullable = true;
		}
		end_element ("return-value");
		return type;
	}

	Parameter parse_parameter (out int array_length_idx = null, out int closure_idx = null, out int destroy_idx = null, out string? scope = null, string? default_name = null) {
		Parameter param;

		if (&array_length_idx != null) {
			array_length_idx = -1;
		}
		if (&closure_idx != null) {
			closure_idx = -1;
		}
		if (&destroy_idx != null) {
			destroy_idx = -1;
		}

		start_element ("parameter");
		string name = reader.get_attribute ("name");
		if (name == null) {
			name = default_name;
		}
		string direction = reader.get_attribute ("direction");
		string transfer = reader.get_attribute ("transfer-ownership");
		string allow_none = reader.get_attribute ("allow-none");

		if (&scope != null) {
			scope = reader.get_attribute ("scope");
		}

		string closure = reader.get_attribute ("closure");
		string destroy = reader.get_attribute ("destroy");
		if (closure != null && &closure_idx != null) {
			closure_idx = closure.to_int ();
		}
		if (destroy != null && &destroy_idx != null) {
			destroy_idx = destroy.to_int ();
		}

		next ();
		if (reader.name == "varargs") {
			start_element ("varargs");
			next ();
			param = new Parameter.with_ellipsis (get_current_src ());
			end_element ("varargs");
		} else {
			var type = parse_type (null, out array_length_idx, transfer == "full");
			if (transfer == "full" || transfer == "container" || destroy != null) {
				type.value_owned = true;
			}
			if (allow_none == "1") {
				type.nullable = true;
			}
			param = new Parameter (name, type, get_current_src ());
			if (direction == "out") {
				param.direction = ParameterDirection.OUT;
			} else if (direction == "inout") {
				param.direction = ParameterDirection.REF;
			}
		}
		end_element ("parameter");
		return param;
	}

	DataType parse_type (out string? ctype = null, out int array_length_index = null, bool transfer_elements = false) {
		bool is_array = false;
		string type_name = reader.get_attribute ("name");

		if (reader.name == "array") {
			is_array = true;
			start_element ("array");

			if (!(type_name == "GLib.Array" || type_name == "GLib.PtrArray")) {
				if (reader.get_attribute ("length") != null
				    && &array_length_index != null) {
					array_length_index = reader.get_attribute ("length").to_int ();
				}
				next ();
				var element_type = parse_type ();
				end_element ("array");
				return new ArrayType (element_type, 1, null);
			}
		} else if (reader.name == "callback"){
			var callback = parse_callback ();
			return new DelegateType (callback);
		} else {
			start_element ("type");
		}

		if (&ctype != null) {
			ctype = reader.get_attribute("c:type");
		}

		next ();

		if (type_name == "GLib.PtrArray"
		    && current_token == MarkupTokenType.START_ELEMENT) {
			type_name = "GLib.GenericArray";
		}

		DataType type = parse_type_from_name (type_name);

		// type arguments / element types
		while (current_token == MarkupTokenType.START_ELEMENT) {
			var element_type = parse_type ();
			element_type.value_owned = transfer_elements;
			type.add_type_argument (element_type);
		}

		end_element (is_array ? "array" : "type");
		return type;
	}

	DataType parse_type_from_name (string type_name) {
		DataType type;
		if (type_name == "none") {
			type = new VoidType (get_current_src ());
		} else if (type_name == "gpointer") {
			type = new PointerType (new VoidType (get_current_src ()), get_current_src ());
		} else if (type_name == "GObject.Strv") {
			type = new ArrayType (new UnresolvedType.from_symbol (new UnresolvedSymbol (null, "string")), 1, get_current_src ());
		} else {
			bool known_type = true;
			if (type_name == "utf8") {
				type_name = "string";
			} else if (type_name == "gboolean") {
				type_name = "bool";
			} else if (type_name == "gchar") {
				type_name = "char";
			} else if (type_name == "gshort") {
				type_name = "short";
			} else if (type_name == "gushort") {
				type_name = "ushort";
			} else if (type_name == "gint") {
				type_name = "int";
			} else if (type_name == "guint") {
				type_name = "uint";
			} else if (type_name == "glong") {
				type_name = "long";
			} else if (type_name == "gulong") {
				type_name = "ulong";
			} else if (type_name == "gint8") {
				type_name = "int8";
			} else if (type_name == "guint8") {
				type_name = "uint8";
			} else if (type_name == "gint16") {
				type_name = "int16";
			} else if (type_name == "guint16") {
				type_name = "uint16";
			} else if (type_name == "gint32") {
				type_name = "int32";
			} else if (type_name == "guint32") {
				type_name = "uint32";
			} else if (type_name == "gint64") {
				type_name = "int64";
			} else if (type_name == "guint64") {
				type_name = "uint64";
			} else if (type_name == "gfloat") {
				type_name = "float";
			} else if (type_name == "gdouble") {
				type_name = "double";
			} else if (type_name == "filename") {
				type_name = "string";
			} else if (type_name == "GLib.offset") {
				type_name = "int64";
			} else if (type_name == "gsize") {
				type_name = "size_t";
			} else if (type_name == "gssize") {
				type_name = "ssize_t";
			} else if (type_name == "GType") {
				type_name = "GLib.Type";
			} else if (type_name == "GLib.String") {
				type_name = "GLib.StringBuilder";
			} else if (type_name == "GObject.Class") {
				type_name = "GLib.ObjectClass";
			} else if (type_name == "GLib.unichar") {
				type_name = "unichar";
			} else if (type_name == "GLib.Data") {
				type_name = "GLib.Datalist";
			} else if (type_name == "Atk.ImplementorIface") {
				type_name = "Atk.Implementor";
			} else {
				known_type = false;
			}
			var sym = parse_symbol_from_string (type_name, get_current_src ());
			type = new UnresolvedType.from_symbol (sym, get_current_src ());
			if (!known_type) {
				unresolved_gir_symbols.add (sym);
			}
		}

		return type;
	}

	Struct parse_record () {
		start_element ("record");
		var st = new Struct (reader.get_attribute ("name"), get_current_src ());
		st.external = true;

		current_gtype_struct_for = reader.get_attribute ("glib:is-gtype-struct-for");

		st.access = SymbolAccessibility.PUBLIC;
		next ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "field") {
				st.add_field (parse_field ());
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				st.add_method (parse_method ("method"));
			} else if (reader.name == "union") {
				Struct s = parse_union ();
				var s_fields = s.get_fields ();
				foreach (var f in s_fields) {
					f.set_cname (s.get_cname () + "." + f.get_cname ());
					f.name = s.name + "_" + f.name;
					st.add_field (f);
				}
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `record'".printf (reader.name));
				break;
			}
		}
		end_element ("record");
		return st;
	}

	Class parse_class () {
		start_element ("class");
		var cl = new Class (reader.get_attribute ("name"), get_current_src ());
		cl.access = SymbolAccessibility.PUBLIC;
		cl.external = true;

		string cname = reader.get_attribute ("c:type");
		if (cname != null) {
			cl.set_cname (cname);
		}

		string parent = reader.get_attribute ("parent");
		if (parent != null) {
			cl.add_base_type (parse_type_from_name (parent));
		}

		next ();
		var signals = new ArrayList<Signal> ();
		var methods = new ArrayList<Method> ();
		var vmethods = new ArrayList<Method> ();
		var fields = new ArrayList<Field> ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "implements") {
				start_element ("implements");
				cl.add_base_type (parse_type_from_name (reader.get_attribute ("name")));
				next ();
				end_element ("implements");
			} else if (reader.name == "constant") {
				cl.add_constant (parse_constant ());
			} else if (reader.name == "field") {
				fields.add (parse_field ());
			} else if (reader.name == "property") {
				cl.add_property (parse_property ());
			} else if (reader.name == "constructor") {
				cl.add_method (parse_constructor (cname));
			} else if (reader.name == "function") {
				methods.add (parse_method ("function"));
			} else if (reader.name == "method") {
				methods.add (parse_method ("method"));
			} else if (reader.name == "virtual-method") {
				vmethods.add (parse_method ("virtual-method"));
			} else if (reader.name == "union") {
				Struct s = parse_union ();
				var s_fields = s.get_fields ();
				foreach (var f in s_fields) {
					f.set_cname (s.get_cname () + "." + f.get_cname ());
					f.name = s.name + "_" + f.name;
					fields.add (f);
				}
			} else if (reader.name == "glib:signal") {
				signals.add (parse_signal ());
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `class'".printf (reader.name));
				break;
			}
		}

		// signal merging
		foreach (Signal sig in signals) {
			var symbol = cl.scope.lookup (sig.name);
			if (symbol == null) {
				cl.add_signal (sig);
			} else if (symbol is Property) {
				// properties take precedence
			} else {
				Report.error (get_current_src (), "duplicate member `%s' in `%s'".printf (sig.name, cl.name));
			}
		}

		// virtual method merging
		foreach (Method m in vmethods) {
			var symbol = cl.scope.lookup (m.name);
			if (symbol == null) {
				cl.add_method (m);
			} else if (symbol is Signal) {
				var sig = (Signal) symbol;
				sig.is_virtual = true;
			} else if (symbol is Property || symbol is Field) {
				// assume method is getter for property/field ignore method
			} else {
				Report.error (get_current_src (), "duplicate member `%s' in `%s'".printf (m.name, cl.name));
			}
		}

		// method merging
		foreach (Method m in methods) {
			var symbol = cl.scope.lookup (m.name);
			if (symbol == null) {
				cl.add_method (m);
			} else if (symbol is Signal) {
				var sig = (Signal) symbol;
				sig.has_emitter = true;
			} else if (symbol is Property || symbol is Field) {
				// assume method is getter for property/field ignore method
			} else if (symbol is Method) {
				// assume method is wrapper for virtual method
			} else {
				Report.error (get_current_src (), "duplicate member `%s' in `%s'".printf (m.name, cl.name));
			}
		}

		// fields have lowest priority
		foreach (Field f in fields) {
			var symbol = cl.scope.lookup (f.name);
			if (symbol == null) {
				cl.add_field (f);
			}
		}

		handle_async_methods (cl);

		end_element ("class");
		return cl;
	}

	Interface parse_interface () {
		start_element ("interface");
		var iface = new Interface (reader.get_attribute ("name"), get_current_src ());
		iface.access = SymbolAccessibility.PUBLIC;
		iface.external = true;

		string cname = reader.get_attribute ("c:type");
		if (cname != null) {
			iface.set_cname (cname);
		}

		next ();
		var methods = new ArrayList<Method> ();
		var vmethods = new ArrayList<Method> ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "prerequisite") {
				start_element ("prerequisite");
				iface.add_prerequisite (parse_type_from_name (reader.get_attribute ("name")));
				next ();
				end_element ("prerequisite");
			} else if (reader.name == "field") {
				parse_field ();
			} else if (reader.name == "property") {
				iface.add_property (parse_property ());
			} else if (reader.name == "virtual-method") {
				vmethods.add (parse_method ("virtual-method"));
			} else if (reader.name == "function") {
				methods.add (parse_method ("function"));
			} else if (reader.name == "method") {
				methods.add (parse_method ("method"));
			} else if (reader.name == "glib:signal") {
				iface.add_signal (parse_signal ());
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `interface'".printf (reader.name));
				break;
			}
		}

		// ensure we have at least one instantiable prerequisite (GLib.Object)
		bool has_instantiable_prereq = false;
		foreach (DataType prereq in iface.get_prerequisites ()) {
			if (prereq.data_type is Class) {
				has_instantiable_prereq = true;
				break;
			}
		}

		if (!has_instantiable_prereq)
			iface.add_prerequisite (new ObjectType ((ObjectTypeSymbol) glib_ns.scope.lookup ("Object")));

		// virtual method merging
		foreach (Method m in vmethods) {
			var symbol = iface.scope.lookup (m.name);
			if (symbol == null) {
				iface.add_method (m);
			} else if (symbol is Signal) {
				var sig = (Signal) symbol;
				sig.is_virtual = true;
			} else {
				Report.error (get_current_src (), "duplicate member `%s' in `%s'".printf (m.name, iface.name));
			}
		}

		// method merging
		foreach (Method m in methods) {
			var symbol = iface.scope.lookup (m.name);
			if (symbol == null) {
				iface.add_method (m);
			} else if (symbol is Signal) {
				var sig = (Signal) symbol;
				sig.has_emitter = true;
			} else if (symbol is Method) {
				// assume method is wrapper for virtual method
			} else {
				Report.error (get_current_src (), "duplicate member `%s' in `%s'".printf (m.name, iface.name));
			}
		}

		handle_async_methods (iface);

		end_element ("interface");
		return iface;
	}

	void handle_async_methods (ObjectTypeSymbol type_symbol) {
		var methods = type_symbol.get_methods ();
		for (int method_n = 0 ; method_n < methods.size ; method_n++) {
			var m = methods.get (method_n);

			if (m.coroutine) {
				string finish_method_base;
				if (m.name.has_suffix ("_async")) {
					finish_method_base = m.name.substring (0, m.name.length - "_async".length);
				} else {
					finish_method_base = m.name;
				}
				var finish_method = type_symbol.scope.lookup (finish_method_base + "_finish") as Method;

				// check if the method is using non-standard finish method name
				if (finish_method == null) {
					var method_cname = m.get_finish_cname ();
					foreach (Method method in type_symbol.get_methods ()) {
						if (method.get_cname () == method_cname) {
							finish_method = method;
							break;
						}
					}
				}

				if (finish_method != null) {
					m.return_type = finish_method.return_type.copy ();
					m.no_array_length = finish_method.no_array_length;
					m.array_null_terminated = finish_method.array_null_terminated;
					foreach (var param in finish_method.get_parameters ()) {
						if (param.direction == ParameterDirection.OUT) {
							var async_param = param.copy ();
							if (m.scope.lookup (param.name) != null) {
								// parameter name conflict
								async_param.name += "_out";
							}
							m.add_parameter (async_param);
						}
					}
					foreach (DataType error_type in finish_method.get_error_types ()) {
						m.add_error_type (error_type.copy ());
					}
					if (methods.index_of (finish_method) < method_n) {
						method_n--;
					}
					type_symbol.scope.remove (finish_method.name);
					methods.remove (finish_method);
				}
			}
		}
	}

	Field parse_field () {
		start_element ("field");
		string name = reader.get_attribute ("name");
		string allow_none = reader.get_attribute ("allow-none");
		next ();
		var type = parse_type ();
		if (type is DelegateType && current_gtype_struct_for != null) {
			// virtual
			var callback_scope = new CallbackScope ();
			callback_scope.parent_namespace = current_namespace;
			callback_scope.gtype_struct_for = parse_symbol_from_string (current_gtype_struct_for);
			ArrayList<Delegate> callbacks = gtype_callbacks.get (callback_scope);
			if (callbacks == null) {
				callbacks = new ArrayList<Delegate> ();
				gtype_callbacks.set (callback_scope, callbacks);
			}
			callbacks.add (((DelegateType) type).delegate_symbol);
		}
		var field = new Field (name, type, null, get_current_src ());
		field.access = SymbolAccessibility.PUBLIC;
		if (allow_none == "1") {
			type.nullable = true;
		}
		end_element ("field");
		return field;
	}

	Property parse_property () {
		start_element ("property");
		string name = string.joinv ("_", reader.get_attribute ("name").split ("-"));
		string readable = reader.get_attribute ("readable");
		string writable = reader.get_attribute ("writable");
		string construct_ = reader.get_attribute ("construct");
		string construct_only = reader.get_attribute ("construct-only");
		next ();
		var type = parse_type ();
		var prop = new Property (name, type, null, null, get_current_src ());
		prop.access = SymbolAccessibility.PUBLIC;
		if (readable != "0") {
			prop.get_accessor = new PropertyAccessor (true, false, false, prop.property_type.copy (), null, null);
		}
		if (writable == "1" || construct_only == "1") {
			prop.set_accessor = new PropertyAccessor (false, (construct_only != "1") && (writable == "1"), (construct_only == "1") || (construct_ == "1"), prop.property_type.copy (), null, null);
		}
		end_element ("property");
		return prop;
	}

	Delegate parse_callback () {
		return this.parse_function ("callback") as Delegate;
	}

	Method parse_constructor (string? parent_ctype = null) {
		start_element ("constructor");
		string name = reader.get_attribute ("name");
		string throws_string = reader.get_attribute ("throws");
		string cname = reader.get_attribute ("c:identifier");
		next ();

		string? ctype;
		parse_return_value (out ctype);

		var m = new CreationMethod (null, name, get_current_src ());
		m.access = SymbolAccessibility.PUBLIC;
		m.has_construct_function = false;
		if (ctype != null && (parent_ctype == null || ctype != parent_ctype + "*")) {
			m.custom_return_type_cname = ctype;
		}
		if (m.name == "new") {
			m.name = null;
		} else if (m.name.has_prefix ("new_")) {
			m.name = m.name.offset ("new_".length);
		}
		if (cname != null) {
			m.set_cname (cname);
		}
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();
			while (current_token == MarkupTokenType.START_ELEMENT) {
				m.add_parameter (parse_parameter ());
			}
			end_element ("parameters");
		}

		if (throws_string == "1") {
			m.add_error_type (new ErrorType (null, null));
		}
		end_element ("constructor");
		return m;
	}

	class MethodInfo {
		public MethodInfo (Parameter param, int array_length_idx, int closure_idx, int destroy_idx) {
			this.param = param;
			this.array_length_idx = array_length_idx;
			this.closure_idx = closure_idx;
			this.destroy_idx = destroy_idx;
			this.vala_idx = 0.0F;
			this.keep = true;
		}

		public Parameter param;
		public float vala_idx;
		public int array_length_idx;
		public int closure_idx;
		public int destroy_idx;
		public bool keep;
	}

	Symbol parse_function (string element_name) {
		start_element (element_name);
		string name = reader.get_attribute ("name");
		string cname = reader.get_attribute ("c:identifier");
		string throws_string = reader.get_attribute ("throws");
		string invoker = reader.get_attribute ("invoker");
		next ();
		DataType return_type;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			return_type = parse_return_value ();
		} else {
			return_type = new VoidType ();
		}

		Symbol s;

		if (element_name == "callback") {
			s = new Delegate (name, return_type, get_current_src ());
		} else {
			s = new Method (name, return_type, get_current_src ());
		}

		s.access = SymbolAccessibility.PUBLIC;
		if (cname != null) {
			if (s is Method) {
				((Method) s).set_cname (cname);
			} else {
				((Delegate) s).set_cname (cname);
			}
		}

		if (element_name == "virtual-method" || element_name == "callback") {
			if (s is Method) {
				((Method) s).is_virtual = true;
			}

			if (invoker != null){
				s.name = invoker;
			}
		} else if (element_name == "function") {
			((Method) s).binding = MemberBinding.STATIC;
		}

		var parameters = new ArrayList<MethodInfo> ();
		var array_length_parameters = new ArrayList<int> ();
		var closure_parameters = new ArrayList<int> ();
		var destroy_parameters = new ArrayList<int> ();
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();

			while (current_token == MarkupTokenType.START_ELEMENT) {
				int array_length_idx, closure_idx, destroy_idx;
				string scope;
				string default_param_name = null;
				if (s is Delegate) {
					default_param_name = "arg%d".printf (parameters.size);
				}
				var param = parse_parameter (out array_length_idx, out closure_idx, out destroy_idx, out scope, default_param_name);
				if (array_length_idx != -1) {
					array_length_parameters.add (array_length_idx);
				}
				if (closure_idx != -1) {
					closure_parameters.add (closure_idx);
				}
				if (destroy_idx != -1) {
					destroy_parameters.add (destroy_idx);
				}

				var info = new MethodInfo(param, array_length_idx, closure_idx, destroy_idx);

				if (s is Method && scope == "async") {
					var unresolved_type = param.variable_type as UnresolvedType;
					if (unresolved_type != null && unresolved_type.unresolved_symbol.name == "AsyncReadyCallback") {
						// GAsync-style method
						((Method) s).coroutine = true;
						info.keep = false;
					}
				}

				parameters.add (info);
			}
			end_element ("parameters");
		}
		int i = 0, j=1;

		int last = -1;
		foreach (MethodInfo info in parameters) {
			if (s is Delegate && info.closure_idx == i) {
				var d = (Delegate) s;
				d.has_target = true;
				d.cinstance_parameter_position = (float) j - 0.1;
				info.keep = false;
			} else if (info.keep
			    && !array_length_parameters.contains (i)
			    && !closure_parameters.contains (i)
			    && !destroy_parameters.contains (i)) {
				info.vala_idx = (float) j;
				info.keep = true;

				/* interpolate for vala_idx between this and last*/
				float last_idx = 0.0F;
				if (last != -1) {
					last_idx = parameters[last].vala_idx;
				}
				for (int k=last+1; k < i; k++) {
					parameters[k].vala_idx =  last_idx + (((j - last_idx) / (i-last)) * (k-last));
				}
				last = i;
				j++;
			} else {
				info.keep = false;
				// make sure that vala_idx is always set
				// the above if branch does not set vala_idx for
				// hidden parameters at the end of the parameter list
				info.vala_idx = (j - 1) + (i - last) * 0.1F;
			}
			i++;
		}

		foreach (MethodInfo info in parameters) {
			if (info.keep) {

				/* add_parameter sets carray_length_parameter_position and cdelegate_target_parameter_position
				 so do it first*/
				if (s is Method) {
					((Method) s).add_parameter (info.param);
				} else {
					((Delegate) s).add_parameter (info.param);
				}

				if (info.array_length_idx != -1) {
					if ((info.array_length_idx) >= parameters.size) {
						Report.error (get_current_src (), "invalid array_length index");
						continue;
					}
					info.param.carray_length_parameter_position = parameters[info.array_length_idx].vala_idx;
					info.param.set_array_length_cname (parameters[info.array_length_idx].param.name);
				}
				if (info.param.variable_type is ArrayType && info.array_length_idx == -1) {
					info.param.no_array_length = true;
				}

				if (info.closure_idx != -1) {
					if ((info.closure_idx) >= parameters.size) {
						Report.error (get_current_src (), "invalid closure index");
						continue;
					}
					info.param.cdelegate_target_parameter_position = parameters[info.closure_idx].vala_idx;
				}
				if (info.destroy_idx != -1) {
					if (info.destroy_idx >= parameters.size) {
						Report.error (get_current_src (), "invalid destroy index");
						continue;
					}
					info.param.cdestroy_notify_parameter_position = parameters[info.destroy_idx].vala_idx;
				}
			}
		}

		if (throws_string == "1") {
			s.add_error_type (new ErrorType (null, null));
		}
		end_element (element_name);
		return s;
	}

	Method parse_method (string element_name) {
		return this.parse_function (element_name) as Method;
	}

	Signal parse_signal () {
		start_element ("glib:signal");
		string name = string.joinv ("_", reader.get_attribute ("name").split ("-"));
		next ();
		DataType return_type;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			return_type = parse_return_value ();
		} else {
			return_type = new VoidType ();
		}
		var sig = new Signal (name, return_type, get_current_src ());
		sig.access = SymbolAccessibility.PUBLIC;
		sig.external = true;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();
			while (current_token == MarkupTokenType.START_ELEMENT) {
				sig.add_parameter (parse_parameter ());
			}
			end_element ("parameters");
		}
		end_element ("glib:signal");
		return sig;
	}

	Class parse_boxed () {
		string name = reader.get_attribute ("name");
		if (name == null) {
			name = reader.get_attribute ("glib:name");
		}
		var cl = new Class (name, get_current_src ());
		cl.access = SymbolAccessibility.PUBLIC;
		cl.external = true;
		cl.is_compact = true;

		string cname = reader.get_attribute ("c:type");
		if (cname != null) {
			cl.set_cname (cname);
		}

		cl.set_type_id ("%s ()".printf (reader.get_attribute ("glib:get-type")));
		cl.set_free_function ("g_boxed_free");
		cl.set_dup_function ("g_boxed_copy");

		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "field") {
				cl.add_field (parse_field ());
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				cl.add_method (parse_method ("method"));
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `class'".printf (reader.name));
				break;
			}
		}

		if (current_token != MarkupTokenType.END_ELEMENT) {
			// error
			Report.error (get_current_src (), "expected end element");
		}
		next ();
		return cl;
	}

	Struct parse_union () {
		start_element ("union");
		var st = new Struct (reader.get_attribute ("name"), get_current_src ());
		st.access = SymbolAccessibility.PUBLIC;
		st.external = true;
		next ();

		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (reader.get_attribute ("introspectable") == "0") {
				skip_element ();
				continue;
			}

			if (reader.name == "field") {
				st.add_field (parse_field ());
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				st.add_method (parse_method ("method"));
			} else if (reader.name == "record") {
				Struct s = parse_record ();
				var fs = s.get_fields ();
				foreach (var f in fs) {
					f.set_cname (s.get_cname () + "." + f.get_cname ());
					f.name = s.name + "_" + f.name;
					st.add_field (f);
				}
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `union'".printf (reader.name));
				break;
			}
		}

		end_element ("union");
		return st;
	}

	Constant parse_constant () {
		start_element ("constant");
		string name = reader.get_attribute ("name");
		next ();
		var type = parse_type ();
		var c = new Constant (name, type, null, get_current_src ());
		c.access = SymbolAccessibility.PUBLIC;
		c.external = true;
		end_element ("constant");
		return c;
	}

	/* Post-parsing */

	void resolve_gir_symbols () {
		// we are remapping unresolved symbols, so create them from concrete symbols
		foreach (var map_from in concrete_symbols_map.get_keys ()) {
			unresolved_symbols_map[get_unresolved_symbol(map_from)] = concrete_symbols_map[map_from];
		}

		// gir has simple namespaces, we won't get deeper than 2 levels here, except reparenting
		foreach (var map_from in unresolved_gir_symbols) {
			while (map_from != null) {
				var map_to = unresolved_symbols_map[map_from];
				if (map_to != null) {
					// remap the original symbol to match the target
					map_from.inner = null;
					map_from.name = map_to.name;
					if (map_to is UnresolvedSymbol) {
						var umap_to = (UnresolvedSymbol) map_to;
						while (umap_to.inner != null) {
							umap_to = umap_to.inner;
							map_from.inner = new UnresolvedSymbol (null, umap_to.name);
							map_from = map_from.inner;
						}
					} else {
						while (map_to.parent_symbol != null && map_to.parent_symbol != context.root) {
							map_to = map_to.parent_symbol;
							map_from.inner = new UnresolvedSymbol (null, map_to.name);
							map_from = map_from.inner;
						}
					}
					break;
				}
				map_from = map_from.inner;
			}
		}
	}

	Symbol? resolve_symbol (Scope parent_scope, UnresolvedSymbol unresolved_symbol) {
		// simple symbol resolver, enough for gir
		if (unresolved_symbol.inner == null) {
			var scope = parent_scope;
			while (scope != null) {
				var sym = scope.lookup (unresolved_symbol.name);
				if (sym != null) {
					return sym;
				}
				scope = scope.parent_scope;
			}
		} else {
			var inner = resolve_symbol (parent_scope, unresolved_symbol.inner);
			if (inner != null) {
				return inner.scope.lookup (unresolved_symbol.name);
			}
		}
		return null;
	}

	void postprocess_gtype_callbacks () {
		foreach (CallbackScope callback_scope in gtype_callbacks.get_keys ()) {
			var gtype = resolve_symbol (callback_scope.parent_namespace.scope, callback_scope.gtype_struct_for) as ObjectTypeSymbol;
			if (gtype == null) {
				Report.error (null, "unknown symbol `%s'".printf (callback_scope.gtype_struct_for.to_string ()));
				continue;
			}
			ArrayList<Delegate> callbacks = gtype_callbacks.get (callback_scope);
			foreach (Delegate d in callbacks) {
				var symbol = gtype.scope.lookup (d.name);
				if (symbol == null) {
					continue;
				} else if (symbol is Method)  {
					var meth = (Method) symbol;
					if (gtype is Class) {
						meth.is_virtual = true;
					} else if (gtype is Interface) {
						meth.is_abstract = true;
					}
				} else if (symbol is Signal) {
					var sig = (Signal) symbol;
					sig.is_virtual = true;
					assume_parameter_names (sig, d);
				} else if (symbol is Property) {
					var prop = (Property) symbol;
					prop.is_virtual = true;
				} else {
					Report.error (get_current_src (), "unknown member type `%s' in `%s'".printf (d.name, gtype.name));
				}
			}
		}
	}

	/* Hash and equal functions */

	static uint unresolved_symbol_hash (void *ptr) {
		var sym = (UnresolvedSymbol) ptr;
		var builder = new StringBuilder ();
		while (sym != null) {
			builder.append (sym.name);
			sym = sym.inner;
		}
		return builder.str.hash ();
	}

	static bool unresolved_symbol_equal (void *ptr1, void *ptr2) {
		var sym1 = (UnresolvedSymbol) ptr1;
		var sym2 = (UnresolvedSymbol) ptr2;
		while (sym1 != sym2) {
			if (sym1 == null || sym2 == null) {
				return false;
			}
			if (sym1.name != sym2.name) {
				return false;
			}
			sym1 = sym1.inner;
			sym2 = sym2.inner;
		}
		return true;
	}

	static uint callback_scope_hash (void *ptr) {
		var cs = (CallbackScope) ptr;
		return unresolved_symbol_hash (cs.gtype_struct_for);
	}

	static bool callback_scope_equal (void *ptr1, void *ptr2) {
		var cs1 = (CallbackScope) ptr1;
		var cs2 = (CallbackScope) ptr2;
		return cs1.parent_namespace == cs2.parent_namespace && unresolved_symbol_equal (cs1.gtype_struct_for, cs2.gtype_struct_for);
	}
}
