public protocol AuthenticationProvider {
    var currentState: AuthenticationState { get }
    var didUpdateState: ((AuthenticationState) -> Void)? { get set }
    func authenticate(completion: @escaping (Result<AuthenticationTokens>) -> Void)
}

public struct AuthenticationTokens {
    public let accessToken: String
    public let idToken: String
    
    public init(accessToken: String, idToken: String) {
        self.accessToken = accessToken
        self.idToken = idToken
    }
}

public enum AuthenticationState {
    case authorized(AuthenticationTokens)
    case unauthorized
}
