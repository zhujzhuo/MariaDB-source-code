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


MACRO (MYSQL_CHECK_LIBGCRYPT)

CHECK_INCLUDE_FILES(gcrypt.h HAVE_GCRYPT_H)
CHECK_LIBRARY_EXISTS(gcrypt gcry_check_version "" HAVE_GCRYPT_LIB)
CHECK_INCLUDE_FILES(gpg-error.h HAVE_GPGERROR_H)
CHECK_LIBRARY_EXISTS(gpg-error gpg_error_check_version "" HAVE_GPGERROR_LIB)

IF (HAVE_GCRYPT_H AND HAVE_GCRYPT_LIB)
  ADD_DEFINITIONS(-DHAVE_GCRYPT=1)
  LINK_LIBRARIES(gcrypt)
ENDIF()

IF (HAVE_GPGERROR_H AND HAVE_GPGERROR_LIB)
  ADD_DEFINITIONS(-DHAVE_GPGERROR=1)
  LINK_LIBRARIES(gpg-error)
ENDIF()

ENDMACRO()
