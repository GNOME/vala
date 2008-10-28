

using GLib;
using Xml;



public class Valadoc.ExternalDocumentation : GLib.Object {
	public virtual bool visit_namespace_start ( string name ) {
		return true;
	}

	public virtual bool visit_namespace_end ( string name ) {
		return true;
	}

	public virtual bool visit_enum_start ( string name ) {
		return true;
	}

	public virtual bool visit_enum_end ( string name ) {
		return true;
	}

	public virtual bool visit_enumvalue_start ( string name ) {
		return true;
	}

	public virtual bool visit_enumvalue_end ( string name ) {
		return true;
	}

	public virtual bool visit_errordomain_start ( string name ) {
		return true;
	}

	public virtual bool visit_errordomain_end ( string name ) {
		return true;
	}

	public virtual bool visit_errorcode_start ( string name ) {
		return true;
	}
 
	public virtual bool visit_errorcode_end ( string name ) {
		return true;
	}

	public virtual bool visit_field_start ( string name ) {
		return true;
	}

	public virtual bool visit_field_end ( string name ) {
		return true;
	}

	public virtual bool visit_signal_start ( string name ) {
		return true;
	}

	public virtual bool visit_signal_end ( string name ) {
		return true;
	}

	public virtual bool visit_method_start ( string name ) {
		return true;
	}

	public virtual bool visit_method_end ( string name ) {
		return true;
	}

	public virtual bool visit_class_start ( string name ) {
		return true;
	}

	public virtual bool visit_class_end ( string name ) {
		return true;
	}

	public virtual bool visit_constant_start ( string name ) {
		return true;
	}

	public virtual bool visit_constant_end ( string name ) {
		return true;
	}

	public virtual bool visit_property_start ( string name ) {
		return true;
	}

	public virtual bool visit_property_end ( string name ) {
		return true;
	}

	public virtual bool visit_delegate_start ( string name ) {
		return true;
	}

	public virtual bool visit_delegate_end ( string name ) {
		return true;
	}

	public virtual bool visit_struct_start ( string name ) {
		return true;
	}

	public virtual bool visit_struct_end ( string name ) {
		return true;
	}

	public virtual bool visit_interface_start ( string name ) {
		return true;
	}

	public virtual bool visit_interface_end ( string name ) {
		return true;
	}



	// Comments:
	public virtual bool visit_comment_start () {
		stdout.printf ( "\n---------------\n" );
		return true;
	}

	public virtual bool visit_comment_tag_start ( string name ) {
		return true;
	}

	public virtual bool visit_comment_tag_end ( string name ) {
		return true;
	}

	public virtual bool visit_comment_inline_tag ( string name, string content ) {
		stdout.printf ( ">{ @%s, %s }", name, content );
		return true;
	}

	public virtual bool visit_comment_string ( string str ) {
		stdout.printf ( "%s", str );
		return true;
	}

	public virtual bool visit_comment_end () {
		stdout.printf ( "\n---------------\n" );
		return true;
	}

	private bool parse_description ( Xml.Node* desc ) {
		bool tmp = this.visit_comment_start ();
		if ( tmp == false )
			return false;

        for (Xml.Node* iter = desc->children; iter != null; iter = iter->next) {
            if (iter->type == ElementType.ELEMENT_NODE) {
				if ( iter->name != "inline-taglet" )
					return false;

				string? tagname = iter->get_prop ( "name" );
				if ( tagname == null )
					return false;

				string content = iter->get_content ();

				this.visit_comment_inline_tag ( tagname, content );
            }
			else if ( iter->type == ElementType.TEXT_NODE ) {
				string content = iter->get_content ();
				tmp = this.visit_comment_string ( content );
				if ( tmp == false )
					return false;
			}
        }

		return this.visit_comment_end ();
	}


	private bool check_name ( string str ) {
		return true;
	}


	private bool parse_field ( Xml.Node* field ) {
		string fname = field->get_prop ( "name" );
		if ( !this.check_name ( fname ) )
			return false;

		bool tmp = this.visit_field_start ( fname );
		if ( tmp == false )
			return false;

		for (Xml.Node* iter = field->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			bool tmp = true;

			switch ( iter->name ) {
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_field_end ( fname );
	}

	private bool parse_delegate ( Xml.Node* _delegate ) {
		string dname = _delegate->get_prop ( "name" );
		if ( !this.check_name ( dname ) )
			return false;

		bool tmp = this.visit_delegate_start ( dname );
		if ( tmp == false )
			return false;

		for (Xml.Node* iter = _delegate->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			bool tmp = false;

			switch ( iter->name ) {
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_delegate_end ( dname );
	}

	private bool parse_constant ( Xml.Node* constant ) {
		string cname = constant->get_prop ( "name" );
		if ( !this.check_name ( cname ) )
			return false;

		bool tmp = this.visit_constant_start ( cname );
		if ( tmp == false )
			return false;

		for (Xml.Node* iter = constant->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			bool tmp = false;

			switch ( iter->name ) {
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_constant_end ( cname );
	}

	private bool parse_method ( Xml.Node* method ) {
		string mname = method->get_prop ( "name" );
		if ( !this.check_name ( mname ) )
			return false;

		bool tmp = this.visit_method_start ( mname );
		if ( tmp == false )
			return false;

		for (Xml.Node* iter = method->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			bool tmp = false;

			switch ( iter->name ) {
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_method_end ( mname );
	}

	private bool parse_property ( Xml.Node* property ) {
		string pname = property->get_prop ( "name" );
		if ( !this.check_name ( pname ) )
			return false;

		bool tmp = this.visit_property_start ( pname );
		if ( tmp == false )
			return false;

		for (Xml.Node* iter = property->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			bool tmp = false;

			switch ( iter->name ) {
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_property_end ( pname );
	}

	private bool parse_signal ( Xml.Node* _signal ) {
		string sname = _signal->get_prop ( "name" );
		if ( !this.check_name ( sname ) )
			return false;

		bool tmp = this.visit_signal_start ( sname );
		if ( tmp == false )
			return false;

		for (Xml.Node* iter = _signal->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			bool tmp = false;

			switch ( iter->name ) {
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_signal_end ( sname );
	}

	private bool parse_errorcode ( Xml.Node* errorcode ) {
		string ename = errorcode->get_prop ( "name" );
		if ( !this.check_name ( ename ) )
			return false;

		bool tmp = this.visit_errorcode_start ( ename );
		if ( tmp == false )
			return false;

		for (Xml.Node* iter = errorcode->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			bool tmp = false;

			switch ( iter->name ) {
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_errorcode_end ( ename );
	}

	private bool parse_enumvalue ( Xml.Node* enumvalue ) {
		string ename = enumvalue->get_prop ( "name" );
		if ( !this.check_name ( ename ) )
			return false;

		for (Xml.Node* iter = enumvalue->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			bool tmp = false;

			switch ( iter->name ) {
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		bool tmp = this.visit_enumvalue_start ( ename );
		if ( tmp == false )
			return false;


		return this.visit_enumvalue_end ( ename );
	}

	private bool parse_class ( Xml.Node* _class ) {
		string cname = _class->get_prop ( "name" );
		if ( !this.check_name ( cname ) )
			return false;

		bool tmp = this.visit_class_start ( cname );
		if ( tmp == false )
			return false;

		for (Xml.Node* iter = _class->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			bool tmp = false;

			switch ( iter->name ) {
			case "class":
				tmp = this.parse_class ( iter );
				break;
			case "struct":
				tmp = this.parse_struct ( iter );
				break;
			case "constant":
				tmp = this.parse_constant ( iter );
				break;
			case "field":
				tmp = this.parse_field ( iter );
				break;
			case "enum":
				tmp = this.parse_enum ( iter );
				break;
			case "delegate":
				tmp = this.parse_delegate ( iter );
				break;
			case "method":
				tmp = this.parse_method ( iter );
				break;
			case "signal":
				tmp = this.parse_signal ( iter );
				break;
			case "property":
				tmp = this.parse_property ( iter );
				break;
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_class_end ( cname );
	}

	private bool parse_struct ( Xml.Node* _struct ) {
		string sname = _struct->get_prop ( "name" );
		if ( !this.check_name ( sname ) )
			return false;

		bool tmp = this.visit_struct_start ( sname );
		if ( tmp == false )
			return false;

		for (Xml.Node* iter = _struct->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			bool tmp = false;

			switch ( iter->name ) {
			case "constant":
				tmp = this.parse_constant ( iter );
				break;
			case "field":
				tmp = this.parse_field ( iter );
				break;
			case "method":
				tmp = this.parse_method ( iter );
				break;
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_struct_end ( sname );
	}

	private bool parse_interface ( Xml.Node* _interface ) {
		string iname = _interface->get_prop ( "name" );
		if ( !this.check_name ( iname ) )
			return false;

		bool tmp = this.visit_interface_start ( iname );
		if ( tmp == false )
			return false;


		for (Xml.Node* iter = _interface->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			tmp = false;

			switch ( iter->name ) {
			case "class":
				tmp = this.parse_class ( iter );
				break;
			case "struct":
				tmp = this.parse_struct ( iter );
				break;
			case "field":
				tmp = this.parse_field ( iter );
				break;
			case "enum":
				tmp = this.parse_enum ( iter );
				break;
			case "delegate":
				tmp = this.parse_delegate ( iter );
				break;
			case "method":
				tmp = this.parse_method ( iter );
				break;
			case "signal":
				tmp = this.parse_signal ( iter );
				break;
			case "property":
				tmp = this.parse_property ( iter );
				break;
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_interface_end ( iname );
	}

	private bool parse_enum ( Xml.Node* _enum ) {
		string ename = _enum->get_prop ( "name" );
		if ( !this.check_name ( ename ) )
			return false;

		bool tmp = this.visit_enum_start ( ename );
		if ( tmp == false )
			return false;


		for (Xml.Node* iter = _enum->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			tmp = false;

			switch ( iter->name ) {
			case "enumvalue":
				tmp = this.parse_enumvalue ( iter );
				break;
			case "method":
				tmp = this.parse_method ( iter );
				break;
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_enum_end ( ename );
	}

	private bool parse_errordomain ( Xml.Node* _errordomain ) {
		string ename = _errordomain->get_prop ( "name" );
		if ( !this.check_name ( ename ) )
			return false;

		bool tmp = this.visit_errordomain_start ( ename );
		if ( tmp == false )
			return false;


		for (Xml.Node* iter = _errordomain->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			tmp = false;

			switch ( iter->name ) {
			case "errorcode":
				tmp = this.parse_errorcode ( iter );
				break;
			case "method":
				tmp = this.parse_method ( iter );
				break;
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_errordomain_end ( ename );
	}

	private bool parse_namespace ( Xml.Node* ns ) {
		string nsname = ns->get_prop ( "name" );
		if ( nsname == null ) {
			stdout.printf ( "Namespace-name is not set.\n" );
			return false;
		}

		bool tmp = this.visit_namespace_start ( nsname );
		if ( tmp == false )
			return false;

		for (Xml.Node* iter = ns->children; iter != null; iter = iter->next) {
			if (iter->type != ElementType.ELEMENT_NODE)
				continue;

			tmp = false;

			switch ( iter->name ) {
			case "namespace":
				tmp = this.parse_namespace ( iter );
				break;
			case "delegate":
				tmp = this.parse_delegate ( iter );
				break;
			case "field":
				tmp = this.parse_field ( iter );
				break;
			case "constant":
				tmp = this.parse_constant ( iter );
				break;
			case "method":
				tmp = this.parse_method ( iter );
				break;
			case "class":
				tmp = this.parse_class ( iter );
				break;
			case "struct":
				tmp = this.parse_struct ( iter );
				break;
			case "interface":
				tmp = this.parse_interface ( iter );
				break;
			case "enum":
				tmp = this.parse_enum ( iter );
				break;
			case "errordomain":
				tmp = this.parse_errordomain ( iter );
				break;
			case "description":
				tmp = this.parse_description ( iter );
				break;
			}

			if ( tmp == false )
				return false;
		}

		return this.visit_namespace_end ( nsname );
	}

	public bool parse ( string path ) {
		Xml.Doc* xml_doc = Xml.Parser.parse_file ( path );
		if ( xml_doc == null ) {
			stderr.printf ( "Can't open file.\n" );
			delete xml_doc;
			return false;
		}

		Xml.Node* root_node = xml_doc->get_root_element ();
		if ( root_node == null ) {
			stderr.printf ( "Missing root-element.\n" );
			delete xml_doc;
			return false;
		}

		if ( root_node->name != "namespace" ) {
			stderr.printf ( "Wrong root-element.\n" );
			delete xml_doc;
			return false;
		}

		bool tmp = this.parse_namespace ( root_node );
		if ( tmp == false ) {
			stdout.printf ( "Error.\n" );
		}

		delete xml_doc;
		return true;
	}
}


