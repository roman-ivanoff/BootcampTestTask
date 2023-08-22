import Foundation

protocol BTTIdentifiable {
    static var identifier: String { get }
    var identifier: String { get }
}

extension BTTIdentifiable {
    static var identifier: String { String(describing: self) }
    var identifier: String { Self.identifier }
}
