public protocol Network {
    func perform<T: APIOperation>(operation: T, complete: @escaping (Result<T.Response>) -> Void) -> Cancellable
}
