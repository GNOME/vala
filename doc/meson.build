manpages = files(
	'vala-gen-introspect.1',
	'valac.1',
	'vapigen.1',
)

# https://github.com/mesonbuild/meson/issues/1602
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative vala-gen-introspect.1 @1@'.format(join_paths(get_option('prefix'), get_option('mandir')), 'vala-gen-introspect@0@.1'.format(vala_version_suffix)))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative valac.1 @1@'.format(join_paths(get_option('prefix'), get_option('mandir')), 'valac@0@.1'.format(vala_version_suffix)))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative vapigen.1 @1@'.format(join_paths(get_option('prefix'), get_option('mandir')), 'vapigen@0@.1'.format(vala_version_suffix)))

if valadoc_enabled
	manpages += files('valadoc.1')
	meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative valadoc.1 @1@'.format(join_paths(get_option('prefix'), get_option('mandir')), 'valadoc@0@.1'.format(vala_version_suffix)))
endif

install_man(manpages)
