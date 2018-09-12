public protocol APIOperation {
    associatedtype Response
    func createRequest() throws -> URLRequest
    func decode(data: Data) throws -> Response
}

public extension APIOperation where Response: Decodable {
    func decode(data: Data) throws -> Response {
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
