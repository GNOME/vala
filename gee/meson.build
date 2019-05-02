inc_libvalageeh = include_directories ('.')
inc_libvalageeh_dep = declare_dependency (include_directories : inc_libvalageeh)

valagee_sources = [
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
]


valagee_sources_c = []

foreach f : valagee_sources
	if get_option ('bootstrap')
		af = f.split('.vala')
		nf = af[0] + '.c'
		valagee_sources_c += nf
	endif
endforeach

install_dirs = [
		false,
		join_paths (get_option('includedir'), 'vala@0@'.format (vala_version_suffix)),
		false
	]
if get_option ('bootstrap')

install_dirs = [
		true
	]
endif

valagee_lib = static_library(
	'valagee',
	valagee_sources_c,
	dependencies: [gobject_dep],
	install: [ false, true, false ],
	install_dir: install_dirs,
	vala_args: ['--use-header'],
	vala_header: 'valagee.h',
	vala_vapi: 'gee.vapi',
)

valagee_dep = declare_dependency(
	link_with: [valagee_lib],
	include_directories: include_directories('.', '..'),
)
