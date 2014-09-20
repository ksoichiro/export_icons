export_icons
============

[Japanese](README.ja.md)

## Introduction

`export_icons` is an icon export tool using [Inkscape](http://inkscape.org/)
for mobile applications(Android/iOS).

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

* `Icon-40.png` (40x40px)
* `Icon-40@2x.png` (80x80px)
* `Icon-72.png` (72x72px)
* `Icon-72@2x.png` (144x144px)
* `Icon-76.png` (76x76px)
* `Icon-76@2x.png` (152x152px)
* `Icon-Small-50.png` (50x50px)
* `Icon-Small-50@2x.png` (100x100px)
* `Icon-Small.png` (29x29px)
* `Icon-Small@2x.png` (58x58px)
* `Icon.png` (57x57px)
* `Icon@2x.png` (114x114px)
* `iTunesArtwork.png` (512x512px)
* `iTunesArtwork@2x.png` (1024x1024px)

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
If set, overwrite existing output directories(`OUTPUT_DIR/Android`, `OUTPUT_DIR/iOS`).  
Otherwise, skip if there are any existing output directories.

`-t OS_TYPE`

Specifies target mobile OS. Optional.  
Valid values are `Android`, `iOS` and `All`.  
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
