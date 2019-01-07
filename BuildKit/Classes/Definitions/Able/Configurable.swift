import UIKit

public protocol Configurable {
    associatedtype Config
    func configure(with config: Config)
}
