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


using Vala;
using GLib;
using Gee;


// private
public Valadoc.Class glib_error = null;



public abstract class Valadoc.Basic : Object {
	public Valadoc.Settings settings {
		construct set;
		protected get;
	}

	public Basic parent {
		construct set;
		get;
	}

	public Tree head {
		construct set;
		get;
	}

	//TODO: Vala.CodeNode => PropertySetter
	protected Vala.Symbol vsymbol {
		protected get;
		set;
	}
}

public class Valadoc.Array : Basic {
	private Vala.ArrayType vtype;

	public Basic data_type {
		private set;
		get;
	}

	public Array ( Valadoc.Settings settings, Vala.ArrayType vtyperef, Basic parent, Tree head ) {
		this.settings = settings;
		this.vtype = vtyperef;
		this.parent = parent;
		this.head = head;

		Vala.DataType vntype = vtyperef.element_type;
		if ( vntype is Vala.ArrayType )
			this.data_type = new Array ( settings, (Vala.ArrayType)vntype, this, head );
		else
			this.data_type = new TypeReference ( settings, vntype, this, head );
	}

	public void write ( Langlet langlet, void* ptr, DocumentedElement parent ) {
		langlet.write_array ( this, ptr, parent);
	}

	public void set_type_references () {
		if ( this.data_type == null )
			/*TODO:possible?*/;
		else if ( this.data_type is Array )
			((Array)this.data_type).set_type_references ();
		else if ( this.data_type is Pointer )
			((Pointer)this.data_type).set_type_references ();
		else
			((TypeReference)this.data_type).set_type_references ();
	}
}

public class Valadoc.Pointer : Basic {
	private Vala.PointerType vtype;

	public Basic data_type {
		private set;
		get;
	}

	public Pointer ( Valadoc.Settings settings, Vala.PointerType vtyperef, Basic parent, Tree head ) {
		this.settings = settings;
		this.vtype = vtyperef;
		this.parent = parent;
		this.head = head;

		Vala.DataType vntype = vtype.base_type;
		if ( vntype is Vala.PointerType )
			this.data_type = new Pointer ( settings, (Vala.PointerType)vntype, this, head );
		else if ( vntype is Vala.ArrayType )
			this.data_type = new Array ( settings, (Vala.ArrayType)vntype, this, head );
		else
			this.data_type = new TypeReference ( settings, vntype, this, head );
	}

	public void write ( Langlet langlet, void* ptr, DocumentedElement parent ) {
		langlet.write_pointer ( this, ptr, parent );
	}

	public void set_type_references () {
		Basic type = this.data_type;
		if ( type == null )
			;
		else if ( type is Array )
			((Array)type).set_type_references ();
		else if ( type is Pointer )
			((Pointer)type ).set_type_references ();
		else
			((TypeReference)type).set_type_references ();
	}
}


public abstract class Valadoc.DocumentedElement : Basic, Documented {
	private Namespace? _nspace = null;
	private Package? _package = null;
	private string _full_name = null;
	private int _line = -1;

	public Namespace? nspace {
		get {
			if ( this._nspace == null ) {
				Valadoc.Basic ast = this;
				while ( ast is Valadoc.Namespace == false ) {
					ast = ast.parent;
					if ( ast == null )
						return null;
				}
				this._nspace = (Valadoc.Namespace)ast;
			}
			return this._nspace;
		}
	}


	public Package? package {
		get {
			if ( this._package == null ) {
				Valadoc.Basic ast = this;
				while ( ast is Valadoc.Package == false ) {
					ast = ast.parent;
					if ( ast == null )
						return null;
				}
				this._package = (Valadoc.Package)ast;
			}
			return this._package;
		}
	}

	public int line {
		get {
			if ( this._line == -1 ) {
				Vala.SourceReference vsref = this.vsymbol.source_reference;
				this._line = ( vsref == null )? 0 : vsref.first_line;
			}
			return this._line;
		}
	}

	protected string? comment_string  {
		get {
			SourceReference sref = this.vsymbol.source_reference;
			if ( sref == null )
				return null;

			return sref.comment;
		}
	}

	public DocumentationTree? documentation {
		protected set;
		get;
	}

	public virtual string? name {
		owned get {
			return this.vsymbol.name;
		}
	}

	// rename to get_full_name, weak
	public string? full_name () {
		if ( this._full_name == null ) {
			if ( this.name == null )
				return null;

			GLib.StringBuilder full_name = new GLib.StringBuilder ( this.name );

			if ( this.parent != null ) {
				for ( Basic pos = this.parent; pos is Package == false ; pos = pos.parent ) {
					string name = ((DocumentedElement)pos).name;
					if ( name != null ) {
						full_name.prepend_unichar ( '.' );
						full_name.prepend ( name );
					}
				}
			}
			this._full_name = full_name.str;
		}
		return this._full_name;
	}

	public string? get_filename () {
		SourceReference? sref = this.vsymbol.source_reference;
		if ( sref == null )
			return null;

		Vala.SourceFile? file = sref.file;
		if ( file == null )
			return null;

		string path = sref.file.filename;
		return GLib.Path.get_basename ( path );
	}
/*
	// rename to file_name
	public string? filename {
		owned get {
			SourceReference? sref = this.vsymbol.source_reference;
			if ( sref == null )
				return null;

			Vala.SourceFile? file = sref.file;
			if ( file == null )
				return null;

			string path = sref.file.filename;
			return GLib.Path.get_basename ( path );
		}
	}
*/
	protected void parse_comment_helper ( Valadoc.Parser docparser ) {
		this.documentation = docparser.parse ( this );
	}

	// internal
	public virtual DocumentedElement? search_element ( string[] params, int pos ) {
		return null;
	}

	// internal
	public virtual DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> list, int pos ) {
		return null;
	}
}

// remove
public interface Valadoc.Inheritable : Valadoc.DocumentedElement {
	protected abstract Inheritable? base_type {
		set;
		get;
	}

	public abstract Gee.Collection<Interface> get_implemented_interface_list ( );
}


public interface Valadoc.EnumHandler : Basic {
	protected abstract Gee.ArrayList<Enum> enums {
		set;
		get;
	}

	protected void set_enum_type_references ( ) {
		foreach ( Enum en in this.enums ) {
			en.set_type_references ( );
		}
	}

	protected DocumentedElement? search_enum_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		foreach ( Enum en in this.enums ) {
			DocumentedElement element = en.search_element_vala ( params, pos+1 );
			if ( element != null )
				return element;			
		}
		return null;
	}

	protected DocumentedElement? search_enum ( string[] params, int pos ) {
		foreach ( Enum en in this.enums ) {
			DocumentedElement element = en.search_element ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	public Gee.Collection<Enum> get_enum_list ( ) {
		var lst = new Gee.ArrayList<Enum> ();
		foreach ( Enum en in this.enums ) {
			if ( !en.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( en );
		}

		return new Gee.ReadOnlyCollection<Enum>( lst );
	}

	public void visit_enums ( Doclet doclet ) {
		foreach ( Enum en in this.enums ) {
			en.visit( doclet );
		}
	}

	public void add_enums ( Gee.Collection<Vala.Enum> venums ) {
		foreach ( Vala.Enum venum in venums ) {
			this.add_enum ( venum );
		}
	}

	public void add_enum ( Vala.Enum venum ) {
		Enum tmp = new Enum ( this.settings, venum, this, this.head );
		this.enums.add( tmp );
	}

	protected void parse_enum_comments ( Valadoc.Parser docparser ) {
		foreach ( Enum en in this.enums ) {
			en.parse_comments ( docparser );
		}
	}
}

public interface Valadoc.DelegateHandler : Basic {
	protected abstract Gee.ArrayList<Delegate> delegates {
		set;
		get;
	}

	protected DocumentedElement? search_delegate_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Delegate == false )
			return null;

		foreach ( Delegate del in this.delegates ) {
			if ( del.is_vdelegate ( (Vala.Delegate)velement ) ) {
				return del;
			}
		}
		return null;
	}

	protected DocumentedElement? search_delegate ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Delegate del in this.delegates ) {
			if ( del.name == params[pos] )
				return del;
		}
		return null;
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

	public void visit_delegates ( Doclet doclet ) {
		foreach ( Delegate del in this.delegates ) {
			del.visit ( doclet );
		}
	}

	public void add_delegates ( Gee.Collection<Vala.Delegate> vdels ) {
		foreach ( Vala.Delegate vdel in vdels ) {
			this.add_delegate ( vdel );
		}
	}

	public void add_delegate ( Vala.Delegate vdel ) {
		var tmp = new Delegate ( this.settings, vdel, this, this.head );
		this.delegates.add ( tmp );
	}

	public void set_delegate_type_references ( ) {
		foreach ( Delegate del in this.delegates ) {
			del.set_type_references ( );
		}
	}

	public void parse_delegate_comments ( Valadoc.Parser docparser ) {
		foreach ( Delegate del in this.delegates ) {
			del.parse_comment ( docparser );
		}
	}
}

public interface Valadoc.InterfaceHandler : Basic {
	protected abstract Gee.ArrayList<Interface> interfaces {
		set;
		get;
	}

	protected DocumentedElement? search_interface_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		foreach ( Interface iface in this.interfaces ) {
			DocumentedElement? element = iface.search_element_vala ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	protected DocumentedElement? search_interface ( string[] params, int pos ) {
		foreach ( Interface iface in this.interfaces ) {
			DocumentedElement? element = iface.search_element ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	public Gee.Collection<Interface> get_interface_list ( ) {
		var lst = new Gee.ArrayList<Interface> ();
		foreach ( Interface iface in this.interfaces ) {
			if ( !iface.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( iface );
		}

		return new Gee.ReadOnlyCollection<Interface>( lst );
	}

	public void visit_interfaces ( Doclet doclet ) {
		foreach ( Interface iface in this.interfaces ) {
			iface.visit( doclet );
		}
	}

	protected void add_interfaces ( Gee.Collection<Vala.Interface> vifaces ) {
		foreach ( Vala.Interface viface in vifaces ) {
			this.add_interface ( viface );
		}
	}

	// internal
	public void add_interface ( Vala.Interface viface ) {
		var tmp = new Interface ( this.settings, viface, this, this.head );
		this.interfaces.add ( tmp );
	}

	protected void set_interface_type_references ( ) {
		foreach ( Interface iface in this.interfaces ) {
			iface.set_type_references ( );
		}
	}

	protected void parse_interface_comments ( Valadoc.Parser docparser ) {
		foreach ( Interface iface in this.interfaces ) {
			iface.parse_comments ( docparser );
		}
	}
}



public interface Valadoc.ErrorDomainHandler : Basic {
	protected abstract Gee.ArrayList<ErrorDomain> errdoms {
		set;
		get;
	}

	protected DocumentedElement? search_error_domain_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			DocumentedElement? element = errdom.search_element_vala ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	protected DocumentedElement? search_error_domain ( string[] params, int pos ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			DocumentedElement? element = errdom.search_element ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	public Gee.Collection<ErrorDomain> get_error_domain_list ( ) {
		var lst = new Gee.ArrayList<ErrorDomain> ();
		foreach ( ErrorDomain errdom in this.errdoms ) {
			if ( !errdom.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( errdom );
		}

		return new Gee.ReadOnlyCollection<ErrorDomain>( lst );
	}

	// internal
	public ErrorDomain? find_errordomain ( Vala.ErrorDomain ver ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			if ( errdom.is_verrordomain( ver ) )
				return errdom;
		}
		return null;
	}

	public void visit_error_domains ( Doclet doclet ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			errdom.visit ( doclet );
		}
	}

	public void add_error_domains ( Gee.Collection<Vala.ErrorDomain> verrdoms ) {
		foreach ( Vala.ErrorDomain verrdom in  verrdoms ) {
			this.add_error_domain ( verrdom );
		}
	}

	public void add_error_domain ( Vala.ErrorDomain verrdom ) {
		var tmp = new ErrorDomain ( this.settings, verrdom, this, this.head );
		this.errdoms.add ( tmp );
	}

	protected void set_errordomain_type_referenes ( ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			errdom.set_type_references ( );
		}
	}

	protected void parse_errordomain_comments ( Valadoc.Parser docparser ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			errdom.parse_comments ( docparser );
		}
	}
}

// rename
public interface Valadoc.Writeable : Basic {
	public abstract DocumentationTree? documentation {
		protected set;
		get;
	}
}

public interface Valadoc.NamespaceHandler : Basic {
	public abstract Gee.ArrayList<Namespace> namespaces {
		set;
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

	// internal
	public Namespace get_namespace_helper ( Vala.Symbol node, Gee.List<Vala.Namespace> vnspaces, int pos ) {
		Vala.Namespace vns = vnspaces.get( pos );

		Namespace ns = this.find_namespace_without_childs ( vns );
		if ( ns == null ) {
			ns = new Namespace( this.settings, vns, this, this.head );
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
			var ns = new Namespace( this.settings, vnspace, this, this.head );
			this.namespaces.add( ns );
			return ns;
		}
	}

	// internal
	public Namespace? find_vnamespace_helper ( Gee.List<Vala.Namespace> vnspaces, int pos ) {
		Vala.Namespace? vns = vnspaces.get ( pos );
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

	// internal?
	private Namespace find_namespace_without_childs ( Vala.Namespace vns ) {
		Namespace ns2 = null;

		foreach ( Namespace ns in this.namespaces ) {
			if ( ns.is_vnspace(vns) )
				ns2 = ns;
		}

		return ns2;
	}

	// internal
	public Namespace find_namespace ( Vala.Namespace vns ) {
		var vnspaces = this.create_parent_vnamespace_list ( vns );

		return this.find_vnamespace_helper ( vnspaces, vnspaces.index_of( vns ) );
	}

	// internal
	public void set_namespace_type_references ( ) {
		foreach ( Namespace ns in this.namespaces ){
			ns.set_type_references ();
		}
	}

	// internal
	public void namespace_inheritance ( ) {
		foreach ( Namespace ns in this.namespaces ){
			ns.inheritance( );
		}
	}

	// internal
	public void parse_namespace_comments ( Valadoc.Parser docparser ) {
		foreach ( Namespace ns in this.namespaces ){
			ns.parse_comments ( docparser );
		}
	}
}



public interface Valadoc.ClassHandler : Basic {
	protected abstract Gee.ArrayList<Class> classes {
		set;
		get;
	}

	protected DocumentedElement? search_class_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		foreach ( Class cl in this.classes ) {
			DocumentedElement? element = cl.search_element_vala ( params, pos+1 );
			if ( element != null )
				return element;			
		}
		return null;
	}

	protected DocumentedElement? search_class ( string[] params, int pos ) {
		foreach ( Class cl in this.classes ) {
			DocumentedElement? element = cl.search_element ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	protected Class? find_vclass ( Vala.Class vcl ) {
		foreach ( Class cl in this.classes ) {
			if ( cl.is_vclass ( vcl ) )
				return cl;

			var tmp = cl.find_vclass ( vcl );
			if ( tmp != null )
				return tmp;
		}
		return null;
	}

	public Gee.ReadOnlyCollection<Class> get_class_list ( ) {
		var lst = new Gee.ArrayList<Class> ();
		foreach ( Class cl in this.classes ) {
			if ( !cl.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( cl );
		}

		return new Gee.ReadOnlyCollection<Class>( lst );
	}

	// internal
	public void add_class ( Vala.Class vcl ) {
		Class cl = new Class ( this.settings, vcl, this, this.head );
		this.classes.add ( cl );
	}

	public void add_classes ( Gee.Collection<Vala.Class> vclasses ) {
		foreach ( Vala.Class vcl in vclasses ) {
			this.add_class ( vcl );
		}
	}


	public void visit_classes ( Doclet doclet ) {
		foreach ( Class cl in this.get_class_list() ) {
			cl.visit ( doclet );
		}
	}

	protected void set_class_type_references ( ) {
		foreach ( Class cl in this.classes ) {
			cl.set_type_references ();
		}
	}

	protected void parse_class_comments ( Valadoc.Parser docparser ) {
		foreach ( Class cl in this.classes ) {
			cl.parse_comments ( docparser );
		}
	}
}



public interface Valadoc.PropertyHandler : Basic {
	protected abstract Gee.ArrayList<Property> properties {
		get;
		set;
	}

	protected DocumentedElement? search_property_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Property == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( Property prop in this.properties ) {
			if ( prop.is_vproperty ( (Vala.Property)velement ) ) {
				return prop;
			}
		}
		return null;
	}

	protected DocumentedElement? search_property ( string[] params, int pos ) {
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

	public Gee.ReadOnlyCollection<Property> get_property_list ( ) {
		var lst = new Gee.ArrayList<Property> ();
		foreach ( Property p in this.properties ) {
			if ( !p.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( p );
		}

		return new Gee.ReadOnlyCollection<Property>( lst );
	}

	protected void parse_property_comments ( Valadoc.Parser docparser ) {
		foreach ( Property prop in this.properties ) {
			prop.parse_comment ( docparser );
		}
	}

	public void visit_properties ( Doclet doclet ) {
		foreach ( Property prop in this.get_property_list () )
			prop.visit ( doclet );
	}

	// rename to set_property_type_references
	protected void set_property_type_reference () {
		foreach ( Property prop in this.properties ) {
			prop.set_type_references ( );
		}
	}

	protected void add_properties ( Gee.Collection<Vala.Property> vproperties ) {
		foreach ( Vala.Property vprop in vproperties ) {
			var tmp = new Property ( this.settings, vprop, this, this.head );
			this.properties.add ( tmp );
		}
	}
}


public interface Valadoc.ConstructionMethodHandler : Basic, MethodHandler {
	protected abstract Gee.ArrayList<Method> construction_methods {
		set;
		get;
	}

	protected DocumentedElement? search_construction_method_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Method == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( Method m in this.methods ) {
			if ( m.is_vmethod ( (Vala.Method)velement ) ) {
				return m;
			}
		}
		return null;
	}

	protected DocumentedElement? search_construction_method ( string[] params, int pos ) {
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

	public Gee.ReadOnlyCollection<Method> get_construction_method_list ( ) {
		var lst = new Gee.ArrayList<Method> ();
		foreach ( Method cm in this.construction_methods ) {
			if ( !cm.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( cm );
		}

		return new Gee.ReadOnlyCollection<Method>( lst );
	}

	protected void parse_construction_method_comments ( Valadoc.Parser docparser ) {
		foreach ( Method cm in this.construction_methods ) {
			cm.parse_comment ( docparser );
		}
	}

	protected void set_construction_method_references ( ) {
		foreach ( Method cm in this.construction_methods ) {
			cm.set_type_references ( );
		}
	}

	public void visit_construction_methods ( Doclet doclet ) {
		foreach ( Method m in this.get_construction_method_list() ) {
			m.visit ( doclet, this );
		}
	}

	protected void add_construction_method ( Vala.CreationMethod vm ) {
		var tmp = new Method ( this.settings, vm, this, this.head );
		this.construction_methods.add ( tmp );
	}

	protected void add_methods_and_construction_methods ( Gee.Collection<Vala.Method> vmethods ) {
		foreach ( Vala.Method vm in vmethods ) {
			if ( vm is Vala.CreationMethod ) {
				//if ( ((Vala.CreationMethod)vm).generated == false ) {
					this.add_construction_method ( (Vala.CreationMethod)vm );
				//}
			}
			else {
				this.add_method ( vm );
			}
		}
	}
}

public interface Valadoc.SignalHandler : Basic {
	protected abstract Gee.ArrayList<Signal> signals {
		get;
		set;
	}

	protected DocumentedElement? search_signal_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Signal == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( Signal sig in this.signals ) {
			if ( sig.is_vsignal ( (Vala.Signal)velement ) ) {
				return sig;
			}
		}
		return null;
	}

	protected DocumentedElement? search_signal ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Signal sig in this.signals ) {
			if ( sig.name == params[pos] )
				return sig;
		}
		return null;
	}

	// internal
	public void add_signals ( Gee.Collection<Vala.Signal> vsignals ) {
		foreach ( Vala.Signal vsig in vsignals ) {
			var tmp = new Signal ( this.settings, vsig, this, this.head );
			this.signals.add ( tmp );
		}
	}

	public void visit_signals ( Doclet doclet ) {
		foreach ( Signal sig in this.get_signal_list ( ) ) {
			sig.visit ( doclet );
		}
	}

	public Gee.ReadOnlyCollection<Signal> get_signal_list () {
		var lst = new Gee.ArrayList<Signal> ();
		foreach ( Signal sig in this.signals ) {
			if ( !sig.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( sig );
		}

		return new Gee.ReadOnlyCollection<Signal>( lst );
	}

	// internal
	protected void set_signal_type_references () {
		foreach ( Signal sig in this.signals ) {
			sig.set_type_references ( );
		}
	}

	// internal
	protected void parse_signal_comments ( Valadoc.Parser docparser ) {
		foreach ( Signal sig in this.signals ) {
			sig.parse_comment ( docparser );
		}
	}
}



public interface Valadoc.StructHandler : Basic {
	protected abstract Gee.ArrayList<Struct> structs {
		set;
		get;
	} 

	protected DocumentedElement? search_struct_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		foreach ( Struct stru in this.structs ) {
			DocumentedElement? element = stru.search_element_vala ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}


	protected DocumentedElement? search_struct ( string[] params, int pos ) {
		foreach ( Struct stru in this.structs ) {
			DocumentedElement? element = stru.search_element ( params, pos+1 );
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

	public void add_struct ( Vala.Struct vstru ) {
		Struct stru = new Struct ( this.settings, vstru, this, this.head );
		this.structs.add( stru );
	}

	public void add_structs ( Gee.Collection<Vala.Struct> vstructs ) {
		foreach ( Vala.Struct vstru in vstructs ) {
			this.add_struct ( vstru );
		}
	}

	public void visit_structs ( Doclet doclet ) {
		foreach ( Struct stru in this.get_struct_list() ) {
			stru.visit ( doclet );
		}
	}

	protected void set_struct_type_references ( ) {
		foreach ( Struct stru in this.structs ) {
			stru.set_type_references ( );
		}
	}

	protected void parse_struct_comments ( Valadoc.Parser docparser ) {
		foreach ( Struct stru in this.structs ) {
			stru.parse_comments ( docparser );
		}
	}
}



public interface Valadoc.Visitable : Basic, SymbolAccessibility {
	protected bool is_type_visitor_accessible ( Valadoc.Basic element ) {
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
	public bool is_public {
		get {
			Vala.SymbolAccessibility access = vsymbol.access;
			return ( access == Vala.SymbolAccessibility.PUBLIC );
		}
	}

	public bool is_protected {
		get {
			Vala.SymbolAccessibility access = vsymbol.access;
			return ( access == Vala.SymbolAccessibility.PROTECTED );
		}
	}

	public bool is_private {
		get {
			Vala.SymbolAccessibility access = vsymbol.access;
			return ( access == Vala.SymbolAccessibility.PRIVATE );
		}
	}
}



public interface Valadoc.ReturnTypeHandler : Basic {
	public abstract TypeReference? type_reference {
		protected set;
		get;
	}

	// internal
	public void set_return_type_references ( ) {
		if ( this.type_reference == null )
			return ;

		this.type_reference.set_type_references ( );
	}

	// internal, rename
	protected void set_ret_type ( Vala.DataType? vtref ) {
		var tmp = new TypeReference ( this.settings, vtref, this, this.head );
		this.type_reference = tmp;
	}
}

public interface Valadoc.ConstantHandler : Basic {
	protected abstract Gee.ArrayList<Constant> constants {
		protected set;
		get;
	}

	protected DocumentedElement? search_constant_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Constant == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( Constant c in this.constants ) {
			if ( c.is_vconstant ( (Vala.Constant)velement ) ) {
				return c;
			}
		}
		return null;
	}

	// internal
	protected DocumentedElement? search_constant ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Constant c in this.constants ) {
			if ( c.name == params[pos] )
				return c;
		}
		return null;
	}

	public Gee.ReadOnlyCollection<Constant> get_constant_list ( ) {
		var lstd = new Gee.ArrayList<Constant> ();
		foreach ( Constant c in this.constants ) {
			if ( !c.is_type_visitor_accessible ( this ) )
				continue ;

			lstd.add ( c );
		}

		return new Gee.ReadOnlyCollection<Constant>( lstd );
	}

	// internal
	public void add_constants ( Gee.Collection<Vala.Constant> vconstants ) {
		foreach ( Vala.Constant vc in vconstants ) {
			this.add_constant ( vc );
		}
	}

	// internal
	public void add_constant ( Vala.Constant vc ) {
		var tmp = new Constant ( this.settings, vc, this, this.head );
		this.constants.add ( tmp );
	}

	// internal
	public void set_constant_type_references ( ) {
		foreach ( Constant c in this.constants ) {
			c.set_type_references ( );
		}
	}

	// internal
	public void parse_constant_comments ( Valadoc.Parser docparser ) {
		foreach ( Constant c in this.constants ) {
			c.parse_comment ( docparser );
		}
	}

	public void visit_constants ( Doclet doclet ) {
		foreach ( Constant c in this.get_constant_list() ) {
			c.visit ( doclet, this );
		}
	}
}


public interface Valadoc.FieldHandler : Basic {
	protected abstract Gee.ArrayList<Field> fields {
		protected set;
		get;
	}

	protected DocumentedElement? search_field_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Field == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( Field f in this.fields ) {
			if ( f.is_vfield ( (Vala.Field)velement ) ) {
				return f;
			}
		}
		return null;
	}

	// internal
	protected DocumentedElement? search_field ( string[] params, int pos ) {
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
		}

		return new Gee.ReadOnlyCollection<Field>( lstd );
	}

	// internal
	public void add_fields ( Gee.Collection<Vala.Field> vfields ) {
		foreach ( Vala.Field vf in vfields ) {
			this.add_field ( vf );
		}
	}

	// internal
	public void add_field ( Vala.Field vf ) {
		//if ( vf.generated == true )
		//	return ;

		var tmp = new Field ( this.settings, vf, this, this.head );
		this.fields.add ( tmp );
	}

	// internal
	public void set_field_type_references ( ) {
		foreach ( Field field in this.fields ) {
			field.set_type_references ( );
		}
	}

	// internal
	public void parse_field_comments ( Valadoc.Parser docparser ) {
		foreach ( Field field in this.fields ) {
			field.parse_comment ( docparser );
		}
	}

	public void visit_fields ( Doclet doclet ) {
		foreach ( Field field in this.get_field_list() ) {
			field.visit ( doclet, this );
		}
	}
}

// rename to ExceptionListHandler
public interface Valadoc.ExceptionHandler : Basic {
	protected abstract Gee.ArrayList<DocumentedElement> err_domains {
		protected set;
		get;
	}

	public Gee.ReadOnlyCollection<DocumentedElement> get_error_domains ( ) {
		return new Gee.ReadOnlyCollection<DocumentedElement> ( this.err_domains );
	}

	public void add_exception_list ( Gee.Collection<Vala.DataType> vexceptions ) {
		foreach ( Vala.DataType vtype in vexceptions  ) {
				if ( ((Vala.ErrorType)vtype).error_domain == null ) {
					this.err_domains.add ( glib_error );
				}
				else {
					ErrorDomain type = (ErrorDomain)this.head.search_vala_symbol ( ((Vala.ErrorType)vtype).error_domain );
					this.err_domains.add ( type );
				}
		}
	}
}

public interface Valadoc.ParameterListHandler : Basic {
	protected abstract Gee.ArrayList<FormalParameter> param_list {
		protected set;
		get;
	}

	public Gee.ReadOnlyCollection<FormalParameter> get_parameter_list ( ) {
		return new Gee.ReadOnlyCollection<FormalParameter> ( this.param_list );
	}

	protected void add_parameter_list ( Gee.Collection<Vala.FormalParameter> vparams ) {
		foreach ( Vala.FormalParameter vfparam in vparams ) {
			var tmp = new FormalParameter ( this.settings, vfparam, this, this.head );
			this.param_list.add ( tmp );
		}
	}

	// internal
	public void set_parameter_list_type_references ( ) {
		foreach ( FormalParameter fparam in this.param_list ) {
			fparam.set_type_references ( );
		}
	}
}



public interface Valadoc.MethodHandler : Basic {
	protected abstract Gee.ArrayList<Method> methods {
		set;
		get;
	}

	protected DocumentedElement? search_method_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Method == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( Method m in this.methods ) {
			if ( m.is_vmethod ( (Vala.Method)velement ) ) {
				return m;
			}
		}
		return null;
	}

	// internal
	protected DocumentedElement? search_method ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Method m in this.methods ) {
			if ( m.name == params[pos] )
				return m;
		}
		return null;
	}

	// internal
	public void set_method_type_references ( ) {
		foreach ( Method m in this.methods ) {
			m.set_type_references ( );
		}
	}

	// internal
	public void parse_method_comments ( Valadoc.Parser docparser ) {
		foreach ( Method m in this.methods ) {
			m.parse_comment ( docparser );
		}
	}

	protected void add_method ( Vala.Method vmethod ) {
		var tmp = new Method ( this.settings, vmethod, this, this.head );
		this.methods.add ( tmp );
	}

	protected void add_methods ( Gee.Collection<Vala.Method> vmethods ) {
		foreach ( Vala.Method vm in vmethods ) {
			this.add_method ( vm );
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

	public TypeParameter? find_vtemplateparameter ( Vala.GenericType vttype ) {
		foreach ( TypeParameter tparam in this.template_param_lst ) {
			if ( tparam.is_vtypeparam ( vttype.type_parameter ) )
				return tparam;
		}

		if ( this.parent is TemplateParameterListHandler )
			return ((TemplateParameterListHandler)this.parent).find_vtemplateparameter ( vttype );

		return null;
	}

	public Gee.ReadOnlyCollection<TypeParameter> get_template_param_list ( ) {
		return new Gee.ReadOnlyCollection<TypeParameter> ( this.template_param_lst );
	} 

	// internal
	public void set_template_parameter_list ( Gee.Collection<Vala.TypeParameter> vtparams ) {
		foreach ( Vala.TypeParameter vtparam in vtparams ) {
			var tmp = new TypeParameter ( this.settings, vtparam, this, this.head );
			this.template_param_lst.add ( tmp );
		}
	}

	// internal
	public void set_template_parameter_list_references ( ) {
		foreach ( TypeParameter tparam in this.template_param_lst ) {
			tparam.set_type_reference ( );
		}
	}
}

public class Valadoc.Constant : DocumentedElement, SymbolAccessibility, ReturnTypeHandler, Visitable, Writeable  {
	private Vala.Constant vconst;

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public bool is_vconstant ( Vala.Constant vconst ) {
		return ( this.vconst == vconst );
	}

	public Constant ( Valadoc.Settings settings, Vala.Constant vconst, ConstantHandler parent, Tree head ) {
		this.settings = settings;
		this.vsymbol = vconst;
		this.vconst = vconst;
		this.parent = parent;
		this.head = head;

		var vret = this.vconst.type_reference;
		this.set_ret_type ( vret );
	}

	public string get_cname () {
		return this.vconst.get_cname ();
	}

	// internal
	public void set_type_references ( ) {
		((ReturnTypeHandler)this).set_return_type_references ( );
	}

	// internal
	public void parse_comment ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );
	}

	public void visit ( Doclet doclet, ConstantHandler? parent ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_constant ( this, parent );
	}

	public void write ( Langlet langlet, void* ptr, ConstantHandler parent ) {
		langlet.write_constant ( this, parent, ptr );
	}
}


public class Valadoc.Field : DocumentedElement, SymbolAccessibility, ReturnTypeHandler, Visitable, Writeable {
	private Vala.Field vfield;

	public Field ( Valadoc.Settings settings, Vala.Field vfield, FieldHandler parent, Tree head ) {
		this.settings = settings;
		this.vsymbol = vfield;
		this.vfield = vfield;
		this.parent = parent;
		this.head = head;

		var vret = this.vfield.field_type;
		this.set_ret_type ( vret );
	}

	// internal
	public bool is_vfield ( Vala.Field vfield ) {
		return ( this.vfield == vfield );
	}

	public string? get_cname () {
		return this.vfield.get_cname();
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public bool is_static {
		get {
			if ( this.parent is Namespace )
				return false;

			return this.vfield.binding == MemberBinding.STATIC;
		}
	}

	public bool is_volatile {
		get {
			return this.vfield.is_volatile;
		}
	}

	// internal
	public void set_type_references ( ) {
		((ReturnTypeHandler)this).set_return_type_references ( );
	}

	// internal
	public void parse_comment ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );
	}

	public void visit ( Doclet doclet, FieldHandler? parent ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_field ( this, parent );
	}

	public void write ( Langlet langlet, void* ptr, FieldHandler parent ) {
		langlet.write_field ( this, parent, ptr );
	}
}


public class Valadoc.TypeReference : Basic {
	private Gee.ArrayList<TypeReference> type_arguments = new Gee.ArrayList<TypeReference> ();
	private Vala.DataType? vtyperef;

	public TypeReference ( Valadoc.Settings settings, Vala.DataType? vtyperef, Basic parent, Tree head ) {
		this.settings = settings;
		this.vtyperef = vtyperef;
		this.parent = parent;
		this.head = head;
	}

	public Gee.ReadOnlyCollection<TypeReference> get_type_arguments ( ) {
		return new Gee.ReadOnlyCollection<TypeReference> ( this.type_arguments );
	}

	private void set_template_argument_list ( Gee.Collection<Vala.DataType> varguments ) {
		foreach ( Vala.DataType vdtype in varguments ) {
			var dtype = new TypeReference ( this.settings, vdtype, this, this.head );
			dtype.set_type_references ( );
			this.type_arguments.add ( dtype );
		}
	}

	public Basic? data_type {
		private set;
		get;
	}

	public bool pass_ownership {
		get {
			Vala.CodeNode? node = this.vtyperef.parent_node;
			if ( node == null )
				return false;

			if ( node is Vala.FormalParameter ) {
				return ( ((Vala.FormalParameter)node).direction == ParameterDirection.IN &&
					((Vala.FormalParameter)node).parameter_type.value_owned );
			}

			if ( node is Vala.Property ) {
				return ((Vala.Property)node).property_type.value_owned;
			}

			return false;
		}
	}

	public bool is_owned {
		get {
			Vala.CodeNode parent = this.vtyperef.parent_node;

			// parameter:
			if ( parent is Vala.FormalParameter ) {
				if ( ((Vala.FormalParameter)parent).direction != ParameterDirection.IN )
					return false;

				return ((Vala.FormalParameter)parent).parameter_type.value_owned;
			}
			return false;
		}
	}

	public bool is_unowned {
		get {
			Vala.CodeNode parent = this.vtyperef.parent_node;

			// parameter:
			if ( parent is Vala.FormalParameter ) {
				if ( ((Vala.FormalParameter)parent).direction == ParameterDirection.IN )
					return false;

				return this.is_weak_helper ( ((Vala.FormalParameter)parent).parameter_type );
			}

			// return type
			if ( parent is Vala.Method == true )
				return this.is_weak_helper ( ((Vala.Method)parent).return_type );
			else if ( parent is Vala.Signal == true )
				return this.is_weak_helper ( ((Vala.Signal)parent).return_type );
			else if ( parent is Vala.Delegate == true )
				return this.is_weak_helper ( ((Vala.Delegate)parent).return_type );

			return false;
		}
	}


	// from vala/valacodewriter.vala
	private bool is_weak_helper ( Vala.DataType type ) {
		if (type.value_owned) {
			return false;
		} else if (type is Vala.VoidType || type is Vala.PointerType) {
			return false;
		} else if (type is Vala.ValueType) {
			if (type.nullable) {
				// nullable structs are heap allocated
				return true;
			}

			// TODO return true for structs with destroy
			return false;
		}

		return true;
	}
	
	public bool is_dynamic {
		get {
			return this.vtyperef.is_dynamic;
		}
	}

	public bool is_weak {
		get {
			return ( this.vtyperef.parent_node is Field )? this.is_weak_helper( this.vtyperef ) : false;
		}
	}

	public bool is_nullable {
		get {
			return this.vtyperef.nullable && this.vtyperef is Vala.PointerType == false;
		}
	}

	// remove
	private string extract_type_name ( Vala.DataType vdtype ) {
			if ( vdtype is Vala.VoidType ) {
				return "void";
			}
			else if ( vdtype is Vala.PointerType ) {
				return this.extract_type_name ( ((Vala.PointerType)vdtype).base_type );
			}
			else if ( vdtype is Vala.DelegateType ) {
				return ((Vala.DelegateType)this.vtyperef).delegate_symbol.name;
			}
			else if ( vdtype is Vala.MethodType ) {
				return ((Vala.MethodType)this.vtyperef).method_symbol.name;
			}
			else if ( vdtype is Vala.SignalType ) {
				return ((Vala.SignalType)this.vtyperef).signal_symbol.name;
			}
			else if ( vdtype is Vala.ArrayType ) {
				this.extract_type_name ( ((Vala.ArrayType)vdtype).element_type );
			}
			return vtyperef.to_string();
	}

	// remove
	public string type_name {
		owned get {
			return this.extract_type_name ( this.vtyperef );
		}
	}

	private TypeParameter? find_template_parameter ( GenericType vtyperef ) {

		Basic? element = this.parent;
		while ( !(element is TemplateParameterListHandler || element == null) ) {
			element = element.parent;
		}

		if ( element == null )
			return null;

		return ((TemplateParameterListHandler)element).find_vtemplateparameter ( (GenericType)vtyperef );
	}

	// internal
	public void set_type_references ( ) {
		if ( this.vtyperef != null ) {
			if ( this.vtyperef is PointerType )
				this.data_type = new Pointer ( settings, (Vala.PointerType)this.vtyperef, this, head );
			else if ( vtyperef is ArrayType )
				this.data_type = new Array ( settings, (Vala.ArrayType)this.vtyperef, this, head );
			else if ( vtyperef is GenericType )
				 this.data_type = find_template_parameter ( (GenericType)vtyperef );
		}


		if ( this.data_type == null ) {
			Vala.DataType vtype = this.vtyperef;
			this.set_template_argument_list ( vtype.get_type_arguments ()  );
			// still necessary?
			if ( vtype is Vala.ErrorType ) {
				Vala.ErrorDomain verrdom = ((Vala.ErrorType)vtype).error_domain;
				if ( verrdom != null )
					this.data_type = this.head.search_vala_symbol ( verrdom );
				else
					this.data_type = glib_error;
			}
			// necessary?
			else if (vtype is Vala.DelegateType ) {
				this.data_type = this.head.search_vala_symbol ( ((Vala.DelegateType)vtype).delegate_symbol );
			}
			else {
				this.data_type = this.head.search_vala_symbol ( vtype.data_type );
			}
		}
		else if ( this.data_type is Pointer ) {
			((Pointer)this.data_type).set_type_references ();
		}
		else if ( this.data_type is Array ) {
			((Array)this.data_type).set_type_references ();
		}
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_type_reference ( this, ptr );
	}
}



public class Valadoc.TypeParameter : Basic, ReturnTypeHandler {
	private Vala.TypeParameter vtypeparam;

	public bool is_vtypeparam ( Vala.TypeParameter vtypeparam ) {
		return this.vtypeparam == vtypeparam;
	}

	public TypeParameter ( Valadoc.Settings settings, Vala.TypeParameter vtypeparam, Basic parent, Tree head ) {
		this.vtypeparam = vtypeparam;
		this.vsymbol = vtypeparam;
		this.settings = settings;
		this.parent = parent;
		this.head = head;
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_type_parameter ( this, ptr );
	}

	public string? name {
		owned get {
			return this.vtypeparam.name;
		}
	}

	// internal
	public void set_type_reference ( ) {
	}
}


public class Valadoc.FormalParameter : Basic, ReturnTypeHandler {
	private Vala.FormalParameter vformalparam;

	public FormalParameter ( Valadoc.Settings settings, Vala.FormalParameter vformalparam, Basic parent, Tree head ) {
		this.settings = settings;
		this.vformalparam = vformalparam;
		this.vsymbol = vformalparam;
		this.parent = parent;
		this.head = head;

		var vformparam = this.vformalparam.parameter_type;
		this.set_ret_type ( vformparam );
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

	public bool has_default_value {
		get {
			return this.vformalparam.default_expression != null;
		}
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public bool ellipsis {
		get {
			return this.vformalparam.ellipsis;
		}
	}

	public string? name {
		owned get {
			return ( this.vformalparam.name == null )? "" : this.vformalparam.name;
		}
	}

	// internal
	public void set_type_references ( ) {
		if ( this.vformalparam.ellipsis )
			return ;

		((ReturnTypeHandler)this).set_return_type_references ( );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_formal_parameter ( this, ptr );
	}
}


public class Valadoc.PropertyAccessor : Object {
	private Vala.PropertyAccessor vpropacc;

	public PropertyAccessor ( Valadoc.Settings settings, Vala.PropertyAccessor vpropacc, Property parent, Tree head ) {
		this.settings = settings;
		this.vpropacc = vpropacc;
		this.parent = parent;
		this.head = head;
	}

	public Tree head {
		construct;
		get;
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

	public bool is_owned {
		get {
			return this.vpropacc.value_type.value_owned;
		}
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_property_accessor ( this, ptr );
	}
}

public class Valadoc.Property : DocumentedElement, SymbolAccessibility, ReturnTypeHandler, Visitable, Writeable {
	private Vala.Property vproperty;

	public Property ( Valadoc.Settings settings, Vala.Property vproperty, PropertyHandler parent, Tree head ) {
		this.settings = settings;
		this.vproperty = vproperty;
		this.vsymbol = vproperty;
		this.parent = parent;
		this.head = head;

		var ret = this.vproperty.property_type;
		this.set_ret_type ( ret );

		if ( this.vproperty.get_accessor != null )
			this.getter = new PropertyAccessor ( this.settings, this.vproperty.get_accessor, this, this.head );

		if ( this.vproperty.set_accessor != null )
			this.setter = new PropertyAccessor ( this.settings, this.vproperty.set_accessor, this, this.head );
	}

	public bool is_vproperty ( Vala.Property vprop ) {
		return ( this.vproperty == vprop );
	}

	public string? get_cname () {
		return this.vproperty.nick;
	}

	public bool equals ( Property p ) {
		return this.vproperty.equals ( p.vproperty );
	}

	public TypeReference? type_reference {
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

	public Property base_property {
		private set;
		get;
	}

	// internal
	public void set_type_references ( ) {
		if ( this.is_override ) {
			Vala.Property vp = ( this.vproperty.base_property == null )? this.vproperty.base_interface_property : this.vproperty.base_property;
			this.base_property = (Property?)this.head.search_vala_symbol ( vp );
		}
		this.set_return_type_references ( );
	}

	public void parse_comment ( Valadoc.Parser docparser ) {
		if ( this.documentation != null )
			return ;

		if ( this.comment_string == null )
			return ;

		bool tmp = Parser.is_documentation ( this.comment_string );
		if ( tmp == false )
			return ;

		if ( this.is_override && docparser.is_inherit_doc ( this ) ) {
			this.base_property.parse_comment ( docparser );
			this.documentation = this.base_property.documentation;
			return ;
		}

		this.parse_comment_helper ( docparser );
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_property ( this );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_property ( this, ptr );
	}
}



public class Valadoc.Signal : DocumentedElement, ParameterListHandler, SymbolAccessibility, ReturnTypeHandler, Visitable, Writeable {
	private Vala.Signal vsignal;

	public Signal ( Valadoc.Settings settings, Vala.Signal vsignal, SignalHandler parent, Tree head ) {
		this.param_list = new Gee.ArrayList<FormalParameter> ();

		this.settings = settings;
		this.vsymbol = vsignal;
		this.vsignal = vsignal;
		this.parent = parent;
		this.head = head;

		var vparamlst = this.vsignal.get_parameters ();
		this.add_parameter_list ( vparamlst );

		var ret = this.vsignal.return_type;
		this.set_ret_type ( ret );
	}

	// internal
	public bool is_vsignal ( Vala.Signal vsig ) {
		return ( this.vsignal == vsig );
	}

	public string? get_cname () {
		return this.vsignal.get_cname();
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	protected Gee.ArrayList<FormalParameter> param_list {
		protected set;
		get;
	}

	// internal
	public void set_type_references ( ) {
		this.set_parameter_list_type_references ( );
		this.set_return_type_references ( );
	}

	// internal
	public void parse_comment ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );
	}

	public bool is_virtual {
		get {
			return this.vsignal.is_virtual;
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
}



public class Valadoc.Method : DocumentedElement, ParameterListHandler, ExceptionHandler, TemplateParameterListHandler, SymbolAccessibility, ReturnTypeHandler, Visitable, Writeable {
	private Vala.Method vmethod;

	public Method ( Valadoc.Settings settings, Vala.Method vmethod, MethodHandler parent, Tree head ) {
		this.template_param_lst = new Gee.ArrayList<TypeParameter> ();
		this.param_list = new Gee.ArrayList<FormalParameter>();
		this.err_domains = new Gee.ArrayList<DocumentedElement>();

		this.settings = settings;
		this.vsymbol = vmethod;
		this.vmethod = vmethod;
		this.parent = parent;
		this.head = head;

		var vret = this.vmethod.return_type;
		this.set_ret_type ( vret );

		var vparamlst = this.vmethod.get_parameters ();
		this.add_parameter_list ( vparamlst );

//		var vtparams = this.vmethod.get_type_parameters ();
//		this.set_template_parameter_list ( vtparams );

		//var vexceptionlst = this.vmethod.get_error_types ();
		//this.add_error_domains ( vexceptionlst );
	}

	// intern
	public bool is_vmethod ( Vala.Method vm ) {
		return ( this.vmethod == vm );
	}

	public string? get_cname () {
		return this.vmethod.get_cname();
	}

	public Method? base_method {
		private set;
		get;
	}

	public TypeReference? type_reference {
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

	public Gee.ArrayList<DocumentedElement> err_domains {
		protected set;
		get;
	}

	public string? comment_str {
		owned get {
			return this.vmethod.source_reference.comment;
		}
	}

	// intern
	public bool equals ( Method m ) {
		return ( m.vmethod == this.vmethod );
	}

	// intern
	public void parse_comment ( Valadoc.Parser docparser ) {
		if ( this.documentation != null )
			return ;

		if ( this.comment_string == null )
			return ;

		bool tmp = Parser.is_documentation ( this.comment_string );
		if ( tmp == false )
			return ;

		if ( this.is_override && docparser.is_inherit_doc ( this ) ) {
			this.base_method.parse_comment ( docparser );
			this.documentation = this.base_method.documentation;
			return ;
		}

		this.parse_comment_helper ( docparser );
	}

	public bool is_yields {
		get {
			return this.vmethod.coroutine;
		}
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
			if ( this.parent is Namespace || this.is_constructor )
				return false;

			return this.vmethod.binding == MemberBinding.STATIC;
		}
	}

	public bool is_constructor {
		get {
			return ( this.vmethod is Vala.CreationMethod );
		}
	}

	public bool is_inline {
		get {
			return this.vmethod.is_inline;
		}
	}

	public override string? name {
		owned get {
			if ( this.is_constructor ) {
				if ( this.vmethod.name == "new" )
					return ((DocumentedElement)this.parent).name;
				else
					return ((DocumentedElement)this.parent).name + "." + this.vmethod.name;
			}
			else {
				return this.vmethod.name;
			}
		}
	}

	// internal
	public void set_type_references ( ) {
		if ( this.is_override ) {
			Vala.Method vm = ( this.vmethod.base_method == null )? this.vmethod.base_interface_method : this.vmethod.base_method;
			this.base_method = (Method?)this.head.search_vala_symbol ( vm );
		}

		this.set_return_type_references ();
		this.set_parameter_list_type_references ();
		this.set_template_parameter_list_references ();

		var vexceptionlst = this.vmethod.get_error_types ();
		this.add_exception_list ( vexceptionlst );
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


public class Valadoc.EnumValue: DocumentedElement, Writeable {
	private Vala.EnumValue venval;

	public EnumValue ( Valadoc.Settings settings, Vala.EnumValue venval, Enum parent, Tree head ) {
		this.settings = settings;
		this.vsymbol = venval;
		this.venval = venval;
		this.parent = parent;
		this.head = head;
	}

	public string get_cname () {
		return this.venval.get_cname ();
	}

	public bool is_venumvalue ( Vala.EnumValue venval ) {
		return ( this.venval == venval );
	}

	public void parse_comment ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_enum_value ( this, ptr );
	}

	public void visit ( Doclet doclet ) {
		doclet.visit_enum_value ( this );
	}
}



public class Valadoc.ErrorCode : DocumentedElement, Writeable {
	private Vala.ErrorCode verrcode;

	public ErrorCode ( Valadoc.Settings settings, Vala.ErrorCode verrcode, ErrorDomain parent, Tree head ) {
		this.settings = settings;
		this.verrcode = verrcode;
		this.vsymbol = verrcode;
		this.parent = parent;
		this.head = head;
	}

	public string get_cname () {
		return this.verrcode.get_cname ();
	}

	public bool is_verrorcode ( Vala.ErrorCode verrcode ) {
		return ( this.verrcode == verrcode );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_error_code ( this, ptr );
	}

	public void parse_comment ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );
	}

	public void visit ( Doclet doclet ) {
		doclet.visit_error_code ( this );
	}
}



public class Valadoc.Delegate : DocumentedElement, SymbolAccessibility, Visitable, Writeable, ParameterListHandler, ReturnTypeHandler, TemplateParameterListHandler, ExceptionHandler {
	private Vala.Delegate vdelegate;

	public Delegate ( Valadoc.Settings settings, Vala.Delegate vdelegate, DelegateHandler parent, Tree head ) {
		this.template_param_lst = new Gee.ArrayList<TypeParameter> ();
		this.param_list = new Gee.ArrayList<FormalParameter>();
		this.err_domains = new Gee.ArrayList<DocumentedElement>();

		this.settings = settings;
		this.vdelegate = vdelegate;
		this.vsymbol = vdelegate;
		this.parent = parent;
		this.head = head;

		var ret = this.vdelegate.return_type;
		this.set_ret_type ( ret );

		var vparamlst = this.vdelegate.get_parameters ();
		this.add_parameter_list ( vparamlst );
	}

	public string? get_cname () {
		return this.vdelegate.get_cname();
	}

	public TypeReference? type_reference {
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

	protected Gee.ArrayList<DocumentedElement> err_domains {
		protected set;
		get;
	}

	public bool is_static {
		get {
			return this.vdelegate.has_target;
		}
	}

	// internal
	public void set_type_references ( ) {
		this.set_return_type_references ( );
		this.set_parameter_list_type_references ( );

		var vexceptionlst = this.vdelegate.get_error_types ();
		this.add_exception_list ( vexceptionlst );
	}

	// internal
	public void parse_comment ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );
	}

	// internal
	public bool is_vdelegate ( Vala.Delegate vdel ) {
		return ( this.vdelegate == vdel );
	}

	// new parameter: DelegateHandler parent
	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_delegate ( this, ptr );
	}
}


public class Valadoc.Class : DocumentedElement, SymbolAccessibility, Writeable, Visitable, ClassHandler, StructHandler, SignalHandler, Inheritable, MethodHandler, EnumHandler, PropertyHandler, ConstructionMethodHandler, FieldHandler, DelegateHandler, ConstantHandler, TemplateParameterListHandler {
	// rename
	private Gee.ArrayList<Interface> parent_types;
	private bool inherited = false;
	private Vala.Class vclass;

	public Class ( Valadoc.Settings settings, Vala.Class vclass, ClassHandler parent, Tree head ) {
		this.template_param_lst = new Gee.ArrayList<TypeParameter> ();
		this.parent_types = new Gee.ArrayList<Interface>();
		this.methods = new Gee.ArrayList<Method> ();

		this.settings = settings;
		this.vsymbol = vclass;
		this.vclass = vclass;
		this.parent = parent;
		this.head = head;

		if ( glib_error == null ) {
			if ( this.full_name () == "GLib.Error" ) {
				glib_error = this;
			}
		}

		var vtparams = this.vclass.get_type_parameters ();
		this.set_template_parameter_list ( vtparams );

		Gee.Collection<Vala.Enum> venums = this.vclass.get_enums ();
		this.enums = new Gee.ArrayList<Enum> ();
		this.add_enums ( venums );

		Gee.Collection<Vala.Delegate> vdelegates = this.vclass.get_delegates ();
		this.delegates = new Gee.ArrayList<Delegate> ();
		this.add_delegates ( vdelegates );

		Gee.Collection<Vala.Class> vclasses = this.vclass.get_classes();
		this.classes = new Gee.ArrayList<Class> ();
		this.add_classes ( vclasses );

		Gee.Collection<Vala.Struct> vstructs = this.vclass.get_structs();
		this.structs = new Gee.ArrayList<Struct> ();
		this.add_structs ( vstructs );

		Gee.Collection<Vala.Field> vfields = this.vclass.get_fields();
		this.fields = new Gee.ArrayList<Field> ();
		this.add_fields ( vfields );

		Gee.Collection<Vala.Method> vmethods = this.vclass.get_methods ();
		this.construction_methods = new Gee.ArrayList<Method>();
		this.add_methods_and_construction_methods ( vmethods );

		Gee.Collection<Vala.Signal> vsignals = this.vclass.get_signals();
		this.signals = new Gee.ArrayList<Signal>();
		this.add_signals ( vsignals );

		Gee.Collection<Vala.Property> vproperties = this.vclass.get_properties();
		this.properties = new Gee.ArrayList<Property>();
		this.add_properties ( vproperties );

		Gee.Collection<Vala.Constant> vconstants = this.vclass.get_constants();
		this.constants = new Gee.ArrayList<Constant>();
		this.add_constants ( vconstants );
	}

	protected Inheritable? base_type {
		private set;
		get;
	}

	protected Gee.ArrayList<TypeParameter> template_param_lst {
		set;
		get;
	}

	protected Gee.ArrayList<Method> methods {
		set;
		get;
	}

	protected Gee.ArrayList<Delegate> delegates {
		private set;
		get;
	}

	protected Gee.ArrayList<Enum> enums {
		private set;
		get;
	}

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

	protected Gee.ArrayList<Constant> constants {
		get;
		set;
	}

	public string? get_cname () {
		return this.vclass.get_cname();
	}

	public Gee.Collection<Interface> get_implemented_interface_list ( ) {
		return this.parent_types;
	}

	// internal
	public override DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos];

		if ( velement is Vala.Class == false )
			return null;

		if ( !this.is_vclass( (Vala.Class)velement ) )
			return null;

		if ( params.size == pos+1 )
			return this;

		velement = params[pos+1];

		DocumentedElement? element = null;

		if ( velement is Vala.Field ) {
			element = this.search_field_vala ( params, pos );
		}
		else if ( velement is Vala.Method ) {
			element = this.search_method_vala ( params, pos );
		}
		else if ( velement is Vala.Delegate ) {
			element = this.search_delegate_vala ( params, pos );
		}
		else if ( velement is Vala.CreationMethod ) {
			element = this.search_construction_method_vala ( params, pos );
		}
		else if ( velement is Vala.Signal ) {
			element = this.search_signal_vala ( params, pos );
		}
		else if ( velement is Vala.Property ) {
			element = this.search_property_vala ( params, pos );
		}
		else if ( velement is Vala.Struct ) {
			element = this.search_struct_vala ( params, pos );
		}
		else if ( velement is Vala.Class ) {
			element = this.search_class_vala ( params, pos );
		}
		else if ( velement is Vala.Enum ) {
			element = this.search_enum_vala ( params, pos );
		}
		else if ( velement is Vala.Constant ) {
			element = this.search_constant_vala ( params, pos );
		}
		return element;
	}

	// internal
	public override DocumentedElement? search_element ( string[] params, int pos ) {
		if ( !(this.name == params[pos] || params[0] == "this") )
			return null;

		if ( params[pos+1] == null )
			return this;

		DocumentedElement? element = this.search_field ( params, pos );
		if ( element != null )
			return element;

		element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_delegate ( params, pos );
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

		element = this.search_enum ( params, pos );
		if ( element != null )
			return element;

		element = this.search_constant ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	public string? comment_str {
		owned get {
			return this.vclass.source_reference.comment;
		}
	}

	// internal
	public bool is_vclass ( Vala.Class vcl ) {
		return this.vclass == vcl;
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_class ( this, ptr );
	}

	public bool is_abstract {
		get {
			return this.vclass.is_abstract;
		}
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_class ( this );
	}

	// internal
	public void parse_comments ( Valadoc.Parser docparser ) {
		if ( this.documentation != null )
			return ;

		if ( this.comment_string != null ) {
			bool tmp = docparser.is_documentation ( this.comment_string );
			if ( tmp == true ) {
				if ( docparser.is_inherit_doc ( this ) && this.base_type != null ) {
					((Class)this.base_type).parse_comments ( docparser );
					this.documentation = this.base_type.documentation;
				}
				else {
					this.parse_comment_helper ( docparser );
				}
			}
		}

		this.parse_construction_method_comments ( docparser );
		this.parse_delegate_comments ( docparser );
		this.parse_constant_comments ( docparser );
		this.parse_property_comments ( docparser );
		this.parse_method_comments ( docparser );
		this.parse_struct_comments ( docparser );
		this.parse_signal_comments ( docparser );
		this.parse_class_comments ( docparser );
		this.parse_field_comments ( docparser );
		this.parse_enum_comments ( docparser );
	}

	private void set_parent_type_references ( Gee.Collection<Vala.DataType> lst ) {
		if ( ((Gee.Collection)this.parent_types).size != 0 )
			return ;

		foreach ( Vala.DataType vtyperef in lst ) {
			Inheritable? element = (Inheritable?)this.head.search_vala_symbol ( vtyperef.data_type );
			if ( element is Class ) {
				this.base_type = (Class)element;
			}
			else {
				this.parent_types.add ( (Interface)element );
			}
		}
	}

	// internal
	public void set_type_references ( ) {
		var lst = this.vclass.get_base_types ();
		this.set_parent_type_references ( lst );

		this.set_template_parameter_list_references ( );
		this.set_construction_method_references ( );
		this.set_constant_type_references ( );
		this.set_delegate_type_references ( );
		this.set_property_type_reference ( );
		this.set_method_type_references ( );
		this.set_signal_type_references ( );
		this.set_field_type_references ( );
		this.set_enum_type_references ( );
		this.set_struct_type_references ( );
		this.set_class_type_references ( );
	}

	private void inheritance_class ( Class dtype ) {
		dtype.inheritance ( );

		var flst = dtype.get_field_list ( );
		foreach ( Field f in flst ) {
			this.fields.add ( f );
		}
		/*
		var plst = dtype.get_property_list ( );
		foreach ( Property prop in plst ) {
			this.properties.add ( prop );
		}
		*/
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

			this.methods.add ( m );
		}
	}

	private void inheritance_interface ( Interface dtype ) {
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

	// internal
	public void inheritance ( ) {
		if ( inherited == true )
			return ;


		inherited = true;


		if ( this.base_type != null )
			this.inheritance_class ( (Class)this.base_type );

		foreach ( Interface dtype in this.parent_types ) {
			this.inheritance_interface ( (Interface)dtype );
		}

		foreach ( Class cl in this.classes ) {
			cl.inheritance( );
		}
	}
}


public class Valadoc.ErrorDomain : DocumentedElement, SymbolAccessibility, Visitable, Writeable, MethodHandler {
	private Gee.ArrayList<ErrorCode> errcodes = new Gee.ArrayList<ErrorCode> ();
	private Vala.ErrorDomain verrdom;

	public ErrorDomain ( Valadoc.Settings settings, Vala.ErrorDomain verrdom, ErrorDomainHandler parent, Tree head ) {
		this.settings = settings;
		this.vsymbol = verrdom;
		this.verrdom = verrdom;
		this.parent = parent;
		this.head = head;

		Gee.Collection<Vala.Method> vmethods = this.verrdom.get_methods ();
		this.methods = new Gee.ArrayList<Method> ();
		this.add_methods ( vmethods );

		Gee.Collection<Vala.ErrorCode> verrcodes = this.verrdom.get_codes ();
		this.append_error_code ( verrcodes );
	}

	public string? get_cname () {
		return this.verrdom.get_cname();
	}

	protected Gee.ArrayList<Method> methods {
		protected set;
		get;
	}

	// internal
	public bool is_verrordomain ( Vala.ErrorDomain ver ) {
		return ( this.verrdom == ver );
	}

	private DocumentedElement? search_error_code ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( ErrorCode errcode in this.errcodes ) {
			if ( errcode.name == params[pos] )
				return errcode;
		}
		return null;
	}

	private DocumentedElement? search_error_code_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.ErrorCode == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( ErrorCode errc in this.errcodes ) {
			if ( errc.is_verrorcode ( (Vala.ErrorCode)velement ) ) {
				return errc;
			}
		}
		return null;
	}

	public override DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos];

		if ( velement is Vala.ErrorDomain == false )
			return null;

		if ( !this.is_verrordomain ( (Vala.ErrorDomain)velement ) )
			return null;

		if ( params.size == pos+1 )
			return this;

		velement = params[pos+1];

		DocumentedElement? element = null;

		if ( velement is Vala.ErrorCode ) {
			element = this.search_error_code_vala ( params, pos );
		}
		else if ( velement is Vala.Method ) {
			element = this.search_method_vala ( params, pos );
		}
		return element;
	}

	// internal
	public override DocumentedElement? search_element ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos+1] == null )
			return this;

		DocumentedElement? element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_error_code ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	// internal
	public void parse_comments ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );
		this.parse_method_comments ( docparser );

		foreach ( ErrorCode errcode in this.errcodes ) {
			errcode.parse_comment ( docparser );
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

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_error_domain ( this, ptr );
	}

	private inline void append_error_code ( Gee.Collection<Vala.ErrorCode> verrcodes ) {
		foreach ( Vala.ErrorCode verrcode in verrcodes ) {
			var tmp = new ErrorCode ( this.settings, verrcode, this, this.head );
			this.errcodes.add ( tmp );
		}
	}

	// internal
	public void set_type_references ( ) {
		this.set_method_type_references ( );
	}
}


public class Valadoc.Enum : DocumentedElement, SymbolAccessibility, Visitable, Writeable, MethodHandler {
	public Enum ( Valadoc.Settings settings, Vala.Enum venum, EnumHandler parent, Tree head ) {
		this.settings = settings;
		this.vsymbol = venum;
		this.venum = venum;
		this.parent = parent;
		this.head = head;

		Gee.Collection<Vala.Method> vmethods = this.venum.get_methods ();
		this.methods = new Gee.ArrayList<Method> ();
		this.add_methods ( vmethods );

		Gee.Collection<Vala.EnumValue> venvals = this.venum.get_values ();
		this.en_values = new Gee.ArrayList<EnumValue> ();
		this.add_enum_values ( venvals );
	}

	public string? get_cname () {
		return this.venum.get_cname();
	}

	private DocumentedElement? search_enum_value_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.EnumValue == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( EnumValue env in this.en_values ) {
			if ( env.is_venumvalue ( (Vala.EnumValue)velement ) ) {
				return env;
			}
		}
		return null;
	}

	private DocumentedElement? search_enum_value ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( EnumValue enval in this.en_values ) {
			if ( enval.name == params[pos] )
				return enval;
		}
		return null;
	}

	public override DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos];

		if ( velement is Vala.Enum == false )
			return null;

		if ( this.is_venum ( (Vala.Enum)velement ) == false )
			return null;

		if ( params.size == pos+1 )
			return this;

		velement = params[pos+1];

		DocumentedElement? element = null;

		if ( velement is Vala.EnumValue ) {
			element = this.search_enum_value_vala ( params, pos );
		}
		else if ( velement is Vala.Method ) {
			element = this.search_method_vala ( params, pos );
		}
		return element;
	}

	// internal
	public override DocumentedElement? search_element ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos+1] == null )
			return this;


		DocumentedElement? element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_enum_value ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	// internal
	public void set_type_references () {
		this.set_method_type_references ();
	}

	protected Gee.ArrayList<Method> methods {
		protected set;
		get;
	}

	private Gee.ArrayList<EnumValue> en_values;

	// rename: get_enum_value_list
	public Gee.ReadOnlyCollection<EnumValue> get_enum_values () {
		return new Gee.ReadOnlyCollection<EnumValue>( this.en_values );
	}

	// internal
	public void parse_comments ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );

		foreach ( EnumValue enval in this.en_values ) {
			enval.parse_comment ( docparser );
		}

		this.parse_method_comments ( docparser );
	}

	private inline void add_enum_values ( Gee.Collection<Vala.EnumValue> venvals ) {
		foreach ( Vala.EnumValue venval in venvals ) {
			var tmp = new EnumValue ( this.settings, venval, this, this.head );
			this.en_values.add ( tmp );
		}
	}

	public void visit_enum_values ( Doclet doclet ) {
		foreach ( EnumValue enval in this.en_values )
			enval.visit ( doclet );
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_enum ( this );
	}

	private Vala.Enum venum;

	// internal
	public bool is_venum ( Vala.Enum ven ) {
		return ( this.venum == ven );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_enum ( this, ptr );
	}
}



public class Valadoc.Struct : DocumentedElement, SymbolAccessibility, Writeable, Visitable, MethodHandler, ConstructionMethodHandler, FieldHandler, ConstantHandler, Inheritable, TemplateParameterListHandler {
	public Struct ( Valadoc.Settings settings, Vala.Struct vstruct, StructHandler parent, Tree head ) {
		this.settings = settings;
		this.vstruct = vstruct;
		this.vsymbol = vstruct;
		this.parent = parent;
		this.head = head;

		this.template_param_lst = new Gee.ArrayList<TypeParameter> ();
		this.methods = new Gee.ArrayList<Method> ();

		var vtparams = this.vstruct.get_type_parameters ();
		this.set_template_parameter_list ( vtparams );

		Gee.Collection<Vala.Field> vfields = this.vstruct.get_fields();
		this.fields = new Gee.ArrayList<Field> ();
		this.add_fields ( vfields );

		Gee.Collection<Vala.Constant> vconstants = this.vstruct.get_constants();
		this.constants = new Gee.ArrayList<Constant> ();
		this.add_constants ( vconstants );

		Gee.Collection<Vala.Method> vmethods = this.vstruct.get_methods ();
		this.construction_methods = new Gee.ArrayList<Method>();
		this.add_methods_and_construction_methods ( vmethods );
	}

	protected Inheritable? base_type {
		protected set;
		get;
	}

	// remove
	public Gee.Collection<Interface> get_implemented_interface_list ( ) {
		return new Gee.ArrayList<Interface> ();
	}

	public string? get_cname () {
		return this.vstruct.get_cname();
	}

	protected Gee.ArrayList<TypeParameter> template_param_lst {
		set;
		get;
	}

	protected Gee.ArrayList<Method> methods {
		set;
		get;
	}

	protected Gee.ArrayList<Field> fields {
		set;
		get;
	}

	protected Gee.ArrayList<Method> construction_methods {
		set;
		get;
	}

	protected Gee.ArrayList<Constant> constants {
		set;
		get;
	}

	public override DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos];

		if ( velement is Vala.Struct == false )
			return null;

		if ( this.is_vstruct ( (Vala.Struct)velement ) == false )
			return null;

		if ( params.size == pos+1 )
			return this;

		velement = params[pos+1];

		DocumentedElement? element = null;

		if ( velement is Vala.Field ) {
			element = this.search_field_vala ( params, pos );
		}
		else if ( velement is Vala.CreationMethod ) {
			element = this.search_construction_method_vala ( params, pos );
		}
		else if ( velement is Vala.Method ) {
			element = this.search_method_vala ( params, pos );
		}
		else if ( velement is Vala.Constant ) {
			element = this.search_constant_vala ( params, pos );
		}

		return element;
	}

	// internal
	public override DocumentedElement? search_element ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos+1] == null )
			return this;

		DocumentedElement? element = this.search_field ( params, pos );
		if ( element != null )
			return element;

		element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_constant ( params, pos );
		if ( element != null )
			return element;

		return this.search_construction_method ( params, pos );
	}

	public string? comment_str {
		owned get {
			return this.vstruct.source_reference.comment;
		}
	}

	private Vala.Struct vstruct;

	// internal
	public bool is_vstruct ( Vala.Struct vstru ) {
		return ( this.vstruct == vstru );
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_struct ( this );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_struct ( this, ptr );
	}

	// internal
	public void parse_comments ( Valadoc.Parser docparser ) {
		if ( this.documentation != null )
			return ;


		if ( this.comment_string != null ) {
			bool tmp = Parser.is_documentation ( this.comment_string );
			if ( tmp == true ) {
				if ( docparser.is_inherit_doc ( this ) && this.base_type != null ) {
					((Valadoc.Struct)this.base_type).parse_comments ( docparser );
					this.documentation = this.base_type.documentation;
				}
				else {
					this.parse_comment_helper ( docparser );
				}
			}
		}

		this.parse_construction_method_comments ( docparser );
		this.parse_constant_comments ( docparser );
		this.parse_method_comments ( docparser );
		this.parse_field_comments ( docparser );
	}

	private void set_parent_references ( ) {
		Vala.ValueType? basetype = (Vala.ValueType?)this.vstruct.base_type;
		if ( basetype == null )
			return ;

		this.base_type = (Struct?)this.head.search_vala_symbol ( (Vala.Struct)basetype.type_symbol );
	}

	// internal
	public void set_type_references ( ) {
		this.set_template_parameter_list_references ( );
		this.set_construction_method_references ( );
		this.set_constant_type_references ( );
		this.set_method_type_references ( );
		this.set_field_type_references ( );
		this.set_parent_references ( );
	}
}


public class Valadoc.Interface : DocumentedElement, SymbolAccessibility, Writeable, Visitable, SignalHandler, PropertyHandler, FieldHandler, TemplateParameterListHandler, MethodHandler, DelegateHandler, EnumHandler, StructHandler, ClassHandler, Inheritable {
	public Interface ( Valadoc.Settings settings, Vala.Interface vinterface, InterfaceHandler parent, Tree head ) {
		this.settings = settings;
		this.vinterface = vinterface;
		this.vsymbol = vinterface;
		this.parent = parent;
		this.head = head;

		this.template_param_lst = new Gee.ArrayList<TypeParameter> ();
		this.methods = new Gee.ArrayList<Method> ();

		var vtparams = this.vinterface.get_type_parameters ();
		this.set_template_parameter_list ( vtparams );

		Gee.Collection<Vala.Method> methods = this.vinterface.get_methods ();
		this.methods = new Gee.ArrayList<Method>();
		this.add_methods ( methods );

		Gee.Collection<Vala.Delegate> delegates = this.vinterface.get_delegates ();
		this.delegates = new Gee.ArrayList<Delegate>();
		this.add_delegates ( delegates );

		Gee.Collection<Vala.Signal> signals = this.vinterface.get_signals();
		this.signals = new Gee.ArrayList<Signal>();
		this.add_signals ( signals );

		Gee.Collection<Vala.Property> properties = this.vinterface.get_properties();
		this.properties = new Gee.ArrayList<Property>();
		this.add_properties ( properties );

		Gee.Collection<Vala.Field> fields = this.vinterface.get_fields();
		this.fields = new Gee.ArrayList<Field>();
		this.add_fields ( fields );

		Gee.Collection<Vala.Struct> structs = this.vinterface.get_structs();
		this.structs = new Gee.ArrayList<Struct>();
		this.add_structs ( structs );

		Gee.Collection<Vala.Class> classes = this.vinterface.get_classes();
		this.classes = new Gee.ArrayList<Class>();
		this.add_classes ( classes );

		Gee.Collection<Vala.Enum> enums = this.vinterface.get_enums();
		this.enums = new Gee.ArrayList<Enum>();
		this.add_enums ( enums );
	}

	private Gee.ArrayList<Interface> parent_types = new Gee.ArrayList<Interface>();

	public Gee.Collection<Interface> get_implemented_interface_list ( ) {
		return this.parent_types;
	}

	public string? get_cname () {
		return this.vinterface.get_cname();
	}

	protected Inheritable? base_type {
		private set;
		get;
	}

	protected Gee.ArrayList<TypeParameter> template_param_lst {
		set;
		get;
	}

	protected Gee.ArrayList<Method> methods {
		set;
		get;
	}

	protected Gee.ArrayList<Property> properties {
		get;
		set;
	}

	protected Gee.ArrayList<Field> fields {
		get;
		set;
	}

	protected Gee.ArrayList<Signal> signals {
		get;
		set;
	}

	protected Gee.ArrayList<Enum> enums {
		get;
		set;
	}

	protected Gee.ArrayList<Delegate> delegates {
		get;
		set;
	}

	protected Gee.ArrayList<Struct> structs {
		get;
		set;
	}

	protected Gee.ArrayList<Class> classes {
		get;
		set;
	}

	private Vala.Interface vinterface;

	public override DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos];

		if ( velement is Vala.Interface == false )
			return null;

		if ( this.is_vinterface ( (Vala.Interface)velement ) == false )
			return null;

		if ( params.size == pos+1 )
			return this;

		velement = params[pos+1];

		DocumentedElement? element = null;

		if ( velement is Vala.Field ) {
			element = this.search_field_vala ( params, pos );
		}
		else if ( velement is Vala.Method ) {
			element = this.search_method_vala ( params, pos );
		}
		else if ( velement is Vala.Signal ) {
			element = this.search_signal_vala ( params, pos );
		}
		else if ( velement is Vala.Property ) {
			element = this.search_property_vala ( params, pos );
		}
		else if ( velement is Vala.Delegate ) {
			element = this.search_delegate_vala ( params, pos );
		}
		else if ( velement is Vala.Struct ) {
			element = this.search_struct_vala ( params, pos );
		}
		else if ( velement is Vala.Enum ) {
			element = this.search_enum_vala ( params, pos );
		}
		else if ( velement is Vala.Class ) {
			element = this.search_class_vala ( params, pos );
		}
		return element;
	}

	// internal
	public override DocumentedElement? search_element ( string[] params, int pos ) {
		if ( !(this.name == params[pos] || params[0] == "this") )
			return null;

		if ( params[pos+1] == null )
			return this;

		DocumentedElement? element = this.search_field ( params, pos );
		if ( element != null )
			return element;

		element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_signal ( params, pos );
		if ( element != null )
			return element;

		element = this.search_property ( params, pos );
		if ( element != null )
			return element;

		element = this.search_delegate ( params, pos );
		if ( element != null )
			return element;

		element = this.search_struct ( params, pos );
		if ( element != null )
			return element;

		element = this.search_enum ( params, pos );
		if ( element != null )
			return element;

		element = this.search_class ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	public string? comment_str {
		owned get {
			return this.vinterface.source_reference.comment;
		}
	}

	// internal
	public bool is_vinterface ( Vala.Interface viface ) {
		return ( this.vinterface == viface );
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_interface ( this );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_interface ( this, ptr );
	}

	// internal
	public void parse_comments ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );
		this.parse_delegate_comments ( docparser );
		this.parse_property_comments ( docparser );
		this.parse_signal_comments ( docparser );
		this.parse_method_comments ( docparser );
		this.parse_struct_comments ( docparser );
		this.parse_field_comments ( docparser );
		this.parse_class_comments ( docparser );
		this.parse_enum_comments ( docparser );
	}

	private void set_prerequisites ( Gee.Collection<Vala.DataType> lst ) {
		if ( ((Gee.Collection)this.parent_types).size != 0 )
			return ;

		foreach ( Vala.DataType vtyperef in lst ) {
			Inheritable? element = (Inheritable?)this.head.search_vala_symbol ( vtyperef.data_type );
			if ( element is Class )
				this.base_type = (Class)element;
			else
				this.parent_types.add ( (Interface)element );
		}
	}

	// internal
	public void set_type_references ( ) {
		this.set_template_parameter_list_references ( );
		this.set_delegate_type_references ();
		this.set_property_type_reference ();
		this.set_signal_type_references ();
		this.set_method_type_references ();
		this.set_struct_type_references ();
		this.set_field_type_references ();
		this.set_enum_type_references ();
		this.set_class_type_references ();

		var lst = this.vinterface.get_prerequisites ( );
		this.set_prerequisites ( lst );
	}
}

public class Valadoc.Namespace : DocumentedElement, MethodHandler, FieldHandler, NamespaceHandler, ErrorDomainHandler,
                                 EnumHandler, ClassHandler, StructHandler, Writeable, InterfaceHandler,
                                 DelegateHandler, ConstantHandler
{
	protected Gee.ArrayList<Constant> constants {
		protected set;
		get;
	}

	protected Gee.ArrayList<Enum> enums {
		private set;
		get;
	}

	protected Gee.ArrayList<Interface> interfaces {
		private set;
		get;
	}

	protected Gee.ArrayList<Delegate> delegates {
		private set;
		get;
	}

	protected Gee.ArrayList<ErrorDomain> errdoms {
		private set;
		get;
	}

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

	// interface
	private DocumentedElement? search_namespace ( string[] params, int pos ) {
		foreach ( Namespace ns in this.namespaces ) {
			DocumentedElement? element = ns.search_element ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	//interface
	private DocumentedElement? search_namespace_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		foreach ( Namespace ns in this.namespaces ) {
			DocumentedElement? element = ns.search_element_vala ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	public override DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos];

		if ( velement is Vala.Namespace == false )
			return null;

		if ( this.is_vnspace ( (Vala.Namespace)velement ) == false )
			return null;

		if ( params.size == pos+1 )
			return this;

		velement = params[pos+1];

		DocumentedElement? element = null;

		if ( velement is Vala.Namespace ) {
			element = this.search_namespace_vala ( params, pos );
		}
		else if ( velement is Vala.Class ) {
			element = this.search_class_vala ( params, pos );
		}
		else if ( velement is Vala.Interface ) {
			element = this.search_interface_vala ( params, pos );
		}
		else if ( velement is Vala.Struct ) {
			element = this.search_struct_vala ( params, pos );
		}
		else if ( velement is Vala.Enum ) {
			element = this.search_enum_vala ( params, pos );
		}
		else if ( velement is Vala.ErrorDomain ) {
			element = this.search_error_domain_vala ( params, pos );
		}
		else if ( velement is Vala.Method ) {
			element = this.search_method_vala ( params, pos );
		}
		else if ( velement is Vala.Field ) {
			element = this.search_field_vala ( params, pos );
		}
		else if ( velement is Vala.DelegateType || velement is Vala.Delegate ) {
			element = this.search_delegate_vala ( params, pos );
		}
		else if ( velement is Vala.Constant ) {
			element = this.search_constant_vala ( params, pos );
		}
		return element;
	}

	// internal
	public override DocumentedElement? search_element ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos+1] == null )
			return this;


		DocumentedElement? element = this.search_namespace ( params, pos );
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

		element = search_constant ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	protected Gee.ArrayList<Field> fields {
		set;
		get;
	}

	protected Gee.ArrayList<Method> methods {
		set;
		get;
	}

	public Namespace ( Valadoc.Settings settings, Vala.Namespace vnspace, NamespaceHandler parent, Tree head ) {
		this.settings = settings;
		this.vsymbol = vnspace;
		this.vnspace = vnspace;
		this.parent = parent;
		this.head = head;

		this.namespaces = new Gee.ArrayList<Namespace> ();
		this.structs = new Gee.ArrayList<Struct>();
		this.classes = new Gee.ArrayList<Class>();

		this.constants = new Gee.ArrayList<Constant> ();
		this.interfaces = new Gee.ArrayList<Interface>();
		this.methods = new Gee.ArrayList<Method> ();
		this.delegates = new Gee.ArrayList<Delegate>();
		this.errdoms = new Gee.ArrayList<ErrorDomain>();
		this.enums = new Gee.ArrayList<Enum>();
		this.fields = new Gee.ArrayList<Field> ();
	}

	public void visit ( Doclet doclet ) {
		doclet.visit_namespace ( this );
	}

	public Vala.Namespace vnspace {
		construct set;
		private get;
	}

	// internal
	public void set_type_references ( ) {
		this.set_errordomain_type_referenes ( );
		this.set_namespace_type_references ( );
		this.set_interface_type_references ( );
		this.set_delegate_type_references ( );
		this.set_constant_type_references ( );
		this.set_method_type_references ( );
		this.set_field_type_references ( );
		this.set_struct_type_references ( );
		this.set_class_type_references ( );
		this.set_enum_type_references ( );
	}

	// internal
	public void inheritance ( ) {
		this.namespace_inheritance ( );
		foreach ( Class cl in this.classes ) {
			cl.inheritance ( );
		}
	}

	// internal
	public void parse_comments ( Valadoc.Parser docparser ) {
		//this.parse_comment_helper ( docparser );
		this.parse_enum_comments ( docparser );
		this.parse_field_comments ( docparser );
		this.parse_class_comments ( docparser );
		this.parse_method_comments ( docparser );
		this.parse_struct_comments ( docparser );
		this.parse_constant_comments ( docparser );
		this.parse_delegate_comments ( docparser );
		this.parse_interface_comments ( docparser );
		this.parse_namespace_comments ( docparser );
 		this.parse_errordomain_comments ( docparser );
	}

	// internal
	public bool is_vnspace ( Vala.Namespace vns ) {
		return ( this.vnspace == vns );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_namespace ( this, ptr );
	}
}


public class Valadoc.Package : DocumentedElement, NamespaceHandler {
	private Gee.ArrayList<Vala.SourceFile> vfiles = new Gee.ArrayList<Vala.SourceFile> ();

	// internal
	public void add_file ( Vala.SourceFile vfile ) {
		this.vfiles.add ( vfile );
	}

	public Gee.ArrayList<Namespace> namespaces {
		default = new Gee.ArrayList<Namespace>();
		private set;
		private get;
	}

	public bool is_package {
		 private set;
		 get;
	}

	// internal
	public void set_dependency_list ( Gee.ArrayList<Package> list ) {
		this._dependencies = list;
	}

	private Gee.ArrayList<Package> _dependencies;

	public Gee.ReadOnlyCollection<Package> get_full_dependency_list () {
		Gee.ArrayList<Package> list = new Gee.ArrayList<Package> ();

		if ( this._dependencies == null )
			return new Gee.ReadOnlyCollection<Package> ( list );

		foreach ( Package pkg in this._dependencies ) {
			if ( list.contains ( pkg ) == false ) {
				list.add ( pkg );
			}

			var pkg_list = pkg.get_full_dependency_list ();
			foreach ( Package pkg2 in pkg_list ) {
				if ( list.contains ( pkg2 ) == false ) {
					list.add ( pkg2 );
				}
			}
		}
		return new Gee.ReadOnlyCollection<Package> ( list );
	}

	public Gee.ReadOnlyCollection<Package> get_dependency_list () {
		if ( this._dependencies == null ) {
			return new Gee.ReadOnlyCollection<Package> ( new Gee.ArrayList<Package> () );
		}

		return new Gee.ReadOnlyCollection<Package> ( this._dependencies );
	}

	private static string extract_package_name ( Settings settings, Vala.SourceFile vfile ) {
		if ( vfile.filename.has_suffix (".vapi") ) {
			string file_name = GLib.Path.get_basename (vfile.filename);
			return file_name.ndup ( file_name.size() - ".vapi".size() );
		}
		else if ( vfile.filename.has_suffix (".gidl") ) {
			string file_name = GLib.Path.get_basename (vfile.filename);
			return file_name.ndup ( file_name.size() - ".gidl".size() );
		}
		else {
			return settings.pkg_name;
		}
	}

	public Package.with_name ( Valadoc.Settings settings, Vala.SourceFile vfile, string name, Tree head, bool is_package = false ) {
		this.settings = settings;
		this.head = head;

		this.is_package = is_package;
		this.package_name = name;

		this.vfiles.add ( vfile );
		this.parent = null;
	}

	public Package ( Valadoc.Settings settings, Vala.SourceFile vfile, Tree head, bool is_package = false ) {
		this.with_name ( settings, vfile, this.extract_package_name ( settings, vfile ), head, is_package );
	}

	private string package_name;

	public override string? name {
		owned get {
			return package_name;
		}
	}

	// internal
	public override DocumentedElement? search_element ( string[] params, int pos ) {
		foreach ( Namespace ns in this.namespaces ) {
			DocumentedElement? element = ns.search_element ( params, pos );
			if ( element != null )
				return element;
		}
		return null;
	}

	// internal
	public override DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		foreach ( Namespace ns in this.namespaces ) {
			DocumentedElement? element = ns.search_element_vala ( params, pos );
			if ( element != null )
				return element;
		}
		return null;
	}

	// internal
	public bool is_vpackage ( Vala.SourceFile vfile ) {
		return this.vfiles.contains ( vfile );
	}

	public bool is_visitor_accessible () {
		return !( this.is_package && this.settings.with_deps == false );
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible () ) {
			return ;
		}
		doclet.visit_package ( this );
	}

	// internal
	public void inheritance ( ) {
		this.namespace_inheritance ( );
	}

	// internal
	public void parse_comments ( Valadoc.Parser docparser ) {
		this.parse_namespace_comments ( docparser );
	}

	// internal
	public void set_type_references ( ) {
		this.set_namespace_type_references ( );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_file ( this, ptr );
	}
}



public class Valadoc.Tree : Vala.CodeVisitor {
	private Gee.ArrayList<Package> packages = new Gee.ArrayList<Package>();
	private Package source_package = null;
	private Valadoc.Settings settings;
	private CodeContext context;
	private ErrorReporter reporter;

	public WikiPageTree? wikitree {
		private set;
		get;
	}

	public Gee.ReadOnlyCollection<Package> get_package_list () {
		return new Gee.ReadOnlyCollection<Package> ( this.packages );
	}

	private void add_dependencies_to_source_package () {
		if ( this.source_package != null ) {
			Gee.ArrayList<Package> deplst = new Gee.ArrayList<Package> ();
			foreach ( Package pkg in this.packages ) {
				if ( pkg != this.source_package ) {
					deplst.add ( pkg );
				}
			}		
			this.source_package.set_dependency_list ( deplst );
		}
	}

	public void visit ( Doclet doclet ) {
		doclet.initialisation ( this.settings, this );
	}

	private DocumentedElement? search_symbol_in_type ( DocumentedElement element, string[] params, int params_offset = 0 ) {
		if ( !( element.parent is Inheritable || element.parent is Enum || element.parent is ErrorDomain ) )
			return null;

		if ( params[0] != "this" ) {
			string[] nparams = new string[ params.length+1 ];
			nparams[0] = "this";
			for ( int i = 0; params.length > i ; i++ ) {
				nparams [i+1] = params[i];
			}
			return this.search_symbol_in_symbol ( (DocumentedElement)element.parent, nparams, 0 );
		}

		return this.search_symbol_in_symbol ( (DocumentedElement)element.parent, params, 0 );
	}

	private DocumentedElement? search_symbol_in_symbol ( DocumentedElement element, string[] params, int params_offset = 0 ) {
		if ( element is Class || element is Interface || element is Struct ) {
			return element.search_element ( params, params_offset );
		}
		else if ( element is Enum ) {
			return element.search_element ( params, params_offset );
		}
		else if ( element is ErrorDomain ) {
			return element.search_element ( params, params_offset );
		}
		return null;
	}

	private DocumentedElement? search_symbol_in_global_namespaces ( DocumentedElement? element, string[] params ) {
		int param_size = 0;
		for ( param_size = 0; params[param_size] != null; param_size++ );

		string[] global_params = new string[param_size +1];

		global_params[0] = null;
		for ( int i = 0; params[i-1] != null ; i++ ) {
			global_params[i+1] = params[i];
		}

		foreach ( Package pkg in this.packages ) {
			DocumentedElement? element2 = pkg.search_element ( global_params, 0 );
			if ( element2 != null )
				return element2;
		}
		return null;
	}

	private DocumentedElement? search_symbol_in_namespaces ( DocumentedElement? element, string[] params ) {
		foreach ( Package pkg in this.packages ) {
			DocumentedElement? element2 = pkg.search_element ( params, 0 );
			if ( element2 != null )
				return element2;
		}
		return null;
	}

	private DocumentedElement? search_element ( DocumentedElement? element, string[] params ) {
		if ( element != null ) {
			if ( params[0] == "this" ) {
				return search_symbol_in_type ( element, params, 1 );
			}

			var tmp = search_symbol_in_type ( element, params );
			if ( tmp != null )
				return tmp;
		}

		var tmp = search_symbol_in_global_namespaces ( element, params );
		if ( tmp != null )
			return tmp;

		tmp = this.search_symbol_in_namespaces ( element, params );
		if ( tmp != null )
			return tmp;

		return null;
	}

	public DocumentedElement? search_symbol_str ( DocumentedElement? element, string symname ) {
		string[] params = symname.split( ".", -1 );
		int i = 0; while ( params[i] != null ) i++;
		params.length = i;

		return this.search_element ( element, params );
	}

	public override void visit_namespace ( Vala.Namespace vns ) {
		vns.accept_children ( this );
	}

	public override void visit_class ( Vala.Class vcl ) {
		if ( vcl.parent_symbol is Vala.Namespace == false )
			return ;

		Vala.SourceFile vfile = vcl.source_reference.file;
		Package file = this.find_file( vfile );
		Namespace ns = file.get_namespace ( vcl );
		ns.add_class ( vcl );
	}

	public override void visit_interface ( Vala.Interface viface ) {
		if ( viface.parent_symbol is Vala.Namespace == false )
			return ;

		Vala.SourceFile vfile = viface.source_reference.file;
		Package file = this.find_file( vfile );
		Namespace ns = file.get_namespace ( viface );
		ns.add_interface ( viface );
	}

	public override void visit_struct ( Vala.Struct vstru ) {
		if ( vstru.parent_symbol is Vala.Namespace == false )
			return ;

		Vala.SourceFile vfile = vstru.source_reference.file;
		Package file = this.find_file( vfile );
		Namespace ns = file.get_namespace ( vstru );
		ns.add_struct ( vstru );
	}

	public override void visit_field ( Vala.Field vf ) {
		if ( vf.parent_symbol is Vala.Namespace == false )
			return ;

		Vala.SourceFile vfile = vf.source_reference.file;
		Package file = this.find_file( vfile );
		Namespace ns = file.get_namespace ( vf );
		ns.add_field ( vf );
	}

	public override void visit_method ( Vala.Method vm ) {
		if ( vm.parent_symbol is Vala.Namespace == false )
			return ;

		Vala.SourceFile vfile = vm.source_reference.file;
		Package file = this.find_file( vfile );
		Namespace ns = file.get_namespace ( vm );
		ns.add_method ( vm );
	}

	public override void visit_delegate ( Vala.Delegate vd ) {
		if ( vd.parent_symbol is Vala.Namespace == false )
			return ;

		Vala.SourceFile vfile = vd.source_reference.file;
		Package file = this.find_file( vfile );
		Namespace ns = file.get_namespace ( vd );
		ns.add_delegate ( vd );
	}

	public override void visit_enum ( Vala.Enum venum ) {
		if ( venum.parent_symbol is Vala.Namespace == false )
			return ;

		Vala.SourceFile vfile = venum.source_reference.file;
		Package file = this.find_file( vfile );
		Namespace ns = file.get_namespace ( venum );
		ns.add_enum ( venum );
	}

	public override void visit_constant ( Vala.Constant vc ) {
		if ( vc.parent_symbol is Vala.Namespace == false )
			return ;

		Vala.SourceFile vfile = vc.source_reference.file;
		Package file = this.find_file( vfile );
		Namespace ns = file.get_namespace ( vc );
		ns.add_constant ( vc );
	}

	public override void visit_error_domain ( Vala.ErrorDomain verrdom ) {
		if ( verrdom.parent_symbol is Vala.Namespace == false )
			return ;

		Vala.SourceFile vfile = verrdom.source_reference.file;
		Package file = this.find_file( vfile );
		Namespace ns = file.get_namespace ( verrdom );
		ns.add_error_domain ( verrdom );
	}

	public Tree ( Valadoc.ErrorReporter reporter, Valadoc.Settings settings) {
		this.context = new Vala.CodeContext ( );
		CodeContext.push (context);

		this.settings = settings;
		this.reporter = reporter;

		reporter.vreporter = this.context.report;

		this.context.checking = settings.enable_checking;
		this.context.deprecated = settings.deprecated;
		this.context.experimental = settings.experimental;
		this.context.non_null_experimental = settings.non_null_experimental;
		this.context.dbus_transformation = !settings.disable_dbus_transformation;


		if (settings.basedir == null) {
			context.basedir = realpath (".");
		} else {
			context.basedir = realpath (settings.basedir);
		}

		if (settings.directory != null) {
			context.directory = realpath (settings.directory);
		} else {
			context.directory = context.basedir;
		}

		if (settings.profile == "gobject-2.0" || settings.profile == "gobject" || settings.profile == null) {
			context.profile = Profile.GOBJECT;
			context.add_define ("GOBJECT");
		}

		if (settings.defines != null) {
			foreach (string define in settings.defines) {
				context.add_define (define);
			}
		}

		if (context.profile == Profile.POSIX) {
			/* default package */
			if (!add_package ("posix")) {
				Report.error (null, "posix not found in specified Vala API directories");
			}
		}
		else if (context.profile == Profile.GOBJECT) {
			int glib_major = 2;
			int glib_minor = 12;


			context.target_glib_major = glib_major;
			context.target_glib_minor = glib_minor;
			if (context.target_glib_major != 2) {
				Report.error (null, "This version of valac only supports GLib 2");
			}

			/* default packages */
			if (!this.add_package ("glib-2.0")) { //
				Report.error (null, "glib-2.0 not found in specified Vala API directories");
			}

			if (!this.add_package ("gobject-2.0")) { //
				Report.error (null, "gobject-2.0 not found in specified Vala API directories");
			}
		}
	}


	private bool add_package (string pkg) {
		if (context.has_package (pkg)) {
			// ignore multiple occurences of the same package
			return true;
		}
	
		var package_path = context.get_package_path (pkg, settings.vapi_directories);
		
		if (package_path == null) {
			return false;
		}

		context.add_package (pkg);


		var vfile = new SourceFile (context, package_path, true);
		context.add_source_file (vfile);

		Package vdpkg = new Package (this.settings, vfile, this, true);
		this.packages.add (vdpkg);

		var deps_filename = Path.build_filename (Path.get_dirname (package_path), "%s.deps".printf (pkg));
		if (FileUtils.test (deps_filename, FileTest.EXISTS)) {
			try {
				string deps_content;
				ulong deps_len;
				FileUtils.get_contents (deps_filename, out deps_content, out deps_len);
				foreach (string dep in deps_content.split ("\n")) {
					dep.strip ();
					if (dep != "") {
						if (!add_package (dep)) {
							Report.error (null, "%s, dependency of %s, not found in specified Vala API directories".printf (dep, pkg));
						}
					}
				}
			} catch (FileError e) {
				Report.error (null, "Unable to read dependency file: %s".printf (e.message));
			}
		}
		
		return true;
	}


	public void add_depencies (string[] packages) {
		foreach (string package in packages) {
			if (!add_package (package)) {
				Report.error (null, "%s not found in specified Vala API directories".printf (package));
			}
		}
	}

	public void add_documented_file (string[] sources) {
		if (sources == null) {
			return ;
		}

		foreach (string source in sources) {
			if (FileUtils.test (source, FileTest.EXISTS)) {
				var rpath = realpath (source);
				if (source.has_suffix (".vala") || source.has_suffix (".gs")) {
					var source_file = new SourceFile (context, rpath);
					Package vdpkg = new Package (this.settings, source_file, this, false); 
					this.packages.add (vdpkg);

					if (context.profile == Profile.POSIX) {
						// import the Posix namespace by default (namespace of backend-specific standard library)
						source_file.add_using_directive (new UsingDirective (new UnresolvedSymbol (null, "Posix", null)));
					} else if (context.profile == Profile.GOBJECT) {
						// import the GLib namespace by default (namespace of backend-specific standard library)
						source_file.add_using_directive (new UsingDirective (new UnresolvedSymbol (null, "GLib", null)));
					}

					context.add_source_file (source_file);
				} else if (source.has_suffix (".vapi")) {
					var vfile = new SourceFile (context, rpath, true);
					Package vdpkg = new Package (this.settings, vfile, this, true); 
					context.add_source_file (vfile);
					this.packages.add (vdpkg);
				} else if (source.has_suffix (".c")) {
					context.add_c_source_file (rpath);
				} else {
					Report.error (null, "%s is not a supported source file type. Only .vala, .vapi, .gs, and .c files are supported.".printf (source));
				}
			} else {
				Report.error (null, "%s not found".printf (source));
			}
		}
	}

	public bool create_tree ( ) {
		Vala.Parser parser  = new Vala.Parser ();
		parser.parse ( this.context );
		if (this.context.report.get_errors () > 0) {
			return false;
		}

		Vala.SymbolResolver resolver = new SymbolResolver ();
		resolver.resolve( this.context );
		if (this.context.report.get_errors () > 0) {
			return false;
		}

		Vala.SemanticAnalyzer analyzer = new SemanticAnalyzer ( );
		analyzer.analyze( this.context );
		if (this.context.report.get_errors () > 0) {
			return false;
		}

		if ( context.non_null_experimental ) {
			Vala.NullChecker null_checker = new NullChecker ();
			null_checker.check ( this.context );

			if (this.context.report.get_errors () > 0) {
				return false;
			}
		}

		this.context.accept( this );
		this.set_type_references ( );
		this.inheritance ( ); // add a switch
		this.add_dependencies_to_source_package ();
		return true;
	}

	// internal
	public Package? find_file ( Vala.SourceFile vfile ) {
		foreach ( Package pkg in this.packages ) {
			if ( pkg.is_vpackage( vfile ) )
				return pkg;
		}
		return null;
	}

	private void set_type_references ( ) {
		foreach ( Package pkg in this.packages ) {
			pkg.set_type_references( );
		}
	}

	private void inheritance ( ) {
		foreach ( Package pkg in this.packages ) {
			pkg.inheritance( );
		}
	}

	public void parse_comments ( Valadoc.Parser docparser ) {
		this.wikitree = new WikiPageTree( this.reporter, this.settings );
		wikitree.create_tree ( docparser );

		foreach ( Package pkg in this.packages ) {
			pkg.parse_comments( docparser );
		}
	}

	// internal
	public DocumentedElement? search_vala_symbol ( Vala.Symbol? vnode ) {
		if ( vnode == null )
			return null;

		Gee.ArrayList<Vala.Symbol> params = new Gee.ArrayList<Vala.Symbol> ();
		for ( Vala.Symbol iter = vnode; iter != null ; iter = iter.parent_symbol ) {
			if ( iter is Vala.DataType )
				params.insert ( 0, ((Vala.DataType)iter).data_type );
			else
				params.insert ( 0, iter );
		}

		if ( params.size == 0 )
			return null;

		if ( params.size >= 2 ) {
			if ( params.get(1) is Vala.Namespace ) {
				params.remove_at ( 0 );
			}
		}

		Vala.SourceFile vfile = vnode.source_reference.file;
		Package file = this.find_file( vfile );

		return file.search_element_vala ( params, 0 );
	}

	private Package? get_external_package_by_name ( string name ) {
		foreach ( Package pkg in this.packages ) {
			if ( name == pkg.name ) {
				return pkg;
			}
		}
		return null;
	}

}

