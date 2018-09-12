import UIKit

extension UIViewController {
    var isPresentedModally: Bool {
        return presentingViewController?.presentedViewController == self
            || (navigationController != nil && navigationController?.presentingViewController?.presentedViewController == navigationController)
            || tabBarController?.presentingViewController is UITabBarController
    }
}
