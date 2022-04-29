import Foundation
import struct XCLogParser.LogManifestEntry

struct BuildLog: Codable {
    let scheme: String
    let timestampStart: TimeInterval
    let timestampEnd: TimeInterval
    let duration: TimeInterval
    let fileName: String
    let title: String
    let uniqueIdentifier: String
    let type: String
}

extension BuildLog: Identifiable {
    var id: String {
        uniqueIdentifier
    }
}

extension BuildLog {
    var erasedStartDate: Date {
        startDate.formatted(with: .ddMMyyyy).date(with: .ddMMyyyy)
    }

    var startDate: Date {
        Date(timeIntervalSince1970: timestampStart)
    }

    var endDate: Date {
        Date(timeIntervalSince1970: timestampEnd)
    }
}

extension LogManifestEntry {
    var asDomain: BuildLog {
        BuildLog(scheme: scheme,
                 timestampStart: TimeInterval(timestampStart),
                 timestampEnd: TimeInterval(timestampEnd),
                 duration: TimeInterval(duration),
                 fileName: fileName,
                 title: title,
                 uniqueIdentifier: uniqueIdentifier,
                 type: type.rawValue)
    }
}
