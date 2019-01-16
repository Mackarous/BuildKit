import os

public protocol Network {
    init(sessionManager: SessionManager)
    @discardableResult func perform<T: NetworkOperation>(operation: T, complete: @escaping (Result<T.Response>) -> Void) -> Cancellable
}

public protocol NetworkOperation {
    associatedtype Request
    associatedtype Response
    associatedtype Decoder = JSONDecoder
    var requiresAuthorization: Bool { get }
    func createRequest() throws -> Request
    func configure(decoder: Decoder)
    func decode(data: Data) throws -> Response
}

public extension NetworkOperation {
    var requiresAuthorization: Bool {
        return true
    }
    
    func configure(decoder: Decoder) {
        
    }
}

public extension NetworkOperation where Response: Decodable, Decoder == JSONDecoder {
    func decode(data: Data) throws -> Response {
        let decoder = JSONDecoder()
        os_log("BuildKit.NetworkOperation: Created decoder %{public}@", type: .debug, String(describing: decoder))
        configure(decoder: decoder)
        os_log("BuildKit.NetworkOperation: Configured decoder %{public}@", type: .debug, String(describing: decoder))
        do {
            os_log("BuildKit.NetworkOperation: Attempting to decode DataResponse", type: .debug)
            let dataResponse = try decoder.decode(DataResponse<Response>.self, from: data)
            os_log("BuildKit.NetworkOperation: Successfully decoded DataResponse", type: .debug)
            return dataResponse.data
        } catch {
            os_log("BuildKit.NetworkOperation: DataResponse decoding unsuccessful...", type: .error, error.localizedDescription)
        }
        os_log("BuildKit.NetworkOperation: Attempting to decode Response", type: .debug)
        let response = try decoder.decode(Response.self, from: data)
        os_log("BuildKit.NetworkOperation: Successfully decoded Response", type: .debug)
        return response
    }
}

private struct DataResponse<T: Decodable>: Decodable {
    let data: T
}
