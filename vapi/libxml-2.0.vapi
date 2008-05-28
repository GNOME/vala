/* libxml2.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini, Michael Lawrence
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
 *	Ondřej Jirman <megous@megous.com>
 */

namespace Xml {
	/* nanoftp - minimal FTP implementation */

	[CCode (cname = "ftpDataCallback", cheader_filename = "libxml/nanoftp.h")]
	[NoArrayLength]
	public static delegate void FtpDataCallback (void* userData, char[] data, int len);

	[CCode (cname = "ftpListCallback", cheader_filename = "libxml/nanoftp.h")]
	public static delegate void FtpListCallback (void* userData, string filename, string attrib, string owner, string group, ulong size, int links, int year, string month, int day, int hour, int minute);

	[Compact]
	[CCode (cname = "void", free_function = "xmlNanoFTPFreeCtxt", cheader_filename = "libxml/nanoftp.h")]
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
		public static NanoFTP* connect_to (string server, int port);

		[CCode (cname = "xmlNanoFTPCwd")]
		public int cwd (string directory);

		[CCode (cname = "xmlNanoFTPDele")]
		public int dele (string file);

		[CCode (cname = "xmlNanoFTPGet")]
		public int get (FtpDataCallback cb, void* user_data, string filename);

		[CCode (cname = "xmlNanoFTPGetConnection")]
		public int get_connection ();

		[CCode (cname = "xmlNanoFTPGetResponse")]
		public int get_response ();

		[CCode (cname = "xmlNanoFTPGetSocket")]
		public int get_socket (string filename);

		[CCode (cname = "xmlNanoFTPInit")]
		public static void init ();

		[CCode (cname = "xmlNanoFTPList")]
		public int list (FtpListCallback cb, void* user_data, string filename);

		[CCode (cname = "xmlNanoFTPNewCtxt")]
		public NanoFTP (string url);

		[CCode (cname = "xmlNanoFTPOpen")]
		public static NanoFTP* open (string url);

		[CCode (cname = "xmlNanoFTPProxy")]
		public static void proxy (string host, int port, string user, string passwd, int type);

		[CCode (cname = "xmlNanoFTPQuit")]
		public int quit ();

		[CCode (cname = "xmlNanoFTPRead")]
		public int read (void* dest, int len);

		[CCode (cname = "xmlNanoFTPScanProxy")]
		public static void scan_proxy (string url);

		[CCode (cname = "xmlNanoFTPUpdateURL")]
		public int update_url (string url);
	}


	/* nanohttp - minimal HTTP implementation */

	[Compact]
	[CCode (cname = "void", cheader_filename = "libxml/nanohttp.h")]
	public class NanoHTTP {
		[CCode (cname = "xmlNanoHTTPAuthHeader")]
		public weak string auth_header ();

		[CCode (cname = "xmlNanoHTTPCleanup")]
		public static void cleanup ();

		[CCode (cname = "xmlNanoHTTPClose")]
		public int close ();

		[CCode (cname = "xmlNanoHTTPContentLength")]
		public int content_length ();

		[CCode (cname = "xmlNanoHTTPEncoding")]
		public weak string http_encoding ();

		[CCode (cname = "xmlNanoHTTPFetch")]
		public static int fetch (string url, string filename, out string content_type);

		[CCode (cname = "xmlNanoHTTPInit")]
		public static void init ();

		[CCode (cname = "xmlNanoHTTPMethod")]
		public static NanoHTTP* method (string url, string method, string input, out string content_type, string headers, int ilen);

		[CCode (cname = "xmlNanoHTTPMethodRedir")]
		public static NanoHTTP* method_redir (string url, string method, string input, out string content_type, out string redir, string headers, int ilen);

		[CCode (cname = "xmlNanoHTTPMimeType")]
		public string mime_type ();

		[CCode (cname = "xmlNanoHTTPOpen")]
		public static NanoHTTP* open (string url, out string content_type);

		[CCode (cname = "xmlNanoHTTPOpenRedir")]
		public static NanoHTTP* open_redir (string url, out string content_type, out string redir);

		[CCode (cname = "xmlNanoHTTPRead")]
		public int read (void* dest, int len);

		[CCode (cname = "xmlNanoHTTPRedir")]
		public weak string redir ();

		[CCode (cname = "xmlNanoHTTPReturnCode")]
		public int return_code ();

		[CCode (cname = "xmlNanoHTTPSave")]
		public int save (string filename);

		[CCode (cname = "xmlNanoHTTPScanProxy")]
		public static void scan_proxy (string URL);
	}


	/* parser - the core parser module */

	[CCode (cheader_filename = "libxml/parser.h")]
	namespace Parser {
		[CCode (cname = "xmlCleanupParser")]
		public static void cleanup ();

		[CCode (cname = "xmlInitParser")]
		public static void init ();

		[CCode (cname = "xmlParseDoc")]
		public static Doc* parse_doc (string cur);

		[CCode (cname = "xmlParseFile")]
		public static Doc* parse_file (string filename);

		[CCode (cname = "xmlParseMemory")]
		public static Doc* parse_memory (string buffer, int size);

		[CCode (cname = "xmlReadDoc")]
		public static Doc* read_doc (string cur, string? url = null, string? encoding = null, int options = 0);

		[CCode (cname = "xmlReadFd")]
		public static Doc* read_fd (int fd, string? base_url = null, string? encoding = null, int options = 0);

		[CCode (cname = "xmlReadFile")]
		public static Doc* read_file (string filename, string? encoding = null, int options = 0);

		[CCode (cname = "xmlReadMemory")]
		public static Doc* read_memory (string text, int len, string? url = null, string? encoding = null, int options = 0);
	}

	[CCode (cname = "xmlParserOption", cprefix = "XML_PARSE_", cheader_filename = "libxml/parser.h")]
	public enum ParserOption {
		RECOVER,
		NOENT,
		DTDLOAD,
		DTDATTR,
		DTDVALID,
		NOERROR,
		NOWARNING,
		PEDANTIC,
		NOBLANKS,
		SAX1,
		XINCLUDE,
		NONET,
		NODICT,
		NSCLEAN,
		NOCDATA,
		NOXINCNODE,
		COMPACT,
	}


	/* tree - interfaces for tree manipulation */

	[CCode (cheader_filename = "libxml/tree.h")]
	namespace Tree {
		[CCode (cname = "xmlGetCompressMode")]
		public static int get_compress_mode ();

		[CCode (cname = "xmlIsXHTML")]
		public static int is_xhtml (string system_id, string public_id);

		[CCode (cname = "xmlSetCompressMode")]
		public static void set_compress_mode (int mode);
	}

	[Compact]
	[CCode (cname = "xmlAttr", cheader_filename = "libxml/tree.h")]
	public class Attr {
		public ElementType type;
		public weak string name;
		public Node* children;
		public Node* last;
		public Node* parent;
		public Attr* next;
		public Attr* prev;
		public Doc* doc;
		public Ns* ns;
		public AttributeType atype;

		[CCode (cname = "xmlRemoveProp")]
		public int remove();
	}

	[Compact]
	[CCode (cname = "xmlAttribute", cheader_filename = "libxml/tree.h")]
	public class Attribute {
		public ElementType type;
		public weak string name;
		public Node* children;
		public Node* last;
		public Dtd* parent;
		public Node* next;
		public Node* prev;
		public Doc* doc;
		public Attribute* nexth;
		public AttributeType atype;
		public AttributeDefault def;
		public weak string default_value;
		public weak string prefix;
		public weak string elem;
	}

	[CCode (cname = "xmlAttributeDefault", cprefix = "XML_ATTRIBUTE_", cheader_filename = "libxml/tree.h")]
	public enum AttributeDefault {
		NONE,
		REQUIRED,
		IMPLIED,
		FIXED
	}

	[CCode (cname = "xmlAttributeType", cprefix = "XML_ATTRIBUTE_", cheader_filename = "libxml/tree.h")]
	public enum AttributeType {
		CDATA,
		ID,
		IDREF ,
		IDREFS,
		ENTITY,
		ENTITIES,
		NMTOKEN,
		NMTOKENS,
		ENUMERATION,
		NOTATION
	}

	[Compact]
	[CCode (cname = "xmlDoc", free_function = "xmlFreeDoc", cheader_filename = "libxml/tree.h,libxml/parser.h")]
	public class Doc {
		public ElementType type;
		public string name;
		public Node* children;
		public Node* last;
		public Node* parent;
		public Node* next;
		public Node* prev;
		public Doc* doc;
		public int compression;
		public int standalone;
		public Dtd* int_subset;
		public Dtd* ext_subset;
		public Ns* old_ns;
		public weak string version;
		public weak string encoding;
		public weak string url;
		public int charset;

		[CCode (cname = "xmlCopyDoc")]
		public Doc* copy (int recursive);

		[CCode (cname = "xmlCreateIntSubset")]
		public Dtd* create_int_subset (string name, string external_id, string system_id);

		[CCode (cname = "xmlDocDump")]
		public static int dump (GLib.FileStream f, Doc* cur);

		[CCode (cname = "xmlDocDumpFormatMemory")]
		public void dump_memory_format (out string mem, out int len = null, bool format = true);

		[CCode (cname = "xmlDocDumpFormatMemoryEnc")]
		public void dump_memory_enc_format (out string mem, out int len = null, string enc = "UTF-8", bool format = true);

		[CCode (cname = "xmlDocDumpMemory")]
		public void dump_memory (out string mem, out int len = null);

		[CCode (cname = "xmlDocDumpMemoryEnc")]
		public void dump_memory_enc (out string mem, out int len = null, string enc = "UTF-8");

		[CCode (cname = "xmlDocFormatDump")]
		public static int dump_format (GLib.FileStream f, Doc* cur, bool format = true);

		[CCode (cname = "xmlDocGetRootElement")]
		public Node* get_root_element();

		[CCode (cname = "xmlDocSetRootElement")]
		public Node* set_root_element(Node* root);

		[CCode (cname = "xmlElemDump")]
		public static void elem_dump (GLib.FileStream f, Doc* doc, Node* cur);

		[CCode (cname = "xmlGetDocCompressMode")]
		public int get_compress_mode ();

		[CCode (cname = "xmlNewCDataBlock")]
		public Node* new_cdata_block (string content, int len);

		[CCode (cname = "xmlNewCharRef")]
		public Node* new_char_ref (string name);

		[CCode (cname = "xmlNewDoc")]
		public Doc (string version);

		[CCode (cname = "xmlNewDocComment")]
		public Node* new_comment (string content);

		[CCode (cname = "xmlNewDocFragment")]
		public Node* new_fragment ();

		[CCode (cname = "xmlNewDocNode")]
		public Node* new_node (Ns* ns, string name, string? content = null);

		[CCode (cname = "xmlNewDocNodeEatName")]
		public Node* new_node_eat_name (Ns* ns, string# name, string? content = null);

		[CCode (cname = "xmlNewDocPI")]
		public Node* new_pi (string name, string content);

		[CCode (cname = "xmlNewDocProp")]
		public Attr* new_prop (string name, string value);

		[CCode (cname = "xmlNewDocRawNode")]
		public Node* new_raw_node (Ns* ns, string name, string content);

		[CCode (cname = "xmlNewDocText")]
		public Node* new_text (string content);

		[CCode (cname = "xmlNewDocTextLen")]
		public Node* new_text_len (string content, int len);

		[CCode (cname = "xmlNewReference")]
		public Node* new_reference (string name);

		[CCode (cname = "xmlNodeListGetRawString")]
		public string node_list_get_raw_string (Node* list, int _inline);

		[CCode (cname = "xmlNodeListGetString")]
		public string node_list_get_string (Node* list, int _inline);

		[InstanceLast]
		[CCode (cname = "xmlSaveFile")]
		public int save_file (string filename);

		[CCode (cname = "xmlSaveFileEnc")]
		public static void save_file_enc (string filename, Doc* cur, string enc = "UTF-8");

		[CCode (cname = "xmlSaveFormatFile")]
		public static void save_format_file (string filename, Doc* cur, int format);

		[CCode (cname = "xmlSaveFormatFileEnc")]
		public static void save_format_file_enc (string filename, Doc* cur, string enc, int format);

		[CCode (cname = "xmlSetDocCompressMode")]
		public void set_compress_mode (int mode);

		[CCode (cname = "xmlStringGetNodeList")]
		public Node* string_get_node_list (string str);

		[CCode (cname = "xmlStringLenGetNodeList")]
		public Node* string_len_get_node_list (string str, int len);
	}

	[Compact]
	[CCode (cname = "xmlDtd", cheader_filename = "libxml/tree.h")]
	public class Dtd {
		public ElementType type;
		public string name;
		public Node* children;
		public Node* last;
		public Node* parent;
		public Node* next;
		public Node* prev;
		public Doc* doc;

		public weak string external_id;
		public weak string system_id;

		[CCode (cname = "xmlNewDtd")]
		public Dtd (Doc* doc, string name, string external_id, string system_id);

		[CCode (cname = "xmlCopyDtd")]
		public Dtd* copy();
	}

	[Compact]
	[CCode (cname = "xmlElement", cheader_filename = "libxml/tree.h")]
	public class Element {
		public ElementType type;
		public weak string name;
		public Node* children;
		public Node* last;
		public Dtd* parent;
		public Node* next;
		public Node* prev;
		public Doc* doc;
		public Attribute* attributes;
		public weak string prefix;
	}

	[CCode (cname = "xmlElementType", cprefix = "XML_", cheader_filename = "libxml/tree.h")]
	public enum ElementType {
		ELEMENT_NODE,
		ATTRIBUTE_NODE,
		TEXT_NODE,
		CDATA_SECTION_NODE,
		ENTITY_REF_NODE,
		ENTITY_NODE,
		PI_NODE,
		COMMENT_NODE,
		DOCUMENT_NODE,
		DOCUMENT_TYPE_NODE,
		DOCUMENT_FRAG_NODE,
		NOTATION_NODE,
		HTML_DOCUMENT_NODE,
		DTD_NODE,
		ELEMENT_DECL,
		ATTRIBUTE_DECL,
		ENTITY_DECL,
		NAMESPACE_DECL,
		XINCLUDE_START,
		XINCLUDE_END,
		DOCB_DOCUMENT_NODE
	}

	[Compact]
	[CCode (cname = "xmlElementContent", free_function = "xmlFreeElementContent", cheader_filename = "libxml/tree.h")]
	public class ElementContent {
		[CCode (cname = "xmlNewElementContent")]
		ElementContent (string name, ElementContentType type);

		public ElementContentType type;
		public ElementContentOccur ocur;
		public const string name;
		public ElementContent c1;
		public ElementContent c2;
		public ElementContent parent;
		public const string prefix;
	}

	[CCode (cname = "xmlElementContentType", cprefix = "XML_ELEMENT_CONTENT_", cheader_filename = "libxml/tree.h")]
	public enum ElementContentType {
		PCDATA,
		ELEMENT,
		SEQ,
		OR
	}

	[CCode (cname = "xmlElementContentOccur", cprefix = "XML_ELEMENT_CONTENT_", cheader_filename = "libxml/tree.h")]
	public enum ElementContentOccur {
		ONCE,
		OPT,
		MULT,
		PLUS
	}

	[Compact]
	[CCode (cname = "xmlEntity", cheader_filename = "libxml/tree.h")]
	public struct Entity {
		public void* private;
		public ElementType type;
		public const string name;
		public Node* children;
		public Node* last;
		public Dtd* parent;
		public Node* next;
		public Node* prev;
		public Doc* doc;
		public string orig;
		public string content;
		public int length;
		public EntityType etype;
		public const string ExternalID;
		public const string SystemID;
		public Entity* nexte;
		public const string URI;
		public int owner;
		public int checked;
	}

	[CCode (cname = "xmlEntityType", cprefix = "XML_", cheader_filename = "libxml/tree.h")]
	public enum EntityType {
		INTERNAL_GENERAL_ENTITY,
		EXTERNAL_GENERAL_PARSED_ENTITY,
		EXTERNAL_GENERAL_UNPARSED_ENTITY,
		INTERNAL_PARAMETER_ENTITY,
		EXTERNAL_PARAMETER_ENTITY,
		INTERNAL_PREDEFINED_ENTITY
	}

	[Compact]
	[CCode (cname = "xmlEnumeration", cheader_filename = "libxml/tree.h")]
	public struct Enumeration {
		public Enumeration* next;
		public const string name;
	}


	[Compact]
	[CCode (cname = "xmlNode", free_function = "xmlFreeNode", cheader_filename = "libxml/tree.h")]
	public class Node {
		public ElementType type;
		public weak string name;
		public Node* children;
		public Node* last;
		public Node* parent;
		public Node* next;
		public Node* prev;
		public Doc* doc;
		public Ns* ns;
		public string content;
		public Attr* properties;
		public Ns* ns_def;
		public ushort line;
		public ushort extra;

		[CCode (cname = "xmlAddChild")]
		public Node* add_child (Node* cur);

		[CCode (cname = "xmlAddChildList")]
		public Node* add_child_list (Node* cur);

		[CCode (cname = "xmlAddNextSibling")]
		public Node* add_next_sibling (Node* elem);

		[CCode (cname = "xmlAddPrevSibling")]
		public Node* add_prev_sibling (Node* elem);

		[CCode (cname = "xmlAddSibling")]
		public Node* add_sibling (Node* elem);

		[CCode (cname = "xmlCopyNode")]
		public Node* copy (int extended);

		[CCode (cname = "xmlCopyNodeList")]
		public Node copy_list();

		[CCode (cname = "xmlDocCopyNode")]
		public Node* doc_copy (Doc* doc, int extended);

		[CCode (cname = "xmlDocCopyNodeList")]
		public Node* doc_copy_list (Doc* doc);

		[CCode (cname = "xmlFreeNodeList")]
		public void free_list ();

		[CCode (cname = "xmlGetLastChild")]
		public Node* get_last_child ();

		[CCode (cname = "xmlGetLineNo")]
		public long get_line_no ();

		[CCode (cname = "xmlGetNoNsProp")]
		public string get_no_ns_prop (string name);

		[CCode (cname = "xmlGetNodePath")]
		public string get_path ();

		[CCode (cname = "xmlGetNsProp")]
		public string get_ns_prop (string name, string ns);

		[CCode (cname = "xmlGetProp")]
		public string get_prop (string name);

		[CCode (cname = "xmlHasNsProp")]
		public Attr* has_ns_prop (string name, string name_space);

		[CCode (cname = "xmlHasProp")]
		public Attr* has_prop (string name);

		[CCode (cname = "xmlIsBlankNode")]
		public int is_blank ();

		[CCode (cname = "xmlNewChild")]
		public Node* new_child (Ns* ns, string name, string? content = null);

		[CCode (cname = "xmlNewNs")]
		public Ns* new_ns (string href, string prefix);

		[CCode (cname = "xmlNewNsProp")]
		public Attr* new_ns_prop (Ns* ns, string name, string value);

		[CCode (cname = "xmlNewProp")]
		public Attr* new_prop (string name, string value);

		[CCode (cname = "xmlNewTextChild")]
		public Node* new_text_child (Ns* ns, string name, string content);

		[CCode (cname = "xmlNodeAddContent")]
		public void add_content (string content);

		[CCode (cname = "xmlNodeAddContentLen")]
		public void add_content_len (string content, int len);

		[CCode (cname = "xmlNodeGetContent")]
		public string get_content();

		[CCode (cname = "xmlNodeGetLang")]
		public string get_lang();

		[CCode (cname = "xmlNodeGetSpacePreserve")]
		public int get_space_preserve();

		[CCode (cname = "xmlNodeIsText")]
		public int is_text();

		[CCode (cname = "xmlNodeSetContent")]
		public void set_content (string content);

		[CCode (cname = "xmlNodeSetContentLen")]
		public void set_content_len (string content, int len);

		[CCode (cname = "xmlNodeSetLang")]
		public void set_lang (string val);

		[CCode (cname = "xmlNodeSetName")]
		public void set_name (string name);

		[CCode (cname = "xmlNodeSetSpacePreserve")]
		public void set_space_preserve (int val);

		[CCode (cname = "xmlReplaceNode")]
		public Node* replace (Node* cur);

		[CCode (cname = "xmlNewComment")]
		public Node.comment (string content);

		[CCode (cname = "xmlNewNode")]
		public Node (Ns* ns, string name);

		[CCode (cname = "xmlNewNodeEatName")]
		public Node.eat_name (Ns* ns, string# name);

		[CCode (cname = "xmlNewText")]
		public Node.text (string content);

		[CCode (cname = "xmlNewTextLen")]
		public Node.text_len (string content, int len);

		[CCode (cname = "xmlNewPI")]
		public Node.pi (string name, string content);

		[CCode (cname = "xmlSetListDoc")]
		public void set_list_doc (Doc* doc);

		[CCode (cname = "xmlSetNsProp")]
		public Attr* set_ns_prop (Ns* ns, string name, string value);

		[CCode (cname = "xmlSetProp")]
		public Attr* set_prop (string name, string value);

		[CCode (cname = "xmlSetTreeDoc")]
		public void set_tree_doc (Doc* doc);

		[CCode (cname = "xmlTextConcat")]
		public int text_concat (string content, int len);

		[CCode (cname = "xmlTextMerge")]
		public Node* text_merge (Node* second);

		[CCode (cname = "xmlUnlinkNode")]
		public void unlink ();

		[CCode (cname = "xmlUnsetNsProp")]
		public int unset_ns_prop (Ns* ns, string name);

		[CCode (cname = "xmlUnsetProp")]
		public int unset_prop (string name);
	}

	[Compact]
	[CCode (cname = "xmlNs", cheader_filename = "libxml/tree.h")]
	public class Ns {
		public Ns next;
		public ElementType type;
		public string href;
		public string prefix;
		public Doc context;
	}

	[Compact]
	[CCode (cname = "xmlParserCtxt")]
	public class ParserCtxt {
		public SAXHandler* sax;
		public void* user_data;

		[CCode (cname = "xmlParseDocument")]
		public int parse_document ();
	}


	/* uri - library of generic URI related routines */

	[Compact]
	[CCode (cname = "xmlURI", free_function = "xmlFreeURI", cheader_filename = "libxml/uri.h")]
	public class URI {
		[CCode (cname = "xmlBuildRelativeURI")]
		public static string build_relative (string uri, string @base);

		[CCode (cname = "xmlBuildURI")]
		public static string build (string URI, string @base);

		[CCode (cname = "xmlCanonicPath")]
		public static string canonic_path (string path);

		[CCode (cname = "xmlCreateURI")]
		public URI ();

		[CCode (cname = "xmlNormalizeURIPath")]
		public static int normalize_uri_path (string path);

		[CCode (cname = "xmlParseURI")]
		public URI* parse (string str);

		[CCode (cname = "xmlParseURIRaw")]
		public URI* parse_raw (string str, int raw);

		[CCode (cname = "xmlParseURIReference")]
		public int parse_reference (string str);

		[CCode (cname = "xmlPathToURI")]
		public static string path_to_uri (string path);

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

		public string scheme;
		public string opaque;
		public string authority;
		public string server;
		public string user;
		public int port;
		public string path;
		public string query;
		public string fragment;
		public int cleanup;
		public string query_raw;
	}


	/* xmlIO - interface for the I/O interfaces used by the parser */

	[CCode (cname = "xmlInputCloseCallback", cheader_filename = "libxml/xmlIO.h")]
	public static delegate int InputCloseCallback (void* context);

	[CCode (cname = "xmlInputReadCallback", cheader_filename = "libxml/xmlIO.h")]
	[NoArrayLength]
	public static delegate int InputReadCallback (void* context, char[] buffer, int len);


	/* xmlschemas - incomplete XML Schemas structure implementation */

	[Compact]
	[CCode (cname = "xmlSchemaValidCtxt", cheader_filename = "libxml/xmlreader.h")]
	public class SchemaValidCtxt {
	}


	/* xmlreader - the XMLReader implementation */

	[CCode (cname = "xmlParserProperties", cprefix = "XML_PARSER_", cheader_filename = "libxml/xmlreader.h")]
	public enum ParserProperties {
		LOADDTD,
		DEFAULTATTRS,
		VALIDATE,
		SUBST_ENTITIES
	}

	[CCode (cname = "xmlParserSeverities", cprefix = "XML_PARSER_SEVERITY_", cheader_filename = "libxml/xmlreader.h")]
	public enum ParserSeverities {
		VALIDITY_WARNING,
		VALIDITY_ERROR,
		WARNING,
		ERROR
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

	[Compact]
	[CCode (cname = "xmlTextReader", free_function = "xmlFreeTextReader", cheader_filename = "libxml/xmlreader.h")]
	public class TextReader {
		[CCode (cname = "xmlNewTextReaderFilename")]
		public TextReader.filename (string uri);

		[CCode (cname = "xmlReaderForDoc")]
		public TextReader.for_doc (string cur, string url, string encoding, int options);

		[CCode (cname = "xmlReaderForFd")]
		public TextReader.for_fd (int fd, string url, string encoding, int options);

		[CCode (cname = "xmlReaderForFile")]
		public TextReader.for_file (string filename, string encoding, int options);

		[CCode (cname = "xmlReaderForIO")]
		public TextReader.for_io (InputReadCallback ioread, InputCloseCallback ioclose, void* ioctx, string url, string encoding, int options);

		[CCode (cname = "xmlReaderForMemory")]
		[NoArrayLength]
		public TextReader.for_memory (char[] buffer, int size, string url, string encoding, int options);

		[CCode (cname = "xmlReaderNewDoc")]
		public int new_doc (string cur, string url, string encoding, int options);

		[CCode (cname = "xmlReaderNewFd")]
		public int new_fd (int fd, string url, string encoding, int options);

		[CCode (cname = "xmlReaderNewFile")]
		public int new_file (string filename, string encoding, int options);

		[CCode (cname = "xmlReaderNewIO")]
		public int new_io (InputReadCallback ioread, InputCloseCallback ioclose, void* ioctx, string url, string encoding, int options);

		[CCode (cname = "xmlReaderNewMemory")]
		[NoArrayLength]
		public int new_memory (char[] buffer, int size, string url, string encoding, int options);

		[CCode (cname = "xmlReaderNewWalker")]
		public int new_walker (Doc* doc);

		[CCode (cname = "xmlReaderWalker")]
		public TextReader.walker (Doc* doc);

		[CCode (cname = "xmlTextReaderAttributeCount")]
		public int attribute_count ();

		[CCode (cname = "xmlTextReaderBaseUri")]
		public string base_uri ();

		[CCode (cname = "xmlTextReaderByteConsumed")]
		public long byte_consumed ();

		[CCode (cname = "xmlTextReaderClose")]
		public int close ();

		[CCode (cname = "xmlTextReaderConstBaseUri")]
		public weak string const_base_uri ();

		[CCode (cname = "xmlTextReaderConstEncoding")]
		public weak string const_encoding ();

		[CCode (cname = "xmlTextReaderConstLocalName")]
		public weak string const_local_name ();

		[CCode (cname = "xmlTextReaderConstName")]
		public weak string const_name ();

		[CCode (cname = "xmlTextReaderConstNamespaceUri")]
		public weak string const_namespace_uri ();

		[CCode (cname = "xmlTextReaderConstPrefix")]
		public weak string const_prefix ();

		[CCode (cname = "xmlTextReaderConstString")]
		public weak string const_string (string str);

		[CCode (cname = "xmlTextReaderConstValue")]
		public weak string const_value ();

		[CCode (cname = "xmlTextReaderConstXmlLang")]
		public weak string const_xml_lang ();

		[CCode (cname = "xmlTextReaderConstXmlVersion")]
		public weak string const_xml_version ();

		[CCode (cname = "xmlTextReaderCurrentDoc")]
		public Doc* current_doc ();

		[CCode (cname = "xmlTextReaderCurrentNode")]
		public Node* current_node ();

		[CCode (cname = "xmlTextReaderDepth")]
		public int depth ();

		[CCode (cname = "xmlTextReaderExpand")]
		public Node* expand ();

		[CCode (cname = "xmlTextReaderGetAttribute")]
		public string get_attribute (string name);

		[CCode (cname = "xmlTextReaderGetAttributeNo")]
		public string get_attribute_no (int no);

		[CCode (cname = "xmlTextReaderGetAttributeNs")]
		public string get_attribute_ns (string local_name, string namespace_uri);

		[CCode (cname = "xmlTextReaderGetErrorHandler")]
		public void get_error_handler (out TextReaderErrorFunc f, void** arg);

		[CCode (cname = "xmlTextReaderGetParserColumnNumber")]
		public int get_parser_column_number ();

		[CCode (cname = "xmlTextReaderGetParserLineNumber")]
		public int get_parser_line_number ();

		[CCode (cname = "xmlTextReaderGetParserProp")]
		public int get_parser_prop (int prop);

		[CCode (cname = "xmlTextReaderHasAttributes")]
		public int has_attributes ();

		[CCode (cname = "xmlTextReaderHasValue")]
		public int has_value ();

		[CCode (cname = "xmlTextReaderIsDefault")]
		public int is_default ();

		[CCode (cname = "xmlTextReaderIsEmptyElement")]
		public int is_empty_element ();

		[CCode (cname = "xmlTextReaderIsNamespaceDecl")]
		public int is_namespace_decl ();

		[CCode (cname = "xmlTextReaderIsValid")]
		public int is_valid ();

		[CCode (cname = "xmlTextReaderLocalName")]
		public string local_name ();

		[CCode (cname = "xmlTextReaderLookupNamespace")]
		public string lookup_namespace (string prefix);

		[CCode (cname = "xmlTextReaderMoveToAttribute")]
		public int move_to_attribute (string name);

		[CCode (cname = "xmlTextReaderMoveToAttributeNo")]
		public int move_to_attribute_no (int no);

		[CCode (cname = "xmlTextReaderMoveToAttributeNs")]
		public int move_to_attribute_ns (string local_name, string namespace_uri);

		[CCode (cname = "xmlTextReaderMoveToElement")]
		public int move_to_element ();

		[CCode (cname = "xmlTextReaderMoveToFirstAttribute")]
		public int move_to_first_attribute ();

		[CCode (cname = "xmlTextReaderMoveToNextAttribute")]
		public int move_to_next_attribute ();

		[CCode (cname = "xmlTextReaderName")]
		public string name ();

		[CCode (cname = "xmlTextReaderNamespaceUri")]
		public string namespace_uri ();

		[CCode (cname = "xmlTextReaderNext")]
		public int next ();

		[CCode (cname = "xmlTextReaderNextSibling")]
		public int next_sibling ();

		[CCode (cname = "xmlTextReaderNodeType")]
		public int node_type ();

		[CCode (cname = "xmlTextReaderNormalization")]
		public int normalization ();

		[CCode (cname = "xmlTextReaderPrefix")]
		public string prefix ();

		[CCode (cname = "xmlTextReaderPreserve")]
		public Node* preserve ();

		[CCode (cname = "xmlTextReaderPreservePattern")]
		[NoArrayLength]
		public int preserve_pattern (string pattern, string[] namespaces);

		[CCode (cname = "xmlTextReaderQuoteChar")]
		public int quote_char ();

		[CCode (cname = "xmlTextReaderRead")]
		public int read ();

		[CCode (cname = "xmlTextReaderReadAttributeValue")]
		public int read_attribute_value ();

		[CCode (cname = "xmlTextReaderReadInnerXml")]
		public string read_inner_xml ();

		[CCode (cname = "xmlTextReaderReadOuterXml")]
		public string read_outer_xml ();

		[CCode (cname = "xmlTextReaderReadState")]
		public int read_state ();

		[CCode (cname = "xmlTextReaderReadString")]
		public string read_string ();

		[CCode (cname = "xmlTextReaderSchemaValidate")]
		public int schema_validate (string xsd);

		[CCode (cname = "xmlTextReaderSchemaValidateCtxt")]
		public int schema_validate_ctxt (SchemaValidCtxt* ctxt, int options);

		[CCode (cname = "xmlTextReaderSetErrorHandler")]
		public void set_error_handler (TextReaderErrorFunc f, void* arg);

		[CCode (cname = "xmlTextReaderSetParserProp")]
		public int set_parser_prop (SchemaValidCtxt* ctxt, int options);

		[CCode (cname = "xmlTextReaderStandalone")]
		public int standalone ();

		[CCode (cname = "xmlTextReaderValue")]
		public string value ();

		[CCode (cname = "xmlTextReaderXmlLang")]
		public string xml_lang ();
	}

	[Compact]
	[CCode (cname = "void", cheader_filename = "libxml/xmlreader.h")]
	public class TextReaderLocator {
	}

	[CCode (cname = "xmlTextReaderMode", cprefix = "XML_TEXTREADER_MODE_", cheader_filename = "libxml/xmlreader.h")]
	public enum TextReaderMode {
		INITIAL,
		INTERACTIVE,
		ERROR,
		EOF,
		CLOSED,
		READING
	}

	public static delegate void TextReaderErrorFunc (void* arg, string msg, ParserSeverities severity, TextReaderLocator* locator);


	/* xpath - XML Path Language implementation */

	[CCode (cheader_filename = "libxml/xpath.h")]
	namespace XPath {
		[CCode (cname = "xmlXPathOrderDocElems")]
		public static long order_doc_elements (Doc* doc);
	}

	[Compact]
	[CCode (cname = "xmlNodeSet", cheader_filename = "libxml/xpath.h")]
	public class NodeSet {
		[CCode (cname = "xmlXPathNodeSetGetLength")]
		public int length ();

		[CCode (cname = "xmlXPathNodeSetIsEmpty")]
		public bool is_empty ();

		[CCode (cname = "xmlXPathNodeSetItem")]
		public Node* item (int index);
	}

	[Compact]
	[CCode (cname = "xmlXPathContext", free_function = "xmlXPathFreeContext", cheader_filename = "libxml/xpath.h")]
	public class XPathContext {
		public Doc* doc;
		public Node* node;

		[CCode (cname = "xmlXPathContextSetCache")]
		public int set_cache (int active, int value, int options);

		[InstanceLast]
		[CCode (cname = "xmlXPathEval")]
		public XPathObject* eval (string str);

		[InstanceLast]
		[CCode (cname = "xmlXPathEvalExpression")]
		public XPathObject* eval_expression (string str);

		[CCode (cname = "xmlXPathNewContext")]
		public XPathContext (Doc* doc);
	}

	[CCode (cname = "xmlXPathError", cprefix = "", cheader_filename = "libxml/xpath.h")]
	public enum XPathError {
		XPATH_EXPRESSION_OK,
		XPATH_NUMBER_ERROR,
		XPATH_UNFINISHED_LITERAL_ERROR,
		XPATH_START_LITERAL_ERROR,
		XPATH_VARIABLE_REF_ERROR,
		XPATH_UNDEF_VARIABLE_ERROR,
		XPATH_INVALID_PREDICATE_ERROR,
		XPATH_EXPR_ERROR,
		XPATH_UNCLOSED_ERROR,
		XPATH_UNKNOWN_FUNC_ERROR,
		XPATH_INVALID_OPERAND,
		XPATH_INVALID_TYPE,
		XPATH_INVALID_ARITY,
		XPATH_INVALID_CTXT_SIZE,
		XPATH_INVALID_CTXT_POSITION,
		XPATH_MEMORY_ERROR,
		XPTR_SYNTAX_ERROR,
		XPTR_RESOURCE_ERROR,
		XPTR_SUB_RESOURCE_ERROR,
		XPATH_UNDEF_PREFIX_ERROR,
		XPATH_ENCODING_ERROR,
		XPATH_INVALID_CHAR_ERROR,
		XPATH_INVALID_CTXT
	}

	[Compact]
	[CCode (cname = "xmlXPathObject", cheader_filename = "libxml/xpath.h")]
	public class XPathObject {
		public XPathObjectType type;
		public NodeSet* nodesetval;
		public int boolval;
		public double floatval;
		public string stringval;
		public void* user;
		public int index;
		public void* user2;
		public int index2;
	}

	[CCode (cname = "xmlXPathObjectType", cprefix = "XPATH_", cheader_filename = "libxml/xpath.h")]
	public enum XPathObjectType {
		UNDEFINED,
		NODESET,
		BOOLEAN,
		NUMBER,
		STRING,
		POINT,
		RANGE,
		LOCATIONSET,
		USERS,
		XSLT_TREE
	}


	/* SAX CALLBACKS */

	[CCode (cname = "attributeDeclSAXFunc")]
	public static delegate void attributeDeclSAXFunc (void* ctx, string elem, string fullname, int type, int def, string defaultValue, Enumeration* tree);

	[CCode (cname = "attributeSAXFunc")]
	public static delegate void attributeSAXFunc (void* ctx, string name, string value);

	[CCode (cname = "cdataBlockSAXFunc")]
	public static delegate void cdataBlockSAXFunc (void* ctx, string value, int len);

	[CCode (cname = "charactersSAXFunc")]
	public static delegate void charactersSAXFunc (void* ctx, string ch, int len);

	[CCode (cname = "commentsSAXFunc")]
	public static delegate void commentSAXFunc (void* ctx, string value);

	[CCode (cname = "elementDeclSAXFunc")]
	public static delegate void elementDeclSAXFunc (void* ctx, string name, int type, ElementContent content);

	[CCode (cname = "endDocumentSAXFunc")]
	public static delegate void endDocumentSAXFunc (void* ctx);

	[CCode (cname = "endElementNsSAX2Func")]
	public static delegate void endElementNsSAX2Func (void* ctx, string localname, string prefix, string URI);

	[CCode (cname = "endElementSAXFunc")]
	public static delegate void endElementSAXFunc (void* ctx, string name);

	[CCode (cname = "entityDeclSAXFunc")]
	public static delegate void entityDeclSAXFunc (void* ctx, string name, int type, string publicId, string systemId, string content);

	[CCode (cname = "errorSAXFunc")]
	public static delegate void errorSAXFunc (void* ctx, string msg, ...);

	[CCode (cname = "externalSubsetSAXFunc")]
	public static delegate void externalSubsetSAXFunc (void* ctx, string name, string ExternalID, string SystemID);

	[CCode (cname = "fatalErrorSAXFunc")]
	public static delegate void fatalErrorSAXFunc (void* ctx, string msg, ...);

	[CCode (cname = "getEntitySAXFunc")]
	public static delegate Entity* getEntitySAXFunc (void* ctx, string name);

	[CCode (cname = "getParameterEntitySAXFunc")]
	public static delegate Entity* getParameterEntitySAXFunc (void* ctx, string name);

	[CCode (cname = "hasExternalSubsetSAXFunc")]
	public static delegate int hasExternalSubsetSAXFunc (void* ctx);

	[CCode (cname = "hasInternalSubsetSAXFunc")]
	public static delegate int hasInternalSubsetSAXFunc (void* ctx);

	[CCode (cname = "ignorableWhitespaceSAXFunc")]
	public static delegate void ignorableWhitespaceSAXFunc (void* ctx, string ch, int len);

	[CCode (cname = "internalSubsetSAXFunc")]
	public static delegate void internalSubsetSAXFunc (void* ctx, string name, string ExternalID, string SystemID);

	[CCode (cname = "isStandaloneSAXFunc")]
	public static delegate int isStandaloneSAXFunc (void* ctx);

	[CCode (cname = "notationDeclSAXFunc")]
	public static delegate void notationDeclSAXFunc (void* ctx, string name, string publicId, string systemId);

	[CCode (cname = "processingInstructionSAXFunc")]
	public static delegate void processingInstructionSAXFunc (void* ctx, string target, string data);

	[CCode (cname = "referenceSAXFunc")]
	public static delegate void referenceSAXFunc (void* ctx, string name);

	// [CCode (cname = "resolveEntitySAXFunc")]
	// public static delegate ParserInput resolveEntitySAXFunc (void* ctx, string publicId, string systemId);

	// [CCode (cname = "setDocumentLocatorSAXFunc")]
	// public static delegate void setDocumentLocatorSAXFunc (void* ctx, SAXLocator loc);

	[CCode (cname = "startDocumentSAXFunc")]
	public static delegate void startDocumentSAXFunc (void* ctx);

	[NoArrayLength]
	[CCode (cname = "startElementNsSAX2Func")]
	public static delegate void startElementNsSAX2Func (void* ctx, string localname, string prefix, string URI, int nb_namespaces, string[] namespaces, int nb_attributes, int nb_defaulted, string[] attributes);

	[NoArrayLength]
	[CCode (cname = "startElementSAXFunc")]
	public static delegate void startElementSAXFunc (void* ctx, string name, string[] atts);

	[CCode (cname = "unparsedEntityDeclSAXFunc")]
	public static delegate void unparsedEntityDeclSAXFunc (void* ctx, string name, string publicId, string systemId, string notationName);

	[CCode (cname = "warningSAXFunc")]
	public static delegate void warningSAXFunc (void* ctx, string msg, ...);

	[CCode (cname ="xmlStructuredErrorFunc")]
	public static delegate void xmlStructuredErrorFunc (void* ctx, Error* error);

	[Compact]
	[CCode (cname = "xmlSAXHandler")]
	public struct SAXHandler {
		public internalSubsetSAXFunc internalSubset;
		public isStandaloneSAXFunc isStandalone;
		public hasInternalSubsetSAXFunc hasInternalSubset;
		public hasExternalSubsetSAXFunc hasExternalSubset;
		// public resolveEntitySAXFunc resolveEntity;
		public getEntitySAXFunc getEntity;
		public entityDeclSAXFunc entityDecl;
		public notationDeclSAXFunc notationDecl;
		public attributeDeclSAXFunc attributeDecl;
		public elementDeclSAXFunc elementDecl;
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
		public getParameterEntitySAXFunc getParameterEntity;
		public cdataBlockSAXFunc cdataBlock;
		public externalSubsetSAXFunc externalSubset;
		public uint initialized;
		public startElementNsSAX2Func startElementNs;
		public endElementNsSAX2Func endElementNs;
		public xmlStructuredErrorFunc serror;
 	}

	[CCode (lower_case_cprefix = "xmlSAX")]
	namespace SAXParser {
		public int UserParseMemory (SAXHandler* sax, void* user_data, string buffer, int size);
		public int UserParseFile (SAXHandler* sax, void* user_data, string filename);
	}


	/* xmlerror - error handling */

	[Compact]
	[CCode (cname = "xmlError", cheader_filename = "libxml/xmlerror.h")]
	public struct Error {
		public int domain;
		public int code;
		public string message;
		public ErrorLevel level;
		public string file;
		public int line;
		public string str1;
		public string str2;
		public string str3;
		public int int1;
		public int int2;
		public void* ctx;
		public void* node;
	}

	[CCode (cname = "xmlErrorLevel", cprefix = "XML_ERR_", cheader_filename = "libxml/xmlerror.h")]
	public enum ErrorLevel {
		NONE = 0,
		WARNING = 1,
		ERROR = 2,
		FATAL = 3
	}

}
