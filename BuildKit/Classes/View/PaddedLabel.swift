import UIKit

@IBDesignable public final class PaddedLabel: UILabel {
    @IBInspectable var horizontalPadding: CGFloat = 0 {
        didSet { invalidateIntrinsicContentSize() }
    }

    @IBInspectable var verticalPadding: CGFloat = 0 {
        didSet { invalidateIntrinsicContentSize() }
    }

    override public var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height += verticalPadding * 2
        size.width += horizontalPadding * 2
        return size
    }
        
    override public func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(
            top: verticalPadding,
            left: horizontalPadding,
            bottom: verticalPadding,
            right: horizontalPadding
        )
        super.drawText(in: rect.inset(by: insets))
    }
}
