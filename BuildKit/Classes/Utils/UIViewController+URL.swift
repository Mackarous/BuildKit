import SafariServices
import UIKit

public extension UIViewController {
    enum OpenLocation {
        case inApp, inSafari
    }
    
    func open(url: URL, _ location: OpenLocation = .inApp) {
        switch location {
        case .inApp:
            guard let scheme = url.scheme else { return }
            if scheme.hasPrefix("http") {
                present(SFSafariViewController(url: url), animated: true)
            } else {
                UIApplication.shared.open(url, options: [:])
            }
        case .inSafari:
            UIApplication.shared.open(url, options: [:])
        }
    }
}
