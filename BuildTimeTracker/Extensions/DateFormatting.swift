import Foundation

extension DateFormatter {
    enum Formatters {
        case `default`
        case ddMMyyyy

        var value: DateFormatter {
            switch self {
                case .default:
                    return .defaultFormatter
                case .ddMMyyyy:
                    return .ddMMyyyy
            }
        }
    }

    static var defaultFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formatter
    }

    static var ddMMyyyy: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
}

extension Date {
    func formatted(with formatter: DateFormatter.Formatters = .default) -> String {
        formatter.value.string(from: self)
    }
}

extension String {
    func date(with formatter: DateFormatter.Formatters = .default) -> Date {
        formatter.value.date(from: self) ?? Date()
    }
}

extension Double {
    func asHMS(style: DateComponentsFormatter.UnitsStyle = .short) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
    }
}
