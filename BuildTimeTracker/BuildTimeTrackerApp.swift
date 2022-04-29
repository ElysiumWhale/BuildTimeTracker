import SwiftUI

@main
struct BuildTimeTrackerApp: App {
    @StateObject
    private var viewModel: BuildLogsViewModel = .init()

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
                .frame(minWidth: 300, idealWidth: 300, minHeight: 300, idealHeight: 400)
                .navigationTitle("Build time tracker")
        }
    }
}
