public protocol Cancellable {
    func cancel()
}

public struct Cancellables {
    public static func create() -> Cancellable {
        return NopCancellable.noOp
    }
    
    private init() { }
}

fileprivate struct NopCancellable: Cancellable {
    fileprivate static let noOp: Cancellable = NopCancellable()
    
    func cancel() { }
}
