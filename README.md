AMAppExportToIPA-Xcode-Plugin
==================

<p align="left">

<!-- <a href="https://travis-ci.org/MellongLau/AMAppExportToIPA-Xcode-Plugin"><img src="https://travis-ci.org/MellongLau/AMAppExportToIPA-Xcode-Plugin.svg" alt="Build Status" /></a> -->
<img src="https://img.shields.io/badge/platform-Xcode%206%2B-blue.svg?style=flat" alt="Platform: Xcode 6+"/>
    <img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat" alt="License: MIT" />

</p>

AMAppExportToIPA-Xcode-Plugin is a simple Xcode plugin to export `.app` to `.ipa` file.

## Usage

![screenshot.gif](https://raw.github.com/MellongLau/AMAppExportToIPA-Xcode-Plugin/master/Screenshots/screenshot.gif)

## Install

You can:

Install from github.

* Get the source code from github

    `$ git clone git@github.com:MellongLau/AMAppExportToIPA-Xcode-Plugin.git`
    
* Build the AMAppExportToIPA-Xcode-Plugin target in the Xcode project and the plug-in will automatically be installed in `~/Library/Application Support/Developer/Shared/Xcode/Plug-ins`.
* Relaunch Xcode.

or

Install via [Alcatraz](http://alcatraz.io/)

In any case, relaunch Xcode to load it.


## Support

Developed and tested against Xcode 6+.

For Xcode7.1, you may need to run shell script:
```shell
find ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins -name Info.plist -maxdepth 3 | xargs -I{} defaults write {} DVTPlugInCompatibilityUUIDs -array-add defaults read /Applications/Xcode.app/Contents/Info DVTPlugInCompatibilityUUID

sudo xcode-select --reset

defaults delete com.apple.dt.Xcode DVTPlugInManagerNonApplePlugIns-Xcode-7.1

```

Or download and execute this [script](https://github.com/cielpy/RPAXU) to add your current Xcode DVTPlugInCompatibilityUUID to all the Xcode plugins.

## More
Learn more? Follow my `WeChat` public account `mellong`:

![WeChat QRcode](http://www.devlong.com/blogImages/qrcode_for_mellong.jpg)

## License

MIT License

Copyright (c) 2016 Mellong Lau

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
