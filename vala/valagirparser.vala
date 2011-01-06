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
 *
 * Pipeline:
 * 1) Parse metadata
 * 2) Parse GIR with metadata, track unresolved GIR symbols, create symbol mappings
 * 3) Reconciliate the tree by mapping tracked symbols
 * 4) Reparent nodes
 * 5) Process callbacks/virtual
 * 6) Process aliases
 * 7) Autoreparent static methods
 *
 * Best hacking practices:
 * - Keep GIR parsing bloat-free, it must contain the logic
 * - Prefer being clean / short over performance
 * - Try to make things common as much as possible
 * - Prefer replace/merge after parse rather than a bunch of if-then-else and hardcoding
 * - Prefer postprocessing over hardcoding the parser
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
		ARRAY_LENGTH_IDX,
		DEFAULT,
		OUT,
		REF,
		VFUNC_NAME,
		VIRTUAL,
		ABSTRACT,
		SCOPE;

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
			var unary = get_expression (arg) as UnaryExpression;
			if (unary != null && unary.operator == UnaryOperator.MINUS) {
				var lit = unary.inner as IntegerLiteral;
				if (lit != null) {
					return -int.parse (lit.value);
				}
			} else {
				var lit = get_expression (arg) as IntegerLiteral;
				if (lit != null) {
					return int.parse (lit.value);
				}
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
			return ((string) begin.pos).substring (0, (int) (end.pos - begin.pos));
		}

		MetadataType? parse_metadata_access () {
			switch (current) {
			case TokenType.DOT:
				next ();
				return MetadataType.GENERIC;
			case TokenType.COLON:
				next ();
				return MetadataType.PROPERTY;
			case TokenType.DOUBLE_COLON:
				next ();
				return MetadataType.SIGNAL;
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
					case TokenType.VIRTUAL:
					case TokenType.ABSTRACT:
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

		Expression? parse_expression () {
			var begin = this.begin;
			var src = get_current_src ();
			Expression expr = null;
			switch (current) {
			case TokenType.NULL:
				expr = new NullLiteral (src);
				break;
			case TokenType.TRUE:
				expr = new BooleanLiteral (true, src);
				break;
			case TokenType.FALSE:
				expr = new BooleanLiteral (false, src);
				break;
			case TokenType.MINUS:
				next ();
				var inner = parse_expression ();
				if (inner == null) {
					Report.error (src, "expected expression after `-', got `%s'".printf (current.to_string ()));
				} else {
					expr = new UnaryExpression (UnaryOperator.MINUS, inner, get_src (begin));
				}
				return expr;
			case TokenType.INTEGER_LITERAL:
				expr = new IntegerLiteral (get_string (), src);
				break;
			case TokenType.REAL_LITERAL:
				expr = new RealLiteral (get_string (), src);
				break;
			case TokenType.STRING_LITERAL:
				expr = new StringLiteral (get_string (), src);
				break;
			case TokenType.IDENTIFIER:
				expr = new MemberAccess (null, get_string (), src);
				while (next () == TokenType.DOT) {
					if (next () != TokenType.IDENTIFIER) {
						Report.error (get_current_src (), "expected identifier got `%s'".printf (current.to_string ()));
						break;
					}
					expr = new MemberAccess (expr, get_string (), get_current_src ());
				}
				return expr;
			default:
				Report.error (src, "expected literal or symbol got `%s'".printf (current.to_string ()));
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

				Expression expr = parse_expression ();
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

	class SymbolInfo {
		public Symbol symbol;
		public Metadata metadata;
		// additional information from GIR
		public HashMap<string,string> girdata;
	}

	class Alias {
		public string name;
		public string cname;
		public DataType base_type;
		public Symbol parent_symbol;
		public SourceReference source_reference;
	}

	static GLib.Regex type_from_string_regex;

	MarkupReader reader;

	CodeContext context;
	Namespace glib_ns;

	SourceFile current_source_file;
	Symbol current_symbol;

	string current_gtype_struct_for;
	SourceLocation begin;
	SourceLocation end;
	MarkupTokenType current_token;

	string[] cheader_filenames;

	ArrayList<Metadata> metadata_stack;
	Metadata metadata;
	ArrayList<HashMap<string,string>> girdata_stack;
	HashMap<string,string> girdata;

	ArrayList<SymbolInfo> current_symbols_info;

	HashMap<UnresolvedSymbol,Symbol> unresolved_symbols_map = new HashMap<UnresolvedSymbol,Symbol> (unresolved_symbol_hash, unresolved_symbol_equal);
	HashMap<Symbol,Symbol> concrete_symbols_map = new HashMap<Symbol,Symbol> ();

	ArrayList<UnresolvedSymbol> unresolved_gir_symbols = new ArrayList<UnresolvedSymbol> ();
	HashMap<UnresolvedSymbol,ArrayList<Symbol>> symbol_reparent_map = new HashMap<UnresolvedSymbol,ArrayList<Symbol>> (unresolved_symbol_hash, unresolved_symbol_equal);
	HashMap<Namespace,ArrayList<Method>> namespace_methods = new HashMap<Namespace,ArrayList<Method>> ();
	ArrayList<Alias> aliases = new ArrayList<Alias> ();
	ArrayList<Interface> interfaces = new ArrayList<Interface> ();

	HashMap<UnresolvedSymbol,ArrayList<Delegate>> gtype_callbacks;

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

		postprocess_interfaces ();
		postprocess_reparenting ();
		postprocess_aliases ();
		postprocess_namespace_methods ();
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
		metadata_stack = new ArrayList<Metadata> ();
		metadata = Metadata.empty;
		girdata_stack = new ArrayList<HashMap<string,string>> ();

		// load metadata, first look into metadata directories then in the same directory of the .gir.
		string? metadata_filename = context.get_metadata_path (source_file.filename);
		if (metadata_filename != null && FileUtils.test (metadata_filename, FileTest.EXISTS)) {
			var metadata_parser = new MetadataParser ();
			var metadata_file = new SourceFile (context, source_file.file_type, metadata_filename);
			context.add_source_file (metadata_file);
			metadata = metadata_parser.parse_metadata (metadata_file);
		}

		this.current_source_file = source_file;
		reader = new MarkupReader (source_file.filename);

		// xml prolog
		next ();
		next ();

		next ();
		parse_repository ();

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

	void add_symbol_to_container (Symbol container, Symbol sym) {
		var name = sym.name;
		if (name == null && sym is CreationMethod) {
			name = ".new";
		}
		if (container.scope.lookup (name) != null) {
			// overridden by -custom.vala
			return;
		}

		if (container is Class) {
			unowned Class cl = (Class) container;

			if (sym is Class) {
				cl.add_class ((Class) sym);
			} else if (sym is Constant) {
				cl.add_constant ((Constant) sym);
			} else if (sym is Enum) {
				cl.add_enum ((Enum) sym);
			} else if (sym is Field) {
				cl.add_field ((Field) sym);
			} else if (sym is Method) {
				cl.add_method ((Method) sym);
			} else if (sym is Property) {
				cl.add_property ((Property) sym);
			} else if (sym is Signal) {
				cl.add_signal ((Signal) sym);
			} else if (sym is Struct) {
				cl.add_struct ((Struct) sym);
			}
		} else if (container is Enum) {
			unowned Enum en = (Enum) container;

			if (sym is EnumValue) {
				en.add_value ((EnumValue) sym);
			} else if (sym is Constant) {
				en.add_constant ((Constant) sym);
			} else if (sym is Method) {
				en.add_method ((Method) sym);
			}
		} else if (container is Interface) {
			unowned Interface iface = (Interface) container;

			if (sym is Class) {
				iface.add_class ((Class) sym);
			} else if (sym is Constant) {
				iface.add_constant ((Constant) sym);
			} else if (sym is Enum) {
				iface.add_enum ((Enum) sym);
			} else if (sym is Field) {
				iface.add_field ((Field) sym);
			} else if (sym is Method) {
				iface.add_method ((Method) sym);
			} else if (sym is Property) {
				iface.add_property ((Property) sym);
			} else if (sym is Signal) {
				iface.add_signal ((Signal) sym);
			} else if (sym is Struct) {
				iface.add_struct ((Struct) sym);
			}
		} else if (container is Namespace) {
			unowned Namespace ns = (Namespace) container;

			if (sym is Namespace) {
				ns.add_namespace ((Namespace) sym);
			} else if (sym is Class) {
				ns.add_class ((Class) sym);
			} else if (sym is Constant) {
				ns.add_constant ((Constant) sym);
			} else if (sym is Delegate) {
				ns.add_delegate ((Delegate) sym);
			} else if (sym is Enum) {
				ns.add_enum ((Enum) sym);
			} else if (sym is ErrorDomain) {
				ns.add_error_domain ((ErrorDomain) sym);
			} else if (sym is Field) {
				ns.add_field ((Field) sym);
			} else if (sym is Interface) {
				ns.add_interface ((Interface) sym);
			} else if (sym is Method) {
				ns.add_method ((Method) sym);
			} else if (sym is Namespace) {
				ns.add_namespace ((Namespace) sym);
			} else if (sym is Struct) {
				ns.add_struct ((Struct) sym);
			}
		} else if (container is Struct) {
			unowned Struct st = (Struct) container;

			if (sym is Constant) {
				st.add_constant ((Constant) sym);
			} else if (sym is Field) {
				st.add_field ((Field) sym);
			} else if (sym is Method) {
				st.add_method ((Method) sym);
			} else if (sym is Property) {
				st.add_property ((Property) sym);
			}
		} else {
			Report.error (sym.source_reference, "impossible to add to container `%s'".printf (container.name));
		}
	}

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

	void assume_parameter_names (Signal sig, Symbol sym, bool skip_first) {
		Iterator<Parameter> iter;
		if (sym is Method) {
			iter = ((Method) sym).get_parameters ().iterator ();
		} else {
			iter = ((Delegate) sym).get_parameters ().iterator ();
		}
		bool first = true;
		foreach (var param in sig.get_parameters ()) {
			if (!iter.next ()) {
				// unreachable for valid GIR
				break;
			}
			if (skip_first && first) {
				if (!iter.next ()) {
					// unreachable for valid GIR
					break;
				}
				first = false;
			}
			param.name = iter.get ().name;
		}
	}

	SymbolInfo? add_symbol_info (Symbol symbol) {
		var name = symbol.name;
		if (symbol is CreationMethod && name == null) {
			name = ".new";
		}

		var info = new SymbolInfo ();
		info.symbol = symbol;
		info.metadata = metadata;
		info.girdata = girdata;
		current_symbols_info.add (info);
		return info;
	}

	ArrayList<SymbolInfo> get_colliding_symbols_info (SymbolInfo info) {
		var name = info.symbol.name;
		if (name == null && info.symbol is CreationMethod) {
			name = ".new";
		}
		var result = new ArrayList<SymbolInfo> ();
		foreach (var cinfo in current_symbols_info) {
			if (cinfo.symbol.name == name) {
				result.add (cinfo);
			}
		}
		return result;
	}

	SymbolInfo? get_current_first_symbol_info (string name) {
		foreach (var info in current_symbols_info) {
			if (info.symbol.name == name) {
				return info;
			}
		}
		return null;
	}

	Symbol? get_current_first_symbol (string name) {
		var info = get_current_first_symbol_info (name);
		if (info != null) {
			return info.symbol;
		}
		return null;
	}

	SymbolInfo? find_invoker (Method method) {
		/* most common use case is invoker has at least the given method prefix
		   and the same parameter names */
		var prefix = "%s_".printf (method.name);
		foreach (var info in current_symbols_info) {
			if (!info.symbol.name.has_prefix (prefix)) {
				continue;
			}
			Method? invoker = info.symbol as Method;
			if (invoker == null || (method.get_parameters ().size != invoker.get_parameters ().size)) {
				continue;
			}
			var iter = invoker.get_parameters ().iterator ();
			foreach (var param in method.get_parameters ()) {
				assert (iter.next ());
				if (param.name != iter.get ().name)	{
					invoker = null;
					break;
				}
			}
			if (invoker != null) {
				return info;
			}
		}

		return null;
	}

	void merge (SymbolInfo info, ArrayList<SymbolInfo> colliding, HashSet<SymbolInfo> merged) {
		if (info.symbol is Struct) {
			var gtype_struct_for = info.girdata["glib:is-gtype-struct-for"];
			if (gtype_struct_for != null) {
				var iface = get_current_first_symbol (gtype_struct_for) as Interface;
				if (iface != null) {
					// set the interface struct name
					iface.set_type_cname (((Struct) info.symbol).get_cname ());
				}
				merged.add (info);
			}
		} else if (info.symbol is Property) {
			var prop = (Property) info.symbol;
			foreach (var cinfo in colliding) {
				var sym = cinfo.symbol;
				if (sym is Signal || sym is Field) {
					// properties take precedence
					merged.add (cinfo);
				} else if (sym is Method) {
					// assume method is getter
					merged.add (cinfo);
				}
			}
			var getter_name = "get_%s".printf (prop.name);
			var setter_name = "set_%s".printf (prop.name);
			if (prop.get_accessor != null) {
				var getter_method = get_current_first_symbol (getter_name) as Method;
				if (getter_method != null) {
					prop.no_accessor_method = false;
					prop.get_accessor.value_type.value_owned = getter_method.return_type.value_owned;
				}
			} else if (prop.set_accessor != null && get_current_first_symbol_info (setter_name) != null) {
				prop.no_accessor_method = false;
			}
		} else if (info.symbol is Signal) {
			var sig = (Signal) info.symbol;
			foreach (var cinfo in colliding) {
				var sym = cinfo.symbol;
				if (sym is Method) {
					var method = (Method) sym;
					if (method.is_virtual) {
						sig.is_virtual = true;
					} else {
						sig.has_emitter = true;
					}
					assume_parameter_names (sig, method, false);
					merged.add (cinfo);
				} else if (sym is Field) {
					merged.add (cinfo);
				}
			}
		} else if (info.symbol is Method && !(info.symbol is CreationMethod)) {
			var m = (Method) info.symbol;
			foreach (var cinfo in colliding) {
				var sym = cinfo.symbol;
				if (sym != m && m.is_virtual && sym is Method) {
					bool different_invoker = false;
					foreach (var attr in m.attributes) {
						if (attr.name == "NoWrapper") {
							/* no invoker but this method has the same name,
							   most probably the invoker has a different name
							   and g-ir-scanner missed it */
							var invoker = find_invoker (m);
							if (invoker != null) {
								m.vfunc_name = m.name;
								m.name = invoker.symbol.name;
								m.attributes.remove (attr);
								merged.add (invoker);
								different_invoker = true;
							}
							break;
						}
					}
					if (!different_invoker) {
						merged.add (cinfo);
					}
				}
			}
			// merge custom vfunc
			if (info.metadata.has_argument (ArgumentType.VFUNC_NAME)) {
				var vfunc = get_current_first_symbol_info (info.metadata.get_string (ArgumentType.VFUNC_NAME));
				if (vfunc != null && vfunc != info) {
					merged.add (vfunc);
				}
			}
			if (m.coroutine) {
				// handle async methods
				string finish_method_base;
				if (m.name.has_suffix ("_async")) {
					finish_method_base = m.name.substring (0, m.name.length - "_async".length);
				} else {
					finish_method_base = m.name;
				}
				var finish_method_info = get_current_first_symbol_info (finish_method_base + "_finish");

				// check if the method is using non-standard finish method name
				if (finish_method_info == null) {
					var method_cname = m.get_finish_cname ();
					foreach (var minfo in current_symbols_info) {
						if (minfo.symbol is Method && ((Method) minfo.symbol).get_cname () == method_cname) {
							finish_method_info = minfo;
							break;
						}
					}
				}

				if (finish_method_info != null && finish_method_info.symbol is Method) {
					var finish_method = (Method) finish_method_info.symbol;
					Method method;
					if (finish_method is CreationMethod) {
						method = new CreationMethod (((CreationMethod) finish_method).class_name, null, m.source_reference);
						method.access = m.access;
						method.binding = m.binding;
						method.external = true;
						method.coroutine = true;
						method.has_construct_function = finish_method.has_construct_function;
						method.attributes = m.attributes.copy ();
						method.set_cname (m.get_cname ());
						if (finish_method_base == "new") {
							method.name = null;
						} else if (finish_method_base.has_prefix ("new_")) {
							method.name = m.name.substring ("new_".length);
						}
						foreach (var param in m.get_parameters ()) {
							method.add_parameter (param);
						}
						info.symbol = method;
					} else {
						method = m;
					}
					method.return_type = finish_method.return_type.copy ();
					method.no_array_length = finish_method.no_array_length;
					method.array_null_terminated = finish_method.array_null_terminated;
					foreach (var param in finish_method.get_parameters ()) {
						if (param.direction == ParameterDirection.OUT) {
							var async_param = param.copy ();
							if (method.scope.lookup (param.name) != null) {
								// parameter name conflict
								async_param.name += "_out";
							}
							method.add_parameter (async_param);
						}
					}
					foreach (DataType error_type in finish_method.get_error_types ()) {
						method.add_error_type (error_type.copy ());
					}
					merged.add (finish_method_info);
				}
			}
		} else if (info.symbol is Field) {
			foreach (var cinfo in colliding) {
				var sym = cinfo.symbol;
				if (sym is Method) {
					// assume method is getter
					merged.add (cinfo);
				}
			}

			var field = (Field) info.symbol;
			if (field.variable_type is ArrayType) {
				var array_length = get_current_first_symbol_info ("n_%s".printf (field.name));
				if (array_length == null) {
					array_length = get_current_first_symbol_info ("%s_length".printf (field.name));
				}
				if (array_length != null) {
					// array has length
					field.set_array_length_cname (array_length.symbol.name);
					field.no_array_length = false;
					merged.add (array_length);
				}
			}
		}
	}

	void postprocess_symbol (Symbol sym, Metadata metadata) {
		// deprecation
		sym.replacement = metadata.get_string (ArgumentType.REPLACEMENT);
		sym.deprecated_since = element_get_string ("deprecated-version", ArgumentType.DEPRECATED_SINCE);
		sym.deprecated = metadata.get_bool (ArgumentType.DEPRECATED) || sym.replacement != null || sym.deprecated_since != null;

		// cheader filename
		var cheader_filename = metadata.get_string (ArgumentType.CHEADER_FILENAME);
		if (cheader_filename != null) {
			foreach (string filename in cheader_filename.split (",")) {
				sym.add_cheader_filename (filename);
			}
		}

		// mark to be reparented
		if (metadata.has_argument (ArgumentType.PARENT)) {
			var target_symbol = parse_symbol_from_string (metadata.get_string (ArgumentType.PARENT), metadata.get_source_reference (ArgumentType.PARENT));
			var reparent_list = symbol_reparent_map[target_symbol];
			if (reparent_list == null) {
				reparent_list = new ArrayList<Symbol>();
				symbol_reparent_map[target_symbol] = reparent_list;
			}
			reparent_list.add (sym);

			// if referenceable, map unresolved references to point to the new place
			if (sym is Namespace || sym is TypeSymbol) {
				set_symbol_mapping (sym, new UnresolvedSymbol (target_symbol, sym.name));
			}
		}

		if (sym is Class) {
			var cl = (Class) sym;
			if (cl.default_construction_method == null) {
				// always provide constructor in generated bindings
				// to indicate that implicit Object () chainup is allowed
				var cm = new CreationMethod (null, null, cl.source_reference);
				cm.has_construct_function = false;
				cm.access = SymbolAccessibility.PROTECTED;
				cl.add_method (cm);
			}
		}
	}

	void merge_add_process (Symbol container) {
		var merged = new HashSet<SymbolInfo> ();
		foreach (var info in current_symbols_info) {
			merge (info, get_colliding_symbols_info (info), merged);
		}

		foreach (var info in current_symbols_info) {
			if (merged.contains (info) || info.metadata.get_bool (ArgumentType.HIDDEN)) {
				continue;
			}
			if (!(current_symbol is Namespace && info.symbol is Method) && !info.metadata.has_argument (ArgumentType.PARENT)) {
				add_symbol_to_container (container, info.symbol);
			}
			postprocess_symbol (info.symbol, info.metadata);
		}
	}

	Metadata get_current_metadata () {
		var name = reader.name;
		var child_name = reader.get_attribute ("name");
		if (child_name == null) {
			return Metadata.empty;
		}

		var type = MetadataType.GENERIC;
		if (name == "glib:signal") {
			child_name = child_name.replace ("-", "_");
			type = MetadataType.SIGNAL;
		} else if (name == "property") {
			type = MetadataType.PROPERTY;
		}

		return metadata.match_child (child_name, type);
	}

	bool push_metadata () {
		var new_metadata = get_current_metadata ();
		// skip ?
		if (new_metadata.has_argument (ArgumentType.SKIP)) {
			if (new_metadata.get_bool (ArgumentType.SKIP)) {
				return false;
			}
		} else if (reader.get_attribute ("introspectable") == "0") {
			return false;
		}

		metadata_stack.add (metadata);
		metadata = new_metadata;
		girdata_stack.add (girdata);
		girdata = new HashMap<string,string> (str_hash, str_equal);

		return true;
	}

	void pop_metadata () {
		metadata = metadata_stack[metadata_stack.size - 1];
		metadata_stack.remove_at (metadata_stack.size - 1);
		girdata = girdata_stack[girdata_stack.size - 1];
		girdata_stack.remove_at (girdata_stack.size - 1);
	}

	bool parse_type_arguments_from_string (DataType parent_type, string type_arguments, SourceReference? source_reference = null) {
		int type_arguments_length = (int) type_arguments.length;
		GLib.StringBuilder current = new GLib.StringBuilder.sized (type_arguments_length);

		int depth = 0;
		for (var c = 0 ; c < type_arguments_length ; c++) {
			if (type_arguments[c] == '<' || type_arguments[c] == '[') {
				depth++;
				current.append_unichar (type_arguments[c]);
			} else if (type_arguments[c] == '>' || type_arguments[c] == ']') {
				depth--;
				current.append_unichar (type_arguments[c]);
			} else if (type_arguments[c] == ',') {
				if (depth == 0) {
					var dt = parse_type_from_string (current.str, true, source_reference);
					if (dt == null) {
						return false;
					}
					parent_type.add_type_argument (dt);
					current.truncate ();
				} else {
					current.append_unichar (type_arguments[c]);
				}
			} else {
				current.append_unichar (type_arguments[c]);
			}
		}

		var dt = parse_type_from_string (current.str, true, source_reference);
		if (dt == null) {
			return false;
		}
		parent_type.add_type_argument (dt);

		return true;
	}

	DataType? parse_type_from_string (string type_string, bool owned_by_default, SourceReference? source_reference = null) {
		if (type_from_string_regex == null) {
			try {
				type_from_string_regex = new GLib.Regex ("^(?:(owned|unowned|weak) +)?([0-9a-zA-Z_\\.]+)(?:<(.+)>)?(\\*+)?(\\[,*\\])?(\\?)?$", GLib.RegexCompileFlags.ANCHORED | GLib.RegexCompileFlags.DOLLAR_ENDONLY | GLib.RegexCompileFlags.OPTIMIZE);
			} catch (GLib.RegexError e) {
				GLib.error ("Unable to compile regex: %s", e.message);
			}
		}

		GLib.MatchInfo match;
		if (!type_from_string_regex.match (type_string, 0, out match)) {
			Report.error (source_reference, "unable to parse type");
			return null;
		}

		DataType? type = null;

		var ownership_data = match.fetch (1);
		var type_name = match.fetch (2);
		var type_arguments_data = match.fetch (3);
		var pointers_data = match.fetch (4);
		var array_data = match.fetch (5);
		var nullable_data = match.fetch (6);

		var nullable = nullable_data != null && nullable_data.length > 0;

		if (ownership_data == null && type_name == "void") {
			if (array_data == null && !nullable) {
				type = new VoidType (source_reference);
				if (pointers_data != null) {
					for (int i=0; i < pointers_data.length; i++) {
						type = new PointerType (type);
					}
				}
				return type;
			} else {
				Report.error (source_reference, "invalid void type");
				return null;
			}
		}

		bool value_owned = owned_by_default;

		if (ownership_data == "owned") {
			if (owned_by_default) {
				Report.error (source_reference, "unexpected `owned' keyword");
			} else {
				value_owned = true;
			}
		} else if (ownership_data == "unowned") {
			if (owned_by_default) {
				value_owned = false;
			} else {
				Report.error (source_reference, "unexpected `unowned' keyword");
				return null;
			}
		}

		var sym = parse_symbol_from_string (type_name, source_reference);
		if (sym == null) {
			return null;
		}
		type = new UnresolvedType.from_symbol (sym, source_reference);

		if (type_arguments_data != null && type_arguments_data.length > 0) {
			if (!parse_type_arguments_from_string (type, type_arguments_data, source_reference)) {
				return null;
			}
		}

		if (pointers_data != null) {
			for (int i=0; i < pointers_data.length; i++) {
				type = new PointerType (type);
			}
		}

		if (array_data != null) {
			type = new ArrayType (type, (int) array_data.length - 1, source_reference);
		}

		type.nullable = nullable;
		type.value_owned = value_owned;
		return type;
	}

	string? element_get_string (string attribute_name, ArgumentType arg_type) {
		if (metadata.has_argument (arg_type)) {
			return metadata.get_string (arg_type);
		} else {
			return reader.get_attribute (attribute_name);
		}
	}

	/*
	 * The changed is a faster way to check whether the type has changed and it may affect the C declaration.
	 * If type arguments change, the C declaration is not affected.
	 */
	DataType? element_get_type (DataType orig_type, bool owned_by_default, out bool changed = null) {
		changed = false;
		var type = orig_type;

		if (metadata.has_argument (ArgumentType.TYPE)) {
			var new_type = parse_type_from_string (metadata.get_string (ArgumentType.TYPE), owned_by_default, metadata.get_source_reference (ArgumentType.TYPE));
			changed = true;
			return new_type;
		}

		if (type is VoidType) {
			return type;
		}

		if (metadata.has_argument (ArgumentType.TYPE_ARGUMENTS)) {
			type.remove_all_type_arguments ();
			parse_type_arguments_from_string (type, metadata.get_string (ArgumentType.TYPE_ARGUMENTS), metadata.get_source_reference (ArgumentType.TYPE_ARGUMENTS));
		}

		if (metadata.get_bool (ArgumentType.ARRAY)) {
			type = new ArrayType (type, 1, type.source_reference);
			changed = true;
		}

		if (owned_by_default || type.value_owned) {
			if (metadata.has_argument (ArgumentType.UNOWNED)) {
				type.value_owned = !metadata.get_bool (ArgumentType.UNOWNED);
			}
		} else if (!owned_by_default || !type.value_owned) {
			if (metadata.has_argument (ArgumentType.OWNED)) {
				type.value_owned = metadata.get_bool (ArgumentType.OWNED);
			}
		}
		if (metadata.has_argument (ArgumentType.NULLABLE)) {
			type.nullable = metadata.get_bool (ArgumentType.NULLABLE);
		}

		return type;
	}

	string? element_get_name (bool remap = false) {
		var name = reader.get_attribute ("name");
		var orig_name = name;
		var pattern = metadata.get_string (ArgumentType.NAME);
		if (pattern != null) {
			try {
				var regex = new Regex (pattern, RegexCompileFlags.ANCHORED, RegexMatchFlags.ANCHORED);
				GLib.MatchInfo match;
				if (!regex.match (name, 0, out match)) {
					name = pattern;
				} else {
					var matched = match.fetch (1);
					if (matched != null && matched.length > 0) {
						name = matched;
					} else {
						name = pattern;
					}
				}
			} catch (Error e) {
				name = pattern;
			}
		} else {
			if (name != null && name.has_suffix ("Enum")) {
				name = name.substring (0, name.length - "Enum".length);
			}
		}
		if (name != orig_name && remap) {
			set_symbol_mapping (parse_symbol_from_string (orig_name), parse_symbol_from_string (name));
		}

		return name;
	}

	void set_array_ccode (Symbol sym, ParameterInfo info) {
		if (sym is Method) {
			var m = (Method) sym;
			m.carray_length_parameter_position = info.vala_idx;
		} else if (sym is Delegate) {
			var d = (Delegate) sym;
			d.carray_length_parameter_position = info.vala_idx;
		} else {
			var param = (Parameter) sym;
			param.carray_length_parameter_position = info.vala_idx;
			param.set_array_length_cname (info.param.name);
		}
		if (info.param.variable_type.to_qualified_string () != "int") {
			var unresolved_type = (UnresolvedType) info.param.variable_type;
			var resolved_struct = resolve_symbol (glib_ns.scope, unresolved_type.unresolved_symbol) as Struct;
			if (resolved_struct != null) {
				if (sym is Method) {
					var m = (Method) sym;
					m.array_length_type = resolved_struct.get_cname ();
				} else {
					var param = (Parameter) sym;
					param.array_length_type = resolved_struct.get_cname ();
				}
			}
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
				skip_element ();
			}
		}
		end_element ("repository");

		report_unused_metadata (metadata);
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

		var ns_metadata = metadata.match_child (gir_namespace);
		if (ns_metadata.has_argument (ArgumentType.NAME)) {
			namespace_name = ns_metadata.get_string (ArgumentType.NAME);
		}

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

		if (cprefix != null) {
			ns.add_cprefix (cprefix);
			ns.set_lower_case_cprefix (Symbol.camel_case_to_lower_case (cprefix) + "_");
		}

		if (ns_metadata.has_argument (ArgumentType.CHEADER_FILENAME)) {
			var val = ns_metadata.get_string (ArgumentType.CHEADER_FILENAME);
			foreach (string filename in val.split (",")) {
				ns.add_cheader_filename (filename);
			}
		} else {
			foreach (string c_header in cheader_filenames) {
				ns.add_cheader_filename (c_header);
			}
		}

		next ();
		var current_namespace_methods = namespace_methods[ns];
		if (current_namespace_methods == null) {
			current_namespace_methods = new ArrayList<Method> ();
			namespace_methods[ns] = current_namespace_methods;
		}
		var old_symbols_info = current_symbols_info;
		var old_symbol = current_symbol;
		current_symbols_info = new ArrayList<SymbolInfo> ();
		current_symbol = ns;
		gtype_callbacks = new HashMap<UnresolvedSymbol,ArrayList<Delegate>> (unresolved_symbol_hash, unresolved_symbol_equal);
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (!push_metadata ()) {
				skip_element ();
				continue;
			}

			if (reader.name == "alias") {
				var alias = parse_alias ();
				aliases.add (alias);
			} else if (reader.name == "enumeration") {
				if (reader.get_attribute ("glib:error-quark") != null) {
					add_symbol_info (parse_error_domain ());
				} else {
					add_symbol_info (parse_enumeration ());
				}
			} else if (reader.name == "bitfield") {
				add_symbol_info (parse_bitfield ());
			} else if (reader.name == "function") {
				var method = parse_method ("function");
				add_symbol_info (method);
				current_namespace_methods.add (method);
			} else if (reader.name == "callback") {
				add_symbol_info (parse_callback ());
			} else if (reader.name == "record") {
				if (reader.get_attribute ("glib:get-type") != null) {
					add_symbol_info (parse_boxed ("record"));
				} else {
					if (!reader.get_attribute ("name").has_suffix ("Private")) {
						add_symbol_info (parse_record ());
					} else {
						skip_element ();
					}
				}
			} else if (reader.name == "class") {
				add_symbol_info (parse_class ());
			} else if (reader.name == "interface") {
				var iface = parse_interface ();
				add_symbol_info (iface);
				interfaces.add (iface);
			} else if (reader.name == "glib:boxed") {
				add_symbol_info (parse_boxed ("glib:boxed"));
			} else if (reader.name == "union") {
				add_symbol_info (parse_union ());
			} else if (reader.name == "constant") {
				add_symbol_info (parse_constant ());
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `namespace'".printf (reader.name));
				skip_element ();
			}

			pop_metadata ();
		}
		end_element ("namespace");

		merge_add_process (ns);
		current_symbols_info = old_symbols_info;
		current_symbol = old_symbol;
		postprocess_gtype_callbacks (ns);

		if (!new_namespace) {
			ns = null;
		}

		return ns;
	}

	Alias parse_alias () {
		// alias has no type information
		start_element ("alias");
		var alias = new Alias ();
		alias.source_reference = get_current_src ();
		alias.name = reader.get_attribute ("name");
		alias.cname = reader.get_attribute ("c:type");
		alias.parent_symbol = current_symbol;
		next ();

		alias.base_type = element_get_type (parse_type (null, null, true), true);

		end_element ("alias");
		return alias;
	}

	private void calculate_common_prefix (ref string common_prefix, string cname) {
		if (common_prefix == null) {
			common_prefix = cname;
			while (common_prefix.length > 0 && !common_prefix.has_suffix ("_")) {
				// FIXME: could easily be made faster
				common_prefix = common_prefix.substring (0, common_prefix.length - 1);
			}
		} else {
			while (!cname.has_prefix (common_prefix)) {
				common_prefix = common_prefix.substring (0, common_prefix.length - 1);
			}
		}
		while (common_prefix.length > 0 && (!common_prefix.has_suffix ("_") ||
		       (cname.get_char (common_prefix.length).isdigit ()) && (cname.length - common_prefix.length) <= 1)) {
			// enum values may not consist solely of digits
			common_prefix = common_prefix.substring (0, common_prefix.length - 1);
		}
	}

	Symbol parse_enumeration (string element_name = "enumeration", bool error_domain = false) {
		start_element (element_name);

		Symbol sym;
		if (error_domain) {
			sym = new ErrorDomain (element_get_name (true), get_current_src ());
		} else {
			var en = new Enum (element_get_name (), get_current_src ());
			if (element_name == "bitfield") {
				en.is_flags = true;
			}
			sym = en;
		}
		sym.access = SymbolAccessibility.PUBLIC;

		string cname = reader.get_attribute ("c:type");
		string common_prefix = null;

		next ();
		
		var old_symbol = current_symbol;
		current_symbol = sym;
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (!push_metadata ()) {
				skip_element ();
				continue;
			}

			if (reader.name == "member") {
				if (error_domain) {
					ErrorCode ec = parse_error_member ();
					((ErrorDomain) sym).add_code (ec);
					calculate_common_prefix (ref common_prefix, ec.get_cname ());
				} else {
					var ev = parse_enumeration_member ();
					((Enum) sym).add_value (ev);
					calculate_common_prefix (ref common_prefix, ev.get_cname ());
				}
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `%s'".printf (reader.name, element_name));
				skip_element ();
			}

			pop_metadata ();
		}

		if (cname != null) {
			if (sym is Enum) {
				((Enum) sym).set_cname (cname);
				((Enum) sym).set_cprefix (common_prefix);
			} else {
				((ErrorDomain) sym).set_cname (cname);
				((ErrorDomain) sym).set_cprefix (common_prefix);
			}
		}

		end_element (element_name);
		current_symbol = old_symbol;
		return sym;
	}

	ErrorDomain parse_error_domain () {
		return parse_enumeration ("enumeration", true) as ErrorDomain;
	}

	Enum parse_bitfield () {
		return parse_enumeration ("bitfield") as Enum;
	}

	EnumValue parse_enumeration_member () {
		start_element ("member");
		var ev = new EnumValue (reader.get_attribute ("name").up ().replace ("-", "_"), null, get_current_src ());
		ev.set_cname (reader.get_attribute ("c:identifier"));
		next ();
		end_element ("member");
		return ev;
	}

	ErrorCode parse_error_member () {
		start_element ("member");

		ErrorCode ec;
		string name = reader.get_attribute ("name").up ().replace ("-", "_");
		string value = reader.get_attribute ("value");
		if (value != null) {
			ec = new ErrorCode.with_value (name, new IntegerLiteral (value));
		} else {
			ec = new ErrorCode (name);
		}
		ec.set_cname (reader.get_attribute ("c:identifier"));

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
		var type = parse_type (out ctype, null, transfer_elements);
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

		array_length_idx = -1;
		closure_idx = -1;
		destroy_idx = -1;

		start_element ("parameter");
		string name = reader.get_attribute ("name");
		if (name == null) {
			name = default_name;
		}
		string direction = null;
		if (metadata.has_argument (ArgumentType.OUT)) {
			if (metadata.get_bool (ArgumentType.OUT)) {
				direction = "out";
			} // null otherwise
		} else if (metadata.has_argument (ArgumentType.REF)) {
			if (metadata.get_bool (ArgumentType.REF)) {
				direction = "inout";
			} // null otherwise
		} else {
			direction = reader.get_attribute ("direction");
		}
		string transfer = reader.get_attribute ("transfer-ownership");
		string allow_none = reader.get_attribute ("allow-none");

		scope = element_get_string ("scope", ArgumentType.SCOPE);

		string closure = reader.get_attribute ("closure");
		string destroy = reader.get_attribute ("destroy");
		if (closure != null && &closure_idx != null) {
			closure_idx = int.parse (closure);
		}
		if (destroy != null && &destroy_idx != null) {
			destroy_idx = int.parse (destroy);
		}

		next ();
		if (reader.name == "varargs") {
			start_element ("varargs");
			next ();
			param = new Parameter.with_ellipsis (get_current_src ());
			end_element ("varargs");
		} else {
			string ctype;
			var type = parse_type (out ctype, out array_length_idx, transfer == "full");
			if (transfer == "full" || transfer == "container" || destroy != null) {
				type.value_owned = true;
			}
			if (allow_none == "1") {
				type.nullable = true;
			}

			bool changed;
			type = element_get_type (type, false, out changed);
			if (!changed) {
				// discard ctype, duplicated information
				ctype = null;
			}

			if (type is ArrayType && metadata.has_argument (ArgumentType.ARRAY_LENGTH_IDX)) {
				array_length_idx = metadata.get_integer (ArgumentType.ARRAY_LENGTH_IDX);
			}

			param = new Parameter (name, type, get_current_src ());
			param.ctype = ctype;
			if (direction == "out") {
				param.direction = ParameterDirection.OUT;
			} else if (direction == "inout") {
				param.direction = ParameterDirection.REF;
			}
			param.initializer = metadata.get_expression (ArgumentType.DEFAULT);
		}
		end_element ("parameter");
		return param;
	}

	DataType parse_type (out string? ctype = null, out int array_length_index = null, bool transfer_elements = false, out bool no_array_length = null, out bool array_null_terminated = null) {
		bool is_array = false;
		string type_name = reader.get_attribute ("name");

		array_length_index = -1;

		if (reader.name == "array") {
			is_array = true;
			start_element ("array");

			if (type_name == null) {
				if (reader.get_attribute ("length") != null
				    && &array_length_index != null) {
					array_length_index = int.parse (reader.get_attribute ("length"));
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

		ctype = reader.get_attribute("c:type");

		next ();

		if (type_name == "GLib.PtrArray"
		    && current_token == MarkupTokenType.START_ELEMENT) {
			type_name = "GLib.GenericArray";
		}

		DataType type = parse_type_from_gir_name (type_name, out no_array_length, out array_null_terminated, ctype);

		// type arguments / element types
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (type_name == "GLib.ByteArray") {
				skip_element ();
				continue;
			}
			var element_type = parse_type ();
			element_type.value_owned = transfer_elements;
			type.add_type_argument (element_type);
		}

		end_element (is_array ? "array" : "type");
		return type;
	}

	DataType parse_type_from_gir_name (string type_name, out bool no_array_length = null, out bool array_null_terminated = null, string? ctype = null) {
		no_array_length = false;
		array_null_terminated = false;

		DataType type;
		if (type_name == "none") {
			type = new VoidType (get_current_src ());
		} else if (type_name == "gpointer") {
			type = new PointerType (new VoidType (get_current_src ()), get_current_src ());
		} else if (type_name == "GObject.Strv") {
			type = new ArrayType (new UnresolvedType.from_symbol (new UnresolvedSymbol (null, "string")), 1, get_current_src ());
			no_array_length = true;
			array_null_terminated = true;
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
				if (ctype != null && ctype.has_prefix ("gssize")) {
					type_name = "ssize_t";
				} else {
					type_name = "long";
				}
			} else if (type_name == "gulong") {
				if (ctype != null && ctype.has_prefix ("gsize")) {
					type_name = "size_t";
				} else {
					type_name = "ulong";
				}
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
		st.access = SymbolAccessibility.PUBLIC;

		string cname = reader.get_attribute ("c:type");
		if (cname != null) {
			st.set_cname (cname);
		}

		current_gtype_struct_for = reader.get_attribute ("glib:is-gtype-struct-for");
		if (current_gtype_struct_for != null) {
			girdata["glib:is-gtype-struct-for"] = current_gtype_struct_for;
		}

		next ();
		var old_symbols_info = current_symbols_info;
		var old_symbol = current_symbol;
		current_symbols_info = new ArrayList<SymbolInfo> ();
		current_symbol = st;
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (!push_metadata ()) {
				skip_element ();
				continue;
			}

			if (reader.name == "field") {
				if (reader.get_attribute ("name") != "priv") {
					add_symbol_info (parse_field ());
				} else {
					skip_element ();
				}
			} else if (reader.name == "constructor") {
				parse_constructor ();
			} else if (reader.name == "method") {
				add_symbol_info (parse_method ("method"));
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
				skip_element ();
			}

			pop_metadata ();
		}
		end_element ("record");

		merge_add_process (st);
		current_symbols_info = old_symbols_info;
		current_symbol = old_symbol;
		current_gtype_struct_for = null;

		return st;
	}

	Class parse_class () {
		start_element ("class");
		var name = element_get_name ();
		string cname = reader.get_attribute ("c:type");
		string parent = reader.get_attribute ("parent");
		var cl = current_symbol.scope.lookup (name) as Class;
		if (cl == null) {
			cl = new Class (name, get_current_src ());
			cl.access = SymbolAccessibility.PUBLIC;
			cl.external = true;

			if (cname != null) {
				cl.set_cname (cname);
			}
		}
		if (parent != null) {
			cl.add_base_type (parse_type_from_gir_name (parent));
		}

		next ();
		var first_field = true;
		var old_symbol = current_symbol;
		var old_symbols_info = current_symbols_info;
		current_symbols_info = new ArrayList<SymbolInfo> ();
		current_symbol = cl;
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (!push_metadata ()) {
				skip_element ();
				continue;
			}

			if (reader.name == "implements") {
				start_element ("implements");
				cl.add_base_type (parse_type_from_gir_name (reader.get_attribute ("name")));
				next ();
				end_element ("implements");
			} else if (reader.name == "constant") {
				add_symbol_info (parse_constant ());
			} else if (reader.name == "field") {
				if (first_field && parent != null) {
					// first field is guaranteed to be the parent instance
					skip_element ();
				} else {
					if (reader.get_attribute ("name") != "priv") {
						add_symbol_info (parse_field ());
					} else {
						skip_element ();
					}
				}
				first_field = false;
			} else if (reader.name == "property") {
				add_symbol_info (parse_property ());
			} else if (reader.name == "constructor") {
				add_symbol_info (parse_constructor ());
			} else if (reader.name == "function") {
				add_symbol_info (parse_method ("function"));
			} else if (reader.name == "method") {
				add_symbol_info (parse_method ("method"));
			} else if (reader.name == "virtual-method") {
				add_symbol_info (parse_method ("virtual-method"));
			} else if (reader.name == "union") {
				Struct s = parse_union ();
				var s_fields = s.get_fields ();
				foreach (var f in s_fields) {
					f.set_cname (s.get_cname () + "." + f.get_cname ());
					f.name = s.name + "_" + f.name;
					add_symbol_info (f);
				}
			} else if (reader.name == "glib:signal") {
				add_symbol_info (parse_signal ());
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `class'".printf (reader.name));
				skip_element ();
			}

			pop_metadata ();
		}

		merge_add_process (cl);
		current_symbols_info = old_symbols_info;
		current_symbol = old_symbol;

		end_element ("class");
		return cl;
	}

	Interface parse_interface () {
		start_element ("interface");
		var iface = new Interface (element_get_name (), get_current_src ());
		iface.access = SymbolAccessibility.PUBLIC;
		iface.external = true;

		string cname = reader.get_attribute ("c:type");
		if (cname != null) {
			iface.set_cname (cname);
		}

		next ();
		var old_symbol = current_symbol;
		var old_symbols_info = current_symbols_info;
		current_symbol = iface;
		current_symbols_info = new ArrayList<SymbolInfo> ();
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (!push_metadata ()) {
				skip_element ();
				continue;
			}

			if (reader.name == "prerequisite") {
				start_element ("prerequisite");
				iface.add_prerequisite (parse_type_from_gir_name (reader.get_attribute ("name")));
				next ();
				end_element ("prerequisite");
			} else if (reader.name == "field") {
				add_symbol_info (parse_field ());
			} else if (reader.name == "property") {
				add_symbol_info (parse_property ());
			} else if (reader.name == "virtual-method") {
				add_symbol_info (parse_method ("virtual-method"));
			} else if (reader.name == "function") {
				add_symbol_info (parse_method ("function"));
			} else if (reader.name == "method") {
				add_symbol_info (parse_method ("method"));
			} else if (reader.name == "glib:signal") {
				add_symbol_info (parse_signal ());
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `interface'".printf (reader.name));
				skip_element ();
			}

			pop_metadata ();
		}

		merge_add_process (iface);
		current_symbol = old_symbol;
		current_symbols_info = old_symbols_info;

		end_element ("interface");
		return iface;
	}

	Field parse_field () {
		start_element ("field");
		string name = reader.get_attribute ("name");
		string allow_none = reader.get_attribute ("allow-none");
		next ();
		var type = parse_type ();
		type = element_get_type (type, true);
		if (type is DelegateType && current_gtype_struct_for != null) {
			// virtual
			var gtype_struct_for = parse_symbol_from_string (current_gtype_struct_for);
			ArrayList<Delegate> callbacks = gtype_callbacks.get (gtype_struct_for);
			if (callbacks == null) {
				callbacks = new ArrayList<Delegate> ();
				gtype_callbacks.set (gtype_struct_for, callbacks);
			}
			callbacks.add (((DelegateType) type).delegate_symbol);
		}
		var field = new Field (name, type, null, get_current_src ());
		field.access = SymbolAccessibility.PUBLIC;
		field.no_array_length = true;
		field.array_null_terminated = true;
		if (allow_none == "1") {
			type.nullable = true;
		}
		end_element ("field");
		return field;
	}

	Property parse_property () {
		start_element ("property");
		string name = reader.get_attribute ("name").replace ("-", "_");
		string readable = reader.get_attribute ("readable");
		string writable = reader.get_attribute ("writable");
		string construct_ = reader.get_attribute ("construct");
		string construct_only = reader.get_attribute ("construct-only");
		next ();
		bool no_array_length;
		bool array_null_terminated;
		var type = parse_type (null, null, false, out no_array_length, out array_null_terminated);
		var prop = new Property (name, type, null, null, get_current_src ());
		prop.access = SymbolAccessibility.PUBLIC;
		prop.external = true;
		prop.no_accessor_method = true;
		prop.no_array_length = no_array_length;
		prop.array_null_terminated = array_null_terminated;
		if (readable != "0") {
			prop.get_accessor = new PropertyAccessor (true, false, false, prop.property_type.copy (), null, null);
			prop.get_accessor.value_type.value_owned = true;
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

	CreationMethod parse_constructor () {
		return parse_function ("constructor") as CreationMethod;
	}

	class ParameterInfo {
		public ParameterInfo (Parameter param, int array_length_idx, int closure_idx, int destroy_idx) {
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
		// replace is needed for signal names
		string name = element_get_name ().replace ("-", "_");
		string cname = reader.get_attribute ("c:identifier");
		string throws_string = reader.get_attribute ("throws");
		string invoker = reader.get_attribute ("invoker");

		next ();
		DataType return_type;
		string return_ctype = null;
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "return-value") {
			return_type = parse_return_value (out return_ctype);
		} else {
			return_type = new VoidType ();
		}
		return_type = element_get_type (return_type, true);

		Symbol s;

		if (element_name == "callback") {
			s = new Delegate (name, return_type, get_current_src ());
		} else if (element_name == "constructor") {
			if (name == "new") {
				name = null;
			} else if (name.has_prefix ("new_")) {
				name = name.substring ("new_".length);
			}
			var m = new CreationMethod (null, name, get_current_src ());
			m.has_construct_function = false;

			string parent_ctype = null;
			if (current_symbol is Class) {
				parent_ctype = ((Class) current_symbol).get_cname ();
			}
			if (return_ctype != null && (parent_ctype == null || return_ctype != parent_ctype + "*")) {
				m.custom_return_type_cname = return_ctype;
			}
			s = m;
		} else if (element_name == "glib:signal") {
			s = new Signal (name, return_type, get_current_src ());
		} else {
			s = new Method (name, return_type, get_current_src ());
		}

		s.access = SymbolAccessibility.PUBLIC;
		if (cname != null) {
			if (s is Method) {
				((Method) s).set_cname (cname);
			} else if (s is Delegate) {
				((Delegate) s).set_cname (cname);
			}
		}

		s.external = true;

		if (element_name == "virtual-method" || element_name == "callback") {
			if (s is Method) {
				((Method) s).is_virtual = true;
				if (invoker == null && !metadata.has_argument (ArgumentType.VFUNC_NAME)) {
					s.attributes.append (new Attribute ("NoWrapper", s.source_reference));
				}
			}

			if (invoker != null) {
				s.name = invoker;
			}
		} else if (element_name == "function") {
			((Method) s).binding = MemberBinding.STATIC;
		}

		if (s is Method && !(s is CreationMethod)) {
			var method = (Method) s;
			if (metadata.has_argument (ArgumentType.VIRTUAL)) {
				method.is_virtual = metadata.get_bool (ArgumentType.VIRTUAL);
				method.is_abstract = false;
			} else if (metadata.has_argument (ArgumentType.ABSTRACT)) {
				method.is_abstract = metadata.get_bool (ArgumentType.ABSTRACT);
				method.is_virtual = false;
			}
			if (metadata.has_argument (ArgumentType.VFUNC_NAME)) {
				method.vfunc_name = metadata.get_string (ArgumentType.VFUNC_NAME);
				method.is_virtual = true;
			}
		}

		var parameters = new ArrayList<ParameterInfo> ();
		var array_length_parameters = new ArrayList<int> ();
		var closure_parameters = new ArrayList<int> ();
		var destroy_parameters = new ArrayList<int> ();
		if (current_token == MarkupTokenType.START_ELEMENT && reader.name == "parameters") {
			start_element ("parameters");
			next ();

			while (current_token == MarkupTokenType.START_ELEMENT) {
				if (!push_metadata ()) {
					skip_element ();
					continue;
				}

				int array_length_idx, closure_idx, destroy_idx;
				string scope;
				string default_param_name = null;
				default_param_name = "arg%d".printf (parameters.size);
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

				var info = new ParameterInfo(param, array_length_idx, closure_idx, destroy_idx);

				if (s is Method && scope == "async") {
					var unresolved_type = param.variable_type as UnresolvedType;
					if (unresolved_type != null && unresolved_type.unresolved_symbol.name == "AsyncReadyCallback") {
						// GAsync-style method
						((Method) s).coroutine = true;
						info.keep = false;
					}
				}

				parameters.add (info);
				pop_metadata ();
			}
			end_element ("parameters");
		}
		var array_length_idx = -1;
		if (return_type is ArrayType && metadata.has_argument (ArgumentType.ARRAY_LENGTH_IDX)) {
			array_length_idx = metadata.get_integer (ArgumentType.ARRAY_LENGTH_IDX);
			parameters[array_length_idx].keep = false;
			array_length_parameters.add (array_length_idx);
		}

		int i = 0, j=1;

		int last = -1;
		foreach (ParameterInfo info in parameters) {
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

		foreach (ParameterInfo info in parameters) {
			if (info.keep) {

				/* add_parameter sets carray_length_parameter_position and cdelegate_target_parameter_position
				 so do it first*/
				if (s is Method) {
					((Method) s).add_parameter (info.param);
				} else if (s is Delegate) {
					((Delegate) s).add_parameter (info.param);
				} else if (s is Signal) {
					((Signal) s).add_parameter (info.param);
				}

				if (info.array_length_idx != -1) {
					if ((info.array_length_idx) >= parameters.size) {
						Report.error (get_current_src (), "invalid array_length index");
						continue;
					}
					set_array_ccode (info.param, parameters[info.array_length_idx]);
				} else if (info.param.variable_type is ArrayType) {
					info.param.no_array_length = true;
					info.param.array_null_terminated = true;
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
		if (array_length_idx != -1) {
			if (array_length_idx >= parameters.size) {
				Report.error (get_current_src (), "invalid array_length index");
			} else {
				set_array_ccode (s, parameters[array_length_idx]);
			}
		} else if (return_type is ArrayType) {
			if (s is Method) {
				var m = (Method) s;
				m.no_array_length = true;
				m.array_null_terminated = true;
			} else if (s is Delegate) {
				var d = (Delegate) s;
				d.no_array_length = true;
				d.array_null_terminated = true;
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
		return this.parse_function ("glib:signal") as Signal;
	}

	Class parse_boxed (string element_name) {
		start_element (element_name);
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
		var old_symbols_info = current_symbols_info;
		var old_symbol = current_symbol;
		current_symbols_info = new ArrayList<SymbolInfo> ();
		current_symbol = cl;
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (!push_metadata ()) {
				skip_element ();
				continue;
			}

			if (reader.name == "field") {
				add_symbol_info (parse_field ());
			} else if (reader.name == "constructor") {
				add_symbol_info (parse_constructor ());
			} else if (reader.name == "method") {
				add_symbol_info (parse_method ("method"));
			} else {
				// error
				Report.error (get_current_src (), "unknown child element `%s' in `class'".printf (reader.name));
				skip_element ();
			}

			pop_metadata ();
		}
		end_element (element_name);

		merge_add_process (cl);
		current_symbols_info = old_symbols_info;
		current_symbol = old_symbol;

		return cl;
	}

	Struct parse_union () {
		start_element ("union");
		var st = new Struct (reader.get_attribute ("name"), get_current_src ());
		st.access = SymbolAccessibility.PUBLIC;
		st.external = true;
		next ();

		var old_symbol = current_symbol;
		current_symbol = st;
		while (current_token == MarkupTokenType.START_ELEMENT) {
			if (!push_metadata ()) {
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
				skip_element ();
			}

			pop_metadata ();
		}

		end_element ("union");
		current_symbol = old_symbol;

		return st;
	}

	Constant parse_constant () {
		start_element ("constant");
		string name = element_get_name ();
		next ();
		var type = parse_type ();
		var c = new Constant (name, type, null, get_current_src ());
		c.access = SymbolAccessibility.PUBLIC;
		c.external = true;
		end_element ("constant");
		return c;
	}

	/* Reporting */
	void report_unused_metadata (Metadata metadata) {
		if (metadata == Metadata.empty) {
			return;
		}

		if (metadata.args.size == 0 && metadata.children.size == 0) {
			Report.warning (metadata.source_reference, "empty metadata");
			return;
		}

		foreach (var arg_type in metadata.args.get_keys ()) {
			var arg = metadata.args[arg_type];
			if (!arg.used) {
				// if metadata is used and argument is not, then it's a unexpected argument
				Report.warning (arg.source_reference, "argument never used");
			}
		}

		foreach (var child in metadata.children) {
			if (!child.used) {
				Report.warning (child.source_reference, "metadata never used");
			} else {
				report_unused_metadata (child);
			}
		}
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

	void postprocess_interfaces () {
		foreach (var iface in interfaces) {
			/* Temporarily workaround G-I bug not adding GLib.Object prerequisite:
			   ensure we have at least one instantiable prerequisite */
			bool has_instantiable_prereq = false;
			foreach (DataType prereq in iface.get_prerequisites ()) {
				Symbol sym = null;
				if (prereq is UnresolvedType) {
					var unresolved_symbol = ((UnresolvedType) prereq).unresolved_symbol;
					sym = resolve_symbol (iface.parent_symbol.scope, unresolved_symbol);
				} else {
					sym = prereq.data_type;
				}
				if (sym is Class) {
					has_instantiable_prereq = true;
					break;
				}
			}

			if (!has_instantiable_prereq) {
				iface.add_prerequisite (new ObjectType ((ObjectTypeSymbol) glib_ns.scope.lookup ("Object")));
			}
		}
	}

	void postprocess_reparenting () {
		foreach (UnresolvedSymbol target_unresolved_symbol in symbol_reparent_map.get_keys ()) {
			var target_symbol = resolve_symbol (context.root.scope, target_unresolved_symbol);
			if (target_symbol == null) {
				// create namespaces backward
				var sym = target_unresolved_symbol;
				var ns = new Namespace (sym.name, sym.source_reference);
				var result = ns;
				sym = sym.inner;
				while (sym != null) {
					var res = resolve_symbol (context.root.scope, sym);
					if (res != null && !(res is Namespace)) {
						result = null;
						break;
					}
					var parent = res as Namespace;
					if (res == null) {
						parent = new Namespace (sym.name, sym.source_reference);
					}
					if (parent.scope.lookup (ns.name) == null) {
						parent.add_namespace (ns);
					}
					ns = parent;
					sym = sym.inner;
				}
				if (result != null && sym == null && context.root.scope.lookup (ns.name) == null) {
					// a new root namespace, helpful for a possible non-gobject gir?
					context.root.add_namespace (ns);
				}
				target_symbol = result;
			}
			if (target_symbol == null) {
				Report.error (null, "unable to reparent into `%s'".printf (target_unresolved_symbol.to_string ()));
				continue;
			}
			var symbols = symbol_reparent_map[target_unresolved_symbol];
			foreach (var symbol in symbols) {
				add_symbol_to_container (target_symbol, symbol);
			}
		}
	}

	void postprocess_gtype_callbacks (Namespace ns) {
		foreach (UnresolvedSymbol gtype_struct_for in gtype_callbacks.get_keys ()) {
			// parent symbol is the record, therefore use parent of parent symbol
			var gtype = resolve_symbol (ns.scope, gtype_struct_for) as ObjectTypeSymbol;
			if (gtype == null) {
				Report.error (null, "unknown symbol `%s' while postprocessing callbacks".printf (gtype_struct_for.name));
				continue;
			}
			ArrayList<Delegate> callbacks = gtype_callbacks.get (gtype_struct_for);
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
					assume_parameter_names (sig, d, true);
				} else if (symbol is Property) {
					var prop = (Property) symbol;
					prop.is_virtual = true;
				} else {
					Report.error (get_current_src (), "unknown member type `%s' in `%s'".printf (d.name, gtype.name));
				}
			}
		}
	}

	void postprocess_aliases () {
		/* this is unfortunate because <alias> tag has no type information, thus we have
		   to guess it from the base type */
		foreach (var alias in aliases) {
			DataType base_type = null;
			Symbol type_sym = null;
			bool simple_type = false;
			if (alias.base_type is UnresolvedType) {
				base_type = alias.base_type;
				type_sym = resolve_symbol (alias.parent_symbol.scope, ((UnresolvedType) base_type).unresolved_symbol);
			} else if (alias.base_type is PointerType && ((PointerType) alias.base_type).base_type is VoidType) {
				// gpointer, if it's a struct make it a simpletype
				simple_type = true;
			} else {
				base_type = alias.base_type;
				type_sym = base_type.data_type;
			}

			if (type_sym is Struct && ((Struct) type_sym).is_simple_type ()) {
				simple_type = true;
			}

			if (base_type == null || type_sym == null || type_sym is Struct) {
				var st = new Struct (alias.name, alias.source_reference);
				st.access = SymbolAccessibility.PUBLIC;
				if (base_type != null) {
					// threat target="none" as a new struct
					st.base_type = base_type;
				}
				st.external = true;
				if (alias.cname != null) {
					st.set_cname (alias.cname);
				}
				if (simple_type) {
					st.set_simple_type (true);
				}
				add_symbol_to_container (alias.parent_symbol, st);
			} else if (type_sym is Class) {
				var cl = new Class (alias.name, alias.source_reference);
				cl.access = SymbolAccessibility.PUBLIC;
				if (base_type != null) {
					cl.add_base_type (base_type);
				}
				cl.external = true;
				if (alias.cname != null) {
					cl.set_cname (alias.cname);
				}
				add_symbol_to_container (alias.parent_symbol, cl);
			}
		}
	}

	void find_static_method_parent (string cname, Symbol current, ref Symbol best, ref double match, double match_char) {
		var old_best = best;
		if (current.scope.get_symbol_table () != null) {
			foreach (var child in current.scope.get_symbol_table().get_values ()) {
				if (child is Struct || child is ObjectTypeSymbol || child is Namespace) {
					find_static_method_parent (cname, child, ref best, ref match, match_char);
				}
			}
		}
		if (best != old_best) {
			// child is better
			return;
		}

		var current_cprefix = current.get_lower_case_cprefix ();
		if (cname.has_prefix (current_cprefix)) {
			var current_match = match_char * current_cprefix.length;
			if (current_match > match) {
				match = current_match;
				best = current;
			}
		}
	}

	void postprocess_namespace_methods () {
		/* transform static methods into instance methods if possible.
		   In most of cases this is a .gir fault we are going to fix */
		foreach (var ns in namespace_methods.get_keys ()) {
			var ns_cprefix = ns.get_lower_case_cprefix ();
			var methods = namespace_methods[ns];
			foreach (var method in methods) {
				if (method.parent_symbol != null) {
					// fixed earlier by metadata
					continue;
				}

				var cname = method.get_cname ();

				Parameter first_param = null;
				if (method.get_parameters ().size > 0) {
					first_param = method.get_parameters()[0];
				}
				if (first_param != null && first_param.variable_type is UnresolvedType) {
					// check if it's a missed instance method (often happens for structs)
					var parent = resolve_symbol (ns.scope, ((UnresolvedType) first_param.variable_type).unresolved_symbol);
					if (parent != null && (parent is Struct || parent is ObjectTypeSymbol || parent is Namespace)
						&& cname.has_prefix (parent.get_lower_case_cprefix ())) {
						// instance method
						var new_name = method.name.substring (parent.get_lower_case_cprefix().length - ns_cprefix.length);
						if (parent.scope.lookup (new_name) == null) {
							method.name = new_name;
							method.get_parameters().remove_at (0);
							method.binding = MemberBinding.INSTANCE;
							add_symbol_to_container (parent, method);
						} else {
							ns.add_method (method);
						}
						continue;
					}
				}

				double match = 0;
				Symbol parent = ns;
				find_static_method_parent (cname, ns, ref parent, ref match, 1.0/cname.length);
				var new_name = method.name.substring (parent.get_lower_case_cprefix().length - ns_cprefix.length);
				if (parent.scope.lookup (new_name) == null) {
					method.name = new_name;
					add_symbol_to_container (parent, method);
				} else {
					ns.add_method (method);
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
}
