install_man(['vala-gen-introspect.1', 'valac.1', 'valadoc.1', 'vapigen.1'])

# https://github.com/mesonbuild/meson/issues/1602
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative vala-gen-introspect.1.gz @1@'.format(join_paths(get_option('prefix'), get_option('mandir')), 'vala-gen-introspect@0@.1.gz'.format(vala_version_suffix)))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative valac.1.gz @1@'.format(join_paths(get_option('prefix'), get_option('mandir')), 'valac@0@.1.gz'.format(vala_version_suffix)))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative valadoc.1.gz @1@'.format(join_paths(get_option('prefix'), get_option('mandir')), 'valadoc@0@.1.gz'.format(vala_version_suffix)))
meson.add_install_script('sh', '-c', 'cd $DESTDIR@0@/man1; ln -fs --relative vapigen.1.gz @1@'.format(join_paths(get_option('prefix'), get_option('mandir')), 'vapigen@0@.1.gz'.format(vala_version_suffix)))
