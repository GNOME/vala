namespace Tracker {

		namespace Ontology {
				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static void field_add (Tracker.Field field);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]				
				public static unowned string field_get_display_name (Tracker.Field field);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static unowned string field_get_id (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static bool field_is_child_of (string child, string parent);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static unowned Tracker.Field get_field_by_id (int id);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static unowned Tracker.Field get_field_by_name (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static unowned string get_field_name_by_service_name (Tracker.Field field, string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static unowned GLib.SList get_field_names_registered (string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]				
				public static unowned string get_service_by_id (int id);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static unowned string get_service_by_mime (string mime);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static unowned Tracker.Service get_service_by_name (string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static Tracker.DBType get_service_db_by_name (string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]				
				public static int get_service_id_by_name (string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static unowned GLib.SList get_service_names_registered ();

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static unowned string get_service_parent (string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static unowned string get_service_parent_by_id (int id);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static int get_service_parent_id_by_id (int id);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static void init ();

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static void service_add (Tracker.Service service, GLib.SList mimes, GLib.SList mime_prefixes);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static int service_get_key_metadata (string service_str, string meta_name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static bool service_get_show_directories (string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static bool service_get_show_files (string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static bool service_has_embedded (string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static bool service_has_metadata (string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static bool service_has_text (string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static bool service_has_thumbnails (string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]
				public static bool service_is_valid (string service_str);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-ontology.h")]				
				public static void shutdown ();
				
		}

		namespace ModuleConfig{
				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static unowned string get_description (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static bool get_enabled (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static unowned GLib.List get_ignored_directories (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static unowned GLib.List get_ignored_directory_patterns (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static unowned GLib.List get_ignored_file_patterns (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static unowned GLib.List get_ignored_files (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static unowned GLib.List get_index_file_patterns (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static unowned GLib.List get_index_files (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static unowned GLib.List get_index_mime_types (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static unowned string get_index_service (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static unowned GLib.List get_modules ();

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static unowned GLib.List get_monitor_directories (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static unowned GLib.List get_monitor_recurse_directories (string name);

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static bool init ();

				[CCode (cheader_filename = "tracker-1.0/libtracker-common/tracker-module-config.h")]
				public static void shutdown ();

		}

		namespace Module {
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h")]
				public delegate void FileFreeDataFunc ();
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h", has_target = false)]
				public delegate void* FileGetDataFunc (string path);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h", has_target = false)]
				public delegate unowned Tracker.Metadata FileGetMetadataFunc (Tracker.File file);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h", has_target = false)]
				public delegate unowned string FileGetServiceTypeFunc (Tracker.File file);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h", has_target = false)]
				public delegate unowned string FileGetText (Tracker.File path);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h", has_target = false)]
				public delegate void FileGetUriFunc (Tracker.File file, string dirname, string basename);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h", has_target = false)]
				public delegate bool FileIterContents (Tracker.File path);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h", has_target = false)]
				public delegate unowned string GetDirectoriesFunc ();
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h", has_target = false)]
				public delegate unowned string GetNameFunc ();
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h", has_target = false)]
				public delegate void Init ();
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h", has_target = false)]
				public delegate void Shutdown ();

				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h")]
				public static void file_free_data (void* file_data);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h")]
				public static void* file_get_data (string path);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h")]
				public static unowned Tracker.Metadata file_get_metadata (Tracker.File file);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h")]
				public static unowned string file_get_service_type (Tracker.File file);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h")]
				public static unowned string file_get_text (Tracker.File file);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h")]
				public static void file_get_uri (Tracker.File file, string dirname, string basename);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h")]
				public static bool file_iter_contents (Tracker.File file);
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h")]
				public static unowned string get_name ();
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h")]
				public static void init ();
				[CCode (cheader_filename = "tracker-1.0/libtracker-indexer/tracker-module.h")]
				public static void shutdown ();
		}

}
