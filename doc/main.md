# Documents

The xmind file is a tree-like structure. The root component is named `Workbook`. You can use this class to create, modify a xmind file.

Then a `Workbook` contains serval sheets which represent mind map panels.

And a `Sheet` contains a root topic mainly, and some infomation of this mind map panel.



#### Workbook

```swift

/// A workbook is as a xmind file.
/// You can open or new a workbook(xmind file).
/// To opera a xmind file, workbook use a temporary storge at temporary path on the disk.
/// The temporary content will be deleted while the workbook object deinited.
/// If open an existing file, first you need call 'loadManifest()' , second call 'loadContent(password: String?)'.
///
public final class Workbook {
}

extension Workbook {

    public var passwordHint: String? { get set }

    /// Load the existing manifest.
    /// Just  only can read passwordHint after called "loadManifest"
    public func loadManifest() throws

    /// Load the existing content.
    /// - Parameter password: Password of the file.
    public func loadContent(password: String? = nil) throws

    /// The all sheets.
    public var allSheets: [Sheet] { get }
    
    /// Add a sheet to the workbook.
    public func add(sheet: Sheet)

    /// Remove a sheet from the workbook.
    public func remove(sheet: Sheet)

    /// Save as a xmind file at the given path.
    /// If a file already exists with this path, This method will throw an error that indicates this csae.
    /// - Parameter path: Path will save to.
    public func save(to path: String, password: String? = nil) throws
}

extension Workbook {

    /// Open a xmind file at the given file path.
    /// It will make a random temporary path by default.
    /// - Parameter filePath: The location of a xmind file which will be opened.
    public static func open(filePath: String) throws -> Workbook

    /// Open a xmind file at the given file path.
    /// - Parameters:
    ///   - filePath: The location of a xmind file which will be opened.
    ///   - temporaryPath: The temporary space that use to cache and opera temporary files.
    public static func open(filePath: String, temporaryPath: String) throws -> Workbook

    /// Create a new xmind file that is empty.
    /// - Parameter temporaryPath: The temporary space that use to cache and opera temporary files.
    public static func new(temporaryPath: String) throws -> Workbook

    /// Create  a new xmind file that is empty.
    /// It will make a random temporary path by default.
    public static func new() throws -> Workbook
}



```

#### Sheet

```swift
/// Sheet represents a mind map panel
/// which contains a root topic.
public class Sheet : Codable {

    /// The unique ID of this sheet.
    public let id: String

    /// The class of this sheet.
    public let `class`: String

    /// Title of this sheet which represents the name of this panel.
    public var title: String

    /// The root topic of this panel.
    /// A sheet only can contains a root topic,
    public let rootTopic: Topic

    /// The topic positioning function.
    public let topicPositioning: String

    /// The relationships of this panel.
    public let relationships: [Relationship]?

    /// Theme of this panel.
    public let theme: Theme

    public init(title: String, rootTopic: Topic)
}
```

#### Topic

```swift
public class Topic : Codable {

    /// The unique ID of this topic.
    public let id: String

    /// The title of this topic.
    public var title: String?

    public init(title: String? = nil)
}


extension Topic {

    /// Add a topic to self.
    /// You cant add an ancestor topic, It do nothing.
    /// If the topic that to be added was alredy contained by self. it will not add twice.
    /// If the topic had a super topic, it will remove from origin super topic,then add to self.
    /// - Parameter topic: The topic to be added.
    public func addSubTopic(_ topic: Topic)

    /// A convenience function for add a topic.
    /// The behave is same as "addSubTopic(_ topic: Topic)".
    /// The returned topic is the new created topic.
    /// - Parameter title: Title of the new topic.
    public func addSubTopic(_ title: String) -> Topic

    /// Remove a sub topic.
    /// - Parameter topic: The sub topic.
    public func removeSubTopic(_ topic: Topic)

    /// If the topic has a super topic, it will remove from the super topic.
    public func removeFromSuperTopic()

    /// Add a marker to the topic, The same class marker can only add once.
    /// - Parameter marker: Marker to be added.
    public func addMarker(_ marker: Marker)

    /// Remove a marker.
    /// - Parameter marker: Marker to be removed.
    public func removeMarker(_ marker: Marker)
}

```

