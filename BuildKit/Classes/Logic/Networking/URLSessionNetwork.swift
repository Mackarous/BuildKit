import Foundation
import os

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
            os_log("BuildKit.URLSessionNetwork: Created network request %{public}@", type: .debug, request.debugDescription)
            if operation.requiresAuthorization {
                request.setValue("Bearer \(sessionManager.currentSession.token)", forHTTPHeaderField: "Authorization")
                os_log("BuildKit.URLSessionNetwork: Request requires authorization %{private}@", type: .debug, request.allHTTPHeaderFields.debugDescription)
            }
            os_log("BuildKit.URLSessionNetwork: Performing network request %{public}@", type: .debug, request.description)
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if let data = data {
                    do {
                        os_log("BuildKit.URLSessionNetwork: Request completed successfully... Attempting decode", type: .debug)
                        let result = try operation.decode(data: data)
                        os_log("BuildKit.URLSessionNetwork: Decoding complete %{private}@", type: .debug, String(describing: result))
                        complete(.success(result))
                    } catch {
                        os_log("BuildKit.URLSessionNetwork: Error while decoding data %{public}@", type: .error, error.localizedDescription)
                        complete(.error(error))
                    }
                } else if let error = error {
                    os_log("BuildKit.URLSessionNetwork: Request incomplete: %{public}@", type: .error, error.localizedDescription)
                    complete(.error(error))
                } else {
                    os_log("BuildKit.URLSessionNetwork: Unknown error", type: .error)
                    complete(.error(Error.unknown))
                }
            }
            task.resume()
            return task
        } catch {
            os_log("BuildKit.URLSessionNetwork: Unable to create network request %{public}@", type: .error, error.localizedDescription)
            complete(.error(error))
        }
        return Cancellables.create()
    }
}

extension URLSessionTask: Cancellable { }
