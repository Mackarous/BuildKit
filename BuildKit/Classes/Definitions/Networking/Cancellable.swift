public protocol Cancellable {
    func cancel()
}

public enum Cancellables {
    /// Creates a cancellable that does nothing. A No Operation cancellable
    ///
    /// - Returns: Cancellable that does nothing
    public static func create() -> Cancellable {
        return NopCancellable.noOp
    }
}

fileprivate struct NopCancellable: Cancellable {
    fileprivate static let noOp: Cancellable = NopCancellable()
    
    func cancel() { }
}
