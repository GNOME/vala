/* zlib.vala
 *
 * Copyright (C) 2006-2009  Raffaele Sandrini, Jürg Billeter, Evan Nemerson
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 * 	Jürg Billeter <j@bitron.ch>
 * 	Evan Nemerson <evan@polussystems.com>
 */

using GLib;

[CCode (lower_case_cprefix = "", cheader_filename = "zlib.h")]
namespace ZLib {
	[CCode (cprefix = "ZLIB_VER_")]
	namespace VERSION {
		[CCode (cname = "ZLIB_VERSION")]
		public const string STRING;
		[CCode (cname = "ZLIB_VERNUM")]
		public const int NUMBER;
		public const int MAJOR;
		public const int MINOR;
		public const int REVISION;
	}

	[CCode (cprefix = "Z_")]
	namespace Flush {
		[CCode (cname = "Z_NO_FLUSH")]
		public const int NONE;
		[CCode (cname = "Z_SYNC_FLUSH")]
		public const int SYNC;
		[CCode (cname = "Z_FULL_FLUSH")]
		public const int FULL;
		public const int FINISH;
		public const int BLOCK;
	}

	[CCode (cprefix = "Z_")]
	namespace Status {
		public const int OK;
		public const int STREAM_END;
		public const int NEED_DICT;
		public const int ERRNO;
		public const int STREAM_ERROR;
		public const int DATA_ERROR;
		public const int MEM_ERROR;
		public const int BUF_ERROR;
		public const int VERSION_ERROR;
	}

	namespace Compression {
		[CCode (cname = "Z_NO_COMPRESSION")]
		public const int NONE;
		[CCode (cname = "Z_BEST_SPEED")]
		public const int BEST_SPEED;
		[CCode (cname = "Z_BEST_COMPRESSION")]
		public const int BEST_COMPRESSION;
		[CCode (cname = "Z_DEFAULT_COMPRESSION")]
		public const int DEFAULT;
	}

	[CCode (cprefix = "Z_")]
	namespace Strategy {
		public const int FILTERED;
		public const int HUFFMAN_ONLY;
		public const int RLE;
		public const int FIXED;
		[CCode (cname = "Z_DEFAULT_STRATEGY")]
		public const int DEFAULT;
	}

	[CCode (cprefix = "Z_")]
	namespace Data {
		public const int BINARY;
		public const int TEXT;
		public const int ASCII;
		public const int UNKNOWN;
	}

	[CCode (cprefix = "Z_")]
	namespace Algorithm {
		public const int DEFLATED;
	}

	[CCode (cname = "z_stream", destroy_function = "deflateEnd")]
	public struct Stream {
		[CCode (array_length_cname = "avail_in", array_length_type = "guint")]
		public uchar[] next_in;
		public ulong total_in;

		[CCode (array_length_cname = "avail_out", array_length_type = "guint")]
		public uchar[] next_out;
		public ulong total_out;

		public string? msg;

		public int data_type;
		public ulong adler;
	}

	[CCode (cname = "z_stream", destroy_function = "deflateEnd")]
	public struct DeflateStream : Stream {
		[CCode (cname = "deflateInit")]
		public DeflateStream (int level = Compression.DEFAULT);
		[CCode (cname = "deflateInit2")]
		public DeflateStream.full (int level, int method, int windowBits, int memLevel, int strategy);

		[CCode (cname = "deflate")]
		public int deflate (int flush);
		[CCode (cname = "deflateSetDictionary")]
		public int set_dictionary ([CCode (array_length_type = "guint")] uchar[] dictionary);
		[CCode (cname = "deflateCopy", instance_pos = 0)]
		public int copy (DeflateStream dest);
		[CCode (cname = "deflateReset")]
		public int reset ();
		[CCode (cname = "deflateParams")]
		public int params (int level, int strategy);
		[CCode (cname = "deflateTune")]
		public int tune (int good_length, int max_lazy, int nice_length, int max_chain);
		[CCode (cname = "deflateBound")]
		public ulong bound (ulong sourceLen);
		[CCode (cname = "deflatePrime")]
		public int prime (int bits, int value);
		[CCode (cname = "deflateSetHeader")]
		public int set_header (GZHeader head);
	}

	[CCode (cname = "z_stream", destroy_function = "inflateEnd")]
	public struct InflateStream : Stream {
		[CCode (cname = "inflateInit")]
		public InflateStream ();
		[CCode (cname = "inflateInit2")]
		public InflateStream.full (int windowBits);

		[CCode (cname = "inflate")]
		public int inflate (int flush);
		[CCode (cname = "inflateSetDictionary")]
		public int set_dictionary ([CCode (array_length_type = "guint")] uchar[] dictionary);
		[CCode (cnmae = "inflateSync")]
		public int sync ();
		public int reset ();
		public int prime (int bits, int value);
		public int get_header (out GZHeader head);
	}

	namespace Utility {
		[CCode (cname = "compress2")]
		public static int compress ([CCode (array_length_type = "gulong")] uchar[] dest, [CCode (array_length_type = "gulong")] uchar[] source, int level = Compression.DEFAULT);
		[CCode (cname = "compressBound")]
		public static int compress_bound (ulong sourceLen);

		public static int uncompress ([CCode (array_length_type = "gulong")] uchar[] dest, [CCode (array_length_type = "gulong")] uchar[] source);
	}

	[CCode (cname = "gz_header")]
	public struct GZHeader {
		public int text;
		public ulong time;
		public int xflags;
		public int os;
		[CCode (array_length_name = "extra_len", array_length_type = "guint")]
		public uchar[] extra;
		public uint extra_max;
		public string? name;
		public uint name_max;
		public string comment;
		[CCode (cname = "comm_max")]
		public uint comment_max;
		public int hcrc;
		public int done;
	}

	[CCode (cname = "gzFile", cprefix = "gz", free_function = "gzclose")]
	public class GZFileStream {
		public static GZFileStream open (string path, string mode);
		public static GZFileStream dopen (int fd, string mode);
		public int setparams (int level, int strategy);
		public int read (char[] buf);
		public int write (char[] buf);
		[PrintfFormat]
		public int printf (string format, ...);
		public int puts (string s);
		public weak string gets (char[] buf);
		public int flush (int flush);
		public int rewind ();
		public bool eof ();
		public bool direct ();
	}
}
