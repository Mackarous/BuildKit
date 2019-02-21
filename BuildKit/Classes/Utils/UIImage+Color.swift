import UIKit

public extension UIImage {
    static func from(_ color: UIColor?, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        guard let color = color else { return nil }
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        color.setFill()
        UIRectFill(rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
