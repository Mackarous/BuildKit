public enum Result<S> {
    case success(S)
    case error(Error)
}
