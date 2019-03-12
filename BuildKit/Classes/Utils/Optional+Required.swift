public extension Optional {
    func required(hint hintExpression: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) -> Wrapped {
        if let unwrapped = self { return unwrapped }
        
        var message = "Required value was nil"
        if let hint = hintExpression() {
            message.append(". Debugging hint: \(hint)")
        }
        preconditionFailure(message, file: file, line: line)
    }
}
