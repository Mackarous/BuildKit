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
    
    /// Creates an anonymous cancellable that executes the block when cancelled
    ///
    /// - Parameter cancel: The closure called to perform any cancellation tasks
    /// - Returns: Cancellable
    public static func create(with cancel: @escaping () -> ()) -> Cancellable {
        return AnonymousCancellable(cancelAction: cancel)
    }
}

fileprivate struct NopCancellable: Cancellable {
    fileprivate static let noOp: Cancellable = NopCancellable()
    func cancel() { }
}

fileprivate final class AnonymousCancellable: Cancellable {
    public typealias CancelAction = () -> Void
    
    private var _isCancelled: Int32 = 0
    private var _cancelAction: CancelAction?
    
    fileprivate init(cancelAction: @escaping CancelAction) {
        _cancelAction = cancelAction
    }
    
    fileprivate func cancel() {
        if OSAtomicCompareAndSwap32Barrier(0, 1, &_isCancelled) {
            assert(_isCancelled == 1)
            
            if let action = _cancelAction {
                _cancelAction = nil
                action()
            }
        }
    }
}
