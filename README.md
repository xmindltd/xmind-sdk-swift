# XMind SDK in Swift

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)[![Language](https://img.shields.io/badge/language-Swift-orange.svg)]()

This SDK enables you to create and modify xmind(`.xmind`) files, and it's written in swift.

Supported Platforms:

- iOS
- macOS

## Structure of XMind files

XMind file is a zip file which contains several components, including manifest, metadata, sheets and resources

Resources contains all the resources of this xmind file that like images.

Metadata represents the version of xmind file and the creator.

Sheets contains all of the topics that belong to the each sheets(canvas).

Manifest lists primary files that contained in this xmind file.

## Usage

If you create a new xmind file, you can directly operate sheets and topics after initializing a `Workbook` instance that represents a xmind file.

If you open a existing xmind file. You need call `public func loadManifest()` of `Workbook` after initializing a workbook to load some base informations. And now you can access the `passwordHint` to read and write the passwordHint. then, you need call `public func loadContent(password: String? = nil)` to load the metadata and sheets. When it's loaded, you can operate sheets and topics.



### Simple

```swift
import XMindSDK

...
...

let wb = try Workbook.open(filePath: filePath)// This file path which contains a existing xmind file.
try wb.loadManifest()
try wb.loadContent(password: "123456")

let root = wb.allSheets.first!.rootTopic

let sub1 = root.addSubTopic("Sub Topic 1")
let sub2 = root.addSubTopic("Sub Topic 2")
let sub3 = root.addSubTopic("Sub Topic 3")

sub3.addSubTopic("Topic 4")
sub3.addSubTopic("Topic 5")

sub2.addMarker(Marker.Arrow.refresh)
root.addMarker(Marker.Flag.darkBlue)
sub1.addMarker(Marker.Priority.p2)

try wb.save(to: filePath, password: "123456")
```



### installation

- Carthage

  ```
  github ""
  ```

- Swift Package Manager

  ```
  .package(url: "", .upToNextMinor(from: "1.0"))
  ```



## License

This SDK is released under the MIT license. See LICENSE for details.