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

	[CCode (cheader_filename = "ctype.h")]
	public bool isalnum (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isalpha (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isascii (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool iscntrl (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isdigit (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isgraph (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool islower (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isprint (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool ispunct (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isspace (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isupper (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isxdigit (int c);
	[CCode (cheader_filename = "ctype.h")]
	public int toascii (int c);
	[CCode (cheader_filename = "ctype.h")]
	public int tolower (int c);
	[CCode (cheader_filename = "ctype.h")]
	public int toupper (int c);

	[Compact]
	[CCode (cname = "struct dirent", cheader_filename = "dirent.h")]
	public class DirEnt {
		public ino_t d_ino;
		public off_t d_off;
		public ushort d_reclen;
		public char d_type;
		public char[265] d_name;
		}

	[Compact]
	[CCode (cname = "DIR", free_function = "closedir", cheader_filename = "dirent.h")]
	public class Dir {
	}

	[CCode (cheader_filename = "dirent.h")]
	public int dirfd (Dir dir);
	[CCode (cheader_filename = "dirent.h")]
	public Dir? opendir (string filename);
	[CCode (cheader_filename = "dirent.h")]
	public Dir? fdopendir (int fd);
	[CCode (cheader_filename = "dirent.h")]
	public unowned DirEnt? readdir (Dir dir);
	[CCode (cheader_filename = "dirent.h")]
	public void rewinddir (Dir dir);
	[CCode (cheader_filename = "dirent.h")]
	public void seekdir (Dir dir, long pos);
	[CCode (cheader_filename = "dirent.h")]
	public long telldir (Dir dir);

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

	[CCode (cheader_filename = "fcntl.h")]
	public const int F_DUPFD;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_GETFD;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_SETFD;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_GETFL;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_SETFL;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_GETLK;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_SETLK;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_SETLKW;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_GETOWN;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_SETOWN;
	[CCode (cheader_filename = "fcntl.h")]
	public const int FD_CLOEXEC;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_RDLCK;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_UNLCK;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_WRLCK;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_CREAT;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_EXCL;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_NOCTTY;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_TRUNC;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_APPEND;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_DSYNC;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_NONBLOCK;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_RSYNC;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_SYNC;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_ACCMODE;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_RDONLY;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_RDWR;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_WRONLY;
	[CCode (cheader_filename = "fcntl.h")]
	public const int POSIX_FADV_NORMAL;
	[CCode (cheader_filename = "fcntl.h")]
	public const int POSIX_FADV_SEQUENTIAL;
	[CCode (cheader_filename = "fcntl.h")]
	public const int POSIX_FADV_RANDOM;
	[CCode (cheader_filename = "fcntl.h")]
	public const int POSIX_FADV_WILLNEED;
	[CCode (cheader_filename = "fcntl.h")]
	public const int POSIX_FADV_DONTNEED;
	[CCode (cheader_filename = "fcntl.h")]
	public const int POSIX_FADV_NOREUSE;
	[CCode (cheader_filename = "fcntl.h")]
	public int creat (string path, mode_t mode);
	[CCode (cheader_filename = "fcntl.h")]
	public int fcntl (int fd, int cmd, ...);
	[CCode (cheader_filename = "fcntl.h")]
	public int open (string path, int oflag, mode_t mode=0);
	[CCode (cheader_filename = "fcntl.h")]
	public int posix_fadvice (int fd, long offset, long len, int advice);
	[CCode (cheader_filename = "fcntl.h")]
	public int posix_fallocate (int fd, long offset, long len);

	[CCode (cheader_filename = "signal.h")]
	public const int SIGABRT;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGALRM;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGBUS;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGCHLD;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGCONT;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGFPE;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGHUP;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGILL;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGINT;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGKILL;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGPIPE;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGQUIT;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGSEGV;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGSTOP;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGTERM;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGTSTP;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGTTIN;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGTTOU;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGUSR1;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGUSR2;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGPOLL;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGPROF;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGSYS;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGTRAP;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGURG;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGVTALRM;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGXCPU;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGXFSZ;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGIOT;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGSTKFLT;

	[SimpleType]
	[IntegerType (rank = 6)]
	[CCode (cname = "pid_t", default_value = "0", cheader_filename = "sys/types.h")]
	public struct pid_t {
	}
	[CCode (cheader_filename = "signal.h")]
	public int kill (pid_t pid, int signum);

	public static delegate void sighandler_t (int signal);

	[CCode (cheader_filename = "signal.h")]
	public sighandler_t signal (int signum, sighandler_t? handler);

	[CCode (cheader_filename = "string.h")]
	public int memcmp (void* s1, void* s2, size_t n);
	[CCode (cheader_filename = "string.h")]
	public unowned string strerror (int errnum);

	[CCode (cheader_filename = "stropts.h")]
	public const int I_PUSH;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_POP;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_LOOK;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_FLUSH;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_FLUSHBAND;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_SETSIG;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_GETSIG;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_FIND;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_PEEK;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_SRDOPT;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_GRDOPT;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_NREAD;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_FDINSERT;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_STR;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_SWROPT;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_GWROPT;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_SENDFD;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_RECVFD;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_LIST;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_ATMARK;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_CKBAND;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_GETBAND;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_CANPUT;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_SETCLTIME;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_GETCLTIME;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_LINK;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_UNLINK;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_PLINK;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_PUNLINK;
	[CCode (cheader_filename = "stropts.h")]
	public const int FLUSHR;
	[CCode (cheader_filename = "stropts.h")]
	public const int FLUSHW;
	[CCode (cheader_filename = "stropts.h")]
	public const int FLUSHRW;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_RDNORM;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_RDBAND;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_INPUT;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_HIPRI;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_OUTPUT;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_WRNORM;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_WRBAND;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_MSG;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_ERROR;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_HANGUP;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_BANDURG;
	[CCode (cheader_filename = "stropts.h")]
	public const int RS_HIPRI;
	[CCode (cheader_filename = "stropts.h")]
	public const int RNORM;
	[CCode (cheader_filename = "stropts.h")]
	public const int RMSGD;
	[CCode (cheader_filename = "stropts.h")]
	public const int RMSGN;
	[CCode (cheader_filename = "stropts.h")]
	public const int RPROTNORN;
	[CCode (cheader_filename = "stropts.h")]
	public const int RPROTDAT;
	[CCode (cheader_filename = "stropts.h")]
	public const int RPROTDIS;
	[CCode (cheader_filename = "stropts.h")]
	public const int SNDZERO;
	[CCode (cheader_filename = "stropts.h")]
	public const int ANYMARK;
	[CCode (cheader_filename = "stropts.h")]
	public const int LASTMARK;
	[CCode (cheader_filename = "stropts.h")]
	public const int MUXID_ALL;
	[CCode (cheader_filename = "stropts.h")]
	public const int MSG_ANY;
	[CCode (cheader_filename = "stropts.h")]
	public const int MSG_BAND;
	[CCode (cheader_filename = "stropts.h")]
	public const int MSG_HIPRI;
	[CCode (cheader_filename = "stropts.h")]
	public const int MORECTL;
	[CCode (cheader_filename = "stropts.h")]
	public const int MOREDATA;
	[CCode (cheader_filename = "stropts.h", sentinel = "")]
	public int ioctl (int fildes, int request, ...);

	[CCode (cheader_filename = "syslog.h")]
	public void openlog (string ident, int option, int facility );

	[CCode (cheader_filename = "syslog.h")]
	public void syslog (int priority, string format, ... );

	[CCode (cheader_filename = "syslog.h")]
	public void closelog ();

	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_PID;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_CONS;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_ODELAY;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_NDELAY;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_NOWAIT;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_EMERG;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_ALERT;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_CRIT;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_ERR;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_WARNING;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_NOTICE;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_INFO;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_DEBUG;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_KERN;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_USER;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_MAIL;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_DAEMON;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_SYSLOG;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LPR;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_NEWS;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_UUCP;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_CRON;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_AUTHPRIV;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_FTP;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL0;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL1;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL2;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL3;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL4;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL5;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL6;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL7;

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

	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFMT;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFBLK;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFCHR;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFIFO;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFREG;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFDIR;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFLNK;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFSOCK;

	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IRWXU;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IRUSR;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IWUSR;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IXUSR;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IRWXG;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IRGRP;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IWGRP;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IXGRP;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IRWXO;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IROTH;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IWOTH;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IXOTH;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_ISUID;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_ISGID;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_ISVTX;

	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISBLK (mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISCHR (mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISDIR (mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISFIFO (mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISREG (mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISLNK (mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISSOCK (mode_t mode);

	[CCode (cheader_filename = "sys/stat.h", cname = "struct stat")]
	public struct Stat {
		public dev_t st_dev;
		public ino_t st_ino;
		public mode_t st_mode;
		public nlink_t st_nlink;
		public uid_t st_uid;
		public gid_t st_gid;
		public dev_t st_rdev;
		public size_t st_size;
		public time_t st_atime;
		public time_t st_mtime;
		public time_t st_ctime;
		public blksize_t st_blksize;
		public blkcnt_t st_blocks;
	}
	[CCode (cheader_filename = "sys/stat.h")]
	int fstat( int fd, out Stat buf);
	[CCode (cheader_filename = "sys/stat.h")]
	int stat (string filename, out Stat buf);

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/statvfs.h")]
	public struct fsblkcnt_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/statvfs.h")]
	public struct fsfilcnt_t {
	}

	[CCode (cheader_filename = "sys/statvfs.h", cname = "struct statvfs")]
	public struct statvfs {
		public ulong f_bsize;
		public ulong f_frsize;
		public fsblkcnt_t f_blocks;
		public fsblkcnt_t f_bfree;
		public fsblkcnt_t f_bavail;
		public fsfilcnt_t f_files;
		public fsfilcnt_t f_ffree;
		public fsfilcnt_t f_favail;
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname="off_t", cheader_filename = "sys/types.h")]
	public struct off_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct uid_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct gid_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname = "mode_t", cheader_filename = "sys/types.h")]
	public struct mode_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct dev_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct ino_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct nlink_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct blksize_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct blkcnt_t {
	}

	[CCode (cheader_filename = "time.h")]
	public struct tm {
		public int tm_sec;
		public int tm_min;
		public int tm_hour;
		public int tm_mday;
		public int tm_mon;
		public int tm_year;
		public int tm_wday;
		public int tm_yday;
		public int tm_isdt;
	}

	[CCode (cheader_filename = "time.h")]
	public struct timespec {
		time_t tv_sec;
		long tv_nsec;
	}

	[CCode (cheader_filename = "unistd.h")]
	public int close (int fd);
	[CCode (cheader_filename = "unistd.h")]
	public int execl (string path, params string[] arg);
	[CCode (cheader_filename = "unistd.h")]
	public ssize_t read (int fd, void* buf, size_t count);
	[CCode (cheader_filename = "unistd.h")]
	public ssize_t write (int fd, void* buf, size_t count);
	[CCode (cheader_filename = "unistd.h")]
	public off_t lseek(int fildes, off_t offset, int whence);

	[CCode (cheader_filename = "unistd.h")]
	public const int SEEK_SET;
	[CCode (cheader_filename = "unistd.h")]
	public const int SEEK_CUR;
	[CCode (cheader_filename = "unistd.h")]
	public const int SEEK_END;
}

