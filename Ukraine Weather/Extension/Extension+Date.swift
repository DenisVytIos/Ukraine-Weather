//
//  Extension+Date.swift
//  Ukraine Weather
//
//  Created by Denis on 10/7/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

extension Date {
  func toString(withFormat format: String = "EEEE ، d MMMM yyyy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "fa-IR")
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
    dateFormatter.calendar = Calendar(identifier: .persian)
    dateFormatter.dateFormat = format
    let str = dateFormatter.string(from: self)
    return str
  }
  func getDayOfWeek(_ today:String) -> Int? {
    let formatter  = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    guard let todayDate = formatter.date(from: today) else { return nil }
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = myCalendar.component(.weekday, from: todayDate)
    return weekDay
  }
  func dayOfWeek() -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: self).capitalized
    // or use capitalized(with: locale) if you want
  }
  var month: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    return dateFormatter.string(from: self)
  }
  var day: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d"
    return dateFormatter.string(from: self)
  }
}
