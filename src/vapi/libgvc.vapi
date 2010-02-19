

[CCode (cprefix = "")]
namespace Graphviz {


//check the headerfile, 	// rename
[CCode (cprefix = "", cheader_filename="gvc.h")]
public enum GraphType { // => GraphKind
	AGDIGRAPHSTRICT,
	AGRAPHSTRICT,
	AGDIGRAPH,
	AGRAPH
}



[CCode (cname = "aginitlib", cheader_filename="gvc.h")]
public void init ( size_t graphinfo, size_t nodeinfo, size_t  edgeinfo);


// rename enum values
[CCode (cname = "agerrlevel_t", cheader_filename = "gvc.h", cprefix = "")]
public enum ErrorLevel {
	AGWARN,
	AGERR,
	AGMAX,
	AGPREV
}

[CCode(cprefix = "ag")]
namespace Error {
	[CCode (cname = "agerrno")]
	public static ErrorLevel errno;

	[CCode (cname = "agerr")]
	public static int error( ErrorLevel level, string fmt, ...);

	[CCode (cname = "agerrors")]
	public static int errors( );

	[CCode (cname = "agseterr")]
	public static void set_error( ErrorLevel err );

	[CCode (cname = "aglasterr")]
	public static string? last_error( );

	// rename
	[CCode (cname = "agerrorf")] // name?
	public static void errorf( string format, ...);

	// rename
	[CCode (cname = "agwarningf")]
	void warningf( string fmt, ...);
}


// -> parser: static class
//	[CCode (cname = "agreadline")]
//	public void read_line(int);

//	[CCode (cname = "agsetfile")]
//	public void set_file( string filename );


//	char *gvUsername(void);




//
//-> class string: (I think we don't need that for the api.)
//[CCode (cname = "agstrdup")]
//extern char *agstrdup(char *);
//[CCode (cname = "agstrfree")]
//extern void agstrfree(char *);
//[CCode (cname = "agcanon")]
//char * 	agcanon (char *)
//[CCode (cname = "agstrcanon")]
//char *agstrcanon(char *, char *);
//[CCode (cname = "agcanonical")]
//char *agcanonical(char *);
//[CCode (cname = "aghtmlstr")]
//int aghtmlstr(char *s);
//[CCode (cname = "agstrdup_html")]
//char *agstrdup_html(char *s);





[Compact]
[CCode (cname = "rank_t", cheader_filename = "gvc.h", free_function = "", cprefix = "")]
public class Rank {

}

[Compact]
[CCode (cname = "Agraph_t", cheader_filename = "gvc.h", free_function = "agclose", cprefix = "")]
// AGraph
public class Graph {
	//[CCode (cname = "agmemread")]
	//public static Graph? mem_read( char[] mem ); // some internal cast-magic caused damage to my brain
	//public void attach_attrs( );

	[CCode (cname = "agread")]
	public static Graph read (GLib.FileStream file );

	[CCode (cname = "AG_IS_DIRECTED")]
	public bool is_directed ( );

	[CCode (cname = "AG_IS_STRICT")]
	public bool is_strict ( );

	//
	[CCode (cname = "agraphattr")]
	public Sym attribute ( string name, string val );

	[CCode (cname = "agfstattr")]
	public weak Sym first_attribute ( );

	[CCode (cname = "aglstattr")]
	public weak Sym last_attribute ( );

	[CCode (cname = "agnxtattr")]
	public weak Sym next_attribute ( Sym sym );

	[CCode (cname = "agprvattr")]
	public weak Sym previous_attribute ( Sym sym );

	//
	[CCode (cname = "agget")]
	public string get( string name );

	//
	[CCode (cname = "agxget")]
	public string get_index( int index );

	[CCode (cname = "agset")]
	public int set(string attr, string val);

	[CCode (cname = "agxset")]
	public int set_index( int index, char[] buf );

	[CCode (cname = "agindex")]
	public int index ( string name );

	[CCode (cname = "agsafeset")]
	public int set_safe( string name, string val, string def );

	[CCode (cname = "agopen")]
	public static Graph open ( string name, GraphType kind );

	//
	[CCode (cname = "agsubg")]
	public weak Graph subgraph( string name );

	[CCode (cname = "agfindsubg")]
	public weak Graph find_sub_graph ( string name );

	[CCode (cname = "agwrite")]
	public int write( GLib.FileStream file );

	[CCode (cname = "agprotograph")]
	public static Graph proto_graph ( );

	[CCode (cname = "agusergraph")]
	public static Graph user_graph( Node n );

	[CCode (cname = "agnnodes")]
	public int n_nodes( );

	[CCode (cname = "agnedges")]
	public int n_edges( );

	[CCode (cname = "aginsert")]
	public void insert( void* obj );

	[CCode (cname = "agdelete")]
	public void delete( void* obj );

	[CCode (cname = "agcontains")]
	public int contains( void* obj );

	// make sure that the returned note is really freed by this class
	[CCode (cname = "agnode")]
	public weak Node node ( string str );

	//
	[CCode (cname = "agnodeattr")]
	Sym node_attribute ( string name, string val );

	[CCode (cname = "agfindnode")]
	public weak Node find_node( string name );

	[CCode (cname = "agfstnode")]
	public weak Node first_node( );

	[CCode (cname = "agnxtnode")]
	public weak Node next_node( Node n );

	[CCode (cname = "aglstnode")]
	public weak Node last_node( );

	[CCode (cname = "agprvnode")]
	public weak Node prev_node( Node n );

	[CCode (cname = "agedge")]
	public weak Edge edge( Node tail, Node head );

	[CCode (cname = "agedgeattr")]
	public weak Sym edge_attribute( string name, string val );

	[CCode (cname = "agfindedge")]
	public weak Edge find_edge( Node tail, Node head );

	[CCode (cname = "agfstedge")]
	public weak Edge first_edge(Graph g, Node n);

	[CCode (cname = "agnxtedge")]
	public weak Edge next_edge( Edge e, Node n);

	[CCode (cname = "agfstin")]
	public weak Edge first_in( Node n );

	[CCode (cname = "agnxtin")]
	public weak Edge next_in ( Edge e );

	[CCode (cname = "agfstout")]
	public weak Edge first_out( Node n );

	[CCode (cname = "agnxtout")]
	public weak Edge next_out( Edge edge );

	//?
	[CCode (cname = "agraphattr")]
	public Sym graph_attribute ( string name, string val );

	[CCode (cname = "agfindattr")]
	public weak Sym find_attribute ( string name );

	[CCode (cname = "agcopyattr")]
	public int copy_attribute( void* newobj );

	//
	[CCode (cname = "agprotonode")]
	public Node proto_node ( );

	//
	[CCode (cname = "agprotoedge")]
	public Edge proto_edge ( );
}



// Fill in!
[Compact]
[CCode (cname = "Agnode_t", cheader_filename = "gvc.h", free_function = "agFREEnode", cprefix = "")]
public class Node {
	[CCode (cname = "agsafeset")]
	public int set_safe( string name, string val, string def );

	[CCode (cname = "agfindattr")]
	public weak Sym find_attribute ( string name );

	[CCode (cname = "agcopyattr")]
	public int copy_attribute( void* newobj );

	//
	[CCode (cname = "agget")]
	public string get( string name );

	//
	[CCode (cname = "agxget")]
	public string get_index( int index );

	//
	[CCode (cname = "agset")]
	public int set(string attr, string val);

	[CCode (cname = "agxset")]
	public int set_index( int index, char[] buf );

	[CCode (cname = "agindex")]
	public int index ( string name );

	// same as cname="agnode" -> i just tink it is weak
	[CCode (cname = "agattr")]
	public weak Sym attribute ( string name, string val );

	[CCode (cname = "agfstattr")]
	public weak Sym first_attribute ( );

	[CCode (cname = "aglstattr")]
	public weak Sym last_attribute ( );

	[CCode (cname = "agnxtattr")]
	public weak Sym next_attribute ( Sym sym );

	[CCode (cname = "agprvattr")]
	public weak Sym previous_attribute ( Sym sym );
}



// FILL IN! - free function?
[Compact]
[CCode (cname = "Agedge_t", cheader_filename = "gvc.h", cprefix = "")]
public class Edge {
	// 
	[CCode (cname = "agattr")]
	public weak Sym attribute ( string name, string val );

	[CCode (cname = "agfstattr")]
	public weak Sym first_attribute ( );

	[CCode (cname = "aglstattr")]
	public weak Sym last_attribute ( );

	[CCode (cname = "agnxtattr")]
	public weak Sym next_attribute ( Sym sym );

	[CCode (cname = "agprvattr")]
	public weak Sym previous_attribute ( Sym sym );

	[CCode (cname = "agsafeset")]
	public int set_safe( string name, string val, string def );

	[CCode (cname = "agfindattr")]
	public weak Sym find_attribute ( string name );

	//
	[CCode (cname = "agcopyattr")]
	public int copy_attribute( void* newobj );

	//
	[CCode (cname = "agget")]
	public string get( string name );

	//
	[CCode (cname = "agxget")]
	public string get_index( int index );

	[CCode (cname = "agset")]
	public int set(string attr, string val);

	[CCode (cname = "agxset")]
	public int set_index( int index, char[] buf );

	[CCode (cname = "agindex")]
	public int index ( string name );
}



// free function?
[Compact]
[CCode (cname = "Agsym_t", cheader_filename = "gvc.h", cprefix = "")]
public class Sym {
}


[Compact]
[CCode (cname = "GVC_t", cheader_filename = "gvc.h", free_function = "gvFreeContext", cprefix = "")]
public class Context {
	//??
	//GVC_t *gvNEWcontext(char **info, char *user);
	[CCode (cname = "gvParseArgs")]
	public int parse_args ( [CCode (array_length_pos = 0.9)] string[] argv );

	[CCode (cname = "gvContext")]
	public static Context context ( ); // => GraphKind

	[CCode (cname = "gvLayout")]
	public int layout ( Graph g, string engine );

	[CCode (cname = "gvLayoutJobs")]
	public int layout_jobs ( Graph g );	

	[CCode (cname = "gvRender")]
	public int render( Graph g, string format, GLib.FileStream file );

	[CCode (cname = "gvRenderFilename")]
	public int render_filename ( Graph g, string format, string filename);

	[CCode (cname = "gvRenderJobs")]
	public int render_jobs ( Graph g );

	[CCode (cname = "gvFreeLayout")]
	public int free_layout ( Graph g );
}


}

