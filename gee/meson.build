valagee_sources = files(
	'arraylist.vala',
	'collection.vala',
	'hashmap.vala',
	'hashset.vala',
	'iterable.vala',
	'iterator.vala',
	'list.vala',
	'mapiterator.vala',
	'map.vala',
	'set.vala',
	'timsort.vala',
)

valagee_lib = static_library(
	'valagee',
	valagee_sources,
	dependencies: [gobject_dep],
	install: [ false, true, false ],
	install_dir: [
		false,
		join_paths (get_option('includedir'), 'vala@0@'.format (vala_version_suffix)),
		false
	],
	vala_args: ['--use-header'],
	vala_header: 'valagee.h',
	vala_vapi: 'gee.vapi',
)

valagee_dep = declare_dependency(
	link_with: [valagee_lib],
	include_directories: include_directories('.', '..'),
)
