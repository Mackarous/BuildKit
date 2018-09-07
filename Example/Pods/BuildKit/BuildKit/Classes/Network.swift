public protocol Network {
    func fetchData(path: String, completion: @escaping (Result<Data>) -> Void)
}
