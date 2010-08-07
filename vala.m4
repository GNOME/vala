dnl vala.m4
dnl
dnl Copyright 2010 Marc-Andre Lureau
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
