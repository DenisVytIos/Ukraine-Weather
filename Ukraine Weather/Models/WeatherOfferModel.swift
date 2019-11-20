//
//  WeatherOfferModel.swift
//  Ukraine Weather
//
//  Created by Denis on 11/16/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

class WeatherOfferModel: Codable {
    
    var tempString: String?
    var tempMinString: String?
    var tempMaxString: String?
    var pressureString: String?
    var humidityString: String?
    static var cityString: String?
    
    init(tempString: String, tempMinString: String, tempMaxString: String, pressureString: String,  humidityString: String, cityString: String) {
        self.tempString = tempString
        self.tempMinString = tempMinString
        self.tempMaxString = tempMaxString
        self.pressureString = pressureString
        self.humidityString = humidityString
        WeatherOfferModel.cityString = cityString
    }
    
    init(entity: WeatherOfferEntity) {
        self.tempString = entity.tempString
        self.tempMaxString = entity.tempString
        self.tempMinString = entity.tempString
        self.pressureString = entity.pressureString
        self.humidityString = entity.humidityString
    }
}
