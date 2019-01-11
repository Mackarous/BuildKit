import Foundation

public struct URLSessionNetwork: Network {
    public enum Error: LocalizedError {
        case unknown, invalidRequest
        public var errorDescription: String? {
            switch self {
            case .unknown: return "An unknown error has occured"
            case .invalidRequest: return "The request type was invalid"
            }
        }
    }

    private let sessionManager: SessionManager

    public init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    public func perform<T>(operation: T, complete: @escaping (Result<T.Response>) -> Void) -> Cancellable where T : NetworkOperation {
        do {
            guard var request = try operation.createRequest() as? URLRequest else { throw Error.invalidRequest }
            if operation.requiresAuthorization {
                request.setValue("Bearer \(sessionManager.currentSession.token)", forHTTPHeaderField: "Authorization")
            }
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
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
            task.resume()
            return task
        } catch {
            complete(.error(error))
        }
        return Cancellables.create()
    }
}

extension URLSessionTask: Cancellable { }
