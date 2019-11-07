//
//  OfferModel.swift
//  Ukraine Weather
//
//  Created by Denis on 9/9/19.
//  Copyright © 2019 Denis. All rights reserved.
//

import Foundation

class OfferModel: Codable {
    var cod: String?
    var message: Float?
    var cnt: Float?
    var list: [ListOfferModel]?
    var city: CityModel?
}
//  {
//  "cod": "200",
//  "message": 0.0105,
//  "cnt": 40,
//  "list": [//////],
//  "city": {
//  "id": 703448,
//  "name": "Kiev",
//  "coord": {
//  "lat": 50.4333,
//  "lon": 30.5167
//  },
//  "country": "UA",
//  "population": 2514227,
//  "timezone": 10800,
//  "sunrise": 1570075218,
//  "sunset": 1570116824
//  }
//}
