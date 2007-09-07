/* libxml2.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini, Michael Lawrence
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 *	Michael Lawrence <lawremi@iastate.edu>
 */

namespace Xml {
	[CCode (free_function = "xmlFreeTextReader", cname = "xmlTextReader", cheader_filename = "libxml/xmlreader.h")]
	public class TextReader {
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

	[CCode (cname = "xmlTextReaderMode", cheader_filename = "libxml/xmlreader.h")]
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

	[CCode (cname = "ftpDataCallback", cheader_filename = "libxml/nanoftp.h")]
	[NoArrayLength]
	public static delegate void FtpDataCallback (pointer userData, char[] data, int len);
	[CCode (cname = "ftpListCallback", cheader_filename = "libxml/nanoftp.h")]
	public static delegate void FtpListCallback (pointer userData, string filename, string attrib, string owner, string group, ulong size, int links, int year, string month, int day, int hour, int minute);

	[CCode (free_function = "xmlNanoFTPFreeCtxt", cname = "gpointer", cheader_filename = "libxml/nanoftp.h")]
	public class NanoFTP {
		[CCode (cname = "xmlNanoFTPCheckResponse")]
		public int check_response ();
		[CCode (cname = "xmlNanoFTPCleanup")]
		public static void cleanup ();
		[CCode (cname = "xmlNanoFTPClose")]
		public int close ();
		[CCode (cname = "xmlNanoFTPCloseConnection")]
		public int close_connection ();
		[CCode (cname = "xmlNanoFTPConnect")]
		public int connect ();
		[CCode (cname = "xmlNanoFTPConnectTo")]
		public NanoFTP.connect_to_server (string server, int port);
		[CCode (cname = "xmlNanoFTPCwd")]
		public int cwd (string directory);
		[CCode (cname = "xmlNanoFTPDele")]
		public int dele (string file);
		[CCode (cname = "xmlNanoFTPGet")]
		public int get_file (FtpDataCallback cb, pointer userData, string filename);
		[CCode (cname = "xmlNanoFTPGetConnection")]
		public int get_connection ();
		[CCode (cname = "xmlNanoFTPGetResponse")]
		public int get_response ();
		[CCode (cname = "xmlNanoFTPGetSocket")]
		public int get_socket (string filename);
		[CCode (cname = "xmlNanoFTPInit")]
		public static void init ();
		[CCode (cname = "xmlNanoFTPList")]
		public int list (FtpListCallback cb, pointer userData, string filename);
		[CCode (cname = "xmlNanoFTPNewCtxt")]
		public NanoFTP (string URL);
		[CCode (cname = "xmlNanoFTPOpen")]
		public NanoFTP.connect_to_url (string URL);
		[CCode (cname = "xmlNanoFTPProxy")]
		public static void proxy (string host, int port, string user, string passwd, int type);
		[CCode (cname = "xmlNanoFTPQuit")]
		public int quit ();
		[CCode (cname = "xmlNanoFTPRead")]
		public int read (pointer dest, int len);
		[CCode (cname = "xmlNanoFTPScanProxy")]
		public static void scan_proxy (string URL);
		[CCode (cname = "xmlNanoFTPUpdateURL")]
		public int update_url (string URL);
	}

	[CCode (free_function = "xmlNanoHTTPClose", cname = "gpointer", cheader_filename = "libxml/nanohttp.h")]
	public class NanoHTTP {
		[CCode (cname = "xmlNanoHTTPAuthHeader")]
		public string auth_header ();

		[CCode (cname = "xmlNanoHTTPCleanup")]
		public static void cleanup ();

		[CCode (cname = "xmlNanoHTTPContentLength")]
		public int content_length ();

		[CCode (cname = "xmlNanoHTTPEncoding")]
		public string http_encoding ();

		[CCode (cname = "xmlNanoHTTPFetch")]
		public static int fetch (string URL, string filename, out string contentType);

		[CCode (cname = "xmlNanoHTTPInit")]
		public static void init ();

		[CCode (cname = "xmlNanoHTTPMethod")]
		public NanoHTTP.with_method (string URL, string method, string input, 
		out string contentType, string headers, int ilen);

		[CCode (cname = "xmlNanoHTTPMethodRedir")]
		public NanoHTTP.with_method_redir (string URL, string method, string input, out string contentType, out string redir, string headers, int ilen);

		[CCode (cname = "xmlNanoHTTPMimeType")]
		public string mime_type ();

		[CCode (cname = "xmlNanoHTTPOpen")]
		public NanoHTTP (string url, out string contentType);

		[CCode (cname = "xmlNanoHTTPOpenRedir")]
		public NanoHTTP.with_redir (string url, out string contentType, out string redir);

		[CCode (cname = "xmlNanoHTTPRead")]
		public int read (pointer dest, int len);

		[CCode (cname = "xmlNanoHTTPRedir")]
		public string redir ();

		[CCode (cname = "xmlNanoHTTPReturnCode")]
		public int return_code ();

		[CCode (cname = "xmlNanoHTTPSave")]
		public int save (string filename);

		[CCode (cname = "xmlNanoHTTPScanProxy")]
		public static void scan_proxy (string URL);
	}

	[CCode (free_function = "xmlFreeURI", cname = "xmlURI", cheader_filename = "libxml/uri.h")]
	public class URI {
		[CCode (cname = "xmlBuildRelativeURI")]
		public static string build_relative (string URI, string @base);
		[CCode (cname = "xmlBuildURI")]
		public static string build (string URI, string @base);
		[CCode (cname = "xmlCanonicPath")]
		public static string canonic_path (string path);
		[CCode (cname = "xmlNormalizeURIPath")]
		public static int normalize_uri_path (string path);
		[CCode (cname = "xmlPathToURI")]
		public static string path_to_uri (string path);

		[CCode (cname = "xmlCreateURI")]
		public URI ();
		[CCode (cname = "xmlParseURI")]
		public URI.parse (string str);
		[CCode (cname = "xmlParseURIRaw")]
		public URI.parse_raw (string str, int raw);

		[CCode (cname = "xmlParseURIReference")]
		public int parse_reference (string str);

		[CCode (cname = "xmlPrintURI")]
		[InstanceLast]
		public void print (GLib.FileStream stream);
		[CCode (cname = "xmlSaveUri")]
		public string save ();

		[CCode (cname = "xmlURIEscape")]
		public static string escape (string str);
		[CCode (cname = "xmlURIEscapeStr")]
		public static string escape_str (string str, string list);
		[CCode (cname = "xmlURIUnescapeString")]
		public static string unescape_string (string str, int len, string target);

		public weak string scheme;
		public weak string opaque;
		public weak string authority;
		public weak string server;
		public weak string user;
		public int port;
		public weak string path;
		public weak string query;
		public weak string fragment;
		public int cleanup;
	}

	/* SAX CALLBACKS */

	// public static delegate void attributeDeclSAXFunc (pointer ctx, string elem, string fullname, int type, int def, string defaultValue, Enumeration tree);

	public static delegate void attributeSAXFunc (pointer ctx, string name, string value);

	public static delegate void cdataBlockSAXFunc (pointer ctx, string value, int len);

	public static delegate void charactersSAXFunc (pointer ctx, string ch, int len);

	public static delegate void commentSAXFunc (pointer ctx, string value);

	// public static delegate void elementDeclSAXFunc (pointer ctx, string name, int type, ElementContent content);

	public static delegate void endDocumentSAXFunc (pointer ctx);

	public static delegate void endElementNsSAX2Func (pointer ctx, string localname, string prefix, string URI);

	public static delegate void endElementSAXFunc (pointer ctx, string name);

	public static delegate void entityDeclSAXFunc (pointer ctx, string name, int type, string publicId, string systemId, string content);

	public static delegate void errorSAXFunc (pointer ctx, string msg, ...);

	public static delegate void externalSubsetSAXFunc (pointer ctx, string name, string ExternalID, string SystemID);

	public static delegate void fatalErrorSAXFunc (pointer ctx, string msg, ...);

	// public static delegate xmlEntityPtr getEntitySAXFunc (pointer ctx, string name);

	// public static delegate xmlEntityPtr getParameterEntitySAXFunc (pointer ctx, string name);

	public static delegate int hasExternalSubsetSAXFunc (pointer ctx);

	public static delegate int hasInternalSubsetSAXFunc (pointer ctx);

	public static delegate void ignorableWhitespaceSAXFunc (pointer ctx, string ch, int len);

	public static delegate void internalSubsetSAXFunc (pointer ctx, string name, string ExternalID, string SystemID);

	public static delegate int isStandaloneSAXFunc (pointer ctx);

	public static delegate void notationDeclSAXFunc (pointer ctx, string name, string publicId, string systemId);

	public static delegate void processingInstructionSAXFunc (pointer ctx, string target, string data);

	public static delegate void referenceSAXFunc (pointer ctx, string name);

	// public static delegate ParserInput resolveEntitySAXFunc (pointer ctx, string publicId, string systemId);

	// public static delegate void setDocumentLocatorSAXFunc (pointer ctx, SAXLocator loc);

	public static delegate void startDocumentSAXFunc (pointer ctx);

	[NoArrayLength]
	public static delegate void startElementNsSAX2Func (pointer ctx, string localname, string prefix, string URI, int nb_namespaces, string[] namespaces, int nb_attributes, int nb_defaulted, string[] attributes);

	[NoArrayLength]
	public static delegate void startElementSAXFunc (pointer ctx, string name, string[] atts);

	public static delegate void unparsedEntityDeclSAXFunc (pointer ctx, string name, string publicId, string systemId, string notationName);

	public static delegate void warningSAXFunc (pointer ctx, string msg, ...);

	[CCode (cname = "xmlSAXHandler")]
	public class SAXHandler {
		public internalSubsetSAXFunc internalSubset;
		public isStandaloneSAXFunc isStandalone;
		public hasInternalSubsetSAXFunc hasInternalSubset;
		public hasExternalSubsetSAXFunc hasExternalSubset;
		// public resolveEntitySAXFunc resolveEntity;
		// public getEntitySAXFunc getEntity;
		public entityDeclSAXFunc entityDecl;
		public notationDeclSAXFunc notationDecl;
		// public attributeDeclSAXFunc attributeDecl;
		// public elementDeclSAXFunc elementDecl;
		public unparsedEntityDeclSAXFunc unparsedEntityDecl;
		// public setDocumentLocatorSAXFunc setDocumentLocator;
		public startDocumentSAXFunc startDocument;
		public endDocumentSAXFunc endDocument;
		public startElementSAXFunc startElement;
		public endElementSAXFunc endElement;
		public referenceSAXFunc reference;
		public charactersSAXFunc characters;
		public ignorableWhitespaceSAXFunc ignorableWhitespace;
		public processingInstructionSAXFunc processingInstruction;
		public commentSAXFunc comment;
		public warningSAXFunc warning;
		public errorSAXFunc error;
		public fatalErrorSAXFunc  fatalError;
		// public getParameterEntitySAXFunc getParameterEntity;
		public cdataBlockSAXFunc cdataBlock;
		public externalSubsetSAXFunc externalSubset;
		public uint initialized;
		public startElementNsSAX2Func startElementNs;
		public endElementNsSAX2Func endElementNs;
		// public xmlStructuredErrorFunc serror;
 	}

	[CCode (free_function = "xmlFreeParserCtxt", cname = "xmlSAXHandler")]
	public class ParserCtxt {
		public weak SAXHandler sax;
		public weak pointer userData;

		[CCode (cname = "xmlParseDocument")]
		public int parse_document();
	}
}
