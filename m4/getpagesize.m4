# getpagesize.m4
# serial 3 (libsigsegv-2.9)
dnl Copyright (C) 2002-2024 Bruno Haible <bruno@clisp.org>
dnl This file is free software, distributed under the terms of the GNU
dnl General Public License.  As a special exception to the GNU General
dnl Public License, this file may be distributed as part of a program
dnl that contains a configuration script generated by Autoconf, under
dnl the same distribution terms as the rest of that program.

# How to determine the memory page size.
AC_DEFUN([SV_GETPAGESIZE],
[
  AC_REQUIRE([AC_PROG_CC])

  AC_CHECK_HEADERS([unistd.h])

  dnl 1) getpagesize().

  AC_CACHE_CHECK([for getpagesize], [sv_cv_func_getpagesize], [
    AC_LINK_IFELSE([
      AC_LANG_PROGRAM([[
#if HAVE_UNISTD_H
#include <sys/types.h>
#include <unistd.h>
#endif
]],
        [[int pgsz = getpagesize();]])],
      [sv_cv_func_getpagesize=yes],
      [sv_cv_func_getpagesize=no])])
  if test $sv_cv_func_getpagesize = yes; then
    AC_DEFINE([HAVE_GETPAGESIZE], [1],
      [Define if getpagesize() is available as a function or a macro.])
  fi

  dnl 2) sysconf(_SC_PAGESIZE).

  AC_CACHE_CHECK([for sysconf(_SC_PAGESIZE)], [sv_cv_func_sysconf_pagesize], [
    AC_LINK_IFELSE([
      AC_LANG_PROGRAM([[
#if HAVE_UNISTD_H
#include <sys/types.h>
#include <unistd.h>
#endif
]],
        [[int pgsz = sysconf (_SC_PAGESIZE);]])],
      [sv_cv_func_sysconf_pagesize=yes],
      [sv_cv_func_sysconf_pagesize=no])])
  if test $sv_cv_func_sysconf_pagesize = yes; then
    AC_DEFINE([HAVE_SYSCONF_PAGESIZE], [1],
      [Define if sysconf(_SC_PAGESIZE) is available as a function or a macro.])
  fi

  dnl 3) PAGESIZE.

  AC_CACHE_CHECK([for PAGESIZE in limits.h], [sv_cv_macro_pagesize], [
    AC_LINK_IFELSE([
      AC_LANG_PROGRAM([[#include <limits.h>]],
        [[int pgsz = PAGESIZE;]])],
      [sv_cv_macro_pagesize=yes],
      [sv_cv_macro_pagesize=no])])
  if test $sv_cv_macro_pagesize = yes; then
    AC_DEFINE([HAVE_PAGESIZE], [1],
      [Define if PAGESIZE is available as a macro.])
  fi

  dnl 4) On BeOS, you need to include <OS.h> and use B_PAGE_SIZE.
])
