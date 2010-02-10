/* config.vapi
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */

[CCode (cprefix = "", lower_case_cprefix = "", cheader_filename = "config.h")]
namespace Config {
	[CCode (cname = "PACKAGE_VERSION")]
	public const string version;

	[CCode (cname = "PACKAGE_DATADIR")]
	public const string plugin_dir;

	[CCode (cname = "PACKAGE_VAPIDIR")]
	public const string vapi_dir;
}

