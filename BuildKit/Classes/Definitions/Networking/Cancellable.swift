public protocol Cancellable {
    func cancel()
}

public struct Cancellables {
    /// Creates a cancellable that does nothing. A No Operation cancellable
    ///
    /// - Returns: Cancellable that does nothing
    public static func create() -> Cancellable {
        return NopCancellable.noOp
    }
    
    private init() { }
}

fileprivate struct NopCancellable: Cancellable {
    fileprivate static let noOp: Cancellable = NopCancellable()
    
    func cancel() { }
}
