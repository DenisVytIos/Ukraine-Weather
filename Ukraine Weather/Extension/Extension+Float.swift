//
//  Extension+Float.swift
//  Ukraine Weather
//
//  Created by Denis on 10/3/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

extension Float {
    func getDateStringFromUnixTime(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
}

