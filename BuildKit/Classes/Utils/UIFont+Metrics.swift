import UIKit

extension UIFont {
    public static func preferredFont(forTextStyle textStyle: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: textStyle)
        let size = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle).pointSize
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        return metrics.scaledFont(for: font)
    }
}
