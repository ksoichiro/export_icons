export_icons
============

## 概要

`export_icons`は、[Inkscape](http://inkscape.org/)を使った
モバイルアプリケーション向けのアイコン生成ツールです。

以下のように実行すると

    export_icons -i Icons.svg -o output

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

    export_icons -i INPUT_FILE -o OUTPUT_DIR [-f] [-t OS_TYPE] [-b BASE_NAME] [-s BASE_SIZE] [-v]

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

### Dockerでの使用方法

`export_icons`のプログラムと`icon.svg`がカレントディレクトリにある場合は、
以下のコマンドで`out`ディレクトリにアイコンが生成されます。

    docker run -t -i -v `pwd`:/workspace -w /workspace ksoichiro/inkscape ./export_icons -i icon.svg -o out -f -v -p /usr/bin/inkscape

## ライセンス

Copyright © 2013 Soichiro Kashima.

MITライセンスでライセンスされています。  
詳しくは同梱のLICENSEファイルをご覧ください。
