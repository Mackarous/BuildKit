import UIKit

@IBDesignable public final class GradientView: UIView {
    override public class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    @IBInspectable var startPoint: CGPoint = .zero {
        didSet { update() }
    }

    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet { update() }
    }

    @IBInspectable var startColor: UIColor = .black {
        didSet { update() }
    }
    
    @IBInspectable var endColor: UIColor = .white {
        didSet { update() }
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        update()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        update()
    }
    
    private func update() {
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [startColor, endColor].map(\.cgColor)
    }
}
