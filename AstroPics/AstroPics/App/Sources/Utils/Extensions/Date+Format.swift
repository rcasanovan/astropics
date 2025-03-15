import Foundation

extension Date {
  public static func formattedCurrentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: Date())
  }

  public static func formattedDateDaysAgo(_ days: Int) -> String {
    let calendar = Calendar.current
    if let dateSevenDaysAgo = calendar.date(byAdding: .day, value: -days, to: Date()) {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      return formatter.string(from: dateSevenDaysAgo)
    }
    return formattedCurrentDate()
  }

  public static func transformDateStringToCurrentLocale(_ dateString: String, locale: Locale) -> String? {
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
