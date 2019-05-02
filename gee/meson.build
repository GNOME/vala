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
		nf = join_paths (meson.current_source_dir (), af[0] + '.c')
		valagee_sources_c += nf
	else
		valagee_sources_c += join_paths (meson.current_source_dir (), f)
	endif
endforeach
