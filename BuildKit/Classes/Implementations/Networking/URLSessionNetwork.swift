import Foundation

public struct URLSessionNetwork: Network {
    public enum Error: LocalizedError {
        case unknown
        public var errorDescription: String? {
            switch self {
            case .unknown: return "An unknown error has occured"
            }
        }
    }
    
    public init() { }
    
    public func perform<T>(operation: T, complete: @escaping (Result<T.Response>) -> Void) -> Cancellable where T : APIOperation {
        do {
            let request = try operation.createRequest()
            return URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        complete(.success(try operation.decode(data: data)))
                    } catch {
                        complete(.error(error))
                    }
                } else if let error = error {
                    complete(.error(error))
                } else {
                    complete(.error(Error.unknown))
                }
            }
        } catch {
            complete(.error(error))
        }
        return Cancellables.create()
    }
}

extension URLSessionTask: Cancellable { }
