import SwiftUI

struct LogListView: View {
    @ObservedObject
    var viewModel: LogListViewModel

    var body: some View {
        // This branching causes warning
        // AttributeGraph: cycle detected through attribute
        if viewModel.logs.isEmpty {
            AdaptiveView {
                Text("No logs").fontWeight(.heavy)
            }
        } else {
            List {
                Section(viewModel.overallTime) {
                    ForEach(viewModel.groupedLogs.keys.sorted(by: >), id: \.self) { dateKey in
                        Section(viewModel.overallTime(for: dateKey)) {
                            ForEach(viewModel.groupedLogs[dateKey] ?? [], id: \.id) { log in
                                LogListCellView(log: log)
                            }
                        }
                    }
                }
                .font(.largeTitle)
            }
        }
    }
}

struct LogListView_Previews: PreviewProvider {
    static var previews: some View {
        LogListView(viewModel: .init())
    }
}
