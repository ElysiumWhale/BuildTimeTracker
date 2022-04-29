import Foundation
import XCLogParser

protocol IParserService {
    func loadProjectsNames() async -> [String]
    func loadManifests(for projectName: String) async -> [BuildLog]
}

struct Parser: IParserService {
    private let fileManager = FileManager.default

    func loadManifests(for projectName: String) async -> [BuildLog] {
        let logOptions = LogOptions(projectName: projectName,
                                    xcworkspacePath: .empty,
                                    xcodeprojPath: .empty,
                                    derivedDataPath: .empty,
                                    logManifestPath: .empty)
        let manifests = try? LogManifest().getWithLogOptions(logOptions)
        let logs = manifests?.map(\.asDomain) ?? []

        #if DEBUG
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        #endif

        return logs
    }

    func loadProjectsNames() async -> [String] {
        let finder = LogFinder()

        // todo: add error throwing with description
        guard let derivedData = finder.customDerivedData ?? finder.defaultDerivedData,
              let folders = try? fileManager.contentsOfDirectory(atPath: derivedData.path) else {
            return []
        }

        var projectNames: [String] = []

        // todo: look for best ways of projects directories searching
        // todo: parallelize folders checking (probably async let)
        // todo: read Info.plist file to retrieve additional information
        for folder in folders {
            if fileManager.fileExists(atPath: derivedData.appendingPathComponent(folder + "/Info.plist").path),
               let projectName = folder.split(separator: "-").first {

                projectNames.append(String(projectName))
            }
        }

        #if DEBUG
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        #endif

        return projectNames
    }
}
