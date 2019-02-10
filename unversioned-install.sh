#!/bin/sh

cd "${DESTDIR}/${MESON_INSTALL_PREFIX}/mydir"
ln -s -f "${DESTDIR}/${MESON_INSTALL_PREFIX}/mydir"
touch "${DESTDIR}/${MESON_INSTALL_PREFIX}/mydir/file.dat"

install-exec-hook:
	cd $(DESTDIR)$(bindir) && $(LN_S) -f vapigen@PACKAGE_SUFFIX@$(EXEEXT) vapigen$(EXEEXT)
	cd $(DESTDIR)$(bindir) && $(LN_S) -f vapicheck@PACKAGE_SUFFIX@$(EXEEXT) vapicheck$(EXEEXT)

install-data-hook:
	cd $(DESTDIR)$(pkgconfigdir) && $(LN_S) -f vapigen@PACKAGE_SUFFIX@.pc vapigen.pc

