import BuildKit
import RxSwift

public final class RxNetwork: ReactiveCompatible {
    fileprivate let network: Network
    fileprivate init(_ network: Network) {
        self.network = network
    }
}

public extension Network {
    public var rx: Reactive<RxNetwork> {
        return RxNetwork(self).rx
    }
}

public extension Reactive where Base: RxNetwork {
    public func perform<T: NetworkOperation>(operation: T) -> Observable<T.Response> {
        return .create { observer in
            let op = self.base.network.perform(operation: operation) { result in
                switch result {
                case .error(let error):
                    observer.onError(error)
                case .success(let response):
                    observer.onNext(response)
                }
            }
            return Disposables.create {
                op.cancel()
            }
        }
    }
}
