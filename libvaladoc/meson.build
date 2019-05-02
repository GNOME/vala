libvaladoc_sources = files([
	'ctyperesolver.vala',
	'devhelp-markupwriter.vala',
	'doclet.vala',
	'errorreporter.vala',
	'filehelper.vala',
	'gtkdocmarkupwriter.vala',
	'gtkdocrenderer.vala',
	'gvc-compat.c',
	'markupwriter.vala',
	'moduleloader.vala',
	'settings.vala',
])

subdir('api')
subdir('charts')
subdir('content')
subdir('documentation')
subdir('highlighter')
subdir('html')
subdir('importer')
subdir('parser')
subdir('taglets')

libvaladoc_sources += api_sources
libvaladoc_sources += charts_sources
libvaladoc_sources += content_sources
libvaladoc_sources += documentation_sources
libvaladoc_sources += highlighter_sources
libvaladoc_sources += html_sources
libvaladoc_sources += importer_sources
libvaladoc_sources += parser_sources
libvaladoc_sources += taglets_sources

libvaladoc_lib = shared_library(
	'valadoc@0@'.format(vala_version_suffix),
	libvaladoc_sources,
	dependencies: [gmodule_dep, valacore_lib_deps, libgvc_dep,
		inc_libvalarooth_dep,
		inc_libvalah_dep,
		inc_libvalacodegenh_dep,
		inc_libvalaccodeh_dep,
		inc_libvalageeh_dep],
	version: '0.0.0',
	install: true,
	install_dir: [
		true,
		join_paths (get_option('includedir'), 'valadoc@0@'.format (vala_version_suffix)),
		true
	],
	c_args: ['-DPACKAGE_VALADOC_LIBDIR="@0@"'.format(join_paths(get_option('prefix'), get_option('libdir'), 'valadoc'))],
	vala_args: ['--use-header'],
	vala_header: 'valadoc.h',
	vala_vapi: 'valadoc@0@.vapi'.format(vala_version_suffix),
	link_with: valacore_lib
)

libvaladoc_dep = declare_dependency(
	link_with: [libvaladoc_lib],
	dependencies: [gmodule_dep, valacore_lib_deps, libgvc_dep],
	include_directories: include_directories('.'))

configure_file(input: 'valadoc.deps.in', output: 'valadoc@0@.deps'.format(vala_version_suffix), configuration: pkgconf)

configure_file(
	input: 'valadoc.pc.in',
	output: 'valadoc@0@.pc'.format(vala_version_suffix),
	configuration: pkgconf,
	install_dir: pkg_install_dir,
)
