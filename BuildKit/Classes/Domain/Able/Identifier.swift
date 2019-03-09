public protocol Identifiable {
    var id: Identifier<Self> { get }
}

public struct Identifier<T>: Cloak, Hashable, Codable {
    public typealias RawValue = String
    public var rawValue: RawValue
    public init(rawValue: RawValue = UUID().uuidString) {
        self.rawValue = rawValue
    }
}

extension Identifier: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        rawValue = value
    }
}

extension Identifier: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "\(String(describing: Identifier.self)): \(rawValue)"
    }
}
