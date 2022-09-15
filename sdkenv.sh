#!/bin/bash

OWRT="$(realpath $(dirname ${BASH_SOURCE}))"
echo "* OpenWRT...: ${OWRT}"

ARCH="$(cat ${OWRT}/.config | sed -n 's/^CONFIG_ARCH="\(.*\)"$/\1/p')"
echo "* ARCH......: ${ARCH}"
export HOST="${ARCH}-openwrt-linux"

CPU_TYPE="$(cat ${OWRT}/.config | sed -n 's/^CONFIG_CPU_TYPE="\(.*\)"$/\1/p')"
echo "* CPU TYPE..: ${CPU_TYPE}"

TARGET_BOARD="$(cat ${OWRT}/.config | sed -n 's/^CONFIG_TARGET_BOARD="\(.*\)"$/\1/p')"
echo "* TARGET....: ${TARGET_BOARD}"

GCC_VER="$(cat ${OWRT}/.config | sed -n 's/CONFIG_GCC_VERSION="\(.*\)"$/\1/p')"
echo "* GCC Ver...: ${GCC_VER}"

LIBC="$(cat ${OWRT}/.config | sed -n 's/CONFIG_LIBC="\(.*\)"$/\1/p')"
echo "* libc......: ${LIBC}"

# example: toolchain-arm_cortex-a9+vfpv3_gcc-7.4.0_musl_eabi
TOOLCHAIN_DIR="$(realpath ${OWRT}/staging_dir/toolchain-${ARCH}_${CPU_TYPE}_gcc-${GCC_VER}_${LIBC}_*)"
echo "* Toolchain.: ${TOOLCHAIN_DIR}"

export PATH="${TOOLCHAIN_DIR}/bin:${OWRT}/staging_dir/host/bin:${OWRT}/staging_dir/host/usr/bin:${OWRT}/staging_dir/hostpkg/bin:${OWRT}/staging_dir/hostpkg/usr/bin:${PATH}"
export STAGING_DIR="${OWRT}/staging_dir"
TARGET_DIR="$(realpath ${STAGING_DIR}/target-${ARCH}_${CPU_TYPE}*)"
echo "* Target dir: ${TARGET_DIR}"
export CC="${HOST}-gcc"
export CXX="${HOST}-g++"
export CFLAGS="-I${TARGET_DIR}/usr/include"
export CXXFLAGS="${CFLAGS}"
TARGET_DIR_ROOT="$(realpath ${TARGET_DIR}/root-${TARGET_BOARD})"
echo "* Root......: ${TARGET_DIR_ROOT}"
export LDFLAGS="-L${TARGET_DIR}/usr/lib -L${TARGET_DIR_ROOT}/usr/lib"
export PKG_CONFIG="${STAGING_DIR}/host/bin/pkg-config.real"
export PKG_CONFIG_PATH="${TARGET_DIR}/usr/lib/pkgconfig"
export PKG_CONFIG_LIBDIR="${TARGET_DIR}/usr/lib/pkgconfig"

# CMake variables
export CMAKE_C_COMPILER_AR="${HOST}-ar"
export CMAKE_C_COMPILER_RANLIB="${HOST}-ranlib"
export CMAKE_LINKER="${HOST}-ld"
export CMAKE_NM="${HOST}-nm"
export CMAKE_OBJCOPY="${HOST}-objcopy"
export CMAKE_OBJDUMP="${HOST}-objdump"
export CMAKE_RANLIB="${HOST}-ranlib"
export CMAKE_STRIP="${HOST}-strip"

export CMAKE_FIND_ROOT_PATH="${OWRT} ${TARGET_DIR} ${TOOLCHAIN_DIR}"
# search for programs in the build host directories
export CMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER
# for libraries and headers in the target directories
export CMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY
export CMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY

# set some optional CGO vars for xcompile
export CGO_ENABLED=1
export GO_EXTLINK_ENABLED=1
export GOARCH="${ARCH}"
if cat "${OWRT}/.config" | grep -qoE 'CONFIG_arm_v7'; then
    echo "* GOARM=7"
    export GOARM=7
fi
if cat "${OWRT}/.config" | grep -qoE 'CONFIG_arm_v6'; then
    echo "* GOARM=6"
    export GOARM=6
fi

check_dirs[0]="${TOOLCHAIN_DIR}"
check_dirs[1]="${TARGET_DIR}"
check_dirs[2]="${TARGET_DIR_ROOT}"
for dir in ${check_dirs[*]}; do
    test -d "${dir}" || echo "* NOT EXIST: ${dir}" >&2
done
