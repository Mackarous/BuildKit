import UIKit

public extension UITableViewController {
    func fixDynamicTypeForStaticTableViews() {
        // Thanks to https://spin.atomicobject.com/2018/10/15/dynamic-type-static-uitableview/ for the fix
        
        // Remove the observer from the table view to prevent it from blanking out the cells
        NotificationCenter.default.removeObserver(
            tableView as Any,
            name: UIContentSizeCategory.didChangeNotification,
            object: nil
        )
        
        // Add our own observer and handle it ourselves
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contentSizeChanged),
            name: UIContentSizeCategory.didChangeNotification,
            object: nil
        )
    }
    
     @objc private func contentSizeChanged() {
        tableView.reloadData()
    }
}
