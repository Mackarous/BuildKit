import BuildKit
import RxSwift

public final class RxDataDetector: ReactiveCompatible {
    fileprivate let dataDetector: DataDetector
    fileprivate init(_ dataDetector: DataDetector) {
        self.dataDetector = dataDetector
    }
}

public extension DataDetector {
    public var rx: Reactive<RxDataDetector> {
        return RxDataDetector(self).rx
    }
}

public extension Reactive where Base: RxDataDetector {
    func convert(string: String, into attributedString: NSAttributedString) -> Single<DataDetector.Info> {
        return .create { observer in
            self.base.dataDetector.convert(string: string, into: attributedString) { result in
                switch result {
                case .success(let info):
                    observer(.success(info))
                case .error(let error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
