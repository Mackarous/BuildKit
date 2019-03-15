public protocol Identifiable {
    associatedtype RawValue: Codable = String
    var id: Identifier<Self> { get }
}

public struct Identifier<Identified: Identifiable> {
    public let rawValue: Identified.RawValue
    public init(rawValue: Identified.RawValue) {
        self.rawValue = rawValue
    }
}

extension Identifier: ExpressibleByUnicodeScalarLiteral where Identified.RawValue == String {
    public typealias UnicodeScalarLiteralType = String
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        rawValue = value
    }
}

extension Identifier: ExpressibleByExtendedGraphemeClusterLiteral where Identified.RawValue == String {
    public typealias ExtendedGraphemeClusterLiteralType = String
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        rawValue = value
    }
}

extension Identifier: ExpressibleByStringLiteral where Identified.RawValue == String {
    public typealias StringLiteralType = String
    public init(stringLiteral value: StringLiteralType) {
        rawValue = value
    }
}

extension Identifier: CustomStringConvertible where Identified.RawValue == String {
    public var description: String {
        return "\(String(describing: Identifier.self)): \(rawValue)"
    }
}

extension Identifier: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try container.decode(Identified.RawValue.self)
    }
}

extension Identifier: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
