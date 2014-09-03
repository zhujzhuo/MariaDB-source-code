# Copyright (c) 2013 Percona LLC and/or its affiliates.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

INCLUDE(gcrypt)
INCLUDE(libarchive)
INCLUDE(quicklz)

MYSQL_CHECK_LIBARCHIVE()
MYSQL_CHECK_LIBGCRYPT()
MYSQL_CHECK_QUICKLZ()

INCLUDE_DIRECTORIES(
  ${CMAKE_SOURCE_DIR}/include
  ${CMAKE_SOURCE_DIR}/storage/innobase/include
  ${CMAKE_SOURCE_DIR}/sql
  )

########################################################################
# xtrabackup binary
########################################################################
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/xtrabackup_version.h.in
               ${CMAKE_CURRENT_BINARY_DIR}/xtrabackup_version.h )

SET(XTRABACKUP_SOURCES
  xtrabackup.cc
  changed_page_bitmap.cc
  compact.cc
  datasink.c
  ds_buffer.c
  ds_local.c
  ds_stdout.c
  ds_tmpfile.c
  ds_xbstream.c
  fil_cur.cc
  read_filt.cc
  write_filt.cc
  xbstream_write.c)

IF (HAVE_LIBRARY_ARCHIVE_LIB)
SET (XTRABACKUP_SOURCES ${XTRABACKUP_SOURCES} ds_archive.c)
ENDIF()
IF (HAVE_GCRYPT_LIB)
SET (XTRABACKUP_SOURCES ${XTRABACKUP_SOURCES} ds_encrypt.c xbcrypt_common.c xbcrypt_write.c)
ENDIF()
IF (HAVE_QUICKLZ_H)
SET (XTRABACKUP_SOURCES ${XTRABACKUP_SOURCES} ds_compress.c)
ENDIF()

MYSQL_ADD_EXECUTABLE(xtrabackup ${XTRABACKUP_SOURCES})

IF (HAVE_LIBRARY_ARCHIVE_LIB)
SET(LIBRARY_ARCHIVE_LIB ${HAVE_LIBRARY_ARCHIVE_LIB})
TARGET_LINK_LIBRARIES(xtrabackup mysqlserver ${LIBRARY_ARCHIVE_LIB})
ELSE()
TARGET_LINK_LIBRARIES(xtrabackup mysqlserver)
ENDIF()

########################################################################
# xbstream binary
########################################################################

MYSQL_ADD_EXECUTABLE(xbstream
  ds_buffer.c
  ds_local.c
  ds_stdout.c
  datasink.c
  xbstream.c
  xbstream_read.c
  xbstream_write.c
  )

SET_TARGET_PROPERTIES(xbstream
        PROPERTIES LINKER_LANGUAGE CXX
        )

TARGET_LINK_LIBRARIES(xbstream
  mysys
  mysys_ssl
  )

########################################################################
# xbcrypt binary
########################################################################

IF (HAVE_GCRYPT_LIB)
  MYSQL_ADD_EXECUTABLE(xbcrypt
    xbcrypt.c
    xbcrypt_common.c
    xbcrypt_read.c
    xbcrypt_write.c
  )

  SET_TARGET_PROPERTIES(xbcrypt
        PROPERTIES LINKER_LANGUAGE CXX
        )

  TARGET_LINK_LIBRARIES(xbcrypt
    mysys
    mysys_ssl
  )
ENDIF()
