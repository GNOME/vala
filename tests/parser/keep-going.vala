// tester for keep-going mode
// searches for a valid code node at the position

public int compare_positions (uint lineno, uint charno, uint olineno, uint ocharno) {
    return lineno > olineno ? 1 :
        (lineno == olineno ?
         (charno > ocharno ? 1 :
          (charno == ocharno ? 0 : -1)) : -1);
}

class FindSymbol : Vala.CodeVisitor {
    uint lineno;
    uint charno;
    public Vala.CodeNode[] results = {};

    public FindSymbol (Vala.SourceFile source_file, uint lineno, uint charno) {
        this.lineno = lineno;
        this.charno = charno;
        this.visit_source_file (source_file);
    }

    public Vala.CodeNode? get_code_node_from_type_name (string type_name) {
        foreach (var node in results)
            if (node.type_name == type_name)
                return node;
        return null;
    }

    private bool match_node (Vala.CodeNode node) {
        Vala.SourceLocation begin_sl = node.source_reference.begin;
        Vala.SourceLocation end_sl = node.source_reference.end;

        return compare_positions ((uint) begin_sl.line, (uint) begin_sl.column, lineno, charno) <= 0 &&
            compare_positions (lineno, charno, (uint) end_sl.line, (uint) end_sl.column) <= 0;
    }

    public override void visit_assignment (Vala.Assignment a) {
        if (match_node (a))
            results += a;
        a.accept_children (this);
    }

    public override void visit_block (Vala.Block b) {
        b.accept_children (this);
    }

    public override void visit_class (Vala.Class cl) {
        cl.accept_children (this);
    }

    public override void visit_declaration_statement (Vala.DeclarationStatement stmt) {
        if (match_node (stmt))
            results += stmt;
        stmt.accept_children (this);
    }

    public override void visit_expression (Vala.Expression expr) {
        if (match_node (expr))
            results += expr;
        expr.accept_children (this);
    }

    public override void visit_expression_statement (Vala.ExpressionStatement stmt) {
        if (match_node (stmt))
            results += stmt;
        stmt.accept_children (this);
    }

    public override void visit_method (Vala.Method m) {
        m.accept_children (this);
    }

    public override void visit_namespace (Vala.Namespace ns) {
        ns.accept_children (this);
    }

    public override void visit_source_file (Vala.SourceFile source_file) {
        source_file.accept_children (this);
    }

    public override void visit_try_statement (Vala.TryStatement stmt) {
        stmt.accept_children (this);
    }
}

string? location_str = null;
string? profile_str = null;
string? node_type = null;
[CCode (array_length = false, array_null_terminated = true)]
string[] filenames;

const OptionEntry[] options = {
    { "node-type", 't', 0, OptionArg.STRING, ref node_type, "Type of node requested, in glib format, like `ValaSymbol'", "TypeName" },
    { "location", 'l', 0, OptionArg.STRING, ref location_str, "Location in document where a ValaSymbol is expected", "LINENO:CHARNO" },
    { "profile", 'p', 0, OptionArg.STRING, ref profile_str, "Profile, either POSIX or GOBJECT (default)", null },
    { OPTION_REMAINING, 0, 0, OptionArg.FILENAME_ARRAY, ref filenames, "Input source file", "FILE" }, 
    { null }
};

int main(string[] args) {
    try {
        var opt_context = new OptionContext ();
        opt_context.set_help_enabled (true);
        opt_context.add_main_entries (options, null);
        opt_context.parse (ref args);
    } catch (OptionError e) {
        printerr ("error: %s\n", e.message);
        printerr ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
        return 1;
    }

    if (filenames.length == 0) {
        printerr ("error: filename required\n");
        printerr ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
        return 1;
    } else if (filenames.length > 1) {
        printerr ("error: too many filenames\n");
        printerr ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
        return 1;
    } else if (location_str == null) {
        printerr ("error: location required\n");
        printerr ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
        return 1;
    }

    string filename = filenames[0];

    if (node_type == null) {
        printerr ("error: no node type given\n");
        printerr ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
        return 1;
    }

    uint lineno, charno;
    MatchInfo match_info;
    if (/^(\d+):(\d+$)/.match (location_str, 0, out match_info)) {
        lineno = uint.parse (match_info.fetch (1));
        charno = uint.parse (match_info.fetch (2));
    } else {
        printerr ("error: invalid location given\n");
        printerr ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
        return 1;
    }

    var context = new Vala.CodeContext () { keep_going = true };
    Vala.CodeContext.push (context);
    string implicit_ns;

    if (profile_str == null || profile_str == "GOBJECT") {
        context.add_external_package ("glib-2.0");
        context.add_external_package ("gobject-2.0");
        context.add_define ("GOBJECT");
        implicit_ns = "GLib";
    } else if (profile_str == "POSIX") {
        context.add_external_package ("posix");
        context.add_define ("POSIX");
        implicit_ns = "Posix";
    } else {
        printerr ("error: invalid profile given\n");
        printerr ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
        Vala.CodeContext.pop ();
        return 1;
    }

    var source_file = new Vala.SourceFile (context, Vala.SourceFileType.SOURCE, (!) filename);
    context.add_source_file (source_file);

    // import the GLib/Posix namespace by default (namespace of backend-specific standard library)
    var ns_ref = new Vala.UsingDirective (new Vala.UnresolvedSymbol (null, implicit_ns, null));
    source_file.add_using_directive (ns_ref);
    context.root.add_using_directive (ns_ref);

    var vala_parser = new Vala.Parser ();
    var genie_parser = new Vala.Genie.Parser ();
    var gir_parser = new Vala.GirParser ();

    vala_parser.parse (context);
    genie_parser.parse (context);
    gir_parser.parse (context);
    context.check ();

    var fs = new FindSymbol (source_file, lineno, charno);
    Vala.CodeNode? found = fs.get_code_node_from_type_name (node_type);

    if (fs.results.length == 0) {
        printerr ("error: no code node found at %u:%u\n", lineno, charno);
        Vala.CodeContext.pop ();
        return 1;
    } else if (fs.results.length > 0 && found == null) {
        foreach (var node in fs.results)
            printerr ("error: found code node `%s' (%s) at %u:%u\n", node.to_string (), node.type_name, lineno, charno);
        Vala.CodeContext.pop ();
        return 1;
    } else {
        print ("success: found `%s' (%s) at %u:%u\n", found.to_string (), found.type_name, lineno, charno);
        Vala.CodeContext.pop ();
        return 0;
    }
}
