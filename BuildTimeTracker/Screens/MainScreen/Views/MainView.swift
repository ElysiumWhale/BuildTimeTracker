import SwiftUI

struct MainView: View {
    @ObservedObject
    var viewModel: BuildLogsViewModel

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
        MainView(viewModel: .init())
    }
}
