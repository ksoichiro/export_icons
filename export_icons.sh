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

VERSION=1.1
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
  echo "Usage: $0 -i INPUT_FILE -o OUTPUT_DIR [-f] [-t OS_TYPE] [-v]"
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

while getopts i:o:ft:v flag
do
  case ${flag} in
    i)
      input_file=${OPTARG};;
    f)
      force_overwrite=1;;
    o)
      output_dir=${OPTARG};;
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
basename=${input_file##*/}
extension=${basename##*.}
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
    export_png ${input_file} ${output_dir}/${OS_TYPE_ANDROID}/res/drawable-ldpi/${ICON_BASE_NAME_ANDROID}.png 36
    export_png ${input_file} ${output_dir}/${OS_TYPE_ANDROID}/res/drawable-mdpi/${ICON_BASE_NAME_ANDROID}.png 48
    export_png ${input_file} ${output_dir}/${OS_TYPE_ANDROID}/res/drawable-hdpi/${ICON_BASE_NAME_ANDROID}.png 72
    export_png ${input_file} ${output_dir}/${OS_TYPE_ANDROID}/res/drawable-xhdpi/${ICON_BASE_NAME_ANDROID}.png 96
    export_png ${input_file} ${output_dir}/${OS_TYPE_ANDROID}/res/drawable-xxhdpi/${ICON_BASE_NAME_ANDROID}.png 144
    export_png ${input_file} ${output_dir}/${OS_TYPE_ANDROID}/${ICON_BASE_NAME_ANDROID}-web.png 512
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
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-76.png 76
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/${ICON_BASE_NAME_IOS}-76@2x.png 152
    # for App Store
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/iTunesArtwork.png 512
    export_png ${input_file} ${output_dir}/${OS_TYPE_IOS}/iTunesArtwork@2x.png 1024
  fi
fi

exit 0
