import SwiftUI

@main
struct BuildTimeTrackerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate

    var body: some Scene {
        WindowGroup {
            EmptyView().frame(width: .zero)
        }
    }
}
