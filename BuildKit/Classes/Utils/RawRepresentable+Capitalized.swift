import Foundation

extension RawRepresentable where RawValue == String {
    public var capitalized: String { return rawValue.capitalized }
}
