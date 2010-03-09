namespace GData {
	public class Feed {
		public unowned GLib.List<GData.Author> get_authors ();
		public unowned GLib.List<GData.Category> get_categories ();
		public unowned GLib.List<GData.Entry> get_entries ();
	}

	[CCode (type_check_function = "GDATA_IS_PICASAWEB_SERVICE", cheader_filename = "gdata/gdata.h")]
	public class PicasaWebService {
		[CCode (cname = "gdata_picasaweb_service_query_all_albums_async")]
		public async void query_all_albums_async (GData.Query? query, string username, GLib.Cancellable? cancellable, GData.QueryProgressCallback progress_callback);
		[CCode (cname = "gdata_picasaweb_service_upload_file_async")]
		public async GData.PicasaWebFile upload_file_async (GData.PicasaWebAlbum album, GData.PicasaWebFile file_entry, GLib.File file_data, GLib.Cancellable? cancellable = null) throws GLib.Error;
	}
}
