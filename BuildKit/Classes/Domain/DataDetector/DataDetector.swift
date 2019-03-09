public protocol DataDetector {
    typealias Info = (formattedString: NSAttributedString, urls: [String: URL])
    typealias Completion = (Result<Info>) -> Void
    func convert(string: String, into attributedString: NSAttributedString, completion: @escaping Completion)
}
