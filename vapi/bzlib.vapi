[CCode (cheader_filename = "bzlib.h")]
namespace BZLib {
    [CCode (cname = "int", cprefix = "BZ_")]
    public enum Action {
        RUN,
        FLUSH,
        FINISH
    }
    
    [CCode (cname = "int", cprefix = "BZ_")]
    public enum Status {
        OK,
        RUN_OK,
        FLUSH_OK,
        FINISH_OK,
        STREAM_END,
        SEQUENCE_ERROR,
        MEM_ERROR,
        DATA_ERROR,
        DATA_ERROR_MAGICK,
        IO_ERROR,
        UNEXPECTED_EOF,
        OUTBUFF_FULL,
        CONFIG_ERROR
    }
    
    //DO NOT HAVE Alloc NOR Free VARIABLES!!!
    public delegate void *Alloc (void *opaque, int n, int m);
    public delegate void Free (void *opaque, void *pointer);
    
    [CCode (cname = "bz_stream", free_function = "g_free")]
    public class Stream {
        public string next_in;
        public uint avail_in;
        public uint totoal_in_lo32;
        public uint total_in_hi32;
        public string next_out;
        public uint avail_out;
        public uint totoal_out_lo32;
        public uint total_out_hi32;
        public void *state;
        //Set Alloc and Free to NULL!
        [CCode (cname = "bzalloc")];
        public Alloc alloc;
        [CCode (cname = "bzfree")];
        public Free free;
        public void *opaque;
        [CCode (cname = "BZ2_bzDecompressInit")]
        public Status compress_init (int block_size_100k, int verbosity, int work_factor);
        [CCode (cname = "BZ2_bzDecompress")]
        public Status compress (Action action);
        [CCode (cname = "BZ2_bzDecompressEnd")]
        public Status compress_end ();
        [CCode (cname = "BZ2_bzDecompressInit")]
        public Status decompress_init (int verbosity, int small);
        [CCode (cname = "BZ2_bzDecompress")]
        public Status decompress ();
        [CCode (cname = "BZ2_bzDecompressEnd")]
        public Status decompress_end ();
    }
}
