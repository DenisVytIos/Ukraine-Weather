//
//  Extension+String.swift
//  Ukraine Weather
//
//  Created by Denis on 10/7/19.
//  Copyright © 2019 Denis. All rights reserved.
//


import Foundation

extension String {
  func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
    dateFormatter.locale = Locale(identifier: "fa-IR")
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    dateFormatter.dateFormat = format
    let date = dateFormatter.date(from: self)
    return date
  }
}


