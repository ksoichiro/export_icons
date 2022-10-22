export_icons
============

[Japanese](README.ja.md)

## Introduction

`export_icons` is an icon export tool using [Inkscape](http://inkscape.org/)
for mobile applications(Android/iOS) and macOS.

Execute

    export_icons -i Icons.svg -o output

and the several sizes of icon are created like following:

    output/Android/drawable-mdpi/ic_launcher.png
    output/Android/drawable-hdpi/ic_launcher.png
    output/Android/drawable-xhdpi/ic_launcher.png
    :
    output/iOS/Icons.png
    output/iOS/Icons@2x.png
    :

## Requirements

* Mac OS X 10.8 or later
* Inkscape 0.48.2 or later
* XQuartz 2.7.4 or later
* Your excellent icon svg files :)

You can also use this tool from Docker.

## Supported files

### Input

SVG file created by Inkscape(*.svg).  
Recommended page size is 1024x1024px.

### Output

#### for Android

Following files will be generated.

* `drawable-ldpi/ic_launcher.png` (36x36px)
* `drawable-mdpi/ic_launcher.png` (48x48px)
* `drawable-hdpi/ic_launcher.png` (72x72px)
* `drawable-xdpi/ic_launcher.png` (96x96px)
* `drawable-xxdpi/ic_launcher.png` (144x144px)
* `drawable-xxxdpi/ic_launcher.png` (192x192px)
* `ic_launcher-web.png` (512x512px)

#### for iOS

Following files will be generated.

* `01a-iPhone-Notification-20@2x.png` (40x40)
* `01b-iPhone-Notification-20@3x.png` (60x60)
* `02a-iPhone-Spotlight-Settings-29.png` (29x29)
* `02b-iPhone-Spotlight-Settings-29@2x.png` (58x58)
* `02c-iPhone-Spotlight-Settings-29@3x.png` (87x87)
* `03a-iPhone-Spotlight-40@2x.png` (80x80)
* `03b-iPhone-Spotlight-40@3x.png` (120x120)
* `04a-iPhone-App-57.png` (57x57)
* `04b-iPhone-App-57@2x.png` (114x114)
* `05a-iPhone-App-60@2x.png` (120x120)
* `05b-iPhone-App-60@3x.png` (180x180)
* `06a-iPad-Notifications-20.png` (20x20)
* `06b-iPad-Notifications-20@2x.png` (40x40)
* `07a-iPad-Settings-29.png` (29x29)
* `07b-iPad-Settings-29@2x.png` (58x58)
* `08a-iPad-Spotlight-40.png` (40x40)
* `08b-iPad-Spotlight-40@2x.png` (80x80)
* `09a-iPad-Spotlight-50.png` (50x50)
* `09b-iPad-Spotlight-50@2x.png` (100x100)
* `10a-iPad-App-72.png` (72x72)
* `10b-iPad-App-72@2x.png` (144x144)
* `11a-iPad-App-76.png` (76x76)
* `11b-iPad-App-76@2x.png` (152x152)
* `12a-iPad-Pro-App-83_5@2x.png` (167x167)
* `13a-iOS-Marketing-1024.png` (1024x1024)

#### for macOS

Following files will be generated.

* `iconbuilder.icns` (16x16, 32x32, 128x128, 256x256, 512x512, @1x and @2x)

## Install

You don't have to add `./` in front of the `export_icons` command when you install it with following methods.

### Homebrew

```sh
$ brew tap ksoichiro/export_icons
$ brew install export_icons
```

### Maunal

Just put the `export_icons` file to the directory like `/usr/local/bin`.  
Or create symbolic link like this:

    ln -s /path/to/this/dir/export_icons /usr/local/bin/export_icons

## Usage

    export_icons -i INPUT_FILE -o OUTPUT_DIR [-f] [-t OS_TYPE] [-b BASE_NAME] [-s BASE_SIZE] [-v] [-p PATH_TO_INKSCAPE]

`-i INPUT_FILE`

Input Inkscape file.  
Required.

`-o OUTPUT_DIR`

Directory to locate output files.  
Required.  
This directory will be automatically created.

`-f`

Optional.   
If set, overwrite existing output directories(`OUTPUT_DIR/Android`, `OUTPUT_DIR/iOS`, `OUTPUT_DIR/macOS`).  
Otherwise, skip if there are any existing output directories.

`-t OS_TYPE`

Specifies target mobile OS. Optional.  
Valid values are `Android`, `iOS`, `macOS` and `All`.  
Default is `All`.

`-b BASE_NAME`

This is only available for Android.
If set, change the base name of the output files.

    export_icons -i ic_my_icon -o out -t Android -b ic_my_icon

Result:

    out/Android/res/drawable-ldpi/ic_my_icon.png
    out/Android/res/drawable-mdpi/ic_my_icon.png
    out/Android/res/drawable-hdpi/ic_my_icon.png
    out/Android/res/drawable-xhdpi/ic_my_icon.png
    out/Android/res/drawable-xxhdpi/ic_my_icon.png

`-s BASE_SIZE`

This is only available for Android.
If set, change the `mdpi` pixel size.

    export_icons -i ic_my_icon -o out -t Android -b ic_my_icon -s 32

Result:

    out/Android/res/drawable-ldpi/ic_my_icon.png -> 24px
    out/Android/res/drawable-mdpi/ic_my_icon.png -> 32px
    out/Android/res/drawable-hdpi/ic_my_icon.png -> 48px
    out/Android/res/drawable-xhdpi/ic_my_icon.png -> 64px
    out/Android/res/drawable-xxhdpi/ic_my_icon.png -> 96px

`-v`

Enable verbose output.

### Usage for Docker

If you have `export_icons` and `icon.svg` in current directory,
then this will generate icons to `out` directory:

    docker run -t -i -v `pwd`:/workspace -w /workspace ksoichiro/inkscape ./export_icons -i icon.svg -o out -f -v -p /usr/bin/inkscape

## License

Copyright © 2013 Soichiro Kashima.

Licensed under MIT License.  
See the bundled LICENSE file for details.
