public protocol DataStore {
    init(path: String)
    func create<T: Storable>(_ item: T) throws
    func create<T: Storable>(_ items: [T]) throws
    func readItem<T: Storable>() throws -> T
    func readItems<T: Storable>() throws -> [T]
    func delete<T: Storable>(_ item: T) throws
    func delete<T: Storable>(_ items: [T]) throws
}

public protocol Storable: Codable, Identifiable { }

public enum DataStoreError: Error {
    case malformedData
}
