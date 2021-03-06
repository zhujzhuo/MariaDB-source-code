#!/bin/sh

# Copyright (c) 2004, 2005 MySQL AB
# Use is subject to license terms
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Library General Public
# License as published by the Free Software Foundation; version 2
# of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Library General Public License for more details.
#
# You should have received a copy of the GNU Library General Public
# License along with this library; if not, write to the Free
# Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA

f=`find result -name 'log.out' | xargs grep "NDBT_ProgramExit: " | grep -c "Failed"`
o=`find result -name 'log.out' | xargs grep "NDBT_ProgramExit: " | grep -c "OK"`

if [ $o -gt 0 -a $f -eq 0 ]
then
    exit 0
fi

exit 1

