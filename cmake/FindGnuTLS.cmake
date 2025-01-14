#
# This file is open source software, licensed to you under the terms
# of the Apache License, Version 2.0 (the "License").  See the NOTICE file
# distributed with this work for additional information regarding copyright
# ownership.  You may not use this file except in compliance with the License.
#
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

#
# Copyright (C) 2018 Scylladb, Ltd.
#

find_package (PkgConfig REQUIRED)

pkg_search_module (GnuTLS IMPORTED_TARGET GLOBAL gnutls)

if (GnuTLS_FOUND)
  add_library(GnuTLS::gnutls INTERFACE IMPORTED)
  target_link_libraries(GnuTLS::gnutls INTERFACE PkgConfig::GnuTLS)
  set(GnuTLS_LIBRARY ${GnuTLS_LIBRARIES})
  set(GnuTLS_INCLUDE_DIR ${GnuTLS_INCLUDE_DIRS})
endif ()

if (NOT GnuTLS_LIBRARY)
  find_library (GnuTLS_LIBRARY
    NAMES gnutls)
endif ()

if (NOT GnuTLS_INCLUDE_DIR)
  find_path (GnuTLS_INCLUDE_DIR
    NAMES gnutls/gnutls.h)
endif ()

mark_as_advanced (
  GnuTLS_LIBRARY
  GnuTLS_INCLUDE_DIR)

include (FindPackageHandleStandardArgs)

find_package_handle_standard_args (GnuTLS
  REQUIRED_VARS
    GnuTLS_LIBRARY
    GnuTLS_INCLUDE_DIR
  VERSION_VAR GnuTLS_VERSION)

if (GnuTLS_FOUND)
  set (GnuTLS_LIBRARIES ${GnuTLS_LIBRARY})
  set (GnuTLS_INCLUDE_DIRS ${GnuTLS_INCLUDE_DIR})
  if (NOT (TARGET GnuTLS::gnutls))
    add_library (GnuTLS::gnutls UNKNOWN IMPORTED)

    set_target_properties (GnuTLS::gnutls
      PROPERTIES
        IMPORTED_LOCATION ${GnuTLS_LIBRARY}
        INTERFACE_INCLUDE_DIRECTORIES ${GnuTLS_INCLUDE_DIRS})
  endif ()
endif ()
