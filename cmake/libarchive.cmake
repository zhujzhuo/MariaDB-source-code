# Copyright (C) 2014, SkySQL Ab. All Rights Reserved.
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

MACRO (MYSQL_CHECK_LIBARCHIVE)

CHECK_INCLUDE_FILES(archive.h HAVE_LIBRARY_ARCHIVE_H)

SET(LIBRARY_ARCHIVE_PATH /usr/lib /usr/local/lib /opt/local/lib)
FIND_LIBRARY(HAVE_LIBRARY_ARCHIVE_LIB archive PATHS ${LIBRARY_ARCHIVE_PATH})

IF (HAVE_LIBRARY_ARCHIVE_LIB AND HAVE_LIBRARY_ARCHIVE_H)
  ADD_DEFINITIONS(-DHAVE_LIBRARY_ARCHIVE=1)
ENDIF()
ENDMACRO()
