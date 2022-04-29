import SwiftUI

class ActionPerformer: ObservableObject {
    @Published
    private(set) var isPerforming = false

    func perform(_ action: RefreshAction?) async {
        guard let action = action, !isPerforming else {
            return
        }

        isPerforming = true
        await action()
        isPerforming = false
    }
}
