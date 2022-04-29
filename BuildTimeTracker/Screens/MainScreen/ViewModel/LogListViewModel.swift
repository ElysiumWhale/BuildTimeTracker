import SwiftUI

final class LogListViewModel: ObservableObject {
    @Published
    private(set) var overallTime = "Overall time: 0 sec"

    @Published
    private(set) var groupedLogs = [Date: [BuildLog]]()

    @Published
    var logs: [BuildLog] = [] {
        didSet {
            groupedLogs = Dictionary(grouping: logs,
                                     by: \.erasedStartDate)
            let time = logs.reduce(into: 0, { $0 += $1.duration })
            overallTime = .colonSeparated("Overall time", time.asHMS())
        }
    }

    func overallTime(for date: Date) -> String {
        guard let logs = groupedLogs[date] else {
            return .colonSeparated(date.formatted(with: .ddMMyyyy), "0 sec")
        }

        let time = logs.reduce(into: 0, { $0 += $1.duration })

        return .colonSeparated(date.formatted(with: .ddMMyyyy), time.asHMS())
    }
}
