import Foundation
import Testing

@testable import Utils

struct DateTests {
  @Test
  func testFormattedCurrentDate() async {
    // Given
    let formattedDate = Date.formattedCurrentDate()

    // When
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: formattedDate)

    // Then
    assert(formattedDate.isEmpty == false, "Formatted date should not be empty")
    assert(date != nil, "Formatted date should be a valid date")
  }

  @Test
  func testTransformDateStringToCurrentLocaleInvalidDate() async {
    // Given
    let dateString = "invalid-date"
    let locale = Locale(identifier: "en_US")

    // When
    let transformedDate = Date.transformDateStringToCurrentLocale(dateString, locale: locale)

    // Then
    assert(transformedDate == nil, "Transformed date should be nil for invalid date")
  }
}
