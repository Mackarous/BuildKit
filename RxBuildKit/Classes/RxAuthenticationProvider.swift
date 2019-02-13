import BuildKit
import RxSwift

public final class RxAuthenticationProvider: ReactiveCompatible {
    fileprivate let authenticationProvider: AuthenticationProvider
    fileprivate init(_ authenticationProvider: AuthenticationProvider) {
        self.authenticationProvider = authenticationProvider
    }
}

public extension AuthenticationProvider {
    public var rx: Reactive<RxAuthenticationProvider> {
        return RxAuthenticationProvider(self).rx
    }
}

public extension Reactive where Base: RxAuthenticationProvider {
    public func authenticate() -> Observable<AuthenticationTokens> {
        return .create { observer in
            self.base.authenticationProvider.authenticate { result in
                switch result {
                case .error(let error):
                    observer.onError(error)
                case .success(let response):
                    observer.onNext(response)
                }
            }
            return Disposables.create()
        }
    }
}
