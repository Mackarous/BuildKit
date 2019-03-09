import SafariServices
import UIKit

public extension URL {
    public enum OpenLocation {
        case inApp, inSafari
        
        public static var `default`: OpenLocation = .inApp
    }
}

public extension UIViewController {
    func open(url: URL, _ location: URL.OpenLocation = .default) {
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
