extension Sequence {
    /// Returns an array containing the values of each element at the given KeyPath.
    ///
    /// In this example, `map` is used first to convert the names in the array
    /// to lowercase strings and then to count their characters.
    ///
    ///     let steve = Person(first: "Steve", last: "Jobs")
    ///     let craig = Person(first: "Craig", last: "Federighi")
    ///     let jony = Person(first: "Jony", last: "Ive")
    ///     let people = [steve, craig, jony]
    ///     let firstNames = people.map(\.first)
    ///     // 'firstNames' == ["Steve", "Craig", "Jony"]
    ///
    /// - Parameter keyPath: A mapping keypath. `keyPath` accepts a keypath of the
    ///   element of this sequence as its parameter and returns a the value at that keypath.
    /// - Returns: An array containing the transformed elements of this
    ///   sequence.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    public func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return map { $0[keyPath: keyPath] }
    }
}
