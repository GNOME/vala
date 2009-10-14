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


public class Valadoc.Tree : Vala.CodeVisitor {
	private Gee.ArrayList<Package> packages = new Gee.ArrayList<Package>();
	private Package source_package = null;
	private Valadoc.Settings settings;
	private CodeContext context;
	private ErrorReporter reporter;
	private Package sourcefiles = null;

	public WikiPageTree? wikitree {
		private set;
		get;
	}

	public Gee.Collection<Package> get_package_list () {
		return this.packages.read_only_view;
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

	private Api.Node? search_relative_to (Api.Node element, string[] path) {
		Api.Node? node = element;
		foreach (string name in path) {
			node = node.find_by_name (name);
			if (node == null) {
				break;
			}
		}

		if (node == null && element.parent != null) {
			node = search_relative_to ((Api.Node) element.parent, path);
		}

		return node;
	}

	public DocumentedElement? search_symbol_str (DocumentedElement? element, string symname) {
		string[] path = split_name (symname);

		if (element == null) {
			Api.Node? node = null;
			foreach (Package packgage in packages) {
				node = search_relative_to (packgage, path);
				if (node != null) {
					return (DocumentedElement) node;
				}
			}
			return null;
		}

		return (DocumentedElement) search_relative_to ((Api.Node) element, path);
	}

	private string[] split_name (string full_name) {
		string[] params = full_name.split( ".", -1 );
		int i = 0; while ( params[i] != null ) i++;
		params.length = i;
		return params;
	}

	public override void visit_namespace ( Vala.Namespace vns ) {
		vns.accept_children ( this );
	}

	public override void visit_class ( Vala.Class vcl ) {
		if ( vcl.parent_symbol is Vala.Namespace == false )
			return ;

		Vala.SourceFile vfile = vcl.source_reference.file;
		Package file = this.find_file(vfile);
		Namespace ns = file.get_namespace (vcl);
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


					if (this.sourcefiles == null) {
						this.sourcefiles = new Package (this.settings, source_file, this, false);
						this.packages.add (this.sourcefiles);
					}
					else {
						this.sourcefiles.add_file (source_file);
					}

					if (context.profile == Profile.POSIX) {
						// import the Posix namespace by default (namespace of backend-specific standard library)
						var ns_ref = new UsingDirective (new UnresolvedSymbol (null, "Posix", null));
						source_file.add_using_directive (ns_ref);
						context.root.add_using_directive (ns_ref);
					} else if (context.profile == Profile.GOBJECT) {
						// import the GLib namespace by default (namespace of backend-specific standard library)
						var ns_ref = new UsingDirective (new UnresolvedSymbol (null, "GLib", null));
						source_file.add_using_directive (ns_ref);
						context.root.add_using_directive (ns_ref);
					}

					context.add_source_file (source_file);
				} else if (source.has_suffix (".vapi")) {
					var vfile = new SourceFile (context, rpath, true);
					Package vdpkg = new Package (this.settings, vfile, this); 
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
		Vala.Parser parser = new Vala.Parser ();
		parser.parse (this.context);
		if (this.context.report.get_errors () > 0) {
			return false;
		}

		Vala.SymbolResolver resolver = new SymbolResolver ();
		resolver.resolve(this.context);
		if (this.context.report.get_errors () > 0) {
			return false;
		}

		Vala.SemanticAnalyzer analyzer = new SemanticAnalyzer ( );
		analyzer.analyze(this.context);
		if (this.context.report.get_errors () > 0) {
			return false;
		}

		if (context.non_null_experimental) {
			Vala.NullChecker null_checker = new NullChecker ();
			null_checker.check (this.context);

			if (this.context.report.get_errors () > 0) {
				return false;
			}
		}

		this.context.accept(this);
		this.resolve_type_references ();
		this.add_dependencies_to_source_package ();
		return true;
	}

	internal Package? find_file (Vala.SourceFile vfile) {
		foreach (Package pkg in this.packages) {
			if (pkg.is_vpackage(vfile))
				return pkg;
		}
		return null;
	}

	private void resolve_type_references () {
		foreach (Package pkg in this.packages) {
			pkg.resolve_type_references();
		}
	}

	public void parse_comments (DocumentationParser docparser) {
		this.wikitree = new WikiPageTree(this.reporter, this.settings);
		wikitree.create_tree (docparser);

		foreach (Package pkg in this.packages) {
			pkg.parse_comments(docparser);
		}
	}

	internal DocumentedElement? search_vala_symbol (Vala.Symbol? vnode) {
		if (vnode == null)
			return null;

		Gee.ArrayList<Vala.Symbol> params = new Gee.ArrayList<Vala.Symbol> ();
		for (Vala.Symbol iter = vnode; iter != null ; iter = iter.parent_symbol) {
			if (iter is Vala.DataType)
				params.insert (0, ((Vala.DataType)iter).data_type);
			else
				params.insert (0, iter);
		}

		if (params.size == 0)
			return null;

		if (params.size >= 2) {
			if (params.get(1) is Vala.Namespace) {
				params.remove_at (0);
			}
		}

		Vala.SourceFile vfile = vnode.source_reference.file;
		Package file = this.find_file(vfile);

		Api.Node? node = file;
		foreach (Symbol symbol in params) {
			node = node.find_by_symbol (symbol);
			if (node == null) {
				return null;
			}
		}
		return node;
	}

	private Package? get_external_package_by_name (string name) {
		foreach (Package pkg in this.packages) {
			if (name == pkg.name) {
				return pkg;
			}
		}
		return null;
	}

}

