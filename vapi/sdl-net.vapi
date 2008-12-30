using GLib;
using SDL;

[CCode (cprefix="SDLNet_", cheader_filename="SDL_net.h")]
namespace SDLNet {
	[CCode (cname="SDLNet_Linked_Version")]
	public static Version linked();

	/**
	 * Initialize the network API 
	 * SDL must be initialized before calls to functions in this library, 
	 * because this library uses utility functions from the SDL library.
	 */
	[CCode (cname="SDLNet_Init")]
	public static int init();

	/** Cleanup the network API */
	[CCode (cname="SDLNet_Quit")]
	public static void quit();

	/** Write a 16bit value to a network packet buffer */
	[CCode (cname="SDLNet_Write16")]
	public static void write16(uint16 value, void *area);

	/** Write a 32bit value to a network packet buffer */
	[CCode (cname="SDLNet_Write32")]
	public static void write32(uint value, void *area);

	/** Read a 16bit value from a network packet buffer */
	[CCode (cname="SDLNet_Read16")]
	public static uint16 read16(void *area);

	/** Read a 32bit value from a network packet buffer */
	[CCode (cname="SDLNet_Read32")]
	public static uint read32(void *area);




	[CCode (cname="IPaddress", free_function="g_free", has_type_id=false)]
	public struct IPAddress {
		public uint host;
		public uint16 port;

		[CCode (cname="INADDR_ANY")]
		public const uint ANY;

		[CCode (cname="INADDR_NONE")]
		public const uint NONE;

		/** 
		 * Resolve a host name and port to an IP address in network form.
		 * @return If the function succeeds, it will return 0.
		 * If the host couldn't be resolved, the host portion of the returned
		 * address will be INADDR_NONE, and the function will return -1.
		 * If 'host' is NULL, the resolved host will be set to INADDR_ANY.
		 */
		[CCode (cname="SDLNet_ResolveHost")]
		[NoArrayLength]
		public static int from_host(IPAddress address, string host, uint16 port);

		/**
		 * Resolve an ip address to a host name in canonical form. 
		 * Note that this function is not thread-safe.
		 * @return If the ip couldn't be resolved, this function returns null,
		 * otherwise a pointer to a static buffer containing the hostname
		 * is returned.  
		 */
		[CCode (cname="SDLNet_ResolveIP")]
		public weak string? lookup();
	}// IPAddress

	[CCode (cname="UDPpacket", free_function="SDLNet_FreePacket")]
	[Compact]
	public class UDPPacket {
		public int channel;
		public uchar *data;
		public int len;
		public int maxlen;
		public int status;
		public IPAddress address;

		/** Allocate a single UDP packet 'size' bytes long. */
		[CCode (cname="SDLNet_AllocPacket")]
		public UDPPacket(int size);

		/** Resize a single UDP packet 'newsize' bytes long. */
		[CCode (cname="SDLNet_ResizePacket")]
		public int resize(int newsize);
	}// UDPPacket

	[CCode (cname="void")]
	[Compact]
	public class Socket {
		public int ready;
	}// Socket

	[CCode (cname="struct _TCPsocket", free_function="SDLNet_TCP_Close")]
	[Compact]
	public class TCPSocket: Socket {
		/** 
		 * Open a TCP network socket
		 * If ip.host is INADDR_NONE or INADDR_ANY, this creates a local server
		 * socket on the given port, otherwise a TCP connection to the remote
		 * host and port is attempted. 
		 * @param ip The address passed in should already be
		 * swapped to network byte order (addresses returned from 
		 * SDLNet_ResolveHost() are already in the correct form).
		 * @return The newly created socket is returned, or null if there was an error.
		 */
		[CCode (cname="SDLNet_TCP_Open")]
		public TCPSocket(IPAddress ip);

		/**
		 * Accept an incoming connection on the given server socket.
		 * @return The newly created socket is returned, or null if there was an error.
		 */
		[CCode (cname="SDLNet_TCP_Accept")]
		public TCPSocket? accept();

		/**
		 * Get the IP address of the remote system associated with the socket.
		 * @return If the socket is a server socket, this function returns null.
		 */
		[CCode (cname="SDLNet_TCP_GetPeerAddress")]
		public IPAddress? get_address();

		/**
		 * Send data over the non-server socket 'sock'
		 * @param data The data to send
		 * @return This function returns the actual amount of data sent.  If the return value
		 * is less than the amount of data sent, then either the remote connection was
		 * closed, or an unknown socket error occurred.
		 */
		[CCode (cname="SDLNet_TCP_Send")]
		public int send(uchar[] data);

		/**
		 * Receive up to (the length of data)  bytes of data over the non-server socket 'sock',
		 * and store them in the buffer pointed to by 'data'.
		 * @param data The buffer to store received data
		 * @return This function returns the actual amount of data received.  If the return
		 * value is less than or equal to zero, then either the remote connection was
		 * closed, or an unknown socket error occurred.
		 */
		[CCode (cname="SDLNet_TCP_Recv")]
		public int receive(uchar[] data);
	}// TCPSocket

	[CCode (cname="struct _UDPsocket", free_function="SDLNet_UDP_Close")]
	[Compact]
	public class UDPSocket: Socket {
		/**
		 * Open a UDP network socket
		 * @param port If 'port' is non-zero, the UDP socket is bound to a local port.
		 * The 'port' should be given in native byte order, but is used
		 * internally in network (big endian) byte order, in addresses, etc.
		 * This allows other systems to send to this socket via a known port.
		 */
		[CCode (cname="SDLNet_UDP_Open")]
		public UDPSocket(uint16 port);

		/**
		 * Bind the address 'address' to the requested channel on the UDP socket.
		 * @param channel If the channel is -1, then the first unbound channel that has not yet
		 * been bound to the maximum number of addresses will be bound with
		 * the given address as it's primary address.
		 * If the channel is already bound, this new address will be added to the
		 * list of valid source addresses for packets arriving on the channel.
		 * If the channel is not already bound, then the address becomes the primary
		 * address, to which all outbound packets on the channel are sent.
		 * @param address If the channel is -1, then the first unbound channel that has not yet
		 * been bound to the maximum number of addresses will be bound with
		 * the given address as it's primary address.
		 * If the channel is already bound, this new address will be added to the
		 * list of valid source addresses for packets arriving on the channel.
		 * If the channel is not already bound, then the address becomes the primary
		 * address, to which all outbound packets on the channel are sent.
		 * @return This function returns the channel which was bound, or -1 on error.
		 */
		[CCode (cname="SDLNet_UDP_Bind")]
		public int bind(int channel, IPAddress address);

		/** Unbind all addresses from the given channel */
		[CCode (cname="SDLNet_UDP_Unbind")]
		public void unbind(int channel);

		/**
		 * Get the primary IP address of the remote system associated with the 
		 * socket and channel.  
		 * @return If the channel is -1, then the primary IP port
		 * of the UDP socket is returned -- this is only meaningful for sockets
		 * opened with a specific port.
		 * If the channel is not bound and not -1, this function returns null
		 */
		[CCode (cname="SDLNet_UDP_GetPeerAddress")]
		public IPAddress? get_address(int channel);

		/**
		 * Send a single packet to the specified channel.
		 * NOTE:
		 * The maximum size of the packet is limited by the MTU (Maximum Transfer Unit)
		 * of the transport medium.  It can be as low as 250 bytes for some PPP links,
		 * and as high as 1500 bytes for ethernet.
		 * @param channel If the channel specified in the packet is -1, the packet will be sent to
		 * the address in the 'src' member of the packet.
		 * @param packet The packet will be updated with the status of the packet after it has
		 * been sent.
		 * @return This function returns 1 if the packet was sent, or 0 on error.
		 */
		[CCode (cname="SDLNet_UDP_Send")]
		public int send(int channel, UDPPacket packet);

		/**
		 * Receive a single packet from the UDP socket.
		 * @param packet The returned packet contains the source address and the channel it arrived
		 * on.  If it did not arrive on a bound channel, the the channel will be set
		 * to -1.
		 * The channels are checked in highest to lowest order, so if an address is
		 * bound to multiple channels, the highest channel with the source address
		 * bound will be returned.
		 * @return This function returns the number of packets read from the network, or -1
		 * on error.  This function does not block, so can return 0 packets pending.
		 */
		[CCode (cname="SDLNet_UDP_Recv")]
		public int receive(UDPPacket packet);

		/**
		 * Send a vector of packets to the the channels specified within the packet.
		 * If the channel specified in the packet is -1, the packet will be sent to
		 * the address in the 'src' member of the packet.
		 * Each packet will be updated with the status of the packet after it has 
		 * been sent, -1 if the packet send failed.
		 * @param packets The packets to send
		 * @return This function returns the number of packets sent.
		 */
		[CCode (cname="SDLNet_UDP_SendV")]
		public int send_many(UDPPacket[] packets);

		/**
		 * Receive a vector of pending packets from the UDP socket.
		 * @param packets The returned packets contain the source address and the channel they arrived
		 * on.  If they did not arrive on a bound channel, the the channel will be set
		 * to -1.
		 * The channels are checked in highest to lowest order, so if an address is
		 * bound to multiple channels, the highest channel with the source address
		 * bound will be returned.
		 * @return This function returns the number of packets read from the network, or -1
		 * on error.  This function does not block, so can return 0 packets pending.
		 */
		[CCode (cname="SDLNet_UDP_RecvV")]
		[NoArrayLength]
		public int receive_many(UDPPacket[] packets);
	}// UDPSocket

	[CCode (cname="struct _SDLNet_SocketSet", free_function="SDLNet_FreeSocketSet")]
	[Compact]
	public class SocketSet {
		/**
		 * Allocate a socket set
		 * @param maxsockets This creates a socket set for up to 'maxsockets' sockets
		 */
		[CCode (cname="SDLNet_AllocSocketSet")]
		public SocketSet(int maxsockets);

		/** Add a socket to a set of sockets to be checked for available data */
		[CCode (cname="SDLNet_AddSocket")]
		public int add(Socket socket);

		/** Remove a socket from a set of sockets to be checked for available data */
		[CCode (cname="SDLNet_DelSocket")]
		public int remove(Socket socket);

		/**
		 * This function checks to see if data is available for reading on the
		 * given set of sockets.  
		 * @param timeout If 'timeout' is 0, it performs a quick poll,
		 * otherwise the function returns when either data is available for
		 * reading, or the timeout in milliseconds has elapsed, which ever occurs
		 * first.  
		 * @return This function returns the number of sockets ready for reading, 
		 * or -1 if there was an error with the select() system call.
		 */
		[CCode (cname="SDLNet_CheckSockets")]
		public int has_data(uint timeout);
	}// SocketSet
}// SDL
