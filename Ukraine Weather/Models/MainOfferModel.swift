//
//  MainOfferModel.swift
//  Ukraine Weather
//
//  Created by Denis on 9/8/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

class MainOfferModel: Codable {
  var temp: Float?
  var tempMin: Float?
  var tempMax: Float?
  var pressure: Float?
  var humidity: Float?
}

//  "main": {
//          "temp": 290.64,
//          "temp_min": 290.64,
//          "temp_max": 290.954,
//          "pressure": 1005.5,
//          "sea_level": 1005.5,
//  "grnd_level": 990.36,
//  "humidity": 67,
//  "temp_kf": -0.31
//  },

