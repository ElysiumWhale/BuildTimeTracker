import SwiftUI

final class ProjectsListViewModel: ObservableObject {
    @Published
    var projects: [Project] = [] {
        didSet {
            selectedProject = projects.first
        }
    }

    @Published
    var selectedProject: Project?
}
