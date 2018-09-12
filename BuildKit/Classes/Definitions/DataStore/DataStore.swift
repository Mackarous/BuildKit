public protocol DataStore {
    init(path: String)
    func upsert<T: Storable>(_ item: T) throws
    func remove<T: Storable>(_ item: T) throws
}

public protocol Storable: Codable, Identifiable { }

public enum DataStoreError: Error {
    case malformedData
}
