/* avahi.vala
 *
 * Copyright (C) 2009  Sebastian Noack
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
 * As a special exception, if you use inline functions from this file, this
 * file does not by itself cause the resulting executable to be covered by
 * the GNU Lesser General Public License.
 *
 * Author:
 *  Sebastian Noack <sebastian.noack@gmail.com>
 */

[CCode(cprefix="Ga", lower_case_cprefix="ga_")]
namespace Avahi {
	/* Error handling */

	[CCode(cheader_filename="avahi-gobject/ga-error.h", cprefix="AVAHI_ERR_")]
	public errordomain Error {
		FAILURE,
		BAD_STATE,
		INVALID_HOST_NAME,
		INVALID_DOMAIN_NAME,
		NO_NETWORK,
		INVALID_TTL,
		IS_PATTERN,
		COLLISION,
		INVALID_RECORD,

		INVALID_SERVICE_NAME,
		INVALID_SERVICE_TYPE,
		INVALID_PORT,
		INVALID_KEY,
		INVALID_ADDRESS,
		TIMEOUT,
		TOO_MANY_CLIENTS,
		TOO_MANY_OBJECTS,
		TOO_MANY_ENTRIES,
		OS,

		ACCESS_DENIED,
		INVALID_OPERATION,
		DBUS_ERROR,
		DISCONNECTED,
		NO_MEMORY,
		INVALID_OBJECT,
		NO_DAEMON,
		INVALID_INTERFACE,
		INVALID_PROTOCOL,
		INVALID_FLAGS,

		NOT_FOUND,
		INVALID_CONFIG,
		VERSION_MISMATCH,
		INVALID_SERVICE_SUBTYPE,
		INVALID_PACKET,
		INVALID_DNS_ERROR,
		DNS_FORMERR,
		DNS_SERVFAIL,
		DNS_NXDOMAIN,
		DNS_NOTIMP,

		DNS_REFUSED,
		DNS_YXDOMAIN,
		DNS_YXRRSET,
		DNS_NXRRSET,
		DNS_NOTAUTH,
		DNS_NOTZONE,
		INVALID_RDATA,
		INVALID_DNS_CLASS,
		INVALID_DNS_TYPE,
		NOT_SUPPORTED,

		NOT_PERMITTED,
		INVALID_ARGUMENT,
		IS_EMPTY,
		NO_CHANGE
	}

	[CCode(cheader_filename="avahi-gobject/ga-error.h", cname="avahi_strerror")]
	public unowned string strerror(int errno);


	/* Network addresses */

	[SimpleType]
	[CCode(cheader_filename="avahi-common/address.h", cname="AvahiProtocol", cprefix="avahi_proto_")]
	public struct Protocol {
		[CCode(cname="AVAHI_PROTO_INET")]
		public static Protocol INET;
		[CCode(cname="AVAHI_PROTO_INET6")]
		public static Protocol INET6;
		[CCode(cname="AVAHI_PROTO_UNSPEC")]
		public static Protocol UNSPEC;

		[CCode(cname="avahi_af_to_proto")]
		public Protocol.from_af(int af);

		public unowned string to_string();
		public int to_af();
		[CCode(cname="AVAHI_PROTO_VALID")]
		public bool is_valid();
	}

	[SimpleType]
	[CCode(cheader_filename="avahi-common/address.h", cname="AvahiIfIndex")]
	public struct Interface {
		[CCode(cname="AVAHI_IF_UNSPEC")]
		public static Interface UNSPEC;

		[CCode(cname="AVAHI_IF_VALID")]
		public bool is_valid();
	}

	[CCode(cheader_filename="avahi-common/address.h", cname="AvahiAddress", cprefix="avahi_address_")]
	public struct Address {
		public Protocol proto;

		[CCode(cname="AVAHI_ADDRESS_STR_MAX")]
		public static size_t STR_MAX;

		[CCode(cname="avahi_address_parse", instance_pos=-1)]
		public Address.parse(string s, Protocol proto=Protocol.UNSPEC);

		[CCode(cname="avahi_address_snprint", instance_pos=-1)]
		public unowned string to_string(char[] dest=new char[STR_MAX]);
		public int cmp(Address other);
	}


	/* Linked list of strings used for DNS TXT record data */

	[CCode(cheader_filename="avahi-common/defs.h", cname="AVAHI_SERVICE_COOKIE_INVALID")]
	public const uint32 SERVICE_COOKIE_INVALID;

	[Compact]
	[CCode(cheader_filename="avahi-common/strlst.h", cname="AvahiStringList", cprefix="avahi_string_list_", dup_function="avahi_string_list_copy", free_function="avahi_string_list_free")]
	public class StringList {
		public StringList next;
		[CCode(array_length_cname="size")]
		public char[] text;

		public StringList(string? txt=null, ...);
		public StringList.from_array(string[] array);

		[ReturnsModifiedPointer()]
		public void add(string text);
		[ReturnsModifiedPointer()]
		[PrintfFormat]
		public void add_printf(string format, ...);
		[ReturnsModifiedPointer()]
		public void add_arbitrary(char[] text);
		[ReturnsModifiedPointer()]
		public void add_anonymous(size_t size);
		[ReturnsModifiedPointer()]
		public void add_many(...);

		public string to_string();
		public int equal(StringList other);
		public StringList copy();
		[ReturnsModifiedPointer()]
		public void reverse();
		public uint length();

		public unowned StringList find(string key);
		public bool get_pair(out string key, out char[] value);
		[ReturnsModifiedPointer()]
		public void add_pair(string key, string? value);
		[ReturnsModifiedPointer()]
		public void add_pair_arbitrary(string key, char[] value);
		public uint32 get_service_cookie();

		[CCode(cname="avahi_string_list_serialize")]
		private size_t _serialize(char[] dest);
		[CCode(cname="avahi_string_list_serialize_dup")]
		public char[] serialize() {
			char[] dest = new char[this.length() * 256];
			dest.length = (int) _serialize(dest);
			return dest;
		}

		[CCode(cname="avahi_string_list_parse")]
		private static int _parse(char[] data, out StringList dest);
		[CCode(cname="avahi_string_list_parse_dup")]
		public static StringList parse(char[] data) throws Error {
			StringList dest;

			int errno = _parse(data, out dest);
			if (errno < 0) {
				var err = new Error.FAILURE(strerror(errno));
				err.code = errno;
				throw err;
			}

			return dest;
		}
	}


	/* Domain name utility functions */

	[CCode(cheader_filename="avahi-common/domain.h", lower_case_cprefix="avahi_")]
	namespace Domain {
		public const size_t DOMAIN_NAME_MAX;
		public const size_t LABEL_MAX;

		[CCode(cname="avahi_normalize_name_strdup")]
		public string normalize_name(string s);
		[CCode(cname="avahi_domain_equal")]
		public bool equal(string a, string b);
		[CCode(cname="avahi_domain_hash")]
		public uint hash(string name);
		public unowned string? get_type_from_subtype(string s);
		public unowned string? unescape_label(ref unowned string name, char[] dest=new char[LABEL_MAX]);

		[CCode(cname="avahi_escape_label")]
		private string? _escape_label(char* src, size_t src_len, ref char* dest, ref size_t dest_len);
		[CCode(cname="avahi_escape_label_dup")]
		public string? escape_label(string s) {
			size_t len = LABEL_MAX * 4;
			char* dest = new char[len];
			return _escape_label(s, s.size(), ref dest, ref len);
		}

		[CCode(cname="avahi_service_name_join")]
		private int _service_name_join(char* dest, size_t dest_len, string name, string type, string domain);
		[CCode(cname="avahi_service_name_join_dup")]
		public string service_name_join(string name, string type, string domain) throws Error {
			char* dest = new char[DOMAIN_NAME_MAX];

			int errno = _service_name_join(dest, DOMAIN_NAME_MAX, name, type, domain);
			if (errno < 0) {
				var err = new Error.FAILURE(strerror(errno));
				err.code = errno;
				throw err;
			}

			return (string) dest;
		}

		[CCode(cname="avahi_service_name_split")]
		private int _service_name_split(string src, char* name,   size_t name_len,
													char* type,   size_t type_len,
													char* domain, size_t domain_len);
		[CCode(cname="avahi_service_name_split_dup")]
		public void service_name_split(string src, out string name, out string type, out string domain) throws Error {
			name = (string) new char[LABEL_MAX];
			type = (string) new char[DOMAIN_NAME_MAX];
			domain = (string) new char[DOMAIN_NAME_MAX];

			int errno = _service_name_split(src, name,   LABEL_MAX,
												 type,   DOMAIN_NAME_MAX,
												 domain, DOMAIN_NAME_MAX);
			if (errno < 0) {
				var err = new Error.FAILURE(strerror(errno));
				err.code = errno;
				throw err;
			}
		}

		public bool is_valid_service_type_generic(string s);
		public bool is_valid_service_type_strict(string s);
		public bool is_valid_service_subtype(string s);
		public bool is_valid_domain_name(string s);
		public bool is_valid_service_name(string s);
		public bool is_valid_host_name(string s);
		public bool is_valid_fqdn(string s);

		[CCode(cheader_filename="avahi-common/address.h")]
		public unowned string reverse_lookup_name(Address addr, char[] dest=new char[DOMAIN_NAME_MAX]);
	}

	[CCode(cheader_filename="avahi-common/alternative.h", lower_case_cprefix="avahi_alternative_")]
	namespace Alternative {
		public string host_name(string s);
		public string service_name(string s);
	}


	/* Lookup flags */

	[CCode(cheader_filename="avahi-gobject/ga-enums.h", cprefix="GA_LOOKUP_RESULT_")]
	public enum LookupResultFlags {
		CACHED,
		WIDE_AREA,
		MULTICAST,
		LOCAL,
		OUR_OWN,
		STATIC
	}

	[Flags]
	[CCode(cheader_filename="avahi-gobject/ga-enums.h", cprefix="GA_LOOKUP_")]
	public enum LookupFlags {
		NO_FLAGS,
		USE_WIDE_AREA,
		USE_MULTICAST,
		NO_TXT,
		NO_ADDRESS
	}


	/* Client */

	[CCode(cheader_filename="avahi-gobject/ga-client.h")]
	public enum ClientState {
		NOT_STARTED,
		S_REGISTERING,
		S_RUNNING,
		S_COLLISION,
		FAILURE,
		CONNECTING
	}

	[Flags]
	[CCode(cheader_filename="avahi-gobject/ga-client.h", cprefix="GA_CLIENT_FLAG_")]
	public enum ClientFlags {
		NO_FLAGS,
		IGNORE_USER_CONFIG,
		NO_FAIL
	}

	[CCode(cheader_filename="avahi-gobject/ga-client.h")]
	public class Client : GLib.Object {
		public Client(ClientFlags flags=ClientFlags.NO_FLAGS);

		public void start() throws Error;

		[NoAccessorMethod]
		public ClientState state { get; }
		[NoAccessorMethod]
		public ClientFlags flags { get; construct; }

		public signal void state_changed(ClientState state);
	}


	/* Record browser */

	[CCode(cheader_filename="avahi-gobject/ga-record-browser.h")]
	public class RecordBrowser : GLib.Object {
		public RecordBrowser(string name, uint16 type);
		public RecordBrowser.full(Interface interface, Protocol protocol, string name, uint16 class, uint16 type, LookupFlags flags=LookupFlags.NO_FLAGS);

		public void attach(Client client) throws Error;

		[NoAccessorMethod]
		public Protocol protocol { get; set; }
		[NoAccessorMethod]
		public Interface interface { get; set; }
		[NoAccessorMethod]
		public string name { owned get; set; }
		[NoAccessorMethod]
		public uint16 type { get; set; }
		[NoAccessorMethod]
		public uint16 class { get; set; }
		[NoAccessorMethod]
		public LookupFlags flags { get; set; }

		public signal void new_record(Interface interface, Protocol protocol, string name, uint16 class, uint16 type, char[] data, LookupResultFlags flags);
		public signal void removed_record(Interface interface, Protocol protocol, string name, uint16 class, uint16 type, char[] data, LookupResultFlags flags);
		public signal void all_for_now();
		public signal void cache_exhausted();
		public signal void failure(GLib.Error error);
	}


	/* Service browser */

	[CCode(cheader_filename="avahi-gobject/ga-service-browser.h")]
	public class ServiceBrowser : GLib.Object {
		public ServiceBrowser(string type);
		public ServiceBrowser.full(Interface interface, Protocol protocol, string type, string? domain=null, LookupFlags flags=LookupFlags.NO_FLAGS);

		public void attach(Client client) throws Error;

		[NoAccessorMethod]
		public Protocol protocol { get; set; }
		[NoAccessorMethod]
		public Protocol aprotocol { get; set; }
		[NoAccessorMethod]
		public Interface interface { get; set; }
		[NoAccessorMethod]
		public string type { owned get; set; }
		[NoAccessorMethod]
		public string? domain { owned get; set; }
		[NoAccessorMethod]
		public LookupFlags flags { get; set; }

		public signal void new_service(Interface interface, Protocol protocol, string name, string type, string domain, LookupResultFlags flags);
		public signal void removed_service(Interface interface, Protocol protocol, string name, string type, string domain, LookupResultFlags flags);
		public signal void all_for_now();
		public signal void cache_exhausted();
		public signal void failure(GLib.Error error);
	}


	/* Service resolver */

	[CCode(cheader_filename="avahi-gobject/ga-service-resolver.h")]
	public class ServiceResolver : GLib.Object {
		public ServiceResolver(Interface interface, Protocol protocol, string name, string type, string domain, Protocol address_protocol, LookupFlags flags=LookupFlags.NO_FLAGS);

		public void attach(Client client) throws Error;
		public bool get_address(out Address address, out uint16 port);

		[NoAccessorMethod]
		public Protocol protocol { get; set; }
		[NoAccessorMethod]
		public Protocol aprotocol { get; set; }
		[NoAccessorMethod]
		public Interface interface { get; set; }
		[NoAccessorMethod]
		public string name { owned get; set; }
		[NoAccessorMethod]
		public string type { owned get; set; }
		[NoAccessorMethod]
		public string domain { owned get; set; }
		[NoAccessorMethod]
		public LookupFlags flags { get; set; }

		public signal void found(Interface interface, Protocol protocol, string name, string type, string domain, string hostname, Address? address, uint16 port, StringList? txt, LookupResultFlags flags);
		public signal void failure(GLib.Error error);
	}


	/* Entry group */

	[Flags]
	[CCode(cheader_filename="avahi-common/defs.h", cname="AvahiPublishFlags", cfrefix="AVAHI_PUBLISH_")]
	public enum PublishFlags {
		UNIQUE,
		NO_PROBE,
		NO_ANNOUNCE,
		ALLOW_MULTIPLE,
		NO_REVERSE,
		NO_COOKIE,
		UPDATE,
		USE_WIDE_AREA,
		USE_MULTICAST
	}

	[CCode(cheader_filename="avahi-gobject/ga-entry-group.h")]
	public enum EntryGroupState {
		UNCOMMITED,
		REGISTERING,
		ESTABLISHED,
		COLLISTION,
		FAILURE
	}

	[Compact]
	[CCode(cheader_filename="avahi-gobject/ga-entry-group.h", ref_function="", unref_function="")]
	public class EntryGroupService {
		public Interface interface;
		public Protocol protocol;
		public PublishFlags flags;
		public string name;
		public string type;
		public string domain;
		public string host;
		public uint16 port;

		public void freeze();
		public void set(string key, string value) throws Error;
		public void set_arbitrary(string key, char[] value) throws Error;
		public void remove_key(string key) throws Error;
		public void thaw() throws Error;
	}

	[CCode(cheader_filename="avahi-gobject/ga-entry-group.h")]
	public class EntryGroup : GLib.Object {
		public EntryGroup();

		public void attach(Client client) throws Error;
		[CCode(sentinel="")]
		public EntryGroupService add_service_strlist(string name, string type, uint16 port, ...) throws Error;
		[CCode(sentinel="")]
		public EntryGroupService add_service_full_strlist(Interface interface, Protocol protocol, PublishFlags flags, string name, string type, string domain, string host, uint16 port, ...) throws Error;
		public EntryGroupService add_service(string name, string type, ...) throws Error;
		public EntryGroupService add_service_full(Interface interface, Protocol protocol, PublishFlags flags, string name, string type, string domain, string host, uint16 port, ...) throws Error;
		public void add_record(PublishFlags flags, string name, uint16 type, uint32 ttl, char[] data) throws Error;
		public void add_record_full(Interface interface, Protocol protocol, PublishFlags flags, string name, uint16 class, uint16 type, uint32 ttl, char[] data) throws Error;
		public void commit() throws Error;
		public void reset() throws Error;

		[NoAccessorMethod]
		public EntryGroupState state { get; }

		public signal void state_changed(EntryGroupState state);
	}
}
