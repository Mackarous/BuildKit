import UIKit

@IBDesignable final class DesignableView: UIView { }
@IBDesignable final class DesignableImageView: UIImageView { }
@IBDesignable final class DesignableTextField: UITextField { }

@IBDesignable final class DesignableButton: UIButton {
    @IBInspectable public var color: UIColor? {
        didSet { setBackgroundImage(.from(color), for: .normal) }
    }

    @IBInspectable public var highlightedColor: UIColor? {
        didSet { setBackgroundImage(.from(highlightedColor), for: .highlighted) }
    }

    @IBInspectable public var disabledColor: UIColor? {
        didSet { setBackgroundImage(.from(disabledColor), for: .disabled) }
    }

    @IBInspectable public var focusedColor: UIColor? {
        didSet { setBackgroundImage(.from(focusedColor), for: .focused) }
    }
}

public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var isRounded: Bool {
        get { return layer.cornerRadius == bounds.width * 2 }
        set { layer.cornerRadius = newValue ? bounds.width / 2 : cornerRadius }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
}
