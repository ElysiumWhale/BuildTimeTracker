import SwiftUI

struct MainView: View {
    @StateObject
    private var viewModel: BuildLogsViewModel = .init()

    var body: some View {
        VStack {
            ProjectPickerView(viewModel: viewModel.projectsListViewModel)
                .disabled(viewModel.isLoading)

            if viewModel.isLoading {
                AdaptiveView {
                    ProgressView()
                }
            } else {
                LogListView(viewModel: viewModel.logsListViewModel)
            }
        }
        .animation(.easeInOut, value: viewModel.isLoading)
        .task {
            await viewModel.loadProjects()
        }
        .refreshable {
            await viewModel.reload()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
