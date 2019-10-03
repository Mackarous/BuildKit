import BuildKit
import RxSwift

public final class RxSessionManager: ReactiveCompatible {
    fileprivate let sessionManager: SessionManager
    fileprivate init(_ sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
}

public extension SessionManager {
    var rx: Reactive<RxSessionManager> {
        return RxSessionManager(self).rx
    }
}

public extension Reactive where Base: RxSessionManager {
    func authorizeSession(with network: Network, idToken: String, completion: @escaping (Result<Session>) -> Void) {
        
    }
}
