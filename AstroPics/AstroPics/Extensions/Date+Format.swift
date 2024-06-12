import Foundation

extension Date {
  static func formattedCurrentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: Date())
  }

  static func formattedDateSevenDaysAgo() -> String {
    let calendar = Calendar.current
    if let dateSevenDaysAgo = calendar.date(byAdding: .day, value: -6, to: Date()) {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      return formatter.string(from: dateSevenDaysAgo)
    }
    return formattedCurrentDate()
  }

  static func transformDateStringToCurrentLocale(_ dateString: String, locale: Locale) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"

    if let date = inputFormatter.date(from: dateString) {
      let outputFormatter = DateFormatter()
      outputFormatter.locale = locale
      outputFormatter.dateStyle = .short
      outputFormatter.timeStyle = .none
      return outputFormatter.string(from: date)
    }

    return nil
  }
}
