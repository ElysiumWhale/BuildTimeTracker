import SwiftUI

struct RefreshButton: View {
    @Environment(\.refresh)
    private var action

    @StateObject
    private var performer = ActionPerformer()

    var body: some View {
        Button {
            Task {
                await performer.perform(action)
            }
        }
        label: {
            Image(systemName: "arrow.clockwise")
        }
        .padding(5)
        .disabled(performer.isPerforming)
    }
}

struct RefreshButton_Previews: PreviewProvider {
    static var previews: some View {
        RefreshButton()
    }
}
