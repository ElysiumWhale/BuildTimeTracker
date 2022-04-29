import Foundation

struct Project: Identifiable, Hashable {
    let id = UUID()
    let name: String

    init(name: String) {
        self.name = name
    }
}
