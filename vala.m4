dnl vala.m4
dnl
dnl Copyright 2010 Marc-Andre Lureau
dnl Copyright 2011 Rodney Dawes <dobey.pwns@gmail.com>
dnl
dnl This library is free software; you can redistribute it and/or
dnl modify it under the terms of the GNU Lesser General Public
dnl License as published by the Free Software Foundation; either
dnl version 2.1 of the License, or (at your option) any later version.
dnl
dnl This library is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
dnl Lesser General Public License for more details.
dnl
dnl You should have received a copy of the GNU Lesser General Public
dnl License along with this library; if not, write to the Free Software
dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA

# _VALA_CHECK_COMPILE_WITH_ARGS(ARGS, [ACTION-IF-TRUE],
#   [ACTION-IF-FALSE])
# --------------------------------------
# Check that Vala compile with ARGS.
#
AC_DEFUN([_VALA_CHECK_COMPILE_WITH_ARGS],
[AC_REQUIRE([AM_PROG_VALAC])[]dnl

  cat <<_ACEOF >conftest.vala
void main(){}
_ACEOF

  AS_IF([vala_error=`$VALAC $1 -q -o conftest$ac_exeext conftest.vala 2>&1`],
        [$2], [$3])
])

])# _VALA_CHECK_COMPILE_WITH_ARGS

# VALA_CHECK_PACKAGES(PKGS, [ACTION-IF-FOUND],
#   [ACTION-IF-NOT-FOUND])
# --------------------------------------
# Check that PKGS Vala bindings are installed and usable.
#
AC_DEFUN([VALA_CHECK_PACKAGES],
[
  ac_save_ifs="$IFS"; unset IFS
  for vala_pkg in $(echo "$1"); do
      vala_pkgs="$vala_pkgs --pkg $vala_pkg"
      vala_bindings="$vala_bindings $vala_pkg"
  done
  IFS="$ac_save_ifs"
  AC_MSG_CHECKING([for $vala_bindings vala bindings])
  _VALA_CHECK_COMPILE_WITH_ARGS([$vala_pkgs],
    [vala_pkg_exists=yes],
    [vala_pkg_exists=no])

AS_IF([test x${vala_pkg_exists} = xno],[
  ifelse([$3], , [AC_MSG_ERROR([]dnl
[Package requirements were not met: $1

$vala_error

Consider adjusting the XDG_DATA_DIRS environment variable if you
installed bindings in a non-standard prefix.
])],
  [AC_MSG_RESULT([no])
$3])],[
  AC_MSG_RESULT([yes])
  ifelse([$2], , :, [$2])[]dnl
])

])# VALA_CHECK_PACKAGES


# Check for Vala bindings for a package, as well as the pkg-config
# CFLAGS and LIBS for the package. The arguments here work the
# same as those for PKG_CHECK_MODULES, which is called internally.
# As a result, the _CFLAGS, _LIBS, and _VALAFLAGS variables will
# all be declared, rather than only _VALAFLAGS.
#
# VALA_CHECK_MODULES(VARIABLE-PREFIX, MODULES, [ACTION-IF-FOUND],
# [ACTION-IF-NOT-FOUND])
# --------------------------------------------------------------
AC_DEFUN([VALA_CHECK_MODULES],
[
		AC_REQUIRE([AM_PROG_VALAC])dnl
		AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
        AC_REQUIRE([_VALA_CHECK_COMPILE_WITH_ARGS])dnl
		AC_ARG_VAR([$1][_VALAFLAGS], [Vala compiler flags for $1])dnl

        VALA_MODULES="`echo '$2' | sed -e 's/ [[=<>]]\+ [[0-9.]]\+//g'`"
        for MODULE in $VALA_MODULES; do
            $1[]_VALAFLAGS="$[]$1[]_VALAFLAGS --pkg $MODULE"
        done

        PKG_CHECK_MODULES([$1], [$2], [$3], [$4])

        pkg_failed=no
		AC_MSG_CHECKING([for $1 vala modules])

        _VALA_CHECK_COMPILE_WITH_ARGS([$1][_VALAFLAGS],
                                      [pkg_failed=yes],
                                      [pkg_failed=no])

		if test $pkg_failed = yes; then
		   AC_MSG_RESULT([no])
		   m4_default([$4], [AC_MSG_ERROR(
		   					[Package requiresments ($2) were not met.])dnl
		   ])
		else
			AC_MSG_RESULT([yes])
			m4_default([$3], [:])
		fi[]dnl
])

# Check whether the Vala API Generator exists in `PATH'. If it is found,
# the variable VAPIGEN is set. Optionally a minimum release number of the
# generator can be requested.
#
# VALA_PROG_VAPIGEN([MINIMUM-VERSION])
# ------------------------------------
AC_DEFUN([VALA_PROG_VAPIGEN],
[AC_PATH_PROG([VAPIGEN], [vapigen], [])
  AS_IF([test -z "$VAPIGEN"],
    [AC_MSG_WARN([No Vala API Generator found. You will not be able to generate .vapi files.])],
    [AS_IF([test -n "$1"],
        [AC_MSG_CHECKING([$VAPIGEN is at least version $1])
         am__vapigen_version=`$VAPIGEN --version | sed 's/Vala API Generator  *//'`
         AS_VERSION_COMPARE([$1], ["$am__vapigen_version"],
           [AC_MSG_RESULT([yes])],
           [AC_MSG_RESULT([yes])],
           [AC_MSG_RESULT([no])
            AC_MSG_ERROR([Vala API Generator $1 not found.])])])])
])
