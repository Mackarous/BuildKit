import UIKit

public protocol Reusable { }
public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }

extension UICollectionReusableView: Reusable { }

public extension UITableView {
    func dequeueReusableCell<C: UITableViewCell>(for indexPath: IndexPath) -> C {
        return dequeueReusableCell(withIdentifier: C.reuseIdentifier, for: indexPath) as! C
    }
    
    func dequeueReusableHeaderFooterView<H: UITableViewHeaderFooterView>() -> H? {
        return dequeueReusableHeaderFooterView(withIdentifier: H.reuseIdentifier) as? H
    }
}

public extension UICollectionView {
    func dequeueReusableCell<C: UICollectionViewCell>(for indexPath: IndexPath) -> C {
        return dequeueReusableCell(withReuseIdentifier: C.reuseIdentifier, for: indexPath) as! C
    }
    
    func dequeueReusableSupplementaryView<V: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> V {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: V.reuseIdentifier, for: indexPath) as! V
    }
}
