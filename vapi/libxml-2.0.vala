/* libxml2.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

namespace Xml {
	[ReferenceType (free_function = "xmlFreeTextReader")]
	[CCode (cname = "xmlTextReader", cheader_filename = "libxml/xmlreader.h")]
	public struct TextReader {
		[CCode (cname = "xmlNewTextReaderFilename")]
		public TextReader.with_filename (string uri);
		
		[CCode (cname = "xmlReaderForFile")]
		public TextReader.from_file (string filename, string encoding, int options);
		
		[CCode (cname = "xmlTextReaderRead")]
		public int read ();
		
		[CCode (cname = "xmlTextReaderReadString")]
		public string read_string ();
		
		[CCode (cname = "xmlTextReaderClose")]
		public int close ();
		
		[CCode (cname = "xmlTextReaderIsValid")]
		public int is_valid ();
		
		[CCode (cname = "xmlFreeTextReader")]
		public void free ();
		
		[CCode (cname = "xmlTextReaderReadState")]
		public int read_state ();
		
		[CCode (cname = "xmlTextReaderNodeType")]
		public ReaderType node_type ();
		
		[CCode (cname = "xmlTextReaderConstLocalName")]
		public weak string local_name ();
		
		[CCode (cname = "xmlTextReaderConstName")]
		public weak string name ();
		
		[CCode (cname = "xmlTextReaderConstNamespaceUri")]
		public weak string namespace_uri ();
		
		[CCode (cname = "xmlTextReaderConstPrefix")]
		public weak string prefix ();
		
		[CCode (cname = "xmlTextReaderConstValue")]
		public weak string @value ();
		
		[CCode (cname = "xmlTextReaderDepth")]
		public int depth ();
		
		[CCode (cname = "xmlTextReaderIsEmptyElement")]
		public int is_empty_element ();
		
		[CCode (cname = "xmlTextReaderHasValue")]
		public int has_value ();		
	}

	[CCode (cname = "xmlTextReaderMode", cheader_filename = "liReaderTypesReaderTypesbxml/xmlreader.h")]
	public enum ReaderMode {
		INITIAL,
		INTERACTIVE,
		ERROR,
		EOF,
		CLOSED,
		READING
	}
	
	[CCode (cname = "xmlReaderTypes",  cheader_filename = "libxml/xmlreader.h")]
	public enum ReaderType {
		NONE,
		ELEMENT,
		ATTRIBUTE,
		TEXT,
		CDATA,
		ENTITY_REFERENCE,
		ENTITY,
		PROCESSING_INSTRUCTION,
		COMMENT,
		DOCUMENT,
		DOCUMENT_TYPE,
		DOCUMENT_FRAGMENT,
		NOTATION,
		WHITESPACE,
		SIGNIFICANT_WHITESPACE,
		END_ELEMENT,
		END_ENTITY,
		XML_DECLARATION
	}
}
