struct Required<Value> {
    var value: Value {
        get { return optionalValue.required(hint: "Required<\(Value.self)>", file: file, line: line) }
        set { optionalValue = newValue }
    }
    
    private var optionalValue: Value?
    private let file: StaticString
    private let line: UInt
    
    init(optionalValue: Value? = nil, file: StaticString = #file, line: UInt = #line) {
        self.optionalValue = optionalValue
        self.file = file
        self.line = line
    }
}

extension Required: CustomStringConvertible where Value: CustomStringConvertible {
    var description: String {
        return String(describing: optionalValue)
    }
}

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
