public protocol InitConfigurable {
    init()
}

public extension InitConfigurable {
    init(configure: (Self) -> Void) {
        self.init()
        configure(self)
    }
}

extension NSObject: InitConfigurable { }
