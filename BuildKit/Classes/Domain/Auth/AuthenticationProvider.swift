import UIKit

public protocol AuthenticationProvider {
    var hasAuthInKeychain: Bool { get }
    func authenticationControl<T: UIControl>() -> T
    func setContainerViewController(_ viewController: UIViewController)
    func authenticate(completion: @escaping (Result<AuthenticationTokens>) -> Void)
    func deauthenticate()
}

public struct AuthenticationTokens: Equatable {
    public let accessToken: String
    public let idToken: String
    
    public init(accessToken: String, idToken: String) {
        self.accessToken = accessToken
        self.idToken = idToken
    }
}
