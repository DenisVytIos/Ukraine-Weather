//
//  ListOfferModel.swift
//  Ukraine Weather
//
//  Created by Denis on 9/8/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

class ListOfferModel: Codable {
  var dt: Float?
  var main: MainOfferModel?
  var dt_txt: String?
  var wind: WindModel?
  var weather: [WeatherModel]?
}
//  "list": [
//  {
//  "dt": 1570093200,
//  "main": {
//  "temp": 290.64,
//  "temp_min": 290.64,
//  "temp_max": 290.954,
//  "pressure": 1005.5,
//  "sea_level": 1005.5,
//  "grnd_level": 990.36,
//  "humidity": 67,
//  "temp_kf": -0.31
//  },
//  "weather": [
//  {
//  "id": 804,
//  "main": "Clouds",
//  "description": "overcast clouds",
//  "icon": "04d"
//  }
//  ],
//  "clouds": {
//  "all": 100
//  },
//  "wind": {
//  "speed": 4.74,
//  "deg": 176.082
//  },
//  "sys": {
//  "pod": "d"
//  },
//  "dt_txt": "2019-10-03 09:00:00"
//  },
