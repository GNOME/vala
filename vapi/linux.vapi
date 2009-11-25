/**
 * Copyright (C) 2009 Michael 'Mickey' Lauer <mlauer@vanille-media.de>
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
 */

[CCode (cprefix = "", lower_case_cprefix = "")]
namespace Linux {

    /*
     * EventFd
     */
    [CCode (cprefix = "EFD_", cheader_filename = "sys/eventfd.h")]
    public enum EventFdFlags {
        CLOEXEC,
        NONBLOCK
    }

    [CCode (cheader_filename = "sys/eventfd.h")]
    public int eventfd (uint count = 0, EventFdFlags flags = 0);
    public int eventfd_read (int fd, out uint64 value);
    public int eventfd_write (int fd, uint64 value);

    /*
     * Inotify
     */
    [CCode (cname = "struct inotify_event", cheader_filename = "sys/inotify.h")]
    public struct InotifyEvent {
        public int wd;
        public uint32 mask;
        public uint32 cookie;
        public uint32 len;
        public string name;
    }

    [CCode (cprefix = "IN_", cheader_filename = "sys/inotify.h")]
    public enum InotifyFlags {
        CLOEXEC,
        NONBLOCK
    }

    [CCode (cname = "int", cprefix = "IN_", cheader_filename = "sys/inotify.h")]
    public enum InotifyMaskFlags {
        ACCESS,
        ATTRIB,
        CLOSE,
        CLOSE_WRITE,
        CLOSE_NOWRITE,
        CREATE,
        DELETE,
        DELETE_SELF,
        MODIFY,
        MOVE,
        MOVE_SELF,
        MOVED_FROM,
        MOVED_TO,
        OPEN,
        DONT_FOLLOW,
        MASK_ADD,
        ONESHOT,
        ONLYDIR,
        IGNORED,
        ISDIR,
        Q_OVERFLOW,
        UNMOUNT
    }

    [CCode (cname = "inotify_init1", cheader_filename = "sys/inotify.h")]
    public int inotify_init (InotifyFlags flags = 0);
    public int inotify_add_watch (int fd, string pathname, InotifyMaskFlags mask);
    public int inotify_rm_watch (int fd, int wd);

    /*
     * SignalFd
     */
    [CCode (cprefix = "SFD_", cheader_filename = "sys/signalfd.h")]
    public enum SignalFdFlags {
        CLOEXEC,
        NONBLOCK
    }

    [CCode (cheader_filename = "sys/signalfd.h")]
    public int signalfd (int fd, Posix.sigset_t mask, SignalFdFlags flags = 0);

    /*
     * Misc non-posix additions
     */
    [CCode (cheader_filename = "dirent.h")]
    public enum DirEntType {
        DT_UNKNOWN,
        DT_FIFO,
        DT_CHR,
        DT_DIR,
        DT_BLK,
        DT_REG,
        DT_LNK,
        DT_SOCK,
        DT_WHT
    }

    [CCode (cheader_filename = "execinfo.h")]
    public int backtrace (void* buffer, int size);

    [CCode (cheader_filename = "execinfo.h")]
    [CCode (array_length = false)]
    public string[] backtrace_symbols (void* buffer, int size);

    [CCode (cheader_filename = "execinfo.h")]
    public void backtrace_symbols_fd (void* buffer, int size, int fd);

    [CCode (cheader_filename = "arpa/inet.h")]
    public int inet_aton(string cp, out Posix.InAddr addr);

    [CCode (cname = "struct winsize", cheader_filename = "termios.h", destroy_function = "")]
    public struct winsize {
        public ushort ws_row;
        public ushort ws_col;
        public ushort ws_xpixel;
        public ushort ws_ypixel;
    }

    [CCode (cheader_filename = "pty.h")]
    public Posix.pid_t forkpty (out int amaster,
                                out int aslave,
                                [CCode (array_length=false, array_null_terminated=true)] char[] name,
                                Posix.termios? termp,
                                winsize? winp);

    [CCode (cheader_filename = "pty.h")]
    public int openpty (out int amaster,
                        out int aslave,
                        [CCode (array_length=false, array_null_terminated=true)] char[] name,
                        Posix.termios? termp,
                        winsize? winp);

    [CCode (cprefix = "CLONE_", cheader_filename = "sched.h")]
    public enum CloneFlags {
        FILES,
        FS,
        NEWNS
    }

    [CCode (cheader_filename = "sched.h")]
    public int unshare (CloneFlags flags);

    [CCode (cheader_filename = "sys/time.h")]
    public int adjtime (Posix.timeval delta, Posix.timeval? olddelta = null);

    // adjtimex(2)
    [CCode (cprefix = "ADJ_", cheader_filename = "sys/timex.h")]
    public enum AdjustModes {
        OFFSET,
        FREQUENCY,
        MAXERROR,
        ESTERROR,
        STATUS,
        TIMECONST,
        TICK,
        OFFSET_SINGLESHOT
    }

    [CCode (cheader_filename = "sys/timex.h")]
    public const int TIME_OK;
    [CCode (cheader_filename = "sys/timex.h")]
    public const int TIME_INS;
    [CCode (cheader_filename = "sys/timex.h")]
    public const int TIME_DEL;
    [CCode (cheader_filename = "sys/timex.h")]
    public const int TIME_OOP;
    [CCode (cheader_filename = "sys/timex.h")]
    public const int TIME_WAIT;
    [CCode (cheader_filename = "sys/timex.h")]
    public const int TIME_BAD;

    // adjtimex(2)
    [CCode (cname = "struct timex", cheader_filename = "sys/timex.h")]
    public struct timex {
        public AdjustModes modes;   /* mode selector */
        public long offset;         /* time offset (usec) */
        public long freq;           /* frequency offset (scaled ppm) */
        public long maxerror;       /* maximum error (usec) */
        public long esterror;       /* estimated error (usec) */
        public int status;          /* clock command/status */
        public long constant;       /* pll time constant */
        public long precision;      /* clock precision (usec) (read-only) */
        public long tolerance;      /* clock frequency tolerance (ppm) (read-only) */
        public Posix.timeval time;  /* current time (read-only) */
        public long tick;           /* usecs between clock ticks */
    }

    [CCode (cheader_filename = "sys/timex.h")]
    public int adjtimex (Linux.timex buf);

    [CCode (cheader_filename = "time.h")]
    public time_t timegm (GLib.Time t);

    [CCode (cheader_filename = "utmp.h")]
    public int login_tty (int fd);

    // mremap(2)
    [CCode (cprefix = "MREMAP_", cheader_filename = "sys/mman.h")]
    public enum MremapFlags {
        MAYMOVE,
        FIXED
    }

    [CCode (cheader_filename = "sys/mman.h")]
    public void *mremap(void *old_address, size_t old_size, size_t new_size,
                        MremapFlags flags);

    /*
     * Network
     */
    [CCode (cprefix = "", lower_case_cprefix = "")]
    namespace Network {
        [CCode (cname = "struct ifreq", cheader_filename = "net/if.h", destroy_function = "")]
        public struct IfReq {
            public char[] ifr_name;
            public Posix.SockAddr ifr_addr;
        }

        /* ioctls */
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCADDRT;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCDELRT;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCRTMSG;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFNAME;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFLINK;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFCONF;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFFLAGS;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFFLAGS;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFADDR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFADDR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFDSTADDR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFDSTADDR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFBRDADDR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFBRDADDR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFNETMASK;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFNETMASK;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFMETRIC;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFMETRIC;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFMEM;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFMEM;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFMTU;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFMTU;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFNAME;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFHWADDR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFENCAP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFENCAP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFHWADDR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFSLAVE;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFSLAVE;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCADDMULTI;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCDELMULTI;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFINDEX;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFPFLAGS;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFPFLAGS;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCDIFADDR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFHWBROADCAST;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFCOUNT;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFBR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFBR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFTXQLEN;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFTXQLEN;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCDARP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGARP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSARP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCDRARP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGRARP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSRARP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCGIFMAP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCSIFMAP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCADDDLCI;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int SIOCDELDLCI;
    }

    /*
     * Input subsystem
     */
    [CCode (cprefix = "", lower_case_cprefix = "")]
    namespace Input {

        /*
         * subsystem structures
         */

        [CCode (cname = "struct input_event", cheader_filename = "linux/input.h")]
        public struct Event {
            public Posix.timeval time;
            public uint16 type;
            public uint16 code;
            public int32 value;
        }

        [CCode (cname = "struct input_id", cheader_filename = "linux/input.h")]
        public struct Id {
            public uint16 bustype;
            public uint16 vendor;
            public uint16 product;
            public uint16 version;
        }

        [CCode (cname = "struct input_absinfo", cheader_filename = "linux/input.h")]
        public struct AbsInfo {
            public int32 value;
            public int32 minimum;
            public int32 maximum;
            public int32 fuzz;
            public int32 flat;
        }

        /*
         * ioctls
         */

        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public const int EVIOCGVERSION;
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public const int EVIOCGID;
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public const int EVIOCGREP;
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public const int EVIOCSREP;
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public const int EVIOCGKEYCODE;
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public const int EVIOCSKEYCODE;

        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public int EVIOCGNAME( uint len );
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public int EVIOCGPHYS( uint len );
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public int EVIOCGUNIQ( uint len );

        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public int EVIOCGKEY( uint len );
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public int EVIOCGLED( uint len );
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public int EVIOCGSND( uint len );
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public int EVIOCGSW( uint len );

        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public int EVIOCGBIT( uint ev, uint len );
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public int EVIOCGABS( uint abs );
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public int EVIOCSABS( uint abs );

        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public const int EVIOCSFF;
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public const int EVIOCRMFF;
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public const int EVIOCGEFFECTS;
        [CCode (cheader_filename = "linux/input.h,sys/ioctl.h")]
        public const int EVIOCGRAB;

        /*
         * event types
         */

        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_SYN;
        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_KEY;
        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_REL;
        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_ABS;
        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_MSC;
        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_SW;
        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_LED;
        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_SND;
        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_REP;
        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_FF;
        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_PWR;
        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_FF_STATUS;
        [CCode (cheader_filename = "linux/input.h")]
        public const uint16 EV_MAX;

        /*
         * synchronization events
         */

        [CCode (cheader_filename = "linux/input.h")]
        public const int SYN_REPORT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int SYN_CONFIG;

        /*
         * keys, switches, buttons, etc.
         */

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_RESERVED;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_ESC;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_1;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_3;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_4;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_5;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_6;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_7;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_8;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_9;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_0;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MINUS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_EQUAL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BACKSPACE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_TAB;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_Q;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_W;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_E;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_R;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_T;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_Y;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_U;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_I;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_O;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_P;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_LEFTBRACE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_RIGHTBRACE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_ENTER;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_LEFTCTRL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_A;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_S;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_D;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_G;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_H;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_J;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_K;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_L;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SEMICOLON;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_APOSTROPHE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_GRAVE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_LEFTSHIFT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BACKSLASH;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_Z;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_X;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_C;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_V;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_B;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_N;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_M;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_COMMA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DOT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SLASH;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_RIGHTSHIFT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KPASTERISK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_LEFTALT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SPACE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CAPSLOCK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F1;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F3;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F4;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F5;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F6;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F7;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F8;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F9;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F10;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMLOCK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SCROLLLOCK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KP7;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KP8;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KP9;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KPMINUS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KP4;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KP5;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KP6;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KPPLUS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KP1;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KP2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KP3;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KP0;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KPDOT;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_ZENKAKUHANKAKU;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_102ND;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F11;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F12;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_RO;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KATAKANA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_HIRAGANA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_HENKAN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KATAKANAHIRAGANA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MUHENKAN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KPJPCOMMA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KPENTER;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_RIGHTCTRL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KPSLASH;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SYSRQ;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_RIGHTALT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_LINEFEED;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_HOME;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_UP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PAGEUP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_LEFT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_RIGHT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_END;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DOWN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PAGEDOWN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_INSERT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DELETE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MACRO;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MUTE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_VOLUMEDOWN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_VOLUMEUP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_POWER;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KPEQUAL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KPPLUSMINUS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PAUSE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SCALE;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KPCOMMA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_HANGEUL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_HANGUEL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_HANJA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_YEN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_LEFTMETA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_RIGHTMETA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_COMPOSE;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_STOP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_AGAIN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PROPS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_UNDO;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FRONT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_COPY;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_OPEN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PASTE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FIND;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CUT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_HELP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MENU;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CALC;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SETUP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SLEEP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_WAKEUP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FILE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SENDFILE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DELETEFILE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_XFER;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PROG1;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PROG2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_WWW;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MSDOS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_COFFEE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SCREENLOCK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DIRECTION;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CYCLEWINDOWS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MAIL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BOOKMARKS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_COMPUTER;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BACK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FORWARD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CLOSECD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_EJECTCD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_EJECTCLOSECD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NEXTSONG;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PLAYPAUSE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PREVIOUSSONG;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_STOPCD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_RECORD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_REWIND;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PHONE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_ISO;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CONFIG;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_HOMEPAGE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_REFRESH;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_EXIT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MOVE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_EDIT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SCROLLUP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SCROLLDOWN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KPLEFTPAREN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KPRIGHTPAREN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NEW;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_REDO;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F13;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F14;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F15;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F16;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F17;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F18;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F19;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F20;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F21;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F22;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F23;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_F24;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PLAYCD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PAUSECD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PROG3;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PROG4;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DASHBOARD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SUSPEND;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CLOSE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PLAY;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FASTFORWARD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BASSBOOST;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PRINT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_HP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CAMERA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SOUND;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_QUESTION;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_EMAIL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CHAT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SEARCH;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CONNECT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FINANCE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SPORT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SHOP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_ALTERASE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CANCEL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRIGHTNESSDOWN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRIGHTNESSUP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MEDIA;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SWITCHVIDEOMODE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KBDILLUMTOGGLE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KBDILLUMDOWN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KBDILLUMUP;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SEND;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_REPLY;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FORWARDMAIL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SAVE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DOCUMENTS;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BATTERY;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BLUETOOTH;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_WLAN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_UWB;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_UNKNOWN;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_VIDEO_NEXT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_VIDEO_PREV;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRIGHTNESS_CYCLE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRIGHTNESS_ZERO;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DISPLAY_OFF;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_WIMAX;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MAX;

        /* Range 248 - 255 is reserved for special needs of AT keyboard driver */

        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_MISC;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_0;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_1;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_3;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_4;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_5;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_6;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_7;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_8;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_9;

        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_MOUSE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_LEFT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_RIGHT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_MIDDLE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_SIDE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_EXTRA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_FORWARD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_BACK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TASK;

        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_JOYSTICK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TRIGGER;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_THUMB;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_THUMB2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOP2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_PINKIE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_BASE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_BASE2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_BASE3;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_BASE4;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_BASE5;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_BASE6;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_DEAD;

        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_GAMEPAD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_A;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_B;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_C;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_X;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_Y;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_Z;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TR;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TL2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TR2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_SELECT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_START;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_MODE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_THUMBL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_THUMBR;

        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_DIGI;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOOL_PEN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOOL_RUBBER;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOOL_BRUSH;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOOL_PENCIL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOOL_AIRBRUSH;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOOL_FINGER;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOOL_MOUSE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOOL_LENS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOUCH;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_STYLUS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_STYLUS2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOOL_DOUBLETAP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_TOOL_TRIPLETAP;

        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_WHEEL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_GEAR_DOWN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BTN_GEAR_UP;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_OK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SELECT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_GOTO;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CLEAR;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_POWER2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_OPTION;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_INFO;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_TIME;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_VENDOR;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_ARCHIVE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PROGRAM;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CHANNEL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FAVORITES;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_EPG;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PVR;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MHP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_LANGUAGE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_TITLE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SUBTITLE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_ANGLE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_ZOOM;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MODE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_KEYBOARD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SCREEN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PC;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_TV;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_TV2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_VCR;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_VCR2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SAT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SAT2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_TAPE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_RADIO;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_TUNER;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PLAYER;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_TEXT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DVD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_AUX;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MP3;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_AUDIO;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_VIDEO;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DIRECTORY;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_LIST;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MEMO;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CALENDAR;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_RED;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_GREEN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_YELLOW;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BLUE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CHANNELUP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CHANNELDOWN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FIRST;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_LAST;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_AB;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NEXT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_RESTART;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SLOW;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SHUFFLE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BREAK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PREVIOUS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DIGITS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_TEEN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_TWEN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_VIDEOPHONE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_GAMES;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_ZOOMIN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_ZOOMOUT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_ZOOMRESET;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_WORDPROCESSOR;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_EDITOR;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SPREADSHEET;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_GRAPHICSEDITOR;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_PRESENTATION;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DATABASE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NEWS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_VOICEMAIL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_ADDRESSBOOK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MESSENGER;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DISPLAYTOGGLE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_SPELLCHECK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_LOGOFF;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DOLLAR;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_EURO;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FRAMEBACK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FRAMEFORWARD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_CONTEXT_MENU;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_MEDIA_REPEAT;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DEL_EOL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DEL_EOS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_INS_LINE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_DEL_LINE;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_ESC;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F1;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F3;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F4;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F5;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F6;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F7;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F8;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F9;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F10;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F11;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F12;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_1;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_D;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_E;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_F;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_S;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_FN_B;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRL_DOT1;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRL_DOT2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRL_DOT3;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRL_DOT4;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRL_DOT5;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRL_DOT6;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRL_DOT7;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRL_DOT8;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRL_DOT9;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_BRL_DOT10;

        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMERIC_0;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMERIC_1;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMERIC_2;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMERIC_3;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMERIC_4;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMERIC_5;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMERIC_6;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMERIC_7;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMERIC_8;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMERIC_9;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMERIC_STAR;
        [CCode (cheader_filename = "linux/input.h")]
        public const int KEY_NUMERIC_POUND;

        /*
        * Relative axes
        */

        [CCode (cheader_filename = "linux/input.h")]
        public const int REL_X;
        [CCode (cheader_filename = "linux/input.h")]
        public const int REL_Y;
        [CCode (cheader_filename = "linux/input.h")]
        public const int REL_Z;
        [CCode (cheader_filename = "linux/input.h")]
        public const int REL_RX;
        [CCode (cheader_filename = "linux/input.h")]
        public const int REL_RY;
        [CCode (cheader_filename = "linux/input.h")]
        public const int REL_RZ;
        [CCode (cheader_filename = "linux/input.h")]
        public const int REL_HWHEEL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int REL_DIAL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int REL_WHEEL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int REL_MISC;
        [CCode (cheader_filename = "linux/input.h")]
        public const int REL_MAX;

        /*
         * Absolute axes
         */

        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_X;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_Y;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_Z;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_RX;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_RY;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_RZ;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_THROTTLE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_RUDDER;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_WHEEL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_GAS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_BRAKE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_HAT0X;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_HAT0Y;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_HAT1X;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_HAT1Y;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_HAT2X;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_HAT2Y;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_HAT3X;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_HAT3Y;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_PRESSURE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_DISTANCE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_TILT_X;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_TILT_Y;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_TOOL_WIDTH;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_VOLUME;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_MISC;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ABS_MAX;

        /*
         * Switch events
         */

        [CCode (cheader_filename = "linux/input.h")]
        public const int SW_LID;
        [CCode (cheader_filename = "linux/input.h")]
        public const int SW_TABLET_MODE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int SW_HEADPHONE_INSERT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int SW_RFKILL_ALL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int SW_RADIO;
        [CCode (cheader_filename = "linux/input.h")]
        public const int SW_MICROPHONE_INSERT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int SW_DOCK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int SW_MAX;

        /*
         * Misc events
         */

        [CCode (cheader_filename = "linux/input.h")]
        public const int MSC_SERIAL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int MSC_PULSELED;
        [CCode (cheader_filename = "linux/input.h")]
        public const int MSC_GESTURE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int MSC_RAW;
        [CCode (cheader_filename = "linux/input.h")]
        public const int MSC_SCAN;
        [CCode (cheader_filename = "linux/input.h")]
        public const int MSC_MAX;

        /*
         * LEDs
         */

        [CCode (cheader_filename = "linux/input.h")]
        public const int LED_NUML;
        [CCode (cheader_filename = "linux/input.h")]
        public const int LED_CAPSL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int LED_SCROLLL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int LED_COMPOSE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int LED_KANA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int LED_SLEEP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int LED_SUSPEND;
        [CCode (cheader_filename = "linux/input.h")]
        public const int LED_MUTE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int LED_MISC;
        [CCode (cheader_filename = "linux/input.h")]
        public const int LED_MAIL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int LED_CHARGING;
        [CCode (cheader_filename = "linux/input.h")]
        public const int LED_MAX;

        /*
         * Autorepeat values
         */

        [CCode (cheader_filename = "linux/input.h")]
        public const int REP_DELAY;
        [CCode (cheader_filename = "linux/input.h")]
        public const int REP_PERIOD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int REP_MAX;

        /*
         * Sounds
         */

        [CCode (cheader_filename = "linux/input.h")]
        public const int SND_CLICK;
        [CCode (cheader_filename = "linux/input.h")]
        public const int SND_BELL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int SND_TONE;
        [CCode (cheader_filename = "linux/input.h")]
        public const int SND_MAX;

        /*
         * IDs.
         */

        [CCode (cheader_filename = "linux/input.h")]
        public const int ID_BUS;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ID_VENDOR;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ID_PRODUCT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int ID_VERSION;

        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_PCI;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_ISAPNP;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_USB;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_HIL;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_BLUETOOTH;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_VIRTUAL;

        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_ISA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_I8042;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_XTKBD;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_RS232;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_GAMEPORT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_PARPORT;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_AMIGA;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_ADB;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_I2C;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_HOST;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_GSC;
        [CCode (cheader_filename = "linux/input.h")]
        public const int BUS_ATARI;
    }

    /*
     * Netlink subsystem
     */
    [CCode (cprefix = "", lower_case_cprefix = "")]
    namespace Netlink {

        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_ROUTE;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_UNUSED;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_USERSOCK;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_FIREWALL;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_INET_DIAG;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_NFLOG;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_XFRM;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_SELINUX;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_ISCSI;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_AUDIT;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_FIB_LOOKUP;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_CONNECTOR;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_NETFILTER;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_IP6_FW;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_DNRTMSG;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_KOBJECT_UEVENT;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_GENERIC;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_SCSITRANSPORT;
        [CCode (cheader_filename = "linux/netlink.h")]
        public const int NETLINK_ECRYPTFS;

        // additions to the socket interface (non-posix)
        [CCode (cheader_filename = "sys/socket.h")]
        public const int AF_NETLINK;
        [CCode (cheader_filename = "sys/socket.h")]
        public const int SOCK_NONBLOCK;
        [CCode (cheader_filename = "sys/socket.h")]
        public const int SOCK_CLOEXEC;

        [CCode (cname = "struct sockaddr_nl", cheader_filename = "linux/netlink.h", destroy_function = "")]
        public struct SockAddrNl {
            public int nl_family;
            public ushort nl_pad;
            public uint32 nl_pid;
            public uint32 nl_groups;
        }

        /*
        [CCode (cheader_filename = "sys/socket.h", sentinel = "")]
        public int bind (int sockfd, SockAddrNl addr, ulong length );
        */
    }

    /*
     * Real time clock subsystem
     */

    [CCode (cprefix = "", lower_case_cprefix = "")]
    namespace Rtc {

        [CCode (cname = "struct rtc_wkalrm", cheader_filename = "linux/rtc.h")]
        public struct WakeAlarm {
            public char enabled;
            public char pending;
            public Posix.tm time;
        }

        [CCode (cheader_filename = "linux/rtc.h,sys/ioctl.h")]
        public const int RTC_RD_TIME;
        [CCode (cheader_filename = "linux/rtc.h,sys/ioctl.h")]
        public const int RTC_SET_TIME;
        [CCode (cheader_filename = "linux/rtc.h,sys/ioctl.h")]
        public const int RTC_WKALM_RD;
        [CCode (cheader_filename = "linux/rtc.h,sys/ioctl.h")]
        public const int RTC_WKALM_SET;
    }

    /*
     * Terminal input/output
     */
    [CCode (cprefix = "", lower_case_cprefix = "")]
    namespace Termios {

        /*
         * non-posix functions
         */
        [CCode (cheader_filename = "stdlib.h")]
        public int ptsname_r (int fd, char[] buf);

        /*
         * non-posix flags
         */
        [CCode (cheader_filename = "termios.h")]
        public const int OLCUC;

        /*
         * non-posix constants
         */

        // flow control
        [CCode (cheader_filename = "termios.h")]
        public const int CRTSCTS;
        // v24 modem lines
        [CCode (cheader_filename = "termios.h")]
        public const int TIOCM_LE;
        [CCode (cheader_filename = "termios.h")]
        public const int TIOCM_DTR;
        [CCode (cheader_filename = "termios.h")]
        public const int TIOCM_RTS;
        [CCode (cheader_filename = "termios.h")]
        public const int TIOCM_ST;
        [CCode (cheader_filename = "termios.h")]
        public const int TIOCM_SR;
        [CCode (cheader_filename = "termios.h")]
        public const int TIOCM_CTS;
        [CCode (cheader_filename = "termios.h")]
        public const int TIOCM_CARM;
        [CCode (cheader_filename = "termios.h")]
        public const int TIOCM_RNG;
        [CCode (cheader_filename = "termios.h")]
        public const int TIOCM_DSR;
        [CCode (cheader_filename = "termios.h")]
        [CCode (cheader_filename = "termios.h")]
        public const int TIOCM_OUT1;
        [CCode (cheader_filename = "termios.h")]
        public const int TIOCM_OUT2;
        [CCode (cheader_filename = "termios.h")]
        public const int TIOCM_LOOP;
        // baud rates
        [CCode (cheader_filename = "termios.h")]
        public const int B460800;
        [CCode (cheader_filename = "termios.h")]
        public const int B500000;
        [CCode (cheader_filename = "termios.h")]
        public const int B576000;
        [CCode (cheader_filename = "termios.h")]
        public const int B921600;
        [CCode (cheader_filename = "termios.h")]
        public const int B1000000;
        [CCode (cheader_filename = "termios.h")]
        public const int B1152000;
        [CCode (cheader_filename = "termios.h")]
        public const int B1500000;
        [CCode (cheader_filename = "termios.h")]
        public const int B2000000;
        [CCode (cheader_filename = "termios.h")]
        public const int B2500000;
        [CCode (cheader_filename = "termios.h")]
        public const int B3000000;
        [CCode (cheader_filename = "termios.h")]
        public const int B3500000;
        [CCode (cheader_filename = "termios.h")]
        public const int B4000000;


        /*
         * ioctls
         */
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCGETS;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSETS;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSETSW;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSETSF;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCGETA;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSETA;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSETAW;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSETAF;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSBRK;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCXONC;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCFLSH;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCEXCL;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCNXCL;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSCTTY;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCGPGRP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSPGRP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCOUTQ;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSTI;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCGWINSZ;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSWINSZ;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCMGET;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCMBIS;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCMBIC;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCMSET;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCGSOFTCAR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSSOFTCAR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int FIONREAD;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCINQ;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCLINUX;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCCONS;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCGSERIAL;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSSERIAL;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCPKT;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int FIONBIO;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCNOTTY;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSETD;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCGETD;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSBRKP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSBRK;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCCBRK;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCGSID;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCGETS2;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSETS2;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSETSW2;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSETSF2;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCGRS485;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSRS485;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCGPTN;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSPTLCK;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCGETX;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSETX;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSETXF;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TCSETXW;

        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int FIONCLEX;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int FIOCLEX;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int FIOASYNC;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSERCONFIG;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSERGWILD;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSERSWILD;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCGLCKTRMIOS;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSLCKTRMIOS;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSERGSTRUCT;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSERGETLSR;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSERGETMULTI;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSERSETMULTI;

        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCMIWAIT;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCGICOUNT;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCGHAYESESP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSHAYESESP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int FIOQSIZE;

        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCPKT_DATA;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCPKT_FLUSHREAD;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCPKT_FLUSHWRITE;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCPKT_STOP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCPKT_START;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCPKT_NOSTOP;
        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCPKT_DOSTOP;

        [CCode (cheader_filename = "sys/ioctl.h")]
        public const int TIOCSER_TEMT;
    }
}
