//
//  CityModel.swift
//  Ukraine Weather
//
//  Created by Denis on 9/8/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

class CityModel: Codable {
  var id: Float?
  var name: String?
  var country: String?
  var population: Float?
  var sunrise: Float?
  var sunset: Float?
}
//  city": {
//      "id": 703448,
//      "name": "Kiev",
//      "coord": {
//              "lat": 50.4333,
//              "lon": 30.5167
//              },
//      "country": "UA",
//      "population": 2514227,
//      "timezone": 10800,
//      "sunrise": 1570075218,
//      "sunset": 1570116824
//}
