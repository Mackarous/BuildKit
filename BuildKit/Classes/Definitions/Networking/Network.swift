public protocol Network {
    func perform<T: NetworkOperation>(operation: T, complete: @escaping (Result<T.Response>) -> Void) -> Cancellable
}

public protocol NetworkOperation {
    associatedtype Response
    func createRequest() throws -> URLRequest
    func decode(data: Data) throws -> Response
}

public extension NetworkOperation where Response: Decodable {
    func decode(data: Data) throws -> Response {
        return try JSONDecoder().decode(Response.self, from: data)
    }
}