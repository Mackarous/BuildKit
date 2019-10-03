import SafariServices
import UIKit

public extension URL {
    enum OpenLocation {
        case inApp, inSafari
        
        public static var `default`: OpenLocation = .inApp
    }
}

public extension UIViewController {
    func open(url: URL, _ location: URL.OpenLocation = .default) {
        let app = UIApplication.shared
        switch location {
        case .inApp:
            guard let scheme = url.scheme else { return }
            if scheme.hasPrefix("http") {
                let safariViewController = SFSafariViewController(url: url)
                safariViewController.preferredControlTintColor = app.keyWindow?.tintColor
                present(safariViewController, animated: true)
            } else {
                app.open(url, options: [:])
            }
        case .inSafari:
            app.open(url, options: [:])
        }
    }
}
