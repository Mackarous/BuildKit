import Foundation
import os

public final class BinaryDataStore: DataStore {
    private let folderURL: URL
    private let fileManager = FileManager.default
    
    public init(path: String) {
        os_log("BuildKit.BinaryDataStore: Initializing BinaryDataStore with path: %{public}@", type: .debug, path)
        let url = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent(path)
        os_log("BuildKit.BinaryDataStore: Using directory with url: %{public}@", type: .debug, url.absoluteString)
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
        os_log("BuildKit.BinaryDataStore: Successfully opened directory at url: %{public}@", type: .debug, url.absoluteString)
        folderURL = url
    }
    
    public func create<T>(_ item: T) throws where T : Storable {
        try create([item])
    }
    
    public func create<T>(_ items: [T]) throws where T : Storable {
        let path = filePath(describing: T.self)
        os_log("BuildKit.BinaryDataStore: About to create files at path: %{public}@", type: .debug, path.absoluteString)
        let data = try PropertyListEncoder().encode(items)
        os_log("BuildKit.BinaryDataStore: Successfully encoded data for items: %{private}@", type: .debug, items.debugDescription)
        try data.write(to: path, options: [.atomic])
        os_log("BuildKit.BinaryDataStore: Successfully wrote file with encoded data at path: %{public}@", type: .debug, path.absoluteString)
    }
    
    public func readItem<T>() throws -> T where T : Storable {
        return try readItems()[0]
    }
    
    public func readItems<T>() throws -> [T] where T : Storable {
        let path = filePath(describing: T.self)
        os_log("BuildKit.BinaryDataStore: About to read data at path: %{public}@", type: .debug, path.absoluteString)
        let data = try Data(contentsOf: path)
        os_log("BuildKit.BinaryDataStore: Successfully read data at path: %{public}@", type: .debug, path.absoluteString)
        os_log("BuildKit.BinaryDataStore: Attempting to decode data", type: .debug)
        let items = try PropertyListDecoder().decode([T].self, from: data)
        os_log("BuildKit.BinaryDataStore: Successfully decoded data for items: %{private}@", type: .debug, items.debugDescription)
        return items
    }
    
    public func delete<T>(_ item: T) throws where T : Storable {
        try delete([item])
    }
    
    public func delete<T>(_ items: [T]) throws where T : Storable {
        let path = filePath(describing: T.self)
        os_log("BuildKit.BinaryDataStore: About to delete files at path: %{public}@", type: .debug, path.absoluteString)
        try fileManager.removeItem(at: path)
        os_log("BuildKit.BinaryDataStore: Successfully deleted files at path: %{public}@", type: .debug, path.absoluteString)
    }
    
    private func filePath<T>(describing instance: T.Type) -> URL where T : Storable {
        return folderURL
            .appendingPathComponent(String(describing: T.self), isDirectory: false)
            .appendingPathExtension("plist")
    }
}
