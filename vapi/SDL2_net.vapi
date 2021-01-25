/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2016-2020 SDL2 VAPI Authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * Authors:
 *  Mario Daniel Ruiz Saavedra <desiderantes93@gmail.com>
 *  Gontzal Uriarte <txasatonga@gmail.com>
 *  Pedro H. Lara Campos <root@pedrohlc.com>
 */

[CCode (cprefix = "SDLNet_", cheader_filename = "SDL2/SDL_net.h")]
namespace SDLNet {
	[CCode (cname = "SDLNet_Linked_Version")]
	public static unowned SDL.Version? linked_version ();

	[CCode (cname = "SDLNet_Init")]
	public static int init ();

	[CCode (cname = "SDLNet_Quit")]
	public static void quit ();

	[CCode (cname = "SDLNet_Write16")]
	public static void write16 (uint16 value, void* area);

	[CCode (cname = "SDLNet_Write32")]
	public static void write32 (uint value, void* area);

	[CCode (cname = "SDLNet_Read16")]
	public static uint16 read16 (void* area);

	[CCode (cname = "SDLNet_Read32")]
	public static uint read32 (void* area);


	[CCode (cname = "IPaddress", free_function = "g_free", has_type_id = false)]
	public struct IPAddress {
		public uint host;
		public uint16 port;

		[CCode (cname = "INADDR_ANY")]
		public const uint ANY;

		[CCode (cname = "INADDR_NONE")]
		public const uint NONE;

		[CCode (cname = "SDLNet_ResolveHost")]
		public static int from_host (out IPAddress address, string? host, uint16 port);

		[CCode (cname = "SDLNet_ResolveIP")]
		public unowned string? lookup ();
	}// IPAddress

	[CCode (cname = "UDPpacket", free_function = "SDLNet_FreePacket")]
	[Compact]
	public class UDPPacket {
		public int channel;
		public uchar *data;
		public int len;
		public int maxlen;
		public int status;
		public IPAddress address;

		[CCode (cname = "SDLNet_AllocPacket")]
		public UDPPacket (int size);

		[CCode (cname = "SDLNet_ResizePacket")]
		public int resize (int newsize);
	}// UDPPacket

	[CCode (cname = "struct _SDLNet_GenericSocket")]
	[Compact]
	public class Socket {
		public int ready;
	}// Socket

	[CCode (cname = "struct _TCPsocket", free_function = "SDLNet_TCP_Close")]
	[Compact]
	public class TCPSocket: Socket {
		[CCode (cname = "SDLNet_TCP_Open")]
		public TCPSocket (IPAddress ip);

		[CCode (cname = "SDLNet_TCP_Accept")]
		public TCPSocket? accept ();

		[CCode (cname = "SDLNet_TCP_GetPeerAddress")]
		public IPAddress? get_address ();

		[CCode (cname = "SDLNet_TCP_Send")]
		public int send (uchar[] data);

		[CCode (cname = "SDLNet_TCP_Recv")]
		public int receive (uchar[] data);
	}// TCPSocket

	[CCode (cname = "struct _UDPsocket", free_function = "SDLNet_UDP_Close")]
	[Compact]
	public class UDPSocket: Socket {
		[CCode (cname = "SDLNet_UDP_Open")]
		public UDPSocket (uint16 port);

		[CCode (cname = "SDLNet_UDP_Bind")]
		public int bind (int channel, IPAddress address);

		[CCode (cname = "SDLNet_UDP_Unbind")]
		public void unbind (int channel);

		[CCode (cname = "SDLNet_UDP_GetPeerAddress")]
		public IPAddress? get_address (int channel);

		[CCode (cname = "SDLNet_UDP_Send")]
		public int send (int channel, UDPPacket packet);

		[CCode (cname = "SDLNet_UDP_Recv")]
		public int receive (UDPPacket packet);

		[CCode (cname = "SDLNet_UDP_SendV")]
		public int send_many (UDPPacket[] packets);

		[CCode (cname = "SDLNet_UDP_RecvV")]
		public int receive_many ([CCode (array_length = false)] UDPPacket[] packets);
	}// UDPSocket

	[CCode (cname = "struct _SDLNet_SocketSet", free_function = "SDLNet_FreeSocketSet")]
	[Compact]
	public class SocketSet {
		[CCode (cname = "SDLNet_AllocSocketSet")]
		public SocketSet (int maxsockets);

		[CCode (cname = "SDLNet_AddSocket")]
		public int add (Socket socket);

		[CCode (cname = "SDLNet_DelSocket")]
		public int remove (Socket socket);

		[CCode (cname = "SDLNet_CheckSockets")]
		public int has_data (uint timeout);

		[CCode (cname = "SDLNet_SocketReady")]
		public int is_ready ();
	}// SocketSet
}// SDL
