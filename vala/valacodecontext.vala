/* valacodecontext.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
using Gee;

/**
 * The root of the code tree.
 */
public class Vala.CodeContext : Object {
	/**
	 * Specifies the name of the library to be built.
	 *
	 * Public header files of a library will be assumed to be installed in
	 * a subdirectory named like the library.
	 */
	public string library { get; set; }

	/**
	 * Enable automatic memory management.
	 */
	public bool memory_management { get; set; }

	/**
	 * Enable run-time checks for programming errors.
	 */
	public bool assert { get; set; }

	/**
	 * Enable additional run-time checks.
	 */
	public bool checking { get; set; }

	/**
	 * Enable non-null types.
	 */
	public bool non_null {
		get { return _non_null; }
		set { _non_null = value; }
	}

	/**
	 * Output C code, don't compile to object code.
	 */
	public bool ccode_only { get; set; }

	/**
	 * Compile but do not link.
	 */
	public bool compile_only { get; set; }

	/**
	 * Output filename.
	 */
	public string output { get; set; }

	/**
	 * Base source directory.
	 */
	public string basedir { get; set; }

	/**
	 * Code output directory.
	 */
	public string directory { get; set; }

	/**
	 * Produce debug information.
	 */
	public bool debug { get; set; }

	/**
	 * Optimization level.
	 */
	public int optlevel { get; set; }

	/**
	 * Enable multithreading support.
	 */
	public bool thread { get; set; }

	/**
	 * Specifies the optional module initialization method.
	 */
	public Method module_init_method { get; set; }

	/**
	 * Keep temporary files produced by the compiler.
	 */
	public bool save_temps { get; set; }

	public bool save_csources {
		get { return save_temps; }
	}

	public bool save_cheaders {
		get { return save_csources || null != library; }
	}

	private Gee.List<SourceFile> source_files = new ArrayList<SourceFile> ();
	private Gee.List<string> c_source_files = new ArrayList<string> ();
	private Namespace! _root = new Namespace (null);
	
	private Gee.List<SourceFileCycle> cycles = new ArrayList<SourceFileCycle> ();

	private Gee.List<string> packages = new ArrayList<string> (str_equal);

	private Gee.List<string> defines = new ArrayList<string> (str_equal);

	private static bool _non_null = false;

	/**
	 * The root namespace of the symbol tree.
	 *
	 * @return root namespace
	 */
	public Namespace! root {
		get { return _root; }
	}

	/**
	 * The selected code generator.
	 */
	public CodeGenerator codegen { get; set; }

	public CodeContext () {
	}

	construct {
		codegen = new CodeGenerator ();
	}

	public static bool is_non_null_enabled () {
		return _non_null;
	}

	/**
	 * Returns a copy of the list of source files.
	 *
	 * @return list of source files
	 */
	public Collection<SourceFile> get_source_files () {
		return new ReadOnlyCollection<SourceFile> (source_files);
	}

	/**
	 * Returns a copy of the list of C source files.
	 *
	 * @return list of C source files
	 */
	public Collection<string> get_c_source_files () {
		return new ReadOnlyCollection<string> (c_source_files);
	}
	
	/**
	 * Adds the specified file to the list of source files.
	 *
	 * @param file a source file
	 */
	public void add_source_file (SourceFile! file) {
		source_files.add (file);
	}

	/**
	 * Adds the specified file to the list of C source files.
	 *
	 * @param file a C source file
	 */
	public void add_c_source_file (string! file) {
		c_source_files.add (file);
	}

	/**
	 * Returns a copy of the list of used packages.
	 *
	 * @return list of used packages
	 */
	public Collection<string> get_packages () {
		return new ReadOnlyCollection<string> (packages);
	}

	/**
	 * Returns whether the specified package is being used.
	 *
	 * @param pkg a package name
	 * @return    true if the specified package is being used
	 */
	public bool has_package (string! pkg) {
		return packages.contains (pkg);
	}

	/**
	 * Adds the specified package to the list of used packages.
	 *
	 * @param pkg a package name
	 */
	public void add_package (string! pkg) {
		packages.add (pkg);
	}

	/**
	 * Visits the complete code tree file by file.
	 *
	 * @param visitor the visitor to be called when traversing
	 */
	public void accept (CodeVisitor! visitor) {
		root.accept (visitor);

		foreach (SourceFile file in source_files) {
			file.accept (visitor);
		}
	}
	
	/**
	 * Find and resolve cycles in source file dependencies.
	 */
	public void find_header_cycles () {
		/* find cycles in dependencies between source files */
		foreach (SourceFile file in source_files) {
			/* we're only interested in internal source files */
			if (file.pkg) {
				continue;
			}
			
			if (file.mark == 0) {
				visit (file, new ArrayList<SourceFile> ());
			}
		}
		
		/* find one head for each cycle, it must not have any
		 * hard dependencies on other files in the cycle
		 */
		foreach (SourceFileCycle cycle in cycles) {
			cycle.head = find_cycle_head (cycle.files.get (0));
			cycle.head.is_cycle_head = true;
		}

		/* connect the source files in a non-cyclic way
		 * cycle members connect to the head of their cycle
		 */
		foreach (SourceFile file2 in source_files) {
			/* we're only interested in internal source files */
			if (file2.pkg) {
				continue;
			}

			foreach (SourceFile dep in file2.get_header_internal_dependencies ()) {
				if (file2.cycle != null && dep.cycle == file2.cycle) {
					/* in the same cycle */
					if (!file2.is_cycle_head) {
						/* include header of cycle head */
						file2.add_header_internal_include (file2.cycle.head.get_cinclude_filename ());
					}
				} else {
					/* we can just include the headers if they are not in a cycle or not in the same cycle as the current file */
					file2.add_header_internal_include (dep.get_cinclude_filename ());
				}
			}
		}
		
	}
	
	private weak SourceFile find_cycle_head (SourceFile! file) {
		foreach (SourceFile dep in file.get_header_internal_full_dependencies ()) {
			if (dep == file) {
				/* ignore file-internal dependencies */
				continue;
			}
			
			foreach (SourceFile cycle_file in file.cycle.files) {
				if (dep == cycle_file) {
					return find_cycle_head (dep);
				}
			}
		}
		/* no hard dependencies on members of the same cycle found
		 * source file suitable as cycle head
		 */
		return file;
	}
	
	private void visit (SourceFile! file, Collection<SourceFile> chain) {
		Gee.List<SourceFile> l = new ArrayList<SourceFile> ();
		foreach (SourceFile chain_file in chain) {
			l.add (chain_file);
		}
		l.add (file);

		/* mark file as currently being visited */
		file.mark = 1;
		
		foreach (SourceFile dep in file.get_header_internal_dependencies ()) {
			if (file == dep) {
				continue;
			}
			
			if (dep.mark == 1) {
				/* found cycle */
				
				var cycle = new SourceFileCycle ();
				cycles.add (cycle);
				
				bool cycle_start_found = false;
				foreach (SourceFile cycle_file in l) {
					SourceFileCycle ref_cycle_file_cycle = cycle_file.cycle;
					if (!cycle_start_found) {
						if (cycle_file == dep) {
							cycle_start_found = true;
						}
					}
					
					if (!cycle_start_found) {
						continue;
					}
					
					if (cycle_file.cycle != null) {
						/* file already in a cycle */
						
						if (cycle_file.cycle == cycle) {
							/* file is in the same cycle, nothing to do */
							continue;
						}
						
						/* file is in an other cycle, merge the two cycles */
						
						cycles.remove (cycle_file.cycle);
						
						foreach (SourceFile inner_cycle_file in cycle_file.cycle.files) {
							if (inner_cycle_file.cycle != cycle) {
								/* file in inner cycle not yet added to outer cycle */
								cycle.files.add (inner_cycle_file);
								inner_cycle_file.cycle = cycle;
							}
						}
					} else {
						cycle.files.add (cycle_file);
						cycle_file.cycle = cycle;
					}
				}
			} else if (dep.mark == 0) {
				/* found not yet visited file */
				
				visit (dep, l);
			}
		}
		
		/* mark file as successfully visited */
		file.mark = 2;
	}

	public void add_define (string define) {
		defines.add (define);
	}

	public bool ignore_node (CodeNode node) {
		var attr = node.get_attribute ("Conditional");
		if (attr == null) {
			return false;
		} else {
			var condition = attr.get_string ("condition");
			if (condition == null) {
				return false;
			} else {
				return !defines.contains (condition);
			}
		}
	}

	public Namespace! create_namespace (string name, SourceReference source_reference = null) {
		var node = new Namespace (name, source_reference);
		node.code_binding = codegen.create_namespace_binding (node);
		return node;
	}

	public Class! create_class (string! name, SourceReference source_reference = null) {
		var node = new Class (name, source_reference);
		node.code_binding = codegen.create_class_binding (node);
		return node;
	}

	public Struct! create_struct (string! name, SourceReference source_reference = null) {
		var node = new Struct (name, source_reference);
		node.code_binding = codegen.create_struct_binding (node);
		return node;
	}

	public Interface! create_interface (string! name, SourceReference source_reference = null) {
		var node = new Interface (name, source_reference);
		node.code_binding = codegen.create_interface_binding (node);
		return node;
	}

	public Enum! create_enum (string! name, SourceReference source_reference = null) {
		var node = new Enum (name, source_reference);
		node.code_binding = codegen.create_enum_binding (node);
		return node;
	}

	public EnumValue! create_enum_value (string! name) {
		var node = new EnumValue (name);
		node.code_binding = codegen.create_enum_value_binding (node);
		return node;
	}

	public EnumValue! create_enum_value_with_value (string! name, Expression value) {
		var node = new EnumValue.with_value (name, value);
		node.code_binding = codegen.create_enum_value_binding (node);
		return node;
	}

	public Delegate! create_delegate (string name, DataType return_type, SourceReference source_reference = null) {
		var node = new Delegate (name, return_type, source_reference);
		node.code_binding = codegen.create_delegate_binding (node);
		return node;
	}

	public Constant! create_constant (string! name, DataType! type_reference, Expression initializer, SourceReference source_reference) {
		var node = new Constant (name, type_reference, initializer, source_reference);
		node.code_binding = codegen.create_constant_binding (node);
		return node;
	}

	public Field! create_field (string! name, DataType! type_reference, Expression initializer, SourceReference source_reference = null) {
		var node = new Field (name, type_reference, initializer, source_reference);
		node.code_binding = codegen.create_field_binding (node);
		return node;
	}

	public Method! create_method (string name, DataType return_type, SourceReference source_reference = null) {
		var node = new Method (name, return_type, source_reference);
		node.code_binding = codegen.create_method_binding (node);
		return node;
	}

	public CreationMethod! create_creation_method (string type_name, string name, SourceReference source_reference = null) {
		var node = new CreationMethod (type_name, name, source_reference);
		node.code_binding = codegen.create_creation_method_binding (node);
		return node;
	}

	public FormalParameter! create_formal_parameter (string! name, DataType type_reference, SourceReference source_reference = null) {
		var node = new FormalParameter (name, type_reference, source_reference);
		node.code_binding = codegen.create_formal_parameter_binding (node);
		return node;
	}

	public FormalParameter! create_formal_parameter_with_ellipsis (SourceReference source_reference = null) {
		var node = new FormalParameter.with_ellipsis (source_reference);
		node.code_binding = codegen.create_formal_parameter_binding (node);
		return node;
	}

	public Property! create_property (string! name, DataType! type_reference, PropertyAccessor get_accessor, PropertyAccessor set_accessor, SourceReference source_reference) {
		var node = new Property (name, type_reference, get_accessor, set_accessor, source_reference);
		node.code_binding = codegen.create_property_binding (node);
		return node;
	}

	public PropertyAccessor! create_property_accessor (bool readable, bool writable, bool construction, Block body, SourceReference source_reference) {
		var node = new PropertyAccessor (readable, writable, construction, body, source_reference);
		node.code_binding = codegen.create_property_accessor_binding (node);
		return node;
	}

	public Signal! create_signal (string! name, DataType! return_type, SourceReference source_reference = null) {
		var node = new Signal (name, return_type, source_reference);
		node.code_binding = codegen.create_signal_binding (node);
		return node;
	}

	public Constructor! create_constructor (SourceReference source_reference) {
		var node = new Constructor (source_reference);
		node.code_binding = codegen.create_constructor_binding (node);
		return node;
	}

	public Destructor! create_destructor (SourceReference source_reference = null) {
		var node = new Destructor (source_reference);
		node.code_binding = codegen.create_destructor_binding (node);
		return node;
	}

	public TypeParameter! create_type_parameter (string name, SourceReference source_reference) {
		var node = new TypeParameter (name, source_reference);
		node.code_binding = codegen.create_type_parameter_binding (node);
		return node;
	}

	public Block! create_block (SourceReference source_reference = null) {
		var node = new Block (source_reference);
		node.code_binding = codegen.create_block_binding (node);
		return node;
	}

	public EmptyStatement! create_empty_statement (SourceReference source_reference = null) {
		var node = new EmptyStatement (source_reference);
		node.code_binding = codegen.create_empty_statement_binding (node);
		return node;
	}

	public DeclarationStatement! create_declaration_statement (LocalVariableDeclaration! declaration, SourceReference source_reference) {
		var node = new DeclarationStatement (declaration, source_reference);
		node.code_binding = codegen.create_declaration_statement_binding (node);
		return node;
	}

	public LocalVariableDeclaration! create_local_variable_declaration (DataType type_reference, SourceReference source_reference) {
		var node = new LocalVariableDeclaration (type_reference, source_reference);
		node.code_binding = codegen.create_local_variable_declaration_binding (node);
		return node;
	}

	public LocalVariableDeclaration! create_local_variable_declaration_var_type (SourceReference source_reference) {
		var node = new LocalVariableDeclaration.var_type (source_reference);
		node.code_binding = codegen.create_local_variable_declaration_binding (node);
		return node;
	}

	public VariableDeclarator! create_variable_declarator (string! name, Expression initializer = null, SourceReference source_reference = null) {
		var node = new VariableDeclarator (name, initializer, source_reference);
		node.code_binding = codegen.create_variable_declarator_binding (node);
		return node;
	}

	public InitializerList! create_initializer_list (SourceReference source_reference) {
		var node = new InitializerList (source_reference);
		node.code_binding = codegen.create_initializer_list_binding (node);
		return node;
	}

	public ExpressionStatement! create_expression_statement (Expression! expression, SourceReference source_reference = null) {
		var node = new ExpressionStatement (expression, source_reference);
		node.code_binding = codegen.create_expression_statement_binding (node);
		return node;
	}

	public IfStatement! create_if_statement (Expression! condition, Block! true_statement, Block false_statement, SourceReference source_reference) {
		var node = new IfStatement (condition, true_statement, false_statement, source_reference);
		node.code_binding = codegen.create_if_statement_binding (node);
		return node;
	}

	public SwitchStatement! create_switch_statement (Expression! expression, SourceReference source_reference) {
		var node = new SwitchStatement (expression, source_reference);
		node.code_binding = codegen.create_switch_statement_binding (node);
		return node;
	}

	public SwitchSection! create_switch_section (SourceReference source_reference) {
		var node = new SwitchSection (source_reference);
		node.code_binding = codegen.create_switch_section_binding (node);
		return node;
	}

	public SwitchLabel! create_switch_label (Expression expression, SourceReference source_reference = null) {
		var node = new SwitchLabel (expression, source_reference);
		node.code_binding = codegen.create_switch_label_binding (node);
		return node;
	}

	public SwitchLabel! create_switch_label_with_default (SourceReference source_reference = null) {
		var node = new SwitchLabel.with_default (source_reference);
		node.code_binding = codegen.create_switch_label_binding (node);
		return node;
	}

	public WhileStatement! create_while_statement (Expression! condition, Block! body, SourceReference source_reference = null) {
		var node = new WhileStatement (condition, body, source_reference);
		node.code_binding = codegen.create_while_statement_binding (node);
		return node;
	}

	public DoStatement! create_do_statement (Block! body, Expression! condition, SourceReference source_reference = null) {
		var node = new DoStatement (body, condition, source_reference);
		node.code_binding = codegen.create_do_statement_binding (node);
		return node;
	}

	public ForStatement! create_for_statement (Expression condition, Block body, SourceReference source_reference = null) {
		var node = new ForStatement (condition, body, source_reference);
		node.code_binding = codegen.create_for_statement_binding (node);
		return node;
	}

	public ForeachStatement! create_foreach_statement (DataType! type_reference, string! variable_name, Expression! collection, Block body, SourceReference source_reference) {
		var node = new ForeachStatement (type_reference, variable_name, collection, body, source_reference);
		node.code_binding = codegen.create_foreach_statement_binding (node);
		return node;
	}

	public BreakStatement! create_break_statement (SourceReference source_reference) {
		var node = new BreakStatement (source_reference);
		node.code_binding = codegen.create_break_statement_binding (node);
		return node;
	}

	public ContinueStatement! create_continue_statement (SourceReference source_reference) {
		var node = new ContinueStatement (source_reference);
		node.code_binding = codegen.create_continue_statement_binding (node);
		return node;
	}

	public ReturnStatement! create_return_statement (Expression return_expression = null, SourceReference source_reference = null) {
		var node = new ReturnStatement (return_expression, source_reference);
		node.code_binding = codegen.create_return_statement_binding (node);
		return node;
	}

	public ThrowStatement! create_throw_statement (Expression! error_expression, SourceReference source_reference = null) {
		var node = new ThrowStatement (error_expression, source_reference);
		node.code_binding = codegen.create_throw_statement_binding (node);
		return node;
	}

	public TryStatement! create_try_statement (Block! body, Block finally_body, SourceReference source_reference = null) {
		var node = new TryStatement (body, finally_body, source_reference);
		node.code_binding = codegen.create_try_statement_binding (node);
		return node;
	}

	public CatchClause! create_catch_clause (DataType type_reference, string variable_name, Block body, SourceReference source_reference = null) {
		var node = new CatchClause (type_reference, variable_name, body, source_reference);
		node.code_binding = codegen.create_catch_clause_binding (node);
		return node;
	}

	public LockStatement! create_lock_statement (Expression resource, Block body, SourceReference source_reference = null) {
		var node = new LockStatement (resource, body, source_reference);
		node.code_binding = codegen.create_lock_statement_binding (node);
		return node;
	}

	public ArrayCreationExpression! create_array_creation_expression (DataType element_type, int rank, InitializerList initializer_list, SourceReference source_reference) {
		var node = new ArrayCreationExpression (element_type, rank, initializer_list, source_reference);
		node.code_binding = codegen.create_array_creation_expression_binding (node);
		return node;
	}

	public BooleanLiteral! create_boolean_literal (bool value, SourceReference source_reference) {
		var node = new BooleanLiteral (value, source_reference);
		node.code_binding = codegen.create_boolean_literal_binding (node);
		return node;
	}

	public CharacterLiteral! create_character_literal (string! value, SourceReference source_reference) {
		var node = new CharacterLiteral (value, source_reference);
		node.code_binding = codegen.create_character_literal_binding (node);
		return node;
	}

	public IntegerLiteral! create_integer_literal (string! value, SourceReference source_reference = null) {
		var node = new IntegerLiteral (value, source_reference);
		node.code_binding = codegen.create_integer_literal_binding (node);
		return node;
	}

	public RealLiteral! create_real_literal (string value, SourceReference source_reference) {
		var node = new RealLiteral (value, source_reference);
		node.code_binding = codegen.create_real_literal_binding (node);
		return node;
	}

	public StringLiteral! create_string_literal (string value, SourceReference source_reference) {
		var node = new StringLiteral (value, source_reference);
		node.code_binding = codegen.create_string_literal_binding (node);
		return node;
	}

	public NullLiteral! create_null_literal (SourceReference source_reference = null) {
		var node = new NullLiteral (source_reference);
		node.code_binding = codegen.create_null_literal_binding (node);
		return node;
	}

	public LiteralExpression! create_literal_expression (Literal! literal, SourceReference source_reference = null) {
		var node = new LiteralExpression (literal, source_reference);
		node.code_binding = codegen.create_literal_expression_binding (node);
		return node;
	}

	public ParenthesizedExpression! create_parenthesized_expression (Expression! inner, SourceReference source_reference) {
		var node = new ParenthesizedExpression (inner, source_reference);
		node.code_binding = codegen.create_parenthesized_expression_binding (node);
		return node;
	}

	public MemberAccess! create_member_access (Expression inner, string! member_name, SourceReference source_reference = null) {
		var node = new MemberAccess (inner, member_name, source_reference);
		node.code_binding = codegen.create_member_access_binding (node);
		return node;
	}

	public MemberAccess! create_member_access_simple (string! member_name, SourceReference source_reference = null) {
		var node = new MemberAccess.simple (member_name, source_reference);
		node.code_binding = codegen.create_member_access_binding (node);
		return node;
	}

	public MemberAccess! create_member_access_pointer (Expression inner, string! member_name, SourceReference source_reference = null) {
		var node = new MemberAccess.pointer (inner, member_name, source_reference);
		node.code_binding = codegen.create_member_access_binding (node);
		return node;
	}

	public InvocationExpression! create_invocation_expression (Expression! call, SourceReference source_reference = null) {
		var node = new InvocationExpression (call, source_reference);
		node.code_binding = codegen.create_invocation_expression_binding (node);
		return node;
	}
	
	public ElementAccess! create_element_access (Expression container, SourceReference source_reference) {
		var node = new ElementAccess (container, source_reference);
		node.code_binding = codegen.create_element_access_binding (node);
		return node;
	}

	public BaseAccess! create_base_access (SourceReference source_reference = null) {
		var node = new BaseAccess (source_reference);
		node.code_binding = codegen.create_base_access_binding (node);
		return node;
	}

	public PostfixExpression! create_postfix_expression (Expression! inner, bool increment, SourceReference source_reference) {
		var node = new PostfixExpression (inner, increment, source_reference);
		node.code_binding = codegen.create_postfix_expression_binding (node);
		return node;
	}

	public ObjectCreationExpression! create_object_creation_expression (MemberAccess! member_name, SourceReference source_reference) {
		var node = new ObjectCreationExpression (member_name, source_reference);
		node.code_binding = codegen.create_object_creation_expression_binding (node);
		return node;
	}

	public SizeofExpression! create_sizeof_expression (DataType! type_reference, SourceReference source_reference) {
		var node = new SizeofExpression (type_reference, source_reference);
		node.code_binding = codegen.create_sizeof_expression_binding (node);
		return node;
	}

	public TypeofExpression! create_typeof_expression (DataType! type_reference, SourceReference source_reference) {
		var node = new TypeofExpression (type_reference, source_reference);
		node.code_binding = codegen.create_typeof_expression_binding (node);
		return node;
	}

	public UnaryExpression! create_unary_expression (UnaryOperator operator, Expression! inner, SourceReference source_reference) {
		var node = new UnaryExpression (operator, inner, source_reference);
		node.code_binding = codegen.create_unary_expression_binding (node);
		return node;
	}

	public CastExpression! create_cast_expression (Expression! inner, DataType! type_reference, SourceReference source_reference, bool is_silent_cast) {
		var node = new CastExpression (inner, type_reference, source_reference, is_silent_cast);
		node.code_binding = codegen.create_cast_expression_binding (node);
		return node;
	}

	public PointerIndirection! create_pointer_indirection (Expression! inner, SourceReference source_reference = null) {
		var node = new PointerIndirection (inner, source_reference);
		node.code_binding = codegen.create_pointer_indirection_binding (node);
		return node;
	}

	public AddressofExpression! create_addressof_expression (Expression! inner, SourceReference source_reference = null) {
		var node = new AddressofExpression (inner, source_reference);
		node.code_binding = codegen.create_addressof_expression_binding (node);
		return node;
	}

	public ReferenceTransferExpression! create_reference_transfer_expression (Expression! inner, SourceReference source_reference = null) {
		var node = new ReferenceTransferExpression (inner, source_reference);
		node.code_binding = codegen.create_reference_transfer_expression_binding (node);
		return node;
	}

	public BinaryExpression! create_binary_expression (BinaryOperator operator, Expression! left, Expression! right, SourceReference source_reference = null) {
		var node = new BinaryExpression (operator, left, right, source_reference);
		node.code_binding = codegen.create_binary_expression_binding (node);
		return node;
	}

	public TypeCheck! create_type_check (Expression! expression, DataType! type_reference, SourceReference source_reference) {
		var node = new TypeCheck (expression, type_reference, source_reference);
		node.code_binding = codegen.create_type_check_binding (node);
		return node;
	}

	public ConditionalExpression! create_conditional_expression (Expression! condition, Expression! true_expression, Expression! false_expression, SourceReference source_reference) {
		var node = new ConditionalExpression (condition, true_expression, false_expression, source_reference);
		node.code_binding = codegen.create_conditional_expression_binding (node);
		return node;
	}

	public LambdaExpression! create_lambda_expression (Expression! expression_body, SourceReference source_reference) {
		var node = new LambdaExpression (expression_body, source_reference);
		node.code_binding = codegen.create_lambda_expression_binding (node);
		return node;
	}

	public LambdaExpression! create_lambda_expression_with_statement_body (Block! statement_body, SourceReference source_reference) {
		var node = new LambdaExpression.with_statement_body (statement_body, source_reference);
		node.code_binding = codegen.create_lambda_expression_binding (node);
		return node;
	}

	public Assignment! create_assignment (Expression! left, Expression! right, AssignmentOperator operator = AssignmentOperator.SIMPLE, SourceReference source_reference = null) {
		var node = new Assignment (left, right, operator, source_reference);
		node.code_binding = codegen.create_assignment_binding (node);
		return node;
	}
}
