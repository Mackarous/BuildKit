public struct ViewModel<Input, Output> {
    public let input: Input
    public let output: Output
    public init(input: Input, output: Output) {
        self.input = input
        self.output = output
    }
}
