//
//  Extension+Date.swift
//  Ukraine Weather
//
//  Created by Denis on 10/7/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

extension Date {
    //- Между функциями разрыв строки добавляет читабельность кода.
    //- Это касается всех файлов в проекте
    //- Поставь в настройках Xcode дефолтный отступ не 2, а 4 пробела.
    
    func toString(withFormat format: String = "EEEE ، d MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.calendar = Calendar(identifier: .persian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
    //- Почему переменная называется today а не date?
    //- Почему метод обьекта, а не класса если в нем не использается self?
    
    static func getDayOfWeek(_ date: String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: date) else { return nil }
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
    
    var monthString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    var dayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    
    var dayAndDayOfWeekString: String {
        let day = self.dayString
        let dayOfWeek = self.dayOfWeek() ?? " "
         return day + " " + dayOfWeek
        
    }
    
    func timeIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func timeHourIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HHa"
        return formatter.string(from: self)
    }
    
    var hourAndDayAndDayOfWeekString: String {
        let day = self.dayString
        let dayOfWeek = self.dayOfWeek() ?? " "
        let hour = self.timeHourIn24HourFormat()
        return hour + " " + day + " " + dayOfWeek
        
    }
}
