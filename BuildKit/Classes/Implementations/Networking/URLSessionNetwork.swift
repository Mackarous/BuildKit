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
            os_log("Created network request %s", type: .debug, request.description)
            if operation.requiresAuthorization {
                request.setValue("Bearer \(sessionManager.currentSession.token)", forHTTPHeaderField: "Authorization")
                os_log("Request requires authorization %s", type: .debug, request.allHTTPHeaderFields?.description ?? "")
            }
            os_log("Performing network request %s", type: .debug, request.description)
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if let data = data {
                    do {
                        os_log("Request completed successfully... Attempting decode", type: .debug)
                        let result = try operation.decode(data: data)
                        os_log("Decoding complete %s", type: .debug, (result as? CustomStringConvertible)?.description ?? "")
                        complete(.success(result))
                    } catch {
                        os_log("Error while decoding data %s", type: .error, error.localizedDescription)
                        complete(.error(error))
                    }
                } else if let error = error {
                    os_log("Request incomplete: %s", type: .error, error.localizedDescription)
                    complete(.error(error))
                } else {
                    os_log("Unknown error", type: .error)
                    complete(.error(Error.unknown))
                }
            }
            task.resume()
            return task
        } catch {
            os_log("Unable to create network request %s", type: .error, error.localizedDescription)
            complete(.error(error))
        }
        return Cancellables.create()
    }
}

extension URLSessionTask: Cancellable { }
