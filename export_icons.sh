#!/bin/bash

################################################################################
#
# export_icons - Inkscape Icon Export Script for Mobile Apps
#
# The MIT License (MIT)
#
# Copyright (c) 2013 Soichiro Kashima
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
################################################################################

VERSION=1.2
INKSCAPE=/Applications/Inkscape.app/Contents/Resources/bin/inkscape
OS_TYPE_ANDROID=Android
OS_TYPE_IOS=iOS
OS_TYPE_ALL=All
ICON_BASE_NAME_ANDROID=ic_launcher
ICON_BASE_NAME_IOS=Icon

function help() {
  echo "export_icons - Inkscape Icon Export Script for Mobile Apps"
  echo "Version ${VERSION}"
  echo "Copyright (c) 2013 Soichiro Kashima."
  echo ""
  echo "Usage: $0 -i INPUT_FILE -o OUTPUT_DIR [-f] [-t OS_TYPE] [-b BASE_NAME] [-s BASE_SIZE] [-v]"
  echo "  -i INPUT_FILE"
  echo "    Input Inkscape file. Required."
  echo ""
  echo "  -o OUTPUT_DIR"
  echo "    Directory to locate output files. Required."
  echo "    This directory will be automatically created."
  echo ""
  echo "  -f"
  echo "    Optional."
  echo "    If set, overwrite existing output directories"
  echo "    ('OUTPUT_DIR/${OS_TYPE_ANDROID}','OUTPUT_DIR/${OS_TYPE_IOS}')."
  echo "    Otherwise, skip if there are any existing output directories."
  echo ""
  echo "  -t OS_TYPE"
  echo "    Specifies target mobile OS. Optional."
  echo "    Valid values: ${OS_TYPE_ANDROID} | ${OS_TYPE_IOS} | ${OS_TYPE_ALL}"
  echo "    Optional. Default is '${OS_TYPE_ALL}'."
  echo ""
  echo "  -b BASE_NAME"
  echo "    Base name of the output files."
  echo "    Don't include extension."
  echo "    Optional."
  echo ""
  echo "  -s BASE_SIZE"
  echo "    Base size in pixel. Android only, and it is used for mdpi."
  echo "    hdpi and upper size is automatically calculated."
  echo "    Optional."
  echo ""
  echo "  -v"
  echo "    Enable verbose output."
  echo ""
}

function log() {
  if [ -n "${verbose}" ]; then
    echo $1
  fi
}

function export_png() {
  local input_file=$1
  local output_file=$2
  local size=$3
  local output_export_dir=`dirname ${output_file}`
  if [ ! -d "${output_export_dir}" ]; then
    mkdir -p "${output_export_dir}"
  fi
  log "Exporting input:${input_file} output:${output_file} size:${size}"
  ${INKSCAPE} -z -C --file="${input_file}" --export-png="${output_file}" -w ${size} -h ${size} > /dev/null 2>&1
}

# Check inkscape command line binary
if [ ! -f "${INKSCAPE}" ]; then
  echo "Inkscape not found."
  exit 1
fi

while getopts b:i:o:fs:t:v flag
do
  case ${flag} in
    b)
      base_name=${OPTARG};;
    i)
      input_file=${OPTARG};;
    f)
      force_overwrite=1;;
    o)
      output_dir=${OPTARG};;
    s)
      base_size=${OPTARG};;
    t)
      os_type=${OPTARG};;
    v)
      verbose=1;;
  esac
done

# Check arguments
if [ -z "${input_file}" -o -z "${output_dir}" ]; then
  help
  exit 1
fi
if [ ! -f "${input_file}" ]; then
  echo "Input file not found: ${input_file}"
  exit 1
fi
input_basename=${input_file##*/}
extension=${input_basename##*.}
if [ "x${extension}" != "xsvg" ]; then
  echo "WARNING: Extension ${extension} is not tested."
fi

if [ -z ${os_type} ]; then
  os_type=${OS_TYPE_ALL}
fi
if [ "${os_type}" != "${OS_TYPE_ANDROID}" -a "${os_type}" != "${OS_TYPE_IOS}" -a "${os_type}" != "${OS_TYPE_ALL}" ]; then
  echo "WARNING: OS_TYPE ${os_type} is not valid. Use '${OS_TYPE_ALL}'."
  os_type=${OS_TYPE_ALL}
fi

# Create output directories
if [ ! -d "${output_dir}" ]; then
  mkdir -p "${output_dir}"
fi

log "Using inkscape binary: ${INKSCAPE}"

if [ "${os_type}" = "${OS_TYPE_ANDROID}" -o "${os_type}" = "${OS_TYPE_ALL}" ]; then
  execute_android=1
  if [ -z "${force_overwrite}" ]; then
    if [ -e "${output_dir}/${OS_TYPE_ANDROID}" ]; then
      echo "${output_dir}/${OS_TYPE_ANDROID} is already exists."
      execute_android=0
    fi
  fi
  if [ ${execute_android} -eq 1 ]; then
    if [ ! -d "${output_dir}/${OS_TYPE_ANDROID}" ]; then
      mkdir -p "${output_dir}/${OS_TYPE_ANDROID}"
    fi

    # for Android
    if [ -z "${base_name}" ]; then
      base_name=${ICON_BASE_NAME_ANDROID}
    fi
    log "base name: ${base_name}"
    size_ldpi=36
    size_mdpi=48
    size_hdpi=72
    size_xhdpi=96
    size_xxhdpi=144
    if [ ! -z "${base_size}" ]; then
      size_mdpi=${base_size}
      size_hdpi=`echo "${size_mdpi}*1.5" | bc`
      size_xhdpi=`echo "${size_mdpi}*2" | bc`
      size_xxhdpi=`echo "${size_hdpi}*2" | bc`
      size_ldpi=`echo "${size_hdpi}/2" | bc`
      log "ldpi: ${size_ldpi}"
      log "mdpi: ${size_mdpi}"
      log "hdpi: ${size_hdpi}"
      log "xhdpi: ${size_xhdpi}"
      log "xxhdpi: ${size_xxhdpi}"
    fi
    export_png ${input_file} ${output_dir}/${OS_TYPE_ANDROID}/res/drawable-ldpi/${base_name}.png ${size_ldpi}
    export_png ${input_file} ${output_dir}/${OS_TYPE_ANDROID}/res/drawable-mdpi/${base_name}.png ${size_mdpi}
    export_png ${input_file} ${output_dir}/${OS_TYPE_ANDROID}/res/drawable-hdpi/${base_name}.png ${size_hdpi}
    export_png ${input_file} ${output_dir}/${OS_TYPE_ANDROID}/res/drawable-xhdpi/${base_name}.png ${size_xhdpi}
    export_png ${input_file} ${output_dir}/${OS_TYPE_ANDROID}/res/drawable-xxhdpi/${base_name}.png ${size_xxhdpi}
    if [ "${base_name}" = "${ICON_BASE_NAME_ANDROID}" ]; then
      export_png ${input_file} ${output_dir}/${OS_TYPE_ANDROID}/${ICON_BASE_NAME_ANDROID}-web.png 512
    fi
  fi
fi

if [ "${os_type}" = "${OS_TYPE_IOS}" -o "${os_type}" = "${OS_TYPE_ALL}" ]; then
  execute_ios=1
  if [ -z "${force_overwrite}" ]; then
    if [ -e "${output_dir}/${OS_TYPE_IOS}" ]; then
      echo "${output_dir}/${OS_TYPE_IOS} is already exists."
      exit 1
    fi
  fi

  if [ ${execute_ios} -eq 1 ]; then
    if [ ! -d "${output_dir}/${OS_TYPE_IOS}" ]; then
      mkdir -p "${output_dir}/${OS_TYPE_IOS}"
    fi

    # for iPhone
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}.png 57
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}@2x.png 114
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-Small.png 29
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-Small@2x.png 58
    # for iPad
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-72.png 72
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-72@2x.png 144
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-Small-50.png 50
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-Small-50@2x.png 100
    # for iOS7
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-40.png 40
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-40@2x.png 80
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-60@2x.png 120
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-76.png 76
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-76@2x.png 152
    # for App Store
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/iTunesArtwork.png 512
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/iTunesArtwork@2x.png 1024
  fi
fi

exit 0
