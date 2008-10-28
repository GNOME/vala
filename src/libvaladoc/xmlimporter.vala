

using GLib;
using Xml;


public class Valadoc.MergeExternalDocumentation : ExternalDocumentation {
	private GLib.Queue<string> stack = new GLib.Queue<string> ();

	public Valadoc.Tree tree {
		construct set;
		private get;
	}

	public MergeExternalDocumentation ( Valadoc.Tree tree ) {
		this.tree = tree;
	}

	private string? type_path () {
		GLib.StringBuilder str = new GLib.StringBuilder ();

		for ( weak GLib.List<string> pos = this.stack.head; pos != null ; pos = pos.next ) {
			str.prepend ( pos.data );
			if ( pos.next != null )
				str.prepend_unichar ( '.' );
		}
		return str.str;
	}


	public override bool visit_enumvalue_start ( string name ) {
		this.stack.push_head ( name );
		return true;
	}

	public override bool visit_enumvalue_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}


	public override bool visit_errorcode_start ( string name ) {
		this.stack.push_head ( name );
		return true;
	}
 
	public override bool visit_errorcode_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}

	public override bool visit_field_start ( string name ) {
		this.stack.push_head ( name );

		Valadoc.Basic? element = this.tree.search_symbol_str ( null, this.type_path() );
		if ( element == null )
			return false;


		element.comment_string = "*\n * HOHOHOHOHOHOHOHO\n ";


		this.stack.pop_head ( );
		return true;
	}

	public override bool visit_field_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}

	public override bool visit_signal_start ( string name ) {
		this.stack.push_head ( name );
		return true;
	}

	public override bool visit_signal_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}

	public override bool visit_method_start ( string name ) {
		this.stack.push_head ( name );
		return true;
	}

	public override bool visit_method_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}

	public override bool visit_constant_start ( string name ) {
		this.stack.push_head ( name );
		return true;
	}

	public override bool visit_constant_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}

	public override bool visit_property_start ( string name ) {
		this.stack.push_head ( name );
		return true;
	}

	public override bool visit_property_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}

	public override bool visit_delegate_start ( string name ) {
		this.stack.push_head ( name );
		return true;
	}

	public override bool visit_delegate_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}

	public override bool visit_errordomain_start ( string name ) {
		this.stack.push_head ( name );
		return true;
	}

	public override bool visit_errordomain_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}

	public override bool visit_class_start ( string name ) {
		this.stack.push_head ( name );
		return true;
	}

	public override bool visit_class_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}

	public override bool visit_struct_start ( string name ) {
		this.stack.push_head ( name );
		return true;
	}

	public override bool visit_struct_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}

	public override bool visit_interface_start ( string name ) {
		this.stack.push_head ( name );
		return true;
	}

	public override bool visit_interface_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}

	public override bool visit_namespace_start ( string name ) {
		if ( name != "" )
			this.stack.push_head ( name );

		stdout.printf ( "Namespace: %s\n", name );
		return true;
	}

	public override bool visit_namespace_end ( string name ) {
		if ( name != "" )
			this.stack.pop_head ( );

		return true;
	}

	public override bool visit_enum_start ( string name ) {
		this.stack.push_head ( name );
		return true;
	}

	public override bool visit_enum_end ( string name ) {
		this.stack.pop_head ( );
		return true;
	}
}

