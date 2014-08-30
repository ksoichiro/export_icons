export_icons
============

## 概要

`export_icons`は、[Inkscape](http://inkscape.org/)を使った
モバイルアプリケーション向けのアイコン生成ツールです。

以下のように実行すると

    ./export_icons -i Icons.svg -o output

次のように様々なサイズのアイコンが一括生成できます。

    output/Android/drawable-mdpi/ic_launcher.png
    output/Android/drawable-hdpi/ic_launcher.png
    output/Android/drawable-xhdpi/ic_launcher.png
    :
    output/iOS/Icons.png
    output/iOS/Icons@2x.png
    :

## 要件

* Mac OS X 10.8 or later
* Inkscape 0.48.2 or later
* XQuartz 2.7.4 or later
* あなたの素晴らしいアイコンSVGファイル :)

## サポートするファイル

### 入力ファイル

Inkscapeで作られたSVGファイル(*.svg)。  
Pageのサイズは 1024x1024px で作成しておくことを推奨します。

### 出力ファイル

#### Android用ファイル

以下のファイルが生成されます。

* `drawable-ldpi/ic_launcher.png` (36x36px)
* `drawable-mdpi/ic_launcher.png` (48x48px)
* `drawable-hdpi/ic_launcher.png` (72x72px)
* `drawable-xdpi/ic_launcher.png` (96x96px)
* `drawable-xxdpi/ic_launcher.png` (144x144px)
* `drawable-xxxdpi/ic_launcher.png` (192x192px)
* `ic_launcher-web.png` (512x512px)

#### iOS用ファイル

以下のファイルが生成されます。

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

## インストール

以下のいずれの場合でも、パスの通った位置にインストールした場合は実行時に`./`をつける必要はありません。

### Homebrew

```sh
$ brew tap ksoichiro/export_icons
$ brew install export_icons
```

### マニュアルインストール

`export_icons`を`/usr/local/bin`のようなパスの通ったディレクトリに置いてください。  
あるいは、次のようにシンボリックリンクを作ります。

    ln -s /path/to/this/dir/export_icons /usr/local/bin/export_icons

## 利用方法

    ./export_icons -i INPUT_FILE -o OUTPUT_DIR [-f] [-t OS_TYPE] [-b BASE_NAME] [-s BASE_SIZE] [-v]

`-i INPUT_FILE`

入力するInkscapeのファイルを指定します。  
必須です。

`-o OUTPUT_DIR`

生成するアイコンを出力するディレクトリを指定します。  
必須です。  
このディレクトリがない場合、自動生成されます。

`-f`

オプションです。  
指定された場合、出力ディレクトリ(`OUTPUT_DIR/Android`, `OUTPUT_DIR/iOS`)が存在していても上書きします。  
指定されていない場合は、出力ディレクトリがあるとスキップします。

`-t OS_TYPE`

対象のモバイルOSを指定します。  
オプションです。  
有効な値は `Android`、`iOS`、`All`です。  
デフォルト値は`All`です。

`-b BASE_NAME`

Androidでのみ有効なオプションです。
指定された場合、出力するファイルのベースになる名前がこの値に変わります。

    export_icons -i ic_my_icon -o out -t Android -b ic_my_icon

結果:

    out/Android/res/drawable-ldpi/ic_my_icon.png
    out/Android/res/drawable-mdpi/ic_my_icon.png
    out/Android/res/drawable-hdpi/ic_my_icon.png
    out/Android/res/drawable-xhdpi/ic_my_icon.png
    out/Android/res/drawable-xxhdpi/ic_my_icon.png

`-s BASE_SIZE`

Androidでのみ有効なオプションです。
指定された場合、`mdpi`のピクセルが変わります。

    export_icons -i ic_my_icon -o out -t Android -b ic_my_icon -s 32

結果:

    out/Android/res/drawable-ldpi/ic_my_icon.png -> 24px
    out/Android/res/drawable-mdpi/ic_my_icon.png -> 32px
    out/Android/res/drawable-hdpi/ic_my_icon.png -> 48px
    out/Android/res/drawable-xhdpi/ic_my_icon.png -> 64px
    out/Android/res/drawable-xxhdpi/ic_my_icon.png -> 96px

`-v`

詳細出力を有効にします。

## ライセンス

Copyright © 2013 Soichiro Kashima.

MITライセンスでライセンスされています。  
詳しくは同梱のLICENSEファイルをご覧ください。
