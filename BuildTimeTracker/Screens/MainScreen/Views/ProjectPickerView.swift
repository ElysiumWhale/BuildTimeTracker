import SwiftUI

struct ProjectPickerView: View {
    @ObservedObject
    private(set) var viewModel: ProjectsListViewModel

    var body: some View {
        HStack(spacing: 0) {
            // This branching causes warning
            // AttributeGraph: cycle detected through attribute
            if viewModel.projects.isEmpty {
                Text("No projects")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(10)
            } else {
                Picker(selection: $viewModel.selectedProject,
                       label: Text("Project").font(.title2).fontWeight(.heavy)) {
                    ForEach(viewModel.projects) {
                        Text($0.name)
                            .tag($0 as Project?)
                    }
                }
                .frame(maxWidth: 350)
                .padding(.vertical, 10)
            }

            RefreshButton()
                .help("Refresh (Cmd + R)")
                .keyboardShortcut(.init("r"), modifiers: .command)
            Button(action: {
                NSApplication.shared.terminate(nil)
            }, label: {
                Image(systemName: "xmark.circle")
            })
            .help("Quit")
        }
    }
}

struct ProjectPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPickerView(viewModel: .init())
    }
}
