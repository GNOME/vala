/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

using Drawer;
using Vala;
using GLib;
using Gee;



public enum ExpressionType {
	NOT_SET,
	STRING,
	CHAR,
	REAL,
	BOOL,
	INT,
	NULL
}



public class Valadoc.Basic : Object {
	protected static string get_comment_string ( Vala.Symbol symbol ) {
		SourceReference sref = symbol.source_reference;
		if ( sref == null )
			return null;

		return sref.comment;
	}

	public virtual Basic? search_in_upper_namespace ( string[] params, int pos ) {
		return null;
	}

	protected void parse_comment_string ( string comment, CommentContext context ) {
		this.comment = new CommentParser();
		this.comment.initialisation ( comment, this, this.head, this.err, context, this.settings );
		this.comment.parse ( );
	}

	protected void parse_comment_helper ( Vala.Symbol symbol, CommentContext context ) {
		if ( this.comment != null )
			return ;

		string str = this.get_comment_string ( symbol );
		if ( str == null )
			return ;

		if ( CommentParser.is_comment_string( str ) )
			this.parse_comment_string ( str, context );
	}

	public int line {
		get {
			Vala.SourceReference vsref = this.vsymbol.source_reference;
			if ( vsref == null )
				return 0;

			return vsref.first_line;
		}
	}

	public Valadoc.Settings settings {
		construct set;
		protected get;
	}

	public DataType parent_data_type {
		get {
			if ( this.parent is DataType )
				return (DataType)this.parent;

			return null;
		}
	}

	public string# file_name {
		get {
			Basic element = this;
			while ( element != null ) {
				if ( element is File )
					return element.name;

				element = element.parent;
			}
			return null;
		}
	}

	public File file {
		get {
			Valadoc.Basic ast = this;
			while ( ast is Valadoc.File == false ) {
				ast = ast.parent;
				if ( ast == null )
					return null;
			}
			return (Valadoc.File)ast;
		}
	}

	public Namespace nspace {
		get {
			Valadoc.Basic ast = this;
			while ( ast is Valadoc.Namespace == false ) {
				ast = ast.parent;
				if ( ast == null )
					return null;
			}
			return (Valadoc.Namespace)ast;
		}
	}

	public CommentParser comment {
		protected set;
		get;
	}

	public Basic parent {
		construct set;
		get;
	}

	protected Vala.Symbol vsymbol {
		get;
		set;
	}

	public ErrorReporter err {
		construct set;
		get;
	}

	public Tree head {
		construct set;
		protected get;
	}

	public virtual string# name {
		get {
			return null;
		}
	}

	// Move to Valadoc.SymbolAccessibility
	public bool is_public {
		get {
			Vala.SymbolAccessibility access = vsymbol.access;
			return ( access == Vala.SymbolAccessibility.PUBLIC )?
				true : false;
		}
	}

	// Move to Valadoc.SymbolAccessibility
	public bool is_protected {
		get {
			Vala.SymbolAccessibility access = vsymbol.access;
			return ( access == Vala.SymbolAccessibility.PROTECTED )?
				true : false;
		}
	}

	// Move to Valadoc.SymbolAccessibility
	public bool is_private {
		get {
			Vala.SymbolAccessibility access = vsymbol.access;
			return ( access == Vala.SymbolAccessibility.PRIVATE )?
				true : false;
		}
	}

	// remove
	public string# accessibility_str {
		get {
			if ( is_public )
				return "public";
			if ( is_private )
				return "private";
			if ( is_protected )
				return "protected";
			return null;
		}
	}

	protected Basic find_member_lst ( Gee.Collection<Basic> lst, string name ) {
		foreach ( Basic element in lst ) {
			if ( element.name == name )
				return element;
		}
		return null;
	}
}



public interface Valadoc.NamespaceHandler : Basic {
	public abstract Gee.ArrayList<Namespace> namespaces {
		private set;
		get;
	}

	public Gee.ReadOnlyCollection<Namespace> get_namespace_list () {
			return new Gee.ReadOnlyCollection<Namespace> ( this.namespaces );
	}

	public void visit_namespaces ( Doclet doclet ) {
		foreach ( Namespace ns in this.namespaces ) {
			ns.visit ( doclet );
		}
	}

	private Gee.ArrayList<Vala.Namespace> create_parent_vnamespace_list ( Vala.Symbol vsymbol ) {
		var lst = new Gee.ArrayList<Vala.Namespace> ();

		while ( vsymbol != null ) {
			if ( vsymbol is Vala.Namespace ) {
				lst.insert ( 0, (Vala.Namespace)vsymbol );
			}
			vsymbol = vsymbol.parent_symbol;
		}
		return lst;
	}

	public void add__namespace ( Namespace ns ) {
		this.namespaces.add ( ns );
	}

	public Namespace get_namespace_helper ( Vala.Symbol node, Gee.List<Vala.Namespace> vnspaces, int pos ) {
		Vala.Namespace vns = vnspaces.get( pos );

		Namespace ns = this.find_namespace_without_childs ( vns );
		if ( ns == null ) {
			ns = new Namespace( this.settings, vns, this, this.head, this.err );
			this.namespaces.add ( ns );
		}

		if ( vnspaces.size == pos+1 ) {
			return ns;
		}

		return ns.get_namespace_helper ( node, vnspaces, pos+1 );
	}

	// TODO: Rename vars
	protected Namespace get_namespace ( Vala.Symbol node ) {
		Vala.Symbol vnd = ((Vala.Symbol)node).parent_symbol;
		if ( vnd is Vala.Namespace == false )
			vnd = vnd.parent_symbol;

		Vala.Namespace vnspace = (Vala.Namespace)vnd;
		var nspace = this.find_namespace ( vnspace );
		if ( nspace != null )
			return nspace;


		var vnspaces = this.create_parent_vnamespace_list ( node );

		if ( vnspaces.size > 2 ) {
			return this.get_namespace_helper ( node, vnspaces, 1 );
		}
		else {
			var ns = new Namespace( this.settings, vnspace, this, this.head, this.err );
			this.namespaces.add( ns );
			return ns;
		}
	}

	public Namespace find_vnamespace_helper ( Gee.List<Vala.Namespace> vnspaces, int pos ) {
		Vala.Namespace vns = vnspaces.get ( pos );
		if ( vns == null )
			return null;

		foreach ( Namespace ns in this.namespaces ) {
			if ( !ns.is_vnspace( vns ) )
				continue ;

			if ( pos+1 == vnspaces.size )
				return ns;

			return ns.find_vnamespace_helper ( vnspaces, pos+1 );
		}

		return null;
	}

	// inline?
	private Namespace find_namespace_without_childs ( Vala.Namespace vns ) {
		Namespace ns2 = null;

		foreach ( Namespace ns in this.namespaces ) {
			if ( ns.is_vnspace(vns) )
				ns2 = ns;
		}

		return ns2;
	}

	public Namespace find_namespace ( Vala.Namespace vns ) {
		var vnspaces = this.create_parent_vnamespace_list ( vns );
		return this.find_vnamespace_helper ( vnspaces, vnspaces.index_of( vns ) );
	}

	public void set_namespace_type_references ( ) {
		foreach ( Namespace ns in this.namespaces ){
			ns.set_type_references ();
		}
	}

	public void namespace_inheritance ( ) {
		foreach ( Namespace ns in this.namespaces ){
			ns.inheritance( );
		}
	}

	public void parse_namespace_comments ( ) {
		foreach ( Namespace ns in this.namespaces ){
			ns.parse_comments ();
		}
	}

	public void create_namespace_images ( ) {
		foreach ( Namespace ns in this.namespaces ) {
			ns.create_images ( );
		}
	}
}



/**
 * A helper for all data types who could contain classes.
 */
public interface Valadoc.ClassHandler : Basic {
	protected abstract Gee.ArrayList<Class> classes {
		set;
		get;
	}

	public abstract uint bracket_level {
		construct set;
		protected get;
	} 

	protected inline Basic? search_class ( string[] params, int pos ) {
		foreach ( Class cl in this.classes ) {
			Basic element = cl.search_in_upper_namespace ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	public Class find_vclass ( Vala.Class vcl ) {
		foreach ( Class cl in this.classes ) {
			if ( cl.is_vclass ( vcl ) )
				return cl;

			var tmp = cl.find_vclass ( vcl );
			if ( tmp != null )
				return tmp;
		}
		return null;
	}

	/**
	 * Returns a list of all visitable classes.
	 */
	public Gee.ReadOnlyCollection<Class> get_class_list ( ) {
		var lst = new Gee.ArrayList<Class> ();
		foreach ( Class cl in this.classes ) {
			if ( !cl.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( cl );
		}

		return new Gee.ReadOnlyCollection<Class>( lst );
	}

	/**
	 * Appends a class. Make sure that the parent of the class is set to the
	 * ClassHandler.
	 *
	 *	@param cl a { @link Valadoc.Class }.
	 */
	public void append_class ( Valadoc.Class cl ) {
		this.classes.add( cl );
	}

	/**
	 * Calls { @link Doclet.class_visitor } for all visitables classes.
	 */
	public void visit_classes ( Doclet doclet ) {
		foreach ( Class cl in this.get_class_list() ) {
			cl.visit ( doclet );
		}
	}

	protected void set_class_references ( ) {
		foreach ( Class cl in this.classes ) {
			cl.set_type_references ();
		}
	}

	protected void parse_class_comments ( ) {
		foreach ( Class cl in this.classes ) {
			cl.parse_comments ( );
		}
	}
}



public interface Valadoc.PropertyHandler : ContainerDataType {
	protected abstract Gee.ArrayList<Property> properties {
		get;
		set;
	}

	protected inline Basic? search_property ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Property prop in this.properties ) {
			if ( prop.name == params[pos] )
				return prop;
		}
		return null;
	}

	protected bool is_overwritten_property ( Property prop ) {
		foreach ( Property p in this.properties ) {
			if ( p.parent != this )
				continue ;

			if ( !p.is_override )
				continue ;

			if ( p.equals ( prop ) )
				return true;
		}
		return false;
	}

	public Gee.Collection<Property> get_property_list ( ) {
		var lst = new Gee.ArrayList<Property> ();
		foreach ( Property p in this.properties ) {
			if ( !p.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( p );
		}

		return new Gee.ReadOnlyCollection<Property>( lst );
	}

	protected void parse_property_comments ( ) {
		foreach ( Property prop in this.properties ) {
			prop.parse_comment ( );
		}
	}

	public void visit_properties ( Doclet doclet ) {
		foreach ( Property prop in this.get_property_list () )
			prop.visit ( doclet );
	}

	protected void set_property_type_reference () {
		foreach ( Property prop in this.properties ) {
			prop.set_type_references ( );
		}
	}

	protected void add_properties ( Gee.Collection<Vala.Property> vproperties ) {
		foreach ( Vala.Property vprop in vproperties ) {
			var tmp = new Property ( this.settings, vprop, this, this.head, this.err, this.bracket_level + 1 );
			tmp.initialisation ( );
			this.properties.add ( tmp );
		}
	}
}


public interface Valadoc.ConstructionMethodHandler : DataType, MethodHandler {
	protected abstract Gee.ArrayList<Method> construction_methods {
		set;
		get;
	}

	protected inline Basic? search_construction_method ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] == null )
			return null;

		if ( params[pos+2] != null )
			return null;

		string name = params[pos] + "." + params[pos+1];

		foreach ( Method m in this.construction_methods ) {
			if ( m.name == name )
				return m;
		}
		return null;
	}

	public Gee.Collection<Method> get_construction_method_list ( ) {
		var lst = new Gee.ArrayList<Method> ();
		foreach ( Method cm in this.construction_methods ) {
			if ( !cm.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( cm );
		}

		return new Gee.ReadOnlyCollection<Method>( lst );
	}

	protected void parse_construction_method_comments ( ) {
		foreach ( Method cm in this.construction_methods ) {
			cm.parse_comment ( );
		}
	}

	protected void set_construction_method_references ( ) {
		foreach ( Method cm in this.construction_methods ) {
			cm.set_type_references ( );
		}
	}

	public void visit_construction_methods ( Doclet doclet ) {
		foreach ( Method m in this.get_construction_method_list() ) {
			m.visit ( doclet, null );
		}
	}

	/**
	 * Adds a list of methods to { @link Vala.MethodHandler } and { @link Vala.ConstructionMethodHandler }.
	 */
	protected void add_methods_and_construction_methods ( Gee.Collection<Vala.Method> vmethods ) {
		foreach ( Vala.Method vm in vmethods ) {
			var tmp = new Method ( this.settings, vm, this, this.head, this.err, this.bracket_level + 1 );
			tmp.initialisation ( );
			if ( tmp.is_constructor )
				this.construction_methods.add ( tmp );
			else 
				this.methods.add ( tmp );
		}
	}
}



public interface Valadoc.SignalHandler : ContainerDataType {
	protected abstract Gee.ArrayList<Signal> signals {
		get;
		set;
	}

	protected inline Basic? search_signal ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Signal sig in this.signals ) {
			if ( sig.name == params[pos] )
				return sig;
		}
		return null;
	}

	public void add_signals ( Gee.Collection<Vala.Signal> vsignals ) {
		foreach ( Vala.Signal vsig in vsignals ) {
			var tmp = new Signal ( this.settings, vsig, this, this.head, this.err, this.bracket_level + 1 );
			tmp.initialisation ();
			this.signals.add ( tmp );
		}
	}

	public void visit_signals ( Doclet doclet ) {
		foreach ( Signal sig in this.get_signal_list ( ) ) {
			sig.visit ( doclet );
		}
	}

	public Gee.Collection<Signal> get_signal_list () {
		var lst = new Gee.ArrayList<Signal> ();
		foreach ( Signal sig in this.signals ) {
			if ( !sig.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( sig );
		}

		return new Gee.ReadOnlyCollection<Signal>( lst );
	}

	protected void set_signal_type_references () {
		foreach ( Signal sig in this.signals ) {
			sig.set_type_references ( );
		}
	}

	protected void parse_signal_comments () {
		foreach ( Signal sig in this.signals ) {
			sig.parse_comment ( );
		}
	}
}



public interface Valadoc.StructHandler : Basic {
	protected abstract Gee.ArrayList<Struct> structs {
		set;
		get;
	} 

	public abstract uint bracket_level {
		construct set;
		protected get;
	} 

	protected inline Basic? search_struct ( string[] params, int pos ) {
		foreach ( Struct stru in this.structs ) {
			Basic element = stru.search_in_upper_namespace ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	public Gee.Collection<Struct> get_struct_list ( ) {
		var lst = new Gee.ArrayList<Struct> ();
		foreach ( Struct stru in this.structs ) {
			if ( !stru.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( stru );
		}

		return new Gee.ReadOnlyCollection<Struct>( lst );
	}

	public void append_struct ( Valadoc.Struct stru ) {
		this.structs.add( stru );
	}

	public void visit_structs ( Doclet doclet ) {
		foreach ( Struct stru in this.get_struct_list() ) {
			stru.visit ( doclet );
		}
	}

	protected void set_struct_references ( ) {
		foreach ( Struct stru in this.structs ) {
			stru.set_type_references ( );
		}
	}
	protected void parse_struct_comments ( ) {
		foreach ( Struct stru in this.structs ) {
			stru.parse_comments ( );
		}
	}
}



public interface Valadoc.Visitable : Basic {
	public bool is_type_visitor_accessible ( Valadoc.Basic element ) {
		if ( !this.settings._private && this.is_private )
			return false;

		if ( !this.settings._protected && this.is_protected )
			return false;

		if ( this.parent != element && !this.settings.add_inherited )
				return false;

		return true;
	}

	public bool is_visitor_accessible ( ) {
		if ( !this.settings._private && this.is_private )
			return false;

		if ( !this.settings._protected && this.is_protected )
			return false;

		return true;
	}
}


public interface Valadoc.SymbolAccessibility : Basic {
	protected abstract Vala.Symbol vsymbol {
		get;
		set;
	}

	public abstract bool is_public {
		get;
	}

	public abstract bool is_protected {
		get;
	}

	public abstract bool is_private {
		get;
	}

	public abstract string# accessibility_str {
		get;
	}
}



public interface Valadoc.ReturnTypeHandler : Basic {
	public abstract TypeReference return_type {
		protected set;
		get;
	}

	public void set_return_type_references ( ) {
		if ( this.return_type == null )
			return ;

		this.return_type.set_type_references ( );
	}

	protected void set_ret_type ( Vala.DataType vtref ) {
		var tmp = new TypeReference.return_type ( this.settings, vtref, this, this.head, this.err );
		this.return_type = tmp;
	}
}


// ????
public interface Valadoc.TypeHandler : Basic {
	public abstract TypeReference type_reference {
		protected set;
		get;
	}

	public void set_type_references ( ) {
		if ( this.type_reference == null )
			return ;

		this.type_reference.set_type_references ( );
	}

	protected void set_ret_type ( Vala.DataType vtref ) {
		var tmp = new TypeReference ( this.settings, vtref, this, this.head, this.err );
		this.type_reference = tmp;
	}
}



public interface Valadoc.FieldHandler : Basic {
	protected abstract Gee.ArrayList<Field> fields {
		protected set;
		get;
	}

	public abstract uint bracket_level {
		construct set;
		get;
	}

	protected inline Basic? search_field ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Field f in this.fields ) {
			if ( f.name == params[pos] )
				return f;
		}
		return null;
	}

	public Gee.ReadOnlyCollection<Field> get_field_list ( ) {
		var lstd = new Gee.ArrayList<Field> ();
		foreach ( Field f in this.fields ) {
			if ( !f.is_type_visitor_accessible ( this ) )
				continue ;

			lstd.add ( f );

			if ( f.is_private )
			stdout.printf ( "wtf - %s\n", f.name );
		}

		return new Gee.ReadOnlyCollection<Type>( lstd );
	}

	public void add_fields ( Gee.Collection<Vala.Field> vfields ) {
		foreach ( Vala.Field vf in vfields ) {
			var tmp = new Field ( this.settings, vf, this, this.head, this.err, this.bracket_level + 1 );
			tmp.initialisation ( );
			this.fields.add ( tmp );
		}
	}

	public void set_field_type_references ( ) {
		foreach ( Field field in this.fields ) {
			field.set_type_references ( );
		}
	}

	public void parse_field_comments ( ) {
		foreach ( Field field in this.fields ) {
			field.parse_comment ( );
		}
	}

	public void visit_fields ( Doclet doclet ) {
		foreach ( Field field in this.get_field_list() ) {
				field.visit ( doclet, this );
		}
	}
}



public interface Valadoc.ExceptionHandler : Basic {
	protected abstract Gee.ArrayList<TypeReference> err_domains {
		protected set;
		get;
	}

	public Gee.ReadOnlyCollection<TypeReference> get_error_domains ( ) {
		return new Gee.ReadOnlyCollection<FormalParameter> ( this.err_domains );
	}

	public void add_error_domains ( Gee.Collection<Vala.DataType> vexceptions ) {
		foreach ( Vala.DataType vtref in vexceptions ) {
			var tmp = new TypeReference ( this.settings, vtref, (Valadoc.Basic)this, this.head, this.err );
			this.err_domains.add ( tmp );
		}
	}

	public void set_exception_type_references ( ) {
		foreach ( TypeReference tref in this.err_domains ) {
			tref.set_type_references ( );
		}
	}
}



public interface Valadoc.ParameterListHandler : Basic {
	protected abstract Gee.ArrayList<FormalParameter> param_list {
		protected set;
		get;
	}

	public abstract uint bracket_level {
		construct set;
		get;
	}

	public Gee.ReadOnlyCollection<FormalParameter> get_parameter_list ( ) {
		return new Gee.ReadOnlyCollection<FormalParameter> ( this.param_list );
	}

	protected void add_parameter_list ( Gee.Collection<Vala.FormalParameter> vparams ) {
		foreach ( Vala.FormalParameter vfparam in vparams ) {
			var tmp = new FormalParameter ( this.settings, vfparam, this, this.head, this.err );
			tmp.initialisation ( );
			this.param_list.add ( tmp );
		}
	}

	public void set_parameter_list_type_references ( ) {
		foreach ( FormalParameter fparam in this.param_list ) {
			fparam.set_type_references ( );
		}
	}
}



public interface Valadoc.MethodHandler : Basic {
	protected abstract Gee.ArrayList<Method> methods {
		protected set;
		get;
	}

	public abstract uint bracket_level {
		construct set;
		get;
	}

	protected inline Basic? search_method ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Method m in this.methods ) {
			if ( m.name == params[pos] )
				return m;
		}
		return null;
	}

	public void set_method_type_references ( ) {
		foreach ( Method m in this.methods ) {
			m.set_type_references ( );
		}
	}

	public void parse_method_comments ( ) {
		foreach ( Method m in this.methods ) {
			m.parse_comment ( );
		}
	}

	protected void add_method ( Vala.Method vmethod ) {
		var tmp = new Method ( this.settings, vmethod, this, this.head, this.err, bracket_level + 1 );
		tmp.initialisation ( );
		this.methods.add ( tmp );
	}

	protected void add_methods ( Gee.Collection<Vala.Method> vmethods ) {
		foreach ( Vala.Method vm in vmethods ) {
			var tmp = new Method ( this.settings, vm, this, this.head, this.err, bracket_level + 1 );
			tmp.initialisation ( );
			this.methods.add ( tmp );
		}
	}

	public void visit_methods ( Doclet doclet ) {
		foreach ( Method m in this.get_method_list() ) {
			m.visit ( doclet, this );
		}
	}


	public Gee.ReadOnlyCollection<Method> get_method_list ( ) {
		var lst = new Gee.ArrayList<Method> ();
		foreach ( Method m in this.methods ) {
			if ( !m.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( m );
		}

		return new Gee.ReadOnlyCollection<Method>( lst );
	}
}



public interface Valadoc.TemplateParameterListHandler : Basic {
	protected abstract Gee.ArrayList<TypeParameter> template_param_lst {
		set;
		get;
	}

	public Gee.ReadOnlyCollection<TypeParameter> get_template_param_list ( ) {
			return new Gee.ReadOnlyCollection<TypeParameter> ( this.template_param_lst );
	} 

	public void set_template_parameter_list ( Gee.Collection<Vala.TypeParameter> vtparams ) {
		foreach ( Vala.TypeParameter vtparam in vtparams ) {
			var tmp = new TypeParameter ( this.settings, vtparam, this, this.head, this.err );
			tmp.initialisation ( );
			this.template_param_lst.add ( tmp );
		}
	}

	public void set_template_parameter_list_references ( ) {
		foreach ( TypeParameter tparam in this.template_param_lst ) {
			tparam.set_type_reference ( );
		}
	}
}



public abstract class Valadoc.Variable : Basic {
}



public class Valadoc.Field : Variable, SymbolAccessibility, TypeHandler, Visitable {
	public Field ( Valadoc.Settings settings,
								 Vala.Field vfield,
								 Basic parent,
								 Tree head,
								 ErrorReporter err,
								 uint bracket_level ) {
		this.bracket_level = bracket_level;
		this.settings = settings;
		this.vfield = vfield;
		this.parent = parent;
		this.head = head;
		this.err = err;
	}

	public uint bracket_level {
		construct set;
		get;
	}

	public TypeReference type_reference {
		protected set;
		get;
	}

	public override string# name {
		get {
			return this.vfield.name;
		}
	}

	public void initialisation ( ) {
		this.vsymbol = this.vfield;

		var vret = this.vfield.type_reference;
		this.set_ret_type ( vret );
	}

	public Vala.Field vfield {
		construct set;
		protected get;
	}

	public bool is_global {
		get {
			return ( this.parent is Valadoc.Namespace )
				? true : false;
		}
	}

	public void set_type_references ( ) {
		((TypeHandler)this).set_type_references ( );
	}

	public void parse_comment ( ) {
		this.parse_comment_helper ( this.vsymbol, CommentContext.VARIABLE );
	}

	public void visit ( Doclet doclet, FieldHandler parent ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_field ( this, parent );
	}

	public void write ( Langlet langlet, void* ptr, FieldHandler parent ) {
		langlet.write_field ( this, parent, ptr );
	}

	public void write_comment ( void* ptr ) {
		if ( this.comment == null )
			return ;

		this.comment.write ( ptr );
	}
}



public class Valadoc.TypeReference : Variable {
	public TypeReference ( Valadoc.Settings settings,
												 Vala.DataType vtyperef,
												 Basic parent,
												 Tree head,
												 ErrorReporter err ) {
		this.is_return_type = false;
		this.settings = settings;
		this.vtyperef = vtyperef;
		this.parent = parent;
		this.head = head;
		this.err = err;
	}

	public TypeReference.return_type ( Valadoc.Settings settings,
																		 Vala.DataType vtyperef,
																		 Basic parent,
																		 Tree head,
																		 ErrorReporter err ) {
		this.is_return_type = true;
		this.settings = settings;
		this.vtyperef = vtyperef;
		this.parent = parent;
		this.head = head;
		this.err = err;
	}

	public bool is_return_type {
		construct set;
		protected get;
	}

	protected Gee.ArrayList<TypeReference> type_arguments = new Gee.ArrayList<TypeReference> ();

	public Gee.ReadOnlyCollection<TypeReference> get_type_arguments ( ) {
		return new Gee.ReadOnlyCollection<TypeReference> ( this.type_arguments );
	}

	private void set_template_argument_list ( Gee.Collection<Vala.DataType> varguments ) {
		foreach ( Vala.DataType vdtype in varguments ) {
			var dtype = new TypeReference ( this.settings, vdtype, this, this.head, this.err );
			dtype.set_type_references ( );
			this.type_arguments.add ( dtype );
		}
	}

	public DataType data_type {
		private set;
		get;
	}

	public Vala.DataType vtyperef {
		construct set;
		protected get;
	}

	public bool pass_ownership {
		get {
			return false;
		}
	}

	public bool is_nullable {
		get {
			return vtyperef.nullable && this.vtyperef is Vala.PointerType == false;
		}
	}

	public bool is_weak {
		get {
			return false;
		}
	}

	public bool is_pointer {
		get {
			return this.vtyperef is Vala.PointerType;
		}
	}

	public uint pointer_rank {
		get {
			if ( !this.is_pointer )
				return 0;

			Vala.DataType vdtype = this.vtyperef;
			for ( uint i = 0 ;; i++ ) {
				if ( vdtype is Vala.PointerType == false )
					return i;

				vdtype =  ((Vala.PointerType)vdtype).base_type;
			}
			return 0;
		}
	}

	public bool is_array {
		get {
			return this.vtyperef.is_array();
		}
	}

	public uint array_rank {
		get {
			if ( !this.is_array )
				return 0;

			return ((Vala.ArrayType)vtyperef).rank;
		}
	}

	public string# type_nspace_name {
		get {

			if ( this.data_type == null )
				return null;

			if ( this.data_type.nspace == null )
				return null;

			return this.data_type.nspace.name;
		}
	}

	public string# type_name {
		get {
			if ( this.vtyperef is Vala.PointerType ) {
				string str = ((Vala.PointerType)this.vtyperef).to_string();
				weak string str2 = str.str ( "*" );
				return str.ndup ( str.len() - str2.len() );
			}

			if ( this.is_array ) {
				return ((Vala.ArrayType)this.vtyperef).element_type.data_type.name;
			}

			var dtype = this.vtyperef.data_type;
			if ( dtype == null )
				return this.vtyperef.to_string();

			return dtype.name;
		}
	}

	private DataType _get_data_type ( Vala.Typesymbol vdtype, File file, Namespace ns ) {
		if ( vdtype is Vala.Enum  ) {
			return ns.find_enum ( (Vala.Enum)vdtype );
		}
		else if ( vdtype is Vala.ArrayType ) {
			var vtsym = ((Vala.ArrayType)vdtype).data_type;
			return this._get_data_type ( vtsym, file, ns );
		}
		else if ( vdtype is Vala.Class ) {
			return ns.find_class ( (Vala.Class)vdtype );
		}
		else if ( vdtype is Vala.Struct ) {
			return ns.find_struct ( (Vala.Struct)vdtype );
		}
		else if ( vdtype is Vala.Interface ) {
			return ns.find_interface ( (Vala.Interface)vdtype );
		}
		else if ( vdtype is Vala.PointerIndirection ) {
			Vala.Typesymbol vtsym = ((Vala.PointerType)vdtype).data_type;
			return this._get_data_type ( vtsym, file, ns );
		}
		return null;
	}

	private File get_file ( Vala.Typesymbol vdtype ) {
		if ( vdtype.source_reference == null ) {
			return null;
		}

		Vala.SourceFile vfile = vdtype.source_reference.file;
		File file = this.head.find_file ( vfile );
		return file;
	}

	private Namespace get_nspace ( File file, Vala.Symbol vns ) {
		while ( vns is Vala.Namespace == false ) {
			vns = vns.parent_symbol;
		}

		Namespace ns = file.find_namespace ( (Vala.Namespace)vns );
		return ns;
	}

	public virtual void set_type_references ( ) {
		this.data_type = this.get_type_references ( this.vtyperef );
	}

	public DataType get_type_references ( Vala.DataType vtyperef ) {
		if ( this.vtyperef is Vala.DelegateType ) {
			Vala.Delegate vdel = ((Vala.DelegateType)vtyperef).delegate_symbol;
			File file = this.get_file ( vdel );
			if ( file == null )
				return null; // err

			Namespace ns = this.get_nspace ( file, vdel );
			Valadoc.Delegate del = ns.find_delegate ( (Vala.Delegate)vdel );
			return del;
		}

		if ( vtyperef is Vala.PointerType ) {
			Vala.DataType vptr = ((Vala.PointerType)vtyperef).base_type;
			if ( vptr == null )
				return null;
			return this.get_type_references ( vptr );
		}

		if ( vtyperef is Vala.ArrayType ) {
			Vala.DataType vptr = ((Vala.ArrayType)vtyperef).element_type;
			if ( vptr == null )
				return null;
			return this.get_type_references ( vptr );
		}

		Vala.Typesymbol vdtype = vtyperef.data_type;
		if ( vdtype == null ) {
			return null;
		}

		var varguments = vtyperef.get_type_arguments ();
		this.set_template_argument_list ( varguments );

		File file = this.get_file ( vdtype );
		if ( file == null )
			return null; // err

		Namespace ns = this.get_nspace ( file, vdtype );
		return this._get_data_type ( vdtype, file, ns );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_type_reference ( this, ptr );
	}
}

// TODO: Remove unused stuff
// You just need it for the name in a template-parameter-list.
// remove TypeHandler-interface
public class Valadoc.TypeParameter : Variable, TypeHandler {
	public TypeParameter ( Valadoc.Settings settings,
												 Vala.TypeParameter vtypeparam,
												 Basic parent,
												 Tree head,
												 ErrorReporter err ) {
		this.vtypeparam = vtypeparam;
		this.settings = settings;
		this.parent = parent;
		this.head = head;
		this.err = err;
	}

	public TypeReference type_reference {
		protected set;
		get;
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_type_parameter ( this, ptr );
	}

	public Vala.TypeParameter vtypeparam {
		construct set;
		protected get;
	}

	public string# datatype_name {
		get {
			return this.vtypeparam.name;
		}
	}

	public void initialisation ( ) {
	}

	public void set_type_reference ( ) {
	}
}


public class Valadoc.FormalParameter : Variable, TypeHandler {
	public FormalParameter ( Valadoc.Settings settings,
													 Vala.FormalParameter vformalparam,
													 Basic parent,
													 Tree head,
													 ErrorReporter err ) {
		this.settings = settings;
		this.vformalparam = vformalparam;
		this.parent = parent;
		this.head = head;
		this.err = err;
	}

	public bool is_out {
		get {
			return this.vformalparam.direction == ParameterDirection.OUT;
		}
	}

	public bool is_ref {
		get {
			return this.vformalparam.direction == ParameterDirection.REF;
		}
	}

	public ExpressionType default_vaule_type {
		default = ExpressionType.NOT_SET;
		private set;
		get;
	}

	public string? default_value {
		private set;
		public get;
	}

	public void initialisation ( ) {
		this.vsymbol = this.vformalparam;

		var vformparam = this.vformalparam.type_reference;
		this.set_ret_type ( vformparam );

		var def = this.vformalparam.default_expression;
		if ( def != null ) {
			{
				if ( def is Vala.StringLiteral ) {
					this.default_value = ((Vala.StringLiteral)def).value;
					this.default_vaule_type = ExpressionType.STRING;
				}
				else if ( def is Vala.CharacterLiteral ) {
					this.default_value = ((Vala.CharacterLiteral)def).value;
					this.default_vaule_type = ExpressionType.CHAR;
				}
				else if ( def is Vala.RealLiteral ) {
					this.default_vaule_type = ExpressionType.REAL;
					this.default_value = ((Vala.RealLiteral)def).value;
				}
				else if ( def is BooleanLiteral ) {
					this.default_value = ((Vala.BooleanLiteral)def).value;
					this.default_vaule_type = ExpressionType.BOOL;
				}
				else if ( def is IntegerLiteral ) {
					this.default_value = ((Vala.IntegerLiteral)def).value;
					this.default_vaule_type = ExpressionType.INT;
				}
				else if ( def is NullLiteral )  {
					this.default_vaule_type = ExpressionType.NULL;
					this.default_value = "null";
				}
			}
		}
	}

	public TypeReference type_reference {
		protected set;
		get;
	}

	public bool ellipsis {
		get {
			return this.vformalparam.ellipsis;
		}
	}

	public bool is_construct {
		get {
			return this.vformalparam.construct_parameter;
		}
	}

	public override string# name {
		get {
			return ( this.vformalparam.name == null )
				? "" : this.vformalparam.name;
		}
	}

	public Vala.FormalParameter vformalparam {
		construct set;
		protected get;
	}

	public void set_type_references ( ) {
		if ( this.vformalparam.ellipsis )
			return ;

		((TypeHandler)this).set_type_references ( );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_formal_parameter ( this, ptr );
	}
}



public class Valadoc.PropertyAccessor : Object {
	public PropertyAccessor ( Valadoc.Settings settings,
										Vala.PropertyAccessor vpropacc,
										Property parent,
										Tree head,
										ErrorReporter err )
	{
		this.parent = parent;
		this.settings = settings;
		this.vpropacc = vpropacc;
		this.head = head;
		this.err = err;
	}

	public void construction ( ) {
	}

	public Tree head {
		construct;
		get;
	}

	public Vala.PropertyAccessor vpropacc {
		construct;
		private get;
	}

	public Settings settings {
		construct;
		get;
	}

	public Property parent {
		private set;
		get;
	}

	public Tree tree {
		construct;
		get;
	}

	public ErrorReporter err {
		construct;
		get;
	}

	public bool is_construct {
		get {
			return this.vpropacc.construction;
		}
	}

	public bool is_protected {
		get {
			return this.vpropacc.access == Vala.SymbolAccessibility.PROTECTED;
		}
	}

	public bool is_public {
		get {
			return this.vpropacc.access == Vala.SymbolAccessibility.PUBLIC;
		}
	}

	public bool is_private {
		get {
			return this.vpropacc.access == Vala.SymbolAccessibility.PRIVATE;
		}
	}

	public bool is_set {
		get {
			return this.vpropacc.writable;
		}
	}

	public bool is_get {
		get {
			return this.vpropacc.readable;
		}
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_property_accessor ( this, ptr );
	}
}


public class Valadoc.Property : Basic, SymbolAccessibility, ReturnTypeHandler, Visitable {
	public Property ( Valadoc.Settings settings,
										Vala.Property vproperty,
										ContainerDataType parent,
										Tree head,
										ErrorReporter err,
										uint bracket_level ) {
		this.settings = settings;
		this.vproperty = vproperty;
		this.parent = parent;
		this.head = head;
		this.err = err;
		this.bracket_level = bracket_level;
	}

	public uint bracket_level {
		construct set;
		get;
	}

	public bool equals ( Property p ) {
		return this.vproperty.equals ( p.vproperty );
	}

	public TypeReference return_type {
		protected set;
		get;
	}

	public bool is_virtual {
		get {
			return this.vproperty.is_virtual;
		}
	}

	public bool is_abstract {
		get {
			return this.vproperty.is_abstract;
		}
	}

	public bool is_override {
		get {
			return this.vproperty.overrides;
		}
	}

	public PropertyAccessor setter {
		private set;
		get;
	}

	public PropertyAccessor getter {
		private set;
		get;
	}

	public void initialisation ( ) {
		this.vsymbol = vproperty;

		var ret = this.vproperty.type_reference;
		this.set_ret_type ( ret );

		if ( this.vproperty.get_accessor != null )
			this.getter = new PropertyAccessor ( this.settings, this.vproperty.get_accessor, this, this.head, this.err );

		if ( this.vproperty.set_accessor != null )
			this.setter = new PropertyAccessor ( this.settings, this.vproperty.set_accessor, this, this.head, this.err );
	}

	public Vala.Property vproperty {
		construct set;
		protected get;
	}

	public override string# name {
		get {
			return this.vproperty.name;
		}
	}

	public void set_type_references ( ) {
		this.set_return_type_references ( );
	}

	public void parse_comment ( ) {
		this.parse_comment_helper ( this.vproperty, CommentContext.PROPERTY );
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_property ( this );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_property ( this, ptr );
	}

	public void write_comment ( void* ptr ) {
		if ( this.comment == null )
			return ;

		this.comment.write ( ptr );
	}
}



public class Valadoc.Signal : Basic, ParameterListHandler, SymbolAccessibility,
															ReturnTypeHandler, Visitable {
	public Signal ( Valadoc.Settings settings,
									Vala.Signal vsignal,
									ContainerDataType parent,
									Tree head,
									ErrorReporter err,
									uint bracket_level ) {
		this.settings = settings;
		this.vsignal = vsignal;
		this.parent = parent;
		this.head = head;
		this.err = err;
		this.bracket_level = bracket_level;
	}

	construct {
		this.param_list = new Gee.ArrayList<FormalParameter> ();
	}

	public uint bracket_level {
		construct set;
		get;
	}

	public TypeReference return_type {
		protected set;
		get;
	}

	public void initialisation ( ) {
		this.vsymbol = vsignal;

		var vparamlst = this.vsignal.get_parameters ();
		this.add_parameter_list ( vparamlst );

		var ret = this.vsignal.return_type;
		this.set_ret_type ( ret );
	}

	protected Gee.ArrayList<FormalParameter> param_list {
		protected set;
		get;
	}

	public Vala.Signal vsignal {
		construct set;
		protected get;
	}

	public void set_type_references ( ) {
		this.set_parameter_list_type_references ( );
		this.set_return_type_references ( );
	}

	public void parse_comment ( ) {
		this.parse_comment_helper ( this.vsignal, CommentContext.SIGNAL );
	}

	public override string# name {
		get {
			return this.vsignal.name;
		}
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_signal ( this );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_signal ( this, ptr );
	}

	public void write_comment ( void* ptr ) {
		if ( this.comment == null )
			return ;

		this.comment.write ( ptr );
	}
}



public class Valadoc.Method : Basic, ParameterListHandler, ExceptionHandler, TemplateParameterListHandler,
															SymbolAccessibility, ReturnTypeHandler, Visitable {
	public Method ( Valadoc.Settings settings,
									Vala.Method vmethod,
									Basic parent,
									Tree head,
									ErrorReporter err,
									uint bracket_level ) {
		this.settings = settings;
		this.vmethod = vmethod;
		this.parent = parent;
		this.head = head;
		this.err = err;
		this.bracket_level = bracket_level;
	}


	construct {
		this.err_domains = new Gee.ArrayList<TypeReference>();
		this.param_list = new Gee.ArrayList<FormalParameter>();
		this.template_param_lst = new Gee.ArrayList<TypeParameter> ();
	}

	public Method base_method {
		get;
		set;
	}

	public uint bracket_level {
		construct set;
		get;
	}

	public TypeReference return_type {
		protected set;
		get;
	}

	public Gee.ArrayList<TypeParameter> template_param_lst {
		protected set;
		get;
	}

	public Gee.ArrayList<FormalParameter> param_list {
		protected set;
		get;
	}

	public Gee.ArrayList<TypeReference> err_domains {
		protected set;
		get;
	}

	public string comment_str {
		get {
			return this.vmethod.source_reference.comment;
		}
	}

	public void write_comment ( void* ptr ) {
		if ( this.comment == null )
			return ;

		this.comment.write ( ptr );
	}

	public bool equals ( Method m ) {
		return ( m.vmethod == this.vmethod );
//		return this.vmethod.equals ( m.vmethod );
	}

	public void parse_comment ( ) {
		if ( this.comment != null )
			return ;

		string str = this.get_comment_string ( this.vmethod );
		if ( str == null )
			return ;

		if ( !CommentParser.is_comment_string( str ) )
			return ;

		if ( this.is_override && CommentParser.is_inherit_doc( str ) ) {
			this.base_method.parse_comment ( );
			this.comment = this.base_method.comment;
			return ;
		}

		this.parse_comment_string ( str, CommentContext.METHOD );
	}

	public void initialisation ( ) {
		this.vsymbol = vmethod;

		var vret = this.vmethod.return_type;
		this.set_ret_type ( vret );

		var vparamlst = this.vmethod.get_parameters ();
		this.add_parameter_list ( vparamlst );

		var vexceptionlst = this.vmethod.get_error_domains ();
		this.add_error_domains ( vexceptionlst );
	}

	public Vala.Method vmethod {
		construct set;
		protected get;
	}

	public bool is_abstract {
		get {
			return this.vmethod.is_abstract;
		}
	}

	public bool is_virtual {
		get {
			return this.vmethod.is_virtual;
		}
	}

	public bool is_override {
		get {
			return this.vmethod.overrides;
		}
	}

	public bool is_static {
		get {
			return !this.vmethod.instance;
		}
	}

	public string# parent_name {
		get {
			return this.parent.name;
		}
	}

	public bool is_global {
		get {
			return ( this.parent is Namespace )
				? true : false;
		}
	}

	public bool is_constructor {
		get {
			return ( this.vmethod is Vala.CreationMethod )?
				true : false;
		}
	}

	public override string# name {
		get {
			if ( this.is_constructor )
				return this.parent_name + this.vmethod.name.offset( ".new".len() );
			else
				return this.vmethod.name;
		}
	}

	public void set_type_references ( ) {
		this.set_return_type_references ( );

		this.set_exception_type_references ( );
		this.set_parameter_list_type_references ( );
	}

	public void visit ( Doclet doclet, Valadoc.MethodHandler in_type ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_method ( this, in_type );
	}

	public void write ( Langlet langlet, void* ptr, Valadoc.MethodHandler parent ) {
		langlet.write_method ( ptr, this, parent );
	}
}



public class Valadoc.EnumValue: Basic {
	public EnumValue ( Valadoc.Settings settings,
										 Vala.EnumValue venval,
										 Enum parent,
										 Tree head,
										 ErrorReporter err ) {
		this.settings = settings;
		this.venval = venval;
		this.parent = parent;
		this.head = head;
		this.err = err;
	}

	public void initialisation ( ) {
		this.bracket_level = 1;
		this.vsymbol = venval;
	}

	public uint bracket_level {
		construct set;
		get;
	}

	public override string# name {
		get {
			return this.venval.name;
		}
	}

	public Vala.EnumValue venval {
		construct set;
		protected get;
	}

	public void parse_comment ( ) {
		this.parse_comment_helper ( this.venval, CommentContext.ENUM_VALUE );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_enum_value ( this, ptr );
	}

	// move to a interface
	public void write_comment ( void* ptr ) {
		if ( this.comment == null )
			return ;

		this.comment.write ( ptr );
	}

	public void visit ( Doclet doclet ) {
		doclet.visit_enum_value ( this );
	}
}



public class Valadoc.ErrorCode : Basic {
	public ErrorCode ( Valadoc.Settings settings,
										 Vala.ErrorCode verrcode,
										 ErrorDomain parent,
										 Tree head,
										 ErrorReporter err ) {
		this.settings = settings;
		this.verrcode = verrcode;
		this.parent = parent;
		this.head = head;
		this.err = err;
	}

	public void initialisation ( ) {
		this.bracket_level = 1;
		this.vsymbol = verrcode;
	}

	public void parse_comments ( ) {
		// TODO: Change Context
		this.parse_comment_helper ( this.verrcode, CommentContext.ENUM_VALUE );
	}

	public uint bracket_level {
		construct set;
		get;
	}

	public override string# name {
		get {
			return this.verrcode.name;
		}
	}

	public Vala.ErrorCode verrcode {
		construct set;
		protected get;
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_error_code ( this, ptr );
	}

	public void parse_comment ( ) {
		// TODO: Change the CommentContext!
		this.parse_comment_helper ( this.verrcode, CommentContext.ENUM_VALUE );
	}

	// move to a interface
	public void write_comment ( void* ptr ) {
		if ( this.comment == null )
			return ;

		this.comment.write ( ptr );
	}

	public void visit ( Doclet doclet ) {
		doclet.visit_error_code ( this );
	}
}



public abstract class Valadoc.DataType: Basic, SymbolAccessibility, Visitable {
	public override string# name {
		get {
			return this.vsymbol.name;
		}
	}

	public uint bracket_level {
		construct set;
		get;
	}

	public virtual void set_type_references ( ) {
	}

	public virtual void visit ( Doclet doclet ) {
	}

	public virtual void write ( Langlet langlet, void* ptr ) {
	}

	// move to a interface
	public virtual void write_comment ( void* ptr ) {
		if ( this.comment == null )
			return ;

		this.comment.write ( ptr );
	}
}


public class Valadoc.Delegate : DataType, ParameterListHandler, SymbolAccessibility,
																ReturnTypeHandler, TemplateParameterListHandler,
																ExceptionHandler {
	public Delegate ( Valadoc.Settings settings,
										Vala.Delegate vdelegate,
										Namespace parent,
										Tree head,
										ErrorReporter err,
										uint bracket_level ) {
		this.settings = settings;
		this.vdelegate = vdelegate;
		this.parent = parent;
		this.head = head;
		this.err = err;
		this.bracket_level = bracket_level;
	}

	construct {
		this.err_domains = new Gee.ArrayList<TypeReference>();
		this.param_list = new Gee.ArrayList<FormalParameter> ();
		this.template_param_lst = new Gee.ArrayList<TypeParameter> ();
	}

	public TypeReference return_type {
		protected set;
		get;
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_delegate ( this );
	}

	public Gee.ArrayList<TypeParameter> template_param_lst {
		protected set;
		get;
	}

	protected Gee.ArrayList<FormalParameter> param_list {
		protected set;
		get;
	}

	protected Gee.ArrayList<TypeReference> err_domains {
		protected set;
		get;
	}

	public void initialisation ( ) {
		this.vsymbol = this.vdelegate;

		var vparamlst = this.vdelegate.get_parameters ();
		this.add_parameter_list ( vparamlst );

		var ret = this.vdelegate.return_type;
		this.set_ret_type ( ret );
	}

	public Vala.Delegate vdelegate {
		construct set;
		protected get;
	}

	public bool is_static {
		get {
			return !this.vdelegate.instance;
		}
	}

	public void set_type_references ( ) {
		this.set_template_parameter_list_references ( );
		this.set_parameter_list_type_references ( );
		this.set_return_type_references ( );
	}

	public void parse_comments ( ) {
		this.parse_comment_helper ( this.vdelegate, CommentContext.DELEGATE );
	}

	public bool is_vdelegate ( Vala.Delegate vdel ) {
		return ( this.vdelegate == vdel )? true : false;
	}

	public override void write ( Langlet langlet, void* ptr ) {
		langlet.write_delegate ( this, ptr );
	}
}



public abstract class Valadoc.ContainerDataType : DataType, MethodHandler, Visitable,
																									TemplateParameterListHandler {
	protected Gee.ArrayList<DataType> parent_types = new Gee.ArrayList<DataType>();

	construct {
		this.template_param_lst = new Gee.ArrayList<TypeParameter> ();
		this.methods = new Gee.ArrayList<Method> ();
	}

	protected Gee.ArrayList<Method> methods {
		set;
		get;
	}

	public virtual string# comment_str {
		get {
			return null;
		}
	}

	protected Gee.ArrayList<TypeParameter> template_param_lst {
		set;
		get;
	}

	public Gee.Collection<DataType> get_parent_types ( ) {
		return this.parent_types;
	}

	public bool derived_from_interface ( Interface iface ) {
		foreach ( DataType dtype in this.parent_types ) {
			if ( dtype == iface )
				return true;
		}
		return false;
	}

	public virtual void parse_comments ( ) {
		this.parse_method_comments ( );
	}

	protected void set_parent_references ( Gee.Collection<Vala.DataType> lst ) {
		if ( ((Gee.Collection)this.parent_types).size != 0 )
			return ;

		foreach ( Vala.DataType vtyperef in lst ) {
			var vtype = vtyperef.data_type;
			if ( vtype == null )
				return ;

			Vala.SourceFile vfile = vtype.source_reference.file;
			File file = this.head.find_file ( vfile );

			Vala.Symbol vns = vtype;
			while ( vns is Vala.Namespace == false ) {
				vns = vns.parent_symbol;
			}

			Namespace ns = file.find_namespace ( (Vala.Namespace)vns );


			if ( vtype is Vala.Class ) {
				var tmp = ns.find_vclass ( (Vala.Class)vtype );
				this.parent_types.add ( tmp );
			}
			else if ( vtype is Vala.Interface ) {
				var tmp = ns.find_interface ( (Vala.Interface)vtype );
				this.parent_types.add ( tmp );
			}
		}
	}

	public override void set_type_references ( ) {
		this.set_template_parameter_list_references ( );
		this.set_method_type_references ( );
		base.set_type_references ( );
	}

	public bool is_double_method ( Method met ) {
		foreach ( Method m2 in this.methods ) {
			if ( met == m2 )
				continue;

			if ( met.name == m2.name )
				return true;
		}
		return false;
	}
}



public class Valadoc.Class : ContainerDataType, Visitable, ClassHandler, StructHandler, SignalHandler,
														 PropertyHandler, ConstructionMethodHandler, FieldHandler {
	public Class ( Valadoc.Settings settings,
								 Vala.Class vclass,
								 Basic parent,
								 Tree head,
								 ErrorReporter err,
								 uint bracket_level ) {
		this.settings = settings;
		this.vclass = vclass;
		this.parent = parent;
		this.head = head;
		this.err = err;
		this.bracket_level = bracket_level;
	}

	private bool inherited = false;
	private Drawer.Class img;

	protected Gee.ArrayList<Field> fields {
		set;
		get;
	}

	protected Gee.ArrayList<Method> construction_methods {
		set;
		get;
	}

	protected Gee.ArrayList<Property> properties {
		get;
		set;
	}
	protected Gee.ArrayList<Class> classes {
		set;
		get;
	}

	protected Gee.ArrayList<Struct> structs {
		set;
		get;
	}

	protected Gee.ArrayList<Signal> signals {
		get;
		set;
	}

	public override Basic? search_in_upper_namespace ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos+1] == null )
			return this;

		var element = this.search_field ( params, pos );
		if ( element != null )
			return element;

		element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_construction_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_signal ( params, pos );
		if ( element != null )
			return element;

		element = this.search_property ( params, pos );
		if ( element != null )
			return element;


		element = this.search_struct ( params, pos );
		if ( element != null )
			return element;

		element = this.search_class ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	public void initialisation ( ) {
		this.construction_methods = new Gee.ArrayList<Method>();
		this.properties = new Gee.ArrayList<Property>();
		this.structs = new Gee.ArrayList<Struct> ();
		this.classes = new Gee.ArrayList<Class> ();
		this.signals = new Gee.ArrayList<Signal>();
		this.fields = new Gee.ArrayList<Field> ();
		this.vsymbol = this.vclass;

		var vtparams = this.vclass.get_type_parameters ();
		this.set_template_parameter_list ( vtparams );

		Gee.Collection<Vala.Field> vfields = this.vclass.get_fields();
		this.add_fields ( vfields );

		Gee.Collection<Vala.Method> vmethods = this.vclass.get_methods ();
		this.add_methods_and_construction_methods ( vmethods );

		Gee.Collection<Vala.Signal> vsignals = this.vclass.get_signals();
		this.add_signals ( vsignals );

		Gee.Collection<Vala.Property> vproperties = this.vclass.get_properties();
		this.add_properties ( vproperties );
	}

	public override string# comment_str {
		get {
			return this.vclass.source_reference.comment;
		}
	}

	public Vala.Class vclass {
		construct set;
		protected get;
	}

	public bool is_vclass ( Vala.Class vcl ) {
		return this.vclass == vcl;
	}

	public override void write ( Langlet langlet, void* ptr ) {
		langlet.write_class ( this, ptr );
	}

	public bool is_abstract {
		get {
			return this.vclass.is_abstract;
		}
	}

	public bool is_static {
		get {
			return this.vclass.is_static;
		}
	}

	public override void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_class ( this );
	}

	public override void parse_comments ( ) {
		this.parse_comment_helper ( this.vclass, CommentContext.CLASS );
		this.parse_construction_method_comments ( );
		this.parse_property_comments ( );
		this.parse_struct_comments ( );
		this.parse_signal_comments ( );
		this.parse_class_comments ( );
		this.parse_field_comments ( );
		base.parse_comments ( );
	}

	protected bool is_double_field ( Field f ) {
		foreach ( Field f2 in this.fields ) {
			if ( f == f2 )
				continue ;

			if ( f.name == f2.name )
				return true;
		}
		return false;
	}

	protected Method find_base_method ( Method mt ) {
		foreach ( Method m in this.methods ) {
			if ( m.parent != this )
				continue ;

			if ( !m.is_override )
				continue ;

			if ( m.equals ( mt ) )
				return m;
		}
		return null;
	}

/*
	protected bool is_overwritten_method ( Method mt ) {
		foreach ( Method m in this.methods ) {
			if ( m.parent != this )
				continue ;

			if ( !m.is_override )
				continue ;

			if ( m.equals ( mt ) )
				return true;
		}
		return false;
	}
*/
	public override void set_type_references ( ) {
		base.set_type_references ( );

		var lst = this.vclass.get_base_types ();
		this.set_parent_references ( lst );

		this.set_construction_method_references ( );
		this.set_property_type_reference ( );
		this.set_signal_type_references ( );
		this.set_field_type_references ( );
		this.set_struct_references ( );
		this.set_class_references ( );
	}

	private void inheritance_class ( Class dtype ) {
		dtype.inheritance ( );

		if ( dtype.name == "Object" )
			return ;

		var flst = dtype.get_field_list ( );
		foreach ( Field f in flst ) {
			this.fields.add ( f );
		}

		var plst = dtype.get_property_list ( );
		foreach ( Property prop in plst ) {
			this.properties.add ( prop );
		}

		var proplst = dtype.get_property_list ( );
		foreach ( Property p in proplst ) {
			if ( p.is_private )
				continue ;

			if ( p.is_override ) {
				if ( this.is_overwritten_property ( p ) )
					continue ;
			}

			this.properties.add ( p );
		}

		var mlst = dtype.get_method_list ( );
		foreach ( Method m in mlst ) {
			if ( m.is_private )
				continue ;

			if ( m.is_virtual || m.is_override ) {
				Method basem = find_base_method ( m );
				if ( basem != null )
					basem.base_method = m;
					continue ;
			}

			this.methods.add ( m );
		}
	}

	private void inheritance_interface ( Interface dtype ) {
		/*if ( dtype.derived_from_interface ( dtype ) )
			return ; */

		var plst = dtype.get_property_list ( );
		foreach ( Property p in plst ) {
			if ( p.is_private )
				continue ;

			if ( p.is_abstract )
				continue ;

			this.properties.add ( p );
		}

		var mlst = dtype.get_method_list ( );
		foreach ( Method m in mlst ) {
			if ( m.is_private )
				continue ;

			if ( m.is_abstract )
				continue ;

			this.methods.add ( m );
		}

		var slst = dtype.get_signal_list ( );
		foreach ( Signal sig in slst ) {
			if ( sig.is_private )
				continue ;

			this.signals.add ( sig );
		}
	}

	public void inheritance ( ) {
		if ( inherited == true )
			return ;

		inherited = true;
		foreach ( DataType dtype in this.parent_types ) {
			if ( dtype is Class )
				this.inheritance_class ( (Class)dtype );
			else if ( dtype is Interface ) 
				this.inheritance_interface ( (Interface)dtype );
		}

		foreach ( Class cl in this.classes ) {
			cl.inheritance( );
		}
	}

	public Drawer.Class get_image ( ) {
		if ( this.img == null ) {
			var lst = new Gee.ArrayList<Drawer.Interface> ();
			Drawer.Class parent = null;

			foreach ( DataType dtype in this.get_parent_types ( ) ) {
				if ( dtype is Valadoc.Class ) {
					parent = ((Valadoc.Class)dtype).get_image ( );
					continue ;
				}
				lst.add ( ((Valadoc.Interface)dtype).get_image() );
			}
			this.img = new Drawer.Class ( this.name, this.nspace.name, parent, lst );
		}
		return img;
	}
}



public class Valadoc.ErrorDomain : DataType, MethodHandler, Visitable {
	public ErrorDomain ( Valadoc.Settings settings,
											 Vala.ErrorDomain verrdom,
											 Namespace parent,
											 Tree head,
											 ErrorReporter err ) {
		this.settings = settings;
		this.verrdom = verrdom;
		this.parent = parent;
		this.head = head;
		this.err = err;
	}

	private Gee.ArrayList<ErrorCode> errcodes = new Gee.ArrayList<ErrorCode> ();

	private Vala.ErrorDomain verrdom {
		protected set;
		get;
	}

	protected Gee.ArrayList<Method> methods {
		protected set;
		get;
	}

	private inline Basic? search_error_code ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( ErrorCode errcode in this.errcodes ) {
			if ( errcode.name == params[pos] )
				return errcode;
		}
		return null;
	}

	public override Basic? search_in_upper_namespace ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos+1] == null )
			return this;

			var element = this.search_method ( params, pos );
			if ( element != null )
				return element;

			element = this.search_error_code ( params, pos );
			if ( element != null )
				return element;

		return null;
	}

	public void parse_comments ( ) {
		this.parse_comment_helper ( this.verrdom, CommentContext.ENUM );
		this.parse_method_comments ( );

		foreach ( ErrorCode errcode in this.errcodes ) {
			errcode.parse_comments ( );
		}
	}

	public void visit_error_codes ( Doclet doclet ) {
		foreach ( ErrorCode errcode in this.errcodes )
			errcode.visit ( doclet );
	}

	public Gee.ReadOnlyCollection<ErrorCode> get_error_code_list ( ) {
		return new Gee.ReadOnlyCollection<ErrorCode> ( this.errcodes );
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_error_domain ( this );
	}

	public override void write ( Langlet langlet, void* ptr ) {
		langlet.write_error_domain ( this, ptr );
	}

	private inline void append_error_code ( Gee.Collection<Vala.ErrorCode> verrcodes ) {
		foreach ( Vala.ErrorCode verrcode in verrcodes ) {
			var tmp = new ErrorCode ( this.settings, verrcode, this, this.head, this.err );
			tmp.initialisation ( );
			this.errcodes.add ( tmp );
		}
	}

	public override void set_type_references ( ) {
		this.set_method_type_references ( );
	}

	public void initialisation ( ) {
		this.vsymbol = this.verrdom;

		Gee.Collection<Vala.Method> vmethods = this.verrdom.get_methods ();
		this.methods = new Gee.ArrayList<Method> ();
		this.add_methods ( vmethods );

		Gee.Collection<Vala.ErrorCode> verrcodes = this.verrdom.get_codes ();
		this.append_error_code ( verrcodes );
	}
}



public class Valadoc.Enum : DataType, MethodHandler, Visitable {
	public Enum ( Valadoc.Settings settings,
								Vala.Enum venum,
								Namespace parent,
								Tree head,
								ErrorReporter err ) {
		this.settings = settings;
		this.venum = venum;
		this.parent = parent;
		this.head = head;
		this.err = err;
	}

	private inline Basic? search_enum_value ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( EnumValue enval in this.en_values ) {
			if ( enval.name == params[pos] )
				return enval;
		}
		return null;
	}

	public override Basic? search_in_upper_namespace ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos+1] == null )
			return this;


		var element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_enum_value ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	public override void set_type_references ( ) {
		this.set_method_type_references ( );
	}

	construct {
		this.en_values = new Gee.ArrayList<EnumValue> ();
		this.methods = new Gee.ArrayList<Method> ();
	}

	protected Gee.ArrayList<Method> methods {
		protected set;
		get;
	}

	protected Gee.ArrayList<EnumValue> en_values {
		get;
		set;
	}

	public Gee.ReadOnlyCollection<EnumValue> get_enum_values () {
		return new Gee.ReadOnlyCollection<EnumValue>( this.en_values );
	}

	public void parse_comments ( ) {
		this.parse_comment_helper ( this.venum, CommentContext.ENUM );
		this.parse_enum_value_comments (  );
		this.parse_method_comments ( );
	}

	private inline void add_enum_values ( Gee.Collection<Vala.EnumValue> venvals ) {
		foreach ( Vala.EnumValue venval in venvals ) {
			var tmp = new EnumValue ( this.settings, venval, this, this.head, this.err );
			tmp.initialisation ( );
			this.en_values.add ( tmp );
		}
	}

	public void initialisation ( ) {
		this.vsymbol = this.venum;

		Gee.Collection<Vala.Method> vmethods = this.venum.get_methods ();
		this.add_methods ( vmethods );

		Gee.Collection<Vala.EnumValue> venvals = this.venum.get_values ();
		this.add_enum_values ( venvals );
	}

	public void visit_enum_values ( Doclet doclet ) {
		foreach ( EnumValue enval in this.en_values )
			enval.visit ( doclet );
	}

	public override void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_enum ( this );
	}

	public Vala.Enum venum {
		construct set;
		protected get;
	}

	public bool is_venum ( Vala.Enum ven ) {
		return ( this.venum == ven )? true : false;
	}

	public override void write ( Langlet langlet, void* ptr ) {
		langlet.write_enum ( this, ptr );
	}

	public void parse_enum_value_comments ( ) {
		foreach ( EnumValue enval in this.en_values ) {
			enval.parse_comment ( );
		}
	}
}



public class Valadoc.Struct : ContainerDataType, Visitable, ConstructionMethodHandler, FieldHandler {
	public Struct ( Valadoc.Settings settings,
								  Vala.Struct vstruct,
								  Basic parent,
								  Tree head,
								  ErrorReporter err,
								  uint bracket_level ) {
		this.settings = settings;
		this.vstruct = vstruct;
		this.parent = parent;
		this.head = head;
		this.err = err;
		this.bracket_level = bracket_level;
	}

	protected Gee.ArrayList<Field> fields {
		set;
		get;
	}

	protected Gee.ArrayList<Method> construction_methods {
		set;
		get;
	}

	public override Basic? search_in_upper_namespace ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos+1] == null )
			return this;

		var element = this.search_field ( params, pos );
		if ( element != null )
			return element;

		element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		return this.search_construction_method ( params, pos );
	}

	public void initialisation ( ) {
		this.construction_methods = new Gee.ArrayList<Method>();
		this.fields = new Gee.ArrayList<Field> ();
		this.vsymbol = this.vstruct;

		Gee.Collection<Vala.Field> vfields = this.vstruct.get_fields();
		this.add_fields ( vfields );

		Gee.Collection<Vala.Method> vmethods = this.vstruct.get_methods ();
		this.add_methods_and_construction_methods ( vmethods );
	}

	public virtual string# comment_str {
		get {
			return this.vstruct.source_reference.comment;
		}
	}

	public Vala.Struct vstruct {
		construct set;
		protected get;
	}

	public bool is_vstruct ( Vala.Struct vstru ) {
		return ( this.vstruct == vstru )? true : false;
	}

	public override void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_struct ( this );
	}

	public override void write ( Langlet langlet, void* ptr ) {
		langlet.write_struct ( this, ptr );
	}

	public override void parse_comments ( ) {
		this.parse_comment_helper ( this.vstruct, CommentContext.STRUCT );
		this.parse_construction_method_comments ( );
		this.parse_field_comments ( );
		base.parse_comments ( );
	}

	public override void set_type_references ( ) {
		this.set_construction_method_references ( );
		this.set_field_type_references ( );
		base.set_type_references ( );

		var lst = this.vstruct.get_base_types ();
		this.set_parent_references ( lst );
	}
}



public class Valadoc.Interface : ContainerDataType, Visitable, SignalHandler, PropertyHandler {
	public Interface ( Valadoc.Settings settings,
										 Vala.Interface vinterface,
										 Namespace parent,
										 Tree head,
										 ErrorReporter err ) {
		this.settings = settings;
		this.vinterface = vinterface;
		this.parent = parent;
		this.head = head;
		this.err = err;
	}

	private Drawer.Interface img;

	protected Gee.ArrayList<Property> properties {
		get;
		set;
	}

	protected Gee.ArrayList<Signal> signals {
		get;
		set;
	}

	public Vala.Interface vinterface {
		construct set;
		protected get;
	}

	public override Basic? search_in_upper_namespace ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos+1] == null )
			return this;

		var element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_signal ( params, pos );
		if ( element != null )
			return element;

		element = this.search_property ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	public void initialisation ( ) {
		this.properties = new Gee.ArrayList<Property>();
		this.signals = new Gee.ArrayList<Signal>();
		this.vsymbol = this.vinterface;

		var vtparams = this.vinterface.get_type_parameters ();
		this.set_template_parameter_list ( vtparams );

		Gee.Collection<Method> methods = this.vinterface.get_methods ();
		this.add_methods ( methods );

		Gee.Collection<Signal> signals = this.vinterface.get_signals();
		this.add_signals ( signals );

		Gee.Collection<Property> properties = this.vinterface.get_properties();
		this.add_properties ( properties );
	}

	public virtual string# comment_str {
		get {
			return this.vinterface.source_reference.comment;
		}
	}

	public bool is_vinterface ( Vala.Interface viface ) {
		return ( this.vinterface == viface )? true : false;
	}

	public override void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_interface ( this );
	}

	public override void write ( Langlet langlet, void* ptr ) {
		langlet.write_interface ( this, ptr );
	}

	public override void parse_comments ( ) {
		this.parse_comment_helper ( this.vinterface, CommentContext.INTERFACE );
		this.parse_property_comments ( );
		this.parse_signal_comments ( );
		base.parse_comments ( );
	}

	public override void set_type_references ( ) {
		base.set_type_references ( );

		this.set_property_type_reference ();
		this.set_signal_type_references ();

		var lst = this.vinterface.get_prerequisites ( );
		this.set_parent_references ( lst );
	}

	public Drawer.Interface get_image ( ) {
		if ( this.img == null ) {
			// not done!
			this.img = new Drawer.Interface ( this.name, this.nspace.name, null, null );
		}
		return img;
	}
}


public class Valadoc.Namespace : Basic, MethodHandler, FieldHandler, Visitable, NamespaceHandler,
																 SymbolAccessibility, ClassHandler, StructHandler
{
	private Gee.ArrayList<Interface> interfaces = new Gee.ArrayList<Interface>();
	private Gee.ArrayList<Delegate> delegates = new Gee.ArrayList<Delegate>();
	private Gee.ArrayList<Enum> enums = new Gee.ArrayList<Enum>();
	private Gee.ArrayList<ErrorDomain> errdoms = new Gee.ArrayList<ErrorDomain>();

	private string _full_name = null;

	public Gee.ArrayList<Namespace> namespaces {
		private set;
		get;
	}

	protected Gee.ArrayList<Class> classes {
		private set;
		get;
	}

	protected Gee.ArrayList<Struct> structs {
		private set;
		get;
	}

	public string full_name {
		get {
			if ( this.name == null )
				return null;

			if ( this._full_name == null ) {
				this._full_name = this.name;
				Basic pos = this.parent;

				while ( pos is Namespace ) {
					this._full_name = pos.name + "." + this._full_name;
					pos = pos.parent;
				}
			}

			return this._full_name;
		}
	}

	construct {
		this.namespaces = new Gee.ArrayList<Namespace> ();
		this.methods = new Gee.ArrayList<Method> ();
		this.structs = new Gee.ArrayList<Struct>();
		this.classes = new Gee.ArrayList<Class>();
		this.fields = new Gee.ArrayList<Field> ();
		this.bracket_level = 0;
	}

	private inline Basic? search_namespace ( string[] params, int pos ) {
		foreach ( Namespace ns in this.namespaces ) {
			Basic element = ns.search_in_upper_namespace ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	private inline Basic? search_interface ( string[] params, int pos ) {
		foreach ( Interface iface in this.interfaces ) {
			Basic element = iface.search_in_upper_namespace ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	private inline Basic? search_enum ( string[] params, int pos ) {
		foreach ( Enum en in this.enums ) {
			Basic element = en.search_in_upper_namespace ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	private inline Basic? search_error_domain ( string[] params, int pos ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			Basic element = errdom.search_in_upper_namespace ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	protected inline Basic? search_delegate ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Delegate del in this.delegates ) {
			if ( del.name == params[pos] )
				return del;
		}
		return null;
	}

	public override Basic? search_in_upper_namespace ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos+1] == null )
			return this;


		Basic element = this.search_namespace ( params, pos );
		if ( element != null )
			return element;

		element = this.search_class ( params, pos );
		if ( element != null )
			return element;

		element = this.search_interface ( params, pos );
		if ( element != null )
			return element;

		element = this.search_struct ( params, pos );
		if ( element != null )
			return element;

		element = this.search_enum ( params, pos );
		if ( element != null )
			return element;

		element = this.search_error_domain ( params, pos );
		if ( element != null )
			return element;

		element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_field ( params, pos );
		if ( element != null )
			return element;

		element = this.search_delegate ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	public void create_images ( ) {
		this.create_namespace_images ( );

		var drawer = new Drawer.Drawer ( );
		drawer.interface_arrow_len = 20;
		drawer.class_arrow_len = 20;
		drawer.block_height = 30;
		drawer.block_width = 120;

		foreach ( Class cl in this.classes ) {
			var climg = cl.get_image ( );
			drawer.draw_class ( climg, cl.name + ".png" );
		}
	}

	public Gee.Collection<Delegate> get_delegate_list ( ) {
		var lst = new Gee.ArrayList<Delegate> ();
		foreach ( Delegate del in this.delegates ) {
			if ( !del.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( del );
		}

		return new Gee.ReadOnlyCollection<Delegate>( lst );
	}

	public uint bracket_level {
		construct set;
		get;
	}

	public string# path {
		get {
			return this.name;
		}
	}

	protected Gee.ArrayList<Field> fields {
		set;
		get;
	}

	protected Gee.ArrayList<Method> methods {
		set;
		get;
	}

	public File file {
		get {
			return (File)this.parent;
		}
	}

	public Interface find_interface ( Vala.Interface viface ) {
		foreach ( Interface iface in this.interfaces ) {
			if ( iface.is_vinterface( viface ) )
				return iface;
		}

		return null;
	}

	public Delegate find_delegate ( Vala.Delegate vdel ) {
		foreach ( Delegate del in this.delegates ) {
			if ( del.is_vdelegate( vdel ) )
				return del;
		}

		return null;
	}

	public Struct find_struct ( Vala.Struct vstruct ) {
		foreach ( Struct stru in this.structs ) {
			if ( stru.is_vstruct( vstruct ) )
				return stru;
		}

		return null;
	}

	public Class find_class ( Vala.Class vclass ) {
		foreach ( Class cl in this.classes ) {
			if ( cl.is_vclass( vclass ) )
				return cl;
		}

		return null;
	}

	public Enum find_enum ( Vala.Enum venum ) {
		foreach ( Enum en in this.enums ) {
			 if ( en.is_venum( venum ) )
			 	return en;
		}

		return null;
	}

	public Namespace ( Valadoc.Settings settings,
										Vala.Namespace vnspace,
										NamespaceHandler parent,
										Tree head,
										ErrorReporter err ) {
		this.settings = settings;
		this.vnspace = vnspace;
		this.parent = parent;
		this.head = head;
		this.err = err;
	}

	public void visit_delegates ( Doclet doclet ) {
		foreach ( Delegate del in this.delegates ) {
			del.visit ( doclet );
		}
	}

	public void visit_enums ( Doclet doclet ) {
		foreach ( Enum en in this.enums ) {
			en.visit( doclet );
		}
	}

	public void visit_error_domains ( Doclet doclet ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			errdom.visit ( doclet );
		}
	}

	// Whats about the interface-handler?
	public void visit_interfaces ( Doclet doclet ) {
		foreach ( Interface iface in this.interfaces ) {
			iface.visit( doclet );
		}
	}

	public void visit ( Doclet doclet ) {
		doclet.visit_namespace ( this );
	}

	public Vala.Namespace vnspace {
		construct set;
		protected get;
	}

	public override string# name {
		get {
			return this.vnspace.name;
		}
	}

	public void append_interface ( Vala.Interface viface ) {
		var tmp = new Interface ( this.settings, viface, this, this.head, this.err );
		tmp.initialisation ( );
		this.interfaces.add ( tmp );
	}

	private Valadoc.Class create_subclasses ( Vala.Class vcl, Basic parent,
									Gee.HashMap<Vala.Class, Gee.ArrayList<Vala.Class> > sub_classes,
									Gee.HashMap<Vala.Class, Gee.ArrayList<Vala.Struct> > sub_structs,
									uint rank )
	{
		var cl = new Class ( this.settings, vcl, parent, this.head, this.err, rank++ );
		cl.initialisation( );

		foreach ( Vala.Struct vsubstruct in sub_structs.get( vcl ) ) {
			var substru = new Struct ( this.settings, vsubstruct, cl, this.head, this.err, rank );
			substru.initialisation( );
			cl.append_struct ( substru );
		}

		foreach ( Vala.Class vsubcl in sub_classes.get ( vcl ) ) {
			var subcl = this.create_subclasses ( vsubcl, cl,sub_classes, sub_structs, rank );
			cl.append_class ( subcl );
		}
		return cl;
	}

	public void append_global_class ( Vala.Class vclass, Gee.HashMap<Vala.Class, Gee.ArrayList<Vala.Class> > vsubclasses,
														 Gee.HashMap<Vala.Class, Gee.ArrayList<Vala.Class> > vsubstructs )
	{
		var tmp = this.create_subclasses ( vclass, this, vsubclasses, vsubstructs, 0 );
		this.append_class ( tmp );
	}

	public void append_global_struct ( Vala.Struct vstruct ) {
		var tmp = new Struct ( this.settings, vstruct, this, this.head, this.err, 0 );
		tmp.initialisation ( );
		this.append_struct ( tmp );
	}

	public void append_enum ( Vala.Enum venum ) {
		var tmp = new Enum ( this.settings, venum, this, this.head, this.err );
		tmp.initialisation ( );
		this.enums.add( tmp );
	}

	public void append_error_domain ( Vala.ErrorDomain verrdom ) {
		var tmp = new ErrorDomain ( this.settings, verrdom, this, this.head, this.err );
		tmp.initialisation ( );
		this.errdoms.add ( tmp );
	}

	public void append_global_method ( Vala.Method vm ) {
		var tmp = new Method ( this.settings, vm, this, this.head, this.err, 0 );
		tmp.initialisation ( );
		this.methods.add ( tmp );
	}

	public void append_global_field ( Vala.Field vf ) {
		var tmp = new Field ( this.settings, vf, this, this.head, this.err, 0 );
		tmp.initialisation ( );
		this.fields.add( tmp );
	}

	public void append_delegate ( Vala.Delegate vdel ) {
		var tmp = new Delegate ( this.settings, vdel, this, this.head, this.err, 0 );
		tmp.initialisation ( );
		this.delegates.add ( tmp );
	}

	// use interface-functions
	public void set_type_references ( ) {
		this.set_namespace_type_references ( );
		this.set_method_type_references ( );
		this.set_field_type_references ( );
		this.set_struct_references ( );
		this.set_class_references ( );

		foreach ( Interface iface in this.interfaces ) {
			iface.set_type_references ( );
		}

		foreach ( Delegate del in this.delegates ) {
			del.set_type_references ( );
		}

		foreach ( Enum en in this.enums ) {
			en.set_type_references ( );
		}

		foreach ( ErrorDomain errdom in this.errdoms ) {
			errdom.set_type_references ( );
		}
	}

	public void inheritance ( ) {
		this.namespace_inheritance ( );

		foreach ( Class cl in this.classes ) {
			cl.inheritance ( );
		}
	}

	public void parse_comments ( ) {
		this.parse_field_comments ( );
		this.parse_class_comments ( );
		this.parse_method_comments ( );
		this.parse_struct_comments ( );
		this.parse_namespace_comments ( );

		foreach ( Interface iface in this.interfaces ) {
			iface.parse_comments ( );
		}

		foreach ( Delegate del in this.delegates ) {
			del.parse_comments ( );
		}

		foreach ( ErrorDomain errdom in this.errdoms ) {
			errdom.parse_comments ( );
		}

		foreach ( Enum en in this.enums ) {
			en.parse_comments ( );
		}
	}

	public bool is_vnspace ( Vala.Namespace vns ) {
		return ( this.vnspace == vns )? true : false ;
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_namespace ( this, ptr );
	}
}


public class Valadoc.File : Basic, NamespaceHandler, Visitable {
	public Gee.ArrayList<Namespace> namespaces {
		get;
		private set;
		default = new Gee.ArrayList<Namespace>();
	}

	public File ( Valadoc.Settings settings,
								Vala.SourceFile vfile,
								Tree head,
								ErrorReporter err ) {
		this.settings = settings;
		this.vfile = vfile;
		this.head = head;
		this.err = err;
	}

	public string name {
		get {
			return this.vfile.filename;
		}
	}

	public Vala.SourceFile vfile {
		construct set;
		protected get;
	}

	public override Basic? search_in_upper_namespace ( string[] params, int pos ) {
		foreach ( Namespace ns in this.namespaces ) {
			Basic element = ns.search_in_upper_namespace( params, pos );
			if ( element != null )
				return element;
		}
		return null;
	}

	public bool is_file ( Vala.SourceFile vfile ) {
		return ( vfile == this.vfile )? true : false;
	}

	public void visit ( Doclet doclet ) {
		if ( !settings.to_doc ( this.name ) )
			return ;

		doclet.visit_file ( this );
	}

	public void append_interface ( Vala.Interface viface ) {
		var ns = this.get_namespace ( viface );
		ns.append_interface ( viface );
	}

	public void append_class ( Vala.Class vclass,
														 Gee.HashMap< Gee.Collection<Vala.Class> > vsubclasses,
														 Gee.HashMap< Gee.Collection<Vala.Struct> > vsubstructs ) {
		var ns = this.get_namespace ( vclass );
		ns.append_global_class ( vclass, vsubclasses, vsubstructs );
	}

	public void append_struct ( Vala.Struct vstruct ) {
		var ns = this.get_namespace ( vstruct );
		ns.append_global_struct ( vstruct );
	}

	public void append_enum ( Vala.Enum venum ) {
		var ns = this.get_namespace ( venum );
		ns.append_enum ( venum );
	}

	public void append_error_domain ( Vala.ErrorDomain verrdom ) {
		var ns = this.get_namespace ( verrdom );
		ns.append_error_domain ( verrdom );
	}

	public void append_global_method ( Vala.Method vm ){
		var ns = this.get_namespace ( vm );
		ns.append_global_method ( vm );
	}

	public void append_global_field ( Vala.Field vf ) {
		var ns = this.get_namespace ( vf );
		ns.append_global_field( vf );
	}

	public void append_delegate ( Vala.Delegate vdel ) {
		var ns = this.get_namespace ( vdel );
		ns.append_delegate ( vdel );
	}

	public void inheritance ( ) {
		this.namespace_inheritance ( );
	}

	public void parse_comments ( ) {
		this.parse_namespace_comments ( );
	}

	public void create_images ( ) {
		this.create_namespace_images ( );
	}

	public void set_type_references ( ) {
		this.set_namespace_type_references ( );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_file ( this, ptr );
	}
}



public class Valadoc.Tree : Vala.CodeVisitor {
	private uint level = 0;
	private Gee.ArrayList<File> files = new Gee.ArrayList<File>();

	private Vala.Typesymbol current_type = null;

	private Gee.HashMap<Vala.Class, Gee.ArrayList<Vala.Class> > sub_classes
		= new Gee.HashMap<Vala.Class, Gee.ArrayList<Vala.Class> > ();

	private Gee.HashMap<Vala.Class, Gee.ArrayList<Vala.Struct> > sub_structs
		= new Gee.HashMap<Vala.Class, Gee.ArrayList<Vala.Struct> > ();


	public Valadoc.Settings settings {
		construct set;
		get;
	}

	public Tree ( Valadoc.Settings settings,
							  Vala.CodeContext context,
							  ErrorReporter err ) {
		this.settings = settings;
		this.context = context;
		this.err = err;
	}

	public CodeContext context {
		construct set;
		get;
	}

	public ErrorReporter err {
		construct set;
		get;
	}

	public void visit ( Doclet doclet ) {
		foreach ( File file in this.files ) {
			file.visit ( doclet );
		}
	}


	private string[] expand_param_field ( string[] params, string str, int params_offset = 0 ) {
		string[] field = str.split( ".", -1 );

		int field_length; for ( field_length=0; field[field_length] != null ; field_length++ );
		int params_length; for ( params_length=0; params[params_length] != null ; params_length++ );

		string[] ret = new string[ field_length + params_length + 1 ];

		int i;
		for ( i = 0; field[i] != null; i++ ) {
			ret[i] = field[i];
		}

		for ( int ii = params_offset; params[ii] != null; ii++, i++ ) {
			ret[i] = params[ii];
		}

		return ret;
	}

	private Basic? search_symbol_in_namespace ( Basic element, string[] params ) {
		return this.search_symbol_in_symbol ( element.nspace, params );
	}

	private Basic? search_symbol_in_type ( Basic element, string[] params, int params_offset = 0 ) {
		if ( !( element.parent is ContainerDataType || element.parent is Enum || element.parent is ErrorDomain ) )
			return null;

		return this.search_symbol_in_symbol ( element.parent, params, params_offset );
	}

	private Basic? search_symbol_in_symbol ( Basic element, string[] params, int params_offset = 0 ) {
		Basic el = element;
		string str = null;
		while ( el.parent != null ) {
			if ( el != element )
				str = el.name + "." + str;
			else
				str = el.name;

			el = el.parent;
		}

		if ( str == null )
			return null;

		var fullparams = this.expand_param_field ( params, str, params_offset );
		return this.search_symbol_in_namespaces ( element, fullparams );
	}

	private Basic? search_symbol_in_global_namespaces ( Basic element, string[] params ) {
		int param_size = 0;
		for ( param_size = 0; params[param_size] != null; param_size++ );

		string[] global_params = new string [ param_size +1];

		global_params[0] = null;
		for ( int i = 0; params[i-1] != null ; i++ ) {
			global_params[i+1] = params[i];
		}

		foreach ( File f in this.files ) {
			Basic element = f.search_in_upper_namespace ( global_params, 0 );
			if ( element != null )
				return element;
		}
		return null;
	}

	private Basic? search_symbol_in_namespaces ( Basic element, string[] params ) {
		foreach ( File f in this.files ) {
			Basic element = f.search_in_upper_namespace ( params, 0 );
			if ( element != null )
				return element;
		}
		return null;
	}

	/**
	 * Looks for the element adressed by params in the tree.
	 *
	 * @param params a null terminated string of names of element in the trees.
	 * 							 ( { "glib", "String", "append", null } for example )
	 * @return The element or null if it is not available.
	 */
	private Basic? search_in_upper_namespace ( Basic element, string[] params ) {
		if ( params[0] == "this" ) {
			return search_symbol_in_type ( element, params, 1 );
		}

		// Global Namespace:
		var tmp = search_symbol_in_global_namespaces ( element, params );
		if ( tmp != null )
			return tmp;

		// In the other Namespaces:
		tmp = this.search_symbol_in_namespaces ( element, params );
		if ( tmp != null )
			return tmp;

		// In the same namespace as element:
		tmp = this.search_symbol_in_namespace ( element, params );
		if ( tmp != null )
			return tmp;

		// In the same datatype:
		tmp = search_symbol_in_type ( element, params );
		if ( tmp != null )
			return tmp;

		return null;
	}

	public Basic? search_symbol_str ( Valadoc.Basic element, string symname ) {
		string[] params = symname.split( ".", -1 );
		return this.search_in_upper_namespace ( element, params );
	}

	public override void visit_namespace ( Vala.Namespace vns ) {
		vns.accept_children ( this );
	}

	public override void visit_field ( Vala.Field vf ) {
		if ( this.level > 0 )
			return ;

		Vala.SourceReference vsrcref = vf.source_reference;
		Vala.SourceFile vsrc = vsrcref.file;

		File file = get_file ( vsrc );
		file.append_global_field ( vf );
	}

	public override void visit_method ( Vala.Method vm ) {
		if ( this.level > 0 )
			return ;

		Vala.SourceReference vsrcref = vm.source_reference;
		Vala.SourceFile vsrc = vsrcref.file;

		File file = get_file ( vsrc );
		file.append_global_method ( vm );
	}

	public override void visit_struct ( Vala.Struct vstruct ) {
		this.level++;

		if ( this.level == 1 ) {
			Vala.SourceReference vsrcref = vstruct.source_reference;
			Vala.SourceFile vsrc = vsrcref.file;

			File file = get_file ( vsrc );
			file.append_struct ( vstruct );
		}
		else {
			Gee.ArrayList<Vala.Class> vstrulist = this.sub_structs.get ( this.current_type );
			vstrulist.add ( vstruct );
		}

		this.level--;
	}

	public override void visit_interface ( Vala.Interface viface ) {
		Vala.SourceReference vsrcref = viface.source_reference;
		Vala.SourceFile vsrc = vsrcref.file;

		File file = get_file ( vsrc );
		file.append_interface ( viface );
	}


	public override void visit_class ( Vala.Class vcl ) {
		Vala.Typesymbol parent_type = this.current_type;
		this.current_type = vcl;
		this.level++;

		var vcllist = new Gee.ArrayList<Vala.Class> ();
		this.sub_classes.set ( vcl, vcllist );

		var vstrulist = new Gee.ArrayList<Vala.Class> ();
		this.sub_structs.set ( vcl, vstrulist );

		vcl.accept_children ( this );

		if ( this.level == 1 ) {
			Vala.SourceReference vsrcref = vcl.source_reference;
			Vala.SourceFile vsrc = vsrcref.file;

			File file = get_file ( vsrc );
			file.append_class ( vcl, this.sub_classes, this.sub_structs );
			this.sub_classes.clear ();
			this.sub_structs.clear ();
		}
		else {
			Gee.ArrayList<Vala.Class> vcllist = this.sub_classes.get ( parent_type );
			vcllist.add ( vcl );
		}

		this.current_type = parent_type;
		this.level--;
	}

	public override void visit_delegate ( Vala.Delegate vdel ) {
		Vala.SourceReference vsrcref = vdel.source_reference;
		Vala.SourceFile vsrc = vsrcref.file;

		File file = get_file ( vsrc );
		file.append_delegate ( vdel );
	}

	public override void visit_error_domain ( Vala.ErrorDomain verrdom ) {
		Vala.SourceReference vsrcref = verrdom.source_reference;
		Vala.SourceFile vsrc = vsrcref.file;
		File file = get_file ( vsrc );

		file.append_error_domain ( verrdom );
	}

	public override void visit_enum ( Vala.Enum ven ) {
		Vala.SourceReference vsrcref = ven.source_reference;
		Vala.SourceFile vsrc = vsrcref.file;
		File file = get_file ( vsrc );

		file.append_enum ( ven );
	}

	private void create_images ( ) {
		foreach ( File f in this.files ) {
			f.create_images ( );
		}
	}

	public void create ( ) {
		this.context.accept( this );
		this.set_type_references ( );
		this.inheritance ( );
		this.parse_comments ( );
		this.create_images ( );
	}

	public File find_file ( Vala.SourceFile vfile ) {
		foreach ( File f in this.files ) {
			if ( f.is_file( vfile ) )
				return f;
		}
		return null;
	}

	private void set_type_references ( ) {
		foreach ( File f in this.files ) {
			f.set_type_references( );
		}
	}

	public void inheritance ( ) {
		foreach ( File f in this.files ) {
			f.inheritance( );
		}
	}

	private void parse_comments ( ) {
		foreach ( File f in this.files ) {
			f.parse_comments( );
		}
	}

	public File get_file ( Vala.SourceFile vfile ) {
		File file = this.find_file( vfile );
		if ( file != null )
			return file;

		var tmp = new File ( this.settings,vfile, this, this.err ); 
		this.files.add ( tmp );
		return tmp;
	}
}


