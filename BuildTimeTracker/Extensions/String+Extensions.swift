import Foundation

extension String {
    static let empty = ""
    static let mock = "Mock"
}

extension String {
    static func colonSeparated(_ lhs: Any, _ rhs: Any) -> String {
        "\(lhs): \(rhs)"
    }
}
