import Foundation
import XCLogParser

// Properties copy-pasted from lib because of internal access
extension LogFinder {
    var defaultDerivedData: URL? {
        guard let homeDirURL = URL.homeDir else {
            return nil
        }

        return homeDirURL.appendingPathComponent("Library/Developer/Xcode/DerivedData", isDirectory: true)
    }

    var customDerivedData: URL? {
        guard let xcodeOptions = UserDefaults.standard.persistentDomain(forName: "com.apple.dt.Xcode"),
              let customLocation = xcodeOptions["IDECustomDerivedDataLocation"] as? String else {
                  return defaultDerivedData
              }

        return URL(fileURLWithPath: customLocation)
    }
}

extension URL {
    static var homeDir: URL? {
        if #available(OSX 10.12, *) {
            return FileManager.default.homeDirectoryForCurrentUser
        } else {
            return FileManager.default.urls(for: .userDirectory, in: .userDomainMask).first
        }
    }
}
