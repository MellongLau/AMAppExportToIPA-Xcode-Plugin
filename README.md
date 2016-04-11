AMAppExportToIPA-Xcode-Plugin
==================

<p align="left">

<a href="https://travis-ci.org/MellongLau/AMAppExportToIPA-Xcode-Plugin"><img src="https://travis-ci.org/MellongLau/AMAppExportToIPA-Xcode-Plugin.svg" alt="Build Status" /></a>
<img src="https://img.shields.io/badge/platform-Xcode%206%2B-blue.svg?style=flat" alt="Platform: Xcode 6+"/>
    <img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat" alt="License: MIT" />

</p>

AMAppExportToIPA is a simple Xcode plugin to export `.app` to `.ipa` file.

**Note:** Please update to v1.1 to in order to avoid conflicts with other Xcode plug-ins.

*AMAppExportToIPA 是一款可以让你在Xcode的project navigator界面中直接右键点击xxx.app -> Export IPA就可以生成对应的IPA文件的Xcode插件。*

**注意:** 请更新到v1.1以避免和其他Xcode插件冲突。

**如果觉得这款插件不错的话请点击右上角的star和推荐给你的朋友，如果想即时了解到我的最新消息，请拉到底部扫描二维码关注我的公众号**

## Usage

![screenshot.gif](https://raw.github.com/MellongLau/AMAppExportToIPA-Xcode-Plugin/master/Screenshots/screenshot.gif)

## Install

You can:

Install from github.

* Get the source code from github

    `$ git clone git@github.com:MellongLau/AMAppExportToIPA-Xcode-Plugin.git`
    
* Build the AMAppExportToIPA target in the Xcode project and the plug-in will automatically be installed in `~/Library/Application Support/Developer/Shared/Xcode/Plug-ins`.
* Relaunch Xcode.

or

Install via [Alcatraz](http://alcatraz.io/)

In any case, relaunch Xcode to load it.


## Support

Developed and tested against Xcode 6+.

After upgrade your Xcode, you may need to run below shell script to add your current Xcode DVTPlugInCompatibilityUUID to all the Xcode plugins:

> curl https://raw.githubusercontent.com/cielpy/RPAXU/master/refreshPluginsAfterXcodeUpgrading.sh | sh


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
