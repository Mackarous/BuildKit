import UIKit

@IBDesignable final class CustomSwitch: UIControl {
    private enum AnimationConstants {
        static let duration: TimeInterval = 0.3
        static let dampingRatio: CGFloat = 0.9
    }

    private enum SwitchState {
        case on, off
    }

    private var _isRounded = true {
        didSet { layoutIfNeeded() }
    }
    override var isRounded: Bool {
        get { return _isRounded }
        set { _isRounded = newValue }
    }
    @IBInspectable var isOn: Bool {
        get { return currentState == .on }
        set { currentState = newValue ? .on : .off }
    }

    @IBInspectable var onTitle: String? {
        didSet {
            onLabel.text = onTitle
            loadViews(for: currentState)
        }
    }
    @IBInspectable var onTitleColor: UIColor = .white {
        didSet {
            onLabel.textColor = onTitleColor
            loadViews(for: currentState)
        }
    }
    @IBInspectable var onBackgroundColor: UIColor = #colorLiteral(red: 0.2980392157, green: 0.8470588235, blue: 0.3960784314, alpha: 1) {
        didSet { loadViews(for: currentState) }
    }
    @IBInspectable var onButtonColor: UIColor = .white {
        didSet { loadViews(for: currentState) }
    }
    @IBInspectable var onButtonImage: UIImage? {
        didSet {
            onImageView.image = onButtonImage
            loadViews(for: currentState)
        }
    }

    @IBInspectable var offTitle: String? {
        didSet {
            offLabel.text = offTitle
            loadViews(for: currentState)
        }
    }
    @IBInspectable var offTitleColor: UIColor = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1) {
        didSet {
            offLabel.textColor = offTitleColor
            loadViews(for: currentState)
        }
    }
    @IBInspectable var offBackgroundColor: UIColor = #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1) {
        didSet { loadViews(for: currentState) }
    }
    @IBInspectable var offButtonColor: UIColor = .white {
        didSet { loadViews(for: currentState) }
    }
    @IBInspectable var offButtonImage: UIImage? {
        didSet {
            offImageView.image = offButtonImage
            loadViews(for: currentState)
        }
    }

    @IBInspectable var titlePadding: CGFloat = 10.0 {
        didSet {
            onLabelConstraint.constant = titlePadding
            offLabelConstraint.constant = titlePadding
            setNeedsUpdateConstraints()
        }
    }

    private var currentState: SwitchState = .on {
        didSet {
            sendActions(for: .valueChanged)
            loadViews(for: currentState)
        }
    }

    private let onLabel = UILabel()
    private let offLabel = UILabel()
    private let buttonView = UIView()
    private let onImageView = UIImageView()
    private let offImageView = UIImageView()

    private lazy var onLabelConstraint = onLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titlePadding)
    private lazy var offLabelConstraint = trailingAnchor.constraint(equalTo: offLabel.trailingAnchor, constant: titlePadding)
    private lazy var buttonLeftConstraint = buttonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2)
    private lazy var buttonRightConstraint = trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: 2)
    private lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
    private lazy var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan))

    private let animator = UIViewPropertyAnimator(
        duration: AnimationConstants.duration,
        dampingRatio: AnimationConstants.dampingRatio
    )
    private let timingParameters = UISpringTimingParameters(
        dampingRatio: AnimationConstants.dampingRatio,
        initialVelocity: .zero
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUp()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if layer.cornerRadius == 0 && isRounded {
            layer.cornerRadius = bounds.height / 2
            buttonView.layer.cornerRadius = buttonView.bounds.width / 2
        }
    }

    private func setUp() {
        setUpGestureRecognizers()
        setUpOnLabel()
        setUpOffLabel()
        setUpButtonView()
        setUpImageView(onImageView)
        setUpImageView(offImageView)
        loadViews(for: currentState)
    }

    private func setUpGestureRecognizers() {
        addGestureRecognizer(tapGestureRecognizer)
        buttonView.addGestureRecognizer(panGestureRecognizer)
    }

    private func setUpOnLabel() {
        addSubview(onLabel)
        onLabel.translatesAutoresizingMaskIntoConstraints = false
        onLabelConstraint.isActive = true
        onLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        onLabel.text = onTitle
        onLabel.textColor = onTitleColor
    }

    private func setUpOffLabel() {
        addSubview(offLabel)
        offLabel.translatesAutoresizingMaskIntoConstraints = false
        offLabelConstraint.isActive = true
        offLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        offLabel.text = offTitle
        offLabel.textColor = offTitleColor
    }

    private func setUpButtonView() {
        addSubview(buttonView)
        buttonView.layer.shadowOffset = CGSize(width: 0, height: 3)
        buttonView.layer.shadowRadius = 8
        buttonView.layer.shadowOpacity = 0.15
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: 2).isActive = true
        buttonView.widthAnchor.constraint(equalTo: buttonView.heightAnchor).isActive = true
    }

    private func setUpImageView(_ imageView: UIImageView) {
        buttonView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 11).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 11).isActive = true
        imageView.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 7).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 7).isActive = true
    }

    private func loadViews(for state: SwitchState) {
        switch state {
        case .off:
            backgroundColor = offBackgroundColor
            offLabel.alpha = 1
            onLabel.alpha = 0
            buttonRightConstraint.isActive = false
            buttonLeftConstraint.isActive = true
            buttonView.backgroundColor = offButtonColor
            onImageView.alpha = 0
            offImageView.alpha = 1
        case .on:
            backgroundColor = onBackgroundColor
            offLabel.alpha = 0
            onLabel.alpha = 1
            buttonLeftConstraint.isActive = false
            buttonRightConstraint.isActive = true
            buttonView.backgroundColor = onButtonColor
            onImageView.alpha = 1
            offImageView.alpha = 0
        }
    }

    private func resetAnimation() {
        animator.addAnimations {
            switch self.currentState {
            case .on:
                self.loadViews(for: .off)
            case .off:
                self.loadViews(for: .on)
            }
            self.layoutIfNeeded()
        }
        animator.addCompletion { position in
            guard position == .end else { return }
            self.isOn = !self.isOn
        }
    }

    @objc private func didTap() {
        if !animator.isRunning {
            resetAnimation()
        }
        animator.startAnimation()
        animator.pauseAnimation()
        animator.continueAnimation(
            withTimingParameters: timingParameters,
            durationFactor: 1
        )
    }

    @objc private func didPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        var fractionCompleted = gestureRecognizer.translation(in: self).x / bounds.width
        var velocity = gestureRecognizer.velocity(in: self).x
        switch gestureRecognizer.state {
        case .began:
            resetAnimation()
            animator.startAnimation()
            animator.pauseAnimation()
        case .changed:
            if isOn { fractionCompleted *= -1 }
            animator.fractionComplete = fractionCompleted
        case .ended:
            let minimumFraction: CGFloat = 0.35
            var durationFactor: CGFloat = 1
            if isOn {
                fractionCompleted *= -1
                velocity *= -1
            }
            if fractionCompleted < minimumFraction && velocity < 30 {
                durationFactor -= minimumFraction
                animator.isReversed = true
                animator.addCompletion { _ in
                    self.loadViews(for: self.currentState)
                }
            }
            animator.continueAnimation(
                withTimingParameters: timingParameters,
                durationFactor: durationFactor
            )
        default:
            break
        }
    }
}
