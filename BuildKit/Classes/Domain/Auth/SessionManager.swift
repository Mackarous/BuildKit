public protocol SessionManager {
    var currentSession: Session { get }
    func configure(with session: Session)
}
