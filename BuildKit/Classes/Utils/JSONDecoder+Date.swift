import Foundation

extension JSONDecoder.DateDecodingStrategy {
    /// ISO8601 Date Decoding Strategy with fractional settings option.
    /// - Note: The Date format used is "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    public static var iso8601WithFractionalSeconds: JSONDecoder.DateDecodingStrategy {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return .formatted(formatter)
    }
}
