import Foundation

public protocol Applyable {}

public extension Applyable where Self: AnyObject {
    @discardableResult
    func apply(_ fun: (Self) throws -> Void) rethrows -> Self {
        try fun(self)
        return self
    }
}

extension NSObject: Applyable {}
