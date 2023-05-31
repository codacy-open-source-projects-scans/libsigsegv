# bold.m4 serial 2 (libsigsegv-2.2)
dnl Copyright (C) 1999-2002 Ralf S. Engelschall <rse@engelschall.com>
dnl Copyright (C) 2002, 2018 Bruno Haible <bruno@clisp.org>
dnl This file is free software, distributed under the terms of the GNU
dnl General Public License.  As a special exception to the GNU General
dnl Public License, this file may be distributed as part of a program
dnl that contains a configuration script generated by Autoconf, under
dnl the same distribution terms as the rest of that program.

# Determine the escape sequences for switching bold output on and off.
AC_DEFUN([RSE_BOLD],
[
  dnl Not pretty.
  dnl AC_REQUIRE([AC_PROG_AWK])

  case $TERM in
    # for the most important terminal types we directly know the sequences
    xterm*|vt220*|vt100*)
      term_bold=`${AWK:-awk} 'BEGIN { printf("%c%c%c%c", 27, 91, 49, 109); }' </dev/null 2>/dev/null`
      term_norm=`${AWK:-awk} 'BEGIN { printf("%c%c%c", 27, 91, 109); }' </dev/null 2>/dev/null`
      ;;
    # for all others, we try to use a possibly existing `tput' or `tcout' utility
    *)
      paths=`echo "$PATH" | sed -e 's/:/ /g'`
      for tool in tput tcout; do
        for dir in $paths; do
          if test -r "$dir/$tool"; then
            for seq in bold md smso; do # 'smso' is last
              bold="`$dir/$tool $seq 2>/dev/null`"
              if test -n "$bold"; then
                term_bold="$bold"
                break
              fi
            done
            if test -n "$term_bold"; then
              for seq in sgr0 me rmso reset; do # 'reset' is last
                norm="`$dir/$tool $seq 2>/dev/null`"
                if test -n "$norm"; then
                  term_norm="$norm"
                  break
                fi
              done
            fi
            break
          fi
        done
        if test -n "$term_bold" && test -n "$term_norm"; then
          break
        fi
      done
      ;;
  esac
  echo "$term_bold" | tr -d '\n' > termbold
  echo "$term_norm" | tr -d '\n' > termnorm
])
