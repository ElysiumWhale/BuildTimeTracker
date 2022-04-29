import SwiftUI
import Combine

@MainActor
final class BuildLogsViewModel: ObservableObject {
    private let parser: IParserService

    private var subscribers = Set<AnyCancellable>()

    @Published
    private(set) var logsListViewModel: LogListViewModel

    @Published
    private(set) var projectsListViewModel: ProjectsListViewModel

    @Published
    private(set) var isLoading = false

    init(parser: IParserService = Parser(),
         projectsListViewModel: ProjectsListViewModel = .init(),
         logsListViewModel: LogListViewModel = .init()) {
        self.parser = parser
        self.projectsListViewModel = projectsListViewModel
        self.logsListViewModel = logsListViewModel

        // todo: replace subscription with .onChange() in MainView (actually doesn't work)
        projectsListViewModel.$selectedProject
            .removeDuplicates()
            .sink { _ in
                Task {
                    await self.reload()
                }
            }
            .store(in: &subscribers)
    }

    func loadProjects() async {
        isLoading = true
        projectsListViewModel.projects = await parser.loadProjectsNames().map { .init(name: $0) }

        if projectsListViewModel.selectedProject == nil,
           let project = projectsListViewModel.projects.first {

            projectsListViewModel.selectedProject = project
        } else {
            isLoading = false
        }
    }

    func reload() async {
        guard !projectsListViewModel.projects.isEmpty else {
            await loadProjects()
            return
        }

        guard let project = projectsListViewModel.selectedProject else {
            return
        }

        await loadLogs(for: project)
    }

    private func loadLogs(for project: Project) async {
        isLoading = true
        logsListViewModel.logs = await parser.loadManifests(for: project.name)
        isLoading = false
    }
}
