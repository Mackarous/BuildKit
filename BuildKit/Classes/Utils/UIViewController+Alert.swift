import UIKit

public extension UIViewController {
    func presentAlert(for error: Error) {
        presentAlert(forMessage: error.localizedDescription)
    }
    
    func presentAlert(forMessage message: String) {
        let alertController = UIAlertController(
            title: "Uh oh! 🥺",
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
