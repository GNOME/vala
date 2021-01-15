/* basicdoclet.vala
 *
 * Copyright (C) 2008-2012 Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */

using Valadoc.Content;
using Valadoc.Api;



public abstract class Valadoc.Html.BasicDoclet : Api.Visitor, Doclet {
	public Html.LinkHelper linker {
		protected set;
		get;
	}

	public Settings settings {
		protected set;
		get;
	}

	public string wiki_index_name {
		default = "index.valadoc";
		protected set;
		get;
	}

	protected Api.Tree tree;
	protected HtmlRenderer _renderer;
	protected Html.MarkupWriter writer;
	protected Html.CssClassResolver cssresolver;
	protected Charts.Factory image_factory;
	protected ErrorReporter reporter;
	protected string package_list_link = "../index.html";

	// CSS:
	private const string css_inline_navigation = "navi_inline";
	private const string css_package_index = "package_index";
	private const string css_brief_description = "brief_description";
	private const string css_description = "description";
	private const string css_known_list = "known_nodes";
	private const string css_leaf_brief_description = "leaf_brief_description";
	private const string css_leaf_code_definition = "leaf_code_definition";

	private const string css_box_headline_text = "text";
	private const string css_box_headline_toggle = "toggle";
	private const string css_box_headline = "headline";
	private const string css_box_content = "content";
	private const string css_box_column = "column";
	private const string css_box = "box";

	private const string css_namespace_note = "namespace_note";
	private const string css_package_note = "package_note";

	private const string css_site_header = "site_header";
	private const string css_navi = "navi_main";
	private const string css_navi_hr = "navi_hr";
	private const string css_errordomain_table_name = "main_errordomain_table_name";
	private const string css_errordomain_table_text = "main_errordomain_table_text";
	private const string css_errordomain_table = "main_errordomain_table";
	private const string css_enum_table_name = "main_enum_table_name";
	private const string css_enum_table_text = "main_enum_table_text";
	private const string css_enum_table = "main_enum_table";
	private const string css_diagram = "main_diagram";
	private const string css_see_list = "main_see_list";
	private const string css_wiki_table = "main_table";
	private const string css_notification_area = "main_notification";
	private const string css_source_sample = "main_sourcesample";
	private const string css_exception_table = "main_parameter_table";
	private const string css_parameter_table_text = "main_parameter_table_text";
	private const string css_parameter_table_name = "main_parameter_table_name";
	private const string css_parameter_table = "main_parameter_table";
	private const string css_title = "main_title";
	private const string css_other_type = "main_other_type";
	private const string css_basic_type  = "main_basic_type";
	private const string css_keyword  = "main_keyword";
	private const string css_optional_parameter  = "main_optional_parameter";
	private const string css_code_definition = "main_code_definition";
	private const string css_headline_hr = "main_hr";
	private const string css_hr = "main_hr";
	private const string css_list_errdom = "main_list_errdom";
	private const string css_list_en = "main_list_en";
	private const string css_list_ns = "main_list_ns";
	private const string css_list_cl = "main_list_cl";
	private const string css_list_iface = "main_list_iface";
	private const string css_list_stru = "main_list_stru";
	private const string css_list_field = "main_list_field";
	private const string css_list_prop = "main_list_prop";
	private const string css_list_del = "main_list_del";
	private const string css_list_sig = "main_list_sig";
	private const string css_list_m = "main_list_m";
	private const string css_style_navigation = "site_navigation";
	private const string css_style_content = "site_content";
	private const string css_style_body = "site_body";
	private const string css_deprecated = "deprecated";

	public virtual void process (Settings settings, Api.Tree tree, ErrorReporter reporter) {
		this.reporter = reporter;
		this.settings = settings;
		this.tree = tree;

		this.cssresolver = new CssClassResolver ();
		this.linker = new LinkHelper ();

		_renderer = new HtmlRenderer (settings, this.linker, this.cssresolver);
		this.image_factory = new SimpleChartFactory (settings, linker);
	}


	// paths:
	protected string? get_link (Api.Node to, Api.Node from) {
		return linker.get_relative_link (from, to, settings);
	}

	protected virtual string get_img_path_html (Api.Node element, string type) {
		return Path.build_filename ("img", element.get_full_name () + "." + type);
	}

	protected virtual string get_img_path (Api.Node element, string type) {
		return Path.build_filename (settings.path, element.package.name, "img",
									element.get_full_name () + "." + type);
	}

	protected virtual string get_icon_directory () {
		return "..";
	}


	private TypeSymbol? unpack_type_reference (TypeReference? type_reference) {
		Api.Item pos = type_reference;

		while (pos != null) {
			if (pos is TypeReference) {
				pos = ((TypeReference) pos).data_type;
			} else if (pos is Api.Array) {
				pos = ((Api.Array) pos).data_type;
			} else if (pos is Pointer) {
				pos = ((Pointer) pos).data_type;
			} else {
				assert (pos is TypeSymbol);
				return (TypeSymbol) pos;
			}
		}

		return null;
	}


	protected void write_navi_entry_html_template (string style, string content, bool is_deprecated) {
		writer.start_tag ("li", {"class", style});

		if (is_deprecated) {
			writer.start_tag ("span", {"class", css_deprecated});
			writer.text (content);
			writer.end_tag ("span");
		} else {
			writer.text (content);
		}

		writer.end_tag ("li");
	}

	protected void write_navi_entry_html_template_with_link (string style, string link,
															 string content, bool is_deprecated)
	{
		writer.start_tag ("li", {"class", style});

		if (is_deprecated) {
			writer.start_tag ("span", {"class", css_deprecated});
			writer.link (link, content);
			writer.end_tag ("span");
		} else {
			writer.link (link, content);
		}

		writer.end_tag ("li");
	}

	protected void write_navi_entry (Api.Node element, Api.Node? pos, string style,
									 bool link, bool full_name = false)
	{
		string name;

		if (full_name == true && element is Namespace) {
			string tmp = element.get_full_name();
			name = (tmp == null)? "Global Namespace" : tmp;
		} else {
			string tmp = element.name;
			name = (tmp == null)? "Global Namespace" : tmp;
		}

		bool is_deprecated = element is Symbol && ((Symbol) element).is_deprecated;

		if (link == true) {
			this.write_navi_entry_html_template_with_link (style,
														   this.get_link (element, pos),
														   name,
														   is_deprecated);
		} else {
			this.write_navi_entry_html_template (style, name, is_deprecated);
		}
	}

	protected void write_wiki_pages (Api.Tree tree, string css_path_wiki, string js_path_wiki,
									 string contentp)
	{
		if (tree.wikitree == null) {
			return ;
		}

		if (tree.wikitree == null) {
			return ;
		}

		Vala.Collection<WikiPage> pages = tree.wikitree.get_pages();
		if (pages.size == 0) {
			return ;
		}

		DirUtils.create (contentp, 0777);

		DirUtils.create (Path.build_filename (contentp, "img"), 0777);

		foreach (WikiPage page in pages) {
			if (page.name != wiki_index_name) {
				write_wiki_page (page, contentp, css_path_wiki, js_path_wiki, this.settings.pkg_name);
			}
		}
	}

	protected virtual void write_wiki_page (WikiPage page, string contentp, string css_path,
											string js_path, string pkg_name)
	{
		GLib.FileStream file = GLib.FileStream.open (
			Path.build_filename (contentp, page.name.substring (0, page.name.length-7).replace ("/", ".")+"htm"),
			"w");

		writer = new MarkupWriter (file);
		_renderer.set_writer (writer);
		this.write_file_header (css_path, js_path, pkg_name);
		_renderer.set_container (page);
		_renderer.render (page.documentation);
		this.write_file_footer ();
	}

	protected void write_navi_top_entry (Api.Node element, Api.Node? parent) {
		string style = cssresolver.resolve (element);

		writer.start_tag ("ul", {"class", css_navi});

		if (element == parent || parent == null) {
			this.write_navi_entry (element, parent, style, false);
		} else {
			this.write_navi_entry (element, parent, style, true);
		}

		writer.end_tag ("ul");
		writer.simple_tag ("hr", {"class", css_navi_hr});
	}

	protected void write_top_element_template (string link) {
		writer.start_tag ("ul", {"class", css_navi});
		writer.start_tag ("li", {"class", css_package_index});
		writer.link (link, "Packages");
		writer.end_tag ("li");
		writer.end_tag ("ul");
		writer.simple_tag ("hr", {"class", css_navi_hr});
	}

	protected void write_top_elements (Api.Node element, Api.Node? parent) {
		Vala.ArrayList<Api.Node> lst = new Vala.ArrayList<Api.Node> ();
		Api.Node pos = element;

		this.write_top_element_template (package_list_link);

		while (pos != null) {
			lst.add (pos);
			pos = (Api.Node)pos.parent;
		}

		for (int i = lst.size-1; i >= 0  ; i--) {
			Api.Node el = lst.get (i);

			if (el.name != null) {
				this.write_navi_top_entry (el, parent);
			}
		}
	}

	protected void fetch_subnamespace_names (Api.Node node, Vala.ArrayList<Namespace> namespaces) {
		var children = node.get_children_by_type (Api.NodeType.NAMESPACE);
		children.sort ((CompareDataFunc) Api.Node.compare_to);
		foreach (Api.Node child in children) {
			namespaces.add ((Namespace) child);
			this.fetch_subnamespace_names (child, namespaces);
		}
	}

	protected void write_navi_package (Package package) {
		Vala.ArrayList<Namespace> ns_list = new Vala.ArrayList<Namespace> ();
		this.fetch_subnamespace_names (package, ns_list);

		writer.start_tag ("div", {"class", css_style_navigation});
		write_top_elements (package, package);
		writer.start_tag ("ul", {"class", css_navi});

		Namespace globals = null;

		foreach (Namespace ns in ns_list) {
			if (ns.name == null) {
				globals = ns;
			} else {
				this.write_navi_entry (ns, package, cssresolver.resolve (ns), true, true);
			}
		}

		if (globals != null) {
			write_navi_children (globals, Api.NodeType.ERROR_CODE, package);
			write_navi_children (globals, Api.NodeType.ENUM_VALUE, package);
			write_navi_children (globals, Api.NodeType.ENUM, package);
			write_navi_children (globals, Api.NodeType.INTERFACE, package);
			write_navi_children (globals, Api.NodeType.CLASS, package);
			write_navi_children (globals, Api.NodeType.STRUCT, package);
			write_navi_children (globals, Api.NodeType.CONSTANT, package);
			write_navi_children (globals, Api.NodeType.PROPERTY, package);
			write_navi_children (globals, Api.NodeType.DELEGATE, package);
			write_navi_children (globals, Api.NodeType.STATIC_METHOD, package);
			write_navi_children (globals, Api.NodeType.CREATION_METHOD, package);
			write_navi_children (globals, Api.NodeType.METHOD, package);
			write_navi_children (globals, Api.NodeType.SIGNAL, package);
			write_navi_children (globals, Api.NodeType.FIELD, package);
		}

		writer.end_tag ("ul");
		writer.end_tag ("div");
	}

	protected void write_navi_symbol (Api.Node node) {
		writer.start_tag ("div", {"class", css_style_navigation});
		write_top_elements (node, node);
		write_navi_symbol_inline (node, node);
		writer.end_tag ("div");
	}

	protected void write_navi_leaf_symbol (Api.Node node) {
		writer.start_tag ("div", {"class", css_style_navigation});
		write_top_elements ((Api.Node) node.parent, node);
		write_navi_symbol_inline ((Api.Node) node.parent, node);
		writer.end_tag ("div");
	}

	protected void write_navi_symbol_inline (Api.Node node, Api.Node? parent) {
		writer.start_tag ("ul", {"class", css_navi});
		write_navi_children (node, Api.NodeType.NAMESPACE, parent);
		write_navi_children (node, Api.NodeType.ERROR_CODE, parent);
		write_navi_children (node, Api.NodeType.ENUM_VALUE, parent);
		write_navi_children (node, Api.NodeType.ENUM, parent);
		write_navi_children (node, Api.NodeType.INTERFACE, parent);
		write_navi_children (node, Api.NodeType.CLASS, parent);
		write_navi_children (node, Api.NodeType.STRUCT, parent);
		write_navi_children (node, Api.NodeType.CONSTANT, parent);
		write_navi_children (node, Api.NodeType.PROPERTY, parent);
		write_navi_children (node, Api.NodeType.DELEGATE, parent);
		write_navi_children (node, Api.NodeType.STATIC_METHOD, parent);
		write_navi_children (node, Api.NodeType.CREATION_METHOD, parent);
		write_navi_children (node, Api.NodeType.METHOD, parent);
		write_navi_children (node, Api.NodeType.SIGNAL, parent);
		write_navi_children (node, Api.NodeType.FIELD, parent);
		writer.end_tag ("ul");
	}

	protected void write_navi_children (Api.Node node, Api.NodeType type, Api.Node? parent) {
		var children = node.get_children_by_type (type);
		children.sort ((CompareDataFunc) Api.Node.compare_to);
		foreach (Api.Node child in children) {
			write_navi_entry (child, parent, cssresolver.resolve (child), child != parent);
		}
	}

	protected void write_package_note (Api.Node element) {
		string package = element.package.name;
		if (package == null) {
			return;
		}

		writer.start_tag ("div", {"class", css_package_note});
		writer.start_tag ("b")
			.text ("Package:")
			.end_tag ("b");
		writer.text (" ")
			.start_tag ("a", {"href", get_link (element.package, element)})
			.text (package)
			.end_tag ("a");
		writer.end_tag ("div");
	}

	protected void write_namespace_note (Api.Node element) {
		Namespace? ns = element.nspace;
		if (ns == null) {
			return;
		}

		if (ns.name == null) {
			return;
		}

		writer.start_tag ("div", {"class", css_namespace_note});
		writer.start_tag ("b")
			.text ("Namespace:")
			.end_tag ("b");
		writer.text (" ")
			.start_tag ("a", {"href", get_link (ns, element)})
			.text (ns.get_full_name())
			.end_tag ("a");
		writer.end_tag ("div");
	}

	private bool has_brief_description (Api.Node element) {
		return element.documentation != null;
	}

	private void write_brief_description (Api.Node element , Api.Node? pos) {
		Content.Comment? doctree = element.documentation;
		if (doctree == null) {
			return;
		}

		Vala.List<Block> description = doctree.content;
		if (description.size > 0) {
			writer.start_tag ("span", {"class", css_brief_description});

			_renderer.set_container (pos);
			_renderer.set_owner (element);
			_renderer.render_children (description.get (0));
			_renderer.set_owner (null);

			writer.end_tag ("span");
		}
	}

	private void write_documentation (Api.Node element , Api.Node? pos) {
		Content.Comment? doctree = element.documentation;
		bool is_deprecated = (element is Symbol && ((Symbol) element).is_deprecated);

		// avoid empty divs
		if (doctree == null && !is_deprecated) {
			return;
		}


		writer.start_tag ("div", {"class", css_description});
		_renderer.set_owner (element);

		// deprecation warning:
		if (is_deprecated) {
			Symbol symbol = (Symbol) element;
			Attribute? version;
			Attribute? deprecated;
			string? replacement;
			string? since;
			if ((version = symbol.get_attribute ("Version")) != null) {
				replacement = ((Vala.Attribute) version.data).get_string ("replacement");
				since = ((Vala.Attribute) version.data).get_string ("deprecated_since");
			} else if ((deprecated = symbol.get_attribute ("Deprecated")) != null) {
				replacement = ((Vala.Attribute) deprecated.data).get_string ("replacement");
				since = ((Vala.Attribute) deprecated.data).get_string ("version");
			} else {
				assert_not_reached ();
			}

			writer.start_tag ("p");
			writer.start_tag ("b");
			writer.text ("Warning:");
			writer.end_tag ("b");
			writer.text (" %s is deprecated".printf (element.name));

			if (since != null) {
				writer.text (" since %s".printf (since));
			}

			writer.text (".");

			if (replacement != null && replacement.length > 2) {
				Api.Node? replacement_node = tree.search_symbol_str (pos,
					replacement.substring (1, replacement.length - 2));

				writer.text (" Use ");
				if (replacement_node == null) {
					writer.text (replacement);
				} else {
					string? link = get_link (replacement_node, pos);
					if (link != null) {
						string css = cssresolver.resolve (replacement_node);
						writer.link (link, replacement_node.get_full_name (), css);
					} else {
						writer.start_tag ("code")
							.text (replacement_node.get_full_name ())
							.end_tag ("code");
					}
				}
				writer.text (".");
			}

			writer.end_tag ("p");
		}

		if (doctree != null) {
			_renderer.set_container (pos);
			_renderer.render (doctree);
		}


		_renderer.set_owner (null);
		writer.end_tag ("div");
	}

	private void write_attributes (Api.Symbol element, Api.Node? pos) {
		writer.set_wrap (false);
		_renderer.set_container (pos);
		foreach (Attribute att in element.get_attributes ()) {
			_renderer.render (att.signature);
			writer.simple_tag ("br");
		}
		writer.set_wrap (true);
	}

	private void write_signature (Api.Node element , Api.Node? pos) {
		writer.set_wrap (false);
		_renderer.set_container (pos);
		_renderer.render (element.signature);
		writer.set_wrap (true);
	}

	protected bool is_internal_node (Api.Node node) {
		return node is Package
		       || node is Api.Namespace
		       || node is Api.Interface
		       || node is Api.Class
		       || node is Api.Struct
		       || node is Api.Enum
		       || node is Api.EnumValue
		       || node is Api.ErrorDomain
		       || node is Api.ErrorCode;
	}

	public void write_navi_packages_inline (Api.Tree tree) {
		writer.start_tag ("ul", {"class", css_navi});
		foreach (Package pkg in tree.get_package_list()) {
			if (pkg.is_browsable (settings)) {
				writer.start_tag ("li", {"class", cssresolver.resolve (pkg)});
				writer.link (linker.get_package_link (pkg, settings), pkg.name);
				// brief description
				writer.end_tag ("li");
			} else {
				writer.start_tag ("li", {"class", cssresolver.resolve (pkg)});
				writer.text (pkg.name);
				writer.end_tag ("li");
			}
		}
		writer.end_tag ("ul");
	}

	public void write_navi_packages (Api.Tree tree) {
		writer.start_tag ("div", {"class", css_style_navigation});
		this.write_navi_packages_inline (tree);
		writer.end_tag ("div");
	}

	public void write_package_index_content (Api.Tree tree) {
		writer.start_tag ("div", {"class", css_style_content});
		writer.start_tag ("h1", {"class", css_title})
			.text ("Packages:")
			.end_tag ("h1");
		writer.simple_tag ("hr", {"class", css_headline_hr});

		WikiPage? wikiindex = (tree.wikitree == null)
			? null
			: tree.wikitree.search (wiki_index_name);
		if (wikiindex != null) {
			_renderer.set_container (wikiindex);
			_renderer.render (wikiindex.documentation);
		}

		writer.start_tag ("h2", {"class", css_title})
			.text ("Content:")
			.end_tag ("h2");
		writer.start_tag ("h3", {"class", css_title})
			.text ("Packages:")
			.end_tag ("h3");
		this.write_navi_packages_inline (tree);
		writer.end_tag ("div");
	}

	private uint html_id_counter = 0;

	private inline Vala.ArrayList<Api.Node> get_accessible_nodes_from_list (Vala.Collection<Api.Node> nodes) {
		var list = new Vala.ArrayList<Api.Node> ();

		foreach (var node in nodes) {
			if (node.is_browsable(_settings)) {
				list.add (node);
			}
		}

		return list;
	}

	private void write_known_symbols_note (Vala.Collection<Api.Node> nodes2, Api.Node container, string headline) {
		var nodes = get_accessible_nodes_from_list (nodes2);
		if (nodes.size == 0) {
			return ;
		}

		nodes.sort ((CompareDataFunc) Api.Node.compare_to);

		// Box:
		var html_id = "box-content-" + html_id_counter.to_string ();
		html_id_counter++;


		writer.start_tag ("div", {"class", css_box});

		// headline:
		writer.start_tag ("div", {"class", css_box_headline, "onclick", "toggle_box (this, '%s')".printf (html_id)})
			.text (headline)
			.end_tag ("div");
		//writer.start_tag ("div", {"class", css_box_headline_text, "onclick", "toggle_box (this, '%s')".printf (html_id)})
		//	.text (headline)
		//	.end_tag ("div");
		//writer.start_tag ("div", {"class", css_box_headline_toggle});
		//writer.start_tag ("img", {"onclick",
		//						  "toggle_box  (this, '" + html_id + "')",
		//						  "src",
		//						  Path.build_filename (get_icon_directory (),
		//						  "coll_open.png")});
		//writer.raw_text ("&nbsp;");
		//writer.end_tag ("div");
		//writer.end_tag ("div");


		// content:
		int[] list_sizes = {0, 0, 0};
		list_sizes[0] = nodes.size;
		list_sizes[2] = list_sizes[0]/3;
		list_sizes[0] -= list_sizes[2];
		list_sizes[1] = list_sizes[0]/2;
		list_sizes[0] -= list_sizes[1];

		writer.start_tag ("div", {"class", css_box_content, "id", html_id});

		var iter = nodes.iterator ();

		for (int i = 0; i < list_sizes.length; i++) {
			writer.start_tag ("div", {"class", css_box_column});
			writer.start_tag ("ul", {"class", css_inline_navigation});

			for (int p = 0; p < list_sizes[i] && iter.next (); p++) {
				var node = iter.get ();
				writer.start_tag ("li", {"class", cssresolver.resolve (node)});
				string link = get_link (node, container);
				if (link == null) {
					writer.text (node.name);
				} else {
					writer.link (link, node.name);
				}
				writer.end_tag ("li");
			}

			writer.end_tag ("ul");
			writer.end_tag ("div");
		}

		writer.end_tag ("div"); // end content

		writer.end_tag ("div"); // end box
	}

	public void write_symbol_content (Api.Node node) {
		writer.start_tag ("div", {"class", css_style_content});
		writer.start_tag ("h1", {"class", css_title})
			.text (node.name)
			.end_tag ("h1");
		writer.simple_tag ("hr", {"class", css_headline_hr});
		this.write_image_block (node);
		writer.start_tag ("h2", {"class", css_title})
			.text ("Description:")
			.end_tag ("h2");
		writer.start_tag ("div", {"class", css_code_definition});
		if (node is Symbol) {
			this.write_attributes ((Symbol) node, node);
		}
		this.write_signature (node, node);
		writer.end_tag ("div");
		this.write_documentation (node, node);

		if (node is Class) {
			var cl = node as Class;
			write_known_symbols_note (cl.get_known_child_classes (),
									  cl,
									  "All known sub-classes:");
			write_known_symbols_note (cl.get_known_derived_interfaces (),
									  cl,
									  "Required by:");
		} else if (node is Interface) {
			var iface = node as Interface;
			write_known_symbols_note (iface.get_known_implementations (),
									  iface,
									  "All known implementing classes:");
			write_known_symbols_note (iface.get_known_related_interfaces (),
									  iface,
									  "All known sub-interfaces:");
		} else if (node is Struct) {
			var stru = node as Struct;
			write_known_symbols_note (stru.get_known_child_structs (),
									  stru,
									  "All known sub-structs:");
		}

		if (node.parent is Namespace) {
			writer.simple_tag ("br");
			write_namespace_note (node);
			write_package_note (node);
		}

		if (!(node is Method || node is Delegate || node is Api.Signal)) {
			// avoids exception listings & implementations

			if (node.has_children ({
					Api.NodeType.ERROR_CODE,
					Api.NodeType.ENUM_VALUE,
					Api.NodeType.CREATION_METHOD,
					Api.NodeType.STATIC_METHOD,
					Api.NodeType.CLASS,
					Api.NodeType.STRUCT,
					Api.NodeType.ENUM,
					Api.NodeType.DELEGATE,
					Api.NodeType.METHOD,
					Api.NodeType.SIGNAL,
					Api.NodeType.PROPERTY,
					Api.NodeType.FIELD,
					Api.NodeType.CONSTANT
				}))
			{
				writer.start_tag ("h2", {"class", css_title}).text ("Content:").end_tag ("h2");
				write_children (node, Api.NodeType.ERROR_CODE, "Error codes", node);
				write_children (node, Api.NodeType.ENUM_VALUE, "Enum values", node);
				write_children (node, Api.NodeType.CLASS, "Classes", node);
				write_children (node, Api.NodeType.STRUCT, "Structs", node);
				write_children (node, Api.NodeType.ENUM, "Enums", node);
				write_children (node, Api.NodeType.CONSTANT, "Constants", node);
				write_children (node, Api.NodeType.PROPERTY, "Properties", node);
				write_children (node, Api.NodeType.DELEGATE, "Delegates", node);
				write_children (node, Api.NodeType.STATIC_METHOD, "Static methods", node);
				write_children (node, Api.NodeType.CREATION_METHOD, "Creation methods", node);
				write_children (node, Api.NodeType.METHOD, "Methods", node);
				write_children (node, Api.NodeType.SIGNAL, "Signals", node);
				write_children (node, Api.NodeType.FIELD, "Fields", node);
			}
		}

		if (node is Class) {
			write_inherited_symbols_note_for_class ((Class) node, node);
		} else if (node is Interface) {
			write_inherited_symbols_note_for_interface ((Interface) node, node);
		} else if (node is Struct) {
			write_inherited_symbols_note_for_struct ((Struct) node, node);
		}

		writer.end_tag ("div");
	}

	private static NodeType[] inheritable_members = {
			NodeType.CONSTANT,
			NodeType.PROPERTY,
			NodeType.DELEGATE,
			NodeType.STATIC_METHOD,
			NodeType.METHOD,
			NodeType.SIGNAL,
			NodeType.FIELD
		};

	private inline bool has_visible_inheritable_children (TypeSymbol symbol) {
		return symbol.has_visible_children_by_types (inheritable_members, _settings);
	}

	private void write_inherited_members_headline () {
		writer.start_tag ("h3", {"class", css_title})
			.text ("Inherited Members:")
			.end_tag ("h3");
	}

	private void write_inherited_symbols_note_for_class (Class cl, Api.Node container) {
		bool headline_printed = false;

		// class hierarchy:
		Class base_class = unpack_type_reference (cl.base_type) as Class;
		while (base_class != null) {
			if (!headline_printed && has_visible_inheritable_children (base_class)) {
				write_inherited_members_headline ();
				headline_printed = true;
			}

			write_inherited_symbols_note (base_class, "class", container);
			base_class = unpack_type_reference (base_class.base_type) as Class;
		}


		// implemented interfaces
		Vala.Collection<Interface> printed_interfaces = new Vala.ArrayList<Interface> ();
		foreach (TypeReference iface_ref in cl.get_full_implemented_interface_list ()) {
			Interface iface = (Interface) unpack_type_reference (iface_ref);

			if (!headline_printed && has_visible_inheritable_children (iface)) {
				write_inherited_members_headline ();
				headline_printed = true;
			} else if (printed_interfaces.contains (iface)) {
				continue ;
			}

			write_inherited_symbols_note (iface, "interface", container);
			printed_interfaces.add (iface);
		}
	}

	private void write_inherited_symbols_note_for_interface (Interface iface, Api.Node container) {
		bool headline_printed = false;

		// class hierarchy:
		Class base_class = unpack_type_reference (iface.base_type) as Class;
		while (base_class != null) {
			if (!headline_printed && has_visible_inheritable_children (base_class)) {
				write_inherited_members_headline ();
				headline_printed = true;
			}

			write_inherited_symbols_note (base_class, "class", container);
			base_class = unpack_type_reference (base_class.base_type) as Class;
		}


		// interfaces:
		Vala.Collection<Interface> printed_interfaces = new Vala.ArrayList<Interface> ();
		foreach (TypeReference pre_ref in iface.get_full_implemented_interface_list ()) {
			Interface pre = (Interface) unpack_type_reference (pre_ref);

			if (!headline_printed && has_visible_inheritable_children (pre)) {
				write_inherited_members_headline ();
				headline_printed = true;
			} else if (printed_interfaces.contains (pre)) {
				continue ;
			}

			write_inherited_symbols_note (pre, "interface", container);
			printed_interfaces.add (pre);
		}
	}

	private void write_inherited_symbols_note_for_struct (Struct str, Api.Node container) {
		Struct base_struct = unpack_type_reference (str.base_type) as Struct;
		if (base_struct != null && has_visible_inheritable_children (base_struct)) {
			write_inherited_members_headline ();
			write_inherited_symbols_note (base_struct, "struct", container);
		}
	}

	private void write_inherited_symbols_note (TypeSymbol symbol, string type, Api.Node container) {
		write_known_symbols_note (symbol.get_children_by_types (inheritable_members, false),
								  container,
								  "All known members inherited from %s %s".printf (type, symbol.get_full_name ()));

		/*
		write_known_symbols_note (symbol.get_children_by_type (NodeType.CONSTANT, false),
			container,
			"All known constants inherited from %s %s".printf (type, symbol.get_full_name ()));
		write_known_symbols_note (symbol.get_children_by_type (NodeType.PROPERTY, false),
			container,
			"All known properties inherited from %s %s".printf (type, symbol.get_full_name ()));
		write_known_symbols_note (symbol.get_children_by_type (NodeType.DELEGATE, false),
			container,
			"All known delegates inherited from %s %s".printf (type, symbol.get_full_name ()));
		write_known_symbols_note (symbol.get_children_by_type (NodeType.STATIC_METHOD, false),
			container,
			"All known static methods inherited from %s %s".printf (type, symbol.get_full_name ()));
		write_known_symbols_note (symbol.get_children_by_type (NodeType.METHOD, false),
			container,
			"All known methods inherited from %s %s".printf (type, symbol.get_full_name ()));
		write_known_symbols_note (symbol.get_children_by_type (NodeType.SIGNAL, false),
			container,
			"All known signals inherited from %s %s".printf (type, symbol.get_full_name ()));
		write_known_symbols_note (symbol.get_children_by_type (NodeType.FIELD, false),
			container,
			"All known fields inherited from  %s %s".printf (type, symbol.get_full_name ()));
		*/
	}

	protected void write_child_namespaces (Api.Node node, Api.Node? parent) {
		Vala.ArrayList<Namespace> namespaces = new Vala.ArrayList<Namespace> ();
		this.fetch_subnamespace_names (node, namespaces);

		if (namespaces.size == 0) {
			return;
		}

		if (namespaces.size == 1) {
			if (namespaces.get(0).name == null) {
				return;
			}
		}

		bool with_childs = parent != null && parent is Package;

		writer.start_tag ("h3", {"class", css_title})
			.text ("Namespaces:")
			.end_tag ("h3");
		writer.start_tag ("ul", {"class", css_inline_navigation});
		foreach (Namespace child in namespaces) {
			if (child.name != null) {
				writer.start_tag ("li", {"class", cssresolver.resolve (child)});
				writer.link (get_link (child, parent), child.name);
				if (has_brief_description (child)) {
					writer.text (" - ");
					this.write_brief_description (child, parent);
				}
				writer.end_tag ("li");
				if (with_childs == true) {
					write_children (child, Api.NodeType.INTERFACE, "Interfaces", parent);
					write_children (child, Api.NodeType.CLASS, "Classes", parent);
					write_children (child, Api.NodeType.STRUCT, "Structs", parent);
					write_children (child, Api.NodeType.ENUM, "Enums", parent);
					write_children (child, Api.NodeType.ERROR_DOMAIN, "Error domains", parent);
					write_children (child, Api.NodeType.CONSTANT, "Constants", parent);
					write_children (child, Api.NodeType.DELEGATE, "Delegates", parent);
					write_children (child, Api.NodeType.METHOD, "Methods", parent);
					write_children (child, Api.NodeType.FIELD, "Fields", parent);
				}
			}
		}
		writer.end_tag ("ul");
	}

	protected void write_child_dependencies (Package package, Api.Node? parent) {
		Vala.Collection<Package>? deps = package.get_full_dependency_list ();
		if (deps.size == 0) {
			return;
		}

		writer.start_tag ("h2", {"class", css_title})
			.text ("Dependencies:")
			.end_tag ("h2");
		writer.start_tag ("ul", {"class", css_inline_navigation});
		foreach (Package p in deps) {
			string? link = this.get_link (p, parent);
			if (link == null) {
				writer.start_tag ("li", {"class", cssresolver.resolve (p), "id", p.name})
					.text (p.name)
					.end_tag ("li");
			} else {
				writer.start_tag ("li", {"class", cssresolver.resolve (p)});
				writer.link (get_link (p, parent), p.name);
				writer.end_tag ("li");
			}
		}
		writer.end_tag ("ul");
	}

	protected void write_children (Api.Node node, Api.NodeType type, string type_string, Api.Node? container) {
		var children = node.get_children_by_type (type);
		if (children.size > 0) {
			// Follow Vala.Codewriter.visit_struct() and don't sort struct fields
			if (!(node is Api.Struct && type == Api.NodeType.FIELD)) {
				children.sort ((CompareDataFunc) Api.Node.compare_to);
			}
			writer.start_tag ("h3", {"class", css_title})
				.text (type_string)
				.text (":")
				.end_tag ("h3");
			writer.start_tag ("ul", {"class", css_inline_navigation});
			foreach (Api.Node child in children) {
				writer.start_tag ("li", {"class", cssresolver.resolve (child)});
				if (is_internal_node (child)) {
					if (child is Symbol && ((Symbol) child).is_deprecated) {
						writer.start_tag ("span", {"class", css_deprecated});
						writer.link (get_link (child, container), child.name);
						writer.end_tag ("span");
					} else {
						writer.link (get_link (child, container), child.name);
					}
					if (has_brief_description (child)) {
						writer.text (" - ");
						write_brief_description (child, container);
					}
				} else {
					writer.start_tag ("span", {"class", css_leaf_code_definition});
					if (child is Symbol && ((Symbol) child).is_deprecated) {
						writer.start_tag ("span", {"class", css_deprecated});
						write_signature (child, container);
						writer.end_tag ("span");
					} else {
						write_signature (child, container);
					}
					writer.end_tag ("span");

					writer.start_tag ("div", {"class", css_leaf_brief_description});
					write_brief_description (child, container);
					writer.end_tag ("div");
				}
				writer.end_tag ("li");
			}
			writer.end_tag ("ul");
		}
	}

	protected void write_image_block (Api.Node element) {
		if (element is Class || element is Interface || element is Struct) {
			unowned string format = (settings.use_svg_images ? "svg" : "png");
			var chart = new Charts.Hierarchy (image_factory, element);
			chart.save (this.get_img_path (element, format), format);

			writer.start_tag ("h2", {"class", css_title})
				.text ("Object Hierarchy:")
				.end_tag ("h2");

			writer.simple_tag ("img", {"class",
									   css_diagram,
									   "usemap",
									   "#"+element.get_full_name (),
									   "alt",
									   "Object hierarchy for %s".printf (element.name),
									   "src",
									   this.get_img_path_html (element, format)});
			writer.add_usemap (chart);
		}
	}

	public void write_namespace_content (Namespace node, Api.Node? parent) {
		writer.start_tag ("div", {"class", css_style_content});
		writer.start_tag ("h1", {"class", css_title})
			.text (node.name == null ? "Global Namespace" : node.get_full_name ())
			.end_tag ("h1");
		writer.simple_tag ("hr", {"class", css_hr});
		writer.start_tag ("h2", {"class", css_title})
			.text ("Description:")
			.end_tag ("h2");

		this.write_documentation (node, parent);

		writer.start_tag ("h2", {"class", css_title})
			.text ("Content:")
			.end_tag ("h2");

		if (node.name == null) {
			this.write_child_namespaces ((Package) node.parent, parent);
		} else {
			this.write_child_namespaces (node, parent);
		}

		write_children (node, Api.NodeType.INTERFACE, "Interfaces", parent);
		write_children (node, Api.NodeType.CLASS, "Classes", parent);
		write_children (node, Api.NodeType.STRUCT, "Structs", parent);
		write_children (node, Api.NodeType.ENUM, "Enums", parent);
		write_children (node, Api.NodeType.ERROR_DOMAIN, "Error domains", parent);
		write_children (node, Api.NodeType.CONSTANT, "Constants", parent);
		write_children (node, Api.NodeType.DELEGATE, "Delegates", parent);
		write_children (node, Api.NodeType.METHOD, "Functions", parent);
		write_children (node, Api.NodeType.FIELD, "Fields", parent);
		writer.end_tag ("div");
	}

	protected void write_package_content (Package node, Api.Node? parent) {
		writer.start_tag ("div", {"class", css_style_content});
		writer.start_tag ("h1", {"class", css_title, "id", node.name})
			.text (node.name)
			.end_tag ("h1");
		writer.simple_tag ("hr", {"class", css_headline_hr});
		writer.start_tag ("h2", {"class", css_title})
			.text ("Description:")
			.end_tag ("h2");


		WikiPage? wikipage = (tree.wikitree == null)? null : tree.wikitree.search (wiki_index_name);
		if (wikipage != null) {
			_renderer.set_container (parent);
			_renderer.render (wikipage.documentation);
		}

		writer.start_tag ("h2", {"class", css_title})
			.text ("Content:")
			.end_tag ("h2");

		this.write_child_namespaces (node, parent);

		foreach (Api.Node child in node.get_children_by_type (Api.NodeType.NAMESPACE)) {
			if (child.name == null) {
				write_children (child, Api.NodeType.INTERFACE, "Interfaces", parent);
				write_children (child, Api.NodeType.CLASS, "Classes", parent);
				write_children (child, Api.NodeType.STRUCT, "Structs", parent);
				write_children (child, Api.NodeType.ENUM, "Enums", parent);
				write_children (child, Api.NodeType.ERROR_DOMAIN, "Error domains", parent);
				write_children (child, Api.NodeType.CONSTANT, "Constants", parent);
				write_children (child, Api.NodeType.DELEGATE, "Delegates", parent);
				write_children (child, Api.NodeType.METHOD, "Functions", parent);
				write_children (child, Api.NodeType.FIELD, "Fields", parent);
			}
		}

		this.write_child_dependencies (node, parent);
		writer.end_tag ("div");
	}

	protected void write_file_header (string css, string js, string? title) {
		writer.start_tag ("html");
		writer.start_tag ("head");
		writer.simple_tag ("meta", {"charset", "UTF-8"});
		if (title == null) {
			writer.start_tag ("title")
				.text ("Vala Binding Reference")
				.end_tag ("title");
		} else {
			writer.start_tag ("title")
				.text (title)
				.text (" &ndash; Vala Binding Reference")
				.end_tag ("title");
		}
		writer.stylesheet_link (css);
		writer.javascript_link (js);
		writer.end_tag ("head");
		writer.start_tag ("body");
		writer.start_tag ("div", {"class", css_site_header});
		writer.text ("%s Reference Manual".printf (title == null ? "" : title));
		writer.end_tag ("div");
		writer.start_tag ("div", {"class", css_style_body});
	}

	protected void write_file_footer () {
		writer.end_tag ("div");
		writer.simple_tag ("br");
		writer.start_tag ("div", {"class", "site_footer"});
		writer.text ("Generated by ");
		writer.link ("https://wiki.gnome.org/Projects/Valadoc", "<kbd>valadoc</kbd>");
		writer.end_tag ("div");
		writer.end_tag ("body");
		writer.end_tag ("html");
	}
}

