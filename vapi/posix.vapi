/* posix.vapi
 *
 * Copyright (C) 2008-2009  Jürg Billeter
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
 * 	Jürg Billeter <j@bitron.ch>
 */

[CCode (cprefix = "", lower_case_cprefix = "")]
namespace Posix {
	[CCode (cheader_filename = "assert.h")]
	public void assert (bool expression);

	[CCode (cheader_filename = "errno.h")]
	public int errno;
	[CCode (cheader_filename = "errno.h")]
	public const int E2BIG;
	[CCode (cheader_filename = "errno.h")]
	public const int EACCES;
	[CCode (cheader_filename = "errno.h")]
	public const int EADDRINUSE;
	[CCode (cheader_filename = "errno.h")]
	public const int EADDRNOTAVAIL;
	[CCode (cheader_filename = "errno.h")]
	public const int EAFNOSUPPORT;
	[CCode (cheader_filename = "errno.h")]
	public const int EAGAIN;
	[CCode (cheader_filename = "errno.h")]
	public const int EALREADY;
	[CCode (cheader_filename = "errno.h")]
	public const int EBADF;
	[CCode (cheader_filename = "errno.h")]
	public const int EBADMSG;
	[CCode (cheader_filename = "errno.h")]
	public const int EBUSY;
	[CCode (cheader_filename = "errno.h")]
	public const int ECANCELED;
	[CCode (cheader_filename = "errno.h")]
	public const int ECHILD;
	[CCode (cheader_filename = "errno.h")]
	public const int ECONNABORTED;
	[CCode (cheader_filename = "errno.h")]
	public const int ECONNREFUSED;
	[CCode (cheader_filename = "errno.h")]
	public const int ECONNRESET;
	[CCode (cheader_filename = "errno.h")]
	public const int EDEADLK;
	[CCode (cheader_filename = "errno.h")]
	public const int EDESTADDRREQ;
	[CCode (cheader_filename = "errno.h")]
	public const int EDOM;
	[CCode (cheader_filename = "errno.h")]
	public const int EDQUOT;
	[CCode (cheader_filename = "errno.h")]
	public const int EEXIST;
	[CCode (cheader_filename = "errno.h")]
	public const int EFAULT;
	[CCode (cheader_filename = "errno.h")]
	public const int EFBIG;
	[CCode (cheader_filename = "errno.h")]
	public const int EHOSTUNREACH;
	[CCode (cheader_filename = "errno.h")]
	public const int EIDRM;
	[CCode (cheader_filename = "errno.h")]
	public const int EILSEQ;
	[CCode (cheader_filename = "errno.h")]
	public const int EINPROGRESS;
	[CCode (cheader_filename = "errno.h")]
	public const int EINTR;
	[CCode (cheader_filename = "errno.h")]
	public const int EINVAL;
	[CCode (cheader_filename = "errno.h")]
	public const int EIO;
	[CCode (cheader_filename = "errno.h")]
	public const int EISCONN;
	[CCode (cheader_filename = "errno.h")]
	public const int EISDIR;
	[CCode (cheader_filename = "errno.h")]
	public const int ELOOP;
	[CCode (cheader_filename = "errno.h")]
	public const int EMFILE;
	[CCode (cheader_filename = "errno.h")]
	public const int EMLINK;
	[CCode (cheader_filename = "errno.h")]
	public const int EMSGSIZE;
	[CCode (cheader_filename = "errno.h")]
	public const int EMULTIHOP;
	[CCode (cheader_filename = "errno.h")]
	public const int ENAMETOOLONG;
	[CCode (cheader_filename = "errno.h")]
	public const int ENETDOWN;
	[CCode (cheader_filename = "errno.h")]
	public const int ENETRESET;
	[CCode (cheader_filename = "errno.h")]
	public const int ENETUNREACH;
	[CCode (cheader_filename = "errno.h")]
	public const int ENFILE;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOBUFS;
	[CCode (cheader_filename = "errno.h")]
	public const int ENODATA;
	[CCode (cheader_filename = "errno.h")]
	public const int ENODEV;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOENT;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOEXEC;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOLCK;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOLINK;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOMEM;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOMSG;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOPROTOOPT;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOSPC;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOSR;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOSTR;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOSYS;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOTCONN;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOTDIR;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOTEMPTY;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOTSOCK;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOTSUP;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOTTY;
	[CCode (cheader_filename = "errno.h")]
	public const int ENXIO;
	[CCode (cheader_filename = "errno.h")]
	public const int EOPNOTSUPP;
	[CCode (cheader_filename = "errno.h")]
	public const int EOVERFLOW;
	[CCode (cheader_filename = "errno.h")]
	public const int EPERM;
	[CCode (cheader_filename = "errno.h")]
	public const int EPIPE;
	[CCode (cheader_filename = "errno.h")]
	public const int EPROTO;
	[CCode (cheader_filename = "errno.h")]
	public const int EPROTONOSUPPORT;
	[CCode (cheader_filename = "errno.h")]
	public const int EPROTOTYPE;
	[CCode (cheader_filename = "errno.h")]
	public const int ERANGE;
	[CCode (cheader_filename = "errno.h")]
	public const int EROFS;
	[CCode (cheader_filename = "errno.h")]
	public const int ESPIPE;
	[CCode (cheader_filename = "errno.h")]
	public const int ESRCH;
	[CCode (cheader_filename = "errno.h")]
	public const int ESTALE;
	[CCode (cheader_filename = "errno.h")]
	public const int ETIME;
	[CCode (cheader_filename = "errno.h")]
	public const int ETIMEDOUT;
	[CCode (cheader_filename = "errno.h")]
	public const int ETXTBSY;
	[CCode (cheader_filename = "errno.h")]
	public const int EWOULDBLOCK;
	[CCode (cheader_filename = "errno.h")]
	public const int EXDEV;

	[CCode (cheader_filename = "string.h")]
	public int memcmp (void* s1, void* s2, size_t n);
	[CCode (cheader_filename = "string.h")]
	public unowned string strerror (int errnum);

	[CCode (cheader_filename = "sys/socket.h")]
	public const int SOCK_DGRAM;
	[CCode (cheader_filename = "sys/socket.h")]
	public const int SOCK_RAW;
	[CCode (cheader_filename = "sys/socket.h")]
	public const int SOCK_SEQPACKET;
	[CCode (cheader_filename = "sys/socket.h")]
	public const int SOCK_STREAM;
	[CCode (cheader_filename = "sys/socket.h")]
	public const int AF_INET;
	[CCode (cheader_filename = "sys/socket.h")]
	public const int AF_INET6;
	[CCode (cheader_filename = "sys/socket.h")]
	public const int AF_UNIX;
	[CCode (cheader_filename = "sys/socket.h")]
	public int socket (int domain, int type, int protocol);

	[CCode (cheader_filename = "unistd.h")]
	public int execl (string path, params string[] arg);
}

