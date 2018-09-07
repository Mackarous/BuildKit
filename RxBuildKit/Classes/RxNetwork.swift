import BuildKit
import RxSwift

extension Reactive where Base: Network {
    func perform<T: APIOperation>(operation: T) -> Observable<T.Response> {
        return .create { observer in
            let op = self.base.perform(operation: operation) { result in
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
