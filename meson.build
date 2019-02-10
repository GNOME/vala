project('vala',
	'c', 'vala',
	version: '0.43.90',
	meson_version: '>= 0.49',
	license: 'LGPL2.1'
)

vala_version = meson.project_version()
version_array = vala_version.split('.')
vala_api_version = '0.44'
vala_version_suffix = '-@0@'.format(vala_api_version)

# Minimal required version for an initial build
vala_version_required = '0.16.1'
vala = meson.get_compiler('vala')
if not vala.version().version_compare('>= @0@'.format(vala_version_required))
	error('valac >= @0@ required!'.format(vala_version_required))
endif
if not vala.version().version_compare('>= @0@'.format(vala_version))
	warning('Proper bootstrap build with valac >= @0@ is required!!!'.format(vala_version))
endif

pkgdatadir = join_paths(get_option('prefix'), get_option('datadir'), 'vala@0@'.format(vala_version_suffix))
pkglibdir = join_paths(get_option('prefix'), get_option('libdir'), 'vala@0@'.format(vala_version_suffix))


conf = configuration_data()
conf.set_quoted('PACKAGE', meson.project_name())
conf.set_quoted('PACKAGE_BUGREPORT', 'https://gitlab.gnome.org/GNOME/vala/issues')
conf.set_quoted('PACKAGE_DATADIR', pkgdatadir)
conf.set_quoted('PACKAGE_NAME', meson.project_name())
conf.set_quoted('PACKAGE_STRING', '@0@ @1@'.format(meson.project_name(), vala_version))
conf.set_quoted('PACKAGE_SUFFIX', vala_version_suffix)
conf.set_quoted('PACKAGE_TARNAME', meson.project_name())
conf.set_quoted('PACKAGE_URL', 'https://wiki.gnome.org/Projects/Vala')
conf.set_quoted('PACKAGE_VERSION', vala_version)
conf.set_quoted('VERSION', vala_version)
conf.set_quoted('API_VERSION', vala_api_version)
conf.set_quoted('BUILD_VERSION', vala_version)
configure_file(input: 'config.h.meson', output: 'config.h', configuration: conf)


vcs_tag(input: 'version.h.meson', output: 'version.h')


pkgconf = configuration_data()
pkgconf.set('prefix', get_option('prefix'))
pkgconf.set('exec_prefix', '${prefix}')
pkgconf.set('libdir', '${prefix}/@0@'.format(get_option('libdir')))
pkgconf.set('bindir', '${exec_prefix}/@0@'.format(get_option('bindir')))
pkgconf.set('datarootdir', '${prefix}/@0@'.format(get_option('datadir')))
pkgconf.set('datadir', '${datarootdir}')
pkgconf.set('includedir', '${prefix}/@0@'.format(get_option('includedir')))
pkgconf.set('pkgdatadir', '${datarootdir}/vala@0@'.format(vala_version_suffix))
pkgconf.set('pkglibdir', '${exec_prefix}/@0@'.format(get_option('libdir'), 'vala@0@'.format(vala_version_suffix)))
pkgconf.set('PACKAGE_SUFFIX', vala_version_suffix)
pkgconf.set('VERSION', vala_version)
pkg_install_dir = '@0@/pkgconfig'.format(get_option('libdir'))

configure_file(
	input: 'libvala.pc.in',
	output: 'libvala@0@.pc'.format(vala_version_suffix),
	configuration: pkgconf,
	install_dir: pkg_install_dir
)

versionconf = configuration_data()
versionconf.set('VALA_MAJOR_VERSION', version_array[0])
versionconf.set('VALA_MINOR_VERSION', version_array[1])
versionconf.set('VALA_MICRO_VERSION', version_array[2])
versionconf.set('API_VERSION', vala_api_version)
versionconf.set('PACKAGE_VERSION', vala_version)

add_project_arguments([
		'--disable-version-header',
		'--vapidir', join_paths(meson.source_root(), 'vapi'),
		'--pkg', 'config',
	],
	language: 'vala'
)

if vala.version().version_compare('>= 0.25.1')
	add_project_arguments(['--hide-internal'], language: 'vala')
endif

if vala.version().version_compare('>= 0.39.6')
	add_project_arguments(['--abi-stability'], language: 'vala')
endif


add_project_arguments([
		'-Wno-discarded-qualifiers',
		'-Wno-incompatible-pointer-types',
		'-Wno-unused',
		'-DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_40',
		'-DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_40',
	],
	language: 'c',
)

glib_version_required = '2.40.0'
libgvc_version_required = '2.16'

glib_dep = dependency('glib-2.0', version: '>= @0@'.format(glib_version_required))
gobject_dep = dependency('gobject-2.0', version: '>= @0@'.format(glib_version_required))
gmodule_dep = dependency('gmodule-2.0', version: '>= @0@'.format(glib_version_required))
libgvc_dep = dependency('libgvc', version: '>= @0@'.format(libgvc_version_required))

# Check for CGraph support of libgvc
cc = meson.get_compiler('c')
if cc.run('''#include <gvc.h>
		int main(void) {
		#ifdef WITH_CGRAPH
			return 0;
		#else
			return -1;
		#endif
		}''',
		dependencies: libgvc_dep).returncode() == 0
	add_project_arguments('-D', 'WITH_CGRAPH', language: 'vala')
endif

subdir('gobject-introspection')
subdir('gee')
subdir('vala')
subdir('ccode')
subdir('codegen')
subdir('compiler')
subdir('vapigen')
subdir('libvaladoc')
subdir('valadoc')
subdir('vapi')
subdir('doc')

install_data('vala.m4', install_dir: join_paths('share', 'aclocal'))

pycat = find_program(join_paths(meson.source_root(), 'build-aux', 'meson', 'cat.py'))
#custom_target(
#	'libvala@0@.vapi'.format(vala_version_suffix),
#	command: [pycat, '@INPUT@'],
#	depends: [valagee_lib, valacore_lib],
#	capture: true,
#	install: true,
#	install_dir: join_paths('share', 'vala', 'vapi'),
#	input: [
#		join_paths(meson.current_build_dir(), 'gee', 'gee.vapi'),
#		join_paths(meson.current_build_dir(), 'vala', 'vala.vapi'),
#	],
#	output: 'libvala@0@.vapi'.format(vala_version_suffix),
#)
